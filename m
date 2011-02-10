From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 0/1] omap3: pm: CM_AUTOIDLE_PLL isn't restored on wakeup from off state
Date: Thu, 10 Feb 2011 21:32:03 +0530
Message-ID: <1297353724-11665-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53426 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147Ab1BJQCU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Feb 2011 11:02:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sanjeev Premi <premi@ti.com>

The value of AUTO_PERIPH_DPLL is being lost after resuming from
the off state. More details on problem and cause in PATCH 1/1.

The problem was found recently in 2.6.32 kernel version and exists
on the latest pm branch at:
    commit 448e9a675e2cfb173fc47083058cf254ccc114a0
    Merge: c1e460d f11bdd3
    Author: Kevin Hilman <khilman@ti.com>
    Date:   Fri Jan 28 14:38:47 2011 -0800

        rebuild PM from branches

The shell script below was used to validate the patch on 2.6.32 for
over 8hrs on OMAP3EVM. The same script has been running after the
patch for past 1 hour on the same EVM.

**** test.sh ****

#!/bin/sh

if [ ! -d /dbg ]; then
	mkdir /dbg
fi

mount -t debugfs debugfs /dbg

echo 1 > /dbg/pm_debug/enable_off_mode
echo 1 > /dbg/pm_debug/sleep_while_idle
echo 5 > /dbg/pm_debug/wakeup_timer_seconds

while :
do
	before=`devmem 0x48004D30`
	echo mem > /sys/power/state
	after=`devmem 0x48004D30`

	sleep 2
	echo ""
	echo "CM_AUTOIDLE_PLL: before=$before after=$after"
	echo ""
	sleep 1
done

**** Before ****

[root@OMAP3EVM /]# ./test.sh
[   48.089172] PM: Syncing filesystems ... done.
[   48.110656] Freezing user space processes ... (elapsed 0.01 seconds) done.
[   48.135009] Freezing remaining freezable tasks ... (elapsed 0.02 seconds) done.
[   48.175598] ------------[ cut here ]------------
    [snip]...removing warning text. Not related to current context...[/snip]
[   48.421356] ---[ end trace 16d570308536c978 ]---
[   48.532165] PM: suspend of devices complete after 361.805 msecs
    [snip]...removed more verbose text...[/snip]
[   55.311767] PM: resume of devices complete after 501.922 msecs
[   55.321807] Restarting tasks ... done.

CM_AUTOIDLE_PLL: before=0x00000009 after=0x00000001

[   59.374603] PM: Syncing filesystems ... done.
[   59.380798] Freezing user space processes ... (elapsed 0.01 seconds) done.
    [snip]...removed more verbose text...[/snip]
[   65.085968] PM: resume of devices complete after 501.953 msecs
[   65.095642] Restarting tasks ... done.

CM_AUTOIDLE_PLL: before=0x00000001 after=0x00000001

[   69.148101] PM: Syncing filesystems ... done.
[   69.154235] Freezing user space processes ... (elapsed 0.01 seconds) done.
    [snip]...removed more verbose text...[/snip]
[   74.860839] PM: resume of devices complete after 501.922 msecs
[   74.870544] Restarting tasks ... done.

CM_AUTOIDLE_PLL: before=0x00000001 after=0x00000001

**** After ****

[root@OMAP3EVM /]# ./test.sh
[   60.737579] PM: Syncing filesystems ... done.
[   60.758941] Freezing user space processes ... (elapsed 0.01 seconds) done.
[   60.783233] Freezing remaining freezable tasks ... (elapsed 0.02 seconds) done.
[   60.819396] omap_device: omap_i2c.1: new worst case activate latency 0: 152587
[   60.831573] ------------[ cut here ]------------
[   60.836547] WARNING: at arch/arm/plat-omap/omap-pm-noop.c:326 omap_pm_get_dev_context_loss_count+0x64/0xb8()
    [snip]...removing warning text. Not related to current context...[/snip]
[   61.077392] ---[ end trace 79ed0d21d6b0de0a ]---
[   61.187927] omap_device: omap_i2c.1: new worst case deactivate latency 0: 61035
[   61.196136] PM: suspend of devices complete after 377.311 msecs
[   61.204650] PM: late suspend of devices complete after 2.258 msecs
[   61.211639] PM: Resume timer in 5.000 secs (163840 ticks at 32768 ticks/sec.)
[   61.219299] omap_device: omap_uart.2: new worst case deactivate latency 0: 91552
[   66.214691] Successfully put all powerdomains to target state
[   66.222106] PM: early resume of devices complete after 1.220 msecs
[   66.730926] PM: resume of devices complete after 501.983 msecs
[   66.740997] Restarting tasks ... done.
[   66.782165] omap_device: omap_uart.0: new worst case activate latency 0: 61035

CM_AUTOIDLE_PLL: before=0x00000009 after=0x00000009

[   70.794433] PM: Syncing filesystems ... done.
[   70.800598] Freezing user space processes ... (elapsed 0.01 seconds) done.
    [snip]...removed more verbose text...[/snip]
[   76.505432] PM: resume of devices complete after 501.892 msecs
[   76.515197] Restarting tasks ... done.

CM_AUTOIDLE_PLL: before=0x00000009 after=0x00000009

[   80.567687] PM: Syncing filesystems ... done.
[   80.573822] Freezing user space processes ... (elapsed 0.01 seconds) done.
    [snip]...removed more verbose text...[/snip]
[   86.272399] PM: resume of devices complete after 501.953 msecs
[   86.282165] Restarting tasks ... done.


Sanjeev Premi (1):
  omap3: Save and restore CM_AUTOIDLE_PLL across off mode

 arch/arm/mach-omap2/cm2xxx_3xxx.c |   13 +++++++++++++
 arch/arm/mach-omap2/pm34xx.c      |   25 ++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletions(-)

-- 
1.7.2.2

