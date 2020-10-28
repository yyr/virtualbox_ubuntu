# Setting up required variables
$VM = "ubuntu20"
$ostype = "Ubuntu_64"
$vbm = "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"
$isopath = "C:\Users\85005\Downloads\ubuntu-20.04.1-desktop-amd64.iso"
$username = "ceoas"
$fullusername = "Ceoas Student"
$mypassword = "ceoasceoas"
$hostname = "ceoasvm.local"

# start
& $vbm createvm --name $VM --ostype $ostype --register

# Setup Virtual Storage/Disks for the Virtual Machine, achievable by CLI or GUI
& $vbm createhd --filename /VirtualBox/$VM/$VM.vdi --size 81920
& $vbm  storagectl $VM --name "SATA Controller" --add sata --controller IntelAHCI
& $vbm storageattach $VM --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium /VirtualBox/$VM/$VM.vdi
& $vbm  storagectl $VM --name "IDE Controller" --add ide
& $vbm storageattach $VM --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium $isopath

# Define Misc settings for the Virtual Machine (optional)
& $vbm modifyvm $VM --ioapic on
& $vbm modifyvm $VM --boot1 dvd --boot2 disk --boot3 none --boot4 none
& $vbm modifyvm $VM --memory 2048 --vram 128

& $vbm unattended install $VM --iso=$isopath --user=$username --full-user-name=$fullusername --password $mypassword --time-zone=UTC --country=IN --hostname=$hostname  --language=en-US  --install-additions

# & $vbm list ostypes

# & $vbm startvm $VM --type headless
& $vbm startvm $VM
