From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv2 08/17] OMAP3: PM: Adding smartreflex class 3 driver.
Date: Thu, 18 Mar 2010 14:45:46 +0530
Message-ID: <1268903755-4151-9-git-send-email-thara@ti.com>
References: <1268903755-4151-1-git-send-email-thara@ti.com>
 <1268903755-4151-2-git-send-email-thara@ti.com>
 <1268903755-4151-3-git-send-email-thara@ti.com>
 <1268903755-4151-4-git-send-email-thara@ti.com>
 <1268903755-4151-5-git-send-email-thara@ti.com>
 <1268903755-4151-6-git-send-email-thara@ti.com>
 <1268903755-4151-7-git-send-email-thara@ti.com>
 <1268903755-4151-8-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47865 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750999Ab0CRJQI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Mar 2010 05:16:08 -0400
In-Reply-To: <1268903755-4151-8-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, nm@ti.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch adds smartreflex class 3 driver. This driver hooks
up with the generic smartreflex driver smartreflex.c to abstract
out class specific implementations out of the generic driver.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/Makefile             |    1 +
 arch/arm/mach-omap2/smartreflex-class3.c |   48 ++++++++++++++++++++++++++++++
 arch/arm/plat-omap/Kconfig               |   11 ++++++-
 3 files changed, 59 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/smartreflex-class3.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 62accd2..0f8c406 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o cpuidle34xx.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 obj-$(CONFIG_OMAP_SMARTREFLEX)		+= sr_device.o smartreflex.o
+obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+= smartreflex-class3.o
 
 AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
 AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a
diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
new file mode 100644
index 0000000..2832b5a
--- /dev/null
+++ b/arch/arm/mach-omap2/smartreflex-class3.c
@@ -0,0 +1,48 @@
+/*
+ * Smart reflex Class 3 specific implementations
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Thara Gopinath <thara@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "smartreflex.h"
+
+static int sr_class3_enable(int id)
+{
+	unsigned long volt = 0;
+
+	if (id == SR1)
+		volt = get_curr_vdd1_voltage();
+	else if (id == SR2)
+		volt = get_curr_vdd2_voltage();
+	if (!volt) {
+		pr_warning("Current voltage unknown.Cannot enable SR%d\n", id);
+		return false;
+	}
+
+	return sr_enable(id, volt);
+}
+
+static int sr_class3_disable(int id)
+{
+	sr_disable(id);
+
+	return true;
+}
+
+/* SR class3 structure */
+struct omap_smartreflex_class_data class3_data = {
+	.enable = sr_class3_enable,
+	.disable = sr_class3_disable,
+};
+
+static int __init sr_class3_init(void)
+{
+	omap_sr_register_class(&class3_data);
+	return 0;
+}
+late_initcall(sr_class3_init);
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 232fd9e..785b7e6 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -55,7 +55,7 @@ config OMAP_DEBUG_LEDS
 
 config OMAP_SMARTREFLEX
 	bool "SmartReflex support"
-	depends on ARCH_OMAP3 && TWL4030_CORE && PM
+	depends on ARCH_OMAP3 && PM
 	help
 	  Say Y if you want to enable SmartReflex.
 
@@ -70,6 +70,15 @@ config OMAP_SMARTREFLEX
 	  compensation for VDD1 and VDD2, user must write 1 to
 	  /sys/power/sr_vddX_autocomp, where X is 1 or 2.
 
+config OMAP_SMARTREFLEX_CLASS3
+	bool "Class 3 mode of Smartreflex Implementation"
+	depends on OMAP_SMARTREFLEX && TWL4030_CORE
+	help
+	  Say Y to enable Class 3 implementation of Smartreflex
+
+	  Class 3 implementation of Smartreflex employs continuous hardware
+	  voltage caliberation.
+
 config OMAP_SMARTREFLEX_TESTING
 	bool "Smartreflex testing support"
 	depends on OMAP_SMARTREFLEX
-- 
1.7.0.rc1.33.g07cf0f

