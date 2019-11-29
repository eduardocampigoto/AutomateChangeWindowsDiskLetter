<# 
Use The command below in a powershell to extract the information to fill the variable $diskUUIDs,
and fill the new letter variables in the same order that the disks where you want to set them.

$parts = Get-Partition ; foreach( $part in $parts ){ $diskId = $part.DiskId; $letter = $part.DriveLetter; $diskNumber = $part.DiskNumber ;$number = $part.PartitionNumber; Write-Output " Drive Letter: = $letter `n Disk ID: $diskID `n Disk Number: $diskNumber `n Partition Number = $number `n`n "}
#>

<#
e.g:
$diskUUIDs=@(""{00000000-0000-0000-0000-110000001000}USBSTOR\DISK&VEN_KINGSTON&PROD_DATATRAVELER_2.0&REV_1.5\3556DDFSSASD1BC1A111134fFA&0:DESKTOP","{00000000-0000-0000-0000-100000001000}USBSTOR\DISK&VEN_KINGSTON&PROD_DATATRAVELER_2.0&REV_1.2\3556DDFSSASD1BC1A1DSSDFGF&0:DESKTOP")
$diskUUIDs=@(""{00000000-0000-0000-0000-110000001000}USBSTOR\DISK&VEN_KINGSTON&PROD_DATATRAVELER_2.0&REV_1.5\3556DDFSSASD1BC1A111134fFA&0:DESKTOP")
#>
$diskUUIDs=@()

<# in $newLetters set the letters that will be used by the partitions above 
e.g:
$newLetters=@("G")
$newLetters=@("G","F")
#>
$newLetters=@()

#DONT CHANGE NOTHING BELOW THIS LINE
foreach($uuid in $diskUUIDs) {    
$letter = $newLetters[[array]::IndexOf($diskUUIDs,$uuid)]
$Partition = (Get-Partition | where UniqueId -eq $uuid)
            
        if($letter -ne $Partition.DriveLetter){
            $dNumber = $Partition.DiskNumber
            $partitionN = $Partition.PartitionNumber            
            $dpartCommand = @" 
SELECT DISK $dNumber
SELECT PARTITION $partitionN
ASSIGN LETTER $letter
"@
            $dpartCommand | Diskpart | Out-Null

            
        }

    
} 
