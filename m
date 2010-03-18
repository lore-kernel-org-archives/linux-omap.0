From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv2 06/17] OMAP3: PM: Correcting API names in samrtreflex driver.
Date: Thu, 18 Mar 2010 14:45:44 +0530
Message-ID: <1268903755-4151-7-git-send-email-thara@ti.com>
References: <1268903755-4151-1-git-send-email-thara@ti.com>
 <1268903755-4151-2-git-send-email-thara@ti.com>
 <1268903755-4151-3-git-send-email-thara@ti.com>
 <1268903755-4151-4-git-send-email-thara@ti.com>
 <1268903755-4151-5-git-send-email-thara@ti.com>
 <1268903755-4151-6-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47866 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751027Ab0CRJQJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Mar 2010 05:16:09 -0400
In-Reply-To: <1268903755-4151-6-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, nm@ti.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch corrects typo in some of the API names in smartreflex driver.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c      |    8 ++++----
 arch/arm/mach-omap2/smartreflex.c |   26 +++++++++++++-------------
 arch/arm/mach-omap2/smartreflex.h |    8 ++++----
 3 files changed, 21 insertions(+), 21 deletions(-)

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
index 5ea671b..c0345e7 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -537,7 +537,7 @@ static void sr_disable(struct omap_sr *sr)
 }
 
 
-void sr_start_vddautocomap(int srid, unsigned long volt)
+void sr_start_vddautocomp(int srid, unsigned long volt)
 {
 	struct omap_sr *sr = _sr_lookup(srid);
 
@@ -559,9 +559,9 @@ void sr_start_vddautocomap(int srid, unsigned long volt)
 			sr_clk_disable(sr);
 	}
 }
-EXPORT_SYMBOL(sr_start_vddautocomap);
+EXPORT_SYMBOL(sr_start_vddautocomp);
 
-int sr_stop_vddautocomap(int srid)
+int sr_stop_vddautocomp(int srid)
 {
 	struct omap_sr *sr = _sr_lookup(srid);
 
@@ -582,9 +582,9 @@ int sr_stop_vddautocomap(int srid)
 		return false;
 
 }
-EXPORT_SYMBOL(sr_stop_vddautocomap);
+EXPORT_SYMBOL(sr_stop_vddautocomp);
 
-void enable_smartreflex(int srid)
+void omap_smartreflex_enable(int srid)
 {
 	unsigned long curr_volt = 0;
 	struct omap_sr *sr = _sr_lookup(srid);
@@ -618,7 +618,7 @@ void enable_smartreflex(int srid)
 	}
 }
 
-void disable_smartreflex(int srid)
+void omap_smartreflex_disable(int srid)
 {
 	u32 i = 0;
 	struct omap_sr *sr = _sr_lookup(srid);
@@ -693,7 +693,7 @@ int sr_voltagescale_vcbypass(u32 target_opp, u32 current_opp,
 	current_opp_no = get_opp_no(current_opp);
 
 	if (vdd == VDD1_OPP) {
-		sr_status = sr_stop_vddautocomap(SR1);
+		sr_status = sr_stop_vddautocomp(SR1);
 		t2_smps_steps = abs(target_vsel - current_vsel);
 
 		prm_rmw_mod_reg_bits(OMAP3430_VC_CMD_ON_MASK,
@@ -703,7 +703,7 @@ int sr_voltagescale_vcbypass(u32 target_opp, u32 current_opp,
 		reg_addr = R_VDD1_SR_CONTROL;
 
 	} else if (vdd == VDD2_OPP) {
-		sr_status = sr_stop_vddautocomap(SR2);
+		sr_status = sr_stop_vddautocomp(SR2);
 		t2_smps_steps =  abs(target_vsel - current_vsel);
 
 		prm_rmw_mod_reg_bits(OMAP3430_VC_CMD_ON_MASK,
@@ -751,9 +751,9 @@ int sr_voltagescale_vcbypass(u32 target_opp, u32 current_opp,
 
 		volt = (target_vsel * 12500) + 600000;
 		if (vdd == VDD1_OPP)
-			sr_start_vddautocomap(SR1, volt);
+			sr_start_vddautocomp(SR1, volt);
 		else if (vdd == VDD2_OPP)
-			sr_start_vddautocomap(SR2, volt);
+			sr_start_vddautocomp(SR2, volt);
 	}
 
 	return 0;
@@ -784,7 +784,7 @@ static int omap_sr_autocomp_store(void *data, u64 val)
 		return 0;
 	}
 	if (val == 0) {
-		sr_stop_vddautocomap(sr_info->srid);
+		sr_stop_vddautocomp(sr_info->srid);
 	} else {
 		unsigned long curr_volt;
 
@@ -792,7 +792,7 @@ static int omap_sr_autocomp_store(void *data, u64 val)
 			curr_volt = get_curr_vdd1_voltage();
 		else
 			curr_volt = get_curr_vdd2_voltage();
-		sr_start_vddautocomap(sr_info->srid, curr_volt);
+		sr_start_vddautocomp(sr_info->srid, curr_volt);
 	}
 	return 0;
 }
@@ -839,7 +839,7 @@ static int __devexit omap_smartreflex_remove(struct platform_device *pdev)
 
 	/* Disable Autocompensation if enabled before removing the module */
 	if (sr_info->is_autocomp_active == 1)
-		sr_stop_vddautocomap(sr_info->srid);
+		sr_stop_vddautocomp(sr_info->srid);
 	list_del(&sr_info->node);
 	kfree(sr_info);
 
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index cab66a4..365a21d 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -286,11 +286,11 @@ struct omap_smartreflex_data {
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
 static inline void enable_smartreflex(int srid) {}
 static inline void disable_smartreflex(int srid) {}
-- 
1.7.0.rc1.33.g07cf0f

