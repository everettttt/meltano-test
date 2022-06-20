ARG MELTANO_IMAGE=meltano/meltano:v2.1.0-python3.8
FROM $MELTANO_IMAGE

WORKDIR /project

# Install all plugins into the `.meltano` directory
COPY ./meltano.yml .
RUN meltano install

# Pin `discovery.yml` manifest by copying cached version to project root
RUN cp -n .meltano/cache/discovery.yml . 2>/dev/null || :

# Copy over remaining project files
COPY . .

# Expose default port used by `meltano ui`
EXPOSE 5000

ENTRYPOINT ["meltano"]