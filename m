From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: [RFC][PATCH] OMAP3: PM: Fix workaround implementation for OMAP3 errata (1.142)
Date: Wed, 29 Jul 2009 16:16:33 +0300
Message-ID: <1248873393-29503-1-git-send-email-ext-roger.quadros@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:47706 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754331AbZG2NRc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Jul 2009 09:17:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

As per errata 1.142, on EMU/HS devices, SDRC_POWER should be programmed
for automatic self-refresh before transition to OFF mode.
In the current implementation this is done in omap3_scratchpad_contents()
which is wrong, since this is the value that will be restored while
resuming from OFF mode and not while transitioning to it.

This patch implements the workaround in the correct way as per errata.

Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
---
 arch/arm/mach-omap2/control.c |   16 ++--------------
 arch/arm/mach-omap2/pm34xx.c  |   20 ++++++++++++++------
 2 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index a7159a9..0a563c8 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -272,20 +272,8 @@ void omap3_save_scratchpad_contents(void)
 			(sdrc_read_reg(SDRC_ERR_TYPE) & 0xFFFF);
 	sdrc_block_contents.dll_a_ctrl = sdrc_read_reg(SDRC_DLLA_CTRL);
 	sdrc_block_contents.dll_b_ctrl = 0x0;
-	/*
-	 * Due to a OMAP3 errata (1.142), on EMU/HS devices SRDC should
-	 * be programed to issue automatic self refresh on timeout
-	 * of AUTO_CNT = 1 prior to any transition to OFF mode.
-	 */
-	if ((omap_type() != OMAP2_DEVICE_TYPE_GP)
-			&& (omap_rev() >= OMAP3430_REV_ES3_0))
-		sdrc_block_contents.power = (sdrc_read_reg(SDRC_POWER) &
-				~(SDRC_POWER_AUTOCOUNT_MASK|
-				SDRC_POWER_CLKCTRL_MASK)) |
-				(1 << SDRC_POWER_AUTOCOUNT_SHIFT) |
-				SDRC_SELF_REFRESH_ON_AUTOCOUNT;
-	else
-		sdrc_block_contents.power = sdrc_read_reg(SDRC_POWER);
+
+	sdrc_block_contents.power = sdrc_read_reg(SDRC_POWER);
 
 	sdrc_block_contents.cs_0 = 0x0;
 	sdrc_block_contents.mcfg_0 = sdrc_read_reg(SDRC_MCFG_0);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 14f10bc..eb3c9e5 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -405,15 +405,23 @@ void omap_sram_idle(void)
 	}
 
 	/*
-	* On EMU/HS devices ROM code restores a SRDC value
-	* from scratchpad which has automatic self refresh on timeout
-	* of AUTO_CNT = 1 enabled. This takes care of errata 1.142.
-	* Hence store/restore the SDRC_POWER register here.
-	*/
+	 * Due to a OMAP3 errata (1.142), on EMU/HS devices SRDC should
+	 * be programed to issue automatic self refresh on timeout
+	 * of AUTO_CNT = 1 prior to any transition to OFF mode.
+	 */
+
 	if (omap_rev() >= OMAP3430_REV_ES3_0 &&
 	    omap_type() != OMAP2_DEVICE_TYPE_GP &&
-	    core_next_state == PWRDM_POWER_OFF)
+	    core_next_state == PWRDM_POWER_OFF) {
+
 		sdrc_pwr = sdrc_read_reg(SDRC_POWER);
+		sdrc_write_reg((sdrc_pwr &
+				~(SDRC_POWER_AUTOCOUNT_MASK|
+				SDRC_POWER_CLKCTRL_MASK)) |
+				(1 << SDRC_POWER_AUTOCOUNT_SHIFT) |
+				SDRC_SELF_REFRESH_ON_AUTOCOUNT,
+					SDRC_POWER);
+	}
 
 	if (regset_save_on_suspend)
 		pm_dbg_regset_save(1);
-- 
1.6.0.4

