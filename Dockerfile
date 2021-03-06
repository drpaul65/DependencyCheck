FROM java:8

MAINTAINER Timo Pagel <dependencycheckmaintainer@timo-pagel.de>

ENV user=dependencycheck
ENV version_url=https://jeremylong.github.io/DependencyCheck/current.txt
ENV download_url=https://dl.bintray.com/jeremy-long/owasp

RUN wget -O /tmp/current.txt ${version_url} && \
 version=$(cat /tmp/current.txt) && \
 file="dependency-check-${version}-release.zip" && \
 wget "$download_url/$file" && \
 unzip ${file} && \
 rm ${file} && \
 mv dependency-check /usr/share/

RUN useradd -ms /bin/bash ${user} && \
 chown -R ${user}:${user} /usr/share/dependency-check && \
 mkdir /report && \
 chown -R ${user}:${user} /report

USER ${user}

VOLUME ["/src" "/usr/share/dependency-check/data" "/report"]

WORKDIR /report

CMD ["--help"]
ENTRYPOINT ["/usr/share/dependency-check/bin/dependency-check.sh"]
