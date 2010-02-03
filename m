From: Mike Turquette <mturquette@gmail.com>
Subject: [RFC] OMAP3: PM: disable twl4030 sleep sequence before reboot
Date: Wed,  3 Feb 2010 13:43:25 -0600
Message-ID: <1265226207-22971-1-git-send-email-mturquette@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f198.google.com ([209.85.211.198]:33713 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932339Ab0BCTno (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Feb 2010 14:43:44 -0500
Received: by ywh36 with SMTP id 36so1626263ywh.15
        for <linux-omap@vger.kernel.org>; Wed, 03 Feb 2010 11:43:43 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

When TWL4030 power scripts are enabled, the sleep script must be
disabled before rebooting, if using DPLL3 reset.  DPLL3 reset drives
SYS_OFFMODE low, causing TWL4030 to initiate the sleep script.  This
script collapses VDD1 and VDD2 voltages, usually after the warm reset
has happened but while ROM code is executing.  In this situation MPU
watchdog typically saves the day.  This happens for every single reboot.
It has also been observed that when VDD1 and VDD2 voltages collapse the
WDT does not kick in and the system becomes irrecoverable.

[PATCH 1/2] MFD: TWL4030: introduce remove_script function 
Introduces new function to twl4030-power.c for disabling any script.
This is done by programming the start address for the specified script
to 0x3f, the END_OF_SCRIPT value.

[PATCH 2/2] OMAP3: PM: remove TWL4030 A2S script before reboot 
Calls new function introduced above from omap2_clk_prepare_for_reboot in
clock34xx.c.  So far this issue is only known to affect 3430 and 3630.
No word yet if OMAP4 and Phoenix have a similar integration issue.

 arch/arm/mach-omap2/clock34xx.c |   15 +++++++++++
 drivers/mfd/twl4030-power.c     |   50 +++++++++++++++++++++++++++++++++++++++
 include/linux/i2c/twl.h         |    1 +
 3 files changed, 66 insertions(+), 0 deletions(-)
