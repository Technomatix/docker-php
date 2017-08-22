# PHP stack

## Work image

```bash
docker pull technomatix/php
```

Run any php-script:

```bash
docker run -it --rm -v $(pwd):/project/ technomatix/php -f path.php
```

Run composer %command%:

```bash
docker run -it --rm technomatix/php composer %command%
```

## Dev image

```bash
docker pull technomatix/php:dev
```

Run codecept:

```bash
docker run -it --rm technomatix/php:dev codecept
```

Run shellcheck:

```bash
docker run -it --rm technomatix/php:dev shellcheck
```

Run bats:

```bash
docker run -it --rm technomatix/php:dev bats
```
