From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 08/13] OMAP3/4 clock: split into per-chip family files
Date: Mon, 15 Feb 2010 17:58:21 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002151755530.28188@utopia.booyaka.com>
References: <20100211181236.795.56094.stgit@localhost.localdomain> <20100211181706.795.84644.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1274776450-1266281901=:28188"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55711 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932299Ab0BPA6W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Feb 2010 19:58:22 -0500
In-Reply-To: <20100211181706.795.84644.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rajendra Nayak <rnayak@ti.com>, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Ranjith Lohithakshan <ranjithl@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1274776450-1266281901=:28188
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE


clock34xx_data.c now contains data for the OMAP34xx family, the
OMAP36xx family, and the OMAP3517 family, so rename it to
clock3xxx_data.c.  Rename clock34xx.c to clock3xxx.c, and move the
chip family-specific clock functions to clock34xx.c, clock36xx.c, or
clock3517.c, as appropriate.  So now "clock3xxx.*" refers to the OMAP3
superset.

The main goal here is to prepare to compile chip family-specific clock
functions only for kernel builds that target that chip family.  To get to
that point, we also need to add CONFIG_ARCH_* options for those other
chip families; that will be done in a future patch, planned for 2.6.35.

OMAP4 is also affected by this.  It duplicated the OMAP3 non-CORE DPLL
clkops structure.  The OMAP4 variant of this clkops structure has been
removed, and since there was nothing else currently in clock44xx.c, it
too has been removed -- it can always be added back later when there
is some content for it.  (The OMAP4 clock autogeneration scripts have been
updated accordingly.)

This second version of the patch fixes some minor errors where the AM35xx=
=20
files were renamed, but the #includes weren't.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=EEt Cousson <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Ranjith Lohithakshan <ranjithl@ti.com>
---
 arch/arm/mach-omap2/Makefile                       |   36 ++--
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c             |    1 +
 arch/arm/mach-omap2/clock.c                        |   12 +
 arch/arm/mach-omap2/clock.h                        |    2 +
 arch/arm/mach-omap2/clock34xx.c                    |  260 +---------------=
----
 arch/arm/mach-omap2/clock34xx.h                    |   27 +--
 arch/arm/mach-omap2/clock3517.c                    |  124 ++++++++++
 arch/arm/mach-omap2/clock3517.h                    |   14 +
 arch/arm/mach-omap2/clock36xx.c                    |   72 ++++++
 arch/arm/mach-omap2/clock36xx.h                    |   13 +
 arch/arm/mach-omap2/clock3xxx.c                    |  145 +++++++++++
 arch/arm/mach-omap2/clock3xxx.h                    |   21 ++
 .../{clock34xx_data.c =3D> clock3xxx_data.c}         |   16 +-
 arch/arm/mach-omap2/clock44xx.c                    |   19 --
 arch/arm/mach-omap2/clock44xx.h                    |    6 +-
 arch/arm/mach-omap2/clock44xx_data.c               |   12 +-
 arch/arm/mach-omap2/io.c                           |    2 +-
 17 files changed, 450 insertions(+), 332 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clock3517.c
 create mode 100644 arch/arm/mach-omap2/clock3517.h
 create mode 100644 arch/arm/mach-omap2/clock36xx.c
 create mode 100644 arch/arm/mach-omap2/clock36xx.h
 create mode 100644 arch/arm/mach-omap2/clock3xxx.c
 create mode 100644 arch/arm/mach-omap2/clock3xxx.h
 rename arch/arm/mach-omap2/{clock34xx_data.c =3D> clock3xxx_data.c} (99%)
 delete mode 100644 arch/arm/mach-omap2/clock44xx.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 10e6c6e..03058ad 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -7,22 +7,14 @@ obj-y :=3D id.o io.o control.o mux.o devices.o serial.o g=
pmc.o timer-gp.o
=20
 omap-2-3-common=09=09=09=09=3D irq.o sdrc.o omap_hwmod.o \
 =09=09=09=09=09  omap_hwmod_common_data.o
-omap-3-4-common=09=09=09=09=3D dpll3xxx.o
 prcm-common=09=09=09=09=3D prcm.o powerdomain.o
 clock-common=09=09=09=09=3D clock.o clock_common_data.o \
 =09=09=09=09=09  clockdomain.o clkt_dpll.o \
 =09=09=09=09=09  clkt_clksel.o
-clock-omap2xxx=09=09=09=09=3D clkt2xxx_dpllcore.o \
-=09=09=09=09=09  clkt2xxx_virt_prcm_set.o \
-=09=09=09=09=09  clkt2xxx_apll.o clkt2xxx_osc.o \
-=09=09=09=09=09  clkt2xxx_sys.o
-clock-omap3xxx=09=09=09=09=3D clkt34xx_dpll3m2.o
-
-obj-$(CONFIG_ARCH_OMAP2) +=3D $(omap-2-3-common) $(prcm-common) $(clock-co=
mmon) \
-=09=09=09    $(clock-omap2xxx)
-obj-$(CONFIG_ARCH_OMAP3) +=3D $(omap-2-3-common) $(prcm-common) $(clock-co=
mmon) \
-=09=09=09    $(omap-3-4-common) $(clock-omap3xxx)
-obj-$(CONFIG_ARCH_OMAP4) +=3D $(omap-3-4-common) $(prcm-common) $(clock-co=
mmon)
+
+obj-$(CONFIG_ARCH_OMAP2) +=3D $(omap-2-3-common) $(prcm-common)
+obj-$(CONFIG_ARCH_OMAP3) +=3D $(omap-2-3-common) $(prcm-common)
+obj-$(CONFIG_ARCH_OMAP4) +=3D $(omap-3-4-common) $(prcm-common)
=20
 obj-$(CONFIG_OMAP_MCBSP) +=3D mcbsp.o
=20
@@ -56,14 +48,24 @@ obj-$(CONFIG_ARCH_OMAP3)=09=09+=3D cm.o
 obj-$(CONFIG_ARCH_OMAP4)=09=09+=3D cm4xxx.o
=20
 # Clock framework
-obj-$(CONFIG_ARCH_OMAP2)=09=09+=3D clock2xxx.o clock2xxx_data.o
+obj-$(CONFIG_ARCH_OMAP2)=09=09+=3D $(clock-common) clock2xxx.o \
+=09=09=09=09=09   clock2xxx_data.o clkt2xxx_sys.o \
+=09=09=09=09=09   clkt2xxx_dpllcore.o \
+=09=09=09=09=09   clkt2xxx_virt_prcm_set.o \
+=09=09=09=09=09   clkt2xxx_apll.o clkt2xxx_osc.o
+obj-$(CONFIG_ARCH_OMAP3)=09=09+=3D $(clock-common) clock3xxx.o \
+=09=09=09=09=09   clock34xx.o clkt34xx_dpll3m2.o \
+=09=09=09=09=09   clock3517.o clock36xx.o \
+=09=09=09=09=09   dpll3xxx.o clock3xxx_data.o
+obj-$(CONFIG_ARCH_OMAP4)=09=09+=3D $(clock-common) clock44xx_data.o \
+=09=09=09=09=09   dpll3xxx.o
+
+# OMAP2 clock rate set data (old "OPP" data)
 obj-$(CONFIG_ARCH_OMAP2420)=09=09+=3D opp2420_data.o
-obj-$(CONFIG_ARCH_OMAP3)=09=09+=3D clock34xx.o clock34xx_data.o
 obj-$(CONFIG_ARCH_OMAP2430)=09=09+=3D opp2430_data.o
-obj-$(CONFIG_ARCH_OMAP4)=09=09+=3D clock44xx.o clock44xx_data.o
=20
 # EMU peripherals
-obj-$(CONFIG_OMAP3_EMU)=09=09+=3D emu.o
+obj-$(CONFIG_OMAP3_EMU)=09=09=09+=3D emu.o
=20
 obj-$(CONFIG_OMAP_MBOX_FWK)=09=09+=3D mailbox_mach.o
 mailbox_mach-objs=09=09=09:=3D mailbox.o
@@ -118,7 +120,7 @@ obj-$(CONFIG_MACH_OMAP3_TOUCHBOOK)=09+=3D board-omap3to=
uchbook.o \
 =09=09=09=09=09   mmc-twl4030.o
 obj-$(CONFIG_MACH_OMAP_4430SDP)=09=09+=3D board-4430sdp.o
=20
-obj-$(CONFIG_MACH_OMAP3517EVM)     +=3D board-am3517evm.o
+obj-$(CONFIG_MACH_OMAP3517EVM)=09=09+=3D board-am3517evm.o
=20
 # Platform specific device init code
 obj-y=09=09=09=09=09+=3D usb-musb.o
diff --git a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c b/arch/arm/mach-omap2/c=
lkt34xx_dpll3m2.c
index 8716a01..b2b1e37 100644
--- a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
+++ b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
@@ -26,6 +26,7 @@
 #include <plat/sdrc.h>
=20
 #include "clock.h"
+#include "clock3xxx.h"
 #include "clock34xx.h"
 #include "sdrc.h"
=20
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 9df5937..82b17ef 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -336,6 +336,18 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *=
new_parent)
 =09return omap2_clksel_set_parent(clk, new_parent);
 }
=20
+/* OMAP3/4 non-CORE DPLL clkops */
+
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
+
+const struct clkops clkops_omap3_noncore_dpll_ops =3D {
+=09.enable=09=09=3D omap3_noncore_dpll_enable,
+=09.disable=09=3D omap3_noncore_dpll_disable,
+};
+
+#endif
+
+
 /*------------------------------------------------------------------------=
-
  * Omap2 clock reset and init functions
  *------------------------------------------------------------------------=
-*/
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index f7e7100..8b724bb 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -115,4 +115,6 @@ extern void omap2_clk_exit_cpufreq_table(struct cpufreq=
_frequency_table **table)
 #define omap2_clk_exit_cpufreq_table=090
 #endif
=20
+extern const struct clkops clkops_omap3_noncore_dpll_ops;
+
 #endif
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34x=
x.c
index c8b4e56..6febd5f 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -8,7 +8,8 @@
  * Jouni H=F6gander
  *
  * Parts of this code are based on code written by
- * Richard Woodruff, Tony Lindgren, Tuukka Tikkanen, Karthik Dasu
+ * Richard Woodruff, Tony Lindgren, Tuukka Tikkanen, Karthik Dasu,
+ * Russell King
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -17,42 +18,16 @@
 #undef DEBUG
=20
 #include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/io.h>
-#include <linux/err.h>
=20
-#include <plat/cpu.h>
 #include <plat/clock.h>
=20
 #include "clock.h"
 #include "clock34xx.h"
-#include "prm.h"
-#include "prm-regbits-34xx.h"
 #include "cm.h"
 #include "cm-regbits-34xx.h"
=20
-/*
- * DPLL5_FREQ_FOR_USBHOST: USBHOST and USBTLL are the only clocks
- * that are sourced by DPLL5, and both of these require this clock
- * to be at 120 MHz for proper operation.
- */
-#define DPLL5_FREQ_FOR_USBHOST=09=09120000000
-
-/*
- * In AM35xx IPSS, the {ICK,FCK} enable bits for modules are exported
- * in the same register at a bit offset of 0x8. The EN_ACK for ICK is
- * at an offset of 4 from ICK enable bit.
- */
-#define AM35XX_IPSS_ICK_MASK=09=09=090xF
-#define AM35XX_IPSS_ICK_EN_ACK_OFFSET =090x4
-#define AM35XX_IPSS_ICK_FCK_OFFSET=09=090x8
-#define AM35XX_IPSS_CLK_IDLEST_VAL=09=090
-
-/* needed by omap3_core_dpll_m2_set_rate() */
-struct clk *sdrc_ick_p, *arm_fck_p;
-
 /**
  * omap3430es2_clk_ssi_find_idlest - return CM_IDLEST info for SSI
  * @clk: struct clk * being enabled
@@ -149,234 +124,3 @@ const struct clkops clkops_omap3430es2_hsotgusb_wait =
=3D {
 =09.find_idlest=09=3D omap3430es2_clk_hsotgusb_find_idlest,
 =09.find_companion =3D omap2_clk_dflt_find_companion,
 };
-
-/**
- * omap36xx_pwrdn_clk_enable_with_hsdiv_restore - enable clocks suffering
- *         from HSDivider PWRDN problem Implements Errata ID: i556.
- * @clk: DPLL output struct clk
- *
- * 3630 only: dpll3_m3_ck, dpll4_m2_ck, dpll4_m3_ck, dpll4_m4_ck,
- * dpll4_m5_ck & dpll4_m6_ck dividers gets loaded with reset
- * valueafter their respective PWRDN bits are set.  Any dummy write
- * (Any other value different from the Read value) to the
- * corresponding CM_CLKSEL register will refresh the dividers.
- */
-static int omap36xx_pwrdn_clk_enable_with_hsdiv_restore(struct clk *clk)
-{
-=09u32 dummy_v, orig_v, clksel_shift;
-=09int ret;
-
-=09/* Clear PWRDN bit of HSDIVIDER */
-=09ret =3D omap2_dflt_clk_enable(clk);
-
-=09/* Restore the dividers */
-=09if (!ret) {
-=09=09clksel_shift =3D __ffs(clk->parent->clksel_mask);
-=09=09orig_v =3D __raw_readl(clk->parent->clksel_reg);
-=09=09dummy_v =3D orig_v;
-
-=09=09/* Write any other value different from the Read value */
-=09=09dummy_v ^=3D (1 << clksel_shift);
-=09=09__raw_writel(dummy_v, clk->parent->clksel_reg);
-
-=09=09/* Write the original divider */
-=09=09__raw_writel(orig_v, clk->parent->clksel_reg);
-=09}
-
-=09return ret;
-}
-
-const struct clkops clkops_omap36xx_pwrdn_with_hsdiv_wait_restore =3D {
-=09.enable=09=09=3D omap36xx_pwrdn_clk_enable_with_hsdiv_restore,
-=09.disable=09=3D omap2_dflt_clk_disable,
-=09.find_companion=09=3D omap2_clk_dflt_find_companion,
-=09.find_idlest=09=3D omap2_clk_dflt_find_idlest,
-};
-
-const struct clkops clkops_noncore_dpll_ops =3D {
-=09.enable=09=09=3D omap3_noncore_dpll_enable,
-=09.disable=09=3D omap3_noncore_dpll_disable,
-};
-
-/**
- * am35xx_clk_find_idlest - return clock ACK info for AM35XX IPSS
- * @clk: struct clk * being enabled
- * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
- * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift into
- * @idlest_val: pointer to a u8 to store the CM_IDLEST indicator
- *
- * The interface clocks on AM35xx IPSS reflects the clock idle status
- * in the enable register itsel at a bit offset of 4 from the enable
- * bit. A value of 1 indicates that clock is enabled.
- */
-static void am35xx_clk_find_idlest(struct clk *clk,
-=09=09=09=09=09    void __iomem **idlest_reg,
-=09=09=09=09=09    u8 *idlest_bit,
-=09=09=09=09=09    u8 *idlest_val)
-{
-=09*idlest_reg =3D (__force void __iomem *)(clk->enable_reg);
-=09*idlest_bit =3D clk->enable_bit + AM35XX_IPSS_ICK_EN_ACK_OFFSET;
-=09*idlest_val =3D AM35XX_IPSS_CLK_IDLEST_VAL;
-}
-
-/**
- * am35xx_clk_find_companion - find companion clock to @clk
- * @clk: struct clk * to find the companion clock of
- * @other_reg: void __iomem ** to return the companion clock CM_*CLKEN va =
in
- * @other_bit: u8 ** to return the companion clock bit shift in
- *
- * Some clocks don't have companion clocks.  For example, modules with
- * only an interface clock (such as HECC) don't have a companion
- * clock.  Right now, this code relies on the hardware exporting a bit
- * in the correct companion register that indicates that the
- * nonexistent 'companion clock' is active.  Future patches will
- * associate this type of code with per-module data structures to
- * avoid this issue, and remove the casts.  No return value.
- */
-static void am35xx_clk_find_companion(struct clk *clk, void __iomem **othe=
r_reg,
-=09=09=09=09=09    u8 *other_bit)
-{
-=09*other_reg =3D (__force void __iomem *)(clk->enable_reg);
-=09if (clk->enable_bit & AM35XX_IPSS_ICK_MASK)
-=09=09*other_bit =3D clk->enable_bit + AM35XX_IPSS_ICK_FCK_OFFSET;
-=09else
-=09=09*other_bit =3D clk->enable_bit - AM35XX_IPSS_ICK_FCK_OFFSET;
-}
-
-const struct clkops clkops_am35xx_ipss_module_wait =3D {
-=09.enable=09=09=3D omap2_dflt_clk_enable,
-=09.disable=09=3D omap2_dflt_clk_disable,
-=09.find_idlest=09=3D am35xx_clk_find_idlest,
-=09.find_companion=09=3D am35xx_clk_find_companion,
-};
-
-/**
- * am35xx_clk_ipss_find_idlest - return CM_IDLEST info for IPSS
- * @clk: struct clk * being enabled
- * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
- * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift into
- * @idlest_val: pointer to a u8 to store the CM_IDLEST indicator
- *
- * The IPSS target CM_IDLEST bit is at a different shift from the
- * CM_{I,F}CLKEN bit.  Pass back the correct info via @idlest_reg
- * and @idlest_bit.  No return value.
- */
-static void am35xx_clk_ipss_find_idlest(struct clk *clk,
-=09=09=09=09=09    void __iomem **idlest_reg,
-=09=09=09=09=09    u8 *idlest_bit,
-=09=09=09=09=09    u8 *idlest_val)
-{
-=09u32 r;
-
-=09r =3D (((__force u32)clk->enable_reg & ~0xf0) | 0x20);
-=09*idlest_reg =3D (__force void __iomem *)r;
-=09*idlest_bit =3D AM35XX_ST_IPSS_SHIFT;
-=09*idlest_val =3D OMAP34XX_CM_IDLEST_VAL;
-}
-
-const struct clkops clkops_am35xx_ipss_wait =3D {
-=09.enable=09=09=3D omap2_dflt_clk_enable,
-=09.disable=09=3D omap2_dflt_clk_disable,
-=09.find_idlest=09=3D am35xx_clk_ipss_find_idlest,
-=09.find_companion=09=3D omap2_clk_dflt_find_companion,
-};
-
-int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate)
-{
-=09/*
-=09 * According to the 12-5 CDP code from TI, "Limitation 2.5"
-=09 * on 3430ES1 prevents us from changing DPLL multipliers or dividers
-=09 * on DPLL4.
-=09 */
-=09if (omap_rev() =3D=3D OMAP3430_REV_ES1_0) {
-=09=09printk(KERN_ERR "clock: DPLL4 cannot change rate due to "
-=09=09       "silicon 'Limitation 2.5' on 3430ES1.\n");
-=09=09return -EINVAL;
-=09}
-=09return omap3_noncore_dpll_set_rate(clk, rate);
-}
-
-void __init omap3_clk_lock_dpll5(void)
-{
-=09struct clk *dpll5_clk;
-=09struct clk *dpll5_m2_clk;
-
-=09dpll5_clk =3D clk_get(NULL, "dpll5_ck");
-=09clk_set_rate(dpll5_clk, DPLL5_FREQ_FOR_USBHOST);
-=09clk_enable(dpll5_clk);
-
-=09/* Enable autoidle to allow it to enter low power bypass */
-=09omap3_dpll_allow_idle(dpll5_clk);
-
-=09/* Program dpll5_m2_clk divider for no division */
-=09dpll5_m2_clk =3D clk_get(NULL, "dpll5_m2_ck");
-=09clk_enable(dpll5_m2_clk);
-=09clk_set_rate(dpll5_m2_clk, DPLL5_FREQ_FOR_USBHOST);
-
-=09clk_disable(dpll5_m2_clk);
-=09clk_disable(dpll5_clk);
-=09return;
-}
-
-/* Common clock code */
-
-/* REVISIT: Move this init stuff out into clock.c */
-
-/*
- * Switch the MPU rate if specified on cmdline.
- * We cannot do this early until cmdline is parsed.
- */
-static int __init omap3xxx_clk_arch_init(void)
-{
-=09struct clk *osc_sys_ck, *dpll1_ck, *arm_fck, *core_ck;
-=09unsigned long osc_sys_rate;
-=09bool err =3D 0;
-
-=09if (!cpu_is_omap34xx())
-=09=09return 0;
-
-=09if (!mpurate)
-=09=09return -EINVAL;
-
-=09/* XXX test these for success */
-=09dpll1_ck =3D clk_get(NULL, "dpll1_ck");
-=09if (WARN(IS_ERR(dpll1_ck), "Failed to get dpll1_ck.\n"))
-=09=09err =3D 1;
-
-=09arm_fck =3D clk_get(NULL, "arm_fck");
-=09if (WARN(IS_ERR(arm_fck), "Failed to get arm_fck.\n"))
-=09=09err =3D 1;
-
-=09core_ck =3D clk_get(NULL, "core_ck");
-=09if (WARN(IS_ERR(core_ck), "Failed to get core_ck.\n"))
-=09=09err =3D 1;
-
-=09osc_sys_ck =3D clk_get(NULL, "osc_sys_ck");
-=09if (WARN(IS_ERR(osc_sys_ck), "Failed to get osc_sys_ck.\n"))
-=09=09err =3D 1;
-
-=09if (err)
-=09=09return -ENOENT;
-
-=09/* REVISIT: not yet ready for 343x */
-=09if (clk_set_rate(dpll1_ck, mpurate))
-=09=09printk(KERN_ERR "*** Unable to set MPU rate\n");
-
-=09recalculate_root_clocks();
-
-=09osc_sys_rate =3D clk_get_rate(osc_sys_ck);
-
-=09pr_info("Switched to new clocking rate (Crystal/Core/MPU): "
-=09=09"%ld.%01ld/%ld/%ld MHz\n",
-=09=09(osc_sys_rate / 1000000),
-=09=09((osc_sys_rate / 100000) % 10),
-=09=09(clk_get_rate(core_ck) / 1000000),
-=09=09(clk_get_rate(arm_fck) / 1000000));
-
-=09calibrate_delay();
-
-=09return 0;
-}
-arch_initcall(omap3xxx_clk_arch_init);
-
-
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34x=
x.h
index b9c65f5..628e8de 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -1,32 +1,15 @@
 /*
- * OMAP3 clock function prototypes and macros
+ * OMAP34xx clock function prototypes and macros
  *
- * Copyright (C) 2007-2009 Texas Instruments, Inc.
- * Copyright (C) 2007-2009 Nokia Corporation
+ * Copyright (C) 2007-2010 Texas Instruments, Inc.
+ * Copyright (C) 2007-2010 Nokia Corporation
  */
=20
-#ifndef __ARCH_ARM_MACH_OMAP2_CLOCK_34XX_H
-#define __ARCH_ARM_MACH_OMAP2_CLOCK_34XX_H
+#ifndef __ARCH_ARM_MACH_OMAP2_CLOCK34XX_H
+#define __ARCH_ARM_MACH_OMAP2_CLOCK34XX_H
=20
-int omap3xxx_clk_init(void);
-int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate);
-int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate);
-void omap3_clk_lock_dpll5(void);
-
-extern struct clk *sdrc_ick_p;
-extern struct clk *arm_fck_p;
-
-/* OMAP34xx-specific clkops */
 extern const struct clkops clkops_omap3430es2_ssi_wait;
 extern const struct clkops clkops_omap3430es2_hsotgusb_wait;
 extern const struct clkops clkops_omap3430es2_dss_usbhost_wait;
-extern const struct clkops clkops_noncore_dpll_ops;
-
-/* AM35xx-specific clkops */
-extern const struct clkops clkops_am35xx_ipss_module_wait;
-extern const struct clkops clkops_am35xx_ipss_wait;
-
-/* OMAP36xx-specific clkops */
-extern const struct clkops clkops_omap36xx_pwrdn_with_hsdiv_wait_restore;
=20
 #endif
diff --git a/arch/arm/mach-omap2/clock3517.c b/arch/arm/mach-omap2/clock351=
7.c
new file mode 100644
index 0000000..b496a93
--- /dev/null
+++ b/arch/arm/mach-omap2/clock3517.c
@@ -0,0 +1,124 @@
+/*
+ * OMAP3517/3505-specific clock framework functions
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Copyright (C) 2010 Nokia Corporation
+ *
+ * Ranjith Lohithakshan
+ * Paul Walmsley
+ *
+ * Parts of this code are based on code written by
+ * Richard Woodruff, Tony Lindgren, Tuukka Tikkanen, Karthik Dasu,
+ * Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <plat/clock.h>
+
+#include "clock.h"
+#include "clock3517.h"
+#include "cm.h"
+#include "cm-regbits-34xx.h"
+
+/*
+ * In AM35xx IPSS, the {ICK,FCK} enable bits for modules are exported
+ * in the same register at a bit offset of 0x8. The EN_ACK for ICK is
+ * at an offset of 4 from ICK enable bit.
+ */
+#define AM35XX_IPSS_ICK_MASK=09=09=090xF
+#define AM35XX_IPSS_ICK_EN_ACK_OFFSET =09=090x4
+#define AM35XX_IPSS_ICK_FCK_OFFSET=09=090x8
+#define AM35XX_IPSS_CLK_IDLEST_VAL=09=090
+
+/**
+ * am35xx_clk_find_idlest - return clock ACK info for AM35XX IPSS
+ * @clk: struct clk * being enabled
+ * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
+ * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift into
+ * @idlest_val: pointer to a u8 to store the CM_IDLEST indicator
+ *
+ * The interface clocks on AM35xx IPSS reflects the clock idle status
+ * in the enable register itsel at a bit offset of 4 from the enable
+ * bit. A value of 1 indicates that clock is enabled.
+ */
+static void am35xx_clk_find_idlest(struct clk *clk,
+=09=09=09=09=09    void __iomem **idlest_reg,
+=09=09=09=09=09    u8 *idlest_bit,
+=09=09=09=09=09    u8 *idlest_val)
+{
+=09*idlest_reg =3D (__force void __iomem *)(clk->enable_reg);
+=09*idlest_bit =3D clk->enable_bit + AM35XX_IPSS_ICK_EN_ACK_OFFSET;
+=09*idlest_val =3D AM35XX_IPSS_CLK_IDLEST_VAL;
+}
+
+/**
+ * am35xx_clk_find_companion - find companion clock to @clk
+ * @clk: struct clk * to find the companion clock of
+ * @other_reg: void __iomem ** to return the companion clock CM_*CLKEN va =
in
+ * @other_bit: u8 ** to return the companion clock bit shift in
+ *
+ * Some clocks don't have companion clocks.  For example, modules with
+ * only an interface clock (such as HECC) don't have a companion
+ * clock.  Right now, this code relies on the hardware exporting a bit
+ * in the correct companion register that indicates that the
+ * nonexistent 'companion clock' is active.  Future patches will
+ * associate this type of code with per-module data structures to
+ * avoid this issue, and remove the casts.  No return value.
+ */
+static void am35xx_clk_find_companion(struct clk *clk, void __iomem **othe=
r_reg,
+=09=09=09=09=09    u8 *other_bit)
+{
+=09*other_reg =3D (__force void __iomem *)(clk->enable_reg);
+=09if (clk->enable_bit & AM35XX_IPSS_ICK_MASK)
+=09=09*other_bit =3D clk->enable_bit + AM35XX_IPSS_ICK_FCK_OFFSET;
+=09else
+=09=09*other_bit =3D clk->enable_bit - AM35XX_IPSS_ICK_FCK_OFFSET;
+}
+
+const struct clkops clkops_am35xx_ipss_module_wait =3D {
+=09.enable=09=09=3D omap2_dflt_clk_enable,
+=09.disable=09=3D omap2_dflt_clk_disable,
+=09.find_idlest=09=3D am35xx_clk_find_idlest,
+=09.find_companion=09=3D am35xx_clk_find_companion,
+};
+
+/**
+ * am35xx_clk_ipss_find_idlest - return CM_IDLEST info for IPSS
+ * @clk: struct clk * being enabled
+ * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
+ * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift into
+ * @idlest_val: pointer to a u8 to store the CM_IDLEST indicator
+ *
+ * The IPSS target CM_IDLEST bit is at a different shift from the
+ * CM_{I,F}CLKEN bit.  Pass back the correct info via @idlest_reg
+ * and @idlest_bit.  No return value.
+ */
+static void am35xx_clk_ipss_find_idlest(struct clk *clk,
+=09=09=09=09=09    void __iomem **idlest_reg,
+=09=09=09=09=09    u8 *idlest_bit,
+=09=09=09=09=09    u8 *idlest_val)
+{
+=09u32 r;
+
+=09r =3D (((__force u32)clk->enable_reg & ~0xf0) | 0x20);
+=09*idlest_reg =3D (__force void __iomem *)r;
+=09*idlest_bit =3D AM35XX_ST_IPSS_SHIFT;
+=09*idlest_val =3D OMAP34XX_CM_IDLEST_VAL;
+}
+
+const struct clkops clkops_am35xx_ipss_wait =3D {
+=09.enable=09=09=3D omap2_dflt_clk_enable,
+=09.disable=09=3D omap2_dflt_clk_disable,
+=09.find_idlest=09=3D am35xx_clk_ipss_find_idlest,
+=09.find_companion=09=3D omap2_clk_dflt_find_companion,
+};
+
+
diff --git a/arch/arm/mach-omap2/clock3517.h b/arch/arm/mach-omap2/clock351=
7.h
new file mode 100644
index 0000000..ca5e5a6
--- /dev/null
+++ b/arch/arm/mach-omap2/clock3517.h
@@ -0,0 +1,14 @@
+/*
+ * OMAP3517/3505 clock function prototypes and macros
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Copyright (C) 2010 Nokia Corporation
+ */
+
+#ifndef __ARCH_ARM_MACH_OMAP2_CLOCK3517_H
+#define __ARCH_ARM_MACH_OMAP2_CLOCK3517_H
+
+extern const struct clkops clkops_am35xx_ipss_module_wait;
+extern const struct clkops clkops_am35xx_ipss_wait;
+
+#endif
diff --git a/arch/arm/mach-omap2/clock36xx.c b/arch/arm/mach-omap2/clock36x=
x.c
new file mode 100644
index 0000000..0c5e25e
--- /dev/null
+++ b/arch/arm/mach-omap2/clock36xx.c
@@ -0,0 +1,72 @@
+/*
+ * OMAP36xx-specific clkops
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Copyright (C) 2010 Nokia Corporation
+ *
+ * Mike Turquette
+ * Vijaykumar GN
+ * Paul Walmsley
+ *
+ * Parts of this code are based on code written by
+ * Richard Woodruff, Tony Lindgren, Tuukka Tikkanen, Karthik Dasu,
+ * Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <plat/clock.h>
+
+#include "clock.h"
+#include "clock36xx.h"
+
+
+/**
+ * omap36xx_pwrdn_clk_enable_with_hsdiv_restore - enable clocks suffering
+ *         from HSDivider PWRDN problem Implements Errata ID: i556.
+ * @clk: DPLL output struct clk
+ *
+ * 3630 only: dpll3_m3_ck, dpll4_m2_ck, dpll4_m3_ck, dpll4_m4_ck,
+ * dpll4_m5_ck & dpll4_m6_ck dividers gets loaded with reset
+ * valueafter their respective PWRDN bits are set.  Any dummy write
+ * (Any other value different from the Read value) to the
+ * corresponding CM_CLKSEL register will refresh the dividers.
+ */
+static int omap36xx_pwrdn_clk_enable_with_hsdiv_restore(struct clk *clk)
+{
+=09u32 dummy_v, orig_v, clksel_shift;
+=09int ret;
+
+=09/* Clear PWRDN bit of HSDIVIDER */
+=09ret =3D omap2_dflt_clk_enable(clk);
+
+=09/* Restore the dividers */
+=09if (!ret) {
+=09=09clksel_shift =3D __ffs(clk->parent->clksel_mask);
+=09=09orig_v =3D __raw_readl(clk->parent->clksel_reg);
+=09=09dummy_v =3D orig_v;
+
+=09=09/* Write any other value different from the Read value */
+=09=09dummy_v ^=3D (1 << clksel_shift);
+=09=09__raw_writel(dummy_v, clk->parent->clksel_reg);
+
+=09=09/* Write the original divider */
+=09=09__raw_writel(orig_v, clk->parent->clksel_reg);
+=09}
+
+=09return ret;
+}
+
+const struct clkops clkops_omap36xx_pwrdn_with_hsdiv_wait_restore =3D {
+=09.enable=09=09=3D omap36xx_pwrdn_clk_enable_with_hsdiv_restore,
+=09.disable=09=3D omap2_dflt_clk_disable,
+=09.find_companion=09=3D omap2_clk_dflt_find_companion,
+=09.find_idlest=09=3D omap2_clk_dflt_find_idlest,
+};
diff --git a/arch/arm/mach-omap2/clock36xx.h b/arch/arm/mach-omap2/clock36x=
x.h
new file mode 100644
index 0000000..a7dee5b
--- /dev/null
+++ b/arch/arm/mach-omap2/clock36xx.h
@@ -0,0 +1,13 @@
+/*
+ * OMAP36xx clock function prototypes and macros
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Copyright (C) 2010 Nokia Corporation
+ */
+
+#ifndef __ARCH_ARM_MACH_OMAP2_CLOCK36XX_H
+#define __ARCH_ARM_MACH_OMAP2_CLOCK36XX_H
+
+extern const struct clkops clkops_omap36xx_pwrdn_with_hsdiv_wait_restore;
+
+#endif
diff --git a/arch/arm/mach-omap2/clock3xxx.c b/arch/arm/mach-omap2/clock3xx=
x.c
new file mode 100644
index 0000000..d142457
--- /dev/null
+++ b/arch/arm/mach-omap2/clock3xxx.c
@@ -0,0 +1,145 @@
+/*
+ * OMAP3-specific clock framework functions
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
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/err.h>
+
+#include <plat/cpu.h>
+#include <plat/clock.h>
+
+#include "clock.h"
+#include "clock3xxx.h"
+#include "prm.h"
+#include "prm-regbits-34xx.h"
+#include "cm.h"
+#include "cm-regbits-34xx.h"
+
+/*
+ * DPLL5_FREQ_FOR_USBHOST: USBHOST and USBTLL are the only clocks
+ * that are sourced by DPLL5, and both of these require this clock
+ * to be at 120 MHz for proper operation.
+ */
+#define DPLL5_FREQ_FOR_USBHOST=09=09120000000
+
+/* needed by omap3_core_dpll_m2_set_rate() */
+struct clk *sdrc_ick_p, *arm_fck_p;
+
+int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate)
+{
+=09/*
+=09 * According to the 12-5 CDP code from TI, "Limitation 2.5"
+=09 * on 3430ES1 prevents us from changing DPLL multipliers or dividers
+=09 * on DPLL4.
+=09 */
+=09if (omap_rev() =3D=3D OMAP3430_REV_ES1_0) {
+=09=09pr_err("clock: DPLL4 cannot change rate due to "
+=09=09       "silicon 'Limitation 2.5' on 3430ES1.\n");
+=09=09return -EINVAL;
+=09}
+
+=09return omap3_noncore_dpll_set_rate(clk, rate);
+}
+
+void __init omap3_clk_lock_dpll5(void)
+{
+=09struct clk *dpll5_clk;
+=09struct clk *dpll5_m2_clk;
+
+=09dpll5_clk =3D clk_get(NULL, "dpll5_ck");
+=09clk_set_rate(dpll5_clk, DPLL5_FREQ_FOR_USBHOST);
+=09clk_enable(dpll5_clk);
+
+=09/* Enable autoidle to allow it to enter low power bypass */
+=09omap3_dpll_allow_idle(dpll5_clk);
+
+=09/* Program dpll5_m2_clk divider for no division */
+=09dpll5_m2_clk =3D clk_get(NULL, "dpll5_m2_ck");
+=09clk_enable(dpll5_m2_clk);
+=09clk_set_rate(dpll5_m2_clk, DPLL5_FREQ_FOR_USBHOST);
+
+=09clk_disable(dpll5_m2_clk);
+=09clk_disable(dpll5_clk);
+=09return;
+}
+
+/* Common clock code */
+
+/* REVISIT: Move this init stuff out into clock.c */
+
+/*
+ * Switch the MPU rate if specified on cmdline.
+ * We cannot do this early until cmdline is parsed.
+ */
+static int __init omap3xxx_clk_arch_init(void)
+{
+=09struct clk *osc_sys_ck, *dpll1_ck, *arm_fck, *core_ck;
+=09unsigned long osc_sys_rate;
+=09bool err =3D 0;
+
+=09if (!cpu_is_omap34xx())
+=09=09return 0;
+
+=09if (!mpurate)
+=09=09return -EINVAL;
+
+=09/* XXX test these for success */
+=09dpll1_ck =3D clk_get(NULL, "dpll1_ck");
+=09if (WARN(IS_ERR(dpll1_ck), "Failed to get dpll1_ck.\n"))
+=09=09err =3D 1;
+
+=09arm_fck =3D clk_get(NULL, "arm_fck");
+=09if (WARN(IS_ERR(arm_fck), "Failed to get arm_fck.\n"))
+=09=09err =3D 1;
+
+=09core_ck =3D clk_get(NULL, "core_ck");
+=09if (WARN(IS_ERR(core_ck), "Failed to get core_ck.\n"))
+=09=09err =3D 1;
+
+=09osc_sys_ck =3D clk_get(NULL, "osc_sys_ck");
+=09if (WARN(IS_ERR(osc_sys_ck), "Failed to get osc_sys_ck.\n"))
+=09=09err =3D 1;
+
+=09if (err)
+=09=09return -ENOENT;
+
+=09/* REVISIT: not yet ready for 343x */
+=09if (clk_set_rate(dpll1_ck, mpurate))
+=09=09printk(KERN_ERR "*** Unable to set MPU rate\n");
+
+=09recalculate_root_clocks();
+
+=09osc_sys_rate =3D clk_get_rate(osc_sys_ck);
+
+=09pr_info("Switched to new clocking rate (Crystal/Core/MPU): "
+=09=09"%ld.%01ld/%ld/%ld MHz\n",
+=09=09(osc_sys_rate / 1000000),
+=09=09((osc_sys_rate / 100000) % 10),
+=09=09(clk_get_rate(core_ck) / 1000000),
+=09=09(clk_get_rate(arm_fck) / 1000000));
+
+=09calibrate_delay();
+
+=09return 0;
+}
+arch_initcall(omap3xxx_clk_arch_init);
+
+
diff --git a/arch/arm/mach-omap2/clock3xxx.h b/arch/arm/mach-omap2/clock3xx=
x.h
new file mode 100644
index 0000000..8bbeeaf
--- /dev/null
+++ b/arch/arm/mach-omap2/clock3xxx.h
@@ -0,0 +1,21 @@
+/*
+ * OMAP3-common clock function prototypes and macros
+ *
+ * Copyright (C) 2007-2010 Texas Instruments, Inc.
+ * Copyright (C) 2007-2010 Nokia Corporation
+ */
+
+#ifndef __ARCH_ARM_MACH_OMAP2_CLOCK3XXX_H
+#define __ARCH_ARM_MACH_OMAP2_CLOCK3XXX_H
+
+int omap3xxx_clk_init(void);
+int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate);
+int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate);
+void omap3_clk_lock_dpll5(void);
+
+extern struct clk *sdrc_ick_p;
+extern struct clk *arm_fck_p;
+
+extern const struct clkops clkops_noncore_dpll_ops;
+
+#endif
diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2/clo=
ck3xxx_data.c
similarity index 99%
rename from arch/arm/mach-omap2/clock34xx_data.c
rename to arch/arm/mach-omap2/clock3xxx_data.c
index 950d6fc..f237902 100644
--- a/arch/arm/mach-omap2/clock34xx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -24,7 +24,11 @@
 #include <plat/clkdev_omap.h>
=20
 #include "clock.h"
+#include "clock3xxx.h"
 #include "clock34xx.h"
+#include "clock36xx.h"
+#include "clock3517.h"
+
 #include "cm.h"
 #include "cm-regbits-34xx.h"
 #include "prm.h"
@@ -374,7 +378,7 @@ static struct dpll_data dpll2_dd =3D {
=20
 static struct clk dpll2_ck =3D {
 =09.name=09=09=3D "dpll2_ck",
-=09.ops=09=09=3D &clkops_noncore_dpll_ops,
+=09.ops=09=09=3D &clkops_omap3_noncore_dpll_ops,
 =09.parent=09=09=3D &sys_ck,
 =09.dpll_data=09=3D &dpll2_dd,
 =09.round_rate=09=3D &omap2_dpll_round_rate,
@@ -615,7 +619,7 @@ static struct dpll_data dpll4_dd_3630 __initdata =3D {
=20
 static struct clk dpll4_ck =3D {
 =09.name=09=09=3D "dpll4_ck",
-=09.ops=09=09=3D &clkops_noncore_dpll_ops,
+=09.ops=09=09=3D &clkops_omap3_noncore_dpll_ops,
 =09.parent=09=09=3D &sys_ck,
 =09.dpll_data=09=3D &dpll4_dd,
 =09.round_rate=09=3D &omap2_dpll_round_rate,
@@ -1023,7 +1027,7 @@ static struct dpll_data dpll5_dd =3D {
=20
 static struct clk dpll5_ck =3D {
 =09.name=09=09=3D "dpll5_ck",
-=09.ops=09=09=3D &clkops_noncore_dpll_ops,
+=09.ops=09=09=3D &clkops_omap3_noncore_dpll_ops,
 =09.parent=09=09=3D &sys_ck,
 =09.dpll_data=09=3D &dpll5_dd,
 =09.round_rate=09=3D &omap2_dpll_round_rate,
@@ -3567,10 +3571,12 @@ int __init omap3xxx_clk_init(void)
=20
 =09clk_init(&omap2_clk_functions);
=20
-=09for (c =3D omap3xxx_clks; c < omap3xxx_clks + ARRAY_SIZE(omap3xxx_clks)=
; c++)
+=09for (c =3D omap3xxx_clks; c < omap3xxx_clks + ARRAY_SIZE(omap3xxx_clks)=
;
+=09     c++)
 =09=09clk_preinit(c->lk.clk);
=20
-=09for (c =3D omap3xxx_clks; c < omap3xxx_clks + ARRAY_SIZE(omap3xxx_clks)=
; c++)
+=09for (c =3D omap3xxx_clks; c < omap3xxx_clks + ARRAY_SIZE(omap3xxx_clks)=
;
+=09     c++)
 =09=09if (c->cpu & cpu_clkflg) {
 =09=09=09clkdev_add(&c->lk);
 =09=09=09clk_register(c->lk.clk);
diff --git a/arch/arm/mach-omap2/clock44xx.c b/arch/arm/mach-omap2/clock44x=
x.c
deleted file mode 100644
index c238717..0000000
--- a/arch/arm/mach-omap2/clock44xx.c
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * OMAP4-specific clock framework functions
- *
- * Copyright (C) 2009 Texas Instruments, Inc.
- *
- * Rajendra Nayak (rnayak@ti.com)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/errno.h>
-#include "clock.h"
-
-const struct clkops clkops_noncore_dpll_ops =3D {
-=09.enable=09=09=3D &omap3_noncore_dpll_enable,
-=09.disable=09=3D &omap3_noncore_dpll_disable,
-};
diff --git a/arch/arm/mach-omap2/clock44xx.h b/arch/arm/mach-omap2/clock44x=
x.h
index ed3b741..6be1095 100644
--- a/arch/arm/mach-omap2/clock44xx.h
+++ b/arch/arm/mach-omap2/clock44xx.h
@@ -5,8 +5,8 @@
  * Copyright (C) 2010 Nokia Corporation
  */
=20
-#ifndef __ARCH_ARM_MACH_OMAP2_CLOCK_44XX_H
-#define __ARCH_ARM_MACH_OMAP2_CLOCK_44XX_H
+#ifndef __ARCH_ARM_MACH_OMAP2_CLOCK44XX_H
+#define __ARCH_ARM_MACH_OMAP2_CLOCK44XX_H
=20
 /*
  * XXX Missing values for the OMAP4 DPLL_USB
@@ -17,6 +17,4 @@
=20
 int omap4xxx_clk_init(void);
=20
-extern const struct clkops clkops_noncore_dpll_ops;
-
 #endif
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clo=
ck44xx_data.c
index 70b314c..022f1a7 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -277,7 +277,7 @@ static struct clk dpll_abe_ck =3D {
 =09.parent=09=09=3D &abe_dpll_refclk_mux_ck,
 =09.dpll_data=09=3D &dpll_abe_dd,
 =09.init=09=09=3D &omap2_init_dpll_parent,
-=09.ops=09=09=3D &clkops_noncore_dpll_ops,
+=09.ops=09=09=3D &clkops_omap3_noncore_dpll_ops,
 =09.recalc=09=09=3D &omap3_dpll_recalc,
 =09.round_rate=09=3D &omap2_dpll_round_rate,
 =09.set_rate=09=3D &omap3_noncore_dpll_set_rate,
@@ -644,7 +644,7 @@ static struct clk dpll_iva_ck =3D {
 =09.parent=09=09=3D &dpll_sys_ref_clk,
 =09.dpll_data=09=3D &dpll_iva_dd,
 =09.init=09=09=3D &omap2_init_dpll_parent,
-=09.ops=09=09=3D &clkops_noncore_dpll_ops,
+=09.ops=09=09=3D &clkops_omap3_noncore_dpll_ops,
 =09.recalc=09=09=3D &omap3_dpll_recalc,
 =09.round_rate=09=3D &omap2_dpll_round_rate,
 =09.set_rate=09=3D &omap3_noncore_dpll_set_rate,
@@ -704,7 +704,7 @@ static struct clk dpll_mpu_ck =3D {
 =09.parent=09=09=3D &dpll_sys_ref_clk,
 =09.dpll_data=09=3D &dpll_mpu_dd,
 =09.init=09=09=3D &omap2_init_dpll_parent,
-=09.ops=09=09=3D &clkops_noncore_dpll_ops,
+=09.ops=09=09=3D &clkops_omap3_noncore_dpll_ops,
 =09.recalc=09=09=3D &omap3_dpll_recalc,
 =09.round_rate=09=3D &omap2_dpll_round_rate,
 =09.set_rate=09=3D &omap3_noncore_dpll_set_rate,
@@ -776,7 +776,7 @@ static struct clk dpll_per_ck =3D {
 =09.parent=09=09=3D &dpll_sys_ref_clk,
 =09.dpll_data=09=3D &dpll_per_dd,
 =09.init=09=09=3D &omap2_init_dpll_parent,
-=09.ops=09=09=3D &clkops_noncore_dpll_ops,
+=09.ops=09=09=3D &clkops_omap3_noncore_dpll_ops,
 =09.recalc=09=09=3D &omap3_dpll_recalc,
 =09.round_rate=09=3D &omap2_dpll_round_rate,
 =09.set_rate=09=3D &omap3_noncore_dpll_set_rate,
@@ -891,7 +891,7 @@ static struct clk dpll_unipro_ck =3D {
 =09.parent=09=09=3D &dpll_sys_ref_clk,
 =09.dpll_data=09=3D &dpll_unipro_dd,
 =09.init=09=09=3D &omap2_init_dpll_parent,
-=09.ops=09=09=3D &clkops_noncore_dpll_ops,
+=09.ops=09=09=3D &clkops_omap3_noncore_dpll_ops,
 =09.recalc=09=09=3D &omap3_dpll_recalc,
 =09.round_rate=09=3D &omap2_dpll_round_rate,
 =09.set_rate=09=3D &omap3_noncore_dpll_set_rate,
@@ -947,7 +947,7 @@ static struct clk dpll_usb_ck =3D {
 =09.parent=09=09=3D &dpll_sys_ref_clk,
 =09.dpll_data=09=3D &dpll_usb_dd,
 =09.init=09=09=3D &omap2_init_dpll_parent,
-=09.ops=09=09=3D &clkops_noncore_dpll_ops,
+=09.ops=09=09=3D &clkops_omap3_noncore_dpll_ops,
 =09.recalc=09=09=3D &omap3_dpll_recalc,
 =09.round_rate=09=3D &omap2_dpll_round_rate,
 =09.set_rate=09=3D &omap3_noncore_dpll_set_rate,
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 01ef2ae..ad782e4 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -36,7 +36,7 @@
 #include <plat/vram.h>
=20
 #include "clock2xxx.h"
-#include "clock34xx.h"
+#include "clock3xxx.h"
 #include "clock44xx.h"
=20
 #include <plat/omap-pm.h>
--=20
1.6.6.GIT

--155748971-1274776450-1266281901=:28188--
