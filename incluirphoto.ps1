$List=(Get-ChildItem E:\USERPIC)
ForEach ($photo in $List){
    $photo1 = [byte[]](Get-Content "E:\USERPIC\$photo" -Encoding byte)
    Set-ADUser $photo.BaseName -Replace @{thumbnailPhoto=$photo1} -Verbose
} 
Remove-Item E:\USERPIC\*.jpg -Recurse