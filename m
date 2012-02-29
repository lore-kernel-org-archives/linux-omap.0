From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 01/13] ARM: OMAP3+: SmartReflex: use voltage domain name in device attributes
Date: Wed, 29 Feb 2012 23:33:37 +0100
Message-ID: <1330554829-11347-2-git-send-email-j-pihet@ti.com>
References: <1330554829-11347-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48113 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756530Ab2B2WeR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Feb 2012 17:34:17 -0500
Received: by mail-ww0-f44.google.com with SMTP id dr13so4173817wgb.1
        for <linux-omap@vger.kernel.org>; Wed, 29 Feb 2012 14:34:16 -0800 (PST)
In-Reply-To: <1330554829-11347-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>
Cc: balbi@ti.com, nm@ti.com, Shweta Gulati <shweta.gulati@ti.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

From: Shweta Gulati <shweta.gulati@ti.com>

To set sr ntarget values for all volt_domain,
volt_table is retrieved by doing a look_up of 'vdd_name'
field from omap_hwmod but voltage domain pointer does not
belong to omap_hwmod and is not used anywhere else.
As a part of voltage layer and SR Layer clean up volt
pointer is removed from omap_hwmod and added in dev
attributes of SR. The value of the field must match
the voltage domain names for the binding to be effective.

Tested on OMAP3630 SDP, OMAP3530 Beagleboard and
OMAP4430 SDP Board.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
Acked by: Nishanth Menon <nm@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |   17 +++++++++++++----
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |   19 ++++++++++++++++---
 arch/arm/mach-omap2/smartreflex.h            |    9 +++++++++
 arch/arm/mach-omap2/sr_device.c              |   11 +++++++----
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 --
 5 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 3c8dd92..8688960 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -29,6 +29,7 @@
 
 #include "omap_hwmod_common_data.h"
 
+#include "smartreflex.h"
 #include "prm-regbits-34xx.h"
 #include "cm-regbits-34xx.h"
 #include "wd_timer.h"
@@ -2664,6 +2665,10 @@ static struct omap_hwmod_class omap36xx_smartreflex_hwmod_class = {
 };
 
 /* SR1 */
+static struct omap_smartreflex_dev_attr sr1_dev_attr = {
+	.sensor_voltdm_name   = "mpu_iva",
+};
+
 static struct omap_hwmod_ocp_if *omap3_sr1_slaves[] = {
 	&omap3_l4_core__sr1,
 };
@@ -2672,7 +2677,6 @@ static struct omap_hwmod omap34xx_sr1_hwmod = {
 	.name		= "sr1_hwmod",
 	.class		= &omap34xx_smartreflex_hwmod_class,
 	.main_clk	= "sr1_fck",
-	.vdd_name	= "mpu_iva",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -2684,6 +2688,7 @@ static struct omap_hwmod omap34xx_sr1_hwmod = {
 	},
 	.slaves		= omap3_sr1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3_sr1_slaves),
+	.dev_attr	= &sr1_dev_attr,
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
@@ -2691,7 +2696,6 @@ static struct omap_hwmod omap36xx_sr1_hwmod = {
 	.name		= "sr1_hwmod",
 	.class		= &omap36xx_smartreflex_hwmod_class,
 	.main_clk	= "sr1_fck",
-	.vdd_name	= "mpu_iva",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -2703,9 +2707,14 @@ static struct omap_hwmod omap36xx_sr1_hwmod = {
 	},
 	.slaves		= omap3_sr1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3_sr1_slaves),
+	.dev_attr	= &sr1_dev_attr,
 };
 
 /* SR2 */
+static struct omap_smartreflex_dev_attr sr2_dev_attr = {
+	.sensor_voltdm_name	= "core",
+};
+
 static struct omap_hwmod_ocp_if *omap3_sr2_slaves[] = {
 	&omap3_l4_core__sr2,
 };
@@ -2714,7 +2723,6 @@ static struct omap_hwmod omap34xx_sr2_hwmod = {
 	.name		= "sr2_hwmod",
 	.class		= &omap34xx_smartreflex_hwmod_class,
 	.main_clk	= "sr2_fck",
-	.vdd_name	= "core",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -2726,6 +2734,7 @@ static struct omap_hwmod omap34xx_sr2_hwmod = {
 	},
 	.slaves		= omap3_sr2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3_sr2_slaves),
+	.dev_attr	= &sr2_dev_attr,
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
@@ -2733,7 +2742,6 @@ static struct omap_hwmod omap36xx_sr2_hwmod = {
 	.name		= "sr2_hwmod",
 	.class		= &omap36xx_smartreflex_hwmod_class,
 	.main_clk	= "sr2_fck",
-	.vdd_name	= "core",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -2745,6 +2753,7 @@ static struct omap_hwmod omap36xx_sr2_hwmod = {
 	},
 	.slaves		= omap3_sr2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3_sr2_slaves),
+	.dev_attr	= &sr2_dev_attr,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index ef0524c..ee3624b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -34,6 +34,7 @@
 
 #include "omap_hwmod_common_data.h"
 
+#include "smartreflex.h"
 #include "cm1_44xx.h"
 #include "cm2_44xx.h"
 #include "prm44xx.h"
@@ -3963,6 +3964,10 @@ static struct omap_hwmod_class omap44xx_smartreflex_hwmod_class = {
 };
 
 /* smartreflex_core */
+static struct omap_smartreflex_dev_attr smartreflex_core_dev_attr = {
+	.sensor_voltdm_name   = "core",
+};
+
 static struct omap_hwmod omap44xx_smartreflex_core_hwmod;
 static struct omap_hwmod_irq_info omap44xx_smartreflex_core_irqs[] = {
 	{ .irq = 19 + OMAP44XX_IRQ_GIC_START },
@@ -3999,7 +4004,6 @@ static struct omap_hwmod omap44xx_smartreflex_core_hwmod = {
 	.mpu_irqs	= omap44xx_smartreflex_core_irqs,
 
 	.main_clk	= "smartreflex_core_fck",
-	.vdd_name	= "core",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_ALWON_SR_CORE_CLKCTRL_OFFSET,
@@ -4009,9 +4013,14 @@ static struct omap_hwmod omap44xx_smartreflex_core_hwmod = {
 	},
 	.slaves		= omap44xx_smartreflex_core_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_core_slaves),
+	.dev_attr	= &smartreflex_core_dev_attr,
 };
 
 /* smartreflex_iva */
+static struct omap_smartreflex_dev_attr smartreflex_iva_dev_attr = {
+	.sensor_voltdm_name	= "iva",
+};
+
 static struct omap_hwmod omap44xx_smartreflex_iva_hwmod;
 static struct omap_hwmod_irq_info omap44xx_smartreflex_iva_irqs[] = {
 	{ .irq = 102 + OMAP44XX_IRQ_GIC_START },
@@ -4047,7 +4056,6 @@ static struct omap_hwmod omap44xx_smartreflex_iva_hwmod = {
 	.clkdm_name	= "l4_ao_clkdm",
 	.mpu_irqs	= omap44xx_smartreflex_iva_irqs,
 	.main_clk	= "smartreflex_iva_fck",
-	.vdd_name	= "iva",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_ALWON_SR_IVA_CLKCTRL_OFFSET,
@@ -4057,9 +4065,14 @@ static struct omap_hwmod omap44xx_smartreflex_iva_hwmod = {
 	},
 	.slaves		= omap44xx_smartreflex_iva_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_iva_slaves),
+	.dev_attr	= &smartreflex_iva_dev_attr,
 };
 
 /* smartreflex_mpu */
+static struct omap_smartreflex_dev_attr smartreflex_mpu_dev_attr = {
+	.sensor_voltdm_name	= "mpu",
+};
+
 static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod;
 static struct omap_hwmod_irq_info omap44xx_smartreflex_mpu_irqs[] = {
 	{ .irq = 18 + OMAP44XX_IRQ_GIC_START },
@@ -4095,7 +4108,6 @@ static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod = {
 	.clkdm_name	= "l4_ao_clkdm",
 	.mpu_irqs	= omap44xx_smartreflex_mpu_irqs,
 	.main_clk	= "smartreflex_mpu_fck",
-	.vdd_name	= "mpu",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_ALWON_SR_MPU_CLKCTRL_OFFSET,
@@ -4105,6 +4117,7 @@ static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod = {
 	},
 	.slaves		= omap44xx_smartreflex_mpu_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_mpu_slaves),
+	.dev_attr	= &smartreflex_mpu_dev_attr,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 5f35b9e..fd61498 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -152,6 +152,15 @@ struct omap_sr_pmic_data {
 	void (*sr_pmic_init) (void);
 };
 
+/**
+ * struct omap_smartreflex_dev_attr - Smartreflex Device attribute.
+ *
+ * @sensor_voltdm_name:       Name of voltdomain of SR instance
+ */
+struct omap_smartreflex_dev_attr {
+	const char      *sensor_voltdm_name;
+};
+
 #ifdef CONFIG_OMAP_SMARTREFLEX
 /*
  * The smart reflex driver supports CLASS1 CLASS2 and CLASS3 SR.
diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index 9f43fcc..6029337 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -74,6 +74,7 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
 	struct omap_sr_data *sr_data;
 	struct platform_device *pdev;
 	struct omap_volt_data *volt_data;
+	struct omap_smartreflex_dev_attr *sr_dev_attr;
 	char *name = "smartreflex";
 	static int i;
 
@@ -84,9 +85,11 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
 		return -ENOMEM;
 	}
 
-	if (!oh->vdd_name) {
+	sr_dev_attr = (struct omap_smartreflex_dev_attr *)oh->dev_attr;
+	if (!sr_dev_attr || !sr_dev_attr->sensor_voltdm_name) {
 		pr_err("%s: No voltage domain specified for %s."
-			"Cannot initialize\n", __func__, oh->name);
+				"Cannot initialize\n", __func__,
+					oh->name);
 		goto exit;
 	}
 
@@ -94,10 +97,10 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
 	sr_data->senn_mod = 0x1;
 	sr_data->senp_mod = 0x1;
 
-	sr_data->voltdm = voltdm_lookup(oh->vdd_name);
+	sr_data->voltdm = voltdm_lookup(sr_dev_attr->sensor_voltdm_name);
 	if (IS_ERR(sr_data->voltdm)) {
 		pr_err("%s: Unable to get voltage domain pointer for VDD %s\n",
-			__func__, oh->vdd_name);
+			__func__, sr_dev_attr->sensor_voltdm_name);
 		goto exit;
 	}
 
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 6470101..9e8e63d 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -484,7 +484,6 @@ struct omap_hwmod_class {
  * @main_clk: main clock: OMAP clock name
  * @_clk: pointer to the main struct clk (filled in at runtime)
  * @opt_clks: other device clocks that drivers can request (0..*)
- * @vdd_name: voltage domain name
  * @voltdm: pointer to voltage domain (filled in at runtime)
  * @masters: ptr to array of OCP ifs that this hwmod can initiate on
  * @slaves: ptr to array of OCP ifs that this hwmod can respond on
@@ -528,7 +527,6 @@ struct omap_hwmod {
 	struct omap_hwmod_opt_clk	*opt_clks;
 	char				*clkdm_name;
 	struct clockdomain		*clkdm;
-	char				*vdd_name;
 	struct omap_hwmod_ocp_if	**masters; /* connect to *_IA */
 	struct omap_hwmod_ocp_if	**slaves;  /* connect to *_TA */
 	void				*dev_attr;
-- 
1.7.5.4

