# Daemon Service

This repository is used by other repositories with git submodule. The *manager.sh* have some function to execute a script like a daemon.

## why did you use these files ?

* No installation required
* No dependency
* No blabla
* just add this repository to yours, nothing else
* Customise your daemon

After programming a script, some programmers want to execute the program like a daemon. Of course, we can use *InitV* or *SystemD*.
But these last ones need to install few things (create specific files in a specific path).

The program *Daemon-Service* would like to use a 'portative' method for any repository or script who will support it.

## Usage

Command available with the *manager.sh* :

```
status|start|stop|restart
```

## Create a daemon in your own git project

First, I create a submodule in your repository :

```
git submodule add https://github.com/Lanxor/daemon-service.git
```

Secondly, create your own *daemon* script :

```
#! /bin/bash
# daemon.sh

# Command to go on the folder of script lauched
cd "$(dirname "`readlink -f "$0"`")"

# Some variables to define the daemon
pidfile='.bme680.pid'
cmd="python3 `pwd`/module.py"

# Import the script and these functions
source "`pwd`/daemon-service/manager.sh"
```

Actually it's important to define `pidfile` and `cmd` variables to execute the daemon correctly.

## Variables

 **pidfile** : Name of file who store the PID of the daemon
 
 **cmd** : Command executed and which will turn into a background task (a daemon)

## In further

* More details with status of daemon
* Manage logfile
* one command to rules them all (just one symbolic link, perhaps)

## Example

1. Create your own git project `folder-example`.
2. Create your code (infinite loop) `example.sh`.
3. Import the git submodule `daemon-service/`
4. Create the configuration file `daemon`.

```
folder-example/
├─ daemon-service/
|  ├─ Readme.md
│  └─ manager.sh
├─ daemon
└─ example.sh
```

File **example.sh**: My script or whatever, need to be in infinite loop.
```
#! /bin/bash

while [ 1 ]; do
  sleep 2
done
```

File **daemon**: Configure the daemon-service.

Here we need to specify `bash example.sh` and not `./example`.
```
#! /bin/bash
# daemon.sh

# Command to go on the folder of script lauched
cd "$(dirname "`readlink -f "$0"`")"

# Some variables to define the daemon
pidfile='.example.pid'
cmd="bash example.sh"

# Import the script and these functions
source "`pwd`/daemon-service/manager.sh"
```


