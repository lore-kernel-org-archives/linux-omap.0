From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v4 8/9] OMAP3: PM: Program correct init voltages for VDD1 and VDD2
Date: Wed, 27 Oct 2010 21:40:55 +0530
Message-ID: <1288195856-11011-9-git-send-email-thara@ti.com>
References: <1288195856-11011-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38078 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759817Ab0J0QLJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Oct 2010 12:11:09 -0400
In-Reply-To: <1288195856-11011-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

By default the system boots up at nominal voltage for every
voltage domain in the system. This patch puts VDD1 and VDD2
to the correct boot up voltage as per the opp tables specified.
This patch implements this by matching the rate of the main clock
of the voltage domain with the opp table and picking up the correct
voltage.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/pm.c |   68 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 0fe905c..353e155 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/err.h>
+#include <linux/opp.h>
 
 #include <plat/omap-pm.h>
 #include <plat/omap_device.h>
@@ -20,6 +21,7 @@
 
 #include <plat/powerdomain.h>
 #include <plat/clockdomain.h>
+#include <plat/voltage.h>
 
 #include "pm.h"
 
@@ -138,6 +140,67 @@ err:
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
 static int __init omap2_common_pm_init(void)
 {
 	omap2_init_processor_devices();
@@ -145,6 +208,11 @@ static int __init omap2_common_pm_init(void)
 	if (cpu_is_omap34xx() || cpu_is_omap44xx())
 		omap_init_opp_table();
 
+	if (cpu_is_omap34xx()) {
+		omap2_set_init_voltage("mpu", "dpll1_ck", mpu_dev);
+		omap2_set_init_voltage("core", "l3_ick", l3_dev);
+	}
+
 	omap_pm_if_init();
 
 	return 0;
-- 
1.7.0.4

