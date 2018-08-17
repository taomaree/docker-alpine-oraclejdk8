FROM frolvlad/alpine-glibc:alpine-3.8 as builder

ENV JAVA_VERSION=8 \
    JAVA_UPDATE=181 \
    JAVA_BUILD=13 \
    JAVA_PATH=96a7b8442fe848ef90c96a2fad6ed6d1 \
    JAVA_HOME="/usr/java/latest"

RUN apk add --no-cache --virtual=build-dependencies wget ca-certificates unzip && \
    mkdir -p /usr/java && \
    wget -P /usr/java --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
        "http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_UPDATE}-b${JAVA_BUILD}/${JAVA_PATH}/server-jre-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" && \
    tar xzfv "/usr/java/server-jre-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" -C /usr/java && \
    mv "/usr/java/jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE}" /usr/java/latest


FROM frolvlad/alpine-glibc:alpine-3.8
ENV JAVA_HOME=/usr/java/latest
ENV PATH="$PATH:${JAVA_HOME}/bin"
COPY --from=builder $JAVA_HOME $JAVA_HOME/
RUN apk --no-cache add ca-certificates
