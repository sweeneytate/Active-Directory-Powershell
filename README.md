# Windows-Powershell - Set up basic active directory with users
Windows Powershell to creare AD and add dummy users

1. Download all files and place them in C:\temp
2. Open newusers.cvs and in the OU tab put in "OU=STAFF,DC=contoso,DC=com". Change contoso.com to you domain and put this in each box for each user
3. Running script order
    3.1. Run "Script to install AD Roles.ps1". This will prompt for domain name and Directory Services Restore Mode (DSRM) password
    5.2  Run "Create Dummy Users.ps1" - This will prompt for domain name and the domain in DC format (DC=consoto,DC=com)

Active directory should be installed with DNS and the amount of users specified in the CSV file.

Sample of CSV file where you need to change the OU column
![image](https://user-images.githubusercontent.com/68751873/155296164-8aaaab33-0d91-4fff-96c1-c64b5fee84d0.png)
