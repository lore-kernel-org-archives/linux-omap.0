From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 22/55] ARM: OMAP2: CM: move cm2xxx.h header to a public location
Date: Mon, 31 Mar 2014 18:16:01 +0300
Message-ID: <1396278994-12624-23-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58771 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483AbaCaPSB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Mar 2014 11:18:01 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

This file needs to be accessible from the PRCM core and mach-omap2 board
support code.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm2xxx.c      |    2 +-
 arch/arm/mach-omap2/cm2xxx.h      |   52 +--------------------------
 arch/arm/mach-omap2/cm_common.c   |    2 +-
 include/linux/power/omap/cm2xxx.h |   70 +++++++++++++++++++++++++++++++++++++
 4 files changed, 73 insertions(+), 53 deletions(-)
 create mode 100644 include/linux/power/omap/cm2xxx.h

diff --git a/arch/arm/mach-omap2/cm2xxx.c b/arch/arm/mach-omap2/cm2xxx.c
index e74484a..6f04031 100644
--- a/arch/arm/mach-omap2/cm2xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx.c
@@ -21,7 +21,7 @@
 #include "prm2xxx.h"
 #include "cm.h"
 #include "cm2xxx_3xxx_private.h"
-#include "cm2xxx.h"
+#include <linux/power/omap/cm2xxx.h>
 #include "clockdomain.h"
 
 /* CM_AUTOIDLE_PLL.AUTO_* bit values for DPLLs */
diff --git a/arch/arm/mach-omap2/cm2xxx.h b/arch/arm/mach-omap2/cm2xxx.h
index 891d81c..5eaa007 100644
--- a/arch/arm/mach-omap2/cm2xxx.h
+++ b/arch/arm/mach-omap2/cm2xxx.h
@@ -18,61 +18,11 @@
 
 #include "prcm-common.h"
 #include "cm2xxx_3xxx.h"
+#include <linux/power/omap/cm2xxx.h>
 
 #define OMAP2420_CM_REGADDR(module, reg)				\
 			OMAP2_L4_IO_ADDRESS(OMAP2420_CM_BASE + (module) + (reg))
 #define OMAP2430_CM_REGADDR(module, reg)				\
 			OMAP2_L4_IO_ADDRESS(OMAP2430_CM_BASE + (module) + (reg))
 
-/*
- * Module specific CM register offsets from CM_BASE + domain offset
- * Use cm_{read,write}_mod_reg() with these registers.
- * These register offsets generally appear in more than one PRCM submodule.
- */
-
-/* OMAP2-specific register offsets */
-
-#define OMAP24XX_CM_FCLKEN2				0x0004
-#define OMAP24XX_CM_ICLKEN4				0x001c
-#define OMAP24XX_CM_AUTOIDLE4				0x003c
-#define OMAP24XX_CM_IDLEST4				0x002c
-
-/* CM_IDLEST bit field values to indicate deasserted IdleReq */
-
-#define OMAP24XX_CM_IDLEST_VAL				0
-
-
-/* Clock management domain register get/set */
-
-#ifndef __ASSEMBLER__
-
-extern void omap2xxx_cm_clkdm_enable_hwsup(s16 module, u32 mask);
-extern void omap2xxx_cm_clkdm_disable_hwsup(s16 module, u32 mask);
-
-extern void omap2xxx_cm_set_dpll_disable_autoidle(void);
-extern void omap2xxx_cm_set_dpll_auto_low_power_stop(void);
-
-extern void omap2xxx_cm_set_apll54_disable_autoidle(void);
-extern void omap2xxx_cm_set_apll54_auto_low_power_stop(void);
-extern void omap2xxx_cm_set_apll96_disable_autoidle(void);
-extern void omap2xxx_cm_set_apll96_auto_low_power_stop(void);
-
-extern bool omap2xxx_cm_is_clkdm_in_hwsup(s16 module, u32 mask);
-extern int omap2xxx_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id,
-					 u8 idlest_shift);
-extern int omap2xxx_cm_split_idlest_reg(void __iomem *idlest_reg,
-					s16 *prcm_inst, u8 *idlest_reg_id);
-extern int omap2xxx_cm_fclks_active(void);
-extern int omap2xxx_cm_mpu_retention_allowed(void);
-extern u32 omap2xxx_cm_get_core_clk_src(void);
-extern u32 omap2xxx_cm_get_core_pll_config(void);
-extern u32 omap2xxx_cm_get_pll_config(void);
-extern u32 omap2xxx_cm_get_pll_status(void);
-extern void omap2xxx_cm_set_mod_dividers(u32 mpu, u32 dsp, u32 gfx, u32 core,
-					 u32 mdm);
-
-extern int __init omap2xxx_cm_init(void);
-
-#endif
-
 #endif
diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_common.c
index c334d38..9a53eb5 100644
--- a/arch/arm/mach-omap2/cm_common.c
+++ b/arch/arm/mach-omap2/cm_common.c
@@ -16,7 +16,7 @@
 #include <linux/errno.h>
 #include <linux/of.h>
 
-#include "cm2xxx.h"
+#include <linux/power/omap/cm2xxx.h>
 #include "cm3xxx.h"
 #include "cm44xx.h"
 
diff --git a/include/linux/power/omap/cm2xxx.h b/include/linux/power/omap/cm2xxx.h
new file mode 100644
index 0000000..df496b4
--- /dev/null
+++ b/include/linux/power/omap/cm2xxx.h
@@ -0,0 +1,70 @@
+/*
+ * OMAP2xxx Clock Management (CM) register definitions
+ *
+ * Copyright (C) 2007-2009, 2012 Texas Instruments, Inc.
+ * Copyright (C) 2007-2010 Nokia Corporation
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * The CM hardware modules on the OMAP2/3 are quite similar to each
+ * other.  The CM modules/instances on OMAP4 are quite different, so
+ * they are handled in a separate file.
+ */
+#ifndef __LINUX_POWER_OMAP_CM2XXX_H
+#define __LINUX_POWER_OMAP_CM2XXX_H
+
+/*
+ * Module specific CM register offsets from CM_BASE + domain offset
+ * Use cm_{read,write}_mod_reg() with these registers.
+ * These register offsets generally appear in more than one PRCM submodule.
+ */
+
+/* OMAP2-specific register offsets */
+
+#define OMAP24XX_CM_FCLKEN2				0x0004
+#define OMAP24XX_CM_ICLKEN4				0x001c
+#define OMAP24XX_CM_AUTOIDLE4				0x003c
+#define OMAP24XX_CM_IDLEST4				0x002c
+
+/* CM_IDLEST bit field values to indicate deasserted IdleReq */
+
+#define OMAP24XX_CM_IDLEST_VAL				0
+
+
+/* Clock management domain register get/set */
+
+#ifndef __ASSEMBLER__
+
+void omap2xxx_cm_clkdm_enable_hwsup(s16 module, u32 mask);
+void omap2xxx_cm_clkdm_disable_hwsup(s16 module, u32 mask);
+
+void omap2xxx_cm_set_dpll_disable_autoidle(void);
+void omap2xxx_cm_set_dpll_auto_low_power_stop(void);
+
+void omap2xxx_cm_set_apll54_disable_autoidle(void);
+void omap2xxx_cm_set_apll54_auto_low_power_stop(void);
+void omap2xxx_cm_set_apll96_disable_autoidle(void);
+void omap2xxx_cm_set_apll96_auto_low_power_stop(void);
+
+bool omap2xxx_cm_is_clkdm_in_hwsup(s16 module, u32 mask);
+int omap2xxx_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id,
+				  u8 idlest_shift);
+int omap2xxx_cm_split_idlest_reg(void __iomem *idlest_reg,
+				 s16 *prcm_inst, u8 *idlest_reg_id);
+int omap2xxx_cm_fclks_active(void);
+int omap2xxx_cm_mpu_retention_allowed(void);
+u32 omap2xxx_cm_get_core_clk_src(void);
+u32 omap2xxx_cm_get_core_pll_config(void);
+u32 omap2xxx_cm_get_pll_config(void);
+u32 omap2xxx_cm_get_pll_status(void);
+void omap2xxx_cm_set_mod_dividers(u32 mpu, u32 dsp, u32 gfx, u32 core,
+				  u32 mdm);
+
+int __init omap2xxx_cm_init(void);
+
+#endif
+
+#endif
-- 
1.7.9.5

