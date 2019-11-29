$disks = Get-Disk
<# 
In $diskUUIDs set the disk UUIDs that will be used, commonly is the same that appears in SerialNumber column from Get-Disk command output.
e.g:
$diskUUIDs=@("97024B4328294CG41")
$diskUUIDs=@("97024B4328294CG41","97024B4328294CG42","97024B4328294CG43")

#IF THIS DONT WORK, TRY TO USE THE COMMAND BELOW IN POWERSHELL COMMAND PROMPT TO GET THE RIGHT UUID
$disks = Get-Disk; foreach( $disk in $disks) { $dsknm= $disk.FriendlyName; $dskmdl = $disk.Model; $dskuuid = $disk.UniqueId; $dsksz = $disk.Size;  Write-Output " NAME: $dsknm `n MODEL: $dskmdl `n UUID: $dskuuid `n SIZE: $dsksz `n `n"  }
#>
$diskUUIDs=@("")

<# 
For $disknumber, set the disk numbers for that you want to change the letter.
This information can be saw at first column of Get-Disk command output
 e.g:
 $diskNumbers=@("1")
 $diskNumbers=@("1","3")
 #>
$diskNumbers=@("")

<# 
for $partitionNumbers, set the partition numbers for that you want to change the letter.
This information can be saw at first column of Get-Partition command output
e.g:
$partitionNumbers=@("2")
$partitionNumbers=@("2","4")
#>
$partitionNumbers=@("")

<# in $letters set the letters that will be used by the partitions above 
e.g:
$letters=@("G")
$letters=@("G","F")
#>
$letters=@("")

#DONT CHANGE NOTHING BELOW THIS LINE
foreach($uuid in $diskUUIDs) {    
$partitionN = $partitionNumbers[[array]::IndexOf($diskUUIDs,$uuid)]
$letter = $letters[[array]::IndexOf($diskUUIDs,$uuid)]

    foreach($disk in $disks){       
        
        if($disk.UniqueId.Equals($uuid)){
                 $dNumber = $diskNumbers[[array]::IndexOf($diskUUIDs,$uuid)]
                 $partitionN = $partitionNumbers[[array]::IndexOf($diskUUIDs,$uuid)]
                 $letter = $letters[[array]::IndexOf($diskUUIDs,$uuid)]
                 $dpartCommand = @" 
SELECT DISK $dNumber
SELECT PARTITION $partitionN
ASSIGN LETTER $letter
"@
                              $dpartCommand | Diskpart | Out-Null

            

            
        }

    }
}

  
  