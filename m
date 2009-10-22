From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 32/32] OMAP3: PM: Program SDRC to send self refresh on timeout of AUTO_CNT
Date: Thu, 22 Oct 2009 16:09:53 -0700
Message-ID: <1256252993-24328-33-git-send-email-khilman@deeprootsystems.com>
References: <1256252993-24328-1-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-2-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-3-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-4-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-5-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-6-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-7-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-8-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-9-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-10-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-11-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-12-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-13-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-14-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-15-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-16-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-17-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-18-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-19-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-20-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-21-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-22-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-23-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-24-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-25-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-26-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-27-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-28-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-29-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-30-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-31-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-32-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f194.google.com ([209.85.221.194]:37878 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755635AbZJVXLt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 19:11:49 -0400
Received: by mail-qy0-f194.google.com with SMTP id 32so5544712qyk.4
        for <linux-omap@vger.kernel.org>; Thu, 22 Oct 2009 16:11:54 -0700 (PDT)
In-Reply-To: <1256252993-24328-32-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Kalle Jokiniemi <kalle.jokiniemi@digia.com>

From: Rajendra Nayak <rnayak@ti.com>

Due to an OMAP3 errata (1.142), on HS/EMU devices SDRC should be
programed to issue automatic self refresh on timeout
of AUTO_CNT = 1 prior to any transition to OFF mode.
This is needed only on sil rev's ES3.0 and above.

This patch enables the above needed WA in the SDRC power register
value stored in scratchpad, so that ROM code restores this value
in SDRC POWER on the wakeup path.
The original SDRC POWER register value is stored and restored back
in omap_sram_idle() function.

This fixes some random crashes observed while stressing suspend
on HS/EMU devices.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/control.c          |   16 +++++++++++++++-
 arch/arm/mach-omap2/pm34xx.c           |   24 +++++++-----------------
 arch/arm/plat-omap/include/plat/sdrc.h |    6 ++++++
 3 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 2ff8d7c..cdd1f35 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -265,7 +265,21 @@ void omap3_save_scratchpad_contents(void)
 			(sdrc_read_reg(SDRC_ERR_TYPE) & 0xFFFF);
 	sdrc_block_contents.dll_a_ctrl = sdrc_read_reg(SDRC_DLLA_CTRL);
 	sdrc_block_contents.dll_b_ctrl = 0x0;
-	sdrc_block_contents.power = sdrc_read_reg(SDRC_POWER);
+	/*
+	 * Due to a OMAP3 errata (1.142), on EMU/HS devices SRDC should
+	 * be programed to issue automatic self refresh on timeout
+	 * of AUTO_CNT = 1 prior to any transition to OFF mode.
+	 */
+	if ((omap_type() != OMAP2_DEVICE_TYPE_GP)
+			&& (omap_rev() >= OMAP3430_REV_ES3_0))
+		sdrc_block_contents.power = (sdrc_read_reg(SDRC_POWER) &
+				~(SDRC_POWER_AUTOCOUNT_MASK|
+				SDRC_POWER_CLKCTRL_MASK)) |
+				(1 << SDRC_POWER_AUTOCOUNT_SHIFT) |
+				SDRC_SELF_REFRESH_ON_AUTOCOUNT;
+	else
+		sdrc_block_contents.power = sdrc_read_reg(SDRC_POWER);
+
 	sdrc_block_contents.cs_0 = 0x0;
 	sdrc_block_contents.mcfg_0 = sdrc_read_reg(SDRC_MCFG_0);
 	sdrc_block_contents.mr_0 = (sdrc_read_reg(SDRC_MR_0) & 0xFFFF);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 511a57d..01b95ea 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -48,12 +48,6 @@
 #include "pm.h"
 #include "sdrc.h"
 
-#define SDRC_POWER_AUTOCOUNT_SHIFT 8
-#define SDRC_POWER_AUTOCOUNT_MASK (0xffff << SDRC_POWER_AUTOCOUNT_SHIFT)
-#define SDRC_POWER_CLKCTRL_SHIFT 4
-#define SDRC_POWER_CLKCTRL_MASK (0x3 << SDRC_POWER_CLKCTRL_SHIFT)
-#define SDRC_SELF_REFRESH_ON_AUTOCOUNT (0x2 << SDRC_POWER_CLKCTRL_SHIFT)
-
 /* Scratchpad offsets */
 #define OMAP343X_TABLE_ADDRESS_OFFSET	   0x31
 #define OMAP343X_TABLE_VALUE_OFFSET	   0x30
@@ -402,19 +396,15 @@ static void omap_sram_idle(void)
 	}
 
 	/*
-	 * Force SDRAM controller to self-refresh mode after timeout on
-	 * autocount. This is needed on ES3.0 to avoid SDRAM controller
-	 * hang-ups.
-	 */
+	* On EMU/HS devices ROM code restores a SRDC value
+	* from scratchpad which has automatic self refresh on timeout
+	* of AUTO_CNT = 1 enabled. This takes care of errata 1.142.
+	* Hence store/restore the SDRC_POWER register here.
+	*/
 	if (omap_rev() >= OMAP3430_REV_ES3_0 &&
 	    omap_type() != OMAP2_DEVICE_TYPE_GP &&
-	    core_next_state == PWRDM_POWER_OFF) {
+	    core_next_state == PWRDM_POWER_OFF)
 		sdrc_pwr = sdrc_read_reg(SDRC_POWER);
-		sdrc_write_reg((sdrc_pwr &
-			~(SDRC_POWER_AUTOCOUNT_MASK|SDRC_POWER_CLKCTRL_MASK)) |
-			(1 << SDRC_POWER_AUTOCOUNT_SHIFT) |
-			SDRC_SELF_REFRESH_ON_AUTOCOUNT, SDRC_POWER);
-	}
 
 	/*
 	 * omap3_arm_context is the location where ARM registers
@@ -424,7 +414,7 @@ static void omap_sram_idle(void)
 	_omap_sram_idle(omap3_arm_context, save_state);
 	cpu_init();
 
-	/* Restore normal SDRAM settings */
+	/* Restore normal SDRC POWER settings */
 	if (omap_rev() >= OMAP3430_REV_ES3_0 &&
 	    omap_type() != OMAP2_DEVICE_TYPE_GP &&
 	    core_next_state == PWRDM_POWER_OFF)
diff --git a/arch/arm/plat-omap/include/plat/sdrc.h b/arch/arm/plat-omap/include/plat/sdrc.h
index 772b71e..f704030 100644
--- a/arch/arm/plat-omap/include/plat/sdrc.h
+++ b/arch/arm/plat-omap/include/plat/sdrc.h
@@ -44,6 +44,12 @@
 #define SDRC_RFR_CTRL_1		0x0D4
 #define SDRC_MANUAL_1		0x0D8
 
+#define SDRC_POWER_AUTOCOUNT_SHIFT	8
+#define SDRC_POWER_AUTOCOUNT_MASK	(0xffff << SDRC_POWER_AUTOCOUNT_SHIFT)
+#define SDRC_POWER_CLKCTRL_SHIFT	4
+#define SDRC_POWER_CLKCTRL_MASK		(0x3 << SDRC_POWER_CLKCTRL_SHIFT)
+#define SDRC_SELF_REFRESH_ON_AUTOCOUNT	(0x2 << SDRC_POWER_CLKCTRL_SHIFT)
+
 /*
  * These values represent the number of memory clock cycles between
  * autorefresh initiation.  They assume 1 refresh per 64 ms (JEDEC), 8192
-- 
1.6.4.3

