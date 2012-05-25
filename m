From: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Subject: Re: [RFC PATCH 00/11] OMAP System Control Module
Date: Fri, 25 May 2012 16:21:08 +0400
Message-ID: <4FBF7934.9000608@dev.rtsoft.ru>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com> <4FBF63E7.3070605@dev.rtsoft.ru> <CAGF5oy_76y=8Cj=1YjhQAo_JvUb8T5K6E7PoWAkDWULjJXuGSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:55941 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751362Ab2EYMVo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 May 2012 08:21:44 -0400
In-Reply-To: <CAGF5oy_76y=8Cj=1YjhQAo_JvUb8T5K6E7PoWAkDWULjJXuGSg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valentin, Eduardo" <eduardo.valentin@ti.com>
Cc: b-cousson@ti.com, kishon@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com, balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org, Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>

  Hi.

On 05/25/2012 03:11 PM, Valentin, Eduardo wrote:
> Konstantin,
>
> On Fri, May 25, 2012 at 1:50 PM, Konstantin Baydarov
> <kbaidarov@dev.rtsoft.ru> wrote:
>>  Hi.
>>
>> On 05/25/2012 12:25 PM, Eduardo Valentin wrote:
>>> Hello Paul and Tony,
>>>
>>> This is a series of patches adding a basic support for system control module,
>>> on OMAP4+ context. It is a working in progress, but I wanted to share already
>>> to get your feedback.
>>>
>>> I've modeled the driver as an MFD. You will see in this series:
>>> . A rework of the system control module header (patch from Santosh, picked from the list)
>>> . Device creation for control module core
>>> . Early device creation for control module core
>>> . The MFD core driver for system control module
>>> . The MFD child for usb-phy pin control
>>> . The MFD child for bandgap sensor
>>> . Very early exposure of OMAP4 thermal zone
>>> . All added drivers are only supporting DT probing
>>> . The series is based on linux-omap master, as it has the hwmod entries for SCM.
>>>
>>> The overall idea of this series is to put in place the infrastructure. It is
>>> not touching nor removing the existing APIs under mach-omap2/control.c for now.
>>> But the target is to have these APIs moved to the MFD core driver.
>>>
>>> For early access, like ID checking, I have written the platform driver
>>> as an early platform driver and you will see also early device addition
>>> and probing under device.c for this case. This is of course a proposal.
>>> I see that there are people that thing this is a bit of an overkill.
>>> Konstantin (CCd) was proposing a simpler solution by having
>>> APIs with early_* prefixes, and solve the IO address mapping with
>>> a DT entry, for instance. But feel free to propose better ways.
>> In my latest version I got rid from early API set, check out patch for V3 patch set.
>> I'll attach patch for current version later.
>
> Please send it across so we can compare your approach with the one
> present in this series.
Moved control module window remap to early_initcall to allow usage of
control module API very early during kernel initialization.
Switched omap_type() to omap-control-core.c API.

Signed-off-by: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>

Index: omap-thermal/drivers/mfd/omap-control-core.c
===================================================================
--- omap-thermal.orig/drivers/mfd/omap-control-core.c
+++ omap-thermal/drivers/mfd/omap-control-core.c
@@ -31,12 +31,16 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/omap_control.h>
 
+#include <linux/of.h>
+#include <linux/of_address.h>
+
 static struct omap_control *omap_control_module;
+struct omap_control omap_control_data;
 
 /**
  * omap_control_readl: Read a single omap control module register.
  *
- * @dev: device to read from.
+ * @dev: unused - there is only one controle module
  * @reg: register to read.
  * @val: output with register value.
  *
@@ -44,7 +48,7 @@ static struct omap_control *omap_control
  */
 int omap_control_readl(struct device *dev, u32 reg, u32 *val)
 {
-	struct omap_control *omap_control = dev_get_drvdata(dev);
+	struct omap_control *omap_control = omap_control_module;
 
 	if (!omap_control)
 		return -EINVAL;
@@ -58,7 +62,7 @@ EXPORT_SYMBOL_GPL(omap_control_readl);
 /**
  * omap_control_writel: Write a single omap control module register.
  *
- * @dev: device to read from.
+ * @dev: unused - there is only one controle module
  * @val: value to write.
  * @reg: register to write to.
  *
@@ -66,7 +70,7 @@ EXPORT_SYMBOL_GPL(omap_control_readl);
  */
 int omap_control_writel(struct device *dev, u32 val, u32 reg)
 {
-	struct omap_control *omap_control = dev_get_drvdata(dev);
+	struct omap_control *omap_control = omap_control_module;
 	unsigned long flags;
 
 	if (!omap_control)
@@ -130,40 +134,26 @@ static const struct of_device_id of_omap
 
 static int __devinit omap_control_probe(struct platform_device *pdev)
 {
-	struct resource *res;
-	void __iomem *base;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct omap_control *omap_control;
 
-	omap_control = devm_kzalloc(dev, sizeof(*omap_control), GFP_KERNEL);
-	if (!omap_control) {
-		dev_err(dev, "not enough memory for omap_control\n");
-		return -ENOMEM;
-	}
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(dev, "missing memory base resource\n");
-		return -EINVAL;
-	}
-
-	base = devm_request_and_ioremap(dev, res);
-	if (!base) {
+	if (!omap_control_module) {
 		dev_err(dev, "ioremap failed\n");
 		return -EADDRNOTAVAIL;
 	}
+	omap_control = omap_control_module;
 
-	omap_control->base = base;
 	omap_control->dev = dev;
 	spin_lock_init(&omap_control->reg_lock);
 
 	platform_set_drvdata(pdev, omap_control);
-	omap_control_module = omap_control;
 
 	return of_platform_populate(np, of_omap_control_match, NULL, dev);
 }
 
+/* Looks like that there is no need to remove control module */
+#if 0
 static int __devexit omap_control_remove(struct platform_device *pdev)
 {
 	struct omap_control *omap_control = platform_get_drvdata(pdev);
@@ -181,10 +171,11 @@ static int __devexit omap_control_remove
 
 	return 0;
 }
+#endif
 
 static struct platform_driver omap_control_driver = {
 	.probe			= omap_control_probe,
-	.remove			= __devexit_p(omap_control_remove),
+//	.remove			= __devexit_p(omap_control_remove),
 	.driver = {
 		.name		= "omap-control-core",
 		.owner		= THIS_MODULE,
@@ -192,6 +183,53 @@ static struct platform_driver omap_contr
 	},
 };
 
+int __init omap_control_of_init(struct device_node *node,
+			     struct device_node *parent)
+{
+	struct resource res;
+
+	if (WARN_ON(!node))
+		return -ENODEV;
+
+	if (of_address_to_resource(node, 0, &res)) {
+		WARN(1, "unable to get intc registers\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+void __init of_omap_control_init(const struct of_device_id *matches)
+{
+	struct device_node *np;
+	struct property *pp = 0;
+	unsigned long phys_base = 0;
+	size_t mapsize = 0;
+
+	for_each_matching_node(np, matches) {
+
+		pp = of_find_property(np, "reg", NULL);
+		if(pp) {
+			phys_base = (unsigned long)be32_to_cpup(pp->value);
+			mapsize = (size_t)be32_to_cpup( (void*)((char*)pp->value + 4) );
+			omap_control_data.base = ioremap(phys_base, mapsize);
+			if(omap_control_data.base)
+				omap_control_module = &omap_control_data;
+
+//			printk("\t\t **** of_omap_control_init(): ioremap addr %x \n", omap_control_data.base);
+		}
+	}
+}
+
+static int __init
+omap_control_early_initcall(void)
+{
+	of_omap_control_init(of_omap_control_match);
+
+	return 0;
+}
+early_initcall(omap_control_early_initcall);
+
 static int __init omap_control_init(void)
 {
 	return platform_driver_register(&omap_control_driver);
Index: omap-thermal/arch/arm/boot/dts/omap4.dtsi
===================================================================
--- omap-thermal.orig/arch/arm/boot/dts/omap4.dtsi
+++ omap-thermal/arch/arm/boot/dts/omap4.dtsi
@@ -275,7 +275,10 @@
 
 		ctrl_module_core: ctrl_module_core@4a002000 {
 			compatible = "ti,omap4-control";
+			#address-cells = <1>;
+			#size-cells = <1>;
 			ti,hwmods = "ctrl_module_core";
+			reg = <0x4a002000 0x1000>;
 			bandgap {
 				compatible = "ti,omap4460-bandgap";
 				interrupts = <0 126 4>; /* talert */
Index: omap-thermal/arch/arm/mach-omap2/id.c
===================================================================
--- omap-thermal.orig/arch/arm/mach-omap2/id.c
+++ omap-thermal/arch/arm/mach-omap2/id.c
@@ -39,16 +39,12 @@ unsigned int omap_rev(void)
 }
 EXPORT_SYMBOL(omap_rev);
 
+int omap_control_readl(struct device *dev, u32 reg, u32 *val);
+
 int omap_type(void)
 {
-	struct device *scm;
-	int ret = 0;
 	u32 val = 0;
 
-	scm = omap_control_get();
-	if (IS_ERR_OR_NULL(scm))
-		return 0;
-
 	if (cpu_is_omap24xx()) {
 		val = omap_ctrl_readl(OMAP24XX_CONTROL_STATUS);
 	} else if (cpu_is_am33xx()) {
@@ -56,23 +52,17 @@ int omap_type(void)
 	} else if (cpu_is_omap34xx()) {
 		val = omap_ctrl_readl(OMAP343X_CONTROL_STATUS);
 	} else if (cpu_is_omap44xx()) {
-		ret = omap_control_readl(scm, OMAP4_CTRL_MODULE_CORE_STATUS,
+		omap_control_readl(0x0, OMAP4_CTRL_MODULE_CORE_STATUS,
 					 &val);
 	} else {
 		pr_err("Cannot detect omap type!\n");
 		goto out;
 	}
 
-	if (ret) {
-		pr_err("problem while fetching omap type\n");
-		goto out;
-	}
-
 	val &= OMAP2_DEVICETYPE_MASK;
 	val >>= 8;
 
 out:
-	omap_control_put(scm);
 	return val;
 }
 EXPORT_SYMBOL(omap_type);
Index: omap-thermal/arch/arm/mach-omap2/devices.c
===================================================================
--- omap-thermal.orig/arch/arm/mach-omap2/devices.c
+++ omap-thermal/arch/arm/mach-omap2/devices.c
@@ -40,6 +40,7 @@
 #define L3_MODULES_MAX_LEN 12
 #define L3_MODULES 3
 
+#if 0
 static struct resource control_resources[] = {
 	[0] = {
 		.start	= 0x4a002000,
@@ -68,6 +69,7 @@ static int __init plat_early_device_setu
 	return 0;
 }
 early_initcall(plat_early_device_setup);
+#endif
 
 static int omap_init_control(void)
 {

