From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v3 06/13] OMAP4: hwmod: Replace RSTCTRL absolute address
 with offset macros
Date: Thu, 7 Jul 2011 02:28:41 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107070227240.30028@utopia.booyaka.com>
References: <1309554558-19819-1-git-send-email-b-cousson@ti.com> <1309554558-19819-7-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-137127682-1310027321=:30028"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35176 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754940Ab1GGI2n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jul 2011 04:28:43 -0400
In-Reply-To: <1309554558-19819-7-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-137127682-1310027321=:30028
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 1 Jul 2011, Benoit Cousson wrote:

> The RSTCTRL register was accessed using an absolute address.
> The usage of hardcoded macros to calculate virtual address from physical
> one should be avoided as much as possible.
> The usage of an offset will allow future improvement like migration from
> the current architecture code toward a module driver.
>=20
> Update prm_xxx accessors, move definition to the proper header file and
> update copyrights.
> Change the s16 register offset parameter to u16.
>=20
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>

This patch was updated to use '_prminst_' in function names that are part=
=20
of the prminst44xx.c file, rather than '_prm_', to preserve consistency=20
with the rest of the file.  Updated patch below.


- Paul

From=20d321d28e3df135330dc9d3143214c67122d1175e Mon Sep 17 00:00:00 2001
From: Benoit Cousson <b-cousson@ti.com>
Date: Fri, 1 Jul 2011 23:09:11 +0200
Subject: [PATCH] OMAP4: hwmod: Replace RSTCTRL absolute address with offset
 macros

The RSTCTRL register was accessed using an absolute address.
The usage of hardcoded macros to calculate virtual address from physical
one should be avoided as much as possible.
The usage of an offset will allow future improvement like migration from
the current architecture code toward a module driver.

Update prm_xxx accessors, move definition to the proper header file and
update copyrights.
Change the s16 register offset parameter to u16.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
[paul@pwsan.com: use '_prminst_' in function names that are part of the
 prminst44xx.c file]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   19 ++++--
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |   16 ++--
 arch/arm/mach-omap2/prm44xx.c                |   93 +---------------------=
----
 arch/arm/mach-omap2/prm44xx.h                |    4 -
 arch/arm/mach-omap2/prminst44xx.c            |   93 ++++++++++++++++++++++=
+++-
 arch/arm/mach-omap2/prminst44xx.h            |   10 +++-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    3 +-
 7 files changed, 125 insertions(+), 113 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hw=
mod.c
index fee80a8..8c993f2 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -148,6 +148,7 @@
 #include "cminst44xx.h"
 #include "prm2xxx_3xxx.h"
 #include "prm44xx.h"
+#include "prminst44xx.h"
 #include "mux.h"
=20
 /* Maximum microseconds to wait for OMAP module to softreset */
@@ -1098,8 +1099,10 @@ static int _assert_hardreset(struct omap_hwmod *oh, =
const char *name)
 =09=09return omap2_prm_assert_hardreset(oh->prcm.omap2.module_offs,
 =09=09=09=09=09=09  ohri.rst_shift);
 =09else if (cpu_is_omap44xx())
-=09=09return omap4_prm_assert_hardreset(oh->prcm.omap4.rstctrl_reg,
-=09=09=09=09=09=09  ohri.rst_shift);
+=09=09return omap4_prminst_assert_hardreset(ohri.rst_shift,
+=09=09=09=09  oh->clkdm->pwrdm.ptr->prcm_partition,
+=09=09=09=09  oh->clkdm->pwrdm.ptr->prcm_offs,
+=09=09=09=09  oh->prcm.omap4.rstctrl_offs);
 =09else
 =09=09return -EINVAL;
 }
@@ -1134,8 +1137,10 @@ static int _deassert_hardreset(struct omap_hwmod *oh=
, const char *name)
 =09=09if (ohri.st_shift)
 =09=09=09pr_err("omap_hwmod: %s: %s: hwmod data error: OMAP4 does not supp=
ort st_shift\n",
 =09=09=09       oh->name, name);
-=09=09ret =3D omap4_prm_deassert_hardreset(oh->prcm.omap4.rstctrl_reg,
-=09=09=09=09=09=09   ohri.rst_shift);
+=09=09ret =3D omap4_prminst_deassert_hardreset(ohri.rst_shift,
+=09=09=09=09  oh->clkdm->pwrdm.ptr->prcm_partition,
+=09=09=09=09  oh->clkdm->pwrdm.ptr->prcm_offs,
+=09=09=09=09  oh->prcm.omap4.rstctrl_offs);
 =09} else {
 =09=09return -EINVAL;
 =09}
@@ -1170,8 +1175,10 @@ static int _read_hardreset(struct omap_hwmod *oh, co=
nst char *name)
 =09=09return omap2_prm_is_hardreset_asserted(oh->prcm.omap2.module_offs,
 =09=09=09=09=09=09       ohri.st_shift);
 =09} else if (cpu_is_omap44xx()) {
-=09=09return omap4_prm_is_hardreset_asserted(oh->prcm.omap4.rstctrl_reg,
-=09=09=09=09=09=09       ohri.rst_shift);
+=09=09return omap4_prminst_is_hardreset_asserted(ohri.rst_shift,
+=09=09=09=09  oh->clkdm->pwrdm.ptr->prcm_partition,
+=09=09=09=09  oh->clkdm->pwrdm.ptr->prcm_offs,
+=09=09=09=09  oh->prcm.omap4.rstctrl_offs);
 =09} else {
 =09=09return -EINVAL;
 =09}
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_44xx_data.c
index 07a66880..488d660 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1139,7 +1139,7 @@ static struct omap_hwmod omap44xx_dsp_c0_hwmod =3D {
 =09.rst_lines_cnt=09=3D ARRAY_SIZE(omap44xx_dsp_c0_resets),
 =09.prcm =3D {
 =09=09.omap4 =3D {
-=09=09=09.rstctrl_reg =3D OMAP4430_RM_TESLA_RSTCTRL,
+=09=09=09.rstctrl_offs =3D OMAP4_RM_TESLA_RSTCTRL_OFFSET,
 =09=09},
 =09},
 =09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -1157,7 +1157,7 @@ static struct omap_hwmod omap44xx_dsp_hwmod =3D {
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_TESLA_TESLA_CLKCTRL_OFFSET,
-=09=09=09.rstctrl_reg =3D OMAP4430_RM_TESLA_RSTCTRL,
+=09=09=09.rstctrl_offs =3D OMAP4_RM_TESLA_RSTCTRL_OFFSET,
 =09=09},
 =09},
 =09.slaves=09=09=3D omap44xx_dsp_slaves,
@@ -2479,7 +2479,7 @@ static struct omap_hwmod omap44xx_ipu_c0_hwmod =3D {
 =09.rst_lines_cnt=09=3D ARRAY_SIZE(omap44xx_ipu_c0_resets),
 =09.prcm=09=09=3D {
 =09=09.omap4 =3D {
-=09=09=09.rstctrl_reg =3D OMAP4430_RM_DUCATI_RSTCTRL,
+=09=09=09.rstctrl_offs =3D OMAP4_RM_DUCATI_RSTCTRL_OFFSET,
 =09=09},
 =09},
 =09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -2495,7 +2495,7 @@ static struct omap_hwmod omap44xx_ipu_c1_hwmod =3D {
 =09.rst_lines_cnt=09=3D ARRAY_SIZE(omap44xx_ipu_c1_resets),
 =09.prcm=09=09=3D {
 =09=09.omap4 =3D {
-=09=09=09.rstctrl_reg =3D OMAP4430_RM_DUCATI_RSTCTRL,
+=09=09=09.rstctrl_offs =3D OMAP4_RM_DUCATI_RSTCTRL_OFFSET,
 =09=09},
 =09},
 =09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -2513,7 +2513,7 @@ static struct omap_hwmod omap44xx_ipu_hwmod =3D {
 =09.prcm=09=09=3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_DUCATI_DUCATI_CLKCTRL_OFFSET,
-=09=09=09.rstctrl_reg =3D OMAP4430_RM_DUCATI_RSTCTRL,
+=09=09=09.rstctrl_offs =3D OMAP4_RM_DUCATI_RSTCTRL_OFFSET,
 =09=09},
 =09},
 =09.slaves=09=09=3D omap44xx_ipu_slaves,
@@ -2679,7 +2679,7 @@ static struct omap_hwmod omap44xx_iva_seq0_hwmod =3D =
{
 =09.rst_lines_cnt=09=3D ARRAY_SIZE(omap44xx_iva_seq0_resets),
 =09.prcm =3D {
 =09=09.omap4 =3D {
-=09=09=09.rstctrl_reg =3D OMAP4430_RM_IVAHD_RSTCTRL,
+=09=09=09.rstctrl_offs =3D OMAP4_RM_IVAHD_RSTCTRL_OFFSET,
 =09=09},
 =09},
 =09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -2695,7 +2695,7 @@ static struct omap_hwmod omap44xx_iva_seq1_hwmod =3D =
{
 =09.rst_lines_cnt=09=3D ARRAY_SIZE(omap44xx_iva_seq1_resets),
 =09.prcm =3D {
 =09=09.omap4 =3D {
-=09=09=09.rstctrl_reg =3D OMAP4430_RM_IVAHD_RSTCTRL,
+=09=09=09.rstctrl_offs =3D OMAP4_RM_IVAHD_RSTCTRL_OFFSET,
 =09=09},
 =09},
 =09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -2713,7 +2713,7 @@ static struct omap_hwmod omap44xx_iva_hwmod =3D {
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_IVAHD_IVAHD_CLKCTRL_OFFSET,
-=09=09=09.rstctrl_reg =3D OMAP4430_RM_IVAHD_RSTCTRL,
+=09=09=09.rstctrl_offs =3D OMAP4_RM_IVAHD_RSTCTRL_OFFSET,
 =09=09},
 =09},
 =09.slaves=09=09=3D omap44xx_iva_slaves,
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index a2a04bf..faec860 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -1,7 +1,7 @@
 /*
  * OMAP4 PRM module functions
  *
- * Copyright (C) 2010 Texas Instruments, Inc.
+ * Copyright (C) 2011 Texas Instruments, Inc.
  * Copyright (C) 2010 Nokia Corporation
  * Beno=EEt Cousson
  * Paul Walmsley
@@ -24,12 +24,6 @@
 #include "prm44xx.h"
 #include "prm-regbits-44xx.h"
=20
-/*
- * Address offset (in bytes) between the reset control and the reset
- * status registers: 4 bytes on OMAP4
- */
-#define OMAP4_RST_CTRL_ST_OFFSET=09=094
-
 /* PRM low-level functions */
=20
 /* Read a register in a CM/PRM instance in the PRM module */
@@ -94,91 +88,6 @@ u32 omap4_prm_clear_inst_reg_bits(u32 bits, s16 inst, s1=
6 reg)
 =09return omap4_prm_rmw_inst_reg_bits(bits, 0x0, inst, reg);
 }
=20
-/**
- * omap4_prm_is_hardreset_asserted - read the HW reset line state of
- * submodules contained in the hwmod module
- * @rstctrl_reg: RM_RSTCTRL register address for this module
- * @shift: register bit shift corresponding to the reset line to check
- *
- * Returns 1 if the (sub)module hardreset line is currently asserted,
- * 0 if the (sub)module hardreset line is not currently asserted, or
- * -EINVAL upon parameter error.
- */
-int omap4_prm_is_hardreset_asserted(void __iomem *rstctrl_reg, u8 shift)
-{
-=09if (!cpu_is_omap44xx() || !rstctrl_reg)
-=09=09return -EINVAL;
-
-=09return omap4_prm_read_bits_shift(rstctrl_reg, (1 << shift));
-}
-
-/**
- * omap4_prm_assert_hardreset - assert the HW reset line of a submodule
- * @rstctrl_reg: RM_RSTCTRL register address for this module
- * @shift: register bit shift corresponding to the reset line to assert
- *
- * Some IPs like dsp, ipu or iva contain processors that require an HW
- * reset line to be asserted / deasserted in order to fully enable the
- * IP.  These modules may have multiple hard-reset lines that reset
- * different 'submodules' inside the IP block.  This function will
- * place the submodule into reset.  Returns 0 upon success or -EINVAL
- * upon an argument error.
- */
-int omap4_prm_assert_hardreset(void __iomem *rstctrl_reg, u8 shift)
-{
-=09u32 mask;
-
-=09if (!cpu_is_omap44xx() || !rstctrl_reg)
-=09=09return -EINVAL;
-
-=09mask =3D 1 << shift;
-=09omap4_prm_rmw_reg_bits(mask, mask, rstctrl_reg);
-
-=09return 0;
-}
-
-/**
- * omap4_prm_deassert_hardreset - deassert a submodule hardreset line and =
wait
- * @rstctrl_reg: RM_RSTCTRL register address for this module
- * @shift: register bit shift corresponding to the reset line to deassert
- *
- * Some IPs like dsp, ipu or iva contain processors that require an HW
- * reset line to be asserted / deasserted in order to fully enable the
- * IP.  These modules may have multiple hard-reset lines that reset
- * different 'submodules' inside the IP block.  This function will
- * take the submodule out of reset and wait until the PRCM indicates
- * that the reset has completed before returning.  Returns 0 upon success =
or
- * -EINVAL upon an argument error, -EEXIST if the submodule was already ou=
t
- * of reset, or -EBUSY if the submodule did not exit reset promptly.
- */
-int omap4_prm_deassert_hardreset(void __iomem *rstctrl_reg, u8 shift)
-{
-=09u32 mask;
-=09void __iomem *rstst_reg;
-=09int c;
-
-=09if (!cpu_is_omap44xx() || !rstctrl_reg)
-=09=09return -EINVAL;
-
-=09rstst_reg =3D rstctrl_reg + OMAP4_RST_CTRL_ST_OFFSET;
-
-=09mask =3D 1 << shift;
-
-=09/* Check the current status to avoid de-asserting the line twice */
-=09if (omap4_prm_read_bits_shift(rstctrl_reg, mask) =3D=3D 0)
-=09=09return -EEXIST;
-
-=09/* Clear the reset status by writing 1 to the status bit */
-=09omap4_prm_rmw_reg_bits(0xffffffff, mask, rstst_reg);
-=09/* de-assert the reset control line */
-=09omap4_prm_rmw_reg_bits(mask, 0, rstctrl_reg);
-=09/* wait the status to be set */
-=09omap_test_timeout(omap4_prm_read_bits_shift(rstst_reg, mask),
-=09=09=09  MAX_MODULE_HARDRESET_WAIT, c);
-
-=09return (c =3D=3D MAX_MODULE_HARDRESET_WAIT) ? -EBUSY : 0;
-}
-
 void omap4_prm_global_warm_sw_reset(void)
 {
 =09u32 v;
diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm44xx.h
index 67a0d3f..a21266f 100644
--- a/arch/arm/mach-omap2/prm44xx.h
+++ b/arch/arm/mach-omap2/prm44xx.h
@@ -767,10 +767,6 @@ extern u32 omap4_prm_set_inst_reg_bits(u32 bits, s16 i=
nst, s16 idx);
 extern u32 omap4_prm_clear_inst_reg_bits(u32 bits, s16 inst, s16 idx);
 extern u32 omap4_prm_read_bits_shift(void __iomem *reg, u32 mask);
=20
-extern int omap4_prm_is_hardreset_asserted(void __iomem *rstctrl_reg, u8 s=
hift);
-extern int omap4_prm_assert_hardreset(void __iomem *rstctrl_reg, u8 shift)=
;
-extern int omap4_prm_deassert_hardreset(void __iomem *rstctrl_reg, u8 shif=
t);
-
 extern void omap4_prm_global_warm_sw_reset(void);
=20
 # endif
diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prmins=
t44xx.c
index a303242..35e02aa 100644
--- a/arch/arm/mach-omap2/prminst44xx.c
+++ b/arch/arm/mach-omap2/prminst44xx.c
@@ -2,6 +2,7 @@
  * OMAP4 PRM instance functions
  *
  * Copyright (C) 2009 Nokia Corporation
+ * Copyright (C) 2011 Texas Instruments, Inc.
  * Paul Walmsley
  *
  * This program is free software; you can redistribute it and/or modify
@@ -53,7 +54,7 @@ void omap4_prminst_write_inst_reg(u32 val, u8 part, s16 i=
nst, u16 idx)
=20
 /* Read-modify-write a register in PRM. Caller must lock */
 u32 omap4_prminst_rmw_inst_reg_bits(u32 mask, u32 bits, u8 part, s16 inst,
-=09=09=09=09   s16 idx)
+=09=09=09=09    u16 idx)
 {
 =09u32 v;
=20
@@ -64,3 +65,93 @@ u32 omap4_prminst_rmw_inst_reg_bits(u32 mask, u32 bits, =
u8 part, s16 inst,
=20
 =09return v;
 }
+
+/*
+ * Address offset (in bytes) between the reset control and the reset
+ * status registers: 4 bytes on OMAP4
+ */
+#define OMAP4_RST_CTRL_ST_OFFSET=09=094
+
+/**
+ * omap4_prminst_is_hardreset_asserted - read the HW reset line state of
+ * submodules contained in the hwmod module
+ * @rstctrl_reg: RM_RSTCTRL register address for this module
+ * @shift: register bit shift corresponding to the reset line to check
+ *
+ * Returns 1 if the (sub)module hardreset line is currently asserted,
+ * 0 if the (sub)module hardreset line is not currently asserted, or
+ * -EINVAL upon parameter error.
+ */
+int omap4_prminst_is_hardreset_asserted(u8 shift, u8 part, s16 inst,
+=09=09=09=09=09u16 rstctrl_offs)
+{
+=09u32 v;
+
+=09v =3D omap4_prminst_read_inst_reg(part, inst, rstctrl_offs);
+=09v &=3D 1 << shift;
+=09v >>=3D shift;
+
+=09return v;
+}
+
+/**
+ * omap4_prminst_assert_hardreset - assert the HW reset line of a submodul=
e
+ * @rstctrl_reg: RM_RSTCTRL register address for this module
+ * @shift: register bit shift corresponding to the reset line to assert
+ *
+ * Some IPs like dsp, ipu or iva contain processors that require an HW
+ * reset line to be asserted / deasserted in order to fully enable the
+ * IP.  These modules may have multiple hard-reset lines that reset
+ * different 'submodules' inside the IP block.  This function will
+ * place the submodule into reset.  Returns 0 upon success or -EINVAL
+ * upon an argument error.
+ */
+int omap4_prminst_assert_hardreset(u8 shift, u8 part, s16 inst,
+=09=09=09=09   u16 rstctrl_offs)
+{
+=09u32 mask =3D 1 << shift;
+
+=09omap4_prminst_rmw_inst_reg_bits(mask, mask, part, inst, rstctrl_offs);
+
+=09return 0;
+}
+
+/**
+ * omap4_prminst_deassert_hardreset - deassert a submodule hardreset line =
and
+ * wait
+ * @rstctrl_reg: RM_RSTCTRL register address for this module
+ * @shift: register bit shift corresponding to the reset line to deassert
+ *
+ * Some IPs like dsp, ipu or iva contain processors that require an HW
+ * reset line to be asserted / deasserted in order to fully enable the
+ * IP.  These modules may have multiple hard-reset lines that reset
+ * different 'submodules' inside the IP block.  This function will
+ * take the submodule out of reset and wait until the PRCM indicates
+ * that the reset has completed before returning.  Returns 0 upon success =
or
+ * -EINVAL upon an argument error, -EEXIST if the submodule was already ou=
t
+ * of reset, or -EBUSY if the submodule did not exit reset promptly.
+ */
+int omap4_prminst_deassert_hardreset(u8 shift, u8 part, s16 inst,
+=09=09=09=09     u16 rstctrl_offs)
+{
+=09int c;
+=09u32 mask =3D 1 << shift;
+=09u16 rstst_offs =3D rstctrl_offs + OMAP4_RST_CTRL_ST_OFFSET;
+
+=09/* Check the current status to avoid de-asserting the line twice */
+=09if (omap4_prminst_is_hardreset_asserted(shift, part, inst,
+=09=09=09=09=09=09rstctrl_offs) =3D=3D 0)
+=09=09return -EEXIST;
+
+=09/* Clear the reset status by writing 1 to the status bit */
+=09omap4_prminst_rmw_inst_reg_bits(0xffffffff, mask, part, inst,
+=09=09=09=09=09rstst_offs);
+=09/* de-assert the reset control line */
+=09omap4_prminst_rmw_inst_reg_bits(mask, 0, part, inst, rstctrl_offs);
+=09/* wait the status to be set */
+=09omap_test_timeout(omap4_prminst_is_hardreset_asserted(shift, part, inst=
,
+=09=09=09=09=09=09=09      rstst_offs),
+=09=09=09  MAX_MODULE_HARDRESET_WAIT, c);
+
+=09return (c =3D=3D MAX_MODULE_HARDRESET_WAIT) ? -EBUSY : 0;
+}
diff --git a/arch/arm/mach-omap2/prminst44xx.h b/arch/arm/mach-omap2/prmins=
t44xx.h
index 02dd66d..c14ae29 100644
--- a/arch/arm/mach-omap2/prminst44xx.h
+++ b/arch/arm/mach-omap2/prminst44xx.h
@@ -2,6 +2,7 @@
  * OMAP4 Power/Reset Management (PRM) function prototypes
  *
  * Copyright (C) 2010 Nokia Corporation
+ * Copyright (C) 2011 Texas Instruments, Inc.
  * Paul Walmsley
  *
  * This program is free software; you can redistribute it and/or modify
@@ -18,8 +19,15 @@
 extern u32 omap4_prminst_read_inst_reg(u8 part, s16 inst, u16 idx);
 extern void omap4_prminst_write_inst_reg(u32 val, u8 part, s16 inst, u16 i=
dx);
 extern u32 omap4_prminst_rmw_inst_reg_bits(u32 mask, u32 bits, u8 part,
-=09=09=09=09=09   s16 inst, s16 idx);
+=09=09=09=09=09   s16 inst, u16 idx);
=20
 extern void omap4_prm_global_warm_sw_reset(void);
=20
+extern int omap4_prminst_is_hardreset_asserted(u8 shift, u8 part, s16 inst=
,
+=09=09=09=09=09   u16 rstctrl_offs);
+extern int omap4_prminst_assert_hardreset(u8 shift, u8 part, s16 inst,
+=09=09=09=09      u16 rstctrl_offs);
+extern int omap4_prminst_deassert_hardreset(u8 shift, u8 part, s16 inst,
+=09=09=09=09=09u16 rstctrl_offs);
+
 #endif
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-o=
map/include/plat/omap_hwmod.h
index 507e65a..627be22 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -2,6 +2,7 @@
  * omap_hwmod macros, structures
  *
  * Copyright (C) 2009-2011 Nokia Corporation
+ * Copyright (C) 2011 Texas Instruments, Inc.
  * Paul Walmsley
  *
  * Created in collaboration with (alphabetical order): Beno=EEt Cousson,
@@ -363,7 +364,7 @@ struct omap_hwmod_omap2_prcm {
  */
 struct omap_hwmod_omap4_prcm {
 =09u16=09=09clkctrl_offs;
-=09void __iomem=09*rstctrl_reg;
+=09u16=09=09rstctrl_offs;
 =09u8=09=09submodule_wkdep_bit;
 };
=20
--=20
1.7.5.4

--155748971-137127682-1310027321=:30028--
