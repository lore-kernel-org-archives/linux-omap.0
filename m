From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 12/18] OMAP3 clock: split out DPLL3 M2 divider functions into
	clkt3xxx_dpll3m2.c
Date: Fri, 15 Jan 2010 02:07:04 -0700
Message-ID: <20100115090703.30690.171.stgit@localhost.localdomain>
References: <20100115090613.30690.49355.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48741 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756824Ab0AOJIP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 04:08:15 -0500
In-Reply-To: <20100115090613.30690.49355.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jouni =?utf-8?b?SMO2Z2FuZGVy?= <jouni.hogander@nokia.com>

Split the DPLL3 M2 divider clock functions out of clock34xx.c and move =
them
into clkt3xxx_dpll3m2.c to improve maintainability.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Jouni H=C3=B6gander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/Makefile           |    3 +
 arch/arm/mach-omap2/clkt3xxx_dpll3m2.c |  120 ++++++++++++++++++++++++=
++++++++
 arch/arm/mach-omap2/clock34xx.c        |   90 ------------------------
 3 files changed, 122 insertions(+), 91 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clkt3xxx_dpll3m2.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefil=
e
index 7ce5fea..b002c81 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -15,11 +15,12 @@ clock-omap2xxx				=3D clkt2xxx_dpllcore.o \
 					  clkt2xxx_virt_prcm_set.o \
 					  clkt2xxx_apll.o clkt2xxx_osc.o \
 					  clkt2xxx_sys.o
+clock-omap3xxx				=3D clkt3xxx_dpll3m2.o
=20
 obj-$(CONFIG_ARCH_OMAP2) +=3D $(omap-2-3-common) $(prcm-common) $(cloc=
k-common) \
 			    $(clock-omap2xxx)
 obj-$(CONFIG_ARCH_OMAP3) +=3D $(omap-2-3-common) $(prcm-common) $(cloc=
k-common) \
-			    $(omap-3-4-common)
+			    $(omap-3-4-common) $(clock-omap3xxx)
 obj-$(CONFIG_ARCH_OMAP4) +=3D $(omap-3-4-common) $(prcm-common) $(cloc=
k-common)
=20
 obj-$(CONFIG_OMAP_MCBSP) +=3D mcbsp.o
diff --git a/arch/arm/mach-omap2/clkt3xxx_dpll3m2.c b/arch/arm/mach-oma=
p2/clkt3xxx_dpll3m2.c
new file mode 100644
index 0000000..14f1a4b
--- /dev/null
+++ b/arch/arm/mach-omap2/clkt3xxx_dpll3m2.c
@@ -0,0 +1,120 @@
+/*
+ * OMAP3 M2 divider clock code
+ *
+ * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * Copyright (C) 2007-2010 Nokia Corporation
+ *
+ * Paul Walmsley
+ * Jouni H=C3=B6gander
+ *
+ * Parts of this code are based on code written by
+ * Richard Woodruff, Tony Lindgren, Tuukka Tikkanen, Karthik Dasu
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <plat/clock.h>
+#include <plat/sram.h>
+#include <plat/sdrc.h>
+
+#include "clock.h"
+#include "clock34xx.h"
+#include "sdrc.h"
+
+#define CYCLES_PER_MHZ			1000000
+
+/*
+ * CORE DPLL (DPLL3) M2 divider rate programming functions
+ *
+ * These call into SRAM code to do the actual CM writes, since the SDR=
AM
+ * is clocked from DPLL3.
+ */
+
+/**
+ * omap3_core_dpll_m2_set_rate - set CORE DPLL M2 divider
+ * @clk: struct clk * of DPLL to set
+ * @rate: rounded target rate
+ *
+ * Program the DPLL M2 divider with the rounded target rate.  Returns
+ * -EINVAL upon error, or 0 upon success.
+ */
+int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
+{
+	u32 new_div =3D 0;
+	u32 unlock_dll =3D 0;
+	u32 c;
+	unsigned long validrate, sdrcrate, _mpurate;
+	struct omap_sdrc_params *sdrc_cs0;
+	struct omap_sdrc_params *sdrc_cs1;
+	int ret;
+
+	if (!clk || !rate)
+		return -EINVAL;
+
+	validrate =3D omap2_clksel_round_rate_div(clk, rate, &new_div);
+	if (validrate !=3D rate)
+		return -EINVAL;
+
+	sdrcrate =3D sdrc_ick_p->rate;
+	if (rate > clk->rate)
+		sdrcrate <<=3D ((rate / clk->rate) >> 1);
+	else
+		sdrcrate >>=3D ((clk->rate / rate) >> 1);
+
+	ret =3D omap2_sdrc_get_params(sdrcrate, &sdrc_cs0, &sdrc_cs1);
+	if (ret)
+		return -EINVAL;
+
+	if (sdrcrate < MIN_SDRC_DLL_LOCK_FREQ) {
+		pr_debug("clock: will unlock SDRC DLL\n");
+		unlock_dll =3D 1;
+	}
+
+	/*
+	 * XXX This only needs to be done when the CPU frequency changes
+	 */
+	_mpurate =3D arm_fck_p->rate / CYCLES_PER_MHZ;
+	c =3D (_mpurate << SDRC_MPURATE_SCALE) >> SDRC_MPURATE_BASE_SHIFT;
+	c +=3D 1;  /* for safety */
+	c *=3D SDRC_MPURATE_LOOPS;
+	c >>=3D SDRC_MPURATE_SCALE;
+	if (c =3D=3D 0)
+		c =3D 1;
+
+	pr_debug("clock: changing CORE DPLL rate from %lu to %lu\n", clk->rat=
e,
+		 validrate);
+	pr_debug("clock: SDRC CS0 timing params used:"
+		 " RFR %08x CTRLA %08x CTRLB %08x MR %08x\n",
+		 sdrc_cs0->rfr_ctrl, sdrc_cs0->actim_ctrla,
+		 sdrc_cs0->actim_ctrlb, sdrc_cs0->mr);
+	if (sdrc_cs1)
+		pr_debug("clock: SDRC CS1 timing params used: "
+		 " RFR %08x CTRLA %08x CTRLB %08x MR %08x\n",
+		 sdrc_cs1->rfr_ctrl, sdrc_cs1->actim_ctrla,
+		 sdrc_cs1->actim_ctrlb, sdrc_cs1->mr);
+
+	if (sdrc_cs1)
+		omap3_configure_core_dpll(
+				  new_div, unlock_dll, c, rate > clk->rate,
+				  sdrc_cs0->rfr_ctrl, sdrc_cs0->actim_ctrla,
+				  sdrc_cs0->actim_ctrlb, sdrc_cs0->mr,
+				  sdrc_cs1->rfr_ctrl, sdrc_cs1->actim_ctrla,
+				  sdrc_cs1->actim_ctrlb, sdrc_cs1->mr);
+	else
+		omap3_configure_core_dpll(
+				  new_div, unlock_dll, c, rate > clk->rate,
+				  sdrc_cs0->rfr_ctrl, sdrc_cs0->actim_ctrla,
+				  sdrc_cs0->actim_ctrlb, sdrc_cs0->mr,
+				  0, 0, 0, 0);
+
+	return 0;
+}
+
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/cloc=
k34xx.c
index 4c4bb3c..552ad30 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -42,8 +42,6 @@
 #include "cm.h"
 #include "cm-regbits-34xx.h"
=20
-#define CYCLES_PER_MHZ			1000000
-
 /*
  * DPLL5_FREQ_FOR_USBHOST: USBHOST and USBTLL are the only clocks
  * that are sourced by DPLL5, and both of these require this clock
@@ -162,94 +160,6 @@ int omap3_dpll4_set_rate(struct clk *clk, unsigned=
 long rate)
 	return omap3_noncore_dpll_set_rate(clk, rate);
 }
=20
-
-/*
- * CORE DPLL (DPLL3) rate programming functions
- *
- * These call into SRAM code to do the actual CM writes, since the SDR=
AM
- * is clocked from DPLL3.
- */
-
-/**
- * omap3_core_dpll_m2_set_rate - set CORE DPLL M2 divider
- * @clk: struct clk * of DPLL to set
- * @rate: rounded target rate
- *
- * Program the DPLL M2 divider with the rounded target rate.  Returns
- * -EINVAL upon error, or 0 upon success.
- */
-int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
-{
-	u32 new_div =3D 0;
-	u32 unlock_dll =3D 0;
-	u32 c;
-	unsigned long validrate, sdrcrate, _mpurate;
-	struct omap_sdrc_params *sdrc_cs0;
-	struct omap_sdrc_params *sdrc_cs1;
-	int ret;
-
-	if (!clk || !rate)
-		return -EINVAL;
-
-	validrate =3D omap2_clksel_round_rate_div(clk, rate, &new_div);
-	if (validrate !=3D rate)
-		return -EINVAL;
-
-	sdrcrate =3D sdrc_ick_p->rate;
-	if (rate > clk->rate)
-		sdrcrate <<=3D ((rate / clk->rate) >> 1);
-	else
-		sdrcrate >>=3D ((clk->rate / rate) >> 1);
-
-	ret =3D omap2_sdrc_get_params(sdrcrate, &sdrc_cs0, &sdrc_cs1);
-	if (ret)
-		return -EINVAL;
-
-	if (sdrcrate < MIN_SDRC_DLL_LOCK_FREQ) {
-		pr_debug("clock: will unlock SDRC DLL\n");
-		unlock_dll =3D 1;
-	}
-
-	/*
-	 * XXX This only needs to be done when the CPU frequency changes
-	 */
-	_mpurate =3D arm_fck_p->rate / CYCLES_PER_MHZ;
-	c =3D (_mpurate << SDRC_MPURATE_SCALE) >> SDRC_MPURATE_BASE_SHIFT;
-	c +=3D 1;  /* for safety */
-	c *=3D SDRC_MPURATE_LOOPS;
-	c >>=3D SDRC_MPURATE_SCALE;
-	if (c =3D=3D 0)
-		c =3D 1;
-
-	pr_debug("clock: changing CORE DPLL rate from %lu to %lu\n", clk->rat=
e,
-		 validrate);
-	pr_debug("clock: SDRC CS0 timing params used:"
-		 " RFR %08x CTRLA %08x CTRLB %08x MR %08x\n",
-		 sdrc_cs0->rfr_ctrl, sdrc_cs0->actim_ctrla,
-		 sdrc_cs0->actim_ctrlb, sdrc_cs0->mr);
-	if (sdrc_cs1)
-		pr_debug("clock: SDRC CS1 timing params used: "
-		 " RFR %08x CTRLA %08x CTRLB %08x MR %08x\n",
-		 sdrc_cs1->rfr_ctrl, sdrc_cs1->actim_ctrla,
-		 sdrc_cs1->actim_ctrlb, sdrc_cs1->mr);
-
-	if (sdrc_cs1)
-		omap3_configure_core_dpll(
-				  new_div, unlock_dll, c, rate > clk->rate,
-				  sdrc_cs0->rfr_ctrl, sdrc_cs0->actim_ctrla,
-				  sdrc_cs0->actim_ctrlb, sdrc_cs0->mr,
-				  sdrc_cs1->rfr_ctrl, sdrc_cs1->actim_ctrla,
-				  sdrc_cs1->actim_ctrlb, sdrc_cs1->mr);
-	else
-		omap3_configure_core_dpll(
-				  new_div, unlock_dll, c, rate > clk->rate,
-				  sdrc_cs0->rfr_ctrl, sdrc_cs0->actim_ctrla,
-				  sdrc_cs0->actim_ctrlb, sdrc_cs0->mr,
-				  0, 0, 0, 0);
-
-	return 0;
-}
-
 /* Common clock code */
=20
 /*


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
