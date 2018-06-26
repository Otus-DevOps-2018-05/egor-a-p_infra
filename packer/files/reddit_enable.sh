#!/bin/bash

mv /tmp/reddit.service /etc/systemd/system/reddit.service

systemctl enable reddit
systemctl start reddit
