From: Zumeng Chen <zumeng.chen@windriver.com>
Subject: [PATCH V3 0/3] Watchdog: OMAP3: bootstatus fix and changes for the current watchdog framework
Date: Sun, 15 Jul 2012 15:19:29 +0800
Message-ID: <1342336772-29020-1-git-send-email-zumeng.chen@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:61752 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123Ab2GOHTo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Jul 2012 03:19:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com, shubhrajyoti@ti.com, linux-watchdog@vger.kernel.org, hvaibhav@ti.com
Cc: wim@iguana.be, linux-omap@vger.kernel.org, tony@atomide.com, paul.gortmaker@windriver.com

Hello,

The following patches based on the 3.5-rc6 from Wim, which
focus on:

1. bootstatus fix for omap3,

2. omap-wdt framework update cater for the current framework
   as Shubhrajyoti comments mentioned.

V3 changes:

1. New comments updated as Kevin mentioned in the third patch;
2. 3530evm works well,
   AM33xx seems work well with the following changes:
	+   if (cpu_is_am335x())
	+       return omap2_prm_read_mod_reg(AM33XX_PRM_DEVICE_MOD,
	+           AM33XX_PRM_RSTST_OFFSET) & 0x7f;
   But since some definitions not ready for am33xx, so I don't
   give the patch, if they have been updated, feel free to take these. 

Regards,

Zumeng Chen (3):
  Watchdog: Omap: Changes for the new watchdog framework
  Watchdog: Omap: select watchdog core for framework change
  Watchdog: Omap: get the bootstatus for OMAP34xx

 arch/arm/mach-omap2/prcm.c  |    9 +-
 drivers/watchdog/Kconfig    |    1 +
 drivers/watchdog/omap_wdt.c |  342 ++++++++++++++++---------------------------
 drivers/watchdog/omap_wdt.h |    5 +
 4 files changed, 136 insertions(+), 221 deletions(-)

-- 
1.7.5.4

