CREATE_DAILY_RAW_TABLE()
{
START_DATE=$(date +"%Y-%m-%d" -d "7 day ago")
END_DATE=$(date +"%Y-%m-%d" -d "1 day ago")

startDate=${startDate:-$START_DATE}
endDate=${endDate:-$END_DATE}
ignorePattern=${ignorePattern:-NO}
historicalData=${historicalData:-NO}
sqlFileKey=${sqlFileKey:-}

while [ $# -gt 0 ]; do

   if [[ $1 == *"--"* ]]; then
        param="${1/--/}"
        declare $param="$2"
        # echo $1 $2 // Optional to see the parameter:value result
   fi

  shift
done

echo $startDate $endDate $ignorePattern $sqlFileKey $historicalData
sqlFile="$SCHEMAS_DIR/$sqlFileKey"
echo $sqlFile
[ -s $sqlFile ]

if [[ $? = 1 ]]
then
    echo "Schema file $sqlFile not exist"
    exit 0
fi

CLIENT=`echo "$sqlFileKey"| cut -d"-" -f1 |tr '[a-z]' '[A-Z]'`
REGION=`echo "$sqlFileKey"| cut -d"-" -f2 |tr '[a-z]' '[A-Z]'`

ignorePattern=`echo "$ignorePattern" | tr '[a-z]' '[A-Z]'`
historicalData=`echo "$historicalData" | tr '[a-z]' '[A-Z]'`

prefix="${CLIENT}-${REGION}-"



if [[ "$CLIENT" = "TDACRM" ]]
   then
    CLIENT="TDA_CRM"
fi


#SF_QUERY_TAG=`echo "${sqlFileKey}" | sed "s/^$prefix//" | sed "s/.sql//"`

SF_QUERY_TAG=`echo "${sqlFileKey}" | sed "s/.sql//" | tr '-' '_'`
RAW_TABLE="${SF_QUERY_TAG}_DAILY_RAW"
echo "Raw table = $RAW_TABLE"

SF_QUERY_TAG="${SF_QUERY_TAG}_DAILY_RAW_TABLE_CREATION"
S3_FILE_PATH=`echo "${sqlFileKey}" | sed "s/^$prefix//" | sed "s/.sql//" | tr '-' '/'`
if [[ "$s3_filepath_from_sh" != "" ]]
    then
    S3_FILE_PATH="$s3_filepath_from_sh"
fi

S3_STAGE_FILE_FORMAT=${env_type}"_${CLIENT}_csv"
if [[ "$s3_fileformat_from_sh" != "" ]]; then
   S3_STAGE_FILE_FORMAT="$s3_fileformat_from_sh"
fi

echo $SF_QUERY_TAG  $S3_FILE_PATH

snowsql -c $connection_di -f $sqlFile -o exit_on_error=true -D SF_QUERY_TAG=$SF_QUERY_TAG
if [[ $? -ne 0 ]]
then
    ERROR_MESSAGE="ERROR IN DAILY RAW TABLE CREATION $(date +%H:%M:%S)"
    echo "$ERROR_MESSAGE" >> $LOGDIR/$LOGFILE
    exit 1
fi

if [[ "$ignorePattern" = "YES" ]]
    then

        if [[ "$historicalData" = "YES" ]]
        then
         #   query="COPY INTO ${RAW_TABLE} FROM @"${env_type}"_${CLIENT}_S3/$REGION/$S3_FILE_PATH/ FILE_FORMAT = (FORMAT_NAME = ${env_type}"_${CLIENT}_csv") FORCE = TRUE;"
         query="COPY INTO ${RAW_TABLE} FROM @"HISTORICAL_${env_type}"_${CLIENT}_S3/$REGION/$S3_FILE_PATH/ FILE_FORMAT = (FORMAT_NAME = HISTORICAL_${env_type}"_${CLIENT}_csv" ESCAPE_UNENCLOSED_FIELD = None) FORCE = TRUE ;"
            echo $query
            snowsql -c $connection_di -q "$query" -o exit_on_error=true -D SF_QUERY_TAG=$SF_QUERY_TAG

            if [[ $? -ne 0 ]]
            then
                ERROR_MESSAGE="ERROR IN INSERTING DATA IN DAILY RAW TABLE $(date +%H:%M:%S)"
                echo "$ERROR_MESSAGE" >> $LOGDIR/$LOGFILE
                exit 1
            fi
        else
            query="COPY INTO ${RAW_TABLE} FROM @"${env_type}"_${CLIENT}_S3/$REGION/$S3_FILE_PATH/ FILE_FORMAT = (FORMAT_NAME = ${S3_STAGE_FILE_FORMAT}) FORCE = TRUE;"

            echo $query
            snowsql -c $connection_di -q "$query" -o exit_on_error=true -D SF_QUERY_TAG=$SF_QUERY_TAG

            if [[ $? -ne 0 ]]
            then
                ERROR_MESSAGE="ERROR IN INSERTING DATA IN DAILY RAW TABLE $(date +%H:%M:%S)"
                echo "$ERROR_MESSAGE" >> $LOGDIR/$LOGFILE
                exit 1
            fi
        fi
    else
        if [ $# -gt 1 ]; then
           GET_SCRIPT_VARIABLES
        else
           GET_SCRIPT_VARIABLES "$startDate" "$endDate"
        fi

        query="COPY INTO ${RAW_TABLE} FROM @"${env_type}"_${CLIENT}_S3/$REGION/$S3_FILE_PATH/ FILE_FORMAT = (FORMAT_NAME = ${S3_STAGE_FILE_FORMAT}) FORCE = TRUE PATTERN = $copy_cmd_pattern;"
        echo $query
        snowsql -c $connection_di -q "$query" -o exit_on_error=true -D SF_QUERY_TAG=$SF_QUERY_TAG

        if [[ $? -ne 0 ]]
        then
            ERROR_MESSAGE="ERROR IN INSERTING DATA IN DAILY RAW TABLE $(date +%H:%M:%S)"
            echo "$ERROR_MESSAGE" >> $LOGDIR/$LOGFILE
            exit 1
        fi

fi

}
