From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v3] OMAP3 clock: split out DPLL3 M2 divider functions into
 mach-omap2/clkt34xx_dpll3m2.c
Date: Tue, 26 Jan 2010 17:19:57 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001261703450.13835@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1891167208-1264551597=:13835"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40055 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346Ab0A0AT6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 19:19:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: jouni.hogander@nokia.com, virtuoso@slind.org, ranjithl@ti.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1891167208-1264551597=:13835
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE


Hi,=20

just FYI, one minor tweak to this patch (updated version below). The file=
=20
"mach-omap2/clkt3xxx_dpll3m2.c" has been renamed to=20
"mach-omap2/clkt34xx_dpll3m2.c" to reflect the fact that it is not=20
available on AM35xx chips.


- Paul


From: Paul Walmsley <paul@pwsan.com>

Split the DPLL3 M2 divider clock functions out of clock34xx.c and move
them into mach-omap2/clkt34xx_dpll3m2.c. This is intended to make the
clock code easier to understand, since all of the functions needed to
manage the OMAP3 DPLL3 M2 divider are now located in their own file,
rather than being mixed with other, unrelated functions.

Clock debugging is also now more finely-grained, since the DEBUG macro
can now be defined for the DPLL3 M2 clock alone.  This should reduce
unnecessary console noise when debugging DVFS.

Also, if at some future point the mach-omap2/ directory is split
into OMAP2/3/4 variants, this clkt file can be placed in the mach-omap34xx/
directory, rather than shared with other chip types that don't use this
clock type.

This patch also lays the groundwork to skip compilation of this
code on OMAP3 chips that don't support DVFS (e.g., AM35xx) via
the Makefile, rather than via #ifdefs.

Thanks to Alexander Shishkin <virtuoso@slind.org> for his comments to
improve the patch description.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Jouni H=F6gander <jouni.hogander@nokia.com>
Cc: Alexander Shishkin <virtuoso@slind.org>
---
 arch/arm/mach-omap2/Makefile           |    3 +-
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c |  120 ++++++++++++++++++++++++++++=
++++
 arch/arm/mach-omap2/clock34xx.c        |   90 ------------------------
 3 files changed, 122 insertions(+), 91 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clkt34xx_dpll3m2.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 7ce5fea..b7b7d7e 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -15,11 +15,12 @@ clock-omap2xxx=09=09=09=09=3D clkt2xxx_dpllcore.o \
 =09=09=09=09=09  clkt2xxx_virt_prcm_set.o \
 =09=09=09=09=09  clkt2xxx_apll.o clkt2xxx_osc.o \
 =09=09=09=09=09  clkt2xxx_sys.o
+clock-omap34xx=09=09=09=09=3D clkt34xx_dpll3m2.o
=20
 obj-$(CONFIG_ARCH_OMAP2) +=3D $(omap-2-3-common) $(prcm-common) $(clock-co=
mmon) \
 =09=09=09    $(clock-omap2xxx)
 obj-$(CONFIG_ARCH_OMAP3) +=3D $(omap-2-3-common) $(prcm-common) $(clock-co=
mmon) \
-=09=09=09    $(omap-3-4-common)
+=09=09=09    $(omap-3-4-common) $(clock-omap34xx)
 obj-$(CONFIG_ARCH_OMAP4) +=3D $(omap-3-4-common) $(prcm-common) $(clock-co=
mmon)
=20
 obj-$(CONFIG_OMAP_MCBSP) +=3D mcbsp.o
diff --git a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c b/arch/arm/mach-omap2/c=
lkt34xx_dpll3m2.c
new file mode 100644
index 0000000..14f1a4b
--- /dev/null
+++ b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
@@ -0,0 +1,120 @@
+/*
+ * OMAP3 M2 divider clock code
+ *
+ * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * Copyright (C) 2007-2010 Nokia Corporation
+ *
+ * Paul Walmsley
+ * Jouni H=F6gander
+ *
+ * Parts of this code are based on code written by
+ * Richard Woodruff, Tony Lindgren, Tuukka Tikkanen, Karthik Dasu
+ *
+ * This program is free software; you can redistribute it and/or modify
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
+#define CYCLES_PER_MHZ=09=09=091000000
+
+/*
+ * CORE DPLL (DPLL3) M2 divider rate programming functions
+ *
+ * These call into SRAM code to do the actual CM writes, since the SDRAM
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
+=09u32 new_div =3D 0;
+=09u32 unlock_dll =3D 0;
+=09u32 c;
+=09unsigned long validrate, sdrcrate, _mpurate;
+=09struct omap_sdrc_params *sdrc_cs0;
+=09struct omap_sdrc_params *sdrc_cs1;
+=09int ret;
+
+=09if (!clk || !rate)
+=09=09return -EINVAL;
+
+=09validrate =3D omap2_clksel_round_rate_div(clk, rate, &new_div);
+=09if (validrate !=3D rate)
+=09=09return -EINVAL;
+
+=09sdrcrate =3D sdrc_ick_p->rate;
+=09if (rate > clk->rate)
+=09=09sdrcrate <<=3D ((rate / clk->rate) >> 1);
+=09else
+=09=09sdrcrate >>=3D ((clk->rate / rate) >> 1);
+
+=09ret =3D omap2_sdrc_get_params(sdrcrate, &sdrc_cs0, &sdrc_cs1);
+=09if (ret)
+=09=09return -EINVAL;
+
+=09if (sdrcrate < MIN_SDRC_DLL_LOCK_FREQ) {
+=09=09pr_debug("clock: will unlock SDRC DLL\n");
+=09=09unlock_dll =3D 1;
+=09}
+
+=09/*
+=09 * XXX This only needs to be done when the CPU frequency changes
+=09 */
+=09_mpurate =3D arm_fck_p->rate / CYCLES_PER_MHZ;
+=09c =3D (_mpurate << SDRC_MPURATE_SCALE) >> SDRC_MPURATE_BASE_SHIFT;
+=09c +=3D 1;  /* for safety */
+=09c *=3D SDRC_MPURATE_LOOPS;
+=09c >>=3D SDRC_MPURATE_SCALE;
+=09if (c =3D=3D 0)
+=09=09c =3D 1;
+
+=09pr_debug("clock: changing CORE DPLL rate from %lu to %lu\n", clk->rate,
+=09=09 validrate);
+=09pr_debug("clock: SDRC CS0 timing params used:"
+=09=09 " RFR %08x CTRLA %08x CTRLB %08x MR %08x\n",
+=09=09 sdrc_cs0->rfr_ctrl, sdrc_cs0->actim_ctrla,
+=09=09 sdrc_cs0->actim_ctrlb, sdrc_cs0->mr);
+=09if (sdrc_cs1)
+=09=09pr_debug("clock: SDRC CS1 timing params used: "
+=09=09 " RFR %08x CTRLA %08x CTRLB %08x MR %08x\n",
+=09=09 sdrc_cs1->rfr_ctrl, sdrc_cs1->actim_ctrla,
+=09=09 sdrc_cs1->actim_ctrlb, sdrc_cs1->mr);
+
+=09if (sdrc_cs1)
+=09=09omap3_configure_core_dpll(
+=09=09=09=09  new_div, unlock_dll, c, rate > clk->rate,
+=09=09=09=09  sdrc_cs0->rfr_ctrl, sdrc_cs0->actim_ctrla,
+=09=09=09=09  sdrc_cs0->actim_ctrlb, sdrc_cs0->mr,
+=09=09=09=09  sdrc_cs1->rfr_ctrl, sdrc_cs1->actim_ctrla,
+=09=09=09=09  sdrc_cs1->actim_ctrlb, sdrc_cs1->mr);
+=09else
+=09=09omap3_configure_core_dpll(
+=09=09=09=09  new_div, unlock_dll, c, rate > clk->rate,
+=09=09=09=09  sdrc_cs0->rfr_ctrl, sdrc_cs0->actim_ctrla,
+=09=09=09=09  sdrc_cs0->actim_ctrlb, sdrc_cs0->mr,
+=09=09=09=09  0, 0, 0, 0);
+
+=09return 0;
+}
+
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34x=
x.c
index 4c4bb3c..552ad30 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -42,8 +42,6 @@
 #include "cm.h"
 #include "cm-regbits-34xx.h"
=20
-#define CYCLES_PER_MHZ=09=09=091000000
-
 /*
  * DPLL5_FREQ_FOR_USBHOST: USBHOST and USBTLL are the only clocks
  * that are sourced by DPLL5, and both of these require this clock
@@ -162,94 +160,6 @@ int omap3_dpll4_set_rate(struct clk *clk, unsigned lon=
g rate)
 =09return omap3_noncore_dpll_set_rate(clk, rate);
 }
=20
-
-/*
- * CORE DPLL (DPLL3) rate programming functions
- *
- * These call into SRAM code to do the actual CM writes, since the SDRAM
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
-=09u32 new_div =3D 0;
-=09u32 unlock_dll =3D 0;
-=09u32 c;
-=09unsigned long validrate, sdrcrate, _mpurate;
-=09struct omap_sdrc_params *sdrc_cs0;
-=09struct omap_sdrc_params *sdrc_cs1;
-=09int ret;
-
-=09if (!clk || !rate)
-=09=09return -EINVAL;
-
-=09validrate =3D omap2_clksel_round_rate_div(clk, rate, &new_div);
-=09if (validrate !=3D rate)
-=09=09return -EINVAL;
-
-=09sdrcrate =3D sdrc_ick_p->rate;
-=09if (rate > clk->rate)
-=09=09sdrcrate <<=3D ((rate / clk->rate) >> 1);
-=09else
-=09=09sdrcrate >>=3D ((clk->rate / rate) >> 1);
-
-=09ret =3D omap2_sdrc_get_params(sdrcrate, &sdrc_cs0, &sdrc_cs1);
-=09if (ret)
-=09=09return -EINVAL;
-
-=09if (sdrcrate < MIN_SDRC_DLL_LOCK_FREQ) {
-=09=09pr_debug("clock: will unlock SDRC DLL\n");
-=09=09unlock_dll =3D 1;
-=09}
-
-=09/*
-=09 * XXX This only needs to be done when the CPU frequency changes
-=09 */
-=09_mpurate =3D arm_fck_p->rate / CYCLES_PER_MHZ;
-=09c =3D (_mpurate << SDRC_MPURATE_SCALE) >> SDRC_MPURATE_BASE_SHIFT;
-=09c +=3D 1;  /* for safety */
-=09c *=3D SDRC_MPURATE_LOOPS;
-=09c >>=3D SDRC_MPURATE_SCALE;
-=09if (c =3D=3D 0)
-=09=09c =3D 1;
-
-=09pr_debug("clock: changing CORE DPLL rate from %lu to %lu\n", clk->rate,
-=09=09 validrate);
-=09pr_debug("clock: SDRC CS0 timing params used:"
-=09=09 " RFR %08x CTRLA %08x CTRLB %08x MR %08x\n",
-=09=09 sdrc_cs0->rfr_ctrl, sdrc_cs0->actim_ctrla,
-=09=09 sdrc_cs0->actim_ctrlb, sdrc_cs0->mr);
-=09if (sdrc_cs1)
-=09=09pr_debug("clock: SDRC CS1 timing params used: "
-=09=09 " RFR %08x CTRLA %08x CTRLB %08x MR %08x\n",
-=09=09 sdrc_cs1->rfr_ctrl, sdrc_cs1->actim_ctrla,
-=09=09 sdrc_cs1->actim_ctrlb, sdrc_cs1->mr);
-
-=09if (sdrc_cs1)
-=09=09omap3_configure_core_dpll(
-=09=09=09=09  new_div, unlock_dll, c, rate > clk->rate,
-=09=09=09=09  sdrc_cs0->rfr_ctrl, sdrc_cs0->actim_ctrla,
-=09=09=09=09  sdrc_cs0->actim_ctrlb, sdrc_cs0->mr,
-=09=09=09=09  sdrc_cs1->rfr_ctrl, sdrc_cs1->actim_ctrla,
-=09=09=09=09  sdrc_cs1->actim_ctrlb, sdrc_cs1->mr);
-=09else
-=09=09omap3_configure_core_dpll(
-=09=09=09=09  new_div, unlock_dll, c, rate > clk->rate,
-=09=09=09=09  sdrc_cs0->rfr_ctrl, sdrc_cs0->actim_ctrla,
-=09=09=09=09  sdrc_cs0->actim_ctrlb, sdrc_cs0->mr,
-=09=09=09=09  0, 0, 0, 0);
-
-=09return 0;
-}
-
 /* Common clock code */
=20
 /*
--=20
1.6.6.rc2.5.g49666

--155748971-1891167208-1264551597=:13835--
