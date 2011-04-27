From: Hemant Pedanekar <hemantp@ti.com>
Subject: [PATCH 2/2] hwmods: Integrate TI816X hwmods
Date: Wed, 27 Apr 2011 22:03:42 +0530
Message-ID: <1303922022-7130-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53844 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432Ab1D0Qd7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Apr 2011 12:33:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux@arm.linux.org.uk, b-cousson@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Hemant Pedanekar <hemantp@ti.com>

This patch integrates TI816X hwmods into hwmods framework.

Note that a TI816X specific function ti816x_cm_wait_module_ready() is added to
wait for module to become ready since corresponding OMAP2/3 function
omap2_cm_wait_module_ready() cannot be used as there are no IDLEST registers in
TI816X.

Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
---
This patch depends on following patch set:
TI816X: prcm: Add module and register offsets
TI816X: clock: Add clock data
TI816X: clock: Add clockdomains and powerdomains data
clock: Integrate TI816X clock data into OMAP clock framework

 arch/arm/mach-omap2/Makefile                 |    2 +
 arch/arm/mach-omap2/cm2xxx_3xxx.h            |    1 +
 arch/arm/mach-omap2/cm816x.c                 |   55 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/io.c                     |    1 +
 arch/arm/mach-omap2/omap_hwmod.c             |   11 ++++-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 6 files changed, 68 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-omap2/cm816x.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index ace5e4e..640294e 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -80,6 +80,7 @@ endif
 obj-$(CONFIG_ARCH_OMAP2)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o \
 					   vc3xxx_data.o vp3xxx_data.o
+obj-$(CONFIG_SOC_OMAPTI816X)		+= cm816x.o
 # XXX The presence of cm2xxx_3xxx.o on the line below is temporary and
 # will be removed once the OMAP4 part of the codebase is converted to
 # use OMAP4-specific PRCM functions.
@@ -149,6 +150,7 @@ obj-$(CONFIG_SOC_OMAP2430)		+= opp2430_data.o
 obj-$(CONFIG_SOC_OMAP2420)		+= omap_hwmod_2420_data.o
 obj-$(CONFIG_SOC_OMAP2430)		+= omap_hwmod_2430_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= omap_hwmod_3xxx_data.o
+obj-$(CONFIG_SOC_OMAPTI816X)		+= omap_hwmod_816x_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= omap_hwmod_44xx_data.o
 
 # EMU peripherals
diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.h b/arch/arm/mach-omap2/cm2xxx_3xxx.h
index 11401c1..47f824a 100644
--- a/arch/arm/mach-omap2/cm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/cm2xxx_3xxx.h
@@ -122,6 +122,7 @@ extern void omap3xxx_cm_clkdm_disable_hwsup(s16 module, u32 mask);
 extern void omap3xxx_cm_clkdm_force_sleep(s16 module, u32 mask);
 extern void omap3xxx_cm_clkdm_force_wakeup(s16 module, u32 mask);
 
+extern int ti816x_cm_wait_module_ready(void __iomem *clkctrl_reg);
 extern void ti816x_cm_clkdm_enable_hwsup(s16 inst, u16 clkdm, u32 mask);
 extern void ti816x_cm_clkdm_disable_hwsup(s16 inst, u16 clkdm, u32 mask);
 extern void ti816x_cm_clkdm_force_sleep(s16 inst, u16 clkdm, u32 mask);
diff --git a/arch/arm/mach-omap2/cm816x.c b/arch/arm/mach-omap2/cm816x.c
new file mode 100644
index 0000000..ec5b478
--- /dev/null
+++ b/arch/arm/mach-omap2/cm816x.c
@@ -0,0 +1,55 @@
+/*
+ * TI816X CM module functions
+ *
+ * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * Based on arch/arm/mach-omap2/cm4xxx.c, original copyright follows:
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/io.h>
+
+#include <plat/common.h>
+
+#include "cm.h"
+#include "cm-regbits-816x.h"
+
+/**
+ * ti816x_cm_wait_module_ready - wait for a module to be in 'func' state
+ * @clkctrl_reg: CLKCTRL module address
+ *
+ * Wait for the module IDLEST to be functional. If the idle state is in any
+ * the non functional state (trans, idle or disabled), module and thus the
+ * sysconfig cannot be accessed and will probably lead to an "imprecise
+ * external abort"
+ *
+ * Module idle state:
+ *   0x0 func:     Module is fully functional, including OCP
+ *   0x1 trans:    Module is performing transition: wakeup, or sleep, or sleep
+ *                 abortion
+ *   0x2 idle:     Module is in Idle mode (only OCP part). It is functional if
+ *                 using separate functional clock
+ *   0x3 disabled: Module is disabled and cannot be accessed
+ *
+ */
+int ti816x_cm_wait_module_ready(void __iomem *clkctrl_reg)
+{
+	int i = 0;
+
+	if (!clkctrl_reg)
+		return 0;
+
+	omap_test_timeout((
+		((__raw_readl(clkctrl_reg) & TI816X_IDLEST_MASK) == 0)),
+		MAX_MODULE_READY_TIME, i);
+
+	return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
+}
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 441e79d..e4e8500 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -366,6 +366,7 @@ void __init omap2_init_common_infrastructure(void)
 		omap3xxx_powerdomains_init();
 		omap3xxx_clockdomains_init();
 		omap3xxx_hwmod_init();
+		ti816x_hwmod_init();
 	} else if (cpu_is_omap44xx()) {
 		omap44xx_powerdomains_init();
 		omap44xx_clockdomains_init();
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index e034294..9f5c2ea 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -962,9 +962,14 @@ static int _wait_target_ready(struct omap_hwmod *oh)
 	/* XXX check clock enable states */
 
 	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-		ret = omap2_cm_wait_module_ready(oh->prcm.omap2.module_offs,
-						 oh->prcm.omap2.idlest_reg_id,
-						 oh->prcm.omap2.idlest_idle_bit);
+		if (cpu_is_ti816x())
+			ret = ti816x_cm_wait_module_ready(
+						oh->prcm.omap4.clkctrl_reg);
+		else
+			ret = omap2_cm_wait_module_ready(
+						oh->prcm.omap2.module_offs,
+						oh->prcm.omap2.idlest_reg_id,
+						oh->prcm.omap2.idlest_idle_bit);
 	} else if (cpu_is_omap44xx()) {
 		ret = omap4_cm_wait_module_ready(oh->prcm.omap4.clkctrl_reg);
 	} else {
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 1adea9c..6059df7 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -610,5 +610,6 @@ extern int omap2420_hwmod_init(void);
 extern int omap2430_hwmod_init(void);
 extern int omap3xxx_hwmod_init(void);
 extern int omap44xx_hwmod_init(void);
+extern int ti816x_hwmod_init(void);
 
 #endif
-- 
1.7.3.5

