# The $null is so that memory in the variable isn't cached.
$ErrorActionPreference = "SilentlyContinue"
$Pods = $null
$Region = $null
$Region = Read-Host -Prompt 'Input region name'
$Pods = kubectl get pods -n tms -l harness.io/service-infra-id=7556398e-69a0-3b07-a67d-c193092f9cae -o=custom-columns=NAME:.metadata.name --context $Region
$Pods = $Pods.Trim(" NAME ")
foreach ($Items in $Pods) {
kubectl delete pod -n tms --context $Region $Items
start-sleep -seconds 15
}
kubectl get pods -n tms -l harness.io/service-infra-id=7556398e-69a0-3b07-a67d-c193092f9cae --context $Region