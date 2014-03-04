From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 07/18] ARM: OMAP2/3: CM: remove direct register access macros from common header
Date: Tue, 4 Mar 2014 18:19:07 +0200
Message-ID: <1393949958-816-8-git-send-email-t-kristo@ti.com>
References: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48473 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754422AbaCDQUW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Mar 2014 11:20:22 -0500
In-Reply-To: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, khilman@linaro.org
Cc: linux-arm-kernel@lists.infradead.org

Done in preparation to move CM to be a driver of its own. This patch causes
currently a build breakage which will be addressed in next patches.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm2xxx.c              |    1 +
 arch/arm/mach-omap2/cm2xxx_3xxx.h         |   48 -------------------
 arch/arm/mach-omap2/cm2xxx_3xxx_private.h |   74 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/cm3xxx.c              |    1 +
 arch/arm/mach-omap2/prm3xxx.c             |    2 +-
 5 files changed, 77 insertions(+), 49 deletions(-)
 create mode 100644 arch/arm/mach-omap2/cm2xxx_3xxx_private.h

diff --git a/arch/arm/mach-omap2/cm2xxx.c b/arch/arm/mach-omap2/cm2xxx.c
index 8be6ea5..4c29f63 100644
--- a/arch/arm/mach-omap2/cm2xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx.c
@@ -20,6 +20,7 @@
 
 #include "prm2xxx.h"
 #include "cm.h"
+#include "cm2xxx_3xxx_private.h"
 #include "cm2xxx.h"
 #include "cm-regbits-24xx.h"
 #include "clockdomain.h"
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
diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx_private.h b/arch/arm/mach-omap2/cm2xxx_3xxx_private.h
new file mode 100644
index 0000000..9131829
--- /dev/null
+++ b/arch/arm/mach-omap2/cm2xxx_3xxx_private.h
@@ -0,0 +1,74 @@
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
+#ifndef __ARCH_ARM_MACH_OMAP2_CM2XXX_3XXX_PRIVATE_H
+#define __ARCH_ARM_MACH_OMAP2_CM2XXX_3XXX_PRIVATE_H
+
+#include "cm.h"
+#include "cm2xxx_3xxx.h"
+
+#ifndef __ASSEMBLER__
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
+
+#endif
+
+#endif
diff --git a/arch/arm/mach-omap2/cm3xxx.c b/arch/arm/mach-omap2/cm3xxx.c
index 129a4e7..989590e 100644
--- a/arch/arm/mach-omap2/cm3xxx.c
+++ b/arch/arm/mach-omap2/cm3xxx.c
@@ -20,6 +20,7 @@
 
 #include "prm2xxx_3xxx.h"
 #include "cm.h"
+#include "cm2xxx_3xxx_private.h"
 #include "cm3xxx.h"
 #include "cm-regbits-34xx.h"
 #include "clockdomain.h"
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index 92ab46a..6dfa95c 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -24,7 +24,7 @@
 #include "powerdomain.h"
 #include "prm3xxx.h"
 #include "prm2xxx_3xxx.h"
-#include "cm2xxx_3xxx.h"
+#include "cm2xxx_3xxx_private.h"
 #include "prm-regbits-34xx.h"
 #include "cm3xxx.h"
 #include "cm-regbits-34xx.h"
-- 
1.7.9.5

