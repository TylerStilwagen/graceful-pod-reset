# The $null is so that memory in the variable isn't cached.
# $ErrorActionPreference = "SilentlyContinue"
$Pods = $null
$Region = $null
$Region = Read-Host -Prompt 'Input region name'
$NS = Read-Host -Prompt 'Input namespace'
kubectl get pods -n $NS --context $Region
$Search = Read-Host -Prompt 'Input unique search string'
$Interval = Read-Host -Prompt 'Input time to delay between deletes'
$Pods = kubectl get pods -n $NS --context $Region -o=custom-columns=NAME:.metadata.name | findstr $Search
$Pods = $Pods.Trim(" NAME ")
write-host Deleting these pods in 10 seconds: $Pods
start-sleep -seconds 10
foreach ($Items in $Pods) {
kubectl delete pod -n $NS --context $Region $Items
start-sleep -seconds $Interval
}
kubectl get pods -n tms --context $Region | findstr $Search
