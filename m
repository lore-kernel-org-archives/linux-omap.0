From: Thara Gopinath <thara@ti.com>
Subject: [RFC 6/7] OMAP3: Update OMAP3 opp tables to contain the voltage domain and device set rate get rate info
Date: Fri,  2 Jul 2010 15:48:28 +0530
Message-ID: <1278065909-32148-7-git-send-email-thara@ti.com>
References: <1278065909-32148-1-git-send-email-thara@ti.com>
 <1278065909-32148-2-git-send-email-thara@ti.com>
 <1278065909-32148-3-git-send-email-thara@ti.com>
 <1278065909-32148-4-git-send-email-thara@ti.com>
 <1278065909-32148-5-git-send-email-thara@ti.com>
 <1278065909-32148-6-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47176 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750875Ab0GBKSk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Jul 2010 06:18:40 -0400
In-Reply-To: <1278065909-32148-6-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, p-basak2@ti.com, Thara Gopinath <thara@ti.com>

This patch updates the omap3 opp tables to contain the voltage domain
associated with the opp. This patch also introduces
omap3_mpu_set_rate, omap3_iva_set_rate, omap3_l3_set_rate,
omap3_mpu_get_rate, omap3_iva_get_rate, omap3_l3_get_rate as device
specific set rate and get rate API's for OMAP3 mpu, iva and l3_main devices
and hooks them up in the correspoinding opp table entries.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/cpufreq34xx.c |  160 +++++++++++++++++++++++++++++++------
 1 files changed, 136 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/cpufreq34xx.c b/arch/arm/mach-omap2/cpufreq34xx.c
index 1589542..1f65f7e 100644
--- a/arch/arm/mach-omap2/cpufreq34xx.c
+++ b/arch/arm/mach-omap2/cpufreq34xx.c
@@ -21,22 +21,41 @@
 
 #include <linux/module.h>
 #include <linux/err.h>
+#include <linux/cpufreq.h>
 
 #include <plat/opp.h>
 #include <plat/cpu.h>
+#include <plat/clock.h>
+#include "cm-regbits-34xx.h"
+#include "prm.h"
 #include "omap3-opp.h"
 
+static int omap3_mpu_set_rate(struct device *dev, unsigned long rate);
+static int omap3_iva_set_rate(struct device *dev, unsigned long rate);
+static int omap3_l3_set_rate(struct device *dev, unsigned long rate);
+
+static unsigned long omap3_mpu_get_rate(struct device *dev);
+static unsigned long omap3_iva_get_rate(struct device *dev);
+static unsigned long omap3_l3_get_rate(struct device *dev);
+
+struct clk *dpll1_clk, *dpll2_clk, *dpll3_clk;
+
 static struct omap_opp_def __initdata omap34xx_opp_def_list[] = {
 	/* MPU OPP1 */
-	OMAP_OPP_DEF("mpu", true, 125000000, 975000),
+	OMAP_OPP_DEF("mpu", "mpu", omap3_mpu_set_rate, omap3_mpu_get_rate,
+			true, 125000000, 975000),
 	/* MPU OPP2 */
-	OMAP_OPP_DEF("mpu", true, 250000000, 1075000),
+	OMAP_OPP_DEF("mpu", "mpu", omap3_mpu_set_rate, omap3_mpu_get_rate,
+		true, 250000000, 1075000),
 	/* MPU OPP3 */
-	OMAP_OPP_DEF("mpu", true, 500000000, 1200000),
+	OMAP_OPP_DEF("mpu", "mpu", omap3_mpu_set_rate, omap3_mpu_get_rate,
+			true, 500000000, 1200000),
 	/* MPU OPP4 */
-	OMAP_OPP_DEF("mpu", true, 550000000, 1270000),
+	OMAP_OPP_DEF("mpu", "mpu", omap3_mpu_set_rate, omap3_mpu_get_rate,
+			true, 550000000, 1270000),
 	/* MPU OPP5 */
-	OMAP_OPP_DEF("mpu", true, 600000000, 1350000),
+	OMAP_OPP_DEF("mpu", "mpu", omap3_mpu_set_rate, omap3_mpu_get_rate,
+			true, 600000000, 1350000),
 
 	/*
 	 * L3 OPP1 - 41.5 MHz is disabled because: The voltage for that OPP is
@@ -46,52 +65,141 @@ static struct omap_opp_def __initdata omap34xx_opp_def_list[] = {
 	 * impact that frequency will do to the MPU and the whole system in
 	 * general.
 	 */
-	OMAP_OPP_DEF("l3_main", false, 41500000, 975000),
+	OMAP_OPP_DEF("l3_main", "core", omap3_l3_set_rate, omap3_l3_get_rate,
+			false, 41500000, 975000),
 	/* L3 OPP2 */
-	OMAP_OPP_DEF("l3_main", true, 83000000, 1050000),
+	OMAP_OPP_DEF("l3_main", "core", omap3_l3_set_rate, omap3_l3_get_rate,
+			true, 83000000, 1050000),
 	/* L3 OPP3 */
-	OMAP_OPP_DEF("l3_main", true, 166000000, 1150000),
-
+	OMAP_OPP_DEF("l3_main", "core", omap3_l3_set_rate, omap3_l3_get_rate,
+			true, 166000000, 1150000),
 
 	/* DSP OPP1 */
-	OMAP_OPP_DEF("iva", true, 90000000, 975000),
+	OMAP_OPP_DEF("iva", "mpu", omap3_iva_set_rate, omap3_iva_get_rate,
+			true, 90000000, 975000),
 	/* DSP OPP2 */
-	OMAP_OPP_DEF("iva", true, 180000000, 1075000),
+	OMAP_OPP_DEF("iva", "mpu", omap3_iva_set_rate, omap3_iva_get_rate,
+			true, 180000000, 1075000),
 	/* DSP OPP3 */
-	OMAP_OPP_DEF("iva", true, 360000000, 1200000),
+	OMAP_OPP_DEF("iva", "mpu", omap3_iva_set_rate, omap3_iva_get_rate,
+			true, 360000000, 1200000),
 	/* DSP OPP4 */
-	OMAP_OPP_DEF("iva", true, 400000000, 1270000),
+	OMAP_OPP_DEF("iva", "mpu", omap3_iva_set_rate, omap3_iva_get_rate,
+			true, 400000000, 1270000),
 	/* DSP OPP5 */
-	OMAP_OPP_DEF("iva", true, 430000000, 1350000),
+	OMAP_OPP_DEF("iva", "mpu", omap3_iva_set_rate, omap3_iva_get_rate,
+			true, 430000000, 1350000),
 };
 static u32 omap34xx_opp_def_size = ARRAY_SIZE(omap34xx_opp_def_list);
 
 static struct omap_opp_def __initdata omap36xx_opp_def_list[] = {
 	/* MPU OPP1 - OPP50 */
-	OMAP_OPP_DEF("mpu", true,  300000000, 930000),
+	OMAP_OPP_DEF("mpu", "mpu", omap3_mpu_set_rate, omap3_mpu_get_rate,
+			true, 300000000, 930000),
 	/* MPU OPP2 - OPP100 */
-	OMAP_OPP_DEF("mpu", true,  600000000, 1100000),
+	OMAP_OPP_DEF("mpu", "mpu", omap3_mpu_set_rate, omap3_mpu_get_rate,
+			true,  600000000, 1100000),
 	/* MPU OPP3 - OPP-Turbo */
-	OMAP_OPP_DEF("mpu", false, 800000000, 1260000),
+	OMAP_OPP_DEF("mpu", "mpu", omap3_mpu_set_rate, omap3_mpu_get_rate,
+			false, 800000000, 1260000),
 	/* MPU OPP4 - OPP-SB */
-	OMAP_OPP_DEF("mpu", false, 1000000000, 1350000),
+	OMAP_OPP_DEF("mpu", "mpu", omap3_mpu_set_rate, omap3_mpu_get_rate,
+			false, 1000000000, 1350000),
 
 	/* L3 OPP1 - OPP50 */
-	OMAP_OPP_DEF("l3_main", true, 100000000, 930000),
+	OMAP_OPP_DEF("l3_main", "core", omap3_l3_set_rate, omap3_l3_get_rate,
+			true, 100000000, 930000),
 	/* L3 OPP2 - OPP100, OPP-Turbo, OPP-SB */
-	OMAP_OPP_DEF("l3_main", true, 200000000, 1137500),
+	OMAP_OPP_DEF("l3_main", "core", omap3_l3_set_rate, omap3_l3_get_rate,
+			true, 200000000, 1137500),
 
 	/* DSP OPP1 - OPP50 */
-	OMAP_OPP_DEF("iva", true,  260000000, 930000),
+	OMAP_OPP_DEF("iva", "mpu", omap3_iva_set_rate, omap3_iva_get_rate,
+			true,  260000000, 930000),
 	/* DSP OPP2 - OPP100 */
-	OMAP_OPP_DEF("iva", true,  520000000, 1100000),
+	OMAP_OPP_DEF("iva", "mpu", omap3_iva_set_rate, omap3_iva_get_rate,
+			true,  520000000, 1100000),
 	/* DSP OPP3 - OPP-Turbo */
-	OMAP_OPP_DEF("iva", false, 660000000, 1260000),
+	OMAP_OPP_DEF("iva", "mpu", omap3_iva_set_rate, omap3_iva_get_rate,
+			false, 660000000, 1260000),
 	/* DSP OPP4 - OPP-SB */
-	OMAP_OPP_DEF("iva", false, 800000000, 1350000),
+	OMAP_OPP_DEF("iva", "mpu", omap3_iva_set_rate, omap3_iva_get_rate,
+			false, 800000000, 1350000),
 };
 static u32 omap36xx_opp_def_size = ARRAY_SIZE(omap36xx_opp_def_list);
 
+static int omap3_iva_set_rate(struct device *dev, unsigned long rate)
+{
+	dev_warn(dev, "%s: Setting device rate to %ld", __func__, rate);
+	return clk_set_rate(dpll2_clk, rate);
+}
+
+static unsigned long omap3_iva_get_rate(struct device *dev)
+{
+	return dpll2_clk->rate;
+}
+
+static int omap3_mpu_set_rate(struct device *dev, unsigned long rate)
+{
+	unsigned long cur_rate = omap3_mpu_get_rate(dev);
+	int ret;
+
+#ifdef CONFIG_CPU_FREQ
+	struct cpufreq_freqs freqs_notify;
+
+	freqs_notify.old = cur_rate / 1000;
+	freqs_notify.new = rate / 1000;
+	freqs_notify.cpu = 0;
+	/* Send pre notification to CPUFreq */
+	cpufreq_notify_transition(&freqs_notify, CPUFREQ_PRECHANGE);
+#endif
+	dev_warn(dev, "%s: Setting device rate to %ld", __func__, rate);
+	ret = clk_set_rate(dpll1_clk, rate);
+	if (ret) {
+		dev_warn(dev, "%s: Unable to set rate to %ld\n",
+			__func__, rate);
+		return ret;
+	}
+
+#ifdef CONFIG_CPU_FREQ
+	/* Send a post notification to CPUFreq */
+	cpufreq_notify_transition(&freqs_notify, CPUFREQ_POSTCHANGE);
+#endif
+
+#ifndef CONFIG_CPU_FREQ
+	/*Update loops_per_jiffy if processor speed is being changed*/
+	loops_per_jiffy = compute_lpj(loops_per_jiffy,
+			cur_rate / 1000, rate / 1000);
+#endif
+	return 0;
+}
+
+static unsigned long omap3_mpu_get_rate(struct device *dev)
+{
+	return dpll1_clk->rate;
+}
+
+static int omap3_l3_set_rate(struct device *dev, unsigned long rate)
+{
+	int l3_div;
+
+	dev_warn(dev, "%s: Setting device rate to %ld", __func__, rate);
+
+	l3_div = cm_read_mod_reg(CORE_MOD, CM_CLKSEL) &
+			OMAP3430_CLKSEL_L3_MASK;
+
+	return clk_set_rate(dpll3_clk, rate * l3_div);
+}
+
+static unsigned long omap3_l3_get_rate(struct device *dev)
+{
+	int l3_div;
+
+	l3_div = cm_read_mod_reg(CORE_MOD, CM_CLKSEL) &
+			OMAP3430_CLKSEL_L3_MASK;
+	return dpll3_clk->rate / l3_div;
+}
+
 /* Temp variable to allow multiple calls */
 static u8 __initdata omap3_table_init;
 
@@ -122,6 +230,10 @@ int __init omap3_pm_init_opp_table(void)
 				opp_def->freq, opp_def->hwmod_name);
 	}
 
+	dpll1_clk = clk_get(NULL, "dpll1_ck");
+	dpll2_clk = clk_get(NULL, "dpll2_ck");
+	dpll3_clk = clk_get(NULL, "dpll3_m2_ck");
+
 	return 0;
 }
 
-- 
1.7.0.rc1.33.g07cf0f

