ARG base_image

FROM $base_image

RUN apt-get update ; apt-get install -y \
      curl \
      jq  &&\
      rm -rf /var/lib/{apt,dpkg,cache,log}/

ENV ROOT_PATH /opt/frontline/probe

COPY probe bootstrap ${ROOT_PATH}/bin/

RUN chmod 755 ${ROOT_PATH}/bin/probe ${ROOT_PATH}/bin/bootstrap

WORKDIR ${ROOT_PATH}

EXPOSE 9999

ENTRYPOINT ["./bin/probe"]
CMD ["/bin/sh", "-c", "cat"]
