From: Paolo Pisati <p.pisati@gmail.com>
Subject: omap4, panda: 3.11, dtb and wifi
Date: Fri, 13 Sep 2013 17:36:02 +0200
Message-ID: <20130913153602.GA17111@luxor.wired.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:37939 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754987Ab3IMPgG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Sep 2013 11:36:06 -0400
Received: by mail-ee0-f46.google.com with SMTP id c13so658891eek.33
        for <linux-omap@vger.kernel.org>; Fri, 13 Sep 2013 08:36:05 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

i know we switched to dtb-only booting, but what's happened to wifi?

3.5.x:
flag@flag-desktop:~$ ls -la /sys/bus/platform/devices/wl12xx/
total 0
drwxr-xr-x 5 root root    0 set 13 17:26 .
drwxr-xr-x 4 root root    0 set 13 17:26 ..
-rw-r--r-- 1 root root 4096 set 13 17:28 bt_coex_state
lrwxrwxrwx 1 root root    0 set 13 17:27 driver -> ../../../../../../../../bus/platform/drivers/wl12xx_driver
-r-------- 1 root root    0 set 13 17:28 fwlog
-r--r--r-- 1 root root 4096 set 13 17:28 hw_pg_ver
drwxr-xr-x 3 root root    0 set 13 17:27 ieee80211
-r--r--r-- 1 root root 4096 set 13 17:28 modalias
drwxr-xr-x 3 root root    0 set 13 17:27 net
drwxr-xr-x 2 root root    0 set 13 17:28 power
lrwxrwxrwx 1 root root    0 set 13 17:27 subsystem -> ../../../../../../../../bus/platform
-rw-r--r-- 1 root root 4096 set 13 17:26 uevent

3.11.x:
flag@flag-desktop:~$ ls -la /sys/bus/platform/devices/wl*
ls: cannot access /sys/bus/platform/devices/wl*: No such file or directory

-- 
bye,
p.
