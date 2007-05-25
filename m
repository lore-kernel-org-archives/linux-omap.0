From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 04/18] omap2: add OMAP24XX Clock Management register defines
Date: Fri, 25 May 2007 02:23:26 -0600
Message-ID: <20070525082501.568932563@pwsan.com>
References: <20070525082322.168056647@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline;
	filename=0004-omap2-add-OMAP24XX-Clock-Management-register-define.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Add symbolic constants for OMAP24XX Clock Management registers,
along with read/write functions.  The registers are divided into two
groups: global registers and module registers.  Global registers appear
only once on the chip, and are used with cm_{read,write}_reg().  Module
registers generally appear more than once, in different OMAP modules,
and have similar functions in each module.  They are used with
cm_{read,write}_mod_reg().

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/cm.h |   94 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 94 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/cm.h

diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
new file mode 100644
index 0000000..4c9a7c7
--- /dev/null
+++ b/arch/arm/mach-omap2/cm.h
@@ -0,0 +1,94 @@
+#ifndef __ARCH_ASM_MACH_OMAP2_CM_H
+#define __ARCH_ASM_MACH_OMAP2_CM_H
+
+/*
+ * OMAP2 Clock Management (CM) register definitions
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
+#define OMAP_CM_REGADDR(module, reg)	 (void __iomem *)IO_ADDRESS(OMAP2_CM_BASE + module + reg)
+
+/*
+ * Architecture-specific global CM registers
+ * Use cm_{read,write}_reg() with these registers.
+ */
+
+/* None currently */
+
+/* Clock management global register get/set */
+
+static void __attribute__((unused)) cm_write_reg(u32 val, void __iomem *addr)
+{
+	pr_debug("cm_write_reg: writing 0x%0x to 0x%0x\n", val, (u32)addr);
+
+	__raw_writel(val, addr);
+}
+
+static u32 __attribute__((unused)) cm_read_reg(void __iomem *addr)
+{
+	return __raw_readl(addr);
+}
+
+
+/*
+ * Module specific CM registers from CM_BASE + domain offset
+ * Use cm_{read,write}_mod_reg() with these registers.
+ */
+
+/* Common between 24xx and 34xx */
+
+#define CM_FCLKEN1					0x0000
+#define CM_CLKEN					CM_FCLKEN1
+#define CM_ICLKEN1					0x0010
+#define CM_ICLKEN					CM_ICLKEN1
+#define CM_ICLKEN2					0x0014
+#define CM_IDLEST1					0x0020
+#define CM_IDLEST                                       CM_IDLEST1
+#define CM_IDLEST2					0x0024
+#define CM_AUTOIDLE					0x0030
+#define CM_AUTOIDLE1					0x0030
+#define CM_AUTOIDLE2					0x0034
+#define CM_CLKSEL					0x0040
+#define CM_CLKSEL1					CM_CLKSEL
+#define CM_CLKSEL2					0x0044
+#define CM_CLKSTCTRL					0x0048
+
+
+/* Architecture-specific registers */
+
+#define OMAP24XX_CM_FCLKEN				CM_FCLKEN1
+#define OMAP24XX_CM_FCLKEN2				0x0004
+#define OMAP24XX_CM_ICLKEN4				0x001c
+#define OMAP24XX_CM_AUTOIDLE3				0x0038
+#define OMAP24XX_CM_AUTOIDLE4				0x003c
+
+#define OMAP2430_CM_ICLKEN3				0x0018
+#define OMAP2430_CM_IDLEST3				0x0028
+
+
+/* Clock management domain register get/set */
+
+static void __attribute__((unused)) cm_write_mod_reg(u32 val, s16 module, s16 idx)
+{
+	cm_write_reg(val, OMAP_CM_REGADDR(module, idx));
+}
+
+static u32 __attribute__((unused)) cm_read_mod_reg(s16 module, s16 idx)
+{
+	return cm_read_reg(OMAP_CM_REGADDR(module, idx));
+}
+
+#endif
-- 
1.5.1.3

-- 
