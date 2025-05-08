$dzisiejsza_data = Get-Date
$logNames = @("System", "Application", "Security", "Setup")

$f_data = $dzisiejsza_data.ToString("dd-MM-yy")

cls
$pokoj = Read-Host "Nr Pokoju: "
$dir_name = "C:\Users\${env:USERNAME}\Desktop\Logi_${pokoj}_Data-${f_data}\"
if(-not(Test-Path $dir_name)){
    mkdir $dir_name

    foreach($logName in $logNames){
        $evtxFilePath = ${dir_name} + $logName + ".evtx"
        wevtutil epl $logName $evtxFilePath
    }
}else{
    cls
    Write-Warning "folder juz istnieje!"
}