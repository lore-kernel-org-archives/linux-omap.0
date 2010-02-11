From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 01/13] OMAP2/3/4 clock: fix DPLL multiplier value errors;
	also copyrights, includes, documentation
Date: Thu, 11 Feb 2010 11:16:25 -0700
Message-ID: <20100211181619.795.6928.stgit@localhost.localdomain>
References: <20100211181236.795.56094.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35510 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756487Ab0BKSUx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 13:20:53 -0500
In-Reply-To: <20100211181236.795.56094.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rajendra Nayak <rnayak@ti.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

The maximum DPLL multiplier (M) values for OMAP2xxx and OMAP3xxx are
one increment higher than they should be.  See for example the
OMAP242x TRM Rev X Section 5.10.6 "Clock Generator Registers" and the
OMAP36xx TRM Rev C Table 3-202 "CM_CLKSEL1_PLL".  Programming a 0 into
the DPLL's M register bitfield is valid for OMAP2/3 and indicates that
the DPLL should enter MN-bypass mode.  Also, increase the minimum
multiplier (M) value for the DPLL rate rounding code from 1 to 2, to
ensure that it does not inadvertently put the DPLL into bypass.

Note that the register documentation in the OMAP2xxx and OMAP3xxx TRMs
does not make clear that the actual DPLL divider value (the "N") is
the content of the appropriate register bitfield for the N value,
_plus one_.  (In other words, an N register bitfield of 0 indicates a
DPLL divider value of 1.)  This is only clearly documented in the
OMAP4430 TRM, in, for example, OMAP4430 TRM Rev A Table 3-1167
"CM_CLKSEL_DPLL_USB".

While here, update copyrights, add kerneldoc for struct dpll_data,
drop the unused struct dpll_data.max_tolerance field, remove some
unnecessary #includes in DPLL-related code, and replace the #include
of <linux/module.h> with <linux/list.h>, which is what was really
needed.  The OMAP4 clock autogenerator script has been updated
accordingly.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clkt_dpll.c         |    2 -
 arch/arm/mach-omap2/clock2xxx_data.c    |    6 +--
 arch/arm/mach-omap2/clock34xx_data.c    |    8 ++--
 arch/arm/mach-omap2/clock44xx.h         |    7 +++
 arch/arm/mach-omap2/clock44xx_data.c    |    2 -
 arch/arm/mach-omap2/dpll3xxx.c          |    4 --
 arch/arm/plat-omap/include/plat/clock.h |   64 +++++++++++++++++++++++=
++------
 7 files changed, 67 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt_dpll.c b/arch/arm/mach-omap2/clkt=
_dpll.c
index 9eee0e6..6ce512e 100644
--- a/arch/arm/mach-omap2/clkt_dpll.c
+++ b/arch/arm/mach-omap2/clkt_dpll.c
@@ -29,7 +29,7 @@
 #include "cm-regbits-34xx.h"
=20
 /* DPLL rate rounding: minimum DPLL multiplier, divider values */
-#define DPLL_MIN_MULTIPLIER		1
+#define DPLL_MIN_MULTIPLIER		2
 #define DPLL_MIN_DIVIDER		1
=20
 /* Possible error results from _dpll_test_mult */
diff --git a/arch/arm/mach-omap2/clock2xxx_data.c b/arch/arm/mach-omap2=
/clock2xxx_data.c
index 52c7a6c..f20a4b2 100644
--- a/arch/arm/mach-omap2/clock2xxx_data.c
+++ b/arch/arm/mach-omap2/clock2xxx_data.c
@@ -2,7 +2,7 @@
  *  linux/arch/arm/mach-omap2/clock2xxx_data.c
  *
  *  Copyright (C) 2005-2009 Texas Instruments, Inc.
- *  Copyright (C) 2004-2009 Nokia Corporation
+ *  Copyright (C) 2004-2010 Nokia Corporation
  *
  *  Contacts:
  *  Richard Woodruff <r-woodruff2@ti.com>
@@ -13,9 +13,9 @@
  * published by the Free Software Foundation.
  */
=20
-#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/clk.h>
+#include <linux/list.h>
=20
 #include <plat/clkdev_omap.h>
=20
@@ -107,7 +107,7 @@ static struct dpll_data dpll_dd =3D {
 	.clk_ref		=3D &sys_ck,
 	.control_reg		=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_mask		=3D OMAP24XX_EN_DPLL_MASK,
-	.max_multiplier		=3D 1024,
+	.max_multiplier		=3D 1023,
 	.min_divider		=3D 1,
 	.max_divider		=3D 16,
 	.rate_tolerance		=3D DEFAULT_DPLL_RATE_TOLERANCE
diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2=
/clock34xx_data.c
index 972a90a..92529da 100644
--- a/arch/arm/mach-omap2/clock34xx_data.c
+++ b/arch/arm/mach-omap2/clock34xx_data.c
@@ -1,8 +1,8 @@
 /*
  * OMAP3 clock data
  *
- * Copyright (C) 2007-2009 Texas Instruments, Inc.
- * Copyright (C) 2007-2009 Nokia Corporation
+ * Copyright (C) 2007-2010 Texas Instruments, Inc.
+ * Copyright (C) 2007-2010 Nokia Corporation
  *
  * Written by Paul Walmsley
  * With many device clock fixes by Kevin Hilman and Jouni H=C3=B6gande=
r
@@ -16,9 +16,9 @@
  * to be requested from drivers directly.
  */
=20
-#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/clk.h>
+#include <linux/list.h>
=20
 #include <plat/control.h>
 #include <plat/clkdev_omap.h>
@@ -37,7 +37,7 @@
 #define OMAP_CM_REGADDR		OMAP34XX_CM_REGADDR
=20
 /* Maximum DPLL multiplier, divider values for OMAP3 */
-#define OMAP3_MAX_DPLL_MULT		2048
+#define OMAP3_MAX_DPLL_MULT		2047
 #define OMAP3630_MAX_JTYPE_DPLL_MULT	4095
 #define OMAP3_MAX_DPLL_DIV		128
=20
diff --git a/arch/arm/mach-omap2/clock44xx.h b/arch/arm/mach-omap2/cloc=
k44xx.h
index 1f55b6b..ed3b741 100644
--- a/arch/arm/mach-omap2/clock44xx.h
+++ b/arch/arm/mach-omap2/clock44xx.h
@@ -2,12 +2,17 @@
  * OMAP4 clock function prototypes and macros
  *
  * Copyright (C) 2009 Texas Instruments, Inc.
+ * Copyright (C) 2010 Nokia Corporation
  */
=20
 #ifndef __ARCH_ARM_MACH_OMAP2_CLOCK_44XX_H
 #define __ARCH_ARM_MACH_OMAP2_CLOCK_44XX_H
=20
-#define OMAP4430_MAX_DPLL_MULT	2048
+/*
+ * XXX Missing values for the OMAP4 DPLL_USB
+ * XXX Missing min_multiplier values for all OMAP4 DPLLs
+ */
+#define OMAP4430_MAX_DPLL_MULT	2047
 #define OMAP4430_MAX_DPLL_DIV	128
=20
 int omap4xxx_clk_init(void);
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2=
/clock44xx_data.c
index 3165f53..1cb789d 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -20,7 +20,7 @@
  */
=20
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/list.h>
 #include <linux/clk.h>
=20
 #include <plat/control.h>
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3=
xxx.c
index 781f750..f7396f0 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -18,7 +18,6 @@
  * published by the Free Software Foundation.
  */
=20
-#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/list.h>
@@ -26,13 +25,10 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/io.h>
-#include <linux/limits.h>
 #include <linux/bitops.h>
=20
 #include <plat/cpu.h>
 #include <plat/clock.h>
-#include <plat/sram.h>
-#include <asm/div64.h>
 #include <asm/clkdev.h>
=20
 #include "clock.h"
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-om=
ap/include/plat/clock.h
index 62fd64f..7b7d046 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -1,9 +1,9 @@
 /*
- *  arch/arm/plat-omap/include/mach/clock.h
+ * OMAP clock: data structure definitions, function prototypes, shared=
 macros
  *
- *  Copyright (C) 2004 - 2005 Nokia corporation
- *  Written by Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
- *  Based on clocks.h by Tony Lindgren, Gordon McNutt and RidgeRun, In=
c
+ * Copyright (C) 2004-2005, 2008-2010 Nokia Corporation
+ * Written by Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
+ * Based on clocks.h by Tony Lindgren, Gordon McNutt and RidgeRun, Inc
  *
  * This program is free software; you can redistribute it and/or modif=
y
  * it under the terms of the GNU General Public License version 2 as
@@ -42,9 +42,49 @@ struct clksel {
 	const struct clksel_rate *rates;
 };
=20
-/*
- * A new flag called flag has been added which indicates what is the
- * type of dpll (like j_type, no_dco_sel)
+/**
+ * struct dpll_data - DPLL registers and integration data
+ * @mult_div1_reg: register containing the DPLL M and N bitfields
+ * @mult_mask: mask of the DPLL M bitfield in @mult_div1_reg
+ * @div1_mask: mask of the DPLL N bitfield in @mult_div1_reg
+ * @clk_bypass: struct clk pointer to the clock's bypass clock input
+ * @clk_ref: struct clk pointer to the clock's reference clock input
+ * @control_reg: register containing the DPLL mode bitfield
+ * @enable_mask: mask of the DPLL mode bitfield in @control_reg
+ * @rate_tolerance: maximum variance allowed from target rate (in Hz)
+ * @last_rounded_rate: cache of the last rate result of omap2_dpll_rou=
nd_rate()
+ * @last_rounded_m: cache of the last M result of omap2_dpll_round_rat=
e()
+ * @max_multiplier: maximum valid non-bypass multiplier value (actual)
+ * @last_rounded_n: cache of the last N result of omap2_dpll_round_rat=
e()
+ * @min_divider: minimum valid non-bypass divider value (actual)
+ * @max_divider: maximum valid non-bypass divider value (actual)
+ * @modes: possible values of @enable_mask
+ * @autoidle_reg: register containing the DPLL autoidle mode bitfield
+ * @idlest_reg: register containing the DPLL idle status bitfield
+ * @autoidle_mask: mask of the DPLL autoidle mode bitfield in @autoidl=
e_reg
+ * @freqsel_mask: mask of the DPLL jitter correction bitfield in @cont=
rol_reg
+ * @idlest_mask: mask of the DPLL idle status bitfield in @idlest_reg
+ * @auto_recal_bit: bitshift of the driftguard enable bit in @control_=
reg
+ * @recal_en_bit: bitshift of the PRM_IRQENABLE_* bit for recalibratio=
n IRQs
+ * @recal_st_bit: bitshift of the PRM_IRQSTATUS_* bit for recalibratio=
n IRQs
+ * @flags: DPLL type/features (see below)
+ *
+ * Possible values for @flags:
+ * DPLL_J_TYPE: "J-type DPLL" (only some 36xx, 4xxx DPLLs)
+ * NO_DCO_SEL: don't program DCO (only for some J-type DPLLs)
+
+ * @freqsel_mask is only used on the OMAP34xx family and AM35xx.
+ *
+ * XXX Some DPLLs have multiple bypass inputs, so it's not technically
+ * correct to only have one @clk_bypass pointer.
+ *
+ * XXX @rate_tolerance should probably be deprecated - currently there
+ * don't seem to be any usecases for DPLL rounding that is not exact.
+ *
+ * XXX The runtime-variable fields (@last_rounded_rate, @last_rounded_=
m,
+ * @last_rounded_n) should be separated from the runtime-fixed fields
+ * and placed into a differenct structure, so that the runtime-fixed d=
ata
+ * can be placed into read-only space.
  */
 struct dpll_data {
 	void __iomem		*mult_div1_reg;
@@ -57,13 +97,12 @@ struct dpll_data {
 	unsigned int		rate_tolerance;
 	unsigned long		last_rounded_rate;
 	u16			last_rounded_m;
+	u16			max_multiplier;
 	u8			last_rounded_n;
 	u8			min_divider;
 	u8			max_divider;
-	u32			max_tolerance;
-	u16			max_multiplier;
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 	u8			modes;
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 	void __iomem		*autoidle_reg;
 	void __iomem		*idlest_reg;
 	u32			autoidle_mask;
@@ -154,6 +193,7 @@ extern const struct clkops clkops_null;
 #define RATE_FIXED		(1 << 1)	/* Fixed clock rate */
 /* bits 2-4 are free */
 #define ENABLE_REG_32BIT	(1 << 5)	/* Use 32-bit access */
+/* bit 6 is free */
 #define CLOCK_IDLE_CONTROL	(1 << 7)
 #define CLOCK_NO_IDLE_PARENT	(1 << 8)
 #define DELAYED_APP		(1 << 9)	/* Delay application of clock */
@@ -162,14 +202,14 @@ extern const struct clkops clkops_null;
 #define INVERT_ENABLE           (1 << 12)       /* 0 enables, 1 disabl=
es */
 #define CLOCK_IN_OMAP4430	(1 << 13)
 #define ALWAYS_ENABLED		(1 << 14)
-/* bits 13-31 are currently free */
+/* bits 15-31 are currently free */
=20
 /* Clksel_rate flags */
 #define DEFAULT_RATE		(1 << 0)
 #define RATE_IN_242X		(1 << 1)
 #define RATE_IN_243X		(1 << 2)
 #define RATE_IN_343X		(1 << 3)	/* rates common to all 343X */
-#define RATE_IN_3430ES2	(1 << 4)	/* 3430ES2 rates only */
+#define RATE_IN_3430ES2		(1 << 4)	/* 3430ES2 rates only */
 #define RATE_IN_36XX		(1 << 5)
 #define RATE_IN_4430		(1 << 6)
=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
