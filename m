From: "Yuri Jaeger Monti" <yurijm@gmail.com>
Subject: TMPFS problem
Date: Wed, 6 Aug 2008 10:53:21 -0300
Message-ID: <65e025470808060653k6f9a5bc1pd2cdda06226cc69d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:12900 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754332AbYHFNxX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2008 09:53:23 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1757516ywe.1
        for <linux-omap@vger.kernel.org>; Wed, 06 Aug 2008 06:53:22 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello!

I can't make the system boot when compiling OMAP Kernel 2.6.26 with
tmpfs support enabled. The system hangs after loading udev and won't
enter any runlevel. When tmpfs is not enabled, udev won't start and
the system boot's fine.

....
....
VFS: Mounted root (ext3 filesystem).
Freeing init memory: 136K
INIT: version 2.86 booting
Starting the hotplug events dispatcher udevd
Synthesizing the initial hotplug events
Registered led device: d9
Registered led device: d2
Registered led device: d3
omap_rng omap_rng: OMAP Random Number Generator ver. 20
Remounting root file system...
root: mount: mount point /dev/pts does not exist
root: mount: mount point /dev/shm does not exist
Setting up IP spoofing protection: rp_filter.
Configuring network interfaces... eth0      no wireless extensions.
udhcpc (v1.9.2) started
run-parts: /etc/udhcpc.d/00avahi-autoipd exited with return code 1
NET: Registered protocol family 17
Sending discover...
Sending select for 192.168.1.109...
Lease of 192.168.1.109 obtained, lease time 86400
run-parts: /etc/udhcpc.d/00avahi-autoipd exited with return code 1
adding dns 192.168.0.2
done.
Starting portmap daemon: portmapportmap: fork: No such device.
i2c_omap i2c_omap.1: Transmit overflow
tps65010: power off button
hwclock: can't open '/dev/misc/rtc': No such file or directory
Tue Aug  5 08:18:00 UTC 2008
hwclock: can't open '/dev/misc/rtc': No such file or directory

Anyone know what am I doing wrong?

Thanks!

-- 
Yuri Jaeger Monti
