FROM yrpri/java-base

RUN \
  cd /tmp && \
  wget https://download.elasticsearch.org/kibana/kibana/kibana-4.0.0-beta3.tar.gz &&\
  tar xvzf kibana-4.0.0-beta3.tar.gz && \
  mv /tmp/kibana-4.0.0-beta3 /kibana

ENV KIBANA_PORT 5642
ENV KIBANA_HOST 0.0.0.0
ENV ES_HOST example.es.com
ENV ES_PORT 9200
ENV KIBANA_INDEX .kibana_b3
ENV APP_ID discover
ENV REQUEST_TIMEOUT 60
ENV SHARD_TIMEOUT 30000
ENV VERIFY_SSL false

ADD config/kibana.yml /kibana/config/kibana.yml
ADD ./run.sh /kibana/run.sh
RUN chmod +x /kibana/run.sh
ADD supervisor.conf /etc/supervisor/conf.d/kibana4.conf

WORKDIR /kibana

EXPOSE 5601
