FROM ubuntu:24.04

# Install isc-dhcp-server and rsyslog
RUN apt update && \
    apt upgrade -y && \
    apt install -y isc-dhcp-server rsyslog && \
    rm -rf /var/lib/apt/lists/*

# Configure rsyslog to log to /var/log/syslog
RUN echo '$ModLoad imuxsock' > /etc/rsyslog.conf && \
    echo '$OmitLocalLogging off' >> /etc/rsyslog.conf && \
    echo '*.info;mail.none;authpriv.none;cron.none /var/log/syslog' >> /etc/rsyslog.conf && \
    echo 'daemon.* /var/log/dhcp.log' >> /etc/rsyslog.conf  # Optional: Separate DHCP logs

# Expose the data volume for configs and leases
VOLUME /data

# Create an entrypoint script to start rsyslog and dhcpd
RUN echo '#!/bin/bash' > /entrypoint.sh && \
    echo 'rsyslogd -n &' >> /entrypoint.sh && \
    echo 'exec dhcpd -f -cf /data/dhcpd.conf -lf /data/dhcpd.leases' >> /entrypoint.sh && \
    chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
