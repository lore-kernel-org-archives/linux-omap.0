From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH] PM OMAP3: Change omap3_save_secure_ram to be called only during init
Date: Fri, 12 Dec 2008 11:20:05 +0200
Message-ID: <1229073605-24235-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:42174 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbYLLJ0Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Dec 2008 04:26:16 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mBC9PrDH024578
	for <linux-omap@vger.kernel.org>; Fri, 12 Dec 2008 11:26:13 +0200
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id mBC9Q7eF025871
	for <linux-omap@vger.kernel.org>; Fri, 12 Dec 2008 11:26:07 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This function is now called only once during the initialization of the device
and consequent sleep cycles will re-use the same saved contents for secure
RAM. Users who need secure services should do secure RAM saving before
entering off-mode, if a secure service has been accessed after last save.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 4223622..b8cf5f2 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -127,6 +127,12 @@ static void omap3_core_restore_context(void)
 	omap_dma_global_context_restore();
 }
 
+/*
+ * FIXME: This function should be called before entering off-mode after
+ * OMAP3 secure services have been accessed. Currently it is only called
+ * once during boot sequence, but this works as we are not using secure
+ * services.
+ */
 static void omap3_save_secure_ram_context(u32 target_mpu_state)
 {
 	u32 ret;
@@ -349,7 +355,6 @@ void omap_sram_idle(void)
 					     OMAP3_PRM_VOLTCTRL_OFFSET);
 			omap3_core_save_context();
 			omap3_prcm_save_context();
-			omap3_save_secure_ram_context(mpu_next_state);
 		}
 		/* Enable IO-PAD wakeup */
 		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
@@ -923,6 +928,18 @@ int __init omap3_pm_init(void)
 	}
 	omap3_save_scratchpad_contents();
 
+	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
+		local_irq_disable();
+		local_fiq_disable();
+
+		omap_dma_global_context_save();
+		omap3_save_secure_ram_context(PWRDM_POWER_ON);
+		omap_dma_global_context_restore();
+
+		local_irq_enable();
+		local_fiq_enable();
+	}
+
 err1:
 	return ret;
 err2:
-- 
1.5.4.3

