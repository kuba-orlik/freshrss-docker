# freshrss-docker
A docker image and docker-compose file for fresh-rss with php7 and a mysql database

## Usage


```
git clone https://github.com/kuba-orlik/freshrss-docker.git
cd freshrss-docker
```

Then, edit the `config.php` file to your liking. Please don't change mysql settings unless you want to use an external database. 

```
./build
docker-compose up -d
```

Then, connect to the app via a web browser and run the setup. Choose 'mysql' database. The credentials are:

* db_name: `root`
* username: `root`
* password: `4335b345ace04ea468bada82a0b3e152`
