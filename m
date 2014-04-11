From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 07/11] ARM: dts: Enable N900 keybaord sleep leds by
 default
Date: Thu, 10 Apr 2014 17:23:59 -0700
Message-ID: <20140411002358.GA15737@atomide.com>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
 <1397173639-29587-8-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:22092 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759303AbaDKAYH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Apr 2014 20:24:07 -0400
Content-Disposition: inline
In-Reply-To: <1397173639-29587-8-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@linaro.org>, Nishanth Menon <nm@ti.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Paul Walmsley <paul@pwsan.com>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Tero Kristo <t-kristo@ti.com>

* Tony Lindgren <tony@atomide.com> [140410 16:52]:
> On N900 there are nice LEDs that show the state of the
> sys_clkreq and sys_off_mode pins.

Here's a work in progress related twl4030 script for N900
to play with, I think it can be made more generic though.
This scales vdd_core to zero during off idle for me with
this series.

Regards,

Tony

8< ----------------------------
diff --git a/Documentation/devicetree/bindings/mfd/twl4030-power.txt b/Documentation/devicetree/bindings/mfd/twl4030-power.txt
index 8e15ec3..35b2b5f 100644
--- a/Documentation/devicetree/bindings/mfd/twl4030-power.txt
+++ b/Documentation/devicetree/bindings/mfd/twl4030-power.txt
@@ -5,7 +5,9 @@ to control the power resources, including power scripts. For now, the
 binding only supports the complete shutdown of the system after poweroff.
 
 Required properties:
-- compatible : must be "ti,twl4030-power"
+- compatible : Needs to be one of the following
+	"ti,twl4030-power-n900"
+	"ti,twl4030-power"
 
 Optional properties:
 - ti,use_poweroff: With this flag, the chip will initiates an ACTIVE-to-OFF or
diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index c5db0af..3ac2b2d 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -269,6 +269,11 @@
 		compatible = "ti,twl4030-audio";
 		ti,enable-vibra = <1>;
 	};
+
+	twl_power: power {
+		compatible = "ti,twl4030-power-n900";
+		ti,use_poweroff;
+	};
 };
 
 &twl_gpio {
diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 96162b6..d6b05eb 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -29,6 +29,7 @@
 #include <linux/i2c/twl.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <asm/mach-types.h>
 
@@ -493,7 +494,8 @@ int twl4030_remove_script(u8 flags)
 	return err;
 }
 
-static int twl4030_power_configure_scripts(struct twl4030_power_data *pdata)
+static int
+twl4030_power_configure_scripts(const struct twl4030_power_data *pdata)
 {
 	int err;
 	int i;
@@ -509,7 +511,8 @@ static int twl4030_power_configure_scripts(struct twl4030_power_data *pdata)
 	return 0;
 }
 
-static int twl4030_power_configure_resources(struct twl4030_power_data *pdata)
+static int
+twl4030_power_configure_resources(const struct twl4030_power_data *pdata)
 {
 	struct twl4030_resconfig *resconfig = pdata->resource_config;
 	int err;
@@ -541,7 +544,7 @@ void twl4030_power_off(void)
 		pr_err("TWL4030 Unable to power off\n");
 }
 
-static bool twl4030_power_use_poweroff(struct twl4030_power_data *pdata,
+static bool twl4030_power_use_poweroff(const struct twl4030_power_data *pdata,
 					struct device_node *node)
 {
 	if (pdata && pdata->use_poweroff)
@@ -553,10 +556,227 @@ static bool twl4030_power_use_poweroff(struct twl4030_power_data *pdata,
 	return false;
 }
 
+#ifdef CONFIG_OF
+
+/* Generic warm reset configuration for omap3 */
+
+static struct twl4030_ins omap3_wrst_seq[] = {
+	{MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_OFF), 2},
+	{MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_WRST), 15},
+	{MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_WRST), 15},
+	{MSG_SINGULAR(DEV_GRP_P1, 0x7, RES_STATE_WRST), 0x60},
+	{MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_ACTIVE), 2},
+	{MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_ACTIVE), 2},
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
+	{ .resource = RES_HFCLKOUT, .devgroup = DEV_GRP_P3, .type = -1,
+	  .type2 = -1 },
+	{ .resource = RES_VDD1, .devgroup = DEV_GRP_P1, .type = -1,
+	  .type2 = -1 },
+	{ .resource = RES_VDD2, .devgroup = DEV_GRP_P1, .type = -1,
+	  .type2 = -1 },
+	{ 0, 0},
+};
+
+static struct twl4030_power_data omap3_reset = {
+	.scripts		= omap3_reset_scripts,
+	.num			= ARRAY_SIZE(omap3_reset_scripts),
+	.resource_config	= omap3_rconfig,
+};
+
+/* Configuration for Nokia N900 */
+
+static struct twl4030_ins n900_sleep_on_seq[] = {
+/*
+ * Turn off everything
+ */
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, 1, 0, RES_STATE_SLEEP), 2},
+};
+
+static struct twl4030_script n900_sleep_on_script = {
+	.script = n900_sleep_on_seq,
+	.size   = ARRAY_SIZE(n900_sleep_on_seq),
+	.flags  = TWL4030_SLEEP_SCRIPT,
+};
+
+static struct twl4030_ins n900_wakeup_seq[] = {
+/*
+ * Reenable everything
+ */
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, 1, 0, RES_STATE_ACTIVE), 2},
+};
+
+static struct twl4030_script n900_wakeup_script = {
+	.script	= n900_wakeup_seq,
+	.size	= ARRAY_SIZE(n900_wakeup_seq),
+	.flags	= TWL4030_WAKEUP12_SCRIPT,
+};
+
+static struct twl4030_ins n900_wakeup_p3_seq[] = {
+/*
+ * Reenable everything
+ */
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, 1, 0, RES_STATE_ACTIVE), 2},
+};
+
+static struct twl4030_script n900_wakeup_p3_script = {
+	.script	= n900_wakeup_p3_seq,
+	.size	= ARRAY_SIZE(n900_wakeup_p3_seq),
+	.flags	= TWL4030_WAKEUP3_SCRIPT,
+};
+
+static struct twl4030_ins n900_wrst_seq[] = {
+/*
+ * Reset twl4030.
+ * Reset VDD1 regulator.
+ * Reset VDD2 regulator.
+ * Reset VPLL1 regulator.
+ * Enable sysclk output.
+ * Reenable twl4030.
+ */
+	{MSG_SINGULAR(DEV_GRP_NULL, RES_RESET, RES_STATE_OFF), 2},
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, 0, 1, RES_STATE_ACTIVE),
+		0x13},
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_PP, 0, 3, RES_STATE_OFF), 0x13},
+	{MSG_SINGULAR(DEV_GRP_NULL, RES_VDD1, RES_STATE_WRST), 0x13},
+	{MSG_SINGULAR(DEV_GRP_NULL, RES_VDD2, RES_STATE_WRST), 0x13},
+	{MSG_SINGULAR(DEV_GRP_NULL, RES_VPLL1, RES_STATE_WRST), 0x35},
+	{MSG_SINGULAR(DEV_GRP_P3, RES_HFCLKOUT, RES_STATE_ACTIVE), 2},
+	{MSG_SINGULAR(DEV_GRP_NULL, RES_RESET, RES_STATE_ACTIVE), 2},
+};
+
+static struct twl4030_script n900_wrst_script = {
+	.script = n900_wrst_seq,
+	.size   = ARRAY_SIZE(n900_wrst_seq),
+	.flags  = TWL4030_WRST_SCRIPT,
+};
+
+static struct twl4030_script *twl4030_n900_scripts[] = {
+	/* wakeup12 script should be loaded before sleep script, otherwise a
+	   board might hit retention before loading of wakeup script is
+	   completed. This can cause boot failures depending on timing issues.
+	*/
+	&n900_wakeup_script,
+	&n900_sleep_on_script,
+	&n900_wakeup_p3_script,
+	&n900_wrst_script,
+};
+
+static struct twl4030_resconfig twl4030_n900_rconfig[] = {
+	{ .resource = RES_VDD1, .devgroup = -1,
+	  .type = 1, .type2 = -1, .remap_off = RES_STATE_OFF,
+	  .remap_sleep = RES_STATE_OFF
+	},
+	{ .resource = RES_VDD2, .devgroup = -1,
+	  .type = 1, .type2 = -1, .remap_off = RES_STATE_OFF,
+	  .remap_sleep = RES_STATE_OFF
+	},
+	{ .resource = RES_VPLL1, .devgroup = -1,
+	  .type = 1, .type2 = -1, .remap_off = RES_STATE_OFF,
+	  .remap_sleep = RES_STATE_OFF
+	},
+	{ .resource = RES_VPLL2, .devgroup = -1,
+	  .type = -1, .type2 = 3, .remap_off = -1, .remap_sleep = -1
+	},
+	{ .resource = RES_VAUX1, .devgroup = -1,
+	  .type = -1, .type2 = 3, .remap_off = -1, .remap_sleep = -1
+	},
+	{ .resource = RES_VAUX2, .devgroup = -1,
+	  .type = -1, .type2 = 3, .remap_off = -1, .remap_sleep = -1
+	},
+	{ .resource = RES_VAUX3, .devgroup = -1,
+	  .type = -1, .type2 = 3, .remap_off = -1, .remap_sleep = -1
+	},
+	{ .resource = RES_VAUX4, .devgroup = -1,
+	  .type = -1, .type2 = 3, .remap_off = -1, .remap_sleep = -1
+	},
+	{ .resource = RES_VMMC1, .devgroup = -1,
+	  .type = -1, .type2 = 3, .remap_off = -1, .remap_sleep = -1
+	},
+	{ .resource = RES_VMMC2, .devgroup = -1,
+	  .type = -1, .type2 = 3, .remap_off = -1, .remap_sleep = -1
+	},
+	{ .resource = RES_VDAC, .devgroup = -1,
+	  .type = -1, .type2 = 3, .remap_off = -1, .remap_sleep = -1
+	},
+	{ .resource = RES_VSIM, .devgroup = -1,
+	  .type = -1, .type2 = 3, .remap_off = -1, .remap_sleep = -1
+	},
+	{ .resource = RES_VINTANA1, .devgroup = DEV_GRP_P1 | DEV_GRP_P3,
+	  .type = -1, .type2 = -1, .remap_off = -1, .remap_sleep = -1
+	},
+	{ .resource = RES_VINTANA2, .devgroup = DEV_GRP_P1 | DEV_GRP_P3,
+	  .type = 1, .type2 = -1, .remap_off = -1, .remap_sleep = -1
+	},
+	{ .resource = RES_VINTDIG, .devgroup = DEV_GRP_P1 | DEV_GRP_P3,
+	  .type = -1, .type2 = -1, .remap_off = -1, .remap_sleep = -1
+	},
+	{ .resource = RES_VIO, .devgroup = DEV_GRP_P3,
+	  .type = 1, .type2 = -1, .remap_off = -1, .remap_sleep = -1
+	},
+	{ .resource = RES_CLKEN, .devgroup = DEV_GRP_P1 | DEV_GRP_P3,
+	  .type = 1, .type2 = -1 , .remap_off = -1, .remap_sleep = -1
+	},
+	{ .resource = RES_REGEN, .devgroup = DEV_GRP_P1 | DEV_GRP_P3,
+	  .type = 1, .type2 = -1, .remap_off = -1, .remap_sleep = -1
+	},
+	{ .resource = RES_NRES_PWRON, .devgroup = DEV_GRP_P1 | DEV_GRP_P3,
+	  .type = 1, .type2 = -1, .remap_off = -1, .remap_sleep = -1
+	},
+	{ .resource = RES_SYSEN, .devgroup = DEV_GRP_P1 | DEV_GRP_P3,
+	  .type = 1, .type2 = -1, .remap_off = -1, .remap_sleep = -1
+	},
+	{ .resource = RES_HFCLKOUT, .devgroup = DEV_GRP_P3,
+	  .type = 1, .type2 = -1, .remap_off = -1, .remap_sleep = -1
+	},
+	{ .resource = RES_32KCLKOUT, .devgroup = -1,
+	  .type = 1, .type2 = -1, .remap_off = -1, .remap_sleep = -1
+	},
+	{ .resource = RES_RESET, .devgroup = -1,
+	  .type = 1, .type2 = -1, .remap_off = -1, .remap_sleep = -1
+	},
+	{ .resource = RES_MAIN_REF, .devgroup = -1,
+	  .type = 1, .type2 = -1, .remap_off = -1, .remap_sleep = -1
+	},
+	{ 0, 0},
+};
+
+static struct twl4030_power_data twl4030_n900 = {
+	.scripts        = twl4030_n900_scripts,
+	.num = ARRAY_SIZE(twl4030_n900_scripts),
+	.resource_config = twl4030_n900_rconfig,
+};
+
+static struct of_device_id twl4030_power_of_match[] = {
+	{
+		.compatible = "ti,twl4030-power-n900",
+		.data = &twl4030_n900,
+	},
+	{
+		.compatible = "ti,twl4030-power",
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
@@ -577,8 +797,12 @@ static int twl4030_power_probe(struct platform_device *pdev)
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
@@ -628,14 +852,6 @@ static int twl4030_power_remove(struct platform_device *pdev)
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
