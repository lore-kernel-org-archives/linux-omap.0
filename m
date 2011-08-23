From: Hemant Pedanekar <hemantp@ti.com>
Subject: [RFC PATCH v2 6/6] hwmods: Integrate TI81XX hwmods
Date: Tue, 23 Aug 2011 22:43:53 +0530
Message-ID: <1314119633-23166-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54413 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755534Ab1HWROD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 13:14:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Hemant Pedanekar <hemantp@ti.com>

This patch integrates TI816X and TI814X hwmods into hwmods framework.

Note that a TI81XX specific function ti81xx_cm_wait_module_ready() is added to
wait for module to become ready since corresponding OMAP2/3 function
omap2_cm_wait_module_ready() cannot be used as there are no IDLEST registers in
TI81XX.

Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
---
 arch/arm/mach-omap2/Makefile                 |    2 +
 arch/arm/mach-omap2/cm2xxx_3xxx.h            |    1 +
 arch/arm/mach-omap2/cm81xx.c                 |   54 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/io.c                     |    1 +
 arch/arm/mach-omap2/omap_hwmod.c             |   13 ++++--
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 6 files changed, 68 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-omap2/cm81xx.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 087412a..7c340e0 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -80,6 +80,7 @@ endif
 obj-$(CONFIG_ARCH_OMAP2)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o \
 					   vc3xxx_data.o vp3xxx_data.o
+obj-$(CONFIG_SOC_OMAPTI81XX)		+= cm81xx.o
 # XXX The presence of cm2xxx_3xxx.o on the line below is temporary and
 # will be removed once the OMAP4 part of the codebase is converted to
 # use OMAP4-specific PRCM functions.
@@ -161,6 +162,7 @@ obj-$(CONFIG_SOC_OMAP2430)		+= omap_hwmod_2xxx_ipblock_data.o \
 obj-$(CONFIG_ARCH_OMAP3)		+= omap_hwmod_2xxx_3xxx_ipblock_data.o \
 					   omap_hwmod_2xxx_3xxx_interconnect_data.o \
 					   omap_hwmod_3xxx_data.o
+obj-$(CONFIG_SOC_OMAPTI81XX)		+= omap_hwmod_81xx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= omap_hwmod_44xx_data.o
 
 # EMU peripherals
diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.h b/arch/arm/mach-omap2/cm2xxx_3xxx.h
index 11401c1..e11d4ee 100644
--- a/arch/arm/mach-omap2/cm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/cm2xxx_3xxx.h
@@ -122,6 +122,7 @@ extern void omap3xxx_cm_clkdm_disable_hwsup(s16 module, u32 mask);
 extern void omap3xxx_cm_clkdm_force_sleep(s16 module, u32 mask);
 extern void omap3xxx_cm_clkdm_force_wakeup(s16 module, u32 mask);
 
+extern int ti81xx_cm_wait_module_ready(u16 inst, u16 clkctrl_reg);
 extern void ti816x_cm_clkdm_enable_hwsup(s16 inst, u16 clkdm, u32 mask);
 extern void ti816x_cm_clkdm_disable_hwsup(s16 inst, u16 clkdm, u32 mask);
 extern void ti816x_cm_clkdm_force_sleep(s16 inst, u16 clkdm, u32 mask);
diff --git a/arch/arm/mach-omap2/cm81xx.c b/arch/arm/mach-omap2/cm81xx.c
new file mode 100644
index 0000000..84d1645
--- /dev/null
+++ b/arch/arm/mach-omap2/cm81xx.c
@@ -0,0 +1,54 @@
+/*
+ * TI81XX CM module functions
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
+#include "cm816x.h"
+
+/**
+ * ti81xx_cm_wait_module_ready - wait for a module to be in 'func' state
+ * @inst: Offset of CM instance associated with
+ * @clkctrl_reg: CLKCTRL offset from CM instance base
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
+int ti81xx_cm_wait_module_ready(u16 inst, u16 clkctrl_reg)
+{
+	int i = 0;
+
+	omap_test_timeout((
+		((__raw_readl(TI816X_CM_REGADDR(inst, clkctrl_reg)) &
+		  TI816X_IDLEST_MASK) == 0)), MAX_MODULE_READY_TIME, i);
+
+	return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
+}
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 969b730..525ec63 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -354,6 +354,7 @@ void __init omap2_init_common_infrastructure(void)
 		omap3xxx_clockdomains_init();
 		ti816x_clockdomains_init();
 		omap3xxx_hwmod_init();
+		ti81xx_hwmod_init();
 	} else if (cpu_is_omap44xx()) {
 		omap44xx_powerdomains_init();
 		omap44xx_clockdomains_init();
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 84cc0bd..49fbd4da 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1051,7 +1051,7 @@ static struct omap_hwmod *_lookup(const char *name)
  */
 static int _init_clkdm(struct omap_hwmod *oh)
 {
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
+	if (cpu_is_omap24xx() || (cpu_is_omap34xx() && !cpu_is_ti81xx()))
 		return 0;
 
 	if (!oh->clkdm_name) {
@@ -1134,9 +1134,14 @@ static int _wait_target_ready(struct omap_hwmod *oh)
 	/* XXX check clock enable states */
 
 	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-		ret = omap2_cm_wait_module_ready(oh->prcm.omap2.module_offs,
-						 oh->prcm.omap2.idlest_reg_id,
-						 oh->prcm.omap2.idlest_idle_bit);
+		if (cpu_is_ti81xx())
+			ret = ti81xx_cm_wait_module_ready(oh->clkdm->cm_inst,
+						oh->prcm.omap4.clkctrl_offs);
+		else
+			ret = omap2_cm_wait_module_ready(
+						oh->prcm.omap2.module_offs,
+						oh->prcm.omap2.idlest_reg_id,
+						oh->prcm.omap2.idlest_idle_bit);
 	} else if (cpu_is_omap44xx()) {
 		if (!oh->clkdm)
 			return -EINVAL;
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 0e329ca..901d277 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -615,5 +615,6 @@ extern int omap2420_hwmod_init(void);
 extern int omap2430_hwmod_init(void);
 extern int omap3xxx_hwmod_init(void);
 extern int omap44xx_hwmod_init(void);
+extern int ti81xx_hwmod_init(void);
 
 #endif
-- 
1.7.3.5

