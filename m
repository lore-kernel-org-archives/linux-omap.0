From: Peter Barada <peterb@logicpd.com>
Subject: Question(s) regarding OMAP3 PM and PBIAS
Date: Mon, 17 Aug 2009 15:24:44 -0400
Message-ID: <1250537084.21933.174.camel@blitz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:32001 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753224AbZHQTU0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Aug 2009 15:20:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Kevin (et al),

I have a OMAP35x board that I've done a quick-n-dirty port of 2.6.31-rc5
from Kevin's PM branch (cgit ID
70a1f2249bbe765f78cf5e220e4e3f539b41eb7f), and using the rx51 as a
starting pint, added support for the Logic OMAP35x SOM, and using
omap3_pm_config defconfig (with my platform added and the others
removed).

It boots up, but I'm running into a problem with my LAN IRQ (its hooked
up to MMC1 dat0, and the external pullup is to Vio_1V8 instead of VMMC1)
and the kernel puts IRQ 312 into polled mode due to the interrupt storm
- NFSroot is pretty slow but usable.

1)  How can I set the PBIAS register to allow MMC1 dat4-7 to be 1.8V
instead of 3V that is needed for MMC1 dat0-3 - and do I have to worry
about twl_mmc1_set_power reprogramming PBIAS for those pins?

On startup, I see messages:
Platform driver 'serial8250' needs updating - please use dev_pm_ops

2) What does the message "please use dev_pm_ops" mean and how can I fix
things to suppress it?

3) When I try "echo mem > /sys/power/state", the console shows:

omap3530# echo mem > /sys/power/state
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.08 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
Suspending console(s) (use no_console_suspend to debug)
mmc0: card 133b removed
Powerdomain (mpu_pwrdm) didn't enter target state 1
Powerdomain (neon_pwrdm) didn't enter target state 1
Powerdomain (core_pwrdm) didn't enter target state 1
Powerdomain (cam_pwrdm) didn't enter target state 1
Powerdomain (dss_pwrdm) didn't enter target state 1
Powerdomain (per_pwrdm) didn't enter target state 1
Could not enter target state in pm_suspend
Restarting tasks ... done.
omap3530# mmc0: host does not support reading read-only switch. assuming
write-enable.
mmc0: new high speed SD card at address 133b
mmcblk1: mmc0:133b SD02G 1.91 GiB
mmcblk1: p1

How can I figure out why it didn't go into suspend (i.e. why the
powerdomains didn't go into target state 1)?  I noticed with CPUIDLE
enabled, turning on debug for clock/powerdomains overloads the console
with sate change messages.

-- 
Peter Barada <peterb@logicpd.com>
Logic Product Development, Inc.
