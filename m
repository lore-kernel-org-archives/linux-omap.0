From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 07/11] OMAP4: PRM: add module hard reset support
Date: Tue, 21 Sep 2010 10:34:49 -0600
Message-ID: <20100921163448.20258.86589.stgit@twilight.localdomain>
References: <20100921163021.20258.87587.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47041 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757838Ab0IUQfk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 12:35:40 -0400
In-Reply-To: <20100921163021.20258.87587.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

=46rom: Beno=C3=AEt Cousson <b-cousson@ti.com>

Most processor modules (e.g., DSP, IVA, IPU) on OMAPs can be reset
under the control of the PRM.  This patch adds an API for this purpose
for OMAP4 devices:

int omap4_prm_is_hardreset_asserted(void __iomem *rstctrl_reg, u8 shift=
);
int omap4_prm_assert_hardreset(void __iomem *rstctrl_reg, u8 shift);
int omap4_prm_deassert_hardreset(void __iomem *rstctrl_reg, u8 shift);

This API is intended to be used only by the hwmod code - a subsequent
patch will add that support to hwmod.

This patch is a collaboration between Beno=C3=AEt Cousson <b-cousson@ti=
=2Ecom>
and Paul Walmsley <paul@pwsan.com>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/Makefile  |    2 -
 arch/arm/mach-omap2/prm.h     |   13 ++++-
 arch/arm/mach-omap2/prm44xx.c |  116 +++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 129 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-omap2/prm44xx.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefil=
e
index 88d3a1e..c0da784 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -15,7 +15,7 @@ clock-common				=3D clock.o clock_common_data.o \
=20
 obj-$(CONFIG_ARCH_OMAP2) +=3D $(omap-2-3-common) $(prcm-common) $(hwmo=
d-common)
 obj-$(CONFIG_ARCH_OMAP3) +=3D $(omap-2-3-common) $(prcm-common) $(hwmo=
d-common)
-obj-$(CONFIG_ARCH_OMAP4) +=3D $(prcm-common) $(hwmod-common)
+obj-$(CONFIG_ARCH_OMAP4) +=3D $(prcm-common) prm44xx.o $(hwmod-common)
=20
 obj-$(CONFIG_OMAP_MCBSP) +=3D mcbsp.o
=20
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 588873b..bc7e6e6 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -5,7 +5,7 @@
  * OMAP2/3 Power/Reset Management (PRM) register definitions
  *
  * Copyright (C) 2007-2009 Texas Instruments, Inc.
- * Copyright (C) 2009 Nokia Corporation
+ * Copyright (C) 2010 Nokia Corporation
  *
  * Written by Paul Walmsley
  *
@@ -246,6 +246,10 @@ static inline u32 prm_clear_mod_reg_bits(u32 bits,=
 s16 module, s16 idx)
 	return prm_rmw_mod_reg_bits(bits, 0x0, module, idx);
 }
=20
+int omap4_prm_is_hardreset_asserted(void __iomem *rstctrl_reg, u8 shif=
t);
+int omap4_prm_assert_hardreset(void __iomem *rstctrl_reg, u8 shift);
+int omap4_prm_deassert_hardreset(void __iomem *rstctrl_reg, u8 shift);
+
 #endif
=20
 /*
@@ -398,4 +402,11 @@ static inline u32 prm_clear_mod_reg_bits(u32 bits,=
 s16 module, s16 idx)
 #define OMAP_POWERSTATE_MASK				(0x3 << 0)
=20
=20
+/*
+ * MAX_MODULE_HARDRESET_WAIT: Maximum microseconds to wait for an OMAP
+ * submodule to exit hardreset
+ */
+#define MAX_MODULE_HARDRESET_WAIT		10000
+
+
 #endif
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44x=
x.c
new file mode 100644
index 0000000..a1ff918
--- /dev/null
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -0,0 +1,116 @@
+/*
+ * OMAP4 PRM module functions
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
+#include "prm-regbits-44xx.h"
+
+/*
+ * Address offset (in bytes) between the reset control and the reset
+ * status registers: 4 bytes on OMAP4
+ */
+#define OMAP4_RST_CTRL_ST_OFFSET		4
+
+/**
+ * omap4_prm_is_hardreset_asserted - read the HW reset line state of
+ * submodules contained in the hwmod module
+ * @rstctrl_reg: RM_RSTCTRL register address for this module
+ * @shift: register bit shift corresponding to the reset line to check
+ *
+ * Returns 1 if the (sub)module hardreset line is currently asserted,
+ * 0 if the (sub)module hardreset line is not currently asserted, or
+ * -EINVAL upon parameter error.
+ */
+int omap4_prm_is_hardreset_asserted(void __iomem *rstctrl_reg, u8 shif=
t)
+{
+	if (!cpu_is_omap44xx() || !rstctrl_reg)
+		return -EINVAL;
+
+	return omap4_prm_read_bits_shift(rstctrl_reg, (1 << shift));
+}
+
+/**
+ * omap4_prm_assert_hardreset - assert the HW reset line of a submodul=
e
+ * @rstctrl_reg: RM_RSTCTRL register address for this module
+ * @shift: register bit shift corresponding to the reset line to asser=
t
+ *
+ * Some IPs like dsp, ipu or iva contain processors that require an HW
+ * reset line to be asserted / deasserted in order to fully enable the
+ * IP.  These modules may have multiple hard-reset lines that reset
+ * different 'submodules' inside the IP block.  This function will
+ * place the submodule into reset.  Returns 0 upon success or -EINVAL
+ * upon an argument error.
+ */
+int omap4_prm_assert_hardreset(void __iomem *rstctrl_reg, u8 shift)
+{
+	u32 mask;
+
+	if (!cpu_is_omap44xx() || !rstctrl_reg)
+		return -EINVAL;
+
+	mask =3D 1 << shift;
+	omap4_prm_rmw_reg_bits(mask, mask, rstctrl_reg);
+
+	return 0;
+}
+
+/**
+ * omap4_prm_deassert_hardreset - deassert a submodule hardreset line =
and wait
+ * @rstctrl_reg: RM_RSTCTRL register address for this module
+ * @shift: register bit shift corresponding to the reset line to deass=
ert
+ *
+ * Some IPs like dsp, ipu or iva contain processors that require an HW
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
+int omap4_prm_deassert_hardreset(void __iomem *rstctrl_reg, u8 shift)
+{
+	u32 mask;
+	void __iomem *rstst_reg;
+	int c;
+
+	if (!cpu_is_omap44xx() || !rstctrl_reg)
+		return -EINVAL;
+
+	rstst_reg =3D rstctrl_reg + OMAP4_RST_CTRL_ST_OFFSET;
+
+	mask =3D 1 << shift;
+
+	/* Check the current status to avoid de-asserting the line twice */
+	if (omap4_prm_read_bits_shift(rstctrl_reg, mask) =3D=3D 0)
+		return -EEXIST;
+
+	/* Clear the reset status by writing 1 to the status bit */
+	omap4_prm_rmw_reg_bits(0xffffffff, mask, rstst_reg);
+	/* de-assert the reset control line */
+	omap4_prm_rmw_reg_bits(mask, 0, rstctrl_reg);
+	/* wait the status to be set */
+	omap_test_timeout(omap4_prm_read_bits_shift(rstst_reg, mask),
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
