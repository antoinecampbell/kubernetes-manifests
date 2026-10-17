# Renovate

Run renovate for a single repo in a disposable container:
```shell
kubectl -n renovate run -it --rm renovate-temp \
  --image=renovate/renovate:latest \
  --restart=Never \
  --overrides='{
    "apiVersion":"v1",
    "spec":{
      "containers":[
        {
          "name":"renovate",
          "image":"renovate/renovate:latest",
          "envFrom":[
            {"secretRef":{"name":"renovate-env"}}
          ],
          "env":[
            {"name":"LOG_LEVEL","value":"info"},
            {"name":"RENOVATE_AUTODISCOVER","value":"false"},
            {"name":"RENOVATE_ENDPOINT","value":"https://api.github.com"},
            {"name":"RENOVATE_GIT_AUTHOR","value":"Renovate Bot <bot@renovateapp.com>"},
            {"name":"RENOVATE_PLATFORM","value":"github"},
            {"name":"RENOVATE_CONFIG","value":"{\"repositories\":[\"antoinecampbell/ktor-api\"]}"}
          ]
        }
      ],
      "restartPolicy":"Never"
    }
  }'
```
