[![Release Charts](https://github.com/QCDIS/VREPaaS-helm-charts/actions/workflows/release.yaml/badge.svg)](https://github.com/QCDIS/VREPaaS-helm-charts/actions/workflows/release.yaml)
[![Test Charts](https://github.com/QCDIS/VREPaaS-helm-charts/actions/workflows/test.yaml/badge.svg)](https://github.com/QCDIS/VREPaaS-helm-charts/actions/workflows/test.yaml)
# VREPaaS-helm-charts

## Installation

Create `values.yaml`, filling-in the following:

```yaml
global:
  environment: production

  keycloak:
    url: "https://host/path"
    realm: "my-realm"
    client_id: "my-client-id"
    client_secret_key: "my-secret-key"

  argo:
    url: "https://host/path"
    namespace: "my-namespace"
    token: "Bearer my-token"


vreapi:
  secret_key: "(generate random key)"
  auth:
    superuser_email:
    superuser_username: "(pick a username)"
    superuser_password: "(generate a password)"
    username: "(pick a username)"
    password: "(generate a password)"
    token: "(generate a token)"

vreapp:
  secret_key: "(generate random another key)"


```

Run:

```bash
helm install paas oci://ghcr.io/qcdis/charts/vrepaas -f values.yaml
```
