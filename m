From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] OMAP3: PM: fix save secure RAM to restore MPU power state
Date: Tue, 25 Jan 2011 16:50:11 -0800
Message-ID: <1296003011-26427-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:54721 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752733Ab1AZAvT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Jan 2011 19:51:19 -0500
Received: by pwj9 with SMTP id 9so226216pwj.7
        for <linux-omap@vger.kernel.org>; Tue, 25 Jan 2011 16:51:18 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tero Kristo <tero.kristo@nokia.com>

Currently, on HS/EMU devices, MPU power state forced to on during PM
init by the save secure RAM code.  Rather than forcing the state of
MPU powerdomain to on, simply read the current value and restore it
after the ROM code has run.

This only affects the !CPUidle case since when CPUidle is enabled, the
MPU power state is dynamically changed by CPUidle.  In the !CPUidle
case, MPU power state is initialized once at init and never touched.

Cc: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
If no objectsions, will be queued in my pm-fixes branch for 2.6.38-rc.

 arch/arm/mach-omap2/pm34xx.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 8cbbead..1916038 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -168,9 +168,10 @@ static void omap3_core_restore_context(void)
  * once during boot sequence, but this works as we are not using secure
  * services.
  */
-static void omap3_save_secure_ram_context(u32 target_mpu_state)
+static void omap3_save_secure_ram_context(void)
 {
 	u32 ret;
+	int mpu_next_state = pwrdm_read_next_pwrst(mpu_pwrdm);
 
 	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
 		/*
@@ -181,7 +182,7 @@ static void omap3_save_secure_ram_context(u32 target_mpu_state)
 		pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
 		ret = _omap_save_secure_sram((u32 *)
 				__pa(omap3_secure_ram_storage));
-		pwrdm_set_next_pwrst(mpu_pwrdm, target_mpu_state);
+		pwrdm_set_next_pwrst(mpu_pwrdm, mpu_next_state);
 		/* Following is for error tracking, it should not happen */
 		if (ret) {
 			printk(KERN_ERR "save_secure_sram() returns %08x\n",
@@ -1094,7 +1095,7 @@ static int __init omap3_pm_init(void)
 		local_fiq_disable();
 
 		omap_dma_global_context_save();
-		omap3_save_secure_ram_context(PWRDM_POWER_ON);
+		omap3_save_secure_ram_context();
 		omap_dma_global_context_restore();
 
 		local_irq_enable();
-- 
1.7.3.5

