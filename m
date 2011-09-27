From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v3 3/6] OMAP2+: pm: Use hwmod name instead of dev pointer
Date: Tue, 27 Sep 2011 19:18:03 +0200
Message-ID: <1317143886-13285-4-git-send-email-b-cousson@ti.com>
References: <1317143886-13285-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58360 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997Ab1I0RS7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Sep 2011 13:18:59 -0400
In-Reply-To: <1317143886-13285-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

Replace the struct device parameter of omap2_set_init_voltage
by the hwmod name. It will avoid having to store explicitely
the device pointer into a static variable.
Moreover, it will be a little bit more scalable if we introduce
new DVFS devices.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/pm.c |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index e7cd794..f852e4f 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -169,18 +169,26 @@ err:
  * in the opp entry
  */
 static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
-						struct device *dev)
+					 const char *oh_name)
 {
 	struct voltagedomain *voltdm;
 	struct clk *clk;
 	struct opp *opp;
 	unsigned long freq, bootup_volt;
+	struct device *dev;
 
-	if (!vdd_name || !clk_name || !dev) {
+	if (!vdd_name || !clk_name || !oh_name) {
 		printk(KERN_ERR "%s: Invalid parameters!\n", __func__);
 		goto exit;
 	}
 
+	dev = omap_device_get_by_hwmod_name(oh_name);
+	if (IS_ERR(dev)) {
+		pr_err("%s: Unable to get dev pointer for hwmod %s\n",
+			__func__, oh_name);
+		goto exit;
+	}
+
 	voltdm = omap_voltage_domain_lookup(vdd_name);
 	if (IS_ERR(voltdm)) {
 		printk(KERN_ERR "%s: Unable to get vdd pointer for vdd_%s\n",
@@ -226,8 +234,8 @@ static void __init omap3_init_voltages(void)
 	if (!cpu_is_omap34xx())
 		return;
 
-	omap2_set_init_voltage("mpu", "dpll1_ck", mpu_dev);
-	omap2_set_init_voltage("core", "l3_ick", l3_dev);
+	omap2_set_init_voltage("mpu", "dpll1_ck", "mpu");
+	omap2_set_init_voltage("core", "l3_ick", "l3_main");
 }
 
 static void __init omap4_init_voltages(void)
@@ -235,9 +243,9 @@ static void __init omap4_init_voltages(void)
 	if (!cpu_is_omap44xx())
 		return;
 
-	omap2_set_init_voltage("mpu", "dpll_mpu_ck", mpu_dev);
-	omap2_set_init_voltage("core", "l3_div_ck", l3_dev);
-	omap2_set_init_voltage("iva", "dpll_iva_m5x2_ck", iva_dev);
+	omap2_set_init_voltage("mpu", "dpll_mpu_ck", "mpu");
+	omap2_set_init_voltage("core", "l3_div_ck", "l3_main_1");
+	omap2_set_init_voltage("iva", "dpll_iva_m5x2_ck", "iva");
 }
 
 static int __init omap2_common_pm_init(void)
-- 
1.7.0.4

