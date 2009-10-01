From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 16/28] OMAP3: PM: Enable SDRAM auto-refresh during sleep
Date: Thu,  1 Oct 2009 16:58:46 -0700
Message-ID: <1254441538-9257-17-git-send-email-khilman@deeprootsystems.com>
References: <1254441538-9257-1-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-2-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-3-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-4-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-5-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-6-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-7-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-8-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-9-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-10-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-11-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-12-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-13-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-14-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-15-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-16-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:51872 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754907AbZJAX7Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 19:59:24 -0400
Received: by mail-px0-f179.google.com with SMTP id 9so694314pxi.4
        for <linux-omap@vger.kernel.org>; Thu, 01 Oct 2009 16:59:28 -0700 (PDT)
In-Reply-To: <1254441538-9257-16-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tero Kristo <tero.kristo@nokia.com>

From: Tero Kristo <tero.kristo@nokia.com>

Fix for ES3.0 bug: SDRC not sending auto-refresh when OMAP wakes-up from OFF
mode (warning for HS devices.)

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 8541512..5e24552 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -45,6 +45,13 @@
 
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
@@ -296,6 +303,7 @@ static void omap_sram_idle(void)
 	int per_next_state = PWRDM_POWER_ON;
 	int core_next_state = PWRDM_POWER_ON;
 	int core_prev_state, per_prev_state;
+	u32 sdrc_pwr = 0;
 
 	if (!_omap_sram_idle)
 		return;
@@ -348,6 +356,21 @@ static void omap_sram_idle(void)
 	}
 
 	/*
+	 * Force SDRAM controller to self-refresh mode after timeout on
+	 * autocount. This is needed on ES3.0 to avoid SDRAM controller
+	 * hang-ups.
+	 */
+	if (system_rev >= OMAP3430_REV_ES3_0 &&
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
@@ -355,6 +378,12 @@ static void omap_sram_idle(void)
 	_omap_sram_idle(omap3_arm_context, save_state);
 	cpu_init();
 
+	/* Restore normal SDRAM settings */
+	if (system_rev >= OMAP3430_REV_ES3_0 &&
+	    omap_type() != OMAP2_DEVICE_TYPE_GP &&
+	    core_next_state == PWRDM_POWER_OFF)
+		sdrc_write_reg(sdrc_pwr, SDRC_POWER);
+
 	/* Restore table entry modified during MMU restoration */
 	if (pwrdm_read_prev_pwrst(mpu_pwrdm) == PWRDM_POWER_OFF)
 		restore_table_entry();
-- 
1.6.4.3

