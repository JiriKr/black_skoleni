FROM python:3.10-bullseye

RUN adduser --disabled-password --gecos "" django

ARG UID
ARG GID
ENV UID $UID
ENV GID $GID

RUN usermod -u $UID django \
    && groupmod -g $GID django

COPY poetry.lock pyproject.toml ./

RUN pip install --no-cache-dir poetry && \
    poetry config virtualenvs.create false && \
    poetry install --no-root --no-interaction --no-ansi -vvv


WORKDIR /app