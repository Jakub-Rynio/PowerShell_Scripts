# geting folder path
Function Get-Folder($desc="Select a folder", $initialDirectory="")
{
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms")|Out-Null

    $foldername = New-Object System.Windows.Forms.FolderBrowserDialog
    $foldername.Description = $desc
    $foldername.rootfolder = "MyComputer"
    $foldername.SelectedPath = $initialDirectory

    if($foldername.ShowDialog() -eq "OK")
    {
        $folder += $foldername.SelectedPath
    }
    return $folder
}

$forSorting =  Get-Folder("Wbierz folder do posortowania")
$sortedIn = Get-Folder("Wybierz folder w ktorym maja sie znalesc posortowane dane (Najlepiej pusty!)")

cls

if ($sortedIn -and $forSorting -and ($sortedIn -ne $forSorting)) {

    # Set the extension list
    cd $forSorting
    $filesForSort = Get-ChildItem
    $fileExtList = $filesForSort | Where-Object {$_.Extension -ne '' } | Select-Object -ExpandProperty Extension | Sort-Object -Unique


    # Create folsers 
    cd $sortedIn
    foreach ($folder in $fileExtList){
        mkdir $folder
    }
    
    # Sorting
    cd $forSorting
    $forSrotingList = $filesForSort.Name
    
    foreach ($fileName in $forSrotingList){
        foreach ($fileExt in $fileExtList){

            if ($fileName.EndsWith($fileExt)){

                $src = $forSorting + "\" + $fileName
                $des = $sortedIn + "\" + $fileExt
                Move-Item -Path $src -Destination $des
            }
        }
    }
    
}else{
    Write-Output "Musisz wybrac foldery"
}