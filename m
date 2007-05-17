From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 05/18] omap2: add OMAP24XX Power/Reset Management register
	defines
Date: Wed, 16 May 2007 18:11:37 -0600
Message-ID: <20070517005443.669115597@pwsan.com>
References: <20070517001132.652728079@pwsan.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline;
	filename=0005-omap2-add-OMAP24XX-Power-Reset-Management-register.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Add symbolic constants for OMAP24XX Power/Reset Management registers,
along with read/write functions.  The registers are divided into two
groups: global registers and module registers.  Global registers appear
only once on the chip, and are used with prm_{read,write}_reg().  Module
registers generally appear more than once, in different OMAP modules,
and have similar functions in each module.  They are used with
prm_{read,write}_mod_reg().

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/prm.h |  119 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 119 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/prm.h

diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
new file mode 100644
index 0000000..70fb9de
--- /dev/null
+++ b/arch/arm/mach-omap2/prm.h
@@ -0,0 +1,119 @@
+#ifndef __ARCH_ARM_MACH_OMAP2_PRM_H
+#define __ARCH_ARM_MACH_OMAP2_PRM_H
+
+/*
+ * OMAP2 Power/Reset Management (PRM) register definitions
+ *
+ * Copyright (C) 2007 Texas Instruments, Inc.
+ * Copyright (C) 2007 Nokia Corporation
+ *
+ * Written by Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <asm/io.h>
+#include "prcm_common.h"
+
+
+#define OMAP_PRM_REGADDR(module, reg)	(void __iomem *)IO_ADDRESS(PRM_BASE + module + reg)
+
+/*
+ * Architecture-specific global PRM registers
+ * Use prm_{read,write}_reg() with these registers.
+ *
+ * With a few exceptions, these are the register names beginning with
+ * PRCM_* on 24xx, and PRM_* on 34xx.  (The exceptions are the
+ * IRQSTATUS and IRQENABLE bits.)
+ *
+ */
+
+#define OMAP24XX_PRCM_REVISION		OMAP_PRM_REGADDR(OCP_MOD, 0x0004)
+#define OMAP24XX_PRCM_SYSCONFIG		OMAP_PRM_REGADDR(OCP_MOD, 0x0014)
+
+#define OMAP24XX_PRCM_IRQSTATUS_MPU	OMAP_PRM_REGADDR(OCP_MOD, 0x0018)
+#define OMAP24XX_PRCM_IRQENABLE_MPU	OMAP_PRM_REGADDR(OCP_MOD, 0x001c)
+
+#define OMAP24XX_PRCM_VOLTCTRL		OMAP_PRM_REGADDR(OCP_MOD, 0x0050)
+#define OMAP24XX_PRCM_VOLTST		OMAP_PRM_REGADDR(OCP_MOD, 0x0054)
+#define OMAP24XX_PRCM_CLKSRC_CTRL	OMAP_PRM_REGADDR(OCP_MOD, 0x0060)
+#define OMAP24XX_PRCM_CLKOUT_CTRL	OMAP_PRM_REGADDR(OCP_MOD, 0x0070)
+#define OMAP24XX_PRCM_CLKEMUL_CTRL	OMAP_PRM_REGADDR(OCP_MOD, 0x0078)
+#define OMAP24XX_PRCM_CLKCFG_CTRL	OMAP_PRM_REGADDR(OCP_MOD, 0x0080)
+#define OMAP24XX_PRCM_CLKCFG_STATUS	OMAP_PRM_REGADDR(OCP_MOD, 0x0084)
+#define OMAP24XX_PRCM_VOLTSETUP		OMAP_PRM_REGADDR(OCP_MOD, 0x0090)
+#define OMAP24XX_PRCM_CLKSSETUP		OMAP_PRM_REGADDR(OCP_MOD, 0x0094)
+#define OMAP24XX_PRCM_POLCTRL		OMAP_PRM_REGADDR(OCP_MOD, 0x0098)
+
+
+/* Power/reset management global register get/set */
+
+static void __attribute__((unused)) prm_write_reg(u32 val, void __iomem *addr)
+{
+	pr_debug("prm_write_reg: writing 0x%0x to 0x%0x\n", val, (u32)addr);
+
+	__raw_writel(val, addr);
+}
+
+static u32 __attribute__((unused)) prm_read_reg(void __iomem *addr)
+{
+	return __raw_readl(addr);
+}
+
+
+/*
+ * Module specific PRM registers from PRM_BASE + domain offset
+ *
+ * Use prm_{read,write}_mod_reg() with these registers.
+ *
+ * With a few exceptions, these are the register names beginning with
+ * {PM,RM}_* on both architectures.  (The exceptions are the IRQSTATUS
+ * and IRQENABLE bits.)
+ *
+ */
+
+/* Registers appearing on both 24xx and 34xx */
+
+#define RM_RSTCTRL					0x0050
+#define RM_RSTTIME					0x0054
+#define RM_RSTST					0x0058
+
+#define PM_WKEN1					0x00a0
+#define PM_WKEN						PM_WKEN1
+#define PM_WKST						0x00b0
+#define PM_WKST1					PM_WKST
+#define PM_WKDEP					0x00c8
+#define PM_EVGENCTRL					0x00d4
+#define PM_EVGENONTIM					0x00d8
+#define PM_EVGENOFFTIM					0x00dc
+#define PM_PWSTCTRL					0x00e0
+#define PM_PWSTST					0x00e4
+
+
+/* Architecture-specific registers */
+
+#define OMAP24XX_PM_WKEN2				0x00a4
+#define OMAP24XX_PM_WKST2				0x00b4
+
+#define OMAP24XX_PRCM_IRQSTATUS_DSP			0x00f0	/* IVA mod */
+#define OMAP24XX_PRCM_IRQENABLE_DSP			0x00f4	/* IVA mod */
+#define OMAP24XX_PRCM_IRQSTATUS_IVA			0x00f8
+#define OMAP24XX_PRCM_IRQENABLE_IVA			0x00fc
+
+
+/* Power/reset management domain register get/set */
+
+static void __attribute__((unused)) prm_write_mod_reg(u32 val, s16 module, s16 idx)
+{
+	prm_write_reg(val, OMAP_PRM_REGADDR(module, idx));
+}
+
+static u32 __attribute__((unused)) prm_read_mod_reg(s16 module, s16 idx)
+{
+	return prm_read_reg(OMAP_PRM_REGADDR(module, idx));
+}
+
+#endif
-- 
1.5.1.3

-- 
