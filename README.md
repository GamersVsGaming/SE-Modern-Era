# SE-Modern-Era
An open source re-envisioning of an older browser based game. Original code comes from: https://sourceforge.net/projects/solar-empire/

## Information
This wordpress development system comes with a CLI helper that should work on Mac and Linux.

You will need to have docker and docker-compose installed on Linux.

You will need to have docker-desktop and docker-compose installed on Mac.

To get a list of available commands type `./server` and press enter.

You can see the names of all running containers using `docker-compose ps` and all stopped containers running `docker-compose ps -a`.

```
$> ./server
Server Manager provided by [D]uffion
Developed by Terry Valladon <duffion@terryvalladon.com>
dev                            Simple dev enviroment. This will run Up and then Import on provided file name. Usage: ./server dev <mysql backup file in src/__dev directory>
down                           Tear down the infrastructure leaving images
env                            Generates .env file based on user input and appends a unique slug to the end of container names
export                         Export the current mysql database to src/__dev folder
first_run                      Start the containers and display information needed for Wordpress Setup page
fixperms                       Reset ownership of files in wordpress to the current shell user
gexport                        Export the current mysql database to src/__dev folder
gimport                        Import a gzipped sql file from src/__dev folder into the mysql database. Must provide filename on end of command.
gulpw                          Uses local gulp bins in the node_modules folder instead of global bins to run 'gulp watch'
help                           Display usage for this application
import                         Import a sql file from src/__dev folder into the mysql database. Must provide filename on end of command. Modified by Jordan L to drop the existing DB before importing.
init                           Pulls in a project form a specified remote, mirrors a specific branch, and fixes permissions
killall                        Kills all docker containers currently running on your host
localmod                       Changes URLs in the DB for posts, postmeta, home, and siteurl to localhost
npminst                        Installs node_modules into your child theme's working directory
purge                          Tear down the infrastructure removing images and volumes and orphans
rebuild                        Rebuild all containers or a single container by name
release                        Build the release docker image for pushing as latest to docker hub
restart                        Restart all containers or a single container by name
setup                          Setup the required directories and display instructions for setup
shell                          Launch shell into container by name
start                          Start all containers or a single container by name
stop                           Stop all containers or a single container by name
timport                        Import a tar.gz compressed sql file from src/__dev folder into the mysql database. Must provide filename on end of command.
update_start                   Set ownership of files in wordpress container to www-data so the system can update
up                             Launch the infrastructure
wp_update                      Updates WP to the latest version
Task completed in 0m0.003s

```

## Setup
   1. Run `./server env` to generate a .env file and append a unique slug to your container names. The unique slug can really be anything but it is best to use something short and related to the project (i.e. for the Duffion.com site, I might use 'ddc')
   2. Run `./server up` to build the WordPress and MySQL DB containers
   3. Run `./server init` to pull in a specified project and mirror a specified branch. Use the SSH URL in the github repo. This function also fixes your file permissions automagically (NOTE: sudo permissions are required)
   4. Run `./server gimport src/__dev/[db_name]` or `./server timport src/__dev/[db_name]` to import a compressed database from the src/__dev folder. The `gimport` function handles .gz files and the `timport` function handles .tar.gz files
   5. Navigate to `localhost` in your browser window to run initial WordPress setup and generate a wp-config.php file. Use the values in your .env file for the DB name, local username, local user password, and DB host

## NPM Functions
  - `./server npminst` will install node modules (npm install) into a specified theme dir
  - `./server gulpw` will run `gulp watch` directly from the node_modules folder

## Database Functions
  - `./server export` will export the current mysql database to src/__dev with the name and timestamp set. Use `ls src/__dev` to see export files.
  - `./server import src/__dev/<filename>` will import the selected sql file into the mysql database. Import file must be located in the src/__dev folder.
  - `./server gimport src/__dev/<filename>` will import a gzip compressed (.gz) database file in src/__dev 
  - `./server timport src/__dev/<filename>` will import a .tar.gz database file in src/__dev
  - `./server gexport` will export a gzip compressed (.gz) database file into src/__dev
  - `./server localmod` allows you to change the site, home, post, and postmeta URLs to 'localhost'; this is used if importing a prod or staging DB into your environment
  
## Permissions
  - `./server update_start` will set the permissions of WordPress files to be owned by the docker web service user; this is used to ensure plugins and core can be easily updated from the backend
  - `./server fixperms` will set the permissions of ALL files to be owned by the currently logged in user account

## Start / Stop / Restart
The following commands can be used to start, stop and restart the containers. 
 - `./server start <container>` - Start all containers, or a container by name, if stopped
 - `./server stop <container>` - Stop all containers, or a container by name, if started
 - `./server restart <container>` - Restart all containers, or a container by name, if started

## Up / Down / Rebuild / Purge
The following commands should only be needed in the event you are rebuilding, updating or removing the wordpress docker dev env from the computer:
  - `./server up` - Will build / rebuild and launch the docker containers
  - `./server down` - Stop and remove the running docker containers
  - `./server rebuild` - Will rebuild and relaunch the docker containers
  - `./server purge` - Stop and remove the running docker containers and remove the cached docker images
  - `./server killall` - Kills all docker containers currently running on your host

## Shell
Using `./server shell <container>` you can access a bash shell in a specific container. This can be useful for runing shell commands such as composer, checking setup configuration or debugging issues.

## Release
The `./server release` command is a wip, and will be used to build a functional docker image that can be pulled down to a hosting services such as Digital Ocean or AWS to host the developed application.
