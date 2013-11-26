From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/12] ARM: OMAP2+: Remove legacy PM init
Date: Mon, 25 Nov 2013 16:14:20 -0800
Message-ID: <1385424867-27243-6-git-send-email-tony@atomide.com>
References: <1385424867-27243-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:30147 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752670Ab3KZAOf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Nov 2013 19:14:35 -0500
In-Reply-To: <1385424867-27243-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

This is no longer needed when booted with device tree.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/pm.c | 161 +----------------------------------------------
 1 file changed, 1 insertion(+), 160 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index e1b4141..cc3b00d 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -30,7 +30,6 @@
 #include "powerdomain.h"
 #include "clockdomain.h"
 #include "pm.h"
-#include "twl-common.h"
 
 /*
  * omap_pm_suspend: points to a function that does the SoC-specific
@@ -70,42 +69,6 @@ void omap_pm_get_oscillator(u32 *tstart, u32 *tshut)
 }
 #endif
 
-static int __init _init_omap_device(char *name)
-{
-	struct omap_hwmod *oh;
-	struct platform_device *pdev;
-
-	oh = omap_hwmod_lookup(name);
-	if (WARN(!oh, "%s: could not find omap_hwmod for %s\n",
-		 __func__, name))
-		return -ENODEV;
-
-	pdev = omap_device_build(oh->name, 0, oh, NULL, 0);
-	if (WARN(IS_ERR(pdev), "%s: could not build omap_device for %s\n",
-		 __func__, name))
-		return -ENODEV;
-
-	return 0;
-}
-
-/*
- * Build omap_devices for processors and bus.
- */
-static void __init omap2_init_processor_devices(void)
-{
-	_init_omap_device("mpu");
-	if (omap3_has_iva())
-		_init_omap_device("iva");
-
-	if (cpu_is_omap44xx()) {
-		_init_omap_device("l3_main_1");
-		_init_omap_device("dsp");
-		_init_omap_device("iva");
-	} else {
-		_init_omap_device("l3_main");
-	}
-}
-
 int __init omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused)
 {
 	/* XXX The usecount test is racy */
@@ -118,84 +81,6 @@ int __init omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused)
 	return 0;
 }
 
-/*
- * This API is to be called during init to set the various voltage
- * domains to the voltage as per the opp table. Typically we boot up
- * at the nominal voltage. So this function finds out the rate of
- * the clock associated with the voltage domain, finds out the correct
- * opp entry and sets the voltage domain to the voltage specified
- * in the opp entry
- */
-static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
-					 const char *oh_name)
-{
-	struct voltagedomain *voltdm;
-	struct clk *clk;
-	struct dev_pm_opp *opp;
-	unsigned long freq, bootup_volt;
-	struct device *dev;
-
-	if (!vdd_name || !clk_name || !oh_name) {
-		pr_err("%s: invalid parameters\n", __func__);
-		goto exit;
-	}
-
-	if (!strncmp(oh_name, "mpu", 3))
-		/* 
-		 * All current OMAPs share voltage rail and clock
-		 * source, so CPU0 is used to represent the MPU-SS.
-		 */
-		dev = get_cpu_device(0);
-	else
-		dev = omap_device_get_by_hwmod_name(oh_name);
-
-	if (IS_ERR(dev)) {
-		pr_err("%s: Unable to get dev pointer for hwmod %s\n",
-			__func__, oh_name);
-		goto exit;
-	}
-
-	voltdm = voltdm_lookup(vdd_name);
-	if (!voltdm) {
-		pr_err("%s: unable to get vdd pointer for vdd_%s\n",
-			__func__, vdd_name);
-		goto exit;
-	}
-
-	clk =  clk_get(NULL, clk_name);
-	if (IS_ERR(clk)) {
-		pr_err("%s: unable to get clk %s\n", __func__, clk_name);
-		goto exit;
-	}
-
-	freq = clk_get_rate(clk);
-	clk_put(clk);
-
-	rcu_read_lock();
-	opp = dev_pm_opp_find_freq_ceil(dev, &freq);
-	if (IS_ERR(opp)) {
-		rcu_read_unlock();
-		pr_err("%s: unable to find boot up OPP for vdd_%s\n",
-			__func__, vdd_name);
-		goto exit;
-	}
-
-	bootup_volt = dev_pm_opp_get_voltage(opp);
-	rcu_read_unlock();
-	if (!bootup_volt) {
-		pr_err("%s: unable to find voltage corresponding to the bootup OPP for vdd_%s\n",
-		       __func__, vdd_name);
-		goto exit;
-	}
-
-	voltdm_scale(voltdm, bootup_volt);
-	return 0;
-
-exit:
-	pr_err("%s: unable to set vdd_%s\n", __func__, vdd_name);
-	return -EINVAL;
-}
-
 #ifdef CONFIG_SUSPEND
 static int omap_pm_enter(suspend_state_t suspend_state)
 {
@@ -245,40 +130,16 @@ static const struct platform_suspend_ops omap_pm_ops = {
 
 #endif /* CONFIG_SUSPEND */
 
-static void __init omap3_init_voltages(void)
-{
-	if (!cpu_is_omap34xx())
-		return;
-
-	omap2_set_init_voltage("mpu_iva", "dpll1_ck", "mpu");
-	omap2_set_init_voltage("core", "l3_ick", "l3_main");
-}
-
-static void __init omap4_init_voltages(void)
-{
-	if (!cpu_is_omap44xx())
-		return;
-
-	omap2_set_init_voltage("mpu", "dpll_mpu_ck", "mpu");
-	omap2_set_init_voltage("core", "l3_div_ck", "l3_main_1");
-	omap2_set_init_voltage("iva", "dpll_iva_m5x2_ck", "iva");
-}
-
 static inline void omap_init_cpufreq(void)
 {
 	struct platform_device_info devinfo = { };
 
-	if (!of_have_populated_dt())
-		devinfo.name = "omap-cpufreq";
-	else
-		devinfo.name = "cpufreq-cpu0";
+	devinfo.name = "cpufreq-cpu0";
 	platform_device_register_full(&devinfo);
 }
 
 static int __init omap2_common_pm_init(void)
 {
-	if (!of_have_populated_dt())
-		omap2_init_processor_devices();
 	omap_pm_if_init();
 
 	return 0;
@@ -287,26 +148,6 @@ omap_postcore_initcall(omap2_common_pm_init);
 
 int __init omap2_common_pm_late_init(void)
 {
-	/*
-	 * In the case of DT, the PMIC and SR initialization will be done using
-	 * a completely different mechanism.
-	 * Disable this part if a DT blob is available.
-	 */
-	if (!of_have_populated_dt()) {
-
-		/* Init the voltage layer */
-		omap_pmic_late_init();
-		omap_voltage_late_init();
-
-		/* Initialize the voltages */
-		omap3_init_voltages();
-		omap4_init_voltages();
-
-		/* Smartreflex device init */
-		omap_devinit_smartreflex();
-
-	}
-
 	/* cpufreq dummy device instantiation */
 	omap_init_cpufreq();
 
-- 
1.8.1.1

