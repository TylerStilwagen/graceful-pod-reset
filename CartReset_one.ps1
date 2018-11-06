# The $null is so that memory in the variable isn't cached.
$Pods = $null
$Region = $null
$ErrorActionPreference = "SilentlyContinue"
$Region = Read-Host -Prompt 'Input region name'
$Pods = kubectl get pods -n cart -o=custom-columns=NAME:.metadata.name --context $Region
$Pods = $Pods.Trim(" NAME ")
foreach ($Items in $Pods) {
write-host "kubectl delete pod -n cart --context" $Region $Items
start-sleep -seconds 5
}