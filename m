From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v3 8/8] OMAP1 clock: convert mach-omap1/clock.h to
 mach-omap1/clock_data.c
Date: Thu, 3 Dec 2009 09:20:13 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912030919270.13408@utopia.booyaka.com>
References: <20091203095830.1203.76290.stgit@localhost.localdomain> <20091203100707.1203.98247.stgit@localhost.localdomain> <20091203102700.GA30423@flint.arm.linux.org.uk> <alpine.DEB.2.00.0912030331360.13408@utopia.booyaka.com> <20091203104354.GB20379@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.0912030355050.13408@utopia.booyaka.com> <alpine.DEB.2.00.0912030424050.13408@utopia.booyaka.com> <20091203121157.GC20379@n2100.arm.linux.org.uk> <alpine.DEB.2.00.0912030520360.13408@utopia.booyaka.com> <20091203150300.GB26651@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.0912030822060.13408@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56048 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754272AbZLCQUH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 11:20:07 -0500
In-Reply-To: <alpine.DEB.2.00.0912030822060.13408@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>

The OMAP1 clock code currently #includes a large .h file full of static
data structures.  Instead, define the data in a .c file.

Russell King <linux@arm.linux.org.uk> proposed this new arrangement:

    http://marc.info/?l=linux-omap&m=125967425908895&w=2

This patch also deals with most of the flagrant checkpatch violations.

While here, separate the mpu_rate data structures out into their own
files, opp.h and opp_data.c.  In the long run, these mpu_rate tables
should be replaced with OPP code.

Also includes a patch from Felipe Balbi <felipe.balbi@nokia.com> to
mark omap1_clk_functions as __initdata to avoid a section warning:

    http://patchwork.kernel.org/patch/64366/

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap1/Makefile                  |    3 
 arch/arm/mach-omap1/clock.c                   |  486 +++-----------
 arch/arm/mach-omap1/clock.h                   |  662 +-------------------
 arch/arm/mach-omap1/clock_data.c              |  843 +++++++++++++++++++++++++
 arch/arm/mach-omap1/io.c                      |    3 
 arch/arm/mach-omap1/opp.h                     |   28 +
 arch/arm/mach-omap1/opp_data.c                |   59 ++
 arch/arm/plat-omap/include/plat/clkdev_omap.h |   18 -
 8 files changed, 1091 insertions(+), 1011 deletions(-)
 create mode 100644 arch/arm/mach-omap1/clock_data.c
 create mode 100644 arch/arm/mach-omap1/opp.h
 create mode 100644 arch/arm/mach-omap1/opp_data.c

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index 87e539a..ceced8f 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -3,7 +3,8 @@
 #
 
 # Common support
-obj-y := io.o id.o sram.o clock.o irq.o mux.o serial.o devices.o
+obj-y := io.o id.o sram.o irq.o mux.o serial.o devices.o
+obj-y += clock.o clock_data.o opp_data.o
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 
diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 26a887c..36393d1 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -1,7 +1,7 @@
 /*
  *  linux/arch/arm/mach-omap1/clock.c
  *
- *  Copyright (C) 2004 - 2005 Nokia corporation
+ *  Copyright (C) 2004 - 2005, 2009 Nokia corporation
  *  Written by Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
  *
  *  Modified to use omap shared clock framework by
@@ -26,12 +26,17 @@
 #include <plat/usb.h>
 #include <plat/clock.h>
 #include <plat/sram.h>
-
-static const struct clkops clkops_generic;
-static const struct clkops clkops_uart;
-static const struct clkops clkops_dspck;
+#include <plat/clkdev_omap.h>
 
 #include "clock.h"
+#include "opp.h"
+
+__u32 arm_idlect1_mask;
+struct clk *api_ck_p, *ck_dpll1_p, *ck_ref_p;
+
+/*-------------------------------------------------------------------------
+ * Omap1 specific clock functions
+ *-------------------------------------------------------------------------*/
 
 static int clk_omap1_dummy_enable(struct clk *clk)
 {
@@ -42,134 +47,24 @@ static void clk_omap1_dummy_disable(struct clk *clk)
 {
 }
 
-static const struct clkops clkops_dummy = {
-	.enable = clk_omap1_dummy_enable,
-	.disable = clk_omap1_dummy_disable,
-};
-
-static struct clk dummy_ck = {
-	.name	= "dummy",
-	.ops	= &clkops_dummy,
-	.flags	= RATE_FIXED,
-};
-
-struct omap_clk {
-	u32		cpu;
-	struct clk_lookup lk;
+const struct clkops clkops_dummy = {
+	.enable		= clk_omap1_dummy_enable,
+	.disable	= clk_omap1_dummy_disable,
 };
 
-#define CLK(dev, con, ck, cp) 		\
-	{				\
-		 .cpu = cp,		\
-		.lk = {			\
-			.dev_id = dev,	\
-			.con_id = con,	\
-			.clk = ck,	\
-		},			\
-	}
-
-#define CK_310	(1 << 0)
-#define CK_7XX	(1 << 1)
-#define CK_1510	(1 << 2)
-#define CK_16XX	(1 << 3)
-
-static struct omap_clk omap_clks[] = {
-	/* non-ULPD clocks */
-	CLK(NULL,	"ck_ref",	&ck_ref,	CK_16XX | CK_1510 | CK_310 | CK_7XX),
-	CLK(NULL,	"ck_dpll1",	&ck_dpll1,	CK_16XX | CK_1510 | CK_310),
-	/* CK_GEN1 clocks */
-	CLK(NULL,	"ck_dpll1out",	&ck_dpll1out.clk, CK_16XX),
-	CLK(NULL,	"ck_sossi",	&sossi_ck,	CK_16XX),
-	CLK(NULL,	"arm_ck",	&arm_ck,	CK_16XX | CK_1510 | CK_310),
-	CLK(NULL,	"armper_ck",	&armper_ck.clk,	CK_16XX | CK_1510 | CK_310),
-	CLK(NULL,	"arm_gpio_ck",	&arm_gpio_ck,	CK_1510 | CK_310),
-	CLK(NULL,	"armxor_ck",	&armxor_ck.clk,	CK_16XX | CK_1510 | CK_310 | CK_7XX),
-	CLK(NULL,	"armtim_ck",	&armtim_ck.clk,	CK_16XX | CK_1510 | CK_310),
-	CLK("omap_wdt",	"fck",		&armwdt_ck.clk,	CK_16XX | CK_1510 | CK_310),
-	CLK("omap_wdt",	"ick",		&armper_ck.clk,	CK_16XX),
-	CLK("omap_wdt", "ick",		&dummy_ck,	CK_1510 | CK_310),
-	CLK(NULL,	"arminth_ck",	&arminth_ck1510, CK_1510 | CK_310),
-	CLK(NULL,	"arminth_ck",	&arminth_ck16xx, CK_16XX),
-	/* CK_GEN2 clocks */
-	CLK(NULL,	"dsp_ck",	&dsp_ck,	CK_16XX | CK_1510 | CK_310),
-	CLK(NULL,	"dspmmu_ck",	&dspmmu_ck,	CK_16XX | CK_1510 | CK_310),
-	CLK(NULL,	"dspper_ck",	&dspper_ck,	CK_16XX | CK_1510 | CK_310),
-	CLK(NULL,	"dspxor_ck",	&dspxor_ck,	CK_16XX | CK_1510 | CK_310),
-	CLK(NULL,	"dsptim_ck",	&dsptim_ck,	CK_16XX | CK_1510 | CK_310),
-	/* CK_GEN3 clocks */
-	CLK(NULL,	"tc_ck",	&tc_ck.clk,	CK_16XX | CK_1510 | CK_310 | CK_7XX),
-	CLK(NULL,	"tipb_ck",	&tipb_ck,	CK_1510 | CK_310),
-	CLK(NULL,	"l3_ocpi_ck",	&l3_ocpi_ck,	CK_16XX | CK_7XX),
-	CLK(NULL,	"tc1_ck",	&tc1_ck,	CK_16XX),
-	CLK(NULL,	"tc2_ck",	&tc2_ck,	CK_16XX),
-	CLK(NULL,	"dma_ck",	&dma_ck,	CK_16XX | CK_1510 | CK_310),
-	CLK(NULL,	"dma_lcdfree_ck", &dma_lcdfree_ck, CK_16XX),
-	CLK(NULL,	"api_ck",	&api_ck.clk,	CK_16XX | CK_1510 | CK_310),
-	CLK(NULL,	"lb_ck",	&lb_ck.clk,	CK_1510 | CK_310),
-	CLK(NULL,	"rhea1_ck",	&rhea1_ck,	CK_16XX),
-	CLK(NULL,	"rhea2_ck",	&rhea2_ck,	CK_16XX),
-	CLK(NULL,	"lcd_ck",	&lcd_ck_16xx,	CK_16XX | CK_7XX),
-	CLK(NULL,	"lcd_ck",	&lcd_ck_1510.clk, CK_1510 | CK_310),
-	/* ULPD clocks */
-	CLK(NULL,	"uart1_ck",	&uart1_1510,	CK_1510 | CK_310),
-	CLK(NULL,	"uart1_ck",	&uart1_16xx.clk, CK_16XX),
-	CLK(NULL,	"uart2_ck",	&uart2_ck,	CK_16XX | CK_1510 | CK_310),
-	CLK(NULL,	"uart3_ck",	&uart3_1510,	CK_1510 | CK_310),
-	CLK(NULL,	"uart3_ck",	&uart3_16xx.clk, CK_16XX),
-	CLK(NULL,	"usb_clko",	&usb_clko,	CK_16XX | CK_1510 | CK_310),
-	CLK(NULL,	"usb_hhc_ck",	&usb_hhc_ck1510, CK_1510 | CK_310),
-	CLK(NULL,	"usb_hhc_ck",	&usb_hhc_ck16xx, CK_16XX),
-	CLK(NULL,	"usb_dc_ck",	&usb_dc_ck,	CK_16XX),
-	CLK(NULL,	"usb_dc_ck",	&usb_dc_ck7xx,	CK_7XX),
-	CLK(NULL,	"mclk",		&mclk_1510,	CK_1510 | CK_310),
-	CLK(NULL,	"mclk",		&mclk_16xx,	CK_16XX),
-	CLK(NULL,	"bclk",		&bclk_1510,	CK_1510 | CK_310),
-	CLK(NULL,	"bclk",		&bclk_16xx,	CK_16XX),
-	CLK("mmci-omap.0", "fck",	&mmc1_ck,	CK_16XX | CK_1510 | CK_310),
-	CLK("mmci-omap.0", "fck",	&mmc3_ck,	CK_7XX),
-	CLK("mmci-omap.0", "ick",	&armper_ck.clk,	CK_16XX | CK_1510 | CK_310 | CK_7XX),
-	CLK("mmci-omap.1", "fck",	&mmc2_ck,	CK_16XX),
-	CLK("mmci-omap.1", "ick",	&armper_ck.clk,	CK_16XX),
-	/* Virtual clocks */
-	CLK(NULL,	"mpu",		&virtual_ck_mpu, CK_16XX | CK_1510 | CK_310),
-	CLK("i2c_omap.1", "fck",	&i2c_fck,	CK_16XX | CK_1510 | CK_310),
-	CLK("i2c_omap.1", "ick",	&i2c_ick,	CK_16XX),
-	CLK("i2c_omap.1", "ick",	&dummy_ck,	CK_1510 | CK_310),
-	CLK("omap_uwire", "fck",	&armxor_ck.clk,	CK_16XX | CK_1510 | CK_310),
-	CLK("omap-mcbsp.1", "ick",	&dspper_ck,	CK_16XX),
-	CLK("omap-mcbsp.1", "ick",	&dummy_ck,	CK_1510 | CK_310),
-	CLK("omap-mcbsp.2", "ick",	&armper_ck.clk,	CK_16XX),
-	CLK("omap-mcbsp.2", "ick",	&dummy_ck,	CK_1510 | CK_310),
-	CLK("omap-mcbsp.3", "ick",	&dspper_ck,	CK_16XX),
-	CLK("omap-mcbsp.3", "ick",	&dummy_ck,	CK_1510 | CK_310),
-	CLK("omap-mcbsp.1", "fck",	&dspxor_ck,	CK_16XX | CK_1510 | CK_310),
-	CLK("omap-mcbsp.2", "fck",	&armper_ck.clk,	CK_16XX | CK_1510 | CK_310),
-	CLK("omap-mcbsp.3", "fck",	&dspxor_ck,	CK_16XX | CK_1510 | CK_310),
-};
-
-static int omap1_clk_enable_generic(struct clk * clk);
-static int omap1_clk_enable(struct clk *clk);
-static void omap1_clk_disable_generic(struct clk * clk);
-static void omap1_clk_disable(struct clk *clk);
-
-__u32 arm_idlect1_mask;
-
-/*-------------------------------------------------------------------------
- * Omap1 specific clock functions
- *-------------------------------------------------------------------------*/
-
-static unsigned long omap1_watchdog_recalc(struct clk *clk)
+/* XXX can be replaced with a fixed_divisor_recalc */
+unsigned long omap1_watchdog_recalc(struct clk *clk)
 {
 	return clk->parent->rate / 14;
 }
 
-static unsigned long omap1_uart_recalc(struct clk *clk)
+unsigned long omap1_uart_recalc(struct clk *clk)
 {
 	unsigned int val = __raw_readl(clk->enable_reg);
 	return val & clk->enable_bit ? 48000000 : 12000000;
 }
 
-static unsigned long omap1_sossi_recalc(struct clk *clk)
+unsigned long omap1_sossi_recalc(struct clk *clk)
 {
 	u32 div = omap_readl(MOD_CONF_CTRL_1);
 
@@ -179,64 +74,6 @@ static unsigned long omap1_sossi_recalc(struct clk *clk)
 	return clk->parent->rate / div;
 }
 
-static int omap1_clk_enable_dsp_domain(struct clk *clk)
-{
-	int retval;
-
-	retval = omap1_clk_enable(&api_ck.clk);
-	if (!retval) {
-		retval = omap1_clk_enable_generic(clk);
-		omap1_clk_disable(&api_ck.clk);
-	}
-
-	return retval;
-}
-
-static void omap1_clk_disable_dsp_domain(struct clk *clk)
-{
-	if (omap1_clk_enable(&api_ck.clk) == 0) {
-		omap1_clk_disable_generic(clk);
-		omap1_clk_disable(&api_ck.clk);
-	}
-}
-
-static const struct clkops clkops_dspck = {
-	.enable		= &omap1_clk_enable_dsp_domain,
-	.disable	= &omap1_clk_disable_dsp_domain,
-};
-
-static int omap1_clk_enable_uart_functional(struct clk *clk)
-{
-	int ret;
-	struct uart_clk *uclk;
-
-	ret = omap1_clk_enable_generic(clk);
-	if (ret == 0) {
-		/* Set smart idle acknowledgement mode */
-		uclk = (struct uart_clk *)clk;
-		omap_writeb((omap_readb(uclk->sysc_addr) & ~0x10) | 8,
-			    uclk->sysc_addr);
-	}
-
-	return ret;
-}
-
-static void omap1_clk_disable_uart_functional(struct clk *clk)
-{
-	struct uart_clk *uclk;
-
-	/* Set force idle acknowledgement mode */
-	uclk = (struct uart_clk *)clk;
-	omap_writeb((omap_readb(uclk->sysc_addr) & ~0x18), uclk->sysc_addr);
-
-	omap1_clk_disable_generic(clk);
-}
-
-static const struct clkops clkops_uart = {
-	.enable		= &omap1_clk_enable_uart_functional,
-	.disable	= &omap1_clk_disable_uart_functional,
-};
-
 static void omap1_clk_allow_idle(struct clk *clk)
 {
 	struct arm_idlect1_clk * iclk = (struct arm_idlect1_clk *)clk;
@@ -344,7 +181,7 @@ static int calc_dsor_exp(struct clk *clk, unsigned long rate)
 	return dsor_exp;
 }
 
-static unsigned long omap1_ckctl_recalc(struct clk *clk)
+unsigned long omap1_ckctl_recalc(struct clk *clk)
 {
 	/* Calculate divisor encoded as 2-bit exponent */
 	int dsor = 1 << (3 & (omap_readw(ARM_CKCTL) >> clk->rate_offset));
@@ -352,7 +189,7 @@ static unsigned long omap1_ckctl_recalc(struct clk *clk)
 	return clk->parent->rate / dsor;
 }
 
-static unsigned long omap1_ckctl_recalc_dsp_domain(struct clk *clk)
+unsigned long omap1_ckctl_recalc_dsp_domain(struct clk *clk)
 {
 	int dsor;
 
@@ -363,25 +200,29 @@ static unsigned long omap1_ckctl_recalc_dsp_domain(struct clk *clk)
 	 * Note that DSP_CKCTL virt addr = phys addr, so
 	 * we must use __raw_readw() instead of omap_readw().
 	 */
-	omap1_clk_enable(&api_ck.clk);
+	omap1_clk_enable(api_ck_p);
 	dsor = 1 << (3 & (__raw_readw(DSP_CKCTL) >> clk->rate_offset));
-	omap1_clk_disable(&api_ck.clk);
+	omap1_clk_disable(api_ck_p);
 
 	return clk->parent->rate / dsor;
 }
 
 /* MPU virtual clock functions */
-static int omap1_select_table_rate(struct clk * clk, unsigned long rate)
+int omap1_select_table_rate(struct clk *clk, unsigned long rate)
 {
 	/* Find the highest supported frequency <= rate and switch to it */
 	struct mpu_rate * ptr;
+	unsigned long dpll1_rate, ref_rate;
 
-	for (ptr = rate_table; ptr->rate; ptr++) {
-		if (ptr->xtal != ck_ref.rate)
+	dpll1_rate = clk_get_rate(ck_dpll1_p);
+	ref_rate = clk_get_rate(ck_ref_p);
+
+	for (ptr = omap1_rate_table; ptr->rate; ptr++) {
+		if (ptr->xtal != ref_rate)
 			continue;
 
 		/* DPLL1 cannot be reprogrammed without risking system crash */
-		if (likely(ck_dpll1.rate!=0) && ptr->pll_rate != ck_dpll1.rate)
+		if (likely(dpll1_rate != 0) && ptr->pll_rate != dpll1_rate)
 			continue;
 
 		/* Can check only after xtal frequency check */
@@ -402,11 +243,13 @@ static int omap1_select_table_rate(struct clk * clk, unsigned long rate)
 	else
 		omap_sram_reprogram_clock(ptr->dpllctl_val, ptr->ckctl_val);
 
-	ck_dpll1.rate = ptr->pll_rate;
+	/* XXX Do we need to recalculate the tree below DPLL1 at this point? */
+	ck_dpll1_p->rate = ptr->pll_rate;
+
 	return 0;
 }
 
-static int omap1_clk_set_rate_dsp_domain(struct clk *clk, unsigned long rate)
+int omap1_clk_set_rate_dsp_domain(struct clk *clk, unsigned long rate)
 {
 	int dsor_exp;
 	u16 regval;
@@ -426,7 +269,7 @@ static int omap1_clk_set_rate_dsp_domain(struct clk *clk, unsigned long rate)
 	return 0;
 }
 
-static long omap1_clk_round_rate_ckctl_arm(struct clk *clk, unsigned long rate)
+long omap1_clk_round_rate_ckctl_arm(struct clk *clk, unsigned long rate)
 {
 	int dsor_exp = calc_dsor_exp(clk, rate);
 	if (dsor_exp < 0)
@@ -436,7 +279,7 @@ static long omap1_clk_round_rate_ckctl_arm(struct clk *clk, unsigned long rate)
 	return clk->parent->rate / (1 << dsor_exp);
 }
 
-static int omap1_clk_set_rate_ckctl_arm(struct clk *clk, unsigned long rate)
+int omap1_clk_set_rate_ckctl_arm(struct clk *clk, unsigned long rate)
 {
 	int dsor_exp;
 	u16 regval;
@@ -456,16 +299,19 @@ static int omap1_clk_set_rate_ckctl_arm(struct clk *clk, unsigned long rate)
 	return 0;
 }
 
-static long omap1_round_to_table_rate(struct clk * clk, unsigned long rate)
+long omap1_round_to_table_rate(struct clk *clk, unsigned long rate)
 {
 	/* Find the highest supported frequency <= rate */
 	struct mpu_rate * ptr;
-	long  highest_rate;
+	long highest_rate;
+	unsigned long ref_rate;
+
+	ref_rate = clk_get_rate(ck_ref_p);
 
 	highest_rate = -EINVAL;
 
-	for (ptr = rate_table; ptr->rate; ptr++) {
-		if (ptr->xtal != ck_ref.rate)
+	for (ptr = omap1_rate_table; ptr->rate; ptr++) {
+		if (ptr->xtal != ref_rate)
 			continue;
 
 		highest_rate = ptr->rate;
@@ -500,8 +346,8 @@ static unsigned calc_ext_dsor(unsigned long rate)
 	return dsor;
 }
 
-/* Only needed on 1510 */
-static int omap1_set_uart_rate(struct clk * clk, unsigned long rate)
+/* XXX Only needed on 1510 */
+int omap1_set_uart_rate(struct clk *clk, unsigned long rate)
 {
 	unsigned int val;
 
@@ -519,7 +365,7 @@ static int omap1_set_uart_rate(struct clk * clk, unsigned long rate)
 }
 
 /* External clock (MCLK & BCLK) functions */
-static int omap1_set_ext_clk_rate(struct clk * clk, unsigned long rate)
+int omap1_set_ext_clk_rate(struct clk *clk, unsigned long rate)
 {
 	unsigned dsor;
 	__u16 ratio_bits;
@@ -537,7 +383,7 @@ static int omap1_set_ext_clk_rate(struct clk * clk, unsigned long rate)
 	return 0;
 }
 
-static int omap1_set_sossi_rate(struct clk *clk, unsigned long rate)
+int omap1_set_sossi_rate(struct clk *clk, unsigned long rate)
 {
 	u32 l;
 	int div;
@@ -560,12 +406,12 @@ static int omap1_set_sossi_rate(struct clk *clk, unsigned long rate)
 	return 0;
 }
 
-static long omap1_round_ext_clk_rate(struct clk * clk, unsigned long rate)
+long omap1_round_ext_clk_rate(struct clk *clk, unsigned long rate)
 {
 	return 96000000 / calc_ext_dsor(rate);
 }
 
-static void omap1_init_ext_clk(struct clk * clk)
+void omap1_init_ext_clk(struct clk *clk)
 {
 	unsigned dsor;
 	__u16 ratio_bits;
@@ -583,7 +429,7 @@ static void omap1_init_ext_clk(struct clk * clk)
 	clk-> rate = 96000000 / dsor;
 }
 
-static int omap1_clk_enable(struct clk *clk)
+int omap1_clk_enable(struct clk *clk)
 {
 	int ret = 0;
 
@@ -611,7 +457,7 @@ err:
 	return ret;
 }
 
-static void omap1_clk_disable(struct clk *clk)
+void omap1_clk_disable(struct clk *clk)
 {
 	if (clk->usecount > 0 && !(--clk->usecount)) {
 		clk->ops->disable(clk);
@@ -666,12 +512,70 @@ static void omap1_clk_disable_generic(struct clk *clk)
 	}
 }
 
-static const struct clkops clkops_generic = {
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
+const struct clkops clkops_generic = {
+	.enable		= omap1_clk_enable_generic,
+	.disable	= omap1_clk_disable_generic,
 };
 
-static long omap1_clk_round_rate(struct clk *clk, unsigned long rate)
+static int omap1_clk_enable_dsp_domain(struct clk *clk)
+{
+	int retval;
+
+	retval = omap1_clk_enable(api_ck_p);
+	if (!retval) {
+		retval = omap1_clk_enable_generic(clk);
+		omap1_clk_disable(api_ck_p);
+	}
+
+	return retval;
+}
+
+static void omap1_clk_disable_dsp_domain(struct clk *clk)
+{
+	if (omap1_clk_enable(api_ck_p) == 0) {
+		omap1_clk_disable_generic(clk);
+		omap1_clk_disable(api_ck_p);
+	}
+}
+
+const struct clkops clkops_dspck = {
+	.enable		= omap1_clk_enable_dsp_domain,
+	.disable	= omap1_clk_disable_dsp_domain,
+};
+
+static int omap1_clk_enable_uart_functional(struct clk *clk)
+{
+	int ret;
+	struct uart_clk *uclk;
+
+	ret = omap1_clk_enable_generic(clk);
+	if (ret == 0) {
+		/* Set smart idle acknowledgement mode */
+		uclk = (struct uart_clk *)clk;
+		omap_writeb((omap_readb(uclk->sysc_addr) & ~0x10) | 8,
+			    uclk->sysc_addr);
+	}
+
+	return ret;
+}
+
+static void omap1_clk_disable_uart_functional(struct clk *clk)
+{
+	struct uart_clk *uclk;
+
+	/* Set force idle acknowledgement mode */
+	uclk = (struct uart_clk *)clk;
+	omap_writeb((omap_readb(uclk->sysc_addr) & ~0x18), uclk->sysc_addr);
+
+	omap1_clk_disable_generic(clk);
+}
+
+const struct clkops clkops_uart = {
+	.enable		= omap1_clk_enable_uart_functional,
+	.disable	= omap1_clk_disable_uart_functional,
+};
+
+long omap1_clk_round_rate(struct clk *clk, unsigned long rate)
 {
 	if (clk->flags & RATE_FIXED)
 		return clk->rate;
@@ -682,7 +586,7 @@ static long omap1_clk_round_rate(struct clk *clk, unsigned long rate)
 	return clk->rate;
 }
 
-static int omap1_clk_set_rate(struct clk *clk, unsigned long rate)
+int omap1_clk_set_rate(struct clk *clk, unsigned long rate)
 {
 	int  ret = -EINVAL;
 
@@ -697,7 +601,7 @@ static int omap1_clk_set_rate(struct clk *clk, unsigned long rate)
 
 #ifdef CONFIG_OMAP_RESET_CLOCKS
 
-static void __init omap1_clk_disable_unused(struct clk *clk)
+void __init omap1_clk_disable_unused(struct clk *clk)
 {
 	__u32 regval32;
 
@@ -726,165 +630,3 @@ static void __init omap1_clk_disable_unused(struct clk *clk)
 #else
 #define omap1_clk_disable_unused	NULL
 #endif
-
-static struct clk_functions omap1_clk_functions = {
-	.clk_enable		= omap1_clk_enable,
-	.clk_disable		= omap1_clk_disable,
-	.clk_round_rate		= omap1_clk_round_rate,
-	.clk_set_rate		= omap1_clk_set_rate,
-	.clk_disable_unused	= omap1_clk_disable_unused,
-};
-
-int __init omap1_clk_init(void)
-{
-	struct omap_clk *c;
-	const struct omap_clock_config *info;
-	int crystal_type = 0; /* Default 12 MHz */
-	u32 reg, cpu_mask;
-
-#ifdef CONFIG_DEBUG_LL
-	/* Resets some clocks that may be left on from bootloader,
-	 * but leaves serial clocks on.
- 	 */
-	omap_writel(0x3 << 29, MOD_CONF_CTRL_0);
-#endif
-
-	/* USB_REQ_EN will be disabled later if necessary (usb_dc_ck) */
-	reg = omap_readw(SOFT_REQ_REG) & (1 << 4);
-	omap_writew(reg, SOFT_REQ_REG);
-	if (!cpu_is_omap15xx())
-		omap_writew(0, SOFT_REQ_REG2);
-
-	clk_init(&omap1_clk_functions);
-
-	/* By default all idlect1 clocks are allowed to idle */
-	arm_idlect1_mask = ~0;
-
-	for (c = omap_clks; c < omap_clks + ARRAY_SIZE(omap_clks); c++)
-		clk_preinit(c->lk.clk);
-
-	cpu_mask = 0;
-	if (cpu_is_omap16xx())
-		cpu_mask |= CK_16XX;
-	if (cpu_is_omap1510())
-		cpu_mask |= CK_1510;
-	if (cpu_is_omap7xx())
-		cpu_mask |= CK_7XX;
-	if (cpu_is_omap310())
-		cpu_mask |= CK_310;
-
-	for (c = omap_clks; c < omap_clks + ARRAY_SIZE(omap_clks); c++)
-		if (c->cpu & cpu_mask) {
-			clkdev_add(&c->lk);
-			clk_register(c->lk.clk);
-		}
-
-	info = omap_get_config(OMAP_TAG_CLOCK, struct omap_clock_config);
-	if (info != NULL) {
-		if (!cpu_is_omap15xx())
-			crystal_type = info->system_clock_type;
-	}
-
-#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-	ck_ref.rate = 13000000;
-#elif defined(CONFIG_ARCH_OMAP16XX)
-	if (crystal_type == 2)
-		ck_ref.rate = 19200000;
-#endif
-
-	printk("Clocks: ARM_SYSST: 0x%04x DPLL_CTL: 0x%04x ARM_CKCTL: 0x%04x\n",
-	       omap_readw(ARM_SYSST), omap_readw(DPLL_CTL),
-	       omap_readw(ARM_CKCTL));
-
-	/* We want to be in syncronous scalable mode */
-	omap_writew(0x1000, ARM_SYSST);
-
-#ifdef CONFIG_OMAP_CLOCKS_SET_BY_BOOTLOADER
-	/* Use values set by bootloader. Determine PLL rate and recalculate
-	 * dependent clocks as if kernel had changed PLL or divisors.
-	 */
-	{
-		unsigned pll_ctl_val = omap_readw(DPLL_CTL);
-
-		ck_dpll1.rate = ck_ref.rate; /* Base xtal rate */
-		if (pll_ctl_val & 0x10) {
-			/* PLL enabled, apply multiplier and divisor */
-			if (pll_ctl_val & 0xf80)
-				ck_dpll1.rate *= (pll_ctl_val & 0xf80) >> 7;
-			ck_dpll1.rate /= ((pll_ctl_val & 0x60) >> 5) + 1;
-		} else {
-			/* PLL disabled, apply bypass divisor */
-			switch (pll_ctl_val & 0xc) {
-			case 0:
-				break;
-			case 0x4:
-				ck_dpll1.rate /= 2;
-				break;
-			default:
-				ck_dpll1.rate /= 4;
-				break;
-			}
-		}
-	}
-#else
-	/* Find the highest supported frequency and enable it */
-	if (omap1_select_table_rate(&virtual_ck_mpu, ~0)) {
-		printk(KERN_ERR "System frequencies not set. Check your config.\n");
-		/* Guess sane values (60MHz) */
-		omap_writew(0x2290, DPLL_CTL);
-		omap_writew(cpu_is_omap7xx() ? 0x3005 : 0x1005, ARM_CKCTL);
-		ck_dpll1.rate = 60000000;
-	}
-#endif
-	propagate_rate(&ck_dpll1);
-	/* Cache rates for clocks connected to ck_ref (not dpll1) */
-	propagate_rate(&ck_ref);
-	printk(KERN_INFO "Clocking rate (xtal/DPLL1/MPU): "
-		"%ld.%01ld/%ld.%01ld/%ld.%01ld MHz\n",
-	       ck_ref.rate / 1000000, (ck_ref.rate / 100000) % 10,
-	       ck_dpll1.rate / 1000000, (ck_dpll1.rate / 100000) % 10,
-	       arm_ck.rate / 1000000, (arm_ck.rate / 100000) % 10);
-
-#if defined(CONFIG_MACH_OMAP_PERSEUS2) || defined(CONFIG_MACH_OMAP_FSAMPLE)
-	/* Select slicer output as OMAP input clock */
-	omap_writew(omap_readw(OMAP7XX_PCC_UPLD_CTRL) & ~0x1, OMAP7XX_PCC_UPLD_CTRL);
-#endif
-
-	/* Amstrad Delta wants BCLK high when inactive */
-	if (machine_is_ams_delta())
-		omap_writel(omap_readl(ULPD_CLOCK_CTRL) |
-				(1 << SDW_MCLK_INV_BIT),
-				ULPD_CLOCK_CTRL);
-
-	/* Turn off DSP and ARM_TIMXO. Make sure ARM_INTHCK is not divided */
-	/* (on 730, bit 13 must not be cleared) */
-	if (cpu_is_omap7xx())
-		omap_writew(omap_readw(ARM_CKCTL) & 0x2fff, ARM_CKCTL);
-	else
-		omap_writew(omap_readw(ARM_CKCTL) & 0x0fff, ARM_CKCTL);
-
-	/* Put DSP/MPUI into reset until needed */
-	omap_writew(0, ARM_RSTCT1);
-	omap_writew(1, ARM_RSTCT2);
-	omap_writew(0x400, ARM_IDLECT1);
-
-	/*
-	 * According to OMAP5910 Erratum SYS_DMA_1, bit DMACK_REQ (bit 8)
-	 * of the ARM_IDLECT2 register must be set to zero. The power-on
-	 * default value of this bit is one.
-	 */
-	omap_writew(0x0000, ARM_IDLECT2);	/* Turn LCD clock off also */
-
-	/*
-	 * Only enable those clocks we will need, let the drivers
-	 * enable other clocks as necessary
-	 */
-	clk_enable(&armper_ck.clk);
-	clk_enable(&armxor_ck.clk);
-	clk_enable(&armtim_ck.clk); /* This should be done by timer code */
-
-	if (cpu_is_omap15xx())
-		clk_enable(&arm_gpio_ck);
-
-	return 0;
-}
diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
index 70195ca..5f6a5bc 100644
--- a/arch/arm/mach-omap1/clock.h
+++ b/arch/arm/mach-omap1/clock.h
@@ -1,7 +1,7 @@
 /*
  *  linux/arch/arm/mach-omap1/clock.h
  *
- *  Copyright (C) 2004 - 2005 Nokia corporation
+ *  Copyright (C) 2004 - 2005, 2009 Nokia corporation
  *  Written by Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
  *  Based on clocks.h by Tony Lindgren, Gordon McNutt and RidgeRun, Inc
  *
@@ -13,30 +13,31 @@
 #ifndef __ARCH_ARM_MACH_OMAP1_CLOCK_H
 #define __ARCH_ARM_MACH_OMAP1_CLOCK_H
 
-static unsigned long omap1_ckctl_recalc(struct clk *clk);
-static unsigned long omap1_watchdog_recalc(struct clk *clk);
-static int omap1_set_sossi_rate(struct clk *clk, unsigned long rate);
-static unsigned long omap1_sossi_recalc(struct clk *clk);
-static unsigned long omap1_ckctl_recalc_dsp_domain(struct clk *clk);
-static int omap1_clk_set_rate_dsp_domain(struct clk * clk, unsigned long rate);
-static int omap1_set_uart_rate(struct clk * clk, unsigned long rate);
-static unsigned long omap1_uart_recalc(struct clk *clk);
-static int omap1_set_ext_clk_rate(struct clk * clk, unsigned long rate);
-static long omap1_round_ext_clk_rate(struct clk * clk, unsigned long rate);
-static void omap1_init_ext_clk(struct clk * clk);
-static int omap1_select_table_rate(struct clk * clk, unsigned long rate);
-static long omap1_round_to_table_rate(struct clk * clk, unsigned long rate);
-
-static int omap1_clk_set_rate_ckctl_arm(struct clk *clk, unsigned long rate);
-static long omap1_clk_round_rate_ckctl_arm(struct clk *clk, unsigned long rate);
-
-struct mpu_rate {
-	unsigned long		rate;
-	unsigned long		xtal;
-	unsigned long		pll_rate;
-	__u16			ckctl_val;
-	__u16			dpllctl_val;
-};
+#include <linux/clk.h>
+
+#include <plat/clock.h>
+
+extern int __init omap1_clk_init(void);
+extern int omap1_clk_enable(struct clk *clk);
+extern void omap1_clk_disable(struct clk *clk);
+extern long omap1_clk_round_rate(struct clk *clk, unsigned long rate);
+extern int omap1_clk_set_rate(struct clk *clk, unsigned long rate);
+extern void __init omap1_clk_disable_unused(struct clk *clk);
+extern unsigned long omap1_ckctl_recalc(struct clk *clk);
+extern int omap1_set_sossi_rate(struct clk *clk, unsigned long rate);
+extern unsigned long omap1_sossi_recalc(struct clk *clk);
+extern unsigned long omap1_ckctl_recalc_dsp_domain(struct clk *clk);
+extern int omap1_clk_set_rate_dsp_domain(struct clk *clk, unsigned long rate);
+extern int omap1_set_uart_rate(struct clk *clk, unsigned long rate);
+extern unsigned long omap1_uart_recalc(struct clk *clk);
+extern int omap1_set_ext_clk_rate(struct clk *clk, unsigned long rate);
+extern long omap1_round_ext_clk_rate(struct clk *clk, unsigned long rate);
+extern void omap1_init_ext_clk(struct clk *clk);
+extern int omap1_select_table_rate(struct clk *clk, unsigned long rate);
+extern long omap1_round_to_table_rate(struct clk *clk, unsigned long rate);
+extern int omap1_clk_set_rate_ckctl_arm(struct clk *clk, unsigned long rate);
+extern long omap1_clk_round_rate_ckctl_arm(struct clk *clk, unsigned long rate);
+extern unsigned long omap1_watchdog_recalc(struct clk *clk);
 
 struct uart_clk {
 	struct clk	clk;
@@ -96,611 +97,12 @@ struct arm_idlect1_clk {
 #define SOFT_REQ_REG		0xfffe0834
 #define SOFT_REQ_REG2		0xfffe0880
 
-/*-------------------------------------------------------------------------
- * Omap1 MPU rate table
- *-------------------------------------------------------------------------*/
-static struct mpu_rate rate_table[] = {
-	/* MPU MHz, xtal MHz, dpll1 MHz, CKCTL, DPLL_CTL
-	 * NOTE: Comment order here is different from bits in CKCTL value:
-	 * armdiv, dspdiv, dspmmu, tcdiv, perdiv, lcddiv
-	 */
-#if defined(CONFIG_OMAP_ARM_216MHZ)
-	{ 216000000, 12000000, 216000000, 0x050d, 0x2910 }, /* 1/1/2/2/2/8 */
-#endif
-#if defined(CONFIG_OMAP_ARM_195MHZ)
-	{ 195000000, 13000000, 195000000, 0x050e, 0x2790 }, /* 1/1/2/2/4/8 */
-#endif
-#if defined(CONFIG_OMAP_ARM_192MHZ)
-	{ 192000000, 19200000, 192000000, 0x050f, 0x2510 }, /* 1/1/2/2/8/8 */
-	{ 192000000, 12000000, 192000000, 0x050f, 0x2810 }, /* 1/1/2/2/8/8 */
-	{  96000000, 12000000, 192000000, 0x055f, 0x2810 }, /* 2/2/2/2/8/8 */
-	{  48000000, 12000000, 192000000, 0x0baf, 0x2810 }, /* 4/4/4/8/8/8 */
-	{  24000000, 12000000, 192000000, 0x0fff, 0x2810 }, /* 8/8/8/8/8/8 */
-#endif
-#if defined(CONFIG_OMAP_ARM_182MHZ)
-	{ 182000000, 13000000, 182000000, 0x050e, 0x2710 }, /* 1/1/2/2/4/8 */
-#endif
-#if defined(CONFIG_OMAP_ARM_168MHZ)
-	{ 168000000, 12000000, 168000000, 0x010f, 0x2710 }, /* 1/1/1/2/8/8 */
-#endif
-#if defined(CONFIG_OMAP_ARM_150MHZ)
-	{ 150000000, 12000000, 150000000, 0x010a, 0x2cb0 }, /* 1/1/1/2/4/4 */
-#endif
-#if defined(CONFIG_OMAP_ARM_120MHZ)
-	{ 120000000, 12000000, 120000000, 0x010a, 0x2510 }, /* 1/1/1/2/4/4 */
-#endif
-#if defined(CONFIG_OMAP_ARM_96MHZ)
-	{  96000000, 12000000,  96000000, 0x0005, 0x2410 }, /* 1/1/1/1/2/2 */
-#endif
-#if defined(CONFIG_OMAP_ARM_60MHZ)
-	{  60000000, 12000000,  60000000, 0x0005, 0x2290 }, /* 1/1/1/1/2/2 */
-#endif
-#if defined(CONFIG_OMAP_ARM_30MHZ)
-	{  30000000, 12000000,  60000000, 0x0555, 0x2290 }, /* 2/2/2/2/2/2 */
-#endif
-	{ 0, 0, 0, 0, 0 },
-};
-
-/*-------------------------------------------------------------------------
- * Omap1 clocks
- *-------------------------------------------------------------------------*/
-
-static struct clk ck_ref = {
-	.name		= "ck_ref",
-	.ops		= &clkops_null,
-	.rate		= 12000000,
-};
-
-static struct clk ck_dpll1 = {
-	.name		= "ck_dpll1",
-	.ops		= &clkops_null,
-	.parent		= &ck_ref,
-};
-
-/*
- * FIXME: This clock seems to be necessary but no-one has asked for its
- * activation.  [ FIX: SoSSI, SSR ]
- */
-static struct arm_idlect1_clk ck_dpll1out = {
-	.clk = {
-		.name		= "ck_dpll1out",
-		.ops		= &clkops_generic,
-		.parent		= &ck_dpll1,
-		.flags		= CLOCK_IDLE_CONTROL | ENABLE_REG_32BIT |
-				  ENABLE_ON_INIT,
-		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
-		.enable_bit	= EN_CKOUT_ARM,
-		.recalc		= &followparent_recalc,
-	},
-	.idlect_shift	= 12,
-};
-
-static struct clk sossi_ck = {
-	.name		= "ck_sossi",
-	.ops		= &clkops_generic,
-	.parent		= &ck_dpll1out.clk,
-	.flags		= CLOCK_NO_IDLE_PARENT | ENABLE_REG_32BIT,
-	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_1),
-	.enable_bit	= 16,
-	.recalc		= &omap1_sossi_recalc,
-	.set_rate	= &omap1_set_sossi_rate,
-};
-
-static struct clk arm_ck = {
-	.name		= "arm_ck",
-	.ops		= &clkops_null,
-	.parent		= &ck_dpll1,
-	.rate_offset	= CKCTL_ARMDIV_OFFSET,
-	.recalc		= &omap1_ckctl_recalc,
-	.round_rate	= omap1_clk_round_rate_ckctl_arm,
-	.set_rate	= omap1_clk_set_rate_ckctl_arm,
-};
-
-static struct arm_idlect1_clk armper_ck = {
-	.clk = {
-		.name		= "armper_ck",
-		.ops		= &clkops_generic,
-		.parent		= &ck_dpll1,
-		.flags		= CLOCK_IDLE_CONTROL,
-		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
-		.enable_bit	= EN_PERCK,
-		.rate_offset	= CKCTL_PERDIV_OFFSET,
-		.recalc		= &omap1_ckctl_recalc,
-		.round_rate	= omap1_clk_round_rate_ckctl_arm,
-		.set_rate	= omap1_clk_set_rate_ckctl_arm,
-	},
-	.idlect_shift	= 2,
-};
-
-/*
- * FIXME: This clock seems to be necessary but no-one has asked for its
- * activation.  [ GPIO code for 1510 ]
- */
-static struct clk arm_gpio_ck = {
-	.name		= "arm_gpio_ck",
-	.ops		= &clkops_generic,
-	.parent		= &ck_dpll1,
-	.flags		= ENABLE_ON_INIT,
-	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
-	.enable_bit	= EN_GPIOCK,
-	.recalc		= &followparent_recalc,
-};
-
-static struct arm_idlect1_clk armxor_ck = {
-	.clk = {
-		.name		= "armxor_ck",
-		.ops		= &clkops_generic,
-		.parent		= &ck_ref,
-		.flags		= CLOCK_IDLE_CONTROL,
-		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
-		.enable_bit	= EN_XORPCK,
-		.recalc		= &followparent_recalc,
-	},
-	.idlect_shift	= 1,
-};
-
-static struct arm_idlect1_clk armtim_ck = {
-	.clk = {
-		.name		= "armtim_ck",
-		.ops		= &clkops_generic,
-		.parent		= &ck_ref,
-		.flags		= CLOCK_IDLE_CONTROL,
-		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
-		.enable_bit	= EN_TIMCK,
-		.recalc		= &followparent_recalc,
-	},
-	.idlect_shift	= 9,
-};
-
-static struct arm_idlect1_clk armwdt_ck = {
-	.clk = {
-		.name		= "armwdt_ck",
-		.ops		= &clkops_generic,
-		.parent		= &ck_ref,
-		.flags		= CLOCK_IDLE_CONTROL,
-		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
-		.enable_bit	= EN_WDTCK,
-		.recalc		= &omap1_watchdog_recalc,
-	},
-	.idlect_shift	= 0,
-};
-
-static struct clk arminth_ck16xx = {
-	.name		= "arminth_ck",
-	.ops		= &clkops_null,
-	.parent		= &arm_ck,
-	.recalc		= &followparent_recalc,
-	/* Note: On 16xx the frequency can be divided by 2 by programming
-	 * ARM_CKCTL:ARM_INTHCK_SEL(14) to 1
-	 *
-	 * 1510 version is in TC clocks.
-	 */
-};
-
-static struct clk dsp_ck = {
-	.name		= "dsp_ck",
-	.ops		= &clkops_generic,
-	.parent		= &ck_dpll1,
-	.enable_reg	= OMAP1_IO_ADDRESS(ARM_CKCTL),
-	.enable_bit	= EN_DSPCK,
-	.rate_offset	= CKCTL_DSPDIV_OFFSET,
-	.recalc		= &omap1_ckctl_recalc,
-	.round_rate	= omap1_clk_round_rate_ckctl_arm,
-	.set_rate	= omap1_clk_set_rate_ckctl_arm,
-};
-
-static struct clk dspmmu_ck = {
-	.name		= "dspmmu_ck",
-	.ops		= &clkops_null,
-	.parent		= &ck_dpll1,
-	.rate_offset	= CKCTL_DSPMMUDIV_OFFSET,
-	.recalc		= &omap1_ckctl_recalc,
-	.round_rate	= omap1_clk_round_rate_ckctl_arm,
-	.set_rate	= omap1_clk_set_rate_ckctl_arm,
-};
-
-static struct clk dspper_ck = {
-	.name		= "dspper_ck",
-	.ops		= &clkops_dspck,
-	.parent		= &ck_dpll1,
-	.enable_reg	= DSP_IDLECT2,
-	.enable_bit	= EN_PERCK,
-	.rate_offset	= CKCTL_PERDIV_OFFSET,
-	.recalc		= &omap1_ckctl_recalc_dsp_domain,
-	.round_rate	= omap1_clk_round_rate_ckctl_arm,
-	.set_rate	= &omap1_clk_set_rate_dsp_domain,
-};
-
-static struct clk dspxor_ck = {
-	.name		= "dspxor_ck",
-	.ops		= &clkops_dspck,
-	.parent		= &ck_ref,
-	.enable_reg	= DSP_IDLECT2,
-	.enable_bit	= EN_XORPCK,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk dsptim_ck = {
-	.name		= "dsptim_ck",
-	.ops		= &clkops_dspck,
-	.parent		= &ck_ref,
-	.enable_reg	= DSP_IDLECT2,
-	.enable_bit	= EN_DSPTIMCK,
-	.recalc		= &followparent_recalc,
-};
-
-/* Tie ARM_IDLECT1:IDLIF_ARM to this logical clock structure */
-static struct arm_idlect1_clk tc_ck = {
-	.clk = {
-		.name		= "tc_ck",
-		.ops		= &clkops_null,
-		.parent		= &ck_dpll1,
-		.flags		= CLOCK_IDLE_CONTROL,
-		.rate_offset	= CKCTL_TCDIV_OFFSET,
-		.recalc		= &omap1_ckctl_recalc,
-		.round_rate	= omap1_clk_round_rate_ckctl_arm,
-		.set_rate	= omap1_clk_set_rate_ckctl_arm,
-	},
-	.idlect_shift	= 6,
-};
-
-static struct clk arminth_ck1510 = {
-	.name		= "arminth_ck",
-	.ops		= &clkops_null,
-	.parent		= &tc_ck.clk,
-	.recalc		= &followparent_recalc,
-	/* Note: On 1510 the frequency follows TC_CK
-	 *
-	 * 16xx version is in MPU clocks.
-	 */
-};
-
-static struct clk tipb_ck = {
-	/* No-idle controlled by "tc_ck" */
-	.name		= "tipb_ck",
-	.ops		= &clkops_null,
-	.parent		= &tc_ck.clk,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk l3_ocpi_ck = {
-	/* No-idle controlled by "tc_ck" */
-	.name		= "l3_ocpi_ck",
-	.ops		= &clkops_generic,
-	.parent		= &tc_ck.clk,
-	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT3),
-	.enable_bit	= EN_OCPI_CK,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk tc1_ck = {
-	.name		= "tc1_ck",
-	.ops		= &clkops_generic,
-	.parent		= &tc_ck.clk,
-	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT3),
-	.enable_bit	= EN_TC1_CK,
-	.recalc		= &followparent_recalc,
-};
-
-/*
- * FIXME: This clock seems to be necessary but no-one has asked for its
- * activation.  [ pm.c (SRAM), CCP, Camera ]
- */
-static struct clk tc2_ck = {
-	.name		= "tc2_ck",
-	.ops		= &clkops_generic,
-	.parent		= &tc_ck.clk,
-	.flags		= ENABLE_ON_INIT,
-	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT3),
-	.enable_bit	= EN_TC2_CK,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk dma_ck = {
-	/* No-idle controlled by "tc_ck" */
-	.name		= "dma_ck",
-	.ops		= &clkops_null,
-	.parent		= &tc_ck.clk,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk dma_lcdfree_ck = {
-	.name		= "dma_lcdfree_ck",
-	.ops		= &clkops_null,
-	.parent		= &tc_ck.clk,
-	.recalc		= &followparent_recalc,
-};
-
-static struct arm_idlect1_clk api_ck = {
-	.clk = {
-		.name		= "api_ck",
-		.ops		= &clkops_generic,
-		.parent		= &tc_ck.clk,
-		.flags		= CLOCK_IDLE_CONTROL,
-		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
-		.enable_bit	= EN_APICK,
-		.recalc		= &followparent_recalc,
-	},
-	.idlect_shift	= 8,
-};
-
-static struct arm_idlect1_clk lb_ck = {
-	.clk = {
-		.name		= "lb_ck",
-		.ops		= &clkops_generic,
-		.parent		= &tc_ck.clk,
-		.flags		= CLOCK_IDLE_CONTROL,
-		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
-		.enable_bit	= EN_LBCK,
-		.recalc		= &followparent_recalc,
-	},
-	.idlect_shift	= 4,
-};
-
-static struct clk rhea1_ck = {
-	.name		= "rhea1_ck",
-	.ops		= &clkops_null,
-	.parent		= &tc_ck.clk,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk rhea2_ck = {
-	.name		= "rhea2_ck",
-	.ops		= &clkops_null,
-	.parent		= &tc_ck.clk,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk lcd_ck_16xx = {
-	.name		= "lcd_ck",
-	.ops		= &clkops_generic,
-	.parent		= &ck_dpll1,
-	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
-	.enable_bit	= EN_LCDCK,
-	.rate_offset	= CKCTL_LCDDIV_OFFSET,
-	.recalc		= &omap1_ckctl_recalc,
-	.round_rate	= omap1_clk_round_rate_ckctl_arm,
-	.set_rate	= omap1_clk_set_rate_ckctl_arm,
-};
-
-static struct arm_idlect1_clk lcd_ck_1510 = {
-	.clk = {
-		.name		= "lcd_ck",
-		.ops		= &clkops_generic,
-		.parent		= &ck_dpll1,
-		.flags		= CLOCK_IDLE_CONTROL,
-		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
-		.enable_bit	= EN_LCDCK,
-		.rate_offset	= CKCTL_LCDDIV_OFFSET,
-		.recalc		= &omap1_ckctl_recalc,
-		.round_rate	= omap1_clk_round_rate_ckctl_arm,
-		.set_rate	= omap1_clk_set_rate_ckctl_arm,
-	},
-	.idlect_shift	= 3,
-};
-
-static struct clk uart1_1510 = {
-	.name		= "uart1_ck",
-	.ops		= &clkops_null,
-	/* Direct from ULPD, no real parent */
-	.parent		= &armper_ck.clk,
-	.rate		= 12000000,
-	.flags		= ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
-	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
-	.enable_bit	= 29,	/* Chooses between 12MHz and 48MHz */
-	.set_rate	= &omap1_set_uart_rate,
-	.recalc		= &omap1_uart_recalc,
-};
-
-static struct uart_clk uart1_16xx = {
-	.clk	= {
-		.name		= "uart1_ck",
-		.ops		= &clkops_uart,
-		/* Direct from ULPD, no real parent */
-		.parent		= &armper_ck.clk,
-		.rate		= 48000000,
-		.flags		= RATE_FIXED | ENABLE_REG_32BIT |
-				  CLOCK_NO_IDLE_PARENT,
-		.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
-		.enable_bit	= 29,
-	},
-	.sysc_addr	= 0xfffb0054,
-};
-
-static struct clk uart2_ck = {
-	.name		= "uart2_ck",
-	.ops		= &clkops_null,
-	/* Direct from ULPD, no real parent */
-	.parent		= &armper_ck.clk,
-	.rate		= 12000000,
-	.flags		= ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
-	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
-	.enable_bit	= 30,	/* Chooses between 12MHz and 48MHz */
-	.set_rate	= &omap1_set_uart_rate,
-	.recalc		= &omap1_uart_recalc,
-};
-
-static struct clk uart3_1510 = {
-	.name		= "uart3_ck",
-	.ops		= &clkops_null,
-	/* Direct from ULPD, no real parent */
-	.parent		= &armper_ck.clk,
-	.rate		= 12000000,
-	.flags		= ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
-	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
-	.enable_bit	= 31,	/* Chooses between 12MHz and 48MHz */
-	.set_rate	= &omap1_set_uart_rate,
-	.recalc		= &omap1_uart_recalc,
-};
-
-static struct uart_clk uart3_16xx = {
-	.clk	= {
-		.name		= "uart3_ck",
-		.ops		= &clkops_uart,
-		/* Direct from ULPD, no real parent */
-		.parent		= &armper_ck.clk,
-		.rate		= 48000000,
-		.flags		= RATE_FIXED | ENABLE_REG_32BIT |
-				  CLOCK_NO_IDLE_PARENT,
-		.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
-		.enable_bit	= 31,
-	},
-	.sysc_addr	= 0xfffb9854,
-};
-
-static struct clk usb_clko = {	/* 6 MHz output on W4_USB_CLKO */
-	.name		= "usb_clko",
-	.ops		= &clkops_generic,
-	/* Direct from ULPD, no parent */
-	.rate		= 6000000,
-	.flags		= RATE_FIXED | ENABLE_REG_32BIT,
-	.enable_reg	= OMAP1_IO_ADDRESS(ULPD_CLOCK_CTRL),
-	.enable_bit	= USB_MCLK_EN_BIT,
-};
-
-static struct clk usb_hhc_ck1510 = {
-	.name		= "usb_hhc_ck",
-	.ops		= &clkops_generic,
-	/* Direct from ULPD, no parent */
-	.rate		= 48000000, /* Actually 2 clocks, 12MHz and 48MHz */
-	.flags		= RATE_FIXED | ENABLE_REG_32BIT,
-	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
-	.enable_bit	= USB_HOST_HHC_UHOST_EN,
-};
-
-static struct clk usb_hhc_ck16xx = {
-	.name		= "usb_hhc_ck",
-	.ops		= &clkops_generic,
-	/* Direct from ULPD, no parent */
-	.rate		= 48000000,
-	/* OTG_SYSCON_2.OTG_PADEN == 0 (not 1510-compatible) */
-	.flags		= RATE_FIXED | ENABLE_REG_32BIT,
-	.enable_reg	= OMAP1_IO_ADDRESS(OTG_BASE + 0x08), /* OTG_SYSCON_2 */
-	.enable_bit	= 8 /* UHOST_EN */,
-};
-
-static struct clk usb_dc_ck = {
-	.name		= "usb_dc_ck",
-	.ops		= &clkops_generic,
-	/* Direct from ULPD, no parent */
-	.rate		= 48000000,
-	.flags		= RATE_FIXED,
-	.enable_reg	= OMAP1_IO_ADDRESS(SOFT_REQ_REG),
-	.enable_bit	= 4,
-};
-
-static struct clk usb_dc_ck7xx = {
-	.name		= "usb_dc_ck",
-	.ops		= &clkops_generic,
-	/* Direct from ULPD, no parent */
-	.rate		= 48000000,
-	.flags		= RATE_FIXED,
-	.enable_reg	= OMAP1_IO_ADDRESS(SOFT_REQ_REG),
-	.enable_bit	= 8,
-};
-
-static struct clk mclk_1510 = {
-	.name		= "mclk",
-	.ops		= &clkops_generic,
-	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
-	.rate		= 12000000,
-	.flags		= RATE_FIXED,
-	.enable_reg	= OMAP1_IO_ADDRESS(SOFT_REQ_REG),
-	.enable_bit	= 6,
-};
-
-static struct clk mclk_16xx = {
-	.name		= "mclk",
-	.ops		= &clkops_generic,
-	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
-	.enable_reg	= OMAP1_IO_ADDRESS(COM_CLK_DIV_CTRL_SEL),
-	.enable_bit	= COM_ULPD_PLL_CLK_REQ,
-	.set_rate	= &omap1_set_ext_clk_rate,
-	.round_rate	= &omap1_round_ext_clk_rate,
-	.init		= &omap1_init_ext_clk,
-};
+extern __u32 arm_idlect1_mask;
+extern struct clk *api_ck_p, *ck_dpll1_p, *ck_ref_p;
 
-static struct clk bclk_1510 = {
-	.name		= "bclk",
-	.ops		= &clkops_generic,
-	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
-	.rate		= 12000000,
-	.flags		= RATE_FIXED,
-};
-
-static struct clk bclk_16xx = {
-	.name		= "bclk",
-	.ops		= &clkops_generic,
-	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
-	.enable_reg	= OMAP1_IO_ADDRESS(SWD_CLK_DIV_CTRL_SEL),
-	.enable_bit	= SWD_ULPD_PLL_CLK_REQ,
-	.set_rate	= &omap1_set_ext_clk_rate,
-	.round_rate	= &omap1_round_ext_clk_rate,
-	.init		= &omap1_init_ext_clk,
-};
-
-static struct clk mmc1_ck = {
-	.name		= "mmc_ck",
-	.ops		= &clkops_generic,
-	/* Functional clock is direct from ULPD, interface clock is ARMPER */
-	.parent		= &armper_ck.clk,
-	.rate		= 48000000,
-	.flags		= RATE_FIXED | ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
-	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
-	.enable_bit	= 23,
-};
-
-static struct clk mmc2_ck = {
-	.name		= "mmc_ck",
-	.id		= 1,
-	.ops		= &clkops_generic,
-	/* Functional clock is direct from ULPD, interface clock is ARMPER */
-	.parent		= &armper_ck.clk,
-	.rate		= 48000000,
-	.flags		= RATE_FIXED | ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
-	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
-	.enable_bit	= 20,
-};
-
-static struct clk mmc3_ck = {
-	.name		= "mmc_ck",
-	.id		= 2,
-	.ops		= &clkops_generic,
-	/* Functional clock is direct from ULPD, interface clock is ARMPER */
-	.parent		= &armper_ck.clk,
-	.rate		= 48000000,
-	.flags		= RATE_FIXED | ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
-	.enable_reg	= OMAP1_IO_ADDRESS(SOFT_REQ_REG),
-	.enable_bit	= 12,
-};
-
-static struct clk virtual_ck_mpu = {
-	.name		= "mpu",
-	.ops		= &clkops_null,
-	.parent		= &arm_ck, /* Is smarter alias for */
-	.recalc		= &followparent_recalc,
-	.set_rate	= &omap1_select_table_rate,
-	.round_rate	= &omap1_round_to_table_rate,
-};
-
-/* virtual functional clock domain for I2C. Just for making sure that ARMXOR_CK
-remains active during MPU idle whenever this is enabled */
-static struct clk i2c_fck = {
-	.name		= "i2c_fck",
-	.id		= 1,
-	.ops		= &clkops_null,
-	.flags		= CLOCK_NO_IDLE_PARENT,
-	.parent		= &armxor_ck.clk,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk i2c_ick = {
-	.name		= "i2c_ick",
-	.id		= 1,
-	.ops		= &clkops_null,
-	.flags		= CLOCK_NO_IDLE_PARENT,
-	.parent		= &armper_ck.clk,
-	.recalc		= &followparent_recalc,
-};
+extern const struct clkops clkops_dspck;
+extern const struct clkops clkops_dummy;
+extern const struct clkops clkops_uart;
+extern const struct clkops clkops_generic;
 
 #endif
diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
new file mode 100644
index 0000000..cf5f017
--- /dev/null
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -0,0 +1,843 @@
+/*
+ *  linux/arch/arm/mach-omap1/clock_data.c
+ *
+ *  Copyright (C) 2004 - 2005, 2009 Nokia corporation
+ *  Written by Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
+ *  Based on clocks.h by Tony Lindgren, Gordon McNutt and RidgeRun, Inc
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <asm/mach-types.h>  /* for machine_is_* */
+
+#include <plat/clock.h>
+#include <plat/cpu.h>
+#include <plat/clkdev_omap.h>
+#include <plat/usb.h>   /* for OTG_BASE */
+
+#include "clock.h"
+
+/*------------------------------------------------------------------------
+ * Omap1 clocks
+ *-------------------------------------------------------------------------*/
+
+/* XXX is this necessary? */
+static struct clk dummy_ck = {
+	.name	= "dummy",
+	.ops	= &clkops_dummy,
+	.flags	= RATE_FIXED,
+};
+
+static struct clk ck_ref = {
+	.name		= "ck_ref",
+	.ops		= &clkops_null,
+	.rate		= 12000000,
+};
+
+static struct clk ck_dpll1 = {
+	.name		= "ck_dpll1",
+	.ops		= &clkops_null,
+	.parent		= &ck_ref,
+};
+
+/*
+ * FIXME: This clock seems to be necessary but no-one has asked for its
+ * activation.  [ FIX: SoSSI, SSR ]
+ */
+static struct arm_idlect1_clk ck_dpll1out = {
+	.clk = {
+		.name		= "ck_dpll1out",
+		.ops		= &clkops_generic,
+		.parent		= &ck_dpll1,
+		.flags		= CLOCK_IDLE_CONTROL | ENABLE_REG_32BIT |
+				  ENABLE_ON_INIT,
+		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
+		.enable_bit	= EN_CKOUT_ARM,
+		.recalc		= &followparent_recalc,
+	},
+	.idlect_shift	= 12,
+};
+
+static struct clk sossi_ck = {
+	.name		= "ck_sossi",
+	.ops		= &clkops_generic,
+	.parent		= &ck_dpll1out.clk,
+	.flags		= CLOCK_NO_IDLE_PARENT | ENABLE_REG_32BIT,
+	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_1),
+	.enable_bit	= 16,
+	.recalc		= &omap1_sossi_recalc,
+	.set_rate	= &omap1_set_sossi_rate,
+};
+
+static struct clk arm_ck = {
+	.name		= "arm_ck",
+	.ops		= &clkops_null,
+	.parent		= &ck_dpll1,
+	.rate_offset	= CKCTL_ARMDIV_OFFSET,
+	.recalc		= &omap1_ckctl_recalc,
+	.round_rate	= omap1_clk_round_rate_ckctl_arm,
+	.set_rate	= omap1_clk_set_rate_ckctl_arm,
+};
+
+static struct arm_idlect1_clk armper_ck = {
+	.clk = {
+		.name		= "armper_ck",
+		.ops		= &clkops_generic,
+		.parent		= &ck_dpll1,
+		.flags		= CLOCK_IDLE_CONTROL,
+		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
+		.enable_bit	= EN_PERCK,
+		.rate_offset	= CKCTL_PERDIV_OFFSET,
+		.recalc		= &omap1_ckctl_recalc,
+		.round_rate	= omap1_clk_round_rate_ckctl_arm,
+		.set_rate	= omap1_clk_set_rate_ckctl_arm,
+	},
+	.idlect_shift	= 2,
+};
+
+/*
+ * FIXME: This clock seems to be necessary but no-one has asked for its
+ * activation.  [ GPIO code for 1510 ]
+ */
+static struct clk arm_gpio_ck = {
+	.name		= "arm_gpio_ck",
+	.ops		= &clkops_generic,
+	.parent		= &ck_dpll1,
+	.flags		= ENABLE_ON_INIT,
+	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
+	.enable_bit	= EN_GPIOCK,
+	.recalc		= &followparent_recalc,
+};
+
+static struct arm_idlect1_clk armxor_ck = {
+	.clk = {
+		.name		= "armxor_ck",
+		.ops		= &clkops_generic,
+		.parent		= &ck_ref,
+		.flags		= CLOCK_IDLE_CONTROL,
+		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
+		.enable_bit	= EN_XORPCK,
+		.recalc		= &followparent_recalc,
+	},
+	.idlect_shift	= 1,
+};
+
+static struct arm_idlect1_clk armtim_ck = {
+	.clk = {
+		.name		= "armtim_ck",
+		.ops		= &clkops_generic,
+		.parent		= &ck_ref,
+		.flags		= CLOCK_IDLE_CONTROL,
+		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
+		.enable_bit	= EN_TIMCK,
+		.recalc		= &followparent_recalc,
+	},
+	.idlect_shift	= 9,
+};
+
+static struct arm_idlect1_clk armwdt_ck = {
+	.clk = {
+		.name		= "armwdt_ck",
+		.ops		= &clkops_generic,
+		.parent		= &ck_ref,
+		.flags		= CLOCK_IDLE_CONTROL,
+		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
+		.enable_bit	= EN_WDTCK,
+		.recalc		= &omap1_watchdog_recalc,
+	},
+	.idlect_shift	= 0,
+};
+
+static struct clk arminth_ck16xx = {
+	.name		= "arminth_ck",
+	.ops		= &clkops_null,
+	.parent		= &arm_ck,
+	.recalc		= &followparent_recalc,
+	/* Note: On 16xx the frequency can be divided by 2 by programming
+	 * ARM_CKCTL:ARM_INTHCK_SEL(14) to 1
+	 *
+	 * 1510 version is in TC clocks.
+	 */
+};
+
+static struct clk dsp_ck = {
+	.name		= "dsp_ck",
+	.ops		= &clkops_generic,
+	.parent		= &ck_dpll1,
+	.enable_reg	= OMAP1_IO_ADDRESS(ARM_CKCTL),
+	.enable_bit	= EN_DSPCK,
+	.rate_offset	= CKCTL_DSPDIV_OFFSET,
+	.recalc		= &omap1_ckctl_recalc,
+	.round_rate	= omap1_clk_round_rate_ckctl_arm,
+	.set_rate	= omap1_clk_set_rate_ckctl_arm,
+};
+
+static struct clk dspmmu_ck = {
+	.name		= "dspmmu_ck",
+	.ops		= &clkops_null,
+	.parent		= &ck_dpll1,
+	.rate_offset	= CKCTL_DSPMMUDIV_OFFSET,
+	.recalc		= &omap1_ckctl_recalc,
+	.round_rate	= omap1_clk_round_rate_ckctl_arm,
+	.set_rate	= omap1_clk_set_rate_ckctl_arm,
+};
+
+static struct clk dspper_ck = {
+	.name		= "dspper_ck",
+	.ops		= &clkops_dspck,
+	.parent		= &ck_dpll1,
+	.enable_reg	= DSP_IDLECT2,
+	.enable_bit	= EN_PERCK,
+	.rate_offset	= CKCTL_PERDIV_OFFSET,
+	.recalc		= &omap1_ckctl_recalc_dsp_domain,
+	.round_rate	= omap1_clk_round_rate_ckctl_arm,
+	.set_rate	= &omap1_clk_set_rate_dsp_domain,
+};
+
+static struct clk dspxor_ck = {
+	.name		= "dspxor_ck",
+	.ops		= &clkops_dspck,
+	.parent		= &ck_ref,
+	.enable_reg	= DSP_IDLECT2,
+	.enable_bit	= EN_XORPCK,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk dsptim_ck = {
+	.name		= "dsptim_ck",
+	.ops		= &clkops_dspck,
+	.parent		= &ck_ref,
+	.enable_reg	= DSP_IDLECT2,
+	.enable_bit	= EN_DSPTIMCK,
+	.recalc		= &followparent_recalc,
+};
+
+/* Tie ARM_IDLECT1:IDLIF_ARM to this logical clock structure */
+static struct arm_idlect1_clk tc_ck = {
+	.clk = {
+		.name		= "tc_ck",
+		.ops		= &clkops_null,
+		.parent		= &ck_dpll1,
+		.flags		= CLOCK_IDLE_CONTROL,
+		.rate_offset	= CKCTL_TCDIV_OFFSET,
+		.recalc		= &omap1_ckctl_recalc,
+		.round_rate	= omap1_clk_round_rate_ckctl_arm,
+		.set_rate	= omap1_clk_set_rate_ckctl_arm,
+	},
+	.idlect_shift	= 6,
+};
+
+static struct clk arminth_ck1510 = {
+	.name		= "arminth_ck",
+	.ops		= &clkops_null,
+	.parent		= &tc_ck.clk,
+	.recalc		= &followparent_recalc,
+	/* Note: On 1510 the frequency follows TC_CK
+	 *
+	 * 16xx version is in MPU clocks.
+	 */
+};
+
+static struct clk tipb_ck = {
+	/* No-idle controlled by "tc_ck" */
+	.name		= "tipb_ck",
+	.ops		= &clkops_null,
+	.parent		= &tc_ck.clk,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk l3_ocpi_ck = {
+	/* No-idle controlled by "tc_ck" */
+	.name		= "l3_ocpi_ck",
+	.ops		= &clkops_generic,
+	.parent		= &tc_ck.clk,
+	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT3),
+	.enable_bit	= EN_OCPI_CK,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk tc1_ck = {
+	.name		= "tc1_ck",
+	.ops		= &clkops_generic,
+	.parent		= &tc_ck.clk,
+	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT3),
+	.enable_bit	= EN_TC1_CK,
+	.recalc		= &followparent_recalc,
+};
+
+/*
+ * FIXME: This clock seems to be necessary but no-one has asked for its
+ * activation.  [ pm.c (SRAM), CCP, Camera ]
+ */
+static struct clk tc2_ck = {
+	.name		= "tc2_ck",
+	.ops		= &clkops_generic,
+	.parent		= &tc_ck.clk,
+	.flags		= ENABLE_ON_INIT,
+	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT3),
+	.enable_bit	= EN_TC2_CK,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk dma_ck = {
+	/* No-idle controlled by "tc_ck" */
+	.name		= "dma_ck",
+	.ops		= &clkops_null,
+	.parent		= &tc_ck.clk,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk dma_lcdfree_ck = {
+	.name		= "dma_lcdfree_ck",
+	.ops		= &clkops_null,
+	.parent		= &tc_ck.clk,
+	.recalc		= &followparent_recalc,
+};
+
+static struct arm_idlect1_clk api_ck = {
+	.clk = {
+		.name		= "api_ck",
+		.ops		= &clkops_generic,
+		.parent		= &tc_ck.clk,
+		.flags		= CLOCK_IDLE_CONTROL,
+		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
+		.enable_bit	= EN_APICK,
+		.recalc		= &followparent_recalc,
+	},
+	.idlect_shift	= 8,
+};
+
+static struct arm_idlect1_clk lb_ck = {
+	.clk = {
+		.name		= "lb_ck",
+		.ops		= &clkops_generic,
+		.parent		= &tc_ck.clk,
+		.flags		= CLOCK_IDLE_CONTROL,
+		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
+		.enable_bit	= EN_LBCK,
+		.recalc		= &followparent_recalc,
+	},
+	.idlect_shift	= 4,
+};
+
+static struct clk rhea1_ck = {
+	.name		= "rhea1_ck",
+	.ops		= &clkops_null,
+	.parent		= &tc_ck.clk,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk rhea2_ck = {
+	.name		= "rhea2_ck",
+	.ops		= &clkops_null,
+	.parent		= &tc_ck.clk,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk lcd_ck_16xx = {
+	.name		= "lcd_ck",
+	.ops		= &clkops_generic,
+	.parent		= &ck_dpll1,
+	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
+	.enable_bit	= EN_LCDCK,
+	.rate_offset	= CKCTL_LCDDIV_OFFSET,
+	.recalc		= &omap1_ckctl_recalc,
+	.round_rate	= omap1_clk_round_rate_ckctl_arm,
+	.set_rate	= omap1_clk_set_rate_ckctl_arm,
+};
+
+static struct arm_idlect1_clk lcd_ck_1510 = {
+	.clk = {
+		.name		= "lcd_ck",
+		.ops		= &clkops_generic,
+		.parent		= &ck_dpll1,
+		.flags		= CLOCK_IDLE_CONTROL,
+		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
+		.enable_bit	= EN_LCDCK,
+		.rate_offset	= CKCTL_LCDDIV_OFFSET,
+		.recalc		= &omap1_ckctl_recalc,
+		.round_rate	= omap1_clk_round_rate_ckctl_arm,
+		.set_rate	= omap1_clk_set_rate_ckctl_arm,
+	},
+	.idlect_shift	= 3,
+};
+
+static struct clk uart1_1510 = {
+	.name		= "uart1_ck",
+	.ops		= &clkops_null,
+	/* Direct from ULPD, no real parent */
+	.parent		= &armper_ck.clk,
+	.rate		= 12000000,
+	.flags		= ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
+	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
+	.enable_bit	= 29,	/* Chooses between 12MHz and 48MHz */
+	.set_rate	= &omap1_set_uart_rate,
+	.recalc		= &omap1_uart_recalc,
+};
+
+static struct uart_clk uart1_16xx = {
+	.clk	= {
+		.name		= "uart1_ck",
+		.ops		= &clkops_uart,
+		/* Direct from ULPD, no real parent */
+		.parent		= &armper_ck.clk,
+		.rate		= 48000000,
+		.flags		= RATE_FIXED | ENABLE_REG_32BIT |
+				  CLOCK_NO_IDLE_PARENT,
+		.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
+		.enable_bit	= 29,
+	},
+	.sysc_addr	= 0xfffb0054,
+};
+
+static struct clk uart2_ck = {
+	.name		= "uart2_ck",
+	.ops		= &clkops_null,
+	/* Direct from ULPD, no real parent */
+	.parent		= &armper_ck.clk,
+	.rate		= 12000000,
+	.flags		= ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
+	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
+	.enable_bit	= 30,	/* Chooses between 12MHz and 48MHz */
+	.set_rate	= &omap1_set_uart_rate,
+	.recalc		= &omap1_uart_recalc,
+};
+
+static struct clk uart3_1510 = {
+	.name		= "uart3_ck",
+	.ops		= &clkops_null,
+	/* Direct from ULPD, no real parent */
+	.parent		= &armper_ck.clk,
+	.rate		= 12000000,
+	.flags		= ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
+	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
+	.enable_bit	= 31,	/* Chooses between 12MHz and 48MHz */
+	.set_rate	= &omap1_set_uart_rate,
+	.recalc		= &omap1_uart_recalc,
+};
+
+static struct uart_clk uart3_16xx = {
+	.clk	= {
+		.name		= "uart3_ck",
+		.ops		= &clkops_uart,
+		/* Direct from ULPD, no real parent */
+		.parent		= &armper_ck.clk,
+		.rate		= 48000000,
+		.flags		= RATE_FIXED | ENABLE_REG_32BIT |
+				  CLOCK_NO_IDLE_PARENT,
+		.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
+		.enable_bit	= 31,
+	},
+	.sysc_addr	= 0xfffb9854,
+};
+
+static struct clk usb_clko = {	/* 6 MHz output on W4_USB_CLKO */
+	.name		= "usb_clko",
+	.ops		= &clkops_generic,
+	/* Direct from ULPD, no parent */
+	.rate		= 6000000,
+	.flags		= RATE_FIXED | ENABLE_REG_32BIT,
+	.enable_reg	= OMAP1_IO_ADDRESS(ULPD_CLOCK_CTRL),
+	.enable_bit	= USB_MCLK_EN_BIT,
+};
+
+static struct clk usb_hhc_ck1510 = {
+	.name		= "usb_hhc_ck",
+	.ops		= &clkops_generic,
+	/* Direct from ULPD, no parent */
+	.rate		= 48000000, /* Actually 2 clocks, 12MHz and 48MHz */
+	.flags		= RATE_FIXED | ENABLE_REG_32BIT,
+	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
+	.enable_bit	= USB_HOST_HHC_UHOST_EN,
+};
+
+static struct clk usb_hhc_ck16xx = {
+	.name		= "usb_hhc_ck",
+	.ops		= &clkops_generic,
+	/* Direct from ULPD, no parent */
+	.rate		= 48000000,
+	/* OTG_SYSCON_2.OTG_PADEN == 0 (not 1510-compatible) */
+	.flags		= RATE_FIXED | ENABLE_REG_32BIT,
+	.enable_reg	= OMAP1_IO_ADDRESS(OTG_BASE + 0x08), /* OTG_SYSCON_2 */
+	.enable_bit	= 8 /* UHOST_EN */,
+};
+
+static struct clk usb_dc_ck = {
+	.name		= "usb_dc_ck",
+	.ops		= &clkops_generic,
+	/* Direct from ULPD, no parent */
+	.rate		= 48000000,
+	.flags		= RATE_FIXED,
+	.enable_reg	= OMAP1_IO_ADDRESS(SOFT_REQ_REG),
+	.enable_bit	= 4,
+};
+
+static struct clk usb_dc_ck7xx = {
+	.name		= "usb_dc_ck",
+	.ops		= &clkops_generic,
+	/* Direct from ULPD, no parent */
+	.rate		= 48000000,
+	.flags		= RATE_FIXED,
+	.enable_reg	= OMAP1_IO_ADDRESS(SOFT_REQ_REG),
+	.enable_bit	= 8,
+};
+
+static struct clk mclk_1510 = {
+	.name		= "mclk",
+	.ops		= &clkops_generic,
+	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
+	.rate		= 12000000,
+	.flags		= RATE_FIXED,
+	.enable_reg	= OMAP1_IO_ADDRESS(SOFT_REQ_REG),
+	.enable_bit	= 6,
+};
+
+static struct clk mclk_16xx = {
+	.name		= "mclk",
+	.ops		= &clkops_generic,
+	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
+	.enable_reg	= OMAP1_IO_ADDRESS(COM_CLK_DIV_CTRL_SEL),
+	.enable_bit	= COM_ULPD_PLL_CLK_REQ,
+	.set_rate	= &omap1_set_ext_clk_rate,
+	.round_rate	= &omap1_round_ext_clk_rate,
+	.init		= &omap1_init_ext_clk,
+};
+
+static struct clk bclk_1510 = {
+	.name		= "bclk",
+	.ops		= &clkops_generic,
+	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
+	.rate		= 12000000,
+	.flags		= RATE_FIXED,
+};
+
+static struct clk bclk_16xx = {
+	.name		= "bclk",
+	.ops		= &clkops_generic,
+	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
+	.enable_reg	= OMAP1_IO_ADDRESS(SWD_CLK_DIV_CTRL_SEL),
+	.enable_bit	= SWD_ULPD_PLL_CLK_REQ,
+	.set_rate	= &omap1_set_ext_clk_rate,
+	.round_rate	= &omap1_round_ext_clk_rate,
+	.init		= &omap1_init_ext_clk,
+};
+
+static struct clk mmc1_ck = {
+	.name		= "mmc_ck",
+	.ops		= &clkops_generic,
+	/* Functional clock is direct from ULPD, interface clock is ARMPER */
+	.parent		= &armper_ck.clk,
+	.rate		= 48000000,
+	.flags		= RATE_FIXED | ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
+	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
+	.enable_bit	= 23,
+};
+
+static struct clk mmc2_ck = {
+	.name		= "mmc_ck",
+	.id		= 1,
+	.ops		= &clkops_generic,
+	/* Functional clock is direct from ULPD, interface clock is ARMPER */
+	.parent		= &armper_ck.clk,
+	.rate		= 48000000,
+	.flags		= RATE_FIXED | ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
+	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
+	.enable_bit	= 20,
+};
+
+static struct clk mmc3_ck = {
+	.name		= "mmc_ck",
+	.id		= 2,
+	.ops		= &clkops_generic,
+	/* Functional clock is direct from ULPD, interface clock is ARMPER */
+	.parent		= &armper_ck.clk,
+	.rate		= 48000000,
+	.flags		= RATE_FIXED | ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
+	.enable_reg	= OMAP1_IO_ADDRESS(SOFT_REQ_REG),
+	.enable_bit	= 12,
+};
+
+static struct clk virtual_ck_mpu = {
+	.name		= "mpu",
+	.ops		= &clkops_null,
+	.parent		= &arm_ck, /* Is smarter alias for */
+	.recalc		= &followparent_recalc,
+	.set_rate	= &omap1_select_table_rate,
+	.round_rate	= &omap1_round_to_table_rate,
+};
+
+/* virtual functional clock domain for I2C. Just for making sure that ARMXOR_CK
+remains active during MPU idle whenever this is enabled */
+static struct clk i2c_fck = {
+	.name		= "i2c_fck",
+	.id		= 1,
+	.ops		= &clkops_null,
+	.flags		= CLOCK_NO_IDLE_PARENT,
+	.parent		= &armxor_ck.clk,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk i2c_ick = {
+	.name		= "i2c_ick",
+	.id		= 1,
+	.ops		= &clkops_null,
+	.flags		= CLOCK_NO_IDLE_PARENT,
+	.parent		= &armper_ck.clk,
+	.recalc		= &followparent_recalc,
+};
+
+/*
+ * clkdev integration
+ */
+
+static struct omap_clk omap_clks[] = {
+	/* non-ULPD clocks */
+	CLK(NULL,	"ck_ref",	&ck_ref,	CK_16XX | CK_1510 | CK_310 | CK_7XX),
+	CLK(NULL,	"ck_dpll1",	&ck_dpll1,	CK_16XX | CK_1510 | CK_310),
+	/* CK_GEN1 clocks */
+	CLK(NULL,	"ck_dpll1out",	&ck_dpll1out.clk, CK_16XX),
+	CLK(NULL,	"ck_sossi",	&sossi_ck,	CK_16XX),
+	CLK(NULL,	"arm_ck",	&arm_ck,	CK_16XX | CK_1510 | CK_310),
+	CLK(NULL,	"armper_ck",	&armper_ck.clk,	CK_16XX | CK_1510 | CK_310),
+	CLK(NULL,	"arm_gpio_ck",	&arm_gpio_ck,	CK_1510 | CK_310),
+	CLK(NULL,	"armxor_ck",	&armxor_ck.clk,	CK_16XX | CK_1510 | CK_310 | CK_7XX),
+	CLK(NULL,	"armtim_ck",	&armtim_ck.clk,	CK_16XX | CK_1510 | CK_310),
+	CLK("omap_wdt",	"fck",		&armwdt_ck.clk,	CK_16XX | CK_1510 | CK_310),
+	CLK("omap_wdt",	"ick",		&armper_ck.clk,	CK_16XX),
+	CLK("omap_wdt", "ick",		&dummy_ck,	CK_1510 | CK_310),
+	CLK(NULL,	"arminth_ck",	&arminth_ck1510, CK_1510 | CK_310),
+	CLK(NULL,	"arminth_ck",	&arminth_ck16xx, CK_16XX),
+	/* CK_GEN2 clocks */
+	CLK(NULL,	"dsp_ck",	&dsp_ck,	CK_16XX | CK_1510 | CK_310),
+	CLK(NULL,	"dspmmu_ck",	&dspmmu_ck,	CK_16XX | CK_1510 | CK_310),
+	CLK(NULL,	"dspper_ck",	&dspper_ck,	CK_16XX | CK_1510 | CK_310),
+	CLK(NULL,	"dspxor_ck",	&dspxor_ck,	CK_16XX | CK_1510 | CK_310),
+	CLK(NULL,	"dsptim_ck",	&dsptim_ck,	CK_16XX | CK_1510 | CK_310),
+	/* CK_GEN3 clocks */
+	CLK(NULL,	"tc_ck",	&tc_ck.clk,	CK_16XX | CK_1510 | CK_310 | CK_7XX),
+	CLK(NULL,	"tipb_ck",	&tipb_ck,	CK_1510 | CK_310),
+	CLK(NULL,	"l3_ocpi_ck",	&l3_ocpi_ck,	CK_16XX | CK_7XX),
+	CLK(NULL,	"tc1_ck",	&tc1_ck,	CK_16XX),
+	CLK(NULL,	"tc2_ck",	&tc2_ck,	CK_16XX),
+	CLK(NULL,	"dma_ck",	&dma_ck,	CK_16XX | CK_1510 | CK_310),
+	CLK(NULL,	"dma_lcdfree_ck", &dma_lcdfree_ck, CK_16XX),
+	CLK(NULL,	"api_ck",	&api_ck.clk,	CK_16XX | CK_1510 | CK_310),
+	CLK(NULL,	"lb_ck",	&lb_ck.clk,	CK_1510 | CK_310),
+	CLK(NULL,	"rhea1_ck",	&rhea1_ck,	CK_16XX),
+	CLK(NULL,	"rhea2_ck",	&rhea2_ck,	CK_16XX),
+	CLK(NULL,	"lcd_ck",	&lcd_ck_16xx,	CK_16XX | CK_7XX),
+	CLK(NULL,	"lcd_ck",	&lcd_ck_1510.clk, CK_1510 | CK_310),
+	/* ULPD clocks */
+	CLK(NULL,	"uart1_ck",	&uart1_1510,	CK_1510 | CK_310),
+	CLK(NULL,	"uart1_ck",	&uart1_16xx.clk, CK_16XX),
+	CLK(NULL,	"uart2_ck",	&uart2_ck,	CK_16XX | CK_1510 | CK_310),
+	CLK(NULL,	"uart3_ck",	&uart3_1510,	CK_1510 | CK_310),
+	CLK(NULL,	"uart3_ck",	&uart3_16xx.clk, CK_16XX),
+	CLK(NULL,	"usb_clko",	&usb_clko,	CK_16XX | CK_1510 | CK_310),
+	CLK(NULL,	"usb_hhc_ck",	&usb_hhc_ck1510, CK_1510 | CK_310),
+	CLK(NULL,	"usb_hhc_ck",	&usb_hhc_ck16xx, CK_16XX),
+	CLK(NULL,	"usb_dc_ck",	&usb_dc_ck,	CK_16XX),
+	CLK(NULL,	"usb_dc_ck",	&usb_dc_ck7xx,	CK_7XX),
+	CLK(NULL,	"mclk",		&mclk_1510,	CK_1510 | CK_310),
+	CLK(NULL,	"mclk",		&mclk_16xx,	CK_16XX),
+	CLK(NULL,	"bclk",		&bclk_1510,	CK_1510 | CK_310),
+	CLK(NULL,	"bclk",		&bclk_16xx,	CK_16XX),
+	CLK("mmci-omap.0", "fck",	&mmc1_ck,	CK_16XX | CK_1510 | CK_310),
+	CLK("mmci-omap.0", "fck",	&mmc3_ck,	CK_7XX),
+	CLK("mmci-omap.0", "ick",	&armper_ck.clk,	CK_16XX | CK_1510 | CK_310 | CK_7XX),
+	CLK("mmci-omap.1", "fck",	&mmc2_ck,	CK_16XX),
+	CLK("mmci-omap.1", "ick",	&armper_ck.clk,	CK_16XX),
+	/* Virtual clocks */
+	CLK(NULL,	"mpu",		&virtual_ck_mpu, CK_16XX | CK_1510 | CK_310),
+	CLK("i2c_omap.1", "fck",	&i2c_fck,	CK_16XX | CK_1510 | CK_310),
+	CLK("i2c_omap.1", "ick",	&i2c_ick,	CK_16XX),
+	CLK("i2c_omap.1", "ick",	&dummy_ck,	CK_1510 | CK_310),
+	CLK("omap_uwire", "fck",	&armxor_ck.clk,	CK_16XX | CK_1510 | CK_310),
+	CLK("omap-mcbsp.1", "ick",	&dspper_ck,	CK_16XX),
+	CLK("omap-mcbsp.1", "ick",	&dummy_ck,	CK_1510 | CK_310),
+	CLK("omap-mcbsp.2", "ick",	&armper_ck.clk,	CK_16XX),
+	CLK("omap-mcbsp.2", "ick",	&dummy_ck,	CK_1510 | CK_310),
+	CLK("omap-mcbsp.3", "ick",	&dspper_ck,	CK_16XX),
+	CLK("omap-mcbsp.3", "ick",	&dummy_ck,	CK_1510 | CK_310),
+	CLK("omap-mcbsp.1", "fck",	&dspxor_ck,	CK_16XX | CK_1510 | CK_310),
+	CLK("omap-mcbsp.2", "fck",	&armper_ck.clk,	CK_16XX | CK_1510 | CK_310),
+	CLK("omap-mcbsp.3", "fck",	&dspxor_ck,	CK_16XX | CK_1510 | CK_310),
+};
+
+/*
+ * init
+ */
+
+static struct clk_functions omap1_clk_functions __initdata = {
+	.clk_enable		= omap1_clk_enable,
+	.clk_disable		= omap1_clk_disable,
+	.clk_round_rate		= omap1_clk_round_rate,
+	.clk_set_rate		= omap1_clk_set_rate,
+	.clk_disable_unused	= omap1_clk_disable_unused,
+};
+
+int __init omap1_clk_init(void)
+{
+	struct omap_clk *c;
+	const struct omap_clock_config *info;
+	int crystal_type = 0; /* Default 12 MHz */
+	u32 reg, cpu_mask;
+
+#ifdef CONFIG_DEBUG_LL
+	/*
+	 * Resets some clocks that may be left on from bootloader,
+	 * but leaves serial clocks on.
+	 */
+	omap_writel(0x3 << 29, MOD_CONF_CTRL_0);
+#endif
+
+	/* USB_REQ_EN will be disabled later if necessary (usb_dc_ck) */
+	reg = omap_readw(SOFT_REQ_REG) & (1 << 4);
+	omap_writew(reg, SOFT_REQ_REG);
+	if (!cpu_is_omap15xx())
+		omap_writew(0, SOFT_REQ_REG2);
+
+	clk_init(&omap1_clk_functions);
+
+	/* By default all idlect1 clocks are allowed to idle */
+	arm_idlect1_mask = ~0;
+
+	for (c = omap_clks; c < omap_clks + ARRAY_SIZE(omap_clks); c++)
+		clk_preinit(c->lk.clk);
+
+	cpu_mask = 0;
+	if (cpu_is_omap16xx())
+		cpu_mask |= CK_16XX;
+	if (cpu_is_omap1510())
+		cpu_mask |= CK_1510;
+	if (cpu_is_omap7xx())
+		cpu_mask |= CK_7XX;
+	if (cpu_is_omap310())
+		cpu_mask |= CK_310;
+
+	for (c = omap_clks; c < omap_clks + ARRAY_SIZE(omap_clks); c++)
+		if (c->cpu & cpu_mask) {
+			clkdev_add(&c->lk);
+			clk_register(c->lk.clk);
+		}
+
+	/* Pointers to these clocks are needed by code in clock.c */
+	api_ck_p = clk_get(NULL, "api_ck");
+	ck_dpll1_p = clk_get(NULL, "ck_dpll1");
+	ck_ref_p = clk_get(NULL, "ck_ref");
+
+	info = omap_get_config(OMAP_TAG_CLOCK, struct omap_clock_config);
+	if (info != NULL) {
+		if (!cpu_is_omap15xx())
+			crystal_type = info->system_clock_type;
+	}
+
+#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
+	ck_ref.rate = 13000000;
+#elif defined(CONFIG_ARCH_OMAP16XX)
+	if (crystal_type == 2)
+		ck_ref.rate = 19200000;
+#endif
+
+	pr_info("Clocks: ARM_SYSST: 0x%04x DPLL_CTL: 0x%04x ARM_CKCTL: "
+		"0x%04x\n", omap_readw(ARM_SYSST), omap_readw(DPLL_CTL),
+		omap_readw(ARM_CKCTL));
+
+	/* We want to be in syncronous scalable mode */
+	omap_writew(0x1000, ARM_SYSST);
+
+#ifdef CONFIG_OMAP_CLOCKS_SET_BY_BOOTLOADER
+	/* Use values set by bootloader. Determine PLL rate and recalculate
+	 * dependent clocks as if kernel had changed PLL or divisors.
+	 */
+	{
+		unsigned pll_ctl_val = omap_readw(DPLL_CTL);
+
+		ck_dpll1.rate = ck_ref.rate; /* Base xtal rate */
+		if (pll_ctl_val & 0x10) {
+			/* PLL enabled, apply multiplier and divisor */
+			if (pll_ctl_val & 0xf80)
+				ck_dpll1.rate *= (pll_ctl_val & 0xf80) >> 7;
+			ck_dpll1.rate /= ((pll_ctl_val & 0x60) >> 5) + 1;
+		} else {
+			/* PLL disabled, apply bypass divisor */
+			switch (pll_ctl_val & 0xc) {
+			case 0:
+				break;
+			case 0x4:
+				ck_dpll1.rate /= 2;
+				break;
+			default:
+				ck_dpll1.rate /= 4;
+				break;
+			}
+		}
+	}
+#else
+	/* Find the highest supported frequency and enable it */
+	if (omap1_select_table_rate(&virtual_ck_mpu, ~0)) {
+		printk(KERN_ERR "System frequencies not set. Check your config.\n");
+		/* Guess sane values (60MHz) */
+		omap_writew(0x2290, DPLL_CTL);
+		omap_writew(cpu_is_omap7xx() ? 0x3005 : 0x1005, ARM_CKCTL);
+		ck_dpll1.rate = 60000000;
+	}
+#endif
+	propagate_rate(&ck_dpll1);
+	/* Cache rates for clocks connected to ck_ref (not dpll1) */
+	propagate_rate(&ck_ref);
+	printk(KERN_INFO "Clocking rate (xtal/DPLL1/MPU): "
+		"%ld.%01ld/%ld.%01ld/%ld.%01ld MHz\n",
+	       ck_ref.rate / 1000000, (ck_ref.rate / 100000) % 10,
+	       ck_dpll1.rate / 1000000, (ck_dpll1.rate / 100000) % 10,
+	       arm_ck.rate / 1000000, (arm_ck.rate / 100000) % 10);
+
+#if defined(CONFIG_MACH_OMAP_PERSEUS2) || defined(CONFIG_MACH_OMAP_FSAMPLE)
+	/* Select slicer output as OMAP input clock */
+	omap_writew(omap_readw(OMAP7XX_PCC_UPLD_CTRL) & ~0x1, OMAP7XX_PCC_UPLD_CTRL);
+#endif
+
+	/* Amstrad Delta wants BCLK high when inactive */
+	if (machine_is_ams_delta())
+		omap_writel(omap_readl(ULPD_CLOCK_CTRL) |
+				(1 << SDW_MCLK_INV_BIT),
+				ULPD_CLOCK_CTRL);
+
+	/* Turn off DSP and ARM_TIMXO. Make sure ARM_INTHCK is not divided */
+	/* (on 730, bit 13 must not be cleared) */
+	if (cpu_is_omap7xx())
+		omap_writew(omap_readw(ARM_CKCTL) & 0x2fff, ARM_CKCTL);
+	else
+		omap_writew(omap_readw(ARM_CKCTL) & 0x0fff, ARM_CKCTL);
+
+	/* Put DSP/MPUI into reset until needed */
+	omap_writew(0, ARM_RSTCT1);
+	omap_writew(1, ARM_RSTCT2);
+	omap_writew(0x400, ARM_IDLECT1);
+
+	/*
+	 * According to OMAP5910 Erratum SYS_DMA_1, bit DMACK_REQ (bit 8)
+	 * of the ARM_IDLECT2 register must be set to zero. The power-on
+	 * default value of this bit is one.
+	 */
+	omap_writew(0x0000, ARM_IDLECT2);	/* Turn LCD clock off also */
+
+	/*
+	 * Only enable those clocks we will need, let the drivers
+	 * enable other clocks as necessary
+	 */
+	clk_enable(&armper_ck.clk);
+	clk_enable(&armxor_ck.clk);
+	clk_enable(&armtim_ck.clk); /* This should be done by timer code */
+
+	if (cpu_is_omap15xx())
+		clk_enable(&arm_gpio_ck);
+
+	return 0;
+}
diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
index 2a6d68a..d9b8d82 100644
--- a/arch/arm/mach-omap1/io.c
+++ b/arch/arm/mach-omap1/io.c
@@ -18,7 +18,8 @@
 #include <plat/mux.h>
 #include <plat/tc.h>
 
-extern int omap1_clk_init(void);
+#include "clock.h"
+
 extern void omap_check_revision(void);
 extern void omap_sram_init(void);
 extern void omapfb_reserve_sdram(void);
diff --git a/arch/arm/mach-omap1/opp.h b/arch/arm/mach-omap1/opp.h
new file mode 100644
index 0000000..07074d7
--- /dev/null
+++ b/arch/arm/mach-omap1/opp.h
@@ -0,0 +1,28 @@
+/*
+ *  linux/arch/arm/mach-omap1/opp.h
+ *
+ *  Copyright (C) 2004 - 2005 Nokia corporation
+ *  Written by Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
+ *  Based on clocks.h by Tony Lindgren, Gordon McNutt and RidgeRun, Inc
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ARCH_ARM_MACH_OMAP1_OPP_H
+#define __ARCH_ARM_MACH_OMAP1_OPP_H
+
+#include <linux/types.h>
+
+struct mpu_rate {
+	unsigned long		rate;
+	unsigned long		xtal;
+	unsigned long		pll_rate;
+	__u16			ckctl_val;
+	__u16			dpllctl_val;
+};
+
+extern struct mpu_rate omap1_rate_table[];
+
+#endif
diff --git a/arch/arm/mach-omap1/opp_data.c b/arch/arm/mach-omap1/opp_data.c
new file mode 100644
index 0000000..75a5465
--- /dev/null
+++ b/arch/arm/mach-omap1/opp_data.c
@@ -0,0 +1,59 @@
+/*
+ *  linux/arch/arm/mach-omap1/opp_data.c
+ *
+ *  Copyright (C) 2004 - 2005 Nokia corporation
+ *  Written by Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
+ *  Based on clocks.h by Tony Lindgren, Gordon McNutt and RidgeRun, Inc
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "opp.h"
+
+/*-------------------------------------------------------------------------
+ * Omap1 MPU rate table
+ *-------------------------------------------------------------------------*/
+struct mpu_rate omap1_rate_table[] = {
+	/* MPU MHz, xtal MHz, dpll1 MHz, CKCTL, DPLL_CTL
+	 * NOTE: Comment order here is different from bits in CKCTL value:
+	 * armdiv, dspdiv, dspmmu, tcdiv, perdiv, lcddiv
+	 */
+#if defined(CONFIG_OMAP_ARM_216MHZ)
+	{ 216000000, 12000000, 216000000, 0x050d, 0x2910 }, /* 1/1/2/2/2/8 */
+#endif
+#if defined(CONFIG_OMAP_ARM_195MHZ)
+	{ 195000000, 13000000, 195000000, 0x050e, 0x2790 }, /* 1/1/2/2/4/8 */
+#endif
+#if defined(CONFIG_OMAP_ARM_192MHZ)
+	{ 192000000, 19200000, 192000000, 0x050f, 0x2510 }, /* 1/1/2/2/8/8 */
+	{ 192000000, 12000000, 192000000, 0x050f, 0x2810 }, /* 1/1/2/2/8/8 */
+	{  96000000, 12000000, 192000000, 0x055f, 0x2810 }, /* 2/2/2/2/8/8 */
+	{  48000000, 12000000, 192000000, 0x0baf, 0x2810 }, /* 4/4/4/8/8/8 */
+	{  24000000, 12000000, 192000000, 0x0fff, 0x2810 }, /* 8/8/8/8/8/8 */
+#endif
+#if defined(CONFIG_OMAP_ARM_182MHZ)
+	{ 182000000, 13000000, 182000000, 0x050e, 0x2710 }, /* 1/1/2/2/4/8 */
+#endif
+#if defined(CONFIG_OMAP_ARM_168MHZ)
+	{ 168000000, 12000000, 168000000, 0x010f, 0x2710 }, /* 1/1/1/2/8/8 */
+#endif
+#if defined(CONFIG_OMAP_ARM_150MHZ)
+	{ 150000000, 12000000, 150000000, 0x010a, 0x2cb0 }, /* 1/1/1/2/4/4 */
+#endif
+#if defined(CONFIG_OMAP_ARM_120MHZ)
+	{ 120000000, 12000000, 120000000, 0x010a, 0x2510 }, /* 1/1/1/2/4/4 */
+#endif
+#if defined(CONFIG_OMAP_ARM_96MHZ)
+	{  96000000, 12000000,  96000000, 0x0005, 0x2410 }, /* 1/1/1/1/2/2 */
+#endif
+#if defined(CONFIG_OMAP_ARM_60MHZ)
+	{  60000000, 12000000,  60000000, 0x0005, 0x2290 }, /* 1/1/1/1/2/2 */
+#endif
+#if defined(CONFIG_OMAP_ARM_30MHZ)
+	{  30000000, 12000000,  60000000, 0x0555, 0x2290 }, /* 2/2/2/2/2/2 */
+#endif
+	{ 0, 0, 0, 0, 0 },
+};
+
diff --git a/arch/arm/plat-omap/include/plat/clkdev_omap.h b/arch/arm/plat-omap/include/plat/clkdev_omap.h
index 97b8c12..96e5d38 100644
--- a/arch/arm/plat-omap/include/plat/clkdev_omap.h
+++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
@@ -11,8 +11,8 @@
 #include <asm/clkdev.h>
 
 struct omap_clk {
-	u32		cpu;
-	struct clk_lookup lk;
+	u16				cpu;
+	struct clk_lookup		lk;
 };
 
 #define CLK(dev, con, ck, cp) 		\
@@ -26,11 +26,15 @@ struct omap_clk {
 	}
 
 
-#define CK_243X		(1 << 0)
-#define CK_242X		(1 << 1)
-#define CK_343X		(1 << 2)
-#define CK_3430ES1	(1 << 3)
-#define CK_3430ES2	(1 << 4)
+#define CK_310		(1 << 0)
+#define CK_7XX		(1 << 1)
+#define CK_1510		(1 << 2)
+#define CK_16XX		(1 << 3)
+#define CK_243X		(1 << 4)
+#define CK_242X		(1 << 5)
+#define CK_343X		(1 << 6)
+#define CK_3430ES1	(1 << 7)
+#define CK_3430ES2	(1 << 8)
 
 
 #endif
