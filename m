From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 5/8] OMAP3: PM: Adding smartreflex class3 driver
Date: Sat, 29 May 2010 22:02:25 +0530
Message-ID: <1275150748-15386-6-git-send-email-thara@ti.com>
References: <1275150748-15386-1-git-send-email-thara@ti.com>
 <1275150748-15386-2-git-send-email-thara@ti.com>
 <1275150748-15386-3-git-send-email-thara@ti.com>
 <1275150748-15386-4-git-send-email-thara@ti.com>
 <1275150748-15386-5-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48841 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757348Ab0E2Qcj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 29 May 2010 12:32:39 -0400
In-Reply-To: <1275150748-15386-5-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

Smartreflex Class3 implementation continuously monitors
silicon performance  and instructs the Voltage Processors
to increase or decrease the voltage.
This patch adds smartreflex class 3 driver. This driver hooks
up with the generic smartreflex driver smartreflex.c to abstract
out class specific implementations out of the generic driver.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/Makefile             |    1 +
 arch/arm/mach-omap2/board-3430sdp.c      |    2 +
 arch/arm/mach-omap2/board-3630sdp.c      |    2 +
 arch/arm/mach-omap2/board-zoom3.c        |    2 +
 arch/arm/mach-omap2/smartreflex-class3.c |   62 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/smartreflex-class3.h |   23 +++++++++++
 arch/arm/plat-omap/Kconfig               |    9 ++++
 7 files changed, 101 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/smartreflex-class3.c
 create mode 100644 arch/arm/mach-omap2/smartreflex-class3.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index ab3772a..116cffb 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o cpuidle34xx.o \
 					   voltage.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 obj-$(CONFIG_OMAP_SMARTREFLEX)          += sr_device.o smartreflex.o
+obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+= smartreflex-class3.o
 
 AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
 AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index da5cea5..ba650a5 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -48,6 +48,7 @@
 #include "hsmmc.h"
 #include "pm.h"
 #include "omap3-opp.h"
+#include "smartreflex-class3.h"
 
 #define CONFIG_DISABLE_HFCLK 1
 
@@ -804,6 +805,7 @@ static void __init omap_3430sdp_init(void)
 	sdp3430_display_init();
 	enable_board_wakeup_source();
 	usb_ehci_init(&ehci_pdata);
+	sr_class3_init();
 }
 
 static void __init omap_3430sdp_map_io(void)
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index b7c44eb..00aef0d 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -27,6 +27,7 @@
 #include "sdram-hynix-h8mbx00u0mer-0em.h"
 #include "pm.h"
 #include "omap3-opp.h"
+#include "smartreflex-class3.h"
 
 #if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91X_MODULE)
 
@@ -107,6 +108,7 @@ static void __init omap_sdp_init(void)
 	board_smc91x_init();
 	enable_board_wakeup_source();
 	usb_ehci_init(&ehci_pdata);
+	sr_class3_init();
 }
 
 MACHINE_START(OMAP_3630SDP, "OMAP 3630SDP board")
diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index 25ce6d6..99ade1c 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -26,6 +26,7 @@
 #include "sdram-hynix-h8mbx00u0mer-0em.h"
 #include "pm.h"
 #include "omap3-opp.h"
+#include "smartreflex-class3.h"
 
 static void __init omap_zoom_map_io(void)
 {
@@ -76,6 +77,7 @@ static void __init omap_zoom_init(void)
 
 	omap_mux_init_gpio(64, OMAP_PIN_OUTPUT);
 	usb_ehci_init(&ehci_pdata);
+	sr_class3_init();
 }
 
 MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")
diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
new file mode 100644
index 0000000..f3b766f
--- /dev/null
+++ b/arch/arm/mach-omap2/smartreflex-class3.c
@@ -0,0 +1,62 @@
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
+#include "smartreflex-class3.h"
+#include "voltage.h"
+
+static int sr_class3_enable(int id)
+{
+	unsigned long volt = 0;
+
+	volt = get_curr_voltage(id);
+	if (!volt) {
+		pr_warning("%s: Current voltage unknown.Cannot enable SR%d\n",
+				__func__, id);
+		return -ENODATA;
+	}
+
+	omap_voltageprocessor_enable(id);
+	return sr_enable(id, volt);
+}
+
+static int sr_class3_disable(int id, int is_volt_reset)
+{
+	omap_voltageprocessor_disable(id);
+	sr_disable(id);
+	if (is_volt_reset)
+		omap_reset_voltage(id);
+
+	return 0;
+}
+
+static int sr_class3_configure(int id)
+{
+	return sr_configure_errgen(id);
+}
+
+/* SR class3 structure */
+struct omap_smartreflex_class_data class3_data = {
+	.enable = sr_class3_enable,
+	.disable = sr_class3_disable,
+	.configure = sr_class3_configure,
+	.class_type = SR_CLASS3,
+};
+
+/* Smartreflex CLASS3 init API to be called from board file */
+int __init sr_class3_init(void)
+{
+	pr_info("SmartReflex CLASS3 initialized\n");
+	return omap_sr_register_class(&class3_data);
+}
diff --git a/arch/arm/mach-omap2/smartreflex-class3.h b/arch/arm/mach-omap2/smartreflex-class3.h
new file mode 100644
index 0000000..4d86037
--- /dev/null
+++ b/arch/arm/mach-omap2/smartreflex-class3.h
@@ -0,0 +1,23 @@
+/*
+ * Smartreflex Class 3 Routines
+ *
+ * Author: Thara Gopinath      <thara@ti.com>
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Thara Gopinath <thara@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ARCH_ARM_MACH_OMAP2_SMARTREFLEXCLASS3_H
+#define __ARCH_ARM_MACH_OMAP2_SMARTREFLEXCLASS3_H
+
+#ifdef CONFIG_OMAP_SMARTREFLEX_CLASS3
+int sr_class3_init(void);
+#else
+static int sr_class3_init(void) { return 0; }
+#endif
+
+#endif
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 34f265e..33256d8 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -85,6 +85,15 @@ config OMAP_SMARTREFLEX_TESTING
 
 	  WARNING: Enabling this option may cause your device to hang!
 
+config OMAP_SMARTREFLEX_CLASS3
+	bool "Class 3 mode of Smartreflex Implementation"
+	depends on OMAP_SMARTREFLEX && TWL4030_CORE
+	help
+	  Say Y to enable Class 3 implementation of Smartreflex
+
+	  Class 3 implementation of Smartreflex employs continuous hardware
+	  voltage caliberation.
+
 config OMAP_RESET_CLOCKS
 	bool "Reset unused clocks during boot"
 	depends on ARCH_OMAP
-- 
1.7.0.rc1.33.g07cf0f

