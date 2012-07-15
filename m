From: Zumeng Chen <zumeng.chen@windriver.com>
Subject: [PATCH v3 3/3] Watchdog: Omap: get the bootstatus for OMAP34xx
Date: Sun, 15 Jul 2012 15:19:32 +0800
Message-ID: <1342336772-29020-4-git-send-email-zumeng.chen@windriver.com>
References: <1342336772-29020-1-git-send-email-zumeng.chen@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:61758 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123Ab2GOHTv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Jul 2012 03:19:51 -0400
In-Reply-To: <1342336772-29020-1-git-send-email-zumeng.chen@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com, shubhrajyoti@ti.com, linux-watchdog@vger.kernel.org, hvaibhav@ti.com
Cc: wim@iguana.be, linux-omap@vger.kernel.org, tony@atomide.com, paul.gortmaker@windriver.com

The offset of WKUP_MOD is not right for the PRM_RSTST of OMAP3. So here
put the right one to match to the actual physical addr 0x48307258, which
defined in PRCM Registers section named as Global_Reg_PRM.

And there is a MPU_WD_RST bit in PRM_RSTST(0x48307258) holding the signal
from omap-wdt reboot, so that we can return WDIOF_CARDRESET if the board
wakes up from omap-wdt reboot for WDIOC_GETBOOTSTATUS ioctl.

Signed-off-by: Zumeng Chen <zumeng.chen@windriver.com>
---
 arch/arm/mach-omap2/prcm.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 480f40a..3ca8aa7 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -48,9 +48,14 @@ void __iomem *prcm_mpu_base;
 
 u32 omap_prcm_get_reset_sources(void)
 {
-	/* XXX This presumably needs modification for 34XX */
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
+	if (cpu_is_omap24xx())
 		return omap2_prm_read_mod_reg(WKUP_MOD, OMAP2_RM_RSTST) & 0x7f;
+
+	/* XXX This presumably needs modification for AM33XX when ready. */
+	if (cpu_is_omap34xx())
+		return omap2_prm_read_mod_reg(OMAP3430_GR_MOD, OMAP2_RM_RSTST) &
+		       0x7f;
+
 	if (cpu_is_omap44xx())
 		return omap2_prm_read_mod_reg(WKUP_MOD, OMAP4_RM_RSTST) & 0x7f;
 
-- 
1.7.5.4

