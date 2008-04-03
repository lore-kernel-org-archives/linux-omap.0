From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/2] PRM/CM: Add new PRM/CM register bit manipulation functions
Date: Thu, 03 Apr 2008 16:34:40 -0600
Message-ID: <20080403223535.800301856@pwsan.com>
References: <20080403223439.820599556@pwsan.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51593 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757909AbYDCWiI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Apr 2008 18:38:08 -0400
Content-Disposition: inline; filename=add_new_prm_cm_mutator_fns.patch
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch implements an idea from Igor Stoppa <igor.stoppa@nokia.com>
from last year.  We use functions to modify PRM/CM register bits,
rather than open-coding those operations.

The patch provides functions that do read + AND + OR + write sequences
on CM and PRM registers: {cm,prm}_rmw_reg_bits(), and
{cm,prm}_rmw_mod_reg_bits().  Several convenience functions are then
implemented on top of those functions for setting and clearing bits:
{cm,prm}_{set,clear}_mod_reg_bits().

These functions don't provide any locking; it is expected that the call=
er
will handle this.

Thanks to Jouni H=C3=B6gander <jouni.hogander@nokia.com> for catching s=
ome=20
embarrassing errors in earlier versions of this code.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/cm.h  |   34 +++++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/prm.h |   37 ++++++++++++++++++++++++++++++++++---
 2 files changed, 67 insertions(+), 4 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/cm.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap.orig/arch/arm/mach-omap2/cm.h	2008-03-30 16:15:32.000000=
000 -0600
+++ linux-omap/arch/arm/mach-omap2/cm.h	2008-03-30 16:27:15.000000000 -=
0600
@@ -14,6 +14,8 @@
  * published by the Free Software Foundation.
  */
=20
+#include <asm/io.h>
+
 #include "prcm-common.h"
=20
 #ifndef __ASSEMBLER__
@@ -54,6 +56,20 @@
 {
 	return __raw_readl(addr);
 }
+
+/* Read-modify-write bits in a CM register */
+static u32 __attribute__((unused)) cm_rmw_reg_bits(u32 mask, u32 bits,=
 void __iomem *va)
+{
+	u32 v;
+
+	v =3D cm_read_reg(va);
+	v &=3D ~mask;
+	v |=3D bits;
+	cm_write_reg(v, va);
+
+	return v;
+}
+
 #endif
=20
 /*
@@ -83,7 +99,6 @@
 #define CM_CLKSEL2					0x0044
 #define CM_CLKSTCTRL					0x0048
=20
-
 /* Architecture-specific registers */
=20
 #define OMAP24XX_CM_FCLKEN2				0x0004
@@ -122,6 +137,23 @@
 {
 	return cm_read_reg(OMAP_CM_REGADDR(module, idx));
 }
+
+/* Read-modify-write bits in a CM register (by domain) */
+static inline u32 __attribute__((unused)) cm_rmw_mod_reg_bits(u32 mask=
, u32 bits, s16 module, s16 idx)
+{
+	return cm_rmw_reg_bits(mask, bits, OMAP_CM_REGADDR(module, idx));
+}
+
+static inline u32 __attribute__((unused)) cm_set_mod_reg_bits(u32 bits=
, s16 module, s16 idx)
+{
+	return cm_rmw_mod_reg_bits(bits, bits, module, idx);
+}
+
+static inline u32 __attribute__((unused)) cm_clear_mod_reg_bits(u32 bi=
ts, s16 module, s16 idx)
+{
+	return cm_rmw_mod_reg_bits(bits, 0x0, module, idx);
+}
+
 #endif
=20
 /* CM register bits shared between 24XX and 3430 */
Index: linux-omap/arch/arm/mach-omap2/prm.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap.orig/arch/arm/mach-omap2/prm.h	2008-03-30 16:15:32.00000=
0000 -0600
+++ linux-omap/arch/arm/mach-omap2/prm.h	2008-03-30 16:27:15.000000000 =
-0600
@@ -4,8 +4,8 @@
 /*
  * OMAP2/3 Power/Reset Management (PRM) register definitions
  *
- * Copyright (C) 2007 Texas Instruments, Inc.
- * Copyright (C) 2007 Nokia Corporation
+ * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * Copyright (C) 2007-2008 Nokia Corporation
  *
  * Written by Paul Walmsley
  *
@@ -14,6 +14,9 @@
  * published by the Free Software Foundation.
  */
=20
+#include <asm/io.h>
+#include <asm/bitops.h>
+
 #include "prcm-common.h"
=20
 #ifndef __ASSEMBLER__
@@ -61,7 +64,6 @@
 #define OMAP3430_PRM_IRQSTATUS_MPU	OMAP_PRM_REGADDR(OCP_MOD, 0x0018)
 #define OMAP3430_PRM_IRQENABLE_MPU	OMAP_PRM_REGADDR(OCP_MOD, 0x001c)
=20
-
 #define OMAP3430_PRM_VC_SMPS_SA		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0=
020)
 #define OMAP3430_PRM_VC_SMPS_VOL_RA	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, =
0x0024)
 #define OMAP3430_PRM_VC_SMPS_CMD_RA	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, =
0x0028)
@@ -113,6 +115,19 @@
 	return __raw_readl(addr);
 }
=20
+/* Read-modify-write bits in a PRM register */
+static u32 __attribute__((unused)) prm_rmw_reg_bits(u32 mask, u32 bits=
, void __iomem *va)
+{
+	u32 v;
+
+	v =3D prm_read_reg(va);
+	v &=3D ~mask;
+	v |=3D bits;
+	prm_write_reg(v, va);
+
+	return v;
+}
+
 #endif
=20
 /*
@@ -154,6 +169,22 @@
 #define OMAP3430_PRM_IRQSTATUS_IVA2			0x00f8
 #define OMAP3430_PRM_IRQENABLE_IVA2			0x00fc
=20
+/* Read-modify-write bits in a PRM register (by domain) */
+static u32 __attribute__((unused)) prm_rmw_mod_reg_bits(u32 mask, u32 =
bits,
+							s16 module, s16 idx)
+{
+	return prm_rmw_reg_bits(mask, bits, OMAP_PRM_REGADDR(module, idx));
+}
+
+static u32 __attribute__((unused)) prm_set_mod_reg_bits(u32 bits, s16 =
module, s16 idx)
+{
+	return prm_rmw_mod_reg_bits(bits, bits, module, idx);
+}
+
+static u32 __attribute__((unused)) prm_clear_mod_reg_bits(u32 bits, s1=
6 module, s16 idx)
+{
+	return prm_rmw_mod_reg_bits(bits, 0x0, module, idx);
+}
=20
 /* Architecture-specific registers */
=20

--=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
