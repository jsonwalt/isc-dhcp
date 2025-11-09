Dynamic Host Configuration Protocol (DHCP) is a networking protocol that dynamically assigns IP addresses to each host on an organization's network. DHCP also assigns Domain Name System (DNS) addresses, subnet masks, default gateways, and an NTP server. As you are aware, this is a critical service in mid/large organizations when a network administrator wants to manage IP address space allocation. Imagine having more than 100 TCP/IP-enabled devices and wanting to manage IP address assignment; it's a boring and complex task. However, with a DHCP server, you can manage the IP address assignment to clients without error.
With this Docker container, you can create a lightweight DHCP server that can manage your organization's IP address space.
To install the ISC DHCP server, you must complete these steps:
1. Pull the Docker image from Docker Hub: sudo docker pull jsonwalt/isc-dhcp
2. Create a folder in /opt to mount the volume: mkdir /opt/dhcp-data/
3. Copy the config file to the volume: cp dhcpd.conf /opt/dhcp-data/
4. Copy VALNs configuration file: cp pool-vlanx.conf /opt/dhcp-data/
5. Create a dhcpd.leased file to log assignment logs: sudo touch /opt/dhcp-data/dhcpd.leases
6. Change the ownership: sudo chown root:root /opt/dhcp-data/*
7. Run the container: sudo docker run -d --name dhcp-server --net=host --init --cap-add=NET_ADMIN --cap-add=NET_RAW --restart unless-stopped -v /opt/dhcp-data:/data -v /opt/dhcp-logs:/var/log -e "TZ=Asia/Tehran" jsonwalt/isc-dhcp
8. Enjoy
