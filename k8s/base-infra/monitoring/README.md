# kube-prometheus-stack
Some resources are too large so the apply needs
to run server side.
```shell
kustomize build . --enable-helm | kubectl apply --server-side=true -f -
```
