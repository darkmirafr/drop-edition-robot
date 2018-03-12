# Drop edition robot

Drop edition to install on every drop robot.


## Install

Requires Docker and docker-compose.

``` bash
git clone git@github.com:Darkmira/drop-edition-robot.git
cd drop-edition-robot/

cp .env.dist .env
# Then set your variables (robot color, server instance, wired pins)

make
```


## Usage

Running make will make your robot listen to his queue (depending on his color),
then execute any order pushed to the queue (forward, right...).


### Testing on amd PC

To test the script on non-Raspberry hardward,
it is possible to use AMD configuration for docker:

Use an AMD image, and/or a RabbitMQ instance by creating a `docker-compose.override.yml` with:

``` yaml
version: '2'

services:
    drop-robotapi-php:
        build:
            context: .
            dockerfile: Dockerfile.amd
        links:
            - rabbitmq

    #
    # RabbitMQ
    #
    rabbitmq:
        image: rabbitmq:management-alpine
        ports:
            - 12000:5672
            - 12001:15672
```

*You may need to comment out in docker compose devices and /sys volume.*

Then go to http://0.0.0.0:12001 and push some message to the queue, like `forward`.
You should see the robot answer in logs.


## License

This library is under [MIT License](LICENSE).
