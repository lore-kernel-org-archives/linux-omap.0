From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH 06/12] arm: omap3: am35x: Add full PWRDM_POWER_INACTIVE support
Date: Wed, 11 Apr 2012 12:05:41 -0700
Message-ID: <1334171147-7517-7-git-send-email-mgreer@animalcreek.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:50313 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761021Ab2DKTsT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 15:48:19 -0400
In-Reply-To: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@ti.com, paul@pwsan.com, "Mark A. Greer" <mgreer@animalcreek.com>

From: "Mark A. Greer" <mgreer@animalcreek.com>

The am35x family of SoCs only support PWRDM_POWER_ON
and PWRDM_POWER_INACTIVE power states. This causes
an issue in some areas of the OMAP3 power-related
code because of assumptions that PWRDM_POWER_RET
and/or PWRDM_POWER_OFF are always valid states.

To get am35x SoCs to work properly, add missing support
for PWRDM_POWER_INACTIVE and remove assumptions that
PWRDM_POWER_RET and PWRDM_POWER_OFF are always valid states.

Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   29 +++++++++++++++++++++++--
 arch/arm/mach-omap2/pm-debug.c    |    8 +++++--
 arch/arm/mach-omap2/pm34xx.c      |   43 +++++++++++++++++++++++--------------
 3 files changed, 60 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 12cf81d..187872a 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -175,12 +175,23 @@ static int next_valid_state(struct cpuidle_device *dev,
 	struct cpuidle_state_usage *curr_usage = &dev->states_usage[index];
 	struct cpuidle_state *curr = &drv->states[index];
 	struct omap3_idle_statedata *cx = cpuidle_get_statedata(curr_usage);
-	u32 mpu_deepest_state = PWRDM_POWER_RET;
-	u32 core_deepest_state = PWRDM_POWER_RET;
+	u32 mpu_deepest_state;
+	u32 core_deepest_state;
 	int next_index = -1;
 
+	if (omap3_has_pwroff()) {
+		mpu_deepest_state = PWRDM_POWER_RET;
+		core_deepest_state = PWRDM_POWER_RET;
+	} else {
+		mpu_deepest_state = PWRDM_POWER_INACTIVE;
+		core_deepest_state = PWRDM_POWER_INACTIVE;
+	}
+
 	if (enable_off_mode) {
+		WARN_ON(!omap3_has_pwroff());
+
 		mpu_deepest_state = PWRDM_POWER_OFF;
+
 		/*
 		 * Erratum i583: valable for ES rev < Es1.2 on 3630.
 		 * CORE OFF mode is not supported in a stable form, restrict
@@ -311,6 +322,9 @@ void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params)
 			cpuidle_board_params[i].exit_latency;
 		cpuidle_params_table[i].target_residency =
 			cpuidle_board_params[i].target_residency;
+
+		WARN_ON(!omap3_has_pwroff() && (i >= 2) &&
+				cpuidle_params_table[i].valid);
 	}
 	return;
 }
@@ -349,6 +363,16 @@ static inline struct omap3_idle_statedata *_fill_cstate_usage(
 	return cx;
 }
 
+/* Only C1 & C2 C states valid when RET & OFF states aren't supported */
+static void omap3_cstate_valid_fixup(void)
+{
+	int idx;
+
+	if (!omap3_has_pwroff())
+		for (idx = 2; idx < OMAP3_NUM_STATES; idx++)
+			cpuidle_params_table[idx].valid = 0;
+}
+
 /**
  * omap3_idle_init - Init routine for OMAP3 idle
  *
@@ -366,6 +390,7 @@ int __init omap3_idle_init(void)
 	per_pd = pwrdm_lookup("per_pwrdm");
 	cam_pd = pwrdm_lookup("cam_pwrdm");
 
+	omap3_cstate_valid_fixup();
 
 	drv->safe_state_index = -1;
 	dev = &per_cpu(omap3_idle_dev, smp_processor_id());
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 814bcd9..339ed42 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -239,19 +239,23 @@ static int option_get(void *data, u64 *val)
 static int option_set(void *data, u64 val)
 {
 	u32 *option = data;
+	int ret = -EINVAL;
 
 	*option = val;
 
-	if (option == &enable_off_mode) {
+	if (omap3_has_pwroff() && (option == &enable_off_mode)) {
 		if (val)
 			omap_pm_enable_off_mode();
 		else
 			omap_pm_disable_off_mode();
+
 		if (cpu_is_omap34xx())
 			omap3_pm_off_mode_enable(val);
+
+		ret = 0;
 	}
 
-	return 0;
+	return ret;
 }
 
 DEFINE_SIMPLE_ATTRIBUTE(pm_dbg_option_fops, option_get, option_set, "%llu\n");
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index b7bbcee..00c4abe 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -279,6 +279,7 @@ void omap_sram_idle(void)
 	mpu_next_state = pwrdm_read_next_pwrst(mpu_pwrdm);
 	switch (mpu_next_state) {
 	case PWRDM_POWER_ON:
+	case PWRDM_POWER_INACTIVE:
 	case PWRDM_POWER_RET:
 		/* No need to save context */
 		save_state = 0;
@@ -614,6 +615,8 @@ void omap3_pm_off_mode_enable(int enable)
 	struct power_state *pwrst;
 	u32 state;
 
+	WARN_ON(!omap3_has_pwroff());
+
 	if (enable)
 		state = PWRDM_POWER_OFF;
 	else
@@ -668,7 +671,12 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 	if (!pwrst)
 		return -ENOMEM;
 	pwrst->pwrdm = pwrdm;
-	pwrst->next_state = PWRDM_POWER_RET;
+
+	if (omap3_has_pwroff())
+		pwrst->next_state = PWRDM_POWER_RET;
+	else
+		pwrst->next_state = PWRDM_POWER_INACTIVE;
+
 	list_add(&pwrst->node, &pwrst_list);
 
 	if (pwrdm_has_hdwr_sar(pwrdm))
@@ -781,25 +789,28 @@ static int __init omap3_pm_init(void)
 		omap3630_ctrl_disable_rta();
 
 	clkdm_add_wkdep(neon_clkdm, mpu_clkdm);
-	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
-		omap3_secure_ram_storage =
-			kmalloc(0x803F, GFP_KERNEL);
-		if (!omap3_secure_ram_storage)
-			pr_err("Memory allocation failed when "
-			       "allocating for secure sram context\n");
 
-		local_irq_disable();
-		local_fiq_disable();
+	if (omap3_has_pwroff()) {
+		if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
+			omap3_secure_ram_storage =
+				kmalloc(0x803F, GFP_KERNEL);
+			if (!omap3_secure_ram_storage)
+				pr_err("Memory allocation failed when "
+				       "allocating for secure sram context\n");
 
-		omap_dma_global_context_save();
-		omap3_save_secure_ram_context();
-		omap_dma_global_context_restore();
+			local_irq_disable();
+			local_fiq_disable();
 
-		local_irq_enable();
-		local_fiq_enable();
-	}
+			omap_dma_global_context_save();
+			omap3_save_secure_ram_context();
+			omap_dma_global_context_restore();
+
+			local_irq_enable();
+			local_fiq_enable();
 
-	omap3_save_scratchpad_contents();
+			omap3_save_scratchpad_contents();
+		}
+	}
 	return ret;
 
 err3:
-- 
1.7.9.4

