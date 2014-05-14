From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/7] mfd: twl4030-power: Add generic reset configuration
Date: Tue, 13 May 2014 18:34:06 -0700
Message-ID: <1400031250-29542-4-git-send-email-tony@atomide.com>
References: <1400031250-29542-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:44736 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752058AbaENBeV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2014 21:34:21 -0400
In-Reply-To: <1400031250-29542-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: lee.jones@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, Robert Nelson <robertcnelson@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Samuel Ortiz <sameo@linux.intel.com>

The twl4030 PMIC needs to be configured properly for things like
warm reset and deeper idle states so the PMIC manages the regulators
properly based on the hardware triggers from the SoC.

For example, when rebooting an OMAP3530 at 125 MHz, it hangs.
With this patch, TWL4030 will be reset when a warm reset occures.
This way the OMAP3530 does not hang on reboot.

Let's use this as the default when compatible = "ti,twl4030-power".
Other more complicated configurations can be added to the driver
based on other compatible flags.

Based on earlier patch by Matthias Brugger <matthias.bgg@gmail.com>:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/144165.html

And Lesly A M <leslyam@ti.com>:

https://github.com/openembedded/openembedded/blob/master/recipes/linux/linux-omap-2.6.39/mfd/0010-MFD-TWL4030-power-scripts-for-OMAP3-boards.patch

For more information about twl4030 configuration for the
"power scripts" see:

http://www.omappedia.com/wiki/TWL4030_power_scripts

Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Robert Nelson <robertcnelson@gmail.com>
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 .../devicetree/bindings/mfd/twl4030-power.txt      |  7 +-
 drivers/mfd/twl4030-power.c                        | 99 +++++++++++++++++++---
 include/linux/i2c/twl.h                            |  3 +
 3 files changed, 95 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/twl4030-power.txt b/Documentation/devicetree/bindings/mfd/twl4030-power.txt
index 8e15ec3..b906116 100644
--- a/Documentation/devicetree/bindings/mfd/twl4030-power.txt
+++ b/Documentation/devicetree/bindings/mfd/twl4030-power.txt
@@ -5,7 +5,12 @@ to control the power resources, including power scripts. For now, the
 binding only supports the complete shutdown of the system after poweroff.
 
 Required properties:
-- compatible : must be "ti,twl4030-power"
+- compatible : must be one of the following
+	"ti,twl4030-power"
+	"ti,twl4030-power-reset"
+
+The use of ti,twl4030-power-reset is recommended at least on
+3530 that needs a special configuration for warm reset to work.
 
 Optional properties:
 - ti,use_poweroff: With this flag, the chip will initiates an ACTIVE-to-OFF or
diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index c0e4fc3..b61b725 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -29,6 +29,7 @@
 #include <linux/i2c/twl.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <asm/mach-types.h>
 
@@ -128,6 +129,30 @@ static u8 res_config_addrs[] = {
 	[RES_MAIN_REF]	= 0x94,
 };
 
+/*
+ * Usable values for .remap_sleep and .remap_off
+ * Based on table "5.3.3 Resource Operating modes"
+ */
+enum {
+	TWL_REMAP_OFF = 0,
+	TWL_REMAP_SLEEP = 8,
+	TWL_REMAP_ACTIVE = 9,
+};
+
+#define TWL_RESOURCE_ON(res)						\
+	{ MSG_SINGULAR(DEV_GRP_NULL, (res), RES_STATE_ACTIVE), 0x02 }
+#define TWL_RESOURCE_OFF(res)						\
+	{ MSG_SINGULAR(DEV_GRP_NULL, (res), RES_STATE_OFF), 0x02 }
+#define TWL_RESOURCE_RESET(res)						\
+	{ MSG_SINGULAR(DEV_GRP_NULL, (res), RES_STATE_WRST), 0x02 }
+#define TWL_RESOURCE_GROUP_RESET(group, type1, type2)			\
+	{ MSG_BROADCAST(DEV_GRP_NULL, (group), (type1), (type2),	\
+		RES_STATE_WRST), 0x02 }
+#define TWL_REMAP_SLEEP(res, devgrp, typ, typ2)				\
+	{ .resource = (res), .devgroup = (devgrp),			\
+	  .type = (typ), .type2 = (typ2),				\
+	  .remap_off = TWL_REMAP_OFF, .remap_sleep = TWL_REMAP_SLEEP, }
+
 static int twl4030_write_script_byte(u8 address, u8 byte)
 {
 	int err;
@@ -502,7 +527,8 @@ int twl4030_remove_script(u8 flags)
 	return err;
 }
 
-static int twl4030_power_configure_scripts(struct twl4030_power_data *pdata)
+static int
+twl4030_power_configure_scripts(const struct twl4030_power_data *pdata)
 {
 	int err;
 	int i;
@@ -518,7 +544,8 @@ static int twl4030_power_configure_scripts(struct twl4030_power_data *pdata)
 	return 0;
 }
 
-static int twl4030_power_configure_resources(struct twl4030_power_data *pdata)
+static int
+twl4030_power_configure_resources(const struct twl4030_power_data *pdata)
 {
 	struct twl4030_resconfig *resconfig = pdata->resource_config;
 	int err;
@@ -550,7 +577,7 @@ void twl4030_power_off(void)
 		pr_err("TWL4030 Unable to power off\n");
 }
 
-static bool twl4030_power_use_poweroff(struct twl4030_power_data *pdata,
+static bool twl4030_power_use_poweroff(const struct twl4030_power_data *pdata,
 					struct device_node *node)
 {
 	if (pdata && pdata->use_poweroff)
@@ -562,10 +589,60 @@ static bool twl4030_power_use_poweroff(struct twl4030_power_data *pdata,
 	return false;
 }
 
+#ifdef CONFIG_OF
+
+/* Generic warm reset configuration for omap3 */
+
+static struct twl4030_ins omap3_wrst_seq[] = {
+	TWL_RESOURCE_OFF(RES_NRES_PWRON),
+	TWL_RESOURCE_OFF(RES_RESET),
+	TWL_RESOURCE_RESET(RES_MAIN_REF),
+	TWL_RESOURCE_GROUP_RESET(RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2),
+	TWL_RESOURCE_RESET(RES_VUSB_3V1),
+	TWL_RESOURCE_GROUP_RESET(RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R1),
+	TWL_RESOURCE_GROUP_RESET(RES_GRP_RC, RES_TYPE_ALL, RES_TYPE2_R0),
+	TWL_RESOURCE_ON(RES_RESET),
+	TWL_RESOURCE_ON(RES_NRES_PWRON),
+};
+
+static struct twl4030_script omap3_wrst_script = {
+	.script	= omap3_wrst_seq,
+	.size	= ARRAY_SIZE(omap3_wrst_seq),
+	.flags	= TWL4030_WRST_SCRIPT,
+};
+
+static struct twl4030_script *omap3_reset_scripts[] = {
+	&omap3_wrst_script,
+};
+
+static struct twl4030_resconfig omap3_rconfig[] = {
+	TWL_REMAP_SLEEP(RES_HFCLKOUT, DEV_GRP_P3, -1, -1),
+	TWL_REMAP_SLEEP(RES_VDD1, DEV_GRP_P1, -1, -1),
+	TWL_REMAP_SLEEP(RES_VDD2, DEV_GRP_P1, -1, -1),
+	{ 0, 0 },
+};
+
+static struct twl4030_power_data omap3_reset = {
+	.scripts		= omap3_reset_scripts,
+	.num			= ARRAY_SIZE(omap3_reset_scripts),
+	.resource_config	= omap3_rconfig,
+};
+
+static struct of_device_id twl4030_power_of_match[] = {
+	{
+		.compatible = "ti,twl4030-power-reset",
+		.data = &omap3_reset,
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, twl4030_power_of_match);
+#endif	/* CONFIG_OF */
+
 static int twl4030_power_probe(struct platform_device *pdev)
 {
-	struct twl4030_power_data *pdata = dev_get_platdata(&pdev->dev);
+	const struct twl4030_power_data *pdata = dev_get_platdata(&pdev->dev);
 	struct device_node *node = pdev->dev.of_node;
+	const struct of_device_id *match;
 	int err = 0;
 	int err2 = 0;
 	u8 val;
@@ -586,8 +663,12 @@ static int twl4030_power_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	match = of_match_device(of_match_ptr(twl4030_power_of_match),
+				&pdev->dev);
+	if (match && match->data)
+		pdata = match->data;
+
 	if (pdata) {
-		/* TODO: convert to device tree */
 		err = twl4030_power_configure_scripts(pdata);
 		if (err) {
 			pr_err("TWL4030 failed to load scripts\n");
@@ -637,14 +718,6 @@ static int twl4030_power_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_OF
-static const struct of_device_id twl4030_power_of_match[] = {
-	{.compatible = "ti,twl4030-power", },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, twl4030_power_of_match);
-#endif
-
 static struct platform_driver twl4030_power_driver = {
 	.driver = {
 		.name	= "twl4030_power",
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index ade1c06..5fe0313 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -486,7 +486,10 @@ static inline int twl6030_mmc_card_detect(struct device *dev, int slot)
 #define RES_GRP_ALL		0x7	/* All resource groups */
 
 #define RES_TYPE2_R0		0x0
+#define RES_TYPE2_R1		0x1
+#define RES_TYPE2_R2		0x2
 
+#define RES_TYPE_R0		0x0
 #define RES_TYPE_ALL		0x7
 
 /* Resource states */
-- 
1.8.1.1

