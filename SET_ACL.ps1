
#Set the default folder to get the ACL info, can be used on mapped drives such as Windows File Servers or Sharepoint connections, recommended to run on the server but can be used on an external connector.
#$Folder_Path_C = "C:\temp"
#$Folder_Path_B = "C:\temp"
#$Folder_Path_A = "C:\temp"

$ACL_C = get-acl "$Folder_Path_C" # get the default ACL permissions that you want to use, modify and reaply on different folders
$ACL_B = get-acl "$Folder_Path_B"
$ACL_A = get-acl "$Folder_Path_A" 

#Where you want the new folder to be created
#$Destination = "C:\test\temp"

#The AD user that is the variable for this case, you can use a csv file with the default users and permissions but here I did with just one user with several folders
$NUser = Read-Host "Inform the AD User"

md "$Destination\"
md "F:\Comercial\$NUser\Documentos Cadastral"
md "F:\Comercial\$NUser\Documentos Juridico"



$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("Domain\$NUser","ExecuteFile,WriteAttributes,ReadData,CreateFiles,AppendData,ReadExtendedAttributes,DeleteSubdirectoriesAndFiles,ReadPermissions,ReadAttributes,WriteExtendedAttributes","ContainerInherit,ObjectInherit","None","Allow")
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("Domain\$Group","ExecuteFile,WriteAttributes,ReadData,CreateFiles,AppendData,ReadExtendedAttributes,DeleteSubdirectoriesAndFiles,ReadPermissions,ReadAttributes,WriteExtendedAttributes","ContainerInherit,ObjectInherit","None","Allow")

$ACL_Adm.SetAccessRule($AccessRule)
$ACL_Cad.SetAccessRule($AccessRule)
$ACL_Jur.SetAccessRule($AccessRule)


$ACL_Adm.SetAccessRule($OAccessRule)
$ACL_Cad.SetAccessRule($OAccessRule)
$ACL_Jur.SetAccessRule($OAccessRule)

$ACL_Adm | Set-Acl "F:\Comercial\$NUser\Documentos Administrativo"
$ACL_Cad | Set-Acl "F:\Comercial\$NUser\Documentos Cadastral"
$ACL_Jur | Set-Acl "F:\Comercial\$NUser\Documentos Juridico"
