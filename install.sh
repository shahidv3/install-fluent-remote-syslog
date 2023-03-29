#!/bin/bash

# Install dependencies
sudo yum install -y gcc make automake autoconf libtool zlib-devel openssl-devel libcurl-devel

# Install td-agent package
sudo yum install -y td-agent

# Install fluent-plugin-remote-syslog gem
sudo /usr/sbin/td-agent-gem install fluent-plugin-remote-syslog

# Configure remote syslog plugin
cat << EOF | sudo tee /etc/td-agent/td-agent.conf > /dev/null
<match your_log_tag>
  @type remote_syslog
  host your_remote_syslog_host
  port your_remote_syslog_port
  severity info
  program your_program_name
  hostname your_hostname
  protocol udp
  <buffer>
    flush_thread_count 4
  </buffer>
</match>
EOF

# Restart td-agent service
sudo systemctl restart td-agent
