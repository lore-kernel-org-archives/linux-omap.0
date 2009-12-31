From: Romit Dasgupta <romit@ti.com>
Subject: [PATCH 7/10] OPP layer and additional cleanups
Date: Thu, 31 Dec 2009 18:59:25 +0530
Message-ID: <1262266165.20175.183.camel@boson>
Reply-To: romit@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42133 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbZLaN3c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Dec 2009 08:29:32 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, nm@ti.com, khilman@deeprootsystems.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Adapted the OMAP3 specific PM layer with the new OPP layer. The following
have been done
    1. Remove struct omap_opp_def and use only struct omap_opp as the previous
       was almost similar to struct omap_opp.
    2. Introduce a function 'get_l3_target_freq' to obtain the L3 frequency
       corresponding to MPU frequency.(This needs to be done neatly). I agree
       that this is ugly.
    3. Defined a voltage scaling registration function.
    4. Invoke the new OPP layer APIs for registering OPPs.

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 9744a35..04265f5 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -113,7 +113,7 @@ static struct prm_setup_vc prm_setup = {
 	.vdd1_off = 0x00,	/* 0.6v */
 };
 
-static struct omap_opp_def __initdata omap34xx_mpu_rate_table[] = {
+static struct omap_opp __initdata omap34xx_mpu_rate_table[] = {
 	/* OPP1 */
 	OMAP_OPP_DEF(true, 125000000, 975000),
 	/* OPP2 */
@@ -128,7 +128,7 @@ static struct omap_opp_def __initdata omap34xx_mpu_rate_table[] = {
 	OMAP_OPP_DEF(0, 0, 0)
 };
 
-static struct omap_opp_def __initdata omap34xx_l3_rate_table[] = {
+static struct omap_opp __initdata omap34xx_l3_rate_table[] = {
 	/* OPP1 */
 	OMAP_OPP_DEF(false, 0, 975000),
 	/* OPP2 */
@@ -139,7 +139,7 @@ static struct omap_opp_def __initdata omap34xx_l3_rate_table[] = {
 	OMAP_OPP_DEF(0, 0, 0)
 };
 
-static struct omap_opp_def __initdata omap34xx_dsp_rate_table[] = {
+static struct omap_opp __initdata omap34xx_dsp_rate_table[] = {
 	/* OPP1 */
 	OMAP_OPP_DEF(true, 90000000, 975000),
 	/* OPP2 */
@@ -154,7 +154,7 @@ static struct omap_opp_def __initdata omap34xx_dsp_rate_table[] = {
 	OMAP_OPP_DEF(0, 0, 0)
 };
 
-static struct omap_opp_def __initdata omap36xx_mpu_rate_table[] = {
+static struct omap_opp __initdata omap36xx_mpu_rate_table[] = {
 	/* OPP1 - OPP50 */
 	OMAP_OPP_DEF(true,  300000000, 930000),
 	/* OPP2 - OPP100 */
@@ -167,7 +167,7 @@ static struct omap_opp_def __initdata omap36xx_mpu_rate_table[] = {
 	OMAP_OPP_DEF(0, 0, 0)
 };
 
-static struct omap_opp_def __initdata omap36xx_l3_rate_table[] = {
+static struct omap_opp __initdata omap36xx_l3_rate_table[] = {
 	/* OPP1 - OPP50 */
 	OMAP_OPP_DEF(true, 100000000, 930000),
 	/* OPP2 - OPP100, OPP-Turbo, OPP-SB */
@@ -176,7 +176,7 @@ static struct omap_opp_def __initdata omap36xx_l3_rate_table[] = {
 	OMAP_OPP_DEF(0, 0, 0)
 };
 
-static struct omap_opp_def __initdata omap36xx_dsp_rate_table[] = {
+static struct omap_opp __initdata omap36xx_dsp_rate_table[] = {
 	/* OPP1 - OPP50 */
 	OMAP_OPP_DEF(true,  260000000, 930000),
 	/* OPP2 - OPP100 */
@@ -189,6 +189,27 @@ static struct omap_opp_def __initdata omap36xx_dsp_rate_table[] = {
 	OMAP_OPP_DEF(0, 0, 0)
 };
 
+/*
+ *XXX: !!! Ugly Alert !!!
+ * Need this info from hw_mods or equivalent.
+ */
+unsigned long get_l3_target_freq(struct omap_opp *opp)
+{
+	if (cpu_is_omap3630()) {
+		if (opp_to_freq(opp) >= 600000000)
+			return 200000000;
+		else
+			return 100000000;
+	} else {
+		if (opp_to_freq(opp) >= 500000000)
+			return 166000000;
+		else
+			return 83000000;
+	}
+
+	return 0;
+}
+
 static inline void omap3_per_save_context(void)
 {
 	omap_gpio_save_context();
@@ -1107,14 +1128,6 @@ void omap3_pm_off_mode_enable(int enable)
 	else
 		state = PWRDM_POWER_RET;
 
-#ifdef CONFIG_OMAP_PM_SRF
-	resource_lock_opp(VDD1_OPP);
-	resource_lock_opp(VDD2_OPP);
-	if (resource_refresh())
-		printk(KERN_ERR "Error: could not refresh resources\n");
-	resource_unlock_opp(VDD1_OPP);
-	resource_unlock_opp(VDD2_OPP);
-#endif
 	list_for_each_entry(pwrst, &pwrst_list, node) {
 		pwrst->next_state = state;
 		set_pwrdm_state(pwrst->pwrdm, state);
@@ -1347,30 +1360,33 @@ static void __init configure_vc(void)
 
 void __init omap3_pm_init_opp_table(void)
 {
-	int i;
-	struct omap_opp_def **omap3_opp_def_list;
-	struct omap_opp_def *omap34xx_opp_def_list[] = {
+	int i, entries;
+	struct omap_opp **omap3_opp_def_list;
+	struct omap_opp *omap34xx_opp_def_list[] = {
 		omap34xx_mpu_rate_table,
 		omap34xx_l3_rate_table,
 		omap34xx_dsp_rate_table
 	};
-	struct omap_opp_def *omap36xx_opp_def_list[] = {
+	struct omap_opp *omap36xx_opp_def_list[] = {
 		omap36xx_mpu_rate_table,
 		omap36xx_l3_rate_table,
 		omap36xx_dsp_rate_table
 	};
-	struct omap_opp **omap3_rate_tables[] = {
-		&mpu_opps,
-		&dsp_opps,
-		&l3_opps
-	};
 
 	omap3_opp_def_list = cpu_is_omap3630() ? omap36xx_opp_def_list :
 				omap34xx_opp_def_list;
-	for (i = 0; i < ARRAY_SIZE(omap3_rate_tables); i++) {
-		*omap3_rate_tables[i] = opp_init_list(omap3_opp_def_list[i]);
+
+	entries = cpu_is_omap3630() ? ARRAY_SIZE(omap36xx_opp_def_list) :
+			ARRAY_SIZE(omap34xx_opp_def_list);
+
+	for (i = 0; i < entries; i++) {
+		int ret;
+		/*
+		 * Alert!! Careful with the order of the rate table entries.
+		 */
+		ret = create_opp_list(i + 1, omap3_opp_def_list[i]);
 		/* We dont want half configured system at the moment */
-		BUG_ON(IS_ERR(omap3_rate_tables[i]));
+		BUG_ON(ret);
 	}
 }
 
@@ -1384,6 +1400,17 @@ static int __init omap3_pm_early_init(void)
 	return 0;
 }
 
+/* static DEFINE_SPINLOCK(scale_fn_lock); */
+volt_scale_t voltage_scale;
+int pm_register_volt_scaling(volt_scale_t fn)
+{
+	/* The lock may be unnecessary right now */
+	/* spinlock_irq(&scale_fn_lock); */
+	voltage_scale = fn;
+	/* spin_unlock_irq(&scale_fn_lock); */
+	return 0;
+}
+
 arch_initcall(omap3_pm_early_init);
 late_initcall(omap3_pm_init);
 


