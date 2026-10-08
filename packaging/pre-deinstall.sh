#!/bin/sh
# SPDX-License-Identifier: GPL-2.0-only
# SPDX-FileCopyrightText: 2026 Mono Technologies Inc.
#
# apk pre-deinstall hook for the device-limits plugin: its service stops and
# stays off, so no process outlives the package and no boot link points at
# nothing. An upgrade does not run it.
/etc/init.d/verso-plugin-qos stop 2>/dev/null
/etc/init.d/verso-plugin-qos disable 2>/dev/null
exit 0
