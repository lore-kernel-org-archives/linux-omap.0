From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 15/32] OMAP3: PM: Enable SDRAM auto-refresh during sleep
Date: Thu, 22 Oct 2009 16:09:36 -0700
Message-ID: <1256252993-24328-16-git-send-email-khilman@deeprootsystems.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f194.google.com ([209.85.221.194]:37878 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755193AbZJVXKs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 19:10:48 -0400
Received: by mail-qy0-f194.google.com with SMTP id 32so5544712qyk.4
        for <linux-omap@vger.kernel.org>; Thu, 22 Oct 2009 16:10:53 -0700 (PDT)
In-Reply-To: <1256252993-24328-15-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tero Kristo <tero.kristo@nokia.com>

From: Tero Kristo <tero.kristo@nokia.com>

Fix for ES3.0 bug: SDRC not sending auto-refresh when OMAP wakes-up
from OFF mode (warning for HS devices.)

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 310c189..3f1f656 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -44,6 +44,13 @@
 
 #include "prm.h"
 #include "pm.h"
+#include "sdrc.h"
+
+#define SDRC_POWER_AUTOCOUNT_SHIFT 8
+#define SDRC_POWER_AUTOCOUNT_MASK (0xffff << SDRC_POWER_AUTOCOUNT_SHIFT)
+#define SDRC_POWER_CLKCTRL_SHIFT 4
+#define SDRC_POWER_CLKCTRL_MASK (0x3 << SDRC_POWER_CLKCTRL_SHIFT)
+#define SDRC_SELF_REFRESH_ON_AUTOCOUNT (0x2 << SDRC_POWER_CLKCTRL_SHIFT)
 
 /* Scratchpad offsets */
 #define OMAP343X_TABLE_ADDRESS_OFFSET	   0x31
@@ -297,6 +304,7 @@ static void omap_sram_idle(void)
 	int per_next_state = PWRDM_POWER_ON;
 	int core_next_state = PWRDM_POWER_ON;
 	int core_prev_state, per_prev_state;
+	u32 sdrc_pwr = 0;
 
 	if (!_omap_sram_idle)
 		return;
@@ -349,6 +357,21 @@ static void omap_sram_idle(void)
 	}
 
 	/*
+	 * Force SDRAM controller to self-refresh mode after timeout on
+	 * autocount. This is needed on ES3.0 to avoid SDRAM controller
+	 * hang-ups.
+	 */
+	if (omap_rev() >= OMAP3430_REV_ES3_0 &&
+	    omap_type() != OMAP2_DEVICE_TYPE_GP &&
+	    core_next_state == PWRDM_POWER_OFF) {
+		sdrc_pwr = sdrc_read_reg(SDRC_POWER);
+		sdrc_write_reg((sdrc_pwr &
+			~(SDRC_POWER_AUTOCOUNT_MASK|SDRC_POWER_CLKCTRL_MASK)) |
+			(1 << SDRC_POWER_AUTOCOUNT_SHIFT) |
+			SDRC_SELF_REFRESH_ON_AUTOCOUNT, SDRC_POWER);
+	}
+
+	/*
 	 * omap3_arm_context is the location where ARM registers
 	 * get saved. The restore path then reads from this
 	 * location and restores them back.
@@ -356,6 +379,12 @@ static void omap_sram_idle(void)
 	_omap_sram_idle(omap3_arm_context, save_state);
 	cpu_init();
 
+	/* Restore normal SDRAM settings */
+	if (omap_rev() >= OMAP3430_REV_ES3_0 &&
+	    omap_type() != OMAP2_DEVICE_TYPE_GP &&
+	    core_next_state == PWRDM_POWER_OFF)
+		sdrc_write_reg(sdrc_pwr, SDRC_POWER);
+
 	/* Restore table entry modified during MMU restoration */
 	if (pwrdm_read_prev_pwrst(mpu_pwrdm) == PWRDM_POWER_OFF)
 		restore_table_entry();
-- 
1.6.4.3

