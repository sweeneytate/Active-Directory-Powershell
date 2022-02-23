##Create Dummy Users in AD from new users CSV UTF-8 File
##Will create new OU called Staff, will create C:\temp if it does not exist.
##newusers.csv must be in C:\temp (this script should place it there if its located elsewhere on the C:\ drive

$domainName = Read-Host "Enter the Domain Name ->"
$DC = Read-Host "Enter DC in format (DC=consoto,DC=com) ->"

New-ADOrganizationalUnit -Name "Staff" -Path "$DC" -ProtectedFromAccidentalDeletion $true

##checks if temp folder exists
$Folder = "C:\temp"
if (Test-Path -Path $Folder){
    Write-Host "Temp Path is Valid"
    }
    else
   {
    mkdir C:\temp 
    Write-Host "Path created"
    }
##checks if the file is  in the right directory
if(Test-Path -Path C:\temp\newusers.csv){
    Write-Host "File is already in the right location"
    }
else
{
Get-ChildItem -Path C:\ -Recurse newusers.csv | Move-Item -Destination C:\temp\
    Write-Host "File found and copies to the right location :)"
} 

$ADUsers = Import-csv C:\temp\newusers.csv

foreach ($User in $ADUsers)
{

       $Username    = $User.username
       $Password    = $User.password
       $Firstname   = $User.firstname
       $Lastname    = $User.lastname
    $Department = $User.department
       $OU           = $User.ou

       #Check if the user account already exists in AD
       if (Get-ADUser -F {SamAccountName -eq $Username})
       {
               #If user does exist, output a warning message
               Write-Warning "A user account $Username has already exist in Active Directory."
       }
       else
       {
              #If a user does not exist then create a new user account
          
        #Account will be created in the OU listed in the $OU variable in the CSV file; don’t forget to change the domain name in the"-UserPrincipalName" variable
              New-ADUser `
            -SamAccountName $Username `
            -UserPrincipalName "$Username@$domainName" `
            -Name "$Firstname $Lastname" `
            -GivenName $Firstname `
            -Surname $Lastname `
            -Enabled $True `
            -ChangePasswordAtLogon $True `
            -DisplayName "$Lastname, $Firstname" `
            -Department $Department `
            -Path $OU `
            -AccountPassword (convertto-securestring $Password -AsPlainText -Force)

       }
}