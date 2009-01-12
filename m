From: Peter Barada <peterb@logicpd.com>
Subject: Suspend/Resume questions
Date: Mon, 12 Jan 2009 12:11:22 -0500
Message-ID: <1231780282.21812.194.camel@blackhole>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:33481 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753009AbZALRLY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Jan 2009 12:11:24 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>


I'm using the current PM branch (2.6.28-rc8, revision 2beb9b4b) to
investigate power consumption on an OMAP35x board (Logic's LV SOM).

When I:

# mount -t vfat /dev/mmc0blkp1 /mnt/sdcard
# echo mem > /sys/power/state
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.00 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
omapfb omapfb: timeout waiting for FRAME DONE
mmc0: card 133b removed
MMC: killing requests for dead queue
cpufreq: suspend failed to assert current frequency is what timing core
thinks it is.
Powerdomain (iva2_pwrdm) didn't enter target state 1
Powerdomain (core_pwrdm) didn't enter target state 1
Powerdomain (per_pwrdm) didn't enter target state 1
Could not enter target state in pm_suspend
cpufreq: resume failed to assert current frequency is what timing core
thinks it is.

eth0: link down
soc-audio soc-audio: scheduling resume work
Restarting tasks ...
soc-audio soc-audio: starting resume work
soc-audio soc-audio: resume work completed
done.
omap3530# mmc0: new high speed SD card at address 133b
mmcblk1: mmc0:133b SD02G 1.91 GiB 
 mmcblk1: p1
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1

omap3530# ls -l /dev/mmcblk0*
ls: /dev/mmcblk0*: No such file or directory
omap3530# 

1) Is "echo mem > /sys/power/state" the proper method to put the board
into suspend?

2) Why does the MMC "move" from /dev/mmcblk0 before the suspend
to /dev/mmcblk1 after the suspend? (If the card is not mounted, it
doesn't "move").

3) Any ideas why the iva2, core, per power domains not change states to
PWRDM_POWER_RET?  Any way to find out?

4) Any suggestions on how to code the power button (attached to TWL4030
PWRON pin) to wake it back up again?

Thanks in advance!

-- 
Peter Barada <peterb@logicpd.com>
