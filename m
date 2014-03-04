From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 14/18] ARM: OMAP2/3: PRM: split PRM header file to common and internal versions
Date: Tue, 4 Mar 2014 18:19:14 +0200
Message-ID: <1393949958-816-15-git-send-email-t-kristo@ti.com>
References: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48494 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754542AbaCDQUe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Mar 2014 11:20:34 -0500
In-Reply-To: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, khilman@linaro.org
Cc: linux-arm-kernel@lists.infradead.org

Internal version contains the direct register access macros and should
only be used by PRCM drivers.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prm2xxx.c              |    2 +-
 arch/arm/mach-omap2/prm2xxx_3xxx.c         |    2 +-
 arch/arm/mach-omap2/prm2xxx_3xxx.h         |   47 -----------------
 arch/arm/mach-omap2/prm2xxx_3xxx_private.h |   77 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm3xxx.c              |    2 +-
 5 files changed, 80 insertions(+), 50 deletions(-)
 create mode 100644 arch/arm/mach-omap2/prm2xxx_3xxx_private.h

diff --git a/arch/arm/mach-omap2/prm2xxx.c b/arch/arm/mach-omap2/prm2xxx.c
index 8d4db6f..45f83dd 100644
--- a/arch/arm/mach-omap2/prm2xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx.c
@@ -23,7 +23,7 @@
 #include "vp.h"
 #include "powerdomain.h"
 #include "clockdomain.h"
-#include "prm2xxx.h"
+#include "prm2xxx_3xxx_private.h"
 #include "cm2xxx_3xxx.h"
 #include "prm-regbits-24xx.h"
 
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index 947f6ad..5209823 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -18,7 +18,7 @@
 
 #include "common.h"
 #include "powerdomain.h"
-#include "prm2xxx_3xxx.h"
+#include "prm2xxx_3xxx_private.h"
 #include "prm-regbits-24xx.h"
 #include "clockdomain.h"
 
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/prm2xxx_3xxx.h
index 9624b40..1c5d998 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
@@ -52,53 +52,6 @@
 #include <linux/io.h>
 #include "powerdomain.h"
 
-/* Power/reset management domain register get/set */
-static inline u32 omap2_prm_read_mod_reg(s16 module, u16 idx)
-{
-	return __raw_readl(prm_base + module + idx);
-}
-
-static inline void omap2_prm_write_mod_reg(u32 val, s16 module, u16 idx)
-{
-	__raw_writel(val, prm_base + module + idx);
-}
-
-/* Read-modify-write a register in a PRM module. Caller must lock */
-static inline u32 omap2_prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module,
-					     s16 idx)
-{
-	u32 v;
-
-	v = omap2_prm_read_mod_reg(module, idx);
-	v &= ~mask;
-	v |= bits;
-	omap2_prm_write_mod_reg(v, module, idx);
-
-	return v;
-}
-
-/* Read a PRM register, AND it, and shift the result down to bit 0 */
-static inline u32 omap2_prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
-{
-	u32 v;
-
-	v = omap2_prm_read_mod_reg(domain, idx);
-	v &= mask;
-	v >>= __ffs(mask);
-
-	return v;
-}
-
-static inline u32 omap2_prm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
-{
-	return omap2_prm_rmw_mod_reg_bits(bits, bits, module, idx);
-}
-
-static inline u32 omap2_prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
-{
-	return omap2_prm_rmw_mod_reg_bits(bits, 0x0, module, idx);
-}
-
 /* These omap2_ PRM functions apply to both OMAP2 and 3 */
 extern int omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift);
 extern int omap2_prm_assert_hardreset(s16 prm_mod, u8 shift);
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx_private.h b/arch/arm/mach-omap2/prm2xxx_3xxx_private.h
new file mode 100644
index 0000000..6e007e9
--- /dev/null
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx_private.h
@@ -0,0 +1,77 @@
+/*
+ * OMAP2xxx/3xxx-common Power/Reset Management (PRM) register definitions
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
+#ifndef __ARCH_ARM_MACH_OMAP2_PRM2XXX_3XXX_PRIVATE_H
+#define __ARCH_ARM_MACH_OMAP2_PRM2XXX_3XXX_PRIVATE_H
+
+#include "prcm-common.h"
+#include "prm.h"
+#include "prm2xxx_3xxx.h"
+
+#ifndef __ASSEMBLER__
+
+#include <linux/io.h>
+#include "powerdomain.h"
+
+/* Power/reset management domain register get/set */
+static inline u32 omap2_prm_read_mod_reg(s16 module, u16 idx)
+{
+	return __raw_readl(prm_base + module + idx);
+}
+
+static inline void omap2_prm_write_mod_reg(u32 val, s16 module, u16 idx)
+{
+	__raw_writel(val, prm_base + module + idx);
+}
+
+/* Read-modify-write a register in a PRM module. Caller must lock */
+static inline u32 omap2_prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module,
+					     s16 idx)
+{
+	u32 v;
+
+	v = omap2_prm_read_mod_reg(module, idx);
+	v &= ~mask;
+	v |= bits;
+	omap2_prm_write_mod_reg(v, module, idx);
+
+	return v;
+}
+
+/* Read a PRM register, AND it, and shift the result down to bit 0 */
+static inline u32 omap2_prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
+{
+	u32 v;
+
+	v = omap2_prm_read_mod_reg(domain, idx);
+	v &= mask;
+	v >>= __ffs(mask);
+
+	return v;
+}
+
+static inline u32 omap2_prm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
+{
+	return omap2_prm_rmw_mod_reg_bits(bits, bits, module, idx);
+}
+
+static inline u32 omap2_prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
+{
+	return omap2_prm_rmw_mod_reg_bits(bits, 0x0, module, idx);
+}
+
+#endif /* __ASSEMBLER */
+
+#endif
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index 09e50d2..eb37970 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -23,7 +23,7 @@
 #include "vp.h"
 #include "powerdomain.h"
 #include "prm3xxx.h"
-#include "prm2xxx_3xxx.h"
+#include "prm2xxx_3xxx_private.h"
 #include "cm2xxx_3xxx_private.h"
 #include "prm-regbits-34xx.h"
 #include "cm3xxx.h"
-- 
1.7.9.5

