From: Peter Barada <peter.barada@logicpd.com>
Subject: linux-3.0: sporadic "illegal instruction" in init scripts
Date: Fri, 13 Apr 2012 14:13:43 -0400
Message-ID: <4F886CD7.3060402@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 174-46-170-154.static.twtelecom.net ([174.46.170.154]:43513
	"HELO edprlnx06.logicpd.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with SMTP id S1755795Ab2DMSVu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Apr 2012 14:21:50 -0400
Received: from [172.16.10.3] (unknown [172.16.10.3])
	by edprlnx06.logicpd.com (Postfix) with ESMTP id DC06560009B
	for <linux-omap@vger.kernel.org>; Fri, 13 Apr 2012 13:13:14 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I'm using linux-3.0 as released on ftp/kernel.org on an DM37x based
board, and I've run into sporadic cases where the init scripts exit with
"illegal instruction" when using a ramdisk as the rootfs:

[    9.640838] VFS: Mounted root (ext2 filesystem) on device 1:0.
[    9.647521] Freeing init memory: 240K
Mounting /proc and /sys
Starting the hotplug events dispatcher udevd
Synthesizing initial hotplug events
[   10.121917] udevd (57): /proc/57/oom_adj is deprecated, please use
/proc/57/oom_score_adj instead.
/etc/rc.d/init.d/udev: line 41:    58 Illegal instruction     udevtrigger
/etc/rc.d/init.d/udev: line 41:    59 Illegal instruction     udevsettle
--timeout=300
/etc/rc.d/init.d/udev: line 41:    60 Illegal instruction     mkdir /dev/pts
/etc/rc.d/init.d/udev: line 41:    61 Illegal instruction     mount -n
-t devpts devpts /dev/pts
/etc/rc.d/init.d/udev: line 41:    62 Illegal instruction     mkdir /dev/shm
/etc/rc.d/rcS: line 24:    63 Illegal instruction    
/etc/rc.d/init.d/$i $mode
/etc/rc.d/rcS: line 24:    64 Illegal instruction    
/etc/rc.d/init.d/$i $mode
/etc/rc.d/rcS: line 24:    65 Illegal instruction    
/etc/rc.d/init.d/$i $mode
/etc/rc.d/rcS: line 24:    66 Illegal instruction    
/etc/rc.d/init.d/$i $mode
/etc/rc.d/rcS: line 24:    67 Illegal instruction    
/etc/rc.d/init.d/$i $mode
/etc/rc.d/rcS: line 24:    68 Illegal instruction    
/etc/rc.d/init.d/$i $mode
/etc/rc.d/rcS: line 24:    69 Illegal instruction    
/etc/rc.d/init.d/$i $mode
/etc/rc.d/rcS: line 24:    70 Illegal instruction    
/etc/rc.d/init.d/$i $mode
/etc/rc.d/rcS: line 24:    71 Illegal instruction    
/etc/rc.d/init.d/$i $mode
/etc/rc.d/rcS: line 24:    72 Illegal instruction    
/etc/rc.d/init.d/$i $mode
/etc/rc.d/rcS: line 24:    73 Illegal instruction    
/etc/rc.d/init.d/$i $mode
/etc/rc.d/rcS: line 24:    74 Illegal instruction    
/etc/rc.d/init.d/$i $mode
/etc/rc.d/rcS: line 37:    75 Illegal instruction     /etc/rc.d/rc.local
$mode

If I switch to an initramfs it works fine...

I added code to arch/arm/kernel/traps.c to dump the PC on SIGILL and
determined do_undefinstr() was triggering the SIGILL signal:

[   10.103637] Freeing init memory: 240K
Mounting /proc and /sys
Starting the hotplug events dispatcher udevd
Synthesizing initial hotplug events
[   10.608764] udevd (56): /proc/56/oom_adj is deprecated, please use
/proc/56/oom_score_adj instead.
[   10.629028] do_undefinstr:376 SIGILL pc 400af000
/etc/rc.d/init.d/udev: line 41:    57 Illegal instruction     udevtrigger
[   10.659301] do_undefinstr:376 SIGILL pc 400ed000
/etc/rc.d/init.d/udev: line 41:    58 Illegal instruction     udevsettle
--timeout=300
[   10.682373] do_undefinstr:376 SIGILL pc 40037000
/etc/rc.d/init.d/udev: line 41:    59 Illegal instruction     mkdir /dev/pts
[   10.704864] do_undefinstr:376 SIGILL pc 400cc000
/etc/rc.d/init.d/udev: line 41:    60 Illegal instruction     mount -n
-t devpts devpts /dev/pts
[   10.727325] do_undefinstr:376 SIGILL pc 400eb000
/etc/rc.d/init.d/udev: line 41:    61 Illegal instruction     mkdir /dev/shm
[   10.756286] do_undefinstr:376 SIGILL pc 4004f000
/etc/rc.d/rcS: line 24:    62 Illegal instruction    
/etc/rc.d/init.d/$i $mode
[   10.780395] do_undefinstr:376 SIGILL pc 400e8000
/etc/rc.d/rcS: line 24:    63 Illegal instruction    
/etc/rc.d/init.d/$i $mode
[   10.803924] do_undefinstr:376 SIGILL pc 4001f000
/etc/rc.d/rcS: line 24:    64 Illegal instruction    
/etc/rc.d/init.d/$i $mode
[   10.827270] do_undefinstr:376 SIGILL pc 400ed000
/etc/rc.d/rcS: line 24:    65 Illegal instruction    
/etc/rc.d/init.d/$i $mode
[   10.850555] do_undefinstr:376 SIGILL pc 400e7000
/etc/rc.d/rcS: line 24:    66 Illegal instruction    
/etc/rc.d/init.d/$i $mode
[   10.874023] do_undefinstr:376 SIGILL pc 400b9000
/etc/rc.d/rcS: line 24:    67 Illegal instruction    
/etc/rc.d/init.d/$i $mode
[   10.897705] do_undefinstr:376 SIGILL pc 4007f000
/etc/rc.d/rcS: line 24:    68 Illegal instruction    
/etc/rc.d/init.d/$i $mode
[   10.920928] do_undefinstr:376 SIGILL pc 40070000
/etc/rc.d/rcS: line 24:    69 Illegal instruction    
/etc/rc.d/init.d/$i $mode
[   10.944427] do_undefinstr:376 SIGILL pc 40021000
/etc/rc.d/rcS: line 24:    70 Illegal instruction    
/etc/rc.d/init.d/$i $mode
[   10.967712] do_undefinstr:376 SIGILL pc 40047000
/etc/rc.d/rcS: line 24:    71 Illegal instruction    
/etc/rc.d/init.d/$i $mode
[   10.991455] do_undefinstr:376 SIGILL pc 400e0000
/etc/rc.d/rcS: line 24:    72 Illegal instruction    
/etc/rc.d/init.d/$i $mode
[   11.015350] do_undefinstr:376 SIGILL pc 40094000
/etc/rc.d/rcS: line 24:    73 Illegal instruction    
/etc/rc.d/init.d/$i $mode
[   11.039978] do_undefinstr:376 SIGILL pc 40106000
/etc/rc.d/rcS: line 37:    74 Illegal instruction     /etc/rc.d/rc.local
$mode
[   11.057037] do_undefinstr:376 SIGILL pc 40031000
[   12.064910] do_undefinstr:376 SIGILL pc 4010c000
[   13.071105] do_undefinstr:376 SIGILL pc 40106000
[   14.077056] do_undefinstr:376 SIGILL pc 400ef000
[   15.082885] do_undefinstr:376 SIGILL pc 40085000
[   16.089080] do_undefinstr:376 SIGILL pc 4004b000
[   17.095642] do_undefinstr:376 SIGILL pc 4002e000
[   18.101379] do_undefinstr:376 SIGILL pc 40092000
[   19.107543] do_undefinstr:376 SIGILL pc 400ec000
[   20.113433] do_undefinstr:376 SIGILL pc 40018000
[   21.119781] do_undefinstr:376 SIGILL pc 40055000

All the PC addresses look to be the first instruction of a page.  If I
switch to an initramfs (instead of a ramdisk) for the rootfs everything
looks to work.

Does this look like the instruction cache wasn't invalidated properly
(IIRC there were change to handle flushing the instruction cache during
COW operations)?
How can I dump the instruction at the user address within
do_undefinstr() to see if the the instruction looks right?
Does anyone have suggestions on how to fix this?

Its sporadic enough that modifying the kernel causes the problem to
disappear for a while (only to come back with yet another
change/addition to the kernel).

Any suggestions are appreciated!

-- 
Peter Barada
peter.barada@logicpd.com

