From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v4 5/9] OMAP3: PM: Adding smartreflex class3 driver
Date: Wed, 27 Oct 2010 21:40:52 +0530
Message-ID: <1288195856-11011-6-git-send-email-thara@ti.com>
References: <1288195856-11011-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36170 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761052Ab0J0QLK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Oct 2010 12:11:10 -0400
In-Reply-To: <1288195856-11011-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

Smartreflex Class3 implementation continuously monitors
silicon performance  and instructs the Voltage Processors
to increase or decrease the voltage.
This patch adds smartreflex class 3 driver. This driver hooks
up with the generic smartreflex driver smartreflex.c to abstract
out class specific implementations out of the generic driver.

Class3 driver is chosen as the default class driver for smartreflex.
If any other class driver needs to be implemented, the init of that
driver should be called from the board file. That way the new class driver
will over-ride the Class3 driver.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/Makefile             |    1 +
 arch/arm/mach-omap2/smartreflex-class3.c |   59 ++++++++++++++++++++++++++++++
 arch/arm/plat-omap/Kconfig               |    9 +++++
 3 files changed, 69 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/smartreflex-class3.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 42b0cc5..e194830 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o voltage.o \
 obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o pm_bus.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 obj-$(CONFIG_OMAP_SMARTREFLEX)          += sr_device.o smartreflex.o
+obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+= smartreflex-class3.o
 
 AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
 AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a
diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
new file mode 100644
index 0000000..60e7055
--- /dev/null
+++ b/arch/arm/mach-omap2/smartreflex-class3.c
@@ -0,0 +1,59 @@
+/*
+ * Smart reflex Class 3 specific implementations
+ *
+ * Author: Thara Gopinath       <thara@ti.com>
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Thara Gopinath <thara@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <plat/smartreflex.h>
+
+static int sr_class3_enable(struct voltagedomain *voltdm)
+{
+	unsigned long volt = omap_voltage_get_nom_volt(voltdm);
+
+	if (!volt) {
+		pr_warning("%s: Curr voltage unknown. Cannot enable sr_%s\n",
+				__func__, voltdm->name);
+		return -ENODATA;
+	}
+
+	omap_vp_enable(voltdm);
+	return sr_enable(voltdm, volt);
+}
+
+static int sr_class3_disable(struct voltagedomain *voltdm, int is_volt_reset)
+{
+	omap_vp_disable(voltdm);
+	sr_disable(voltdm);
+	if (is_volt_reset)
+		omap_voltage_reset(voltdm);
+
+	return 0;
+}
+
+static int sr_class3_configure(struct voltagedomain *voltdm)
+{
+	return sr_configure_errgen(voltdm);
+}
+
+/* SR class3 structure */
+static struct omap_sr_class_data class3_data = {
+	.enable = sr_class3_enable,
+	.disable = sr_class3_disable,
+	.configure = sr_class3_configure,
+	.class_type = SR_CLASS3,
+};
+
+/* Smartreflex Class3 init API to be called from board file */
+static int __init sr_class3_init(void)
+{
+	pr_info("SmartReflex Class3 initialized\n");
+	return sr_register_class(&class3_data);
+}
+late_initcall(sr_class3_init);
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 04b0bd2..7ba92c2 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -71,6 +71,15 @@ config OMAP_SMARTREFLEX_TESTING
 
 	  WARNING: Enabling this option may cause your device to hang!
 
+config OMAP_SMARTREFLEX_CLASS3
+	bool "Class 3 mode of Smartreflex Implementation"
+	depends on OMAP_SMARTREFLEX && TWL4030_CORE
+	help
+	  Say Y to enable Class 3 implementation of Smartreflex
+
+	  Class 3 implementation of Smartreflex employs continuous hardware
+	  voltage calibration.
+
 config OMAP_RESET_CLOCKS
 	bool "Reset unused clocks during boot"
 	depends on ARCH_OMAP
-- 
1.7.0.4

