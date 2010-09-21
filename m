From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 08/11] OMAP2/3: PRM: add module hard reset support
Date: Tue, 21 Sep 2010 10:34:51 -0600
Message-ID: <20100921163449.20258.89354.stgit@twilight.localdomain>
References: <20100921163021.20258.87587.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47044 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757941Ab0IUQfk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 12:35:40 -0400
In-Reply-To: <20100921163021.20258.87587.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

This patch adds hard-reset support for processor modules (e.g., DSP, IV=
A)
on OMAP2/3 platforms.  It's based on the OMAP4 hard-reset support that =
Beno=C3=AEt
developed in the previous patch.

This patch is a collaboration between Beno=C3=AEt Cousson <b-cousson@ti=
=2Ecom>
and Paul Walmsley <paul@pwsan.com>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/Makefile       |    2 -
 arch/arm/mach-omap2/prm.h          |    5 ++
 arch/arm/mach-omap2/prm2xxx_3xxx.c |  110 ++++++++++++++++++++++++++++=
++++++++
 3 files changed, 116 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/prm2xxx_3xxx.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefil=
e
index c0da784..eb2504a 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -5,7 +5,7 @@
 # Common support
 obj-y :=3D id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-g=
p.o pm.o
=20
-omap-2-3-common				=3D irq.o sdrc.o
+omap-2-3-common				=3D irq.o sdrc.o prm2xxx_3xxx.o
 hwmod-common				=3D omap_hwmod.o \
 					  omap_hwmod_common_data.o
 prcm-common				=3D prcm.o powerdomain.o
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index bc7e6e6..7be040b 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -246,6 +246,11 @@ static inline u32 prm_clear_mod_reg_bits(u32 bits,=
 s16 module, s16 idx)
 	return prm_rmw_mod_reg_bits(bits, 0x0, module, idx);
 }
=20
+/* These omap2_ PRM functions apply to both OMAP2 and 3 */
+int omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift);
+int omap2_prm_assert_hardreset(s16 prm_mod, u8 shift);
+int omap2_prm_deassert_hardreset(s16 prm_mod, u8 shift);
+
 int omap4_prm_is_hardreset_asserted(void __iomem *rstctrl_reg, u8 shif=
t);
 int omap4_prm_assert_hardreset(void __iomem *rstctrl_reg, u8 shift);
 int omap4_prm_deassert_hardreset(void __iomem *rstctrl_reg, u8 shift);
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/p=
rm2xxx_3xxx.c
new file mode 100644
index 0000000..421771e
--- /dev/null
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -0,0 +1,110 @@
+/*
+ * OMAP2/3 PRM module functions
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Copyright (C) 2010 Nokia Corporation
+ * Beno=C3=AEt Cousson
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+
+#include <plat/common.h>
+#include <plat/cpu.h>
+#include <plat/prcm.h>
+
+#include "prm.h"
+#include "prm-regbits-24xx.h"
+#include "prm-regbits-34xx.h"
+
+/**
+ * omap2_prm_is_hardreset_asserted - read the HW reset line state of
+ * submodules contained in the hwmod module
+ * @prm_mod: PRM submodule base (e.g. CORE_MOD)
+ * @shift: register bit shift corresponding to the reset line to check
+ *
+ * Returns 1 if the (sub)module hardreset line is currently asserted,
+ * 0 if the (sub)module hardreset line is not currently asserted, or
+ * -EINVAL if called while running on a non-OMAP2/3 chip.
+ */
+int omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift)
+{
+	if (!(cpu_is_omap24xx() || cpu_is_omap34xx()))
+		return -EINVAL;
+
+	return prm_read_mod_bits_shift(prm_mod, OMAP2_RM_RSTCTRL,
+				       (1 << shift));
+}
+
+/**
+ * omap2_prm_assert_hardreset - assert the HW reset line of a submodul=
e
+ * @prm_mod: PRM submodule base (e.g. CORE_MOD)
+ * @shift: register bit shift corresponding to the reset line to asser=
t
+ *
+ * Some IPs like dsp or iva contain processors that require an HW
+ * reset line to be asserted / deasserted in order to fully enable the
+ * IP.  These modules may have multiple hard-reset lines that reset
+ * different 'submodules' inside the IP block.  This function will
+ * place the submodule into reset.  Returns 0 upon success or -EINVAL
+ * upon an argument error.
+ */
+int omap2_prm_assert_hardreset(s16 prm_mod, u8 shift)
+{
+	u32 mask;
+
+	if (!(cpu_is_omap24xx() || cpu_is_omap34xx()))
+		return -EINVAL;
+
+	mask =3D 1 << shift;
+	prm_rmw_mod_reg_bits(mask, mask, prm_mod, OMAP2_RM_RSTCTRL);
+
+	return 0;
+}
+
+/**
+ * omap2_prm_deassert_hardreset - deassert a submodule hardreset line =
and wait
+ * @prm_mod: PRM submodule base (e.g. CORE_MOD)
+ * @shift: register bit shift corresponding to the reset line to deass=
ert
+ *
+ * Some IPs like dsp or iva contain processors that require an HW
+ * reset line to be asserted / deasserted in order to fully enable the
+ * IP.  These modules may have multiple hard-reset lines that reset
+ * different 'submodules' inside the IP block.  This function will
+ * take the submodule out of reset and wait until the PRCM indicates
+ * that the reset has completed before returning.  Returns 0 upon succ=
ess or
+ * -EINVAL upon an argument error, -EEXIST if the submodule was alread=
y out
+ * of reset, or -EBUSY if the submodule did not exit reset promptly.
+ */
+int omap2_prm_deassert_hardreset(s16 prm_mod, u8 shift)
+{
+	u32 mask;
+	int c;
+
+	if (!(cpu_is_omap24xx() || cpu_is_omap34xx()))
+		return -EINVAL;
+
+	mask =3D 1 << shift;
+
+	/* Check the current status to avoid de-asserting the line twice */
+	if (prm_read_mod_bits_shift(prm_mod, OMAP2_RM_RSTCTRL, mask) =3D=3D 0=
)
+		return -EEXIST;
+
+	/* Clear the reset status by writing 1 to the status bit */
+	prm_rmw_mod_reg_bits(0xffffffff, mask, prm_mod, OMAP2_RM_RSTST);
+	/* de-assert the reset control line */
+	prm_rmw_mod_reg_bits(mask, 0, prm_mod, OMAP2_RM_RSTCTRL);
+	/* wait the status to be set */
+	omap_test_timeout(prm_read_mod_bits_shift(prm_mod, OMAP2_RM_RSTST,
+						  mask),
+			  MAX_MODULE_HARDRESET_WAIT, c);
+
+	return (c =3D=3D MAX_MODULE_HARDRESET_WAIT) ? -EBUSY : 0;
+}
+


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
