From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v6 10/10] OMAP3: PM: Program correct init voltages for VDD1 and VDD2
Date: Mon, 20 Dec 2010 22:29:17 +0530
Message-ID: <1292864357-13939-11-git-send-email-thara@ti.com>
References: <1292864357-13939-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37657 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932876Ab0LTQ7l (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Dec 2010 11:59:41 -0500
In-Reply-To: <1292864357-13939-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, nm@ti.com, Thara Gopinath <thara@ti.com>

By default the system boots up at nominal voltage for every
voltage domain in the system. This patch puts VDD1 and VDD2
to the correct boot up voltage as per the opp tables specified.
This patch implements this by matching the rate of the main clock
of the voltage domain with the opp table and picking up the correct
voltage.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/pm.c |   76 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index e84f46b..cee86a5 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/err.h>
+#include <linux/opp.h>
 
 #include <plat/omap-pm.h>
 #include <plat/omap_device.h>
@@ -138,6 +139,76 @@ err:
 	return ret;
 }
 
+/*
+ * This API is to be called during init to put the various voltage
+ * domains to the voltage as per the opp table. Typically we boot up
+ * at the nominal voltage. So this function finds out the rate of
+ * the clock associated with the voltage domain, finds out the correct
+ * opp entry and puts the voltage domain to the voltage specifies
+ * in the opp entry
+ */
+static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
+						struct device *dev)
+{
+	struct voltagedomain *voltdm;
+	struct clk *clk;
+	struct opp *opp;
+	unsigned long freq, bootup_volt;
+
+	if (!vdd_name || !clk_name || !dev) {
+		printk(KERN_ERR "%s: Invalid parameters!\n", __func__);
+		goto exit;
+	}
+
+	voltdm = omap_voltage_domain_lookup(vdd_name);
+	if (IS_ERR(voltdm)) {
+		printk(KERN_ERR "%s: Unable to get vdd pointer for vdd_%s\n",
+			__func__, vdd_name);
+		goto exit;
+	}
+
+	clk =  clk_get(NULL, clk_name);
+	if (IS_ERR(clk)) {
+		printk(KERN_ERR "%s: unable to get clk %s\n",
+			__func__, clk_name);
+		goto exit;
+	}
+
+	freq = clk->rate;
+	clk_put(clk);
+
+	opp = opp_find_freq_ceil(dev, &freq);
+	if (IS_ERR(opp)) {
+		printk(KERN_ERR "%s: unable to find boot up OPP for vdd_%s\n",
+			__func__, vdd_name);
+		goto exit;
+	}
+
+	bootup_volt = opp_get_voltage(opp);
+	if (!bootup_volt) {
+		printk(KERN_ERR "%s: unable to find voltage corresponding"
+			"to the bootup OPP for vdd_%s\n", __func__, vdd_name);
+		goto exit;
+	}
+
+	omap_voltage_scale_vdd(voltdm, bootup_volt);
+	return 0;
+
+exit:
+	printk(KERN_ERR "%s: Unable to put vdd_%s to its init voltage\n\n",
+		__func__, vdd_name);
+	return -EINVAL;
+}
+
+static void __init omap3_init_voltages(void)
+{
+	if (!cpu_is_omap34xx())
+		return;
+
+	omap2_set_init_voltage("mpu", "dpll1_ck", mpu_dev);
+	omap2_set_init_voltage("core", "l3_ick", l3_dev);
+}
+
 static int __init omap2_common_pm_init(void)
 {
 	omap2_init_processor_devices();
@@ -151,8 +222,13 @@ static int __init omap2_common_pm_late_init(void)
 {
 	/* Init the OMAP TWL parameters */
 	omap3_twl_init();
+
 	/* Init the voltage layer */
 	omap_voltage_late_init();
+
+	/* Initialize the voltages */
+	omap3_init_voltages();
+
 	/* Smartreflex device init */
 	omap_devinit_smartreflex();
 
-- 
1.7.0.4

