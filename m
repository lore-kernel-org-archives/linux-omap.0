From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 4/6] Enable SDRAM auto-refresh during sleep
Date: Tue, 14 Oct 2008 15:23:29 +0300
Message-ID: <1223987011-25667-5-git-send-email-tero.kristo@nokia.com>
References: <>
 <1223987011-25667-1-git-send-email-tero.kristo@nokia.com>
 <1223987011-25667-2-git-send-email-tero.kristo@nokia.com>
 <1223987011-25667-3-git-send-email-tero.kristo@nokia.com>
 <1223987011-25667-4-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:26850 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754864AbYJNKh4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 06:37:56 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9EAbpIP023100
	for <linux-omap@vger.kernel.org>; Tue, 14 Oct 2008 05:37:55 -0500
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m9EAbjLw000373
	for <linux-omap@vger.kernel.org>; Tue, 14 Oct 2008 13:37:51 +0300
In-Reply-To: <1223987011-25667-4-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Fix for ES3.0 bug: SDRC not sending auto-refresh when OMAP wakes-up from OFF
mode (warning for HS devices.)

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index d5892c5..513c4bf 100755
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -46,6 +46,11 @@
 
 #define OMAP3430_PRM_RSTST      \
 	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0058)
+#define SDRC_POWER_AUTOCOUNT_SHIFT 8
+#define SDRC_POWER_AUTOCOUNT_MASK (0xffff << SDRC_POWER_AUTOCOUNT_SHIFT)
+#define SDRC_POWER_CLKCTRL_SHIFT 4
+#define SDRC_POWER_CLKCTRL_MASK (0x3 << SDRC_POWER_CLKCTRL_SHIFT)
+#define SDRC_SELF_REFRESH_ON_AUTOCOUNT (0x2 << SDRC_POWER_CLKCTRL_SHIFT)
 
 u32 context_mem[128];
 
@@ -349,12 +354,34 @@ void omap_sram_idle(void)
 		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
 	}
 
+	/*
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
 	*(scratchpad_restore_addr) = restore_pointer_address;
 
 	_omap_sram_idle(context_mem, save_state);
 
 	*(scratchpad_restore_addr) = 0x0;
 
+	/* Restore normal SDRAM settings */
+	if (system_rev >= OMAP3430_REV_ES3_0 &&
+	    omap_type() != OMAP2_DEVICE_TYPE_GP &&
+	    core_next_state == PWRDM_POWER_OFF) {
+		sdrc_write_reg(sdrc_pwr, SDRC_POWER);
+       }
+
 	/* Restore table entry modified during MMU restoration */
 	if (pwrdm_read_prev_pwrst(mpu_pwrdm) == 0x0)
 		restore_table_entry();
-- 
1.5.4.3

