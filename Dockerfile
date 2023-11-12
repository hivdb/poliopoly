FROM openjdk:18
ADD https://get.nextflow.io /usr/bin/nextflow
RUN chmod +x /usr/bin/nextflow && /usr/bin/nextflow
ENV VIRALRECON_VERSION=2.6.0
RUN nextflow pull nf-core/viralrecon -r ${VIRALRECON_VERSION}
RUN microdnf install cryptsetup libseccomp runc squashfs-tools findutils which
ARG SINGULARITY_VERSION=3.10.2
RUN curl -sSL -o /tmp/singularity-ce.rpm \
    https://github.com/sylabs/singularity/releases/download/v${SINGULARITY_VERSION}/singularity-ce-${SINGULARITY_VERSION}-1.el8.x86_64.rpm && \
    rpm -i /tmp/singularity-ce.rpm && \
    rm /tmp/singularity-ce.rpm
ARG PICARD_VERSION=2.27.4
RUN mkdir -p /opt/picard && \
    curl -sSL -o /opt/picard/picard.jar \
    https://github.com/broadinstitute/picard/releases/download/${PICARD_VERSION}/picard.jar && \
    echo '#! /bin/sh' > /usr/bin/picard && \
    echo 'java -jar /opt/picard/picard.jar "$@"' >> /usr/bin/picard && \
    chmod +x /usr/bin/picard
COPY bin/poliopoly_internal /usr/bin/poliopoly
COPY refs /refs
ENTRYPOINT ["/usr/bin/poliopoly"]
