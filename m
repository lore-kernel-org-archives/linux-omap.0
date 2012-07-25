From: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Subject: [PATCH v4 2/4] mfd: omap: control: core system control driver
Date: Wed, 25 Jul 2012 15:05:16 +0400
Message-ID: <500FD2EC.7060208@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070005060009070704080802"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:58822 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755030Ab2GYLFS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jul 2012 07:05:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, kishon@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com
Cc: balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org, Eduardo Valentin <eduardo.valentin@ti.com>

This is a multi-part message in MIME format.
--------------070005060009070704080802
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit

This patch introduces a MFD core device driver for
OMAP system control module.

The control module allows software control of
various static modes supported by the device. It is
composed of two control submodules: general control
module and device (padconfiguration) control
module.

Device driver is probed with postcore_initcall.
Control module register CONTROL_STATUS that is needed
by omap_type() is early mapped by postcore_initcall_sync.

Signed-off-by: J Keerthy <j-keerthy@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
Signed-off-by: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
---
 .../devicetree/bindings/mfd/omap_control.txt       |   32 ++++
 arch/arm/mach-omap2/Kconfig                        |    1 +
 arch/arm/plat-omap/Kconfig                         |    4 +
 drivers/mfd/Kconfig                                |    6 +
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/omap-control-core.c                    |  162 ++++++++++++++++++++
 include/linux/mfd/omap_control.h                   |   35 +++++
 7 files changed, 241 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/omap_control.txt
 create mode 100644 drivers/mfd/omap-control-core.c
 create mode 100644 include/linux/mfd/omap_control.h

diff --git a/Documentation/devicetree/bindings/mfd/omap_control.txt b/Documentation/devicetree/bindings/mfd/omap_control.txt
new file mode 100644
index 0000000..a9dca9e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/omap_control.txt
@@ -0,0 +1,32 @@
+* Texas Instrument OMAP System Control Module (SCM) bindings
+
+The control module allows software control of various static modes supported by
+the device. The control module controls the settings of various device  modules
+through register configuration and internal signals. It also controls  the  pad
+configuration, pin functional multiplexing, and the routing of internal signals
+(such as PRCM  signals or DMA requests)  to output pins configured for hardware
+observability.
+
+Required properties:
+- compatible : Should be:
+  - "ti,omap3-control" for OMAP3 support
+  - "ti,omap4-control" for OMAP4 support
+  - "ti,omap5-control" for OMAP5 support
+
+OMAP specific properties:
+- ti,hwmods: Name of the hwmod associated to the control module:
+  Should be "ctrl_module_core";
+
+OMAP CONTROL_STATUS register:
+reg = <0x4A0022C4 0x4>; /* CONTROL_STATUS register */
+
+Examples:
+ctrl_module_core: ctrl_module_core@4A0022C4 {
+	compatible = "ti,omap4-control";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	/* ranges; */
+	ti,hwmods = "ctrl_module_core";
+	reg = <0x4A0022C4 0x4>; /* CONTROL_STATUS register */
+};
+
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index dd0fbf7..1235576 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -59,6 +59,7 @@ config ARCH_OMAP4
 	select ARM_ERRATA_720789
 	select ARCH_HAS_OPP
 	select PM_RUNTIME if CPU_IDLE
+	select ARCH_HAS_CONTROL_MODULE
 	select PM_OPP if PM
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select ARM_CPU_SUSPEND if PM
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index dd36eba..2b2c9d8 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -5,6 +5,10 @@ menu "TI OMAP Common Features"
 config ARCH_OMAP_OTG
 	bool
 
+config ARCH_HAS_CONTROL_MODULE
+	bool
+	select MFD_OMAP_CONTROL
+
 choice
 	prompt "OMAP System Type"
 	default ARCH_OMAP2PLUS
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 92144ed..530ac60 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -823,6 +823,12 @@ config MFD_WL1273_CORE
 	  driver connects the radio-wl1273 V4L2 module and the wl1273
 	  audio codec.
 
+config MFD_OMAP_CONTROL
+	bool "Texas Instruments OMAP System control module"
+	depends on ARCH_HAS_CONTROL_MODULE
+	help
+	  This is the core driver for system control module.
+
 config MFD_OMAP_USB_HOST
 	bool "Support OMAP USBHS core driver"
 	depends on USB_EHCI_HCD_OMAP || USB_OHCI_HCD_OMAP3
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 75f6ed6..b037443 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -107,6 +107,7 @@ obj-$(CONFIG_MFD_TPS6586X)	+= tps6586x.o
 obj-$(CONFIG_MFD_VX855)		+= vx855.o
 obj-$(CONFIG_MFD_WL1273_CORE)	+= wl1273-core.o
 obj-$(CONFIG_MFD_CS5535)	+= cs5535-mfd.o
+obj-$(CONFIG_MFD_OMAP_CONTROL)	+= omap-control-core.o
 obj-$(CONFIG_MFD_OMAP_USB_HOST)	+= omap-usb-host.o
 obj-$(CONFIG_MFD_PM8921_CORE) 	+= pm8921-core.o
 obj-$(CONFIG_MFD_PM8XXX_IRQ) 	+= pm8xxx-irq.o
diff --git a/drivers/mfd/omap-control-core.c b/drivers/mfd/omap-control-core.c
new file mode 100644
index 0000000..cefbc5a
--- /dev/null
+++ b/drivers/mfd/omap-control-core.c
@@ -0,0 +1,162 @@
+/*
+ * OMAP system control module driver file
+ *
+ * Copyright (C) 2011-2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Contacts:
+ * Based on original code written by:
+ *    J Keerthy <j-keerthy@ti.com>
+ *    Moiz Sonasath <m-sonasath@ti.com>
+ * MFD clean up and re-factoring:
+ *    Eduardo Valentin <eduardo.valentin@ti.com>
+ *    Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/export.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/omap_control.h>
+
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+void __iomem *omap_control_base;
+unsigned long omap_control_phys_base;
+size_t omap_control_mapsize;
+
+u32 omap_control_status_read(void)
+{
+	return __raw_readl(omap_control_base);
+}
+
+static const struct of_device_id of_omap_control_match[] = {
+	{ .compatible = "ti,omap3-control", },
+	{ .compatible = "ti,omap4-control", },
+	{ .compatible = "ti,omap5-control", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, of_omap_control_match);
+
+/*
+ *  Request control module resources
+ */
+static int __devinit omap_control_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	const char *name;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENOMEM;
+
+	if (!res) {
+		dev_err(dev, "invalid resource\n");
+		return -EINVAL;
+	}
+
+	name = res->name ?: dev_name(dev);
+
+	/*
+	 * Can't use res->start and resource_size(res) from platform_get_resource,
+	 * because omap_device_alloc() overwrites DT resources -
+	 * using omap_control_phys_base, omap_control_mapsize instead
+	 */
+	if (!devm_request_mem_region(dev, omap_control_phys_base, omap_control_mapsize, name)) {
+		dev_err(dev, "can't request region for resource %pR\n", res);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+
+static struct platform_driver omap_control_driver = {
+	.probe			= omap_control_probe,
+	.driver = {
+		.name		= "omap-control-core",
+		.owner		= THIS_MODULE,
+		.of_match_table	= of_omap_control_match,
+	},
+};
+
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
+
+	for_each_matching_node(np, matches) {
+		pp = of_find_property(np, "reg", NULL);
+		if(pp) {
+			omap_control_phys_base = (unsigned long)be32_to_cpup(pp->value);
+			omap_control_mapsize = (size_t)be32_to_cpup( (void*)((char*)pp->value + 4) );
+			/*
+			 * Map control module register CONTROL_STATUS register:
+			 * omap24xx - OMAP24XX_CONTROL_STATUS
+			 * am33xx   - AM33XX_CONTROL_STATUS
+			 * omap34xx - OMAP343X_CONTROL_STATUS
+			 * omap44xx - OMAP4_CTRL_MODULE_CORE_STATUS
+			 * omap54xx - OMAP5XXX_CONTROL_STATUS
+			 */
+			omap_control_base = ioremap(omap_control_phys_base, omap_control_mapsize);
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
+static int __init omap_control_init(void)
+{
+	return platform_driver_register(&omap_control_driver);
+}
+postcore_initcall_sync(omap_control_init);
+
+static void __exit omap_control_exit(void)
+{
+	platform_driver_unregister(&omap_control_driver);
+}
+module_exit(omap_control_exit);
+early_platform_init("early_omap_control", &omap_control_driver);
+
+MODULE_DESCRIPTION("OMAP system control module driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:omap-control-core");
+MODULE_AUTHOR("Texas Instruments Inc.");
diff --git a/include/linux/mfd/omap_control.h b/include/linux/mfd/omap_control.h
new file mode 100644
index 0000000..ee90a38
--- /dev/null
+++ b/include/linux/mfd/omap_control.h
@@ -0,0 +1,35 @@
+/*
+ * OMAP system control module header file
+ *
+ * Copyright (C) 2011-2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Contact:
+ *   J Keerthy <j-keerthy@ti.com>
+ *   Moiz Sonasath <m-sonasath@ti.com>
+ *   Abraham, Kishon Vijay <kishon@ti.com>
+ *   Eduardo Valentin <eduardo.valentin@ti.com>
+ *   Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ */
+
+#ifndef __DRIVERS_OMAP_CONTROL_H
+#define __DRIVERS_OMAP_CONTROL_H
+
+#ifdef CONFIG_MFD_OMAP_CONTROL
+u32 omap_control_status_read(void);
+#else
+static inline u32 omap_control_status_read(void)
+{
+	return 0;
+}
+#endif
+
+#endif /* __DRIVERS_OMAP_CONTROL_H */
-- 
1.7.7.6


--------------070005060009070704080802
Content-Type: text/plain; charset=UTF-8;
 name="Attached Message Part"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="Attached Message Part"


--------------070005060009070704080802--
