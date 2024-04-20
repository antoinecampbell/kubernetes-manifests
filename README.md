# kubernetes-manifests
Home cluster manifests

## sealed-secrets
### Create secret
```shell
kubectl create secret generic \
  -n namespace \
  --dry-run=client \
  -o yaml \
  secret-name \
  --from-literal='MY_SECRET=password' \
  | kubeseal -o yaml --controller-namespace sealed-secrets --controller-name sealed-secrets
```
