From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv2 6/8] OMAP3: PM: Adding smartreflex class3 driver
Date: Fri, 13 Aug 2010 19:17:09 +0530
Message-ID: <1281707231-3026-7-git-send-email-thara@ti.com>
References: <1281707231-3026-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53797 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761647Ab0HMNr0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Aug 2010 09:47:26 -0400
In-Reply-To: <1281707231-3026-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, dderrick@ti.com, Thara Gopinath <thara@ti.com>

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
 arch/arm/mach-omap2/smartreflex-class3.c |   61 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/smartreflex-class3.h |   23 +++++++++++
 arch/arm/plat-omap/Kconfig               |    9 ++++
 7 files changed, 100 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/smartreflex-class3.c
 create mode 100644 arch/arm/mach-omap2/smartreflex-class3.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index f259bb8..8ead729 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o voltage.o \
 obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 obj-$(CONFIG_OMAP_SMARTREFLEX)          += sr_device.o smartreflex.o
+obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+= smartreflex-class3.o
 
 AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
 AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 67b95b5f..9a04a2e 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -47,6 +47,7 @@
 #include "sdram-qimonda-hyb18m512160af-6.h"
 #include "hsmmc.h"
 #include "pm.h"
+#include "smartreflex-class3.h"
 
 #define CONFIG_DISABLE_HFCLK 1
 
@@ -813,6 +814,7 @@ static void __init omap_3430sdp_init(void)
 	sdp3430_display_init();
 	enable_board_wakeup_source();
 	usb_ehci_init(&ehci_pdata);
+	sr_class3_init();
 }
 
 MACHINE_START(OMAP_3430SDP, "OMAP3430 3430SDP board")
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index b359c3f..597b1a3 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -25,6 +25,7 @@
 
 #include "mux.h"
 #include "sdram-hynix-h8mbx00u0mer-0em.h"
+#include "smartreflex-class3.h"
 
 #if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91X_MODULE)
 
@@ -214,6 +215,7 @@ static void __init omap_sdp_init(void)
 	board_flash_init(sdp_flash_partitions, chip_sel_sdp);
 	enable_board_wakeup_source();
 	usb_ehci_init(&ehci_pdata);
+	sr_class3_init();
 }
 
 MACHINE_START(OMAP_3630SDP, "OMAP 3630SDP board")
diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index 6ca0b83..03411b2 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -24,6 +24,7 @@
 
 #include "mux.h"
 #include "sdram-hynix-h8mbx00u0mer-0em.h"
+#include "smartreflex-class3.h"
 
 static struct omap_board_config_kernel zoom_config[] __initdata = {
 };
@@ -120,6 +121,7 @@ static void __init omap_zoom_init(void)
 
 	omap_mux_init_gpio(64, OMAP_PIN_OUTPUT);
 	usb_ehci_init(&ehci_pdata);
+	sr_class3_init();
 }
 
 MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")
diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
new file mode 100644
index 0000000..162d36d
--- /dev/null
+++ b/arch/arm/mach-omap2/smartreflex-class3.c
@@ -0,0 +1,61 @@
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
+
+static int sr_class3_enable(struct voltagedomain *voltdm)
+{
+	unsigned long volt = 0;
+
+	volt = omap_voltage_get_nom_volt(voltdm);
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
+static struct omap_smartreflex_class_data class3_data = {
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
index 8056349..af7acc9 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -67,6 +67,15 @@ config OMAP_SMARTREFLEX_TESTING
 
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
1.7.1.GIT

