# docker-php

```bash
docker pull technomatix/php
```

## Run codecept

```bash
docker run -it --rm technomatix/php codecept
```

## Run any php-script

```bash
docker run -it --rm -v $(pwd):/project/ technomatix/php -f path.php
```

## Run composer <comand>

```bash
docker run -it --rm technomatix/php composer <comand>
```
