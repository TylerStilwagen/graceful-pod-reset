# The $null is so that memory in the variable isn't cached.
$ErrorActionPreference = "SilentlyContinue"
$DC = ("dublin-pci", "frankfurt-pci", "hongkong-pci", "norcal-pci", "seoul-pci", "tokyo-pci", "virginia-pci")
foreach ($Region in $DC){
$Pods = $null
$Pods = kubectl get pods -n cart -o=custom-columns=NAME:.metadata.name --context $Region
$Pods = $Pods.Trim(" NAME ")
foreach ($Items in $Pods) {
  write-host "kubectl delete pod -n cart --context" $Region $Items
start-sleep -seconds 5
}}