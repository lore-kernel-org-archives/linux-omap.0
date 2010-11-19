From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 04/13] OMAP3: PM: Save secure RAM context before entering WFI
Date: Thu, 18 Nov 2010 19:54:49 -0600
Message-ID: <1290131698-6194-5-git-send-email-nm@ti.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51914 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756964Ab0KSBzC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Nov 2010 20:55:02 -0500
In-Reply-To: <1290131698-6194-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin <khilman@deeprootsystems.com>, Jean Pihet <jean.pihet@newoldbits.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

From: Tero Kristo <tero.kristo@nokia.com>

Currently this is done during initialization. move this to just before
wfi call in omap_sram_idle.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   35 ++++++++++++++---------------------
 1 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 633b696..ba85e9c 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -77,6 +77,8 @@ static int (*_omap_save_secure_sram)(u32 *addr);
 static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
 static struct powerdomain *core_pwrdm, *per_pwrdm;
 static struct powerdomain *cam_pwrdm;
+static int secure_ram_save_status;
+static int secure_ram_saved;
 
 static inline void omap3_per_save_context(void)
 {
@@ -182,30 +184,22 @@ int __init omap3_secure_copy_data_set(struct omap3_secure_copy_data *data)
 /*
  * FIXME: This function should be called before entering off-mode after
  * OMAP3 secure services have been accessed. Currently it is only called
- * once during boot sequence, but this works as we are not using secure
+ * once during first OFF transition, but this works as we are not using secure
  * services.
  */
 static void omap3_save_secure_ram_context(u32 target_mpu_state)
 {
-	u32 ret;
-
-	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
+	if (!secure_ram_saved && omap_type() != OMAP2_DEVICE_TYPE_GP) {
 		/*
 		 * MPU next state must be set to POWER_ON temporarily,
 		 * otherwise the WFI executed inside the ROM code
 		 * will hang the system.
 		 */
 		pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
-		ret = _omap_save_secure_sram((u32 *)
+		secure_ram_save_status = _omap_save_secure_sram((u32 *)
 				__pa(omap3_secure_ram_storage));
 		pwrdm_set_next_pwrst(mpu_pwrdm, target_mpu_state);
-		/* Following is for error tracking, it should not happen */
-		if (ret) {
-			printk(KERN_ERR "save_secure_sram() returns %08x\n",
-				ret);
-			while (1)
-				;
-		}
+		secure_ram_saved = 1;
 	}
 }
 
@@ -426,6 +420,7 @@ void omap_sram_idle(void)
 		if (core_next_state == PWRDM_POWER_OFF) {
 			omap3_core_save_context();
 			omap3_prcm_save_context();
+			omap3_save_secure_ram_context(mpu_next_state);
 		}
 	}
 
@@ -498,6 +493,13 @@ void omap_sram_idle(void)
 
 	pwrdm_post_transition();
 
+	/* Check if secure RAM save failed for some reason */
+	if (secure_ram_save_status > 0) {
+		WARN(1, "secure ram save failed (%d)\n",
+			secure_ram_save_status);
+		secure_ram_save_status = 0;
+	}
+
 	omap2_clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
 }
 
@@ -1068,15 +1070,6 @@ static int __init omap3_pm_init(void)
 			printk(KERN_ERR "Memory allocation failed when"
 					"allocating for secure sram context\n");
 
-		local_irq_disable();
-		local_fiq_disable();
-
-		omap_dma_global_context_save();
-		omap3_save_secure_ram_context(PWRDM_POWER_ON);
-		omap_dma_global_context_restore();
-
-		local_irq_enable();
-		local_fiq_enable();
 	}
 
 	omap3_save_scratchpad_contents();
-- 
1.6.3.3

