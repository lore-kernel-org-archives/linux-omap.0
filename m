From: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Subject: Re: [RFC PATCH 04/11] OMAP: Add early device for system control module
Date: Fri, 25 May 2012 15:54:48 +0400
Message-ID: <4FBF7308.4050605@dev.rtsoft.ru>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com> <1337934361-1606-5-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:48144 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753793Ab2EYLyu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 May 2012 07:54:50 -0400
In-Reply-To: <1337934361-1606-5-git-send-email-eduardo.valentin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: b-cousson@ti.com, kishon@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com, balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org, Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>

  Hi.

On 05/25/2012 12:25 PM, Eduardo Valentin wrote:
> This is a way to add an early device for system control module.
> the code is also requesting for driver registration and probing.
> Done at early_initcall because at that time, ioremapping is possible.
>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> ---
>  arch/arm/mach-omap2/devices.c |   29 +++++++++++++++++++++++++++++
>  1 files changed, 29 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 9332673..58cc5c3 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -40,6 +40,35 @@
>  #define L3_MODULES_MAX_LEN 12
>  #define L3_MODULES 3
>  
> +static struct resource control_resources[] = {
> +	[0] = {
> +		.start	= 0x4a002000,
> +		.end	= 0x4a0027ff,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +};
Init control module platform device resources from device tree instead of
hard-coding them.
Prevent control module driver registering itself second time after it has
already been registered by early_platform_driver_register_all().

Signed-off-by: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>

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
Index: omap-thermal/arch/arm/mach-omap2/devices.c
===================================================================
--- omap-thermal.orig/arch/arm/mach-omap2/devices.c
+++ omap-thermal/arch/arm/mach-omap2/devices.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/platform_data/omap4-keypad.h>
+#include <linux/of_address.h>
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
@@ -40,6 +41,7 @@
 #define L3_MODULES_MAX_LEN 12
 #define L3_MODULES 3
 
+#if 0
 static struct resource control_resources[] = {
 	[0] = {
 		.start	= 0x4a002000,
@@ -47,6 +49,17 @@ static struct resource control_resources
 		.flags	= IORESOURCE_MEM,
 	},
 };
+#endif
+
+static const struct of_device_id of_omap_control_match[] = {
+	{ .compatible = "ti,omap3-control", },
+	{ .compatible = "ti,omap4-control", },
+	{ .compatible = "ti,omap5-control", },
+	{ },
+};
+
+static struct resource control_resources[1];
+
 static struct platform_device control_device = {
 	.name		= "omap-control-core",
 	.id		= 0,
@@ -58,8 +71,56 @@ static struct platform_device *early_dev
 	&control_device,
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
+//			printk("\t\t **** of_omap_control_init(): ioremap %x \n", be32_to_cpup(pp->value));
+//			printk("\t\t **** of_omap_control_init(): 2 value %x \n", be32_to_cpup( (char*)pp->value + 4 ) );
+//			printk("\t\t **** of_omap_control_init(): length %x \n", pp->length);
+
+			phys_base = (resource_size_t)be32_to_cpup(pp->value);
+			mapsize = (size_t)be32_to_cpup( (void*)((char*)pp->value + 4) );
+#if 0
+			omap_control_data.base = ioremap(phys_base, mapsize);
+			if(omap_control_data.base)
+				omap_control_module = &omap_control_data;
+#endif
+			control_resources[0].start = phys_base;
+			control_resources[0].end = phys_base + mapsize;
+			control_resources[0].flags = IORESOURCE_MEM;
+			printk("\t\t **** of_omap_control_init(): start addr %x \n", control_resources[0].start);
+			printk("\t\t **** of_omap_control_init(): end   addr %x \n", control_resources[0].end);
+		}
+	}
+}
+
 static int __init plat_early_device_setup(void)
 {
+	of_omap_control_init(of_omap_control_match);
 	early_platform_add_devices(early_devices,
 				   ARRAY_SIZE(early_devices));
 	early_platform_driver_register_all("early_omap_control");
Index: omap-thermal/drivers/mfd/omap-control-core.c
===================================================================
--- omap-thermal.orig/drivers/mfd/omap-control-core.c
+++ omap-thermal/drivers/mfd/omap-control-core.c
@@ -194,6 +194,10 @@ static struct platform_driver omap_contr
 
 static int __init omap_control_init(void)
 {
+	/* Check is early driver probe is done */
+	if (!omap_control_module)
+		return 0;
+
 	return platform_driver_register(&omap_control_driver);
 }
 postcore_initcall_sync(omap_control_init);

