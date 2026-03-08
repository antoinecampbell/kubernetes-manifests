# ArgoCD

## Applying Changes
Some of the CRDs are too large and require a server side apply. 
To apply changes, run the following command:

```bash
kustomize build . --enable-helm | kubectl apply --server-side --force-conflicts -f - 
```
