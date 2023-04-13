# tailscale

Run Tailscale (agent/relay/proxy) in a container

## Usage

This client is made to be run inside a docker container.<br/>
There is no need to expose the network interface nor use the network host.<br/>
Why?<br/>
Because there some environment variables that allow to use this container as a reverse proxy when in the tailscale network there are some subnets exposed.<br/>
<br/>
First of all, if your host doesn't have `net.ipv4.ip_forward` enabled (that is mandatory for tailscale) you can active it with `SET_IP_FORWARD=true`.<br/>
<br/>
Then, you can active the proxy mode with `PROXY_MODE=true`.<br/>
The proxy mode will enable a nginx reverse proxy that will expose from this container some of the services that are running inside the tailscale network, that you can specify with some environment variables with this format:<br/>
```PROXY_HOST_[LOCAL-PORT]=[REMOTE-HOST]:[REMOTE-PORT]```<br/>
The reverse proxy will automatically use tailscale nameserver (100.100.100.100) to resolve the REMOTE HOST. <br/>
If you want to use a custom namesever you can specify it in the `DNS_SERVER` environment variable.

### Docker

```bash
docker run -d \
  -e PROXY_MODE=true \
  -e PROXY_HOST_8800=172.20.219.159:8000 \
  -e PROXY_HOST_8801=10.43.195.57:8000 \
  -e SET_IP_FORWARD=true \
  -e TAILSCALE_LOGIN_SERVER=<your_headscale_server>\
  -e TAILSCALE_HOSTNAME=local-client \
  -e TAILSCALE_AUTH_KEY=<your_auth_key> \
  -e TAILSCALE_ACCEPT_ROUTES=true \
  -e DNS_SERVER=10.43.0.10
  --privileged \
  -p 8800:8800 \
  -p 8801:8801 \
  leen15/tailscale
```

## Credits

inspired by @hamishforbes [gist](https://gist.github.com/hamishforbes/2ac7ae9d7ea47cad4e3a813c9b45c10f) and @mvisonneau
