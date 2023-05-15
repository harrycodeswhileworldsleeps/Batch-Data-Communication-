# Batch-Data-Communication-

BDC in ABAP. 
Requirement 

Team has been doing a manual task of updating the sales org for every run. 
To automate this with the help of file, we will be using BDC.

![image](https://github.com/harrycodeswhileworldsleeps/Batch-Data-Communication-/assets/94862735/ee5337fc-fe2f-48db-9c25-cc4d953ea33e)


## Step 1 - T code SHDB 

![image](https://github.com/harrycodeswhileworldsleeps/Batch-Data-Communication-/assets/94862735/2fdc11f4-8944-4cad-99d0-18f6e06d6250)

## Step 2 

After the recording is done , move ahead with the task of copying it into a program. After that start the formation of internal table and workareas for the structure type that is made , also for the standard 'BDCDATA'. 

## Step 3 

Try to replace the manual inputs with the necessary dynamic variables / work-areas. 

## How it works: - 

![image](https://github.com/harrycodeswhileworldsleeps/Batch-Data-Communication-/assets/94862735/760e94c6-46ae-484f-8b44-836e4b172283)

Asks for the file 

![image](https://github.com/harrycodeswhileworldsleeps/Batch-Data-Communication-/assets/94862735/31802b53-58ac-49f1-975f-72bdc3d07d73)

Does everything manually 

![image](https://github.com/harrycodeswhileworldsleeps/Batch-Data-Communication-/assets/94862735/d368ffe7-0b03-49c2-bb2e-26ec0fb0b018)

Created entries ! 
2 ways to do BDC are: - 

Call Transaction Method 
For this refer to the program - ZSLS_ORG_BDC

Session Metod 

Here 3 standard FM are used
1. BDC_INSERT 
2. BDC_OPEN_GROUP 
3. BDC_CLOSE_GROUP

Also subroutines BDC_DYNPRO and BDC_FIELD are important to mention. 

SM35 is the T code to check your batch input sessions 

![image](https://github.com/harrycodeswhileworldsleeps/Batch-Data-Communication-/assets/94862735/2245a776-ed7d-4a7b-b2cd-054d419da1a9)




