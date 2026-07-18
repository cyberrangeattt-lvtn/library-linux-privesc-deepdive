#!/bin/bash
# Nightly backup of application state - runs as root via cron every minute
# for this training scenario (normally would be daily).
tar czf /var/backups/app-$(date +%s).tar.gz /opt/app 2>/dev/null
