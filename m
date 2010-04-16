From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv3 06/22] OMAP3: PM: Correcting API names in samrtreflex driver.
Date: Fri, 16 Apr 2010 14:33:01 +0530
Message-ID: <1271408597-3066-7-git-send-email-thara@ti.com>
References: <1271408597-3066-1-git-send-email-thara@ti.com>
 <1271408597-3066-2-git-send-email-thara@ti.com>
 <1271408597-3066-3-git-send-email-thara@ti.com>
 <1271408597-3066-4-git-send-email-thara@ti.com>
 <1271408597-3066-5-git-send-email-thara@ti.com>
 <1271408597-3066-6-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40664 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757146Ab0DPJDc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 05:03:32 -0400
In-Reply-To: <1271408597-3066-6-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch corrects typo in some of the API names in smartreflex driver. It
also renames enable_smartreflex, disable_smartreflex APIs to
omap_smartreflex_enable and omap_smartreflex_disable to be
more consistent with rest of the API's in the driver code.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c      |    8 ++++----
 arch/arm/mach-omap2/smartreflex.c |   26 +++++++++++++-------------
 arch/arm/mach-omap2/smartreflex.h |   12 ++++++------
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index b51b461..9777ab2 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -430,9 +430,9 @@ void omap_sram_idle(void)
 	 * Only needed if we are going to enter retention or off.
 	 */
 	if (mpu_next_state <= PWRDM_POWER_RET)
-		disable_smartreflex(SR1);
+		omap_smartreflex_disable(SR1);
 	if (core_next_state <= PWRDM_POWER_RET)
-		disable_smartreflex(SR2);
+		omap_smartreflex_disable(SR2);
 
 	/* CORE */
 	if (core_next_state < PWRDM_POWER_ON) {
@@ -531,9 +531,9 @@ void omap_sram_idle(void)
 	 * retention or off
 	 */
 	if (mpu_next_state <= PWRDM_POWER_RET)
-		enable_smartreflex(SR1);
+		omap_smartreflex_enable(SR1);
 	if (core_next_state <= PWRDM_POWER_RET)
-		enable_smartreflex(SR2);
+		omap_smartreflex_enable(SR2);
 
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 669f1bb..359f7ec 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -540,7 +540,7 @@ static void sr_disable(struct omap_sr *sr)
 }
 
 
-void sr_start_vddautocomap(int srid, unsigned long volt)
+void sr_start_vddautocomp(int srid, unsigned long volt)
 {
 	struct omap_sr *sr = _sr_lookup(srid);
 
@@ -562,9 +562,9 @@ void sr_start_vddautocomap(int srid, unsigned long volt)
 			sr_clk_disable(sr);
 	}
 }
-EXPORT_SYMBOL(sr_start_vddautocomap);
+EXPORT_SYMBOL(sr_start_vddautocomp);
 
-int sr_stop_vddautocomap(int srid)
+int sr_stop_vddautocomp(int srid)
 {
 	struct omap_sr *sr = _sr_lookup(srid);
 
@@ -585,9 +585,9 @@ int sr_stop_vddautocomap(int srid)
 		return false;
 
 }
-EXPORT_SYMBOL(sr_stop_vddautocomap);
+EXPORT_SYMBOL(sr_stop_vddautocomp);
 
-void enable_smartreflex(int srid)
+void omap_smartreflex_enable(int srid)
 {
 	unsigned long curr_volt = 0;
 	struct omap_sr *sr = _sr_lookup(srid);
@@ -621,7 +621,7 @@ void enable_smartreflex(int srid)
 	}
 }
 
-void disable_smartreflex(int srid)
+void omap_smartreflex_disable(int srid)
 {
 	u32 i = 0;
 	struct omap_sr *sr = _sr_lookup(srid);
@@ -696,7 +696,7 @@ int sr_voltagescale_vcbypass(u32 target_opp, u32 current_opp,
 	current_opp_no = get_opp_no(current_opp);
 
 	if (vdd == VDD1_OPP) {
-		sr_status = sr_stop_vddautocomap(SR1);
+		sr_status = sr_stop_vddautocomp(SR1);
 		t2_smps_steps = abs(target_vsel - current_vsel);
 
 		prm_rmw_mod_reg_bits(OMAP3430_VC_CMD_ON_MASK,
@@ -706,7 +706,7 @@ int sr_voltagescale_vcbypass(u32 target_opp, u32 current_opp,
 		reg_addr = R_VDD1_SR_CONTROL;
 
 	} else if (vdd == VDD2_OPP) {
-		sr_status = sr_stop_vddautocomap(SR2);
+		sr_status = sr_stop_vddautocomp(SR2);
 		t2_smps_steps =  abs(target_vsel - current_vsel);
 
 		prm_rmw_mod_reg_bits(OMAP3430_VC_CMD_ON_MASK,
@@ -754,9 +754,9 @@ int sr_voltagescale_vcbypass(u32 target_opp, u32 current_opp,
 
 		volt = (target_vsel * 12500) + 600000;
 		if (vdd == VDD1_OPP)
-			sr_start_vddautocomap(SR1, volt);
+			sr_start_vddautocomp(SR1, volt);
 		else if (vdd == VDD2_OPP)
-			sr_start_vddautocomap(SR2, volt);
+			sr_start_vddautocomp(SR2, volt);
 	}
 
 	return 0;
@@ -787,7 +787,7 @@ static int omap_sr_autocomp_store(void *data, u64 val)
 		return 0;
 	}
 	if (val == 0) {
-		sr_stop_vddautocomap(sr_info->srid);
+		sr_stop_vddautocomp(sr_info->srid);
 	} else {
 		unsigned long curr_volt;
 
@@ -795,7 +795,7 @@ static int omap_sr_autocomp_store(void *data, u64 val)
 			curr_volt = get_curr_vdd1_voltage();
 		else
 			curr_volt = get_curr_vdd2_voltage();
-		sr_start_vddautocomap(sr_info->srid, curr_volt);
+		sr_start_vddautocomp(sr_info->srid, curr_volt);
 	}
 	return 0;
 }
@@ -840,7 +840,7 @@ static int __devexit omap_smartreflex_remove(struct platform_device *pdev)
 
 	/* Disable Autocompensation if enabled before removing the module */
 	if (sr_info->is_autocomp_active == 1)
-		sr_stop_vddautocomap(sr_info->srid);
+		sr_stop_vddautocomp(sr_info->srid);
 	list_del(&sr_info->node);
 	kfree(sr_info);
 
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index b14ba50..12c7ce0 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -315,14 +315,14 @@ struct omap_smartreflex_data {
 	int (*device_idle)(struct platform_device *pdev);
 };
 
-void enable_smartreflex(int srid);
-void disable_smartreflex(int srid);
+void omap_smartreflex_enable(int srid);
+void omap_smartreflex_disable(int srid);
 int sr_voltagescale_vcbypass(u32 t_opp, u32 c_opp, u8 t_vsel, u8 c_vsel);
-void sr_start_vddautocomap(int srid, unsigned long volt);
-int sr_stop_vddautocomap(int srid);
+void sr_start_vddautocomp(int srid, unsigned long volt);
+int sr_stop_vddautocomp(int srid);
 #else
-static inline void enable_smartreflex(int srid) {}
-static inline void disable_smartreflex(int srid) {}
+static inline void omap_smartreflex_enable(int srid) {}
+static inline void omap_smartreflex_disable(int srid) {}
 #endif
 
 #endif
-- 
1.7.0.rc1.33.g07cf0f

