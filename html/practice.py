# #1,2
# def SumItemsMulItems(lis):
#     num_sum=0
#     num_mul=1
#     for i in lis:
#         num_sum=num_sum+i
#         num_mul=num_mul*i
#     print(num_sum,num_mul)
# SumItemsMulItems([1,2,3,4,5])
 
# #3,4
# def LargestAndSmallestNum(lis):
#     val=sorted(lis)
#     print("The largest number is:",val[-1])
#     print("The smallest number is:",val[0])
# LargestAndSmallestNum([2,3,1,7,5,4,0])

# #5
# def CountNoOfString(lis):
#     count=0
#     for i in lis:
#         if len(i)>=2 and i[-1]==i[0]:
#             count+=1
#     print(count)
# CountNoOfString(['abc', 'xyz', 'aba', '1221','amanna'])

# 7
# def FindDuplicate(lis):
#     new_list=[]
#     for i in lis:
#         if i not in new_list:
#             new_list.append(i)
#     return new_list
# val=FindDuplicate([1,1,2,2,3,3])
# print(val)

# 8
# def CheckEmpty(lis):
#     new_lis=[]
#     if lis==new_lis:
#         print('Empty')
#     else:
#         print('Not Empty')
# CheckEmpty([1,2,3])

# 9
# def CopyList(lis):
#     lis1=lis.copy()
#     print(lis1)
# CopyList([1,2,3])

# 10
# def LongerThanN(lis,num):
#     for i in lis:
#         if len(i)>num:
#             print(i)
# LongerThanN(['abcd','aaaa','ab','a'],3)

# 11
# def OneCommonMemb(lis1,lis2):
#     for i in lis1:
#         for j in lis2:
#             if i==j:
#                 return True
#     return False
# val=OneCommonMemb([1,2,3],[5,2,6])
# print(val)

# 12
# def RemoveElement(lis):
#     new_li=[]
#     for (index,item) in enumerate(lis):
#         if index not in (0,4,5):
#             new_li.append(item)
#     return new_li
# val=RemoveElement(['Red','Green','White','Black','Pink','Yellow'])
# print(val)

# 13
# lis = [[['*'for col in range(6)]
#        for col in range(4)]
#        for row in range(3)]
# print(lis)

# 14
# def RemoveEven(lis):
#     count=0
#     for i in lis:
#         if i%2==0:
#             lis.remove(i)
#     return len(lis)
# val=RemoveEven([1,3,4,5])
# print(val)

# 16
# def FirstFiveLastFive():
#     lis=[]
#     for i in range(1,31):
#         lis.append(i**2)
#     print(lis[0:5])
#     print(lis[-5:])
# FirstFiveLastFive()

# 17
# def FirstFiveLastFive():
#     lis=[]
#     for i in range(1,31):
#         lis.append(i**2)
#     print(lis[6:])

# FirstFiveLastFive()

# 19
# def DiffrenceList(lis1,lis2):
#     new=[]
#     for i in lis1:
#         if i not in lis2:
#             new.append(i)
#     return new
# val=DiffrenceList([1,2,3,4,5],[3,2,5] )
# print(val)

# 20
# def Access(lis):
#     for index,item in enumerate(lis):
#         print(item,"at",index)
# Access([4,5,6,7,8])

# 21
# def ConvertListToString(lis):
#     st=''
#     for i in lis:
#         st=st+i
#     print(st,type(st))
# ConvertListToString(['a','b','c'])

# 24
# def AppendLis(l1,l2):
#     return l1+l2
# val=AppendLis([1,2,3],[4,5,6])
# print(val)

# 25
# import random
# def PickRandom(lis):
#     return random.choice(lis)
# val=PickRandom([1,2,3,4,5])
# print(val)

# 26
# def Identical(l1,l2):
#     l1.sort()
#     l2.sort()
#     if l1==l2:
#         print('Identical')
#     else:
#         print('Not identical')
# Identical([2,3,3,4,5],[4,5,2,2,3])

# 27
# def SecondSmallest(lis):
#     lis.sort()
#     print(lis[1])
# SecondSmallest([3,5,4,8,0])

# 28
# def SecondLargest(lis):
#     lis.sort()
#     print(lis[-2])
# SecondLargest([3,5,4,8,78,0])

# 29
# def Unique(lis):
#     new_lis=[]
#     for i in lis:
#         if i not in new_lis:
#             new_lis.append(i)
#     return new_lis
# val=Unique([1,1,2,2,3,4])
# for i in val:
#     print(i)

# 30
# def FreqEle(lis):
#     dic={}
#     for i in lis:
#         if i  in dic:
#             dic[i]+=1
#         else:
#             dic[i]=1
#     for key,items in dic.items():
#         dic[key]=items
#     print(dic)
# FreqEle([1,1,2,2,3,3,4,1,2])

# 31
# def ElemSpec(lis,start,end):
#     l1=[]
#     for i in range(start,end+1):
#         l1.append(lis[i])
#     print(l1)
# ElemSpec([1,2,3,4,5],1,3)

#35
# def ConcatRange(num):
#     lis=['p','q']
#     new_lis=[]
#     for i in range(1,num+1):
#         for j in lis:
#             val=j+str(i)
#             new_lis.append(val)
#     print(new_lis)
# ConcatRange(5)

#36
# def UniqueIdentification(integer,string):
#     return f'{id(integer)} { id(string)}'
# print(UniqueIdentification(10,'10'))

#38

#39
# def ConertListToSingle(lis):
#     st=''
#     for i in lis:
#         st+=str(i)
#     val=int(st)
#     print(type(val))
# ConertListToSingle([11, 33, 50])

vl='aman'
new='this is %s'%vl
print(new)