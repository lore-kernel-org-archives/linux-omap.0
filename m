From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCH] i2c: omap: revert "i2c: omap: switch to threaded IRQ support"
Date: Tue, 16 Oct 2012 18:28:13 +0530
Message-ID: <CAM=Q2csHTbR4rBe1HNr5-M3sG5wgdCv6dCnGLmNQEwo1gjCSGg@mail.gmail.com>
References: <alpine.DEB.2.00.1210150148080.16624@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:45218 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255Ab2JPM6O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Oct 2012 08:58:14 -0400
In-Reply-To: <alpine.DEB.2.00.1210150148080.16624@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-i2c@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>, Wolfram Sang <w.sang@pengutronix.de>, Ben Dooks <ben-linux@fluff.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Oct 15, 2012 at 7:21 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Commit 3b2f8f82dad7d1f79cdc8fc05bd1c94baf109bde ("i2c: omap: switch to
> threaded IRQ support") causes communication with I2C devices to fail
> after system suspend/resume on all OMAP3 devices:
>
Could you tell me which  omap3 platform

On Beagle Xm
after
mount /dev/mmcblk  /mmcfs


# mount /dev/mmcblk0p2 /mmcfs/
[  412.480041] kjournald starting.  Commit interval 5 seconds
[  412.490020] EXT3-fs (mmcblk0p2): using internal journal
[  412.495605] EXT3-fs (mmcblk0p2): mounted filesystem with ordered data mode
#


# cd /mmcfs/
#
#
# ls
bin                   omap3_usb_prcm.sh     usb_prcm.sh
dev                   omap3_usbhs_off.sh    usb_uhh_show.sh
etc                   omap3_usbhs_on.sh     usb_uhh_tll.sh
init                  proc                  usbhs_clk_disable.sh
lib                   readmem.dat           usbhs_clk_enable.sh
lost+found            root                  usbhs_set_sm.sh
mnt                   sbin                  usbhs_show.sh
modules               sys                   usr
msc                   tmp                   var
omap3_ehcidump.sh     usb_omap3.sh
#
#
# echo mem > /sys/power/state
[  464.785461] PM: Syncing filesystems ... done.
[  464.791442] PM: Preparing system for mem sleep
[  464.798034] Freezing user space processes ... (elapsed 0.02 seconds) done.
[  464.827301] Freezing remaining freezable tasks ... (elapsed 0.02
seconds) done.
[  464.858703] PM: Entering mem sleep
[  464.862304] Suspending console(s) (use no_console_suspend to debug)
[  464.994415] PM: suspend of devices complete after 121.002 msecs
[  464.998107] PM: late suspend of devices complete after 3.662 msecs
[  465.003173] PM: noirq suspend of devices complete after 5.004 msecs
[  465.003173] Disabling non-boot CPUs ...
[  466.225585] Successfully put all powerdomains to target state
[  466.228942] PM: noirq resume of devices complete after 3.051 msecs
[  466.232421] PM: early resume of devices complete after 2.349 msecs
[  467.492645] PM: resume of devices complete after 1260.131 msecs
[  467.546936] PM: Finishing wakeup.
[  467.550415] Restarting tasks ... done.
#
#
# cat /debug/pm_debug/count | grep per_pwrdm
per_pwrdm (ON),OFF:7,RET:0,INA:0,ON:8,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
per_clkdm->per_pwrdm (17)
# echo mem > /sys/power/state
[ 1492.225311] PM: Syncing filesystems ... done.
[ 1492.232177] PM: Preparing system for mem sleep
[ 1492.238830] Freezing user space processes ... (elapsed 0.02 seconds) done.
[ 1492.268188] Freezing remaining freezable tasks ... (elapsed 0.02
seconds) done.
[ 1492.299804] PM: Entering mem sleep
[ 1492.303375] Suspending console(s) (use no_console_suspend to debug)
[ 1492.435333] PM: suspend of devices complete after 120.880 msecs
[ 1492.439025] PM: late suspend of devices complete after 3.692 msecs
[ 1492.444091] PM: noirq suspend of devices complete after 5.004 msecs
[ 1492.444091] Disabling non-boot CPUs ...
[ 1493.745544] Successfully put all powerdomains to target state
[ 1493.748901] PM: noirq resume of devices complete after 3.051 msecs
[ 1493.752319] PM: early resume of devices complete after 2.319 msecs
[ 1494.794067] PM: resume of devices complete after 1041.625 msecs
[ 1494.848388] PM: Finishing wakeup.
[ 1494.851867] Restarting tasks ... done.
#
#
# cat /debug/pm_debug/count | grep per_pwrdm
per_pwrdm (ON),OFF:8,RET:0,INA:0,ON:9,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
per_clkdm->per_pwrdm (17)
#

Anyways will retry with fs on mmc.
