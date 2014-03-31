From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 24/55] ARM: OMAP3: CM: move cm3xxx.h header to public location
Date: Mon, 31 Mar 2014 18:16:03 +0300
Message-ID: <1396278994-12624-25-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54697 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753829AbaCaPSK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Mar 2014 11:18:10 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

This file needs to be accessible from the PRCM core and mach-omap2 board
support code.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm3xxx.c      |    2 +-
 arch/arm/mach-omap2/cm3xxx.h      |   66 +----------------------------
 arch/arm/mach-omap2/cm_common.c   |    2 +-
 arch/arm/mach-omap2/prm3xxx.c     |    2 +-
 include/linux/power/omap/cm3xxx.h |   82 +++++++++++++++++++++++++++++++++++++
 5 files changed, 86 insertions(+), 68 deletions(-)
 create mode 100644 include/linux/power/omap/cm3xxx.h

diff --git a/arch/arm/mach-omap2/cm3xxx.c b/arch/arm/mach-omap2/cm3xxx.c
index 859c2fd..cbba617 100644
--- a/arch/arm/mach-omap2/cm3xxx.c
+++ b/arch/arm/mach-omap2/cm3xxx.c
@@ -21,7 +21,7 @@
 #include "prm2xxx_3xxx.h"
 #include "cm.h"
 #include "cm2xxx_3xxx_private.h"
-#include "cm3xxx.h"
+#include <linux/power/omap/cm3xxx.h>
 #include "clockdomain.h"
 
 #define OMAP34XX_CLKSTCTRL_DISABLE_AUTO		0x0
diff --git a/arch/arm/mach-omap2/cm3xxx.h b/arch/arm/mach-omap2/cm3xxx.h
index 0301557..9c2047f 100644
--- a/arch/arm/mach-omap2/cm3xxx.h
+++ b/arch/arm/mach-omap2/cm3xxx.h
@@ -18,73 +18,9 @@
 
 #include "prcm-common.h"
 #include "cm2xxx_3xxx.h"
+#include <linux/power/omap/cm3xxx.h>
 
 #define OMAP34XX_CM_REGADDR(module, reg)				\
 			OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE + (module) + (reg))
 
-
-/*
- * OMAP3-specific global CM registers
- * Use cm_{read,write}_reg() with these registers.
- * These registers appear once per CM module.
- */
-
-#define OMAP3430_CM_SYSCONFIG		0x0010
-#define OMAP3430_CM_POLCTRL		0x009c
-
-#define OMAP3_CM_CLKOUT_CTRL_OFFSET	0x0070
-
-/*
- * Module specific CM register offsets from CM_BASE + domain offset
- * Use cm_{read,write}_mod_reg() with these registers.
- * These register offsets generally appear in more than one PRCM submodule.
- */
-
-/* OMAP3-specific register offsets */
-
-#define OMAP3430_CM_CLKEN_PLL				0x0004
-#define OMAP3430ES2_CM_CLKEN2				0x0004
-#define OMAP3430ES2_CM_FCLKEN3				0x0008
-#define OMAP3430_CM_IDLEST_PLL				CM_IDLEST2
-#define OMAP3430_CM_AUTOIDLE_PLL			CM_AUTOIDLE2
-#define OMAP3430ES2_CM_AUTOIDLE2_PLL			CM_AUTOIDLE2
-#define OMAP3430_CM_CLKSEL1				CM_CLKSEL
-#define OMAP3430_CM_CLKSEL1_PLL				CM_CLKSEL
-#define OMAP3430_CM_CLKSEL2_PLL				CM_CLKSEL2
-#define OMAP3430_CM_SLEEPDEP				CM_CLKSEL2
-#define OMAP3430_CM_CLKSEL3				OMAP2_CM_CLKSTCTRL
-#define OMAP3430_CM_CLKSTST				0x004c
-#define OMAP3430ES2_CM_CLKSEL4				0x004c
-#define OMAP3430ES2_CM_CLKSEL5				0x0050
-#define OMAP3430_CM_CLKSEL2_EMU				0x0050
-#define OMAP3430_CM_CLKSEL3_EMU				0x0054
-
-
-/* CM_IDLEST bit field values to indicate deasserted IdleReq */
-
-#define OMAP34XX_CM_IDLEST_VAL				1
-
-
-#ifndef __ASSEMBLER__
-
-extern void omap3xxx_cm_clkdm_enable_hwsup(s16 module, u32 mask);
-extern void omap3xxx_cm_clkdm_disable_hwsup(s16 module, u32 mask);
-extern void omap3xxx_cm_clkdm_force_sleep(s16 module, u32 mask);
-extern void omap3xxx_cm_clkdm_force_wakeup(s16 module, u32 mask);
-
-extern bool omap3xxx_cm_is_clkdm_in_hwsup(s16 module, u32 mask);
-extern int omap3xxx_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id,
-					 u8 idlest_shift);
-
-extern int omap3xxx_cm_split_idlest_reg(void __iomem *idlest_reg,
-					s16 *prcm_inst, u8 *idlest_reg_id);
-
-extern void omap3_cm_save_context(void);
-extern void omap3_cm_restore_context(void);
-extern void omap3_cm_save_scratchpad_contents(u32 *ptr);
-
-extern int __init omap3xxx_cm_init(void);
-
-#endif
-
 #endif
diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_common.c
index 9a53eb5..f8f9343 100644
--- a/arch/arm/mach-omap2/cm_common.c
+++ b/arch/arm/mach-omap2/cm_common.c
@@ -17,7 +17,7 @@
 #include <linux/of.h>
 
 #include <linux/power/omap/cm2xxx.h>
-#include "cm3xxx.h"
+#include <linux/power/omap/cm3xxx.h>
 #include "cm44xx.h"
 
 /*
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index 852bc4d..4700605 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -23,7 +23,7 @@
 #include "prm3xxx.h"
 #include "prm2xxx_3xxx_private.h"
 #include "cm2xxx_3xxx_private.h"
-#include "cm3xxx.h"
+#include <linux/power/omap/cm3xxx.h>
 
 #define OMAP3430_GLOBAL_COLD_RST_MASK			(1 << 0)
 #define OMAP3430_GLOBAL_COLD_RST_SHIFT			0
diff --git a/include/linux/power/omap/cm3xxx.h b/include/linux/power/omap/cm3xxx.h
new file mode 100644
index 0000000..ef3204b
--- /dev/null
+++ b/include/linux/power/omap/cm3xxx.h
@@ -0,0 +1,82 @@
+/*
+ * OMAP2/3 Clock Management (CM) register definitions
+ *
+ * Copyright (C) 2007-2009 Texas Instruments, Inc.
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
+#ifndef __LINUX_POWER_OMAP_CM3XXX_H
+#define __LINUX_POWER_OMAP_CM3XXX_H
+
+/*
+ * OMAP3-specific global CM registers
+ * Use cm_{read,write}_reg() with these registers.
+ * These registers appear once per CM module.
+ */
+
+#define OMAP3430_CM_SYSCONFIG		0x0010
+#define OMAP3430_CM_POLCTRL		0x009c
+
+#define OMAP3_CM_CLKOUT_CTRL_OFFSET	0x0070
+
+/*
+ * Module specific CM register offsets from CM_BASE + domain offset
+ * Use cm_{read,write}_mod_reg() with these registers.
+ * These register offsets generally appear in more than one PRCM submodule.
+ */
+
+/* OMAP3-specific register offsets */
+
+#define OMAP3430_CM_CLKEN_PLL				0x0004
+#define OMAP3430ES2_CM_CLKEN2				0x0004
+#define OMAP3430ES2_CM_FCLKEN3				0x0008
+#define OMAP3430_CM_IDLEST_PLL				CM_IDLEST2
+#define OMAP3430_CM_AUTOIDLE_PLL			CM_AUTOIDLE2
+#define OMAP3430ES2_CM_AUTOIDLE2_PLL			CM_AUTOIDLE2
+#define OMAP3430_CM_CLKSEL1				CM_CLKSEL
+#define OMAP3430_CM_CLKSEL1_PLL				CM_CLKSEL
+#define OMAP3430_CM_CLKSEL2_PLL				CM_CLKSEL2
+#define OMAP3430_CM_SLEEPDEP				CM_CLKSEL2
+#define OMAP3430_CM_CLKSEL3				OMAP2_CM_CLKSTCTRL
+#define OMAP3430_CM_CLKSTST				0x004c
+#define OMAP3430ES2_CM_CLKSEL4				0x004c
+#define OMAP3430ES2_CM_CLKSEL5				0x0050
+#define OMAP3430_CM_CLKSEL2_EMU				0x0050
+#define OMAP3430_CM_CLKSEL3_EMU				0x0054
+
+
+/* CM_IDLEST bit field values to indicate deasserted IdleReq */
+
+#define OMAP34XX_CM_IDLEST_VAL				1
+
+#ifndef __ASSEMBLER__
+
+void omap3xxx_cm_clkdm_enable_hwsup(s16 module, u32 mask);
+void omap3xxx_cm_clkdm_disable_hwsup(s16 module, u32 mask);
+void omap3xxx_cm_clkdm_force_sleep(s16 module, u32 mask);
+void omap3xxx_cm_clkdm_force_wakeup(s16 module, u32 mask);
+
+bool omap3xxx_cm_is_clkdm_in_hwsup(s16 module, u32 mask);
+int omap3xxx_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id,
+				  u8 idlest_shift);
+
+int omap3xxx_cm_split_idlest_reg(void __iomem *idlest_reg,
+				 s16 *prcm_inst, u8 *idlest_reg_id);
+
+void omap3_cm_save_context(void);
+void omap3_cm_restore_context(void);
+void omap3_cm_save_scratchpad_contents(u32 *ptr);
+
+int __init omap3xxx_cm_init(void);
+
+#endif
+
+#endif
-- 
1.7.9.5

