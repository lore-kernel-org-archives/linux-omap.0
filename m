From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 01/11] OMAP4: PRCM: add OMAP4-specific
 accessor/mutatorfunctions
Date: Tue, 14 Dec 2010 23:48:14 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012142345050.15971@utopia.booyaka.com>
References: <20101208061657.30541.79824.stgit@twilight.localdomain> <20101208061829.30541.99531.stgit@twilight.localdomain> <25f8b00ceea2d6945cf74024299e81a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-402391754-1292395694=:15971"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58738 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766Ab0LOGsP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Dec 2010 01:48:15 -0500
In-Reply-To: <25f8b00ceea2d6945cf74024299e81a8@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-402391754-1292395694=:15971
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Rajendra

On Wed, 8 Dec 2010, Rajendra Nayak wrote:

> Would it help if we can avoid one more level of function
> indirection (given that these are low level apis) and store
> the Partition offsets in the tables above (instead of func
> pointers) and do some thing like this.
> =09
> =09return __raw_readl(OMAP2_L4_IO_ADDRESS(cm_read_offset[part],
> module, idx));
>=20
> with the table entries of cm_read_offset looking something like
> > +=09[OMAP4430_PRM_PARTITION]=09=09=3D OMAP4430_PRM_BASE,
> > +=09[OMAP4430_CM1_PARTITION]=09=09=3D OMAP4430_CM1_BASE,
> > +=09[OMAP4430_CM2_PARTITION]=09=09=3D OMAP4430_CM2_BASE,

I did a version of this patch without the extra level of indirection. =20
I'm not sure if it's better or worse.  The original seems conceptually=20
cleaner to me, but this revised version is probably slightly more=20
efficient.  Do you (or anyone else) have a strong preference?

Note that the patch has not yet been boot-tested, but I think the=20
principle is clear.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Tue, 14 Dec 2010 22:23:49 -0700=20
Subject: [PATCH] OMAP4: PRCM: add OMAP4-specific accessor/mutator functions

In some ways, the OMAP4 PRCM register layout is quite different than
the OMAP2/3 PRCM register layout.  For example, on OMAP2/3, from a
register layout point of view, all CM instances were located in the CM
subsystem, and all PRM instances were located in the PRM subsystem.
OMAP4 changes this.  Now, for example, some CM instances, such as
WKUP_CM and EMU_CM, are located in the system PRM subsystem.  And a
"local PRCM" exists for the MPU - this PRCM combines registers that
would normally appear in both CM and PRM instances, but uses its own
register layout which matches neither the OMAP2/3 PRCM layout nor the
OMAP4 PRCM layout.

To try to deal with this, introduce some new functions, omap4_cminst*
and omap4_prminst*.  The former is to be used when writing to a CM
instance register (no matter what subsystem or hardware module it
exists in), and the latter, similarly, with PRM instance registers.
To determine which "PRCM partition" to write to, the functions take a
PRCM instance ID argument.  Subsequent patches add these partition IDs
to the OMAP4 powerdomain and clockdomain definitions.

As far as I can see, there's really no good way to handle these types
of register access inconsistencies.  This patch seemed like the least
bad approach.

Moving forward, the long-term goal is to remove all direct PRCM
register access from the PM code.  PRCM register access should go
through layers such as the powerdomain and clockdomain code that can
hide the details of how to interact with the specific hardware
variant.

While here, rename cm4xxx.c to cm44xx.c to match the naming convention
of the other OMAP4 PRCM files.

Thanks to Santosh Shilimkar <santosh.shilimkar@ti.com> for some comments.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=EEt Cousson <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/Makefile           |    4 +-
 arch/arm/mach-omap2/cm1_44xx.h         |    5 ++
 arch/arm/mach-omap2/cm2_44xx.h         |    6 ++
 arch/arm/mach-omap2/cm44xx.c           |   52 +++++++++++++++
 arch/arm/mach-omap2/cm4xxx.c           |   62 ------------------
 arch/arm/mach-omap2/cminst44xx.c       |  109 ++++++++++++++++++++++++++++=
++++
 arch/arm/mach-omap2/cminst44xx.h       |   25 +++++++
 arch/arm/mach-omap2/prcm.c             |   26 +-------
 arch/arm/mach-omap2/prcm44xx.h         |   42 ++++++++++++
 arch/arm/mach-omap2/prcm_mpu44xx.c     |   45 +++++++++++++
 arch/arm/mach-omap2/prcm_mpu44xx.h     |    8 +++
 arch/arm/mach-omap2/prm44xx.c          |   65 +++++++++++++++++++
 arch/arm/mach-omap2/prm44xx.h          |    6 ++
 arch/arm/mach-omap2/prminst44xx.c      |   66 +++++++++++++++++++
 arch/arm/mach-omap2/prminst44xx.h      |   25 +++++++
 arch/arm/plat-omap/include/plat/prcm.h |    7 +-
 16 files changed, 462 insertions(+), 91 deletions(-)
 create mode 100644 arch/arm/mach-omap2/cm44xx.c
 delete mode 100644 arch/arm/mach-omap2/cm4xxx.c
 create mode 100644 arch/arm/mach-omap2/cminst44xx.c
 create mode 100644 arch/arm/mach-omap2/cminst44xx.h
 create mode 100644 arch/arm/mach-omap2/prcm44xx.h
 create mode 100644 arch/arm/mach-omap2/prcm_mpu44xx.c
 create mode 100644 arch/arm/mach-omap2/prminst44xx.c
 create mode 100644 arch/arm/mach-omap2/prminst44xx.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index aee22f9..0c0cdd9 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -69,7 +69,9 @@ obj-$(CONFIG_ARCH_OMAP3)=09=09+=3D prcm.o cm2xxx_3xxx.o p=
rm2xxx_3xxx.o
 # XXX The presence of cm2xxx_3xxx.o on the line below is temporary and
 # will be removed once the OMAP4 part of the codebase is converted to
 # use OMAP4-specific PRCM functions.
-obj-$(CONFIG_ARCH_OMAP4)=09=09+=3D prcm.o cm2xxx_3xxx.o cm4xxx.o
+obj-$(CONFIG_ARCH_OMAP4)=09=09+=3D prcm.o cm2xxx_3xxx.o cminst44xx.o \
+=09=09=09=09=09   cm44xx.o prcm_mpu44xx.o \
+=09=09=09=09=09   prminst44xx.o
=20
 # OMAP powerdomain framework
 powerdomain-common=09=09=09+=3D powerdomain.o powerdomain-common.o
diff --git a/arch/arm/mach-omap2/cm1_44xx.h b/arch/arm/mach-omap2/cm1_44xx.=
h
index aa2ee78..63ef9e3 100644
--- a/arch/arm/mach-omap2/cm1_44xx.h
+++ b/arch/arm/mach-omap2/cm1_44xx.h
@@ -248,4 +248,9 @@
 #define OMAP4_CM_DYN_DEP_PRESCAL_RESTORE_OFFSET=09=090x0040
 #define OMAP4430_CM_DYN_DEP_PRESCAL_RESTORE=09=09OMAP44XX_CM1_REGADDR(OMAP=
4430_CM1_RESTORE_INST, 0x0040)
=20
+/* Function prototypes */
+extern u32 omap4_cm1_read_inst_reg(s16 inst, u16 idx);
+extern void omap4_cm1_write_inst_reg(u32 val, s16 inst, u16 idx);
+extern u32 omap4_cm1_rmw_inst_reg_bits(u32 mask, u32 bits, s16 inst, s16 i=
dx);
+
 #endif
diff --git a/arch/arm/mach-omap2/cm2_44xx.h b/arch/arm/mach-omap2/cm2_44xx.=
h
index 89c9522..0fd0210 100644
--- a/arch/arm/mach-omap2/cm2_44xx.h
+++ b/arch/arm/mach-omap2/cm2_44xx.h
@@ -480,4 +480,10 @@
 #define OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL_RESTORE=09OMAP44XX_CM2_REGADDR(=
OMAP4430_CM2_RESTORE_INST, 0x0058)
 #define OMAP4_CM_SDMA_STATICDEP_RESTORE_OFFSET=09=090x005c
 #define OMAP4430_CM_SDMA_STATICDEP_RESTORE=09=09OMAP44XX_CM2_REGADDR(OMAP4=
430_CM2_RESTORE_INST, 0x005c)
+
+/* Function prototypes */
+extern u32 omap4_cm2_read_inst_reg(s16 inst, u16 idx);
+extern void omap4_cm2_write_inst_reg(u32 val, s16 inst, u16 idx);
+extern u32 omap4_cm2_rmw_inst_reg_bits(u32 mask, u32 bits, s16 inst, s16 i=
dx);
+
 #endif
diff --git a/arch/arm/mach-omap2/cm44xx.c b/arch/arm/mach-omap2/cm44xx.c
new file mode 100644
index 0000000..e96f53e
--- /dev/null
+++ b/arch/arm/mach-omap2/cm44xx.c
@@ -0,0 +1,52 @@
+/*
+ * OMAP4 CM1, CM2 module low-level functions
+ *
+ * Copyright (C) 2010 Nokia Corporation
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * These functions are intended to be used only by the cminst44xx.c file.
+ * XXX Perhaps we should just move them there and make them static.
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/io.h>
+
+#include <plat/common.h>
+
+#include "cm.h"
+#include "cm1_44xx.h"
+#include "cm2_44xx.h"
+#include "cm-regbits-44xx.h"
+
+/* CM1 hardware module low-level functions */
+
+/* Read a register in CM1 */
+u32 omap4_cm1_read_inst_reg(s16 inst, u16 reg)
+{
+=09return __raw_readl(OMAP44XX_CM1_REGADDR(inst, reg));
+}
+
+/* Write into a register in CM1 */
+void omap4_cm1_write_inst_reg(u32 val, s16 inst, u16 reg)
+{
+=09__raw_writel(val, OMAP44XX_CM1_REGADDR(inst, reg));
+}
+
+/* Read a register in CM2 */
+u32 omap4_cm2_read_inst_reg(s16 inst, u16 reg)
+{
+=09return __raw_readl(OMAP44XX_CM2_REGADDR(inst, reg));
+}
+
+/* Write into a register in CM2 */
+void omap4_cm2_write_inst_reg(u32 val, s16 inst, u16 reg)
+{
+=09__raw_writel(val, OMAP44XX_CM2_REGADDR(inst, reg));
+}
diff --git a/arch/arm/mach-omap2/cm4xxx.c b/arch/arm/mach-omap2/cm4xxx.c
deleted file mode 100644
index 25d2b3e..0000000
--- a/arch/arm/mach-omap2/cm4xxx.c
+++ /dev/null
@@ -1,62 +0,0 @@
-/*
- * OMAP4 CM module functions
- *
- * Copyright (C) 2009 Nokia Corporation
- * Paul Walmsley
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/delay.h>
-#include <linux/spinlock.h>
-#include <linux/list.h>
-#include <linux/errno.h>
-#include <linux/err.h>
-#include <linux/io.h>
-
-#include <asm/atomic.h>
-
-#include <plat/common.h>
-
-#include "cm44xx.h"
-#include "cm-regbits-44xx.h"
-
-/**
- * omap4_cm_wait_module_ready - wait for a module to be in 'func' state
- * @clkctrl_reg: CLKCTRL module address
- *
- * Wait for the module IDLEST to be functional. If the idle state is in an=
y
- * the non functional state (trans, idle or disabled), module and thus the
- * sysconfig cannot be accessed and will probably lead to an "imprecise
- * external abort"
- *
- * Module idle state:
- *   0x0 func:     Module is fully functional, including OCP
- *   0x1 trans:    Module is performing transition: wakeup, or sleep, or s=
leep
- *                 abortion
- *   0x2 idle:     Module is in Idle mode (only OCP part). It is functiona=
l if
- *                 using separate functional clock
- *   0x3 disabled: Module is disabled and cannot be accessed
- *
- */
-int omap4_cm_wait_module_ready(void __iomem *clkctrl_reg)
-{
-=09int i =3D 0;
-
-=09if (!clkctrl_reg)
-=09=09return 0;
-
-=09omap_test_timeout((
-=09=09((__raw_readl(clkctrl_reg) & OMAP4430_IDLEST_MASK) =3D=3D 0) ||
-=09=09 (((__raw_readl(clkctrl_reg) & OMAP4430_IDLEST_MASK) >>
-=09=09  OMAP4430_IDLEST_SHIFT) =3D=3D 0x2)),
-=09=09MAX_MODULE_READY_TIME, i);
-
-=09return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
-}
-
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst4=
4xx.c
new file mode 100644
index 0000000..c13613b
--- /dev/null
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -0,0 +1,109 @@
+/*
+ * OMAP4 CM instance functions
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This is needed since CM instances can be in the PRM, PRCM_MPU, CM1,
+ * or CM2 hardware modules.  For example, the EMU_CM CM instance is in
+ * the PRM hardware module.  What a mess...
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/io.h>
+
+#include <plat/common.h>
+
+#include "cm.h"
+#include "cm1_44xx.h"
+#include "cm2_44xx.h"
+#include "cm44xx.h"
+#include "cminst44xx.h"
+#include "cm-regbits-44xx.h"
+#include "prcm44xx.h"
+#include "prm44xx.h"
+#include "prcm_mpu44xx.h"
+
+static u32 _cm_bases[OMAP4_MAX_PRCM_PARTITIONS] =3D {
+=09[OMAP4430_INVALID_PRCM_PARTITION]=09=3D 0,
+=09[OMAP4430_PRM_PARTITION]=09=09=3D OMAP4430_PRM_BASE,
+=09[OMAP4430_CM1_PARTITION]=09=09=3D OMAP4430_CM1_BASE,
+=09[OMAP4430_CM2_PARTITION]=09=09=3D OMAP4430_CM2_BASE,
+=09[OMAP4430_SCRM_PARTITION]=09=09=3D 0,
+=09[OMAP4430_PRCM_MPU_PARTITION]=09=09=3D OMAP4430_PRCM_MPU_BASE,
+};
+
+/* Read a register in a CM instance */
+u32 omap4_cminst_read_inst_reg(u8 part, s16 inst, u16 idx)
+{
+=09BUG_ON(part >=3D OMAP4_MAX_PRCM_PARTITIONS ||
+=09       part =3D=3D OMAP4430_INVALID_PRCM_PARTITION ||
+=09       !_cm_bases[part]);
+=09return __raw_readl(OMAP2_L4_IO_ADDRESS(_cm_bases[part] + inst + idx));
+}
+
+/* Write into a register in a CM instance */
+void omap4_cminst_write_inst_reg(u32 val, u8 part, s16 inst, u16 idx)
+{
+=09BUG_ON(part >=3D OMAP4_MAX_PRCM_PARTITIONS ||
+=09       part =3D=3D OMAP4430_INVALID_PRCM_PARTITION ||
+=09       !_cm_bases[part]);
+=09__raw_writel(val, OMAP2_L4_IO_ADDRESS(_cm_bases[part] + inst + idx));
+}
+
+/* Read-modify-write a register in CM1. Caller must lock */
+u32 omap4_cminst_rmw_inst_reg_bits(u32 mask, u32 bits, u8 part, s16 inst,
+=09=09=09=09   s16 idx)
+{
+=09u32 v;
+
+=09v =3D omap4_cminst_read_inst_reg(part, inst, idx);
+=09v &=3D ~mask;
+=09v |=3D bits;
+=09omap4_cminst_write_inst_reg(v, part, inst, idx);
+
+=09return v;
+}
+
+
+/**
+ * omap4_cm_wait_module_ready - wait for a module to be in 'func' state
+ * @clkctrl_reg: CLKCTRL module address
+ *
+ * Wait for the module IDLEST to be functional. If the idle state is in an=
y
+ * the non functional state (trans, idle or disabled), module and thus the
+ * sysconfig cannot be accessed and will probably lead to an "imprecise
+ * external abort"
+ *
+ * Module idle state:
+ *   0x0 func:     Module is fully functional, including OCP
+ *   0x1 trans:    Module is performing transition: wakeup, or sleep, or s=
leep
+ *                 abortion
+ *   0x2 idle:     Module is in Idle mode (only OCP part). It is functiona=
l if
+ *                 using separate functional clock
+ *   0x3 disabled: Module is disabled and cannot be accessed
+ *
+ */
+int omap4_cm_wait_module_ready(void __iomem *clkctrl_reg)
+{
+=09int i =3D 0;
+
+=09if (!clkctrl_reg)
+=09=09return 0;
+
+=09omap_test_timeout((
+=09=09((__raw_readl(clkctrl_reg) & OMAP4430_IDLEST_MASK) =3D=3D 0) ||
+=09=09 (((__raw_readl(clkctrl_reg) & OMAP4430_IDLEST_MASK) >>
+=09=09  OMAP4430_IDLEST_SHIFT) =3D=3D 0x2)),
+=09=09MAX_MODULE_READY_TIME, i);
+
+=09return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
+}
+
diff --git a/arch/arm/mach-omap2/cminst44xx.h b/arch/arm/mach-omap2/cminst4=
4xx.h
new file mode 100644
index 0000000..6baa4c7
--- /dev/null
+++ b/arch/arm/mach-omap2/cminst44xx.h
@@ -0,0 +1,25 @@
+/*
+ * OMAP4 Clock Management (CM) function prototypes
+ *
+ * Copyright (C) 2010 Nokia Corporation
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __ARCH_ASM_MACH_OMAP2_CMINST44XX_H
+#define __ARCH_ASM_MACH_OMAP2_CMINST44XX_H
+
+/*
+ * In an ideal world, we would not export these low-level functions,
+ * but this will probably take some time to fix properly
+ */
+extern u32 omap4_cminst_read_inst_reg(u8 part, s16 inst, u16 idx);
+extern void omap4_cminst_write_inst_reg(u32 val, u8 part, s16 inst, u16 id=
x);
+extern u32 omap4_cminst_rmw_inst_reg_bits(u32 mask, u32 bits, u8 part,
+=09=09=09=09=09   s16 inst, s16 idx);
+
+extern int omap4_cm_wait_module_ready(void __iomem *clkctrl_reg);
+
+#endif
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index dd95cbb..fe0865b 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -33,6 +33,7 @@
 #include "cm44xx.h"
 #include "prm2xxx_3xxx.h"
 #include "prm44xx.h"
+#include "prcm44xx.h"
 #include "prm-regbits-24xx.h"
 #include "prm-regbits-44xx.h"
 #include "control.h"
@@ -80,31 +81,6 @@ void omap_prcm_arch_reset(char mode, const char *cmd)
 =09=09=09=09     prcm_offs, OMAP4_RM_RSTCTRL);
 }
=20
-/* Read a PRM register, AND it, and shift the result down to bit 0 */
-u32 omap4_prm_read_bits_shift(void __iomem *reg, u32 mask)
-{
-=09u32 v;
-
-=09v =3D __raw_readl(reg);
-=09v &=3D mask;
-=09v >>=3D __ffs(mask);
-
-=09return v;
-}
-
-/* Read-modify-write a register in a PRM module. Caller must lock */
-u32 omap4_prm_rmw_reg_bits(u32 mask, u32 bits, void __iomem *reg)
-{
-=09u32 v;
-
-=09v =3D __raw_readl(reg);
-=09v &=3D ~mask;
-=09v |=3D bits;
-=09__raw_writel(v, reg);
-
-=09return v;
-}
-
 /**
  * omap2_cm_wait_idlest - wait for IDLEST bit to indicate module readiness
  * @reg: physical address of module IDLEST register
diff --git a/arch/arm/mach-omap2/prcm44xx.h b/arch/arm/mach-omap2/prcm44xx.=
h
new file mode 100644
index 0000000..7334ffb
--- /dev/null
+++ b/arch/arm/mach-omap2/prcm44xx.h
@@ -0,0 +1,42 @@
+/*
+ * OMAP4 PRCM definitions
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Copyright (C) 2010 Nokia Corporation
+ *
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This file contains macros and functions that are common to all of
+ * the PRM/CM/PRCM blocks on the OMAP4 devices: PRM, CM1, CM2,
+ * PRCM_MPU, SCRM
+ */
+
+#ifndef __ARCH_ARM_MACH_OMAP2_PRCM44XX_H
+#define __ARCH_ARM_MACH_OMAP2_PRCM44XX_H
+
+/*
+ * OMAP4 PRCM partition IDs
+ *
+ * The numbers and order are arbitrary, but 0 is reserved for the
+ * 'invalid' partition in case someone forgets to add a
+ * .prcm_partition field.
+ */
+#define OMAP4430_INVALID_PRCM_PARTITION=09=090
+#define OMAP4430_PRM_PARTITION=09=09=091
+#define OMAP4430_CM1_PARTITION=09=09=092
+#define OMAP4430_CM2_PARTITION=09=09=093
+#define OMAP4430_SCRM_PARTITION=09=09=094
+#define OMAP4430_PRCM_MPU_PARTITION=09=095
+
+/*
+ * OMAP4_MAX_PRCM_PARTITIONS: set to the highest value of the PRCM partiti=
on
+ * IDs, plus one
+ */
+#define OMAP4_MAX_PRCM_PARTITIONS=09=096
+
+
+#endif
diff --git a/arch/arm/mach-omap2/prcm_mpu44xx.c b/arch/arm/mach-omap2/prcm_=
mpu44xx.c
new file mode 100644
index 0000000..171fe17
--- /dev/null
+++ b/arch/arm/mach-omap2/prcm_mpu44xx.c
@@ -0,0 +1,45 @@
+/*
+ * OMAP4 PRCM_MPU module functions
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/io.h>
+
+#include <plat/common.h>
+
+#include "prcm_mpu44xx.h"
+#include "cm-regbits-44xx.h"
+
+/* PRCM_MPU low-level functions */
+
+u32 omap4_prcm_mpu_read_inst_reg(s16 inst, u16 reg)
+{
+=09return __raw_readl(OMAP44XX_PRCM_MPU_REGADDR(inst, reg));
+}
+
+void omap4_prcm_mpu_write_inst_reg(u32 val, s16 inst, u16 reg)
+{
+=09__raw_writel(val, OMAP44XX_PRCM_MPU_REGADDR(inst, reg));
+}
+
+u32 omap4_prcm_mpu_rmw_inst_reg_bits(u32 mask, u32 bits, s16 inst, s16 reg=
)
+{
+=09u32 v;
+
+=09v =3D omap4_prcm_mpu_read_inst_reg(inst, reg);
+=09v &=3D ~mask;
+=09v |=3D bits;
+=09omap4_prcm_mpu_write_inst_reg(v, inst, reg);
+
+=09return v;
+}
diff --git a/arch/arm/mach-omap2/prcm_mpu44xx.h b/arch/arm/mach-omap2/prcm_=
mpu44xx.h
index 80e00c1..e5190e9 100644
--- a/arch/arm/mach-omap2/prcm_mpu44xx.h
+++ b/arch/arm/mach-omap2/prcm_mpu44xx.h
@@ -88,4 +88,12 @@
 #define OMAP4_CM_CPU1_CLKSTCTRL_OFFSET=09=09=090x0018
 #define OMAP4430_CM_CPU1_CLKSTCTRL=09=09=09OMAP44XX_PRCM_MPU_REGADDR(OMAP4=
430_PRCM_MPU_CPU1_INST, 0x0018)
=20
+/* Function prototypes */
+# ifndef __ASSEMBLER__
+extern u32 omap4_prcm_mpu_read_inst_reg(s16 inst, u16 idx);
+extern void omap4_prcm_mpu_write_inst_reg(u32 val, s16 inst, u16 idx);
+extern u32 omap4_prcm_mpu_rmw_inst_reg_bits(u32 mask, u32 bits, s16 inst,
+=09=09=09=09=09    s16 idx);
+# endif
+
 #endif
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 697b58f..c016ae4 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/err.h>
+#include <linux/io.h>
=20
 #include <plat/common.h>
 #include <plat/cpu.h>
@@ -29,6 +30,70 @@
  */
 #define OMAP4_RST_CTRL_ST_OFFSET=09=094
=20
+/* PRM low-level functions */
+
+/* Read a register in a CM/PRM instance in the PRM module */
+u32 omap4_prm_read_inst_reg(s16 inst, u16 reg)
+{
+=09return __raw_readl(OMAP44XX_PRM_REGADDR(inst, reg));
+}
+
+/* Write into a register in a CM/PRM instance in the PRM module */
+void omap4_prm_write_inst_reg(u32 val, s16 inst, u16 reg)
+{
+=09__raw_writel(val, OMAP44XX_PRM_REGADDR(inst, reg));
+}
+
+/* Read-modify-write a register in a PRM module. Caller must lock */
+u32 omap4_prm_rmw_inst_reg_bits(u32 mask, u32 bits, s16 inst, s16 reg)
+{
+=09u32 v;
+
+=09v =3D omap4_prm_read_inst_reg(inst, reg);
+=09v &=3D ~mask;
+=09v |=3D bits;
+=09omap4_prm_write_inst_reg(v, inst, reg);
+
+=09return v;
+}
+
+/* Read a PRM register, AND it, and shift the result down to bit 0 */
+/* XXX deprecated */
+u32 omap4_prm_read_bits_shift(void __iomem *reg, u32 mask)
+{
+=09u32 v;
+
+=09v =3D __raw_readl(reg);
+=09v &=3D mask;
+=09v >>=3D __ffs(mask);
+
+=09return v;
+}
+
+/* Read-modify-write a register in a PRM module. Caller must lock */
+/* XXX deprecated */
+u32 omap4_prm_rmw_reg_bits(u32 mask, u32 bits, void __iomem *reg)
+{
+=09u32 v;
+
+=09v =3D __raw_readl(reg);
+=09v &=3D ~mask;
+=09v |=3D bits;
+=09__raw_writel(v, reg);
+
+=09return v;
+}
+
+u32 omap4_prm_set_inst_reg_bits(u32 bits, s16 inst, s16 reg)
+{
+=09return omap4_prm_rmw_inst_reg_bits(bits, bits, inst, reg);
+}
+
+u32 omap4_prm_clear_inst_reg_bits(u32 bits, s16 inst, s16 reg)
+{
+=09return omap4_prm_rmw_inst_reg_bits(bits, 0x0, inst, reg);
+}
+
 /**
  * omap4_prm_is_hardreset_asserted - read the HW reset line state of
  * submodules contained in the hwmod module
diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm44xx.h
index 3d36149..3588653 100644
--- a/arch/arm/mach-omap2/prm44xx.h
+++ b/arch/arm/mach-omap2/prm44xx.h
@@ -744,6 +744,12 @@
 /* Function prototypes */
 # ifndef __ASSEMBLER__
=20
+extern u32 omap4_prm_read_inst_reg(s16 inst, u16 idx);
+extern void omap4_prm_write_inst_reg(u32 val, s16 inst, u16 idx);
+extern u32 omap4_prm_rmw_inst_reg_bits(u32 mask, u32 bits, s16 inst, s16 i=
dx);
+extern u32 omap4_prm_rmw_reg_bits(u32 mask, u32 bits, void __iomem *reg);
+extern u32 omap4_prm_set_inst_reg_bits(u32 bits, s16 inst, s16 idx);
+extern u32 omap4_prm_clear_inst_reg_bits(u32 bits, s16 inst, s16 idx);
 extern u32 omap4_prm_read_bits_shift(void __iomem *reg, u32 mask);
=20
 extern int omap4_prm_is_hardreset_asserted(void __iomem *rstctrl_reg, u8 s=
hift);
diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prmins=
t44xx.c
new file mode 100644
index 0000000..a303242
--- /dev/null
+++ b/arch/arm/mach-omap2/prminst44xx.c
@@ -0,0 +1,66 @@
+/*
+ * OMAP4 PRM instance functions
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/io.h>
+
+#include <plat/common.h>
+
+#include "prm44xx.h"
+#include "prminst44xx.h"
+#include "prm-regbits-44xx.h"
+#include "prcm44xx.h"
+#include "prcm_mpu44xx.h"
+
+static u32 _prm_bases[OMAP4_MAX_PRCM_PARTITIONS] =3D {
+=09[OMAP4430_INVALID_PRCM_PARTITION]=09=3D 0,
+=09[OMAP4430_PRM_PARTITION]=09=09=3D OMAP4430_PRM_BASE,
+=09[OMAP4430_CM1_PARTITION]=09=09=3D 0,
+=09[OMAP4430_CM2_PARTITION]=09=09=3D 0,
+=09[OMAP4430_SCRM_PARTITION]=09=09=3D 0,
+=09[OMAP4430_PRCM_MPU_PARTITION]=09=09=3D OMAP4430_PRCM_MPU_BASE,
+};
+
+/* Read a register in a PRM instance */
+u32 omap4_prminst_read_inst_reg(u8 part, s16 inst, u16 idx)
+{
+=09BUG_ON(part >=3D OMAP4_MAX_PRCM_PARTITIONS ||
+=09       part =3D=3D OMAP4430_INVALID_PRCM_PARTITION ||
+=09       !_prm_bases[part]);
+=09return __raw_readl(OMAP2_L4_IO_ADDRESS(_prm_bases[part] + inst +
+=09=09=09=09=09       idx));
+}
+
+/* Write into a register in a PRM instance */
+void omap4_prminst_write_inst_reg(u32 val, u8 part, s16 inst, u16 idx)
+{
+=09BUG_ON(part >=3D OMAP4_MAX_PRCM_PARTITIONS ||
+=09       part =3D=3D OMAP4430_INVALID_PRCM_PARTITION ||
+=09       !_prm_bases[part]);
+=09__raw_writel(val, OMAP2_L4_IO_ADDRESS(_prm_bases[part] + inst + idx));
+}
+
+/* Read-modify-write a register in PRM. Caller must lock */
+u32 omap4_prminst_rmw_inst_reg_bits(u32 mask, u32 bits, u8 part, s16 inst,
+=09=09=09=09   s16 idx)
+{
+=09u32 v;
+
+=09v =3D omap4_prminst_read_inst_reg(part, inst, idx);
+=09v &=3D ~mask;
+=09v |=3D bits;
+=09omap4_prminst_write_inst_reg(v, part, inst, idx);
+
+=09return v;
+}
diff --git a/arch/arm/mach-omap2/prminst44xx.h b/arch/arm/mach-omap2/prmins=
t44xx.h
new file mode 100644
index 0000000..02dd66d
--- /dev/null
+++ b/arch/arm/mach-omap2/prminst44xx.h
@@ -0,0 +1,25 @@
+/*
+ * OMAP4 Power/Reset Management (PRM) function prototypes
+ *
+ * Copyright (C) 2010 Nokia Corporation
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __ARCH_ASM_MACH_OMAP2_PRMINST44XX_H
+#define __ARCH_ASM_MACH_OMAP2_PRMINST44XX_H
+
+/*
+ * In an ideal world, we would not export these low-level functions,
+ * but this will probably take some time to fix properly
+ */
+extern u32 omap4_prminst_read_inst_reg(u8 part, s16 inst, u16 idx);
+extern void omap4_prminst_write_inst_reg(u32 val, u8 part, s16 inst, u16 i=
dx);
+extern u32 omap4_prminst_rmw_inst_reg_bits(u32 mask, u32 bits, u8 part,
+=09=09=09=09=09   s16 inst, s16 idx);
+
+extern void omap4_prm_global_warm_sw_reset(void);
+
+#endif
diff --git a/arch/arm/plat-omap/include/plat/prcm.h b/arch/arm/plat-omap/in=
clude/plat/prcm.h
index d059a05..078906d 100644
--- a/arch/arm/plat-omap/include/plat/prcm.h
+++ b/arch/arm/plat-omap/include/plat/prcm.h
@@ -18,6 +18,10 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ * XXX This file is deprecated.  The PRCM is an OMAP2+-only subsystem,
+ * so this file doesn't belong in plat-omap/include/plat.  Please
+ * do not add anything new to this file.
  */
=20
 #ifndef __ASM_ARM_ARCH_OMAP_PRCM_H
@@ -31,9 +35,6 @@ int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, u8 =
idlest,
 #define START_PADCONF_SAVE 0x2
 #define PADCONF_SAVE_DONE  0x1
=20
-u32 omap4_prm_read_bits_shift(void __iomem *reg, u32 mask);
-u32 omap4_prm_rmw_reg_bits(u32 mask, u32 bits, void __iomem *reg);
-
 #endif
=20
=20
--=20
1.7.2.3

--155748971-402391754-1292395694=:15971--
