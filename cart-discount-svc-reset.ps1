# The $null is so that memory in the variable isn't cached.
$Pods = $null
$Region = $null
# $ErrorActionPreference = "SilentlyContinue"
$Region = Read-Host -Prompt 'Input region name'
$Pods = kubectl get pods -n cart -l harness.io/service-infra-id=fb2b7147-02ec-3757-9646-0c78080d31bb -o=custom-columns=NAME:.metadata.name --context $Region
$Pods = $Pods.Trim(" NAME ")
foreach ($Items in $Pods) {
kubectl delete pod -n tms --context $Region $Items
start-sleep -seconds 15
}
kubectl get pods -n cart -l harness.io/service-infra-id=fb2b7147-02ec-3757-9646-0c78080d31bb --context $Region