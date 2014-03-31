From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 31/55] ARM: OMAP2: export parts of prm2xxx.h header file
Date: Mon, 31 Mar 2014 18:16:10 +0300
Message-ID: <1396278994-12624-32-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58793 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870AbaCaPSY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Mar 2014 11:18:24 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Some of these are shared between the PRM driver and mach-omap2 board code.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm2xxx.c       |    4 +++-
 arch/arm/mach-omap2/prm2xxx.c      |    2 +-
 arch/arm/mach-omap2/prm2xxx.h      |   20 +-----------------
 arch/arm/mach-omap2/prm_common.c   |    2 +-
 include/linux/power/omap/prm2xxx.h |   39 ++++++++++++++++++++++++++++++++++++
 5 files changed, 45 insertions(+), 22 deletions(-)
 create mode 100644 include/linux/power/omap/prm2xxx.h

diff --git a/arch/arm/mach-omap2/cm2xxx.c b/arch/arm/mach-omap2/cm2xxx.c
index f4a070c..b37783a 100644
--- a/arch/arm/mach-omap2/cm2xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx.c
@@ -18,11 +18,13 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include "prm2xxx.h"
+#include <linux/power/omap/prm2xxx.h>
 #include <linux/power/omap/cm.h>
 #include "cm2xxx_3xxx_private.h"
 #include <linux/power/omap/cm2xxx.h>
 #include "clockdomain.h"
+#include "prcm-common.h"
+#include "prm2xxx_3xxx.h"
 
 /* CM_AUTOIDLE_PLL.AUTO_* bit values for DPLLs */
 #define DPLL_AUTOIDLE_DISABLE				0x0
diff --git a/arch/arm/mach-omap2/prm2xxx.c b/arch/arm/mach-omap2/prm2xxx.c
index 5b5260c..849b415 100644
--- a/arch/arm/mach-omap2/prm2xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx.c
@@ -20,7 +20,7 @@
 
 #include "powerdomain.h"
 #include "clockdomain.h"
-#include "prm2xxx.h"
+#include <linux/power/omap/prm2xxx.h>
 #include "prm2xxx_3xxx_private.h"
 #include <linux/power/omap/cm2xxx_3xxx.h>
 
diff --git a/arch/arm/mach-omap2/prm2xxx.h b/arch/arm/mach-omap2/prm2xxx.h
index 071bb6d..19ff266 100644
--- a/arch/arm/mach-omap2/prm2xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx.h
@@ -19,6 +19,7 @@
 #include "prcm-common.h"
 #include "prm.h"
 #include "prm2xxx_3xxx.h"
+#include <linux/power/omap/prm2xxx.h>
 
 #define OMAP2420_PRM_REGADDR(module, reg)				\
 		OMAP2_L4_IO_ADDRESS(OMAP2420_PRM_BASE + (module) + (reg))
@@ -35,9 +36,7 @@
  *
  */
 
-#define OMAP2_PRCM_REVISION_OFFSET	0x0000
 #define OMAP2420_PRCM_REVISION		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0000)
-#define OMAP2_PRCM_SYSCONFIG_OFFSET	0x0010
 #define OMAP2420_PRCM_SYSCONFIG		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0010)
 
 #define OMAP2_PRCM_IRQSTATUS_MPU_OFFSET	0x0018
@@ -45,11 +44,9 @@
 #define OMAP2_PRCM_IRQENABLE_MPU_OFFSET	0x001c
 #define OMAP2420_PRCM_IRQENABLE_MPU	OMAP2420_PRM_REGADDR(OCP_MOD, 0x001c)
 
-#define OMAP2_PRCM_VOLTCTRL_OFFSET	0x0050
 #define OMAP2420_PRCM_VOLTCTRL		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0050)
 #define OMAP2_PRCM_VOLTST_OFFSET	0x0054
 #define OMAP2420_PRCM_VOLTST		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0054)
-#define OMAP2_PRCM_CLKSRC_CTRL_OFFSET	0x0060
 #define OMAP2420_PRCM_CLKSRC_CTRL	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0060)
 #define OMAP2_PRCM_CLKOUT_CTRL_OFFSET	0x0070
 #define OMAP2420_PRCM_CLKOUT_CTRL	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0070)
@@ -59,9 +56,7 @@
 #define OMAP2420_PRCM_CLKCFG_CTRL	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0080)
 #define OMAP2_PRCM_CLKCFG_STATUS_OFFSET	0x0084
 #define OMAP2420_PRCM_CLKCFG_STATUS	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0084)
-#define OMAP2_PRCM_VOLTSETUP_OFFSET	0x0090
 #define OMAP2420_PRCM_VOLTSETUP		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0090)
-#define OMAP2_PRCM_CLKSSETUP_OFFSET	0x0094
 #define OMAP2420_PRCM_CLKSSETUP		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0094)
 #define OMAP2_PRCM_POLCTRL_OFFSET	0x0098
 #define OMAP2420_PRCM_POLCTRL		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0098)
@@ -119,17 +114,4 @@
 #define OMAP24XX_PRCM_IRQSTATUS_IVA			0x00f8
 #define OMAP24XX_PRCM_IRQENABLE_IVA			0x00fc
 
-#ifndef __ASSEMBLER__
-/* Function prototypes */
-extern int omap2xxx_clkdm_sleep(struct clockdomain *clkdm);
-extern int omap2xxx_clkdm_wakeup(struct clockdomain *clkdm);
-
-extern void omap2xxx_prm_dpll_reset(void);
-void omap2xxx_prm_clear_mod_irqs(s16 module, u8 regs, u32 wkst_mask);
-void omap2xxx_prm_init_pm(void);
-
-extern int __init omap2xxx_prm_init(void);
-
-#endif
-
 #endif
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 090d13f..273a338 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -29,7 +29,7 @@
 #include <linux/clk/ti.h>
 
 #include "prm2xxx_3xxx.h"
-#include "prm2xxx.h"
+#include <linux/power/omap/prm2xxx.h>
 #include "prm3xxx.h"
 #include "prm44xx.h"
 
diff --git a/include/linux/power/omap/prm2xxx.h b/include/linux/power/omap/prm2xxx.h
new file mode 100644
index 0000000..32b76d5
--- /dev/null
+++ b/include/linux/power/omap/prm2xxx.h
@@ -0,0 +1,39 @@
+/*
+ * OMAP2xxx Power/Reset Management (PRM) register definitions
+ *
+ * Copyright (C) 2007-2009, 2011-2012 Texas Instruments, Inc.
+ * Copyright (C) 2008-2010 Nokia Corporation
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * The PRM hardware modules on the OMAP2/3 are quite similar to each
+ * other.  The PRM on OMAP4 has a new register layout, and is handled
+ * in a separate file.
+ */
+#ifndef __LINUX_POWER_OMAP_PRM2XXX_H
+#define __LINUX_POWER_OMAP_PRM2XXX_H
+
+#define OMAP2_PRCM_REVISION_OFFSET		0x0000
+#define OMAP2_PRCM_SYSCONFIG_OFFSET		0x0010
+#define OMAP2_PRCM_VOLTCTRL_OFFSET		0x0050
+#define OMAP2_PRCM_CLKSRC_CTRL_OFFSET		0x0060
+#define OMAP2_PRCM_VOLTSETUP_OFFSET		0x0090
+#define OMAP2_PRCM_CLKSSETUP_OFFSET		0x0094
+
+#ifndef __ASSEMBLER__
+
+struct clockdomain;
+
+/* Function prototypes */
+int omap2xxx_clkdm_sleep(struct clockdomain *clkdm);
+int omap2xxx_clkdm_wakeup(struct clockdomain *clkdm);
+void omap2xxx_prm_dpll_reset(void);
+void omap2xxx_prm_clear_mod_irqs(s16 module, u8 regs, u32 wkst_mask);
+void omap2xxx_prm_init_pm(void);
+int __init omap2xxx_prm_init(void);
+#endif
+
+#endif
-- 
1.7.9.5

