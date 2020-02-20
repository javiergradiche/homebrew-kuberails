# Docker 
```
# build docker image
docker-compose build
```

# Generators
```
docker-compose run kuberails /bin/sh
> rb2exe kuberails.rb --add=. --output=./bin/linux/kura --target=l64
> rb2exe kuberails.rb --add=. --output=./bin/osx/kura --target=osx
```
#

# Usage 
```
# add executable to your bin folder
cp ./bin/osx/kura ~/bin/
kura --help #get help
kura pods -e prod #get all pods with prod in mame
kura pods -n -e stage #get all pods, and show description of pod selected in options
```