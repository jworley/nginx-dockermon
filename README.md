# nginx-dockermon

Automated nginx reverse proxy using Docker and dockermon. Uses dockermon to generate reverse proxy config
files for nginx and reloads nginx when containers with exposed ports are started and stopped  

## Usage

To run this container:

```
$ docker run -d -p 80:80 -v  /var/run/docker.sock:/tmp/docker.sock jasonincode/nginx-dockermon
```

Then start the contianers that are to be proxied with the environment variable VIRTUAL_HOST=app.contoso.com  

```
$ docker run -e VIRTUAL_HOST=app.contoso.com ...
```

Nginx will now forward requests with the given host name to the new started container.

### Multiple ports

If your container exposes multiple ports, nginx-dockermon will forward to port 80 by default, to override this
behavior set the variable VIRTUAL_PORT to the desired port.

### Multiple hosts

You can map multiple host names to a single container by comma delimiting them in the VIRTUAL_HOST variable.
