From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 11/11] ARM: OMAP2+: CM: move direct register write macros to internal header
Date: Fri, 11 Oct 2013 19:15:41 +0300
Message-ID: <1381508141-15244-12-git-send-email-t-kristo@ti.com>
References: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54843 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758558Ab3JKQQj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Oct 2013 12:16:39 -0400
In-Reply-To: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@linaro.org, paul@pwsan.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org

The direct register access macros should not be exposed to CM clients.
Thus, move the register macros to their own file and only include these
to the cm_*.c files.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm2xxx.c      |    1 +
 arch/arm/mach-omap2/cm2xxx_3xxx.h |   48 --------------------------
 arch/arm/mach-omap2/cm3xxx.c      |    1 +
 arch/arm/mach-omap2/cm_internal.h |   67 +++++++++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+), 48 deletions(-)
 create mode 100644 arch/arm/mach-omap2/cm_internal.h

diff --git a/arch/arm/mach-omap2/cm2xxx.c b/arch/arm/mach-omap2/cm2xxx.c
index ce25abb..c7facf1 100644
--- a/arch/arm/mach-omap2/cm2xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx.c
@@ -26,6 +26,7 @@
 #include "cm2xxx.h"
 #include "cm-regbits-24xx.h"
 #include "clockdomain.h"
+#include "cm_internal.h"
 
 /* CM_AUTOIDLE_PLL.AUTO_* bit values for DPLLs */
 #define DPLL_AUTOIDLE_DISABLE				0x0
diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.h b/arch/arm/mach-omap2/cm2xxx_3xxx.h
index bfbd16f..b40b5bd 100644
--- a/arch/arm/mach-omap2/cm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/cm2xxx_3xxx.h
@@ -48,54 +48,6 @@
 
 #ifndef __ASSEMBLER__
 
-#include <linux/io.h>
-
-static inline u32 omap2_cm_read_mod_reg(s16 module, u16 idx)
-{
-	return __raw_readl(cm_base + module + idx);
-}
-
-static inline void omap2_cm_write_mod_reg(u32 val, s16 module, u16 idx)
-{
-	__raw_writel(val, cm_base + module + idx);
-}
-
-/* Read-modify-write a register in a CM module. Caller must lock */
-static inline u32 omap2_cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module,
-					    s16 idx)
-{
-	u32 v;
-
-	v = omap2_cm_read_mod_reg(module, idx);
-	v &= ~mask;
-	v |= bits;
-	omap2_cm_write_mod_reg(v, module, idx);
-
-	return v;
-}
-
-/* Read a CM register, AND it, and shift the result down to bit 0 */
-static inline u32 omap2_cm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
-{
-	u32 v;
-
-	v = omap2_cm_read_mod_reg(domain, idx);
-	v &= mask;
-	v >>= __ffs(mask);
-
-	return v;
-}
-
-static inline u32 omap2_cm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
-{
-	return omap2_cm_rmw_mod_reg_bits(bits, bits, module, idx);
-}
-
-static inline u32 omap2_cm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
-{
-	return omap2_cm_rmw_mod_reg_bits(bits, 0x0, module, idx);
-}
-
 extern int omap2xxx_cm_apll54_enable(void);
 extern void omap2xxx_cm_apll54_disable(void);
 extern int omap2xxx_cm_apll96_enable(void);
diff --git a/arch/arm/mach-omap2/cm3xxx.c b/arch/arm/mach-omap2/cm3xxx.c
index b0509b9..ccd29ba 100644
--- a/arch/arm/mach-omap2/cm3xxx.c
+++ b/arch/arm/mach-omap2/cm3xxx.c
@@ -26,6 +26,7 @@
 #include "cm3xxx.h"
 #include "cm-regbits-34xx.h"
 #include "clockdomain.h"
+#include "cm_internal.h"
 
 static const u8 omap3xxx_cm_idlest_offs[] = {
 	CM_IDLEST1, CM_IDLEST2, OMAP2430_CM_IDLEST3
diff --git a/arch/arm/mach-omap2/cm_internal.h b/arch/arm/mach-omap2/cm_internal.h
new file mode 100644
index 0000000..929157d
--- /dev/null
+++ b/arch/arm/mach-omap2/cm_internal.h
@@ -0,0 +1,67 @@
+/*
+ * OMAP2+ Clock Management (CM) internal header
+ *
+ * Copyright (C) 2007-2013 Texas Instruments, Inc.
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
+
+#ifndef __ARCH_ARM_MACH_OMAP2_CM_INTERNAL_H
+#define __ARCH_ARM_MACH_OMAP2_CM_INTERNAL_H
+
+#include <linux/io.h>
+
+static inline u32 omap2_cm_read_mod_reg(s16 module, u16 idx)
+{
+	return __raw_readl(cm_base + module + idx);
+}
+
+static inline void omap2_cm_write_mod_reg(u32 val, s16 module, u16 idx)
+{
+	__raw_writel(val, cm_base + module + idx);
+}
+
+/* Read-modify-write a register in a CM module. Caller must lock */
+static inline u32 omap2_cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module,
+					    s16 idx)
+{
+	u32 v;
+
+	v = omap2_cm_read_mod_reg(module, idx);
+	v &= ~mask;
+	v |= bits;
+	omap2_cm_write_mod_reg(v, module, idx);
+
+	return v;
+}
+
+/* Read a CM register, AND it, and shift the result down to bit 0 */
+static inline u32 omap2_cm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
+{
+	u32 v;
+
+	v = omap2_cm_read_mod_reg(domain, idx);
+	v &= mask;
+	v >>= __ffs(mask);
+
+	return v;
+}
+
+static inline u32 omap2_cm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
+{
+	return omap2_cm_rmw_mod_reg_bits(bits, bits, module, idx);
+}
+
+static inline u32 omap2_cm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
+{
+	return omap2_cm_rmw_mod_reg_bits(bits, 0x0, module, idx);
+}
+#endif
-- 
1.7.9.5

