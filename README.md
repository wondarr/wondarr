Wondarr
-
Wondarr is an independent application that automates the downloading of media from the Internet. It is similar to [Radarr](https://github.com/Radarr/Radarr), [Sonarr](https://github.com/Sonarr/Sonarr), and [Jackett](https://github.com/Jackett/Jackett) except it aims to be a healthy alternative to all of those by implementing their features and capabilities in one application.

#### Building
```bash
git clone https://github.com/wondarr/wondarr.git
cd wondarr
./setup.sh build
```

#### Running
After the above steps:
```bash
cd build
./wondarr
```
The app will then be accessible at [localhost:8000](localhost:8000). This will bind the server to localhost only, meaning the app will only be accessible on that machine. To bind to all addresses:
```bash
cd build
ROCKET_ENV=prod ./wondarr
```
With the prod environment enabled the app will then be accessible at the server's address on the standard port 80. This will allow you to access the app from other machines, although if you are on Linux you will likely need to run the sever as root.
