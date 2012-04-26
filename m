From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH-V3 3/3] ARM: OMAP3+: clock33xx: Add AM33XX clock tree
 data
Date: Thu, 26 Apr 2012 02:41:41 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204260241000.10308@utopia.booyaka.com>
References: <1333458578-23073-1-git-send-email-hvaibhav@ti.com> <1333458578-23073-4-git-send-email-hvaibhav@ti.com> <alpine.DEB.2.00.1204241857260.24864@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83E9FD175@DBDE01.ent.ti.com> <4F97B891.1020601@ti.com>
 <79CD15C6BA57404B839C016229A409A83E9FD707@DBDE01.ent.ti.com> <4F97E243.6000500@ti.com> <79CD15C6BA57404B839C016229A409A83E9FDA47@DBDE01.ent.ti.com> <4F97EF11.4020300@ti.com> <79CD15C6BA57404B839C016229A409A83E9FDAE7@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1204250755020.29696@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83E9FDD1D@DBDE01.ent.ti.com> <alpine.DEB.2.00.1204260226060.10308@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34084 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754211Ab2DZIlm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Apr 2012 04:41:42 -0400
In-Reply-To: <alpine.DEB.2.00.1204260226060.10308@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Mohammed, Afzal" <afzal@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, 26 Apr 2012, Paul Walmsley wrote:

> I have taken a first pass at this.  The updated patch is below.  It has 
> been compile-tested only.  Could you please review this and try testing 
> it?  It is also in the branch 'am33xx_support_3.5' of 
> git://git.pwsan.com/linux-2.6.

Here is the patch.


- Paul

From: Vaibhav Hiremath <hvaibhav@ti.com>
Date: Wed, 18 Apr 2012 15:46:53 -0600
Subject: [PATCH] ARM: OMAP3+: clock33xx: Add AM33XX clock tree data

AM33XX clock implementation is different than any existing OMAP
family of devices. Although DPLL module is similar to OMAP4
device, but the usage is very much different than OMAP4.
AM33XX has different peripheral set and each module gets
integrated to the clock framework differently than OMAP
family of devices.

This patch adds full Clock tree data for AM33XX family
of devices and also integrates it into existing OMAP framework.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
CC: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
[paul@pwsan.com: renamed "clk_sel" to "clksel" to conform with other
 OMAPs; dropped leaf modulemode clock nodes; dropped empty interface
 clock nodes; share common clksel_rate blocks between OMAP44xx and
 AM33xx; added AM33XX_CONTROL_STATUS_SYSBOOT1_MASK/SHIFT macros; fixed
 some control.h formatting; fixed some multiline comment formatting;
 moved the non-inlineable function am33xx_init_timer_parent() from
 clock33xx.h to clock33xx.c; added .set_rate & .round_rate function pointers
 for many clksel clocks; added .init function pointer to many clksel clocks;
 changed .recalc function pointer for many clksel clocks; timer fcks
 have been split from timer mux control clocks]
---
 arch/arm/mach-omap2/Makefile                  |    1 +
 arch/arm/mach-omap2/clock.h                   |   14 +
 arch/arm/mach-omap2/clock33xx_data.c          | 1159 +++++++++++++++++++++++++
 arch/arm/mach-omap2/clock3xxx_data.c          |   20 +-
 arch/arm/mach-omap2/clock44xx_data.c          |   72 --
 arch/arm/mach-omap2/clock_common_data.c       |   77 ++
 arch/arm/mach-omap2/control.h                 |   32 +-
 arch/arm/mach-omap2/io.c                      |    3 +-
 arch/arm/plat-omap/include/plat/clkdev_omap.h |    1 +
 9 files changed, 1274 insertions(+), 105 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clock33xx_data.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 0fb1eaf..c20498f 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -156,6 +156,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= $(clock-common) clock3xxx.o \
 					   clock3517.o clock36xx.o \
 					   dpll3xxx.o clock3xxx_data.o \
 					   clkt_iclk.o
+obj-$(CONFIG_SOC_OMAPAM33XX)		+= clock33xx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(clock-common) clock44xx_data.o \
 					   dpll3xxx.o dpll44xx.o
 
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index b8c2a68..afb0eb4 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -163,4 +163,18 @@ extern const struct clkops clkops_omap3_noncore_dpll_ops;
 extern const struct clkops clkops_omap3_core_dpll_ops;
 extern const struct clkops clkops_omap4_dpllmx_ops;
 
+/* clksel_rate blocks shared between OMAP44xx and AM33xx */
+extern const struct clksel_rate div_1_0_rates[];
+extern const struct clksel_rate div_1_1_rates[];
+extern const struct clksel_rate div_1_2_rates[];
+extern const struct clksel_rate div_1_3_rates[];
+extern const struct clksel_rate div_1_4_rates[];
+extern const struct clksel_rate div31_1to31_rates[];
+
+/* clocks shared between various OMAP SoCs */
+extern struct clk virt_19200000_ck;
+extern struct clk virt_26000000_ck;
+
+extern int am33xx_clk_init(void);
+
 #endif
diff --git a/arch/arm/mach-omap2/clock33xx_data.c b/arch/arm/mach-omap2/clock33xx_data.c
new file mode 100644
index 0000000..02854e2
--- /dev/null
+++ b/arch/arm/mach-omap2/clock33xx_data.c
@@ -0,0 +1,1159 @@
+/*
+ * AM33XX Clock data
+ *
+ * Copyright (C) 2011-2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Vaibhav Hiremath <hvaibhav@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/clk.h>
+#include <plat/clkdev_omap.h>
+
+#include "iomap.h"
+#include "control.h"
+#include "clock.h"
+#include "cm.h"
+#include "cm33xx.h"
+#include "cm-regbits-33xx.h"
+#include "prm.h"
+
+/* Maximum DPLL multiplier, divider values for AM33XX */
+#define AM33XX_MAX_DPLL_MULT		2047
+#define AM33XX_MAX_DPLL_DIV		128
+
+/* Modulemode control */
+#define AM33XX_MODULEMODE_HWCTRL	0
+#define AM33XX_MODULEMODE_SWCTRL	1
+
+#warning XXX What is clkdiv32k?  Is this a module or a clock?  It appears to be a clock, so why does it need a modulemode field?  XXX How is this division implemented?  It appears to be an M,N counter.  It has a clksel correspondence in the SCM.  At OPP100 M,N is 64,46875.  At OPP50 they are presumably 32,46875.
+#warning XXX add clkdm_name fields to clocks
+
+/*
+ * TRM ERRATA: Timer 3 & 6 default parent (TCLKIN) may not be always
+ * physically present, in such a case HWMOD enabling of clock would be
+ * failure with default parent. And timer probe thinks clock is
+ * already enabled, this leads to crash upon accessing timer 3 & 6
+ * registers in probe.  Fix by setting parent of both these timers to
+ * master oscillator clock.
+ *
+ * XXX This should be fixed by switching to a known-available clock
+ * source either during PRCM initialization, or during hwmod reset.
+ */
+static void am33xx_init_timer_parent(struct clk *clk)
+{
+	omap2_clksel_set_parent(clk, clk->parent);
+}
+
+/* Root clocks */
+static struct clk clk_32768_ck = {
+	.name		= "clk_32768_ck",
+	.rate		= 32768,
+	.ops		= &clkops_null,
+};
+
+/* On-Chip 32KHz RC OSC */
+static struct clk clk_rc32k_ck = {
+	.name		= "clk_rc32k_ck",
+	.rate		= 32000,
+	.ops		= &clkops_null,
+};
+
+/* Crystal input clks */
+static struct clk virt_24m_ck = {
+	.name		= "virt_24m_ck",
+	.rate		= 24000000,
+	.ops		= &clkops_null,
+};
+
+static struct clk virt_25m_ck = {
+	.name		= "virt_25m_ck",
+	.rate		= 25000000,
+	.ops		= &clkops_null,
+};
+
+static struct clk tclkin_ck = {
+	.name		= "tclkin_ck",
+	.rate		= 12000000,
+	.ops		= &clkops_null,
+};
+
+/* Oscillator clock */
+/* 19.2, 24, 25 or 26 MHz */
+static const struct clksel sys_clkin_sel[] = {
+	{ .parent = &virt_19200000_ck, .rates = div_1_0_rates },
+	{ .parent = &virt_24m_ck, .rates = div_1_1_rates },
+	{ .parent = &virt_25m_ck, .rates = div_1_2_rates },
+	{ .parent = &virt_26000000_ck, .rates = div_1_3_rates },
+	{ .parent = NULL },
+};
+
+/* sys_clk_in */
+/* adc_tsc_fck functional clock */
+static struct clk sys_clkin_ck = {
+	.name		= "sys_clkin_ck",
+	.parent		= &virt_24m_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= AM33XX_CTRL_REGADDR(AM33XX_CONTROL_STATUS),
+	.clksel_mask	= AM33XX_CONTROL_STATUS_SYSBOOT1_MASK,
+	.clksel		= sys_clkin_sel,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+/* DPLL_CORE */
+static struct dpll_data dpll_core_dd = {
+	.mult_div1_reg	= AM33XX_CM_CLKSEL_DPLL_CORE,
+	.clk_bypass	= &sys_clkin_ck,
+	.clk_ref	= &sys_clkin_ck,
+	.control_reg	= AM33XX_CM_CLKMODE_DPLL_CORE,
+	.modes		= (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
+	.idlest_reg	= AM33XX_CM_IDLEST_DPLL_CORE,
+	.mult_mask	= AM33XX_DPLL_MULT_MASK,
+	.div1_mask	= AM33XX_DPLL_DIV_MASK,
+	.enable_mask	= AM33XX_DPLL_EN_MASK,
+	.idlest_mask	= AM33XX_ST_DPLL_CLK_MASK,
+	.max_multiplier	= AM33XX_MAX_DPLL_MULT,
+	.max_divider	= AM33XX_MAX_DPLL_DIV,
+	.min_divider	= 1,
+};
+
+/* CLKDCOLDO output */
+static struct clk dpll_core_ck = {
+	.name		= "dpll_core_ck",
+	.parent		= &sys_clkin_ck,
+	.dpll_data	= &dpll_core_dd,
+	.init		= &omap2_init_dpll_parent,
+	.ops		= &clkops_omap3_core_dpll_ops,
+	.recalc		= &omap3_dpll_recalc,
+};
+
+static struct clk dpll_core_x2_ck = {
+	.name		= "dpll_core_x2_ck",
+	.parent		= &dpll_core_ck,
+	.flags		= CLOCK_CLKOUTX2,
+	.ops		= &clkops_null,
+	.recalc		= &omap3_clkoutx2_recalc,
+};
+
+static const struct clksel dpll_core_m4_div[] = {
+	{ .parent = &dpll_core_x2_ck, .rates = div31_1to31_rates },
+	{ .parent = NULL },
+};
+
+/* lcdc, timer interface clock */
+static struct clk dpll_core_m4_ck = {
+	.name		= "dpll_core_m4_ck",
+	.parent		= &dpll_core_x2_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel		= dpll_core_m4_div,
+	.clksel_reg	= AM33XX_CM_DIV_M4_DPLL_CORE,
+	.clksel_mask	= AM33XX_HSDIVIDER_CLKOUT1_DIV_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
+};
+
+static const struct clksel dpll_core_m5_div[] = {
+	{ .parent = &dpll_core_x2_ck, .rates = div31_1to31_rates },
+	{ .parent = NULL },
+};
+
+static struct clk dpll_core_m5_ck = {
+	.name		= "dpll_core_m5_ck",
+	.parent		= &dpll_core_x2_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel		= dpll_core_m5_div,
+	.clksel_reg	= AM33XX_CM_DIV_M5_DPLL_CORE,
+	.clksel_mask	= AM33XX_HSDIVIDER_CLKOUT2_DIV_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
+};
+
+static const struct clksel dpll_core_m6_div[] = {
+	{ .parent = &dpll_core_x2_ck, .rates = div31_1to31_rates },
+	{ .parent = NULL },
+};
+
+static struct clk dpll_core_m6_ck = {
+	.name		= "dpll_core_m6_ck",
+	.parent		= &dpll_core_x2_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel		= dpll_core_m6_div,
+	.clksel_reg	= AM33XX_CM_DIV_M6_DPLL_CORE,
+	.clksel_mask	= AM33XX_HSDIVIDER_CLKOUT3_DIV_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
+};
+
+/* DPLL_MPU */
+static struct dpll_data dpll_mpu_dd = {
+	.mult_div1_reg	= AM33XX_CM_CLKSEL_DPLL_MPU,
+	.clk_bypass	= &sys_clkin_ck,
+	.clk_ref	= &sys_clkin_ck,
+	.control_reg	= AM33XX_CM_CLKMODE_DPLL_MPU,
+	.modes		= (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
+	.idlest_reg	= AM33XX_CM_IDLEST_DPLL_MPU,
+	.mult_mask	= AM33XX_DPLL_MULT_MASK,
+	.div1_mask	= AM33XX_DPLL_DIV_MASK,
+	.enable_mask	= AM33XX_DPLL_EN_MASK,
+	.idlest_mask	= AM33XX_ST_DPLL_CLK_MASK,
+	.max_multiplier	= AM33XX_MAX_DPLL_MULT,
+	.max_divider	= AM33XX_MAX_DPLL_DIV,
+	.min_divider	= 1,
+};
+
+/* CLKOUT: fdpll/M2 */
+static struct clk dpll_mpu_ck = {
+	.name		= "dpll_mpu_ck",
+	.parent		= &sys_clkin_ck,
+	.dpll_data	= &dpll_mpu_dd,
+	.init		= &omap2_init_dpll_parent,
+	.ops		= &clkops_omap3_noncore_dpll_ops,
+	.recalc		= &omap3_dpll_recalc,
+	.round_rate	= &omap2_dpll_round_rate,
+	.set_rate	= &omap3_noncore_dpll_set_rate,
+};
+
+/*
+ * TODO: Add clksel here (sys_clkin, CORE_CLKOUTM6, PER_CLKOUTM2
+ * and ALT_CLK1/2)
+ */
+static const struct clksel dpll_mpu_m2_div[] = {
+	{ .parent = &dpll_mpu_ck, .rates = div31_1to31_rates },
+	{ .parent = NULL },
+};
+
+static struct clk dpll_mpu_m2_ck = {
+	.name		= "dpll_mpu_m2_ck",
+	.parent		= &dpll_mpu_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel		= dpll_mpu_m2_div,
+	.clksel_reg	= AM33XX_CM_DIV_M2_DPLL_MPU,
+	.clksel_mask	= AM33XX_DPLL_CLKOUT_DIV_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
+};
+
+/* DPLL_DDR */
+static struct dpll_data dpll_ddr_dd = {
+	.mult_div1_reg	= AM33XX_CM_CLKSEL_DPLL_DDR,
+	.clk_bypass	= &sys_clkin_ck,
+	.clk_ref	= &sys_clkin_ck,
+	.control_reg	= AM33XX_CM_CLKMODE_DPLL_DDR,
+	.modes		= (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
+	.idlest_reg	= AM33XX_CM_IDLEST_DPLL_DDR,
+	.mult_mask	= AM33XX_DPLL_MULT_MASK,
+	.div1_mask	= AM33XX_DPLL_DIV_MASK,
+	.enable_mask	= AM33XX_DPLL_EN_MASK,
+	.idlest_mask	= AM33XX_ST_DPLL_CLK_MASK,
+	.max_multiplier	= AM33XX_MAX_DPLL_MULT,
+	.max_divider	= AM33XX_MAX_DPLL_DIV,
+	.min_divider	= 1,
+};
+
+/* CLKOUT: fdpll/M2 */
+static struct clk dpll_ddr_ck = {
+	.name		= "dpll_ddr_ck",
+	.parent		= &sys_clkin_ck,
+	.dpll_data	= &dpll_ddr_dd,
+	.init		= &omap2_init_dpll_parent,
+	.ops		= &clkops_null,
+	.recalc		= &omap3_dpll_recalc,
+};
+
+/*
+ * TODO: Add clksel here (sys_clkin, CORE_CLKOUTM6, PER_CLKOUTM2
+ * and ALT_CLK1/2)
+ */
+static const struct clksel dpll_ddr_m2_div[] = {
+	{ .parent = &dpll_ddr_ck, .rates = div31_1to31_rates },
+	{ .parent = NULL },
+};
+
+static struct clk dpll_ddr_m2_ck = {
+	.name		= "dpll_ddr_m2_ck",
+	.parent		= &dpll_ddr_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel		= dpll_ddr_m2_div,
+	.clksel_reg	= AM33XX_CM_DIV_M2_DPLL_DDR,
+	.clksel_mask	= AM33XX_DPLL_CLKOUT_DIV_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
+};
+
+/* emif_fck functional clock */
+static struct clk dpll_ddr_m2_div2_ck = {
+	.name		= "dpll_ddr_m2_div2_ck",
+	.parent		= &dpll_ddr_m2_ck,
+	.ops		= &clkops_omap2_dflt,
+	.fixed_div	= 2,
+	.recalc		= &omap_fixed_divisor_recalc,
+};
+
+/* DPLL_DISP */
+static struct dpll_data dpll_disp_dd = {
+	.mult_div1_reg	= AM33XX_CM_CLKSEL_DPLL_DISP,
+	.clk_bypass	= &sys_clkin_ck,
+	.clk_ref	= &sys_clkin_ck,
+	.control_reg	= AM33XX_CM_CLKMODE_DPLL_DISP,
+	.modes		= (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
+	.idlest_reg	= AM33XX_CM_IDLEST_DPLL_DISP,
+	.mult_mask	= AM33XX_DPLL_MULT_MASK,
+	.div1_mask	= AM33XX_DPLL_DIV_MASK,
+	.enable_mask	= AM33XX_DPLL_EN_MASK,
+	.idlest_mask	= AM33XX_ST_DPLL_CLK_MASK,
+	.max_multiplier	= AM33XX_MAX_DPLL_MULT,
+	.max_divider	= AM33XX_MAX_DPLL_DIV,
+	.min_divider	= 1,
+};
+
+/* CLKOUT: fdpll/M2 */
+static struct clk dpll_disp_ck = {
+	.name		= "dpll_disp_ck",
+	.parent		= &sys_clkin_ck,
+	.dpll_data	= &dpll_disp_dd,
+	.init		= &omap2_init_dpll_parent,
+	.ops		= &clkops_null,
+	.recalc		= &omap3_dpll_recalc,
+	.round_rate	= &omap2_dpll_round_rate,
+	.set_rate	= &omap3_noncore_dpll_set_rate,
+};
+
+/*
+ * TODO: Add clksel here (sys_clkin, CORE_CLKOUTM6, PER_CLKOUTM2
+ * and ALT_CLK1/2)
+ */
+static const struct clksel dpll_disp_m2_div[] = {
+	{ .parent = &dpll_disp_ck, .rates = div31_1to31_rates },
+	{ .parent = NULL },
+};
+
+static struct clk dpll_disp_m2_ck = {
+	.name		= "dpll_disp_m2_ck",
+	.parent		= &dpll_disp_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel		= dpll_disp_m2_div,
+	.clksel_reg	= AM33XX_CM_DIV_M2_DPLL_DISP,
+	.clksel_mask	= AM33XX_DPLL_CLKOUT_DIV_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
+};
+
+/* DPLL_PER */
+static struct dpll_data dpll_per_dd = {
+	.mult_div1_reg	= AM33XX_CM_CLKSEL_DPLL_PERIPH,
+	.clk_bypass	= &sys_clkin_ck,
+	.clk_ref	= &sys_clkin_ck,
+	.control_reg	= AM33XX_CM_CLKMODE_DPLL_PER,
+	.modes		= (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
+	.idlest_reg	= AM33XX_CM_IDLEST_DPLL_PER,
+	.mult_mask	= AM33XX_DPLL_MULT_PERIPH_MASK,
+	.div1_mask	= AM33XX_DPLL_PER_DIV_MASK,
+	.enable_mask	= AM33XX_DPLL_EN_MASK,
+	.idlest_mask	= AM33XX_ST_DPLL_CLK_MASK,
+	.max_multiplier	= AM33XX_MAX_DPLL_MULT,
+	.max_divider	= AM33XX_MAX_DPLL_DIV,
+	.min_divider	= 1,
+	.flags		= DPLL_J_TYPE,
+};
+
+/* CLKDCOLDO */
+static struct clk dpll_per_ck = {
+	.name		= "dpll_per_ck",
+	.parent		= &sys_clkin_ck,
+	.dpll_data	= &dpll_per_dd,
+	.init		= &omap2_init_dpll_parent,
+	.ops		= &clkops_null,
+	.recalc		= &omap3_dpll_recalc,
+	.round_rate	= &omap2_dpll_round_rate,
+	.set_rate	= &omap3_noncore_dpll_set_rate,
+};
+
+/* CLKOUT: fdpll/M2 */
+static const struct clksel dpll_per_m2_div[] = {
+	{ .parent = &dpll_per_ck, .rates = div31_1to31_rates },
+	{ .parent = NULL },
+};
+
+static struct clk dpll_per_m2_ck = {
+	.name		= "dpll_per_m2_ck",
+	.parent		= &dpll_per_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel		= dpll_per_m2_div,
+	.clksel_reg	= AM33XX_CM_DIV_M2_DPLL_PER,
+	.clksel_mask	= AM33XX_DPLL_CLKOUT_DIV_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
+};
+
+/*
+ * l4_wkup_gclk, l4_rtc_gclk, uart1_ick, wdt0_ick, wdt1_ick, gpt0_ick,
+ * gpt1_ick, l4_wkup_aon_gclk, uart[2-6]_ick, gpt[2-7]_ick, l4ls_gclk
+ */
+static struct clk core_100mhz_ck = {
+	.name		= "core_100mhz_ck",
+	.parent		= &dpll_core_m4_ck,
+	.ops		= &clkops_null,
+	.fixed_div	= 2,
+	.recalc		= &omap_fixed_divisor_recalc,
+};
+
+static struct clk clk_24mhz = {
+	.name		= "clk_24mhz",
+	.parent		= &dpll_per_m2_ck,
+	.fixed_div	= 8,
+	.ops		= &clkops_null,
+	.recalc		= &omap_fixed_divisor_recalc,
+};
+
+/* clkdiv32 is generated from fixed division of 732.421875 */
+static struct clk clkdiv32k_ick = {
+	.name		= "clkdiv32k_ick",
+	.clkdm_name	= "clk_24mhz_clkdm",
+	.rate		= 32768,
+	.parent		= &clk_24mhz,
+	.enable_reg	= AM33XX_CM_PER_CLKDIV32K_CLKCTRL,
+	.enable_bit	= AM33XX_MODULEMODE_SWCTRL,
+	.ops		= &clkops_omap2_dflt,
+};
+
+/* I2C1-3, SPI0, SPI1, UART1-6 functional clock */
+static struct clk dpll_per_m2_div4_ck = {
+	.name		= "dpll_per_m2_div4_ck",
+	.parent		= &dpll_per_m2_ck,
+	.fixed_div	= 4,
+	.ops		= &clkops_null,
+	.recalc		= &omap_fixed_divisor_recalc,
+};
+
+/*
+ * mcasp0/1 can be removed once sound/soc/davinci/davinci-mcasp.c is
+ * converted to use runtime PM
+ */
+static struct clk mcasp0_fck = {
+	.name		= "mcasp0_fck",
+	.clkdm_name	= "l3s_clkdm",
+	.parent		= &sys_clkin_ck,
+	.enable_reg	= AM33XX_CM_PER_MCASP0_CLKCTRL,
+	.enable_bit	= AM33XX_MODULEMODE_SWCTRL,
+	.ops		= &clkops_omap2_dflt,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk mcasp1_fck = {
+	.name		= "mcasp1_fck",
+	.clkdm_name	= "l3s_clkdm",
+	.parent		= &sys_clkin_ck,
+	.enable_reg	= AM33XX_CM_PER_MCASP1_CLKCTRL,
+	.enable_bit	= AM33XX_MODULEMODE_SWCTRL,
+	.ops		= &clkops_omap2_dflt,
+	.recalc		= &followparent_recalc,
+};
+
+/* Timers */
+
+/* Secure Timer: Used only to disable the clocks and for completeness */
+static const struct clksel timer0_clkmux_sel[] = {
+	{ .parent = &clk_rc32k_ck, .rates = div_1_0_rates },
+	{ .parent = &clkdiv32k_ick, .rates = div_1_1_rates },
+	{ .parent = &sys_clkin_ck, .rates = div_1_2_rates },
+	{ .parent = &tclkin_ck, .rates = div_1_3_rates },
+	{ .parent = NULL },
+};
+
+/*
+ * It should be possible to remove the timerX_fck nodes after Tarun's
+ * patch series to clean up the mach-omap2/timer.c clk_get code
+ */
+static struct clk timer0_fck_mux_ck = {
+	.name		= "timer0_fck_mux_ck",
+	.clkdm_name	= "l4_wkup_clkdm",
+	.parent		= &clk_rc32k_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel		= timer0_clkmux_sel,
+	.clksel_reg	= AM33XX_CTRL_REGADDR(AM33XX_CONTROL_SEC_CLK_CTRL),
+	.clksel_mask	= AM33XX_TIMER0_CLKSEL_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk timer0_fck = {
+	.name		= "timer0_fck",
+	.clkdm_name	= "l4_wkup_clkdm",
+	.parent		= &timer0_fck_mux_ck,
+	.enable_reg	= AM33XX_CM_WKUP_TIMER0_CLKCTRL,
+	.enable_bit	= AM33XX_MODULEMODE_SWCTRL,
+	.ops		= &clkops_omap2_dflt,
+	.recalc		= &followparent_recalc,
+};
+
+static const struct clksel timer1_clkmux_sel[] = {
+	{ .parent = &sys_clkin_ck, .rates = div_1_0_rates },
+	{ .parent = &clkdiv32k_ick, .rates = div_1_1_rates },
+	{ .parent = &tclkin_ck, .rates = div_1_2_rates },
+	{ .parent = &clk_rc32k_ck, .rates = div_1_3_rates },
+	{ .parent = &clk_32768_ck, .rates = div_1_4_rates },
+	{ .parent = NULL },
+};
+
+static struct clk timer1_fck_mux_ck = {
+	.name		= "timer1_fck_mux_ck",
+	.clkdm_name	= "l4ls_clkdm",
+	.parent		= &sys_clkin_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel		= timer1_clkmux_sel,
+	.clksel_reg	= AM33XX_CLKSEL_TIMER1MS_CLK,
+	.clksel_mask	= AM33XX_CLKSEL_0_2_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
+};
+
+static struct clk timer1_fck = {
+	.name		= "timer1_fck",
+	.clkdm_name	= "l4ls_clkdm",
+	.parent		= &timer1_fck_mux_ck,
+	.enable_reg	= AM33XX_CM_WKUP_TIMER1_CLKCTRL,
+	.enable_bit	= AM33XX_MODULEMODE_SWCTRL,
+	.ops		= &clkops_omap2_dflt,
+	.recalc		= &followparent_recalc,
+};
+
+static const struct clksel timer2_to_7_clksel[] = {
+	{ .parent = &tclkin_ck, .rates = div_1_0_rates },
+	{ .parent = &sys_clkin_ck, .rates = div_1_1_rates },
+	{ .parent = &clkdiv32k_ick, .rates = div_1_2_rates },
+	{ .parent = NULL },
+};
+
+static struct clk timer2_fck_mux_ck = {
+	.name		= "timer2_fck_mux_ck",
+	.clkdm_name	= "l4ls_clkdm",
+	.parent		= &sys_clkin_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel		= timer2_to_7_clksel,
+	.clksel_reg	= AM33XX_CLKSEL_TIMER2_CLK,
+	.clksel_mask	= AM33XX_CLKSEL_0_1_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
+};
+
+static struct clk timer2_fck = {
+	.name		= "timer2_fck",
+	.clkdm_name	= "l4ls_clkdm",
+	.parent		= &timer2_fck_mux_ck,
+	.enable_reg	= AM33XX_CM_PER_TIMER2_CLKCTRL,
+	.enable_bit	= AM33XX_MODULEMODE_SWCTRL,
+	.ops		= &clkops_omap2_dflt,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk timer3_fck_mux_ck = {
+	.name		= "timer3_fck_mux_ck",
+	.clkdm_name	= "l4ls_clkdm",
+	.parent		= &sys_clkin_ck,
+	.init		= &am33xx_init_timer_parent,
+	.clksel		= timer2_to_7_clksel,
+	.clksel_reg	= AM33XX_CLKSEL_TIMER3_CLK,
+	.clksel_mask	= AM33XX_CLKSEL_0_1_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
+};
+
+static struct clk timer3_fck = {
+	.name		= "timer3_fck",
+	.clkdm_name	= "l4ls_clkdm",
+	.parent		= &timer3_fck_mux_ck,
+	.enable_reg	= AM33XX_CM_PER_TIMER3_CLKCTRL,
+	.enable_bit	= AM33XX_MODULEMODE_SWCTRL,
+	.ops		= &clkops_omap2_dflt,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk timer4_fck_mux_ck = {
+	.name		= "timer4_fck_mux_ck",
+	.clkdm_name	= "l4ls_clkdm",
+	.parent		= &sys_clkin_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel		= timer2_to_7_clksel,
+	.clksel_reg	= AM33XX_CLKSEL_TIMER4_CLK,
+	.clksel_mask	= AM33XX_CLKSEL_0_1_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
+};
+
+static struct clk timer4_fck = {
+	.name		= "timer4_fck",
+	.clkdm_name	= "l4ls_clkdm",
+	.parent		= &timer4_fck_mux_ck,
+	.enable_reg	= AM33XX_CM_PER_TIMER4_CLKCTRL,
+	.enable_bit	= AM33XX_MODULEMODE_SWCTRL,
+	.ops		= &clkops_omap2_dflt,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk timer5_fck_mux_ck = {
+	.name		= "timer5_fck_mux_ck",
+	.clkdm_name	= "l4ls_clkdm",
+	.parent		= &sys_clkin_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel		= timer2_to_7_clksel,
+	.clksel_reg	= AM33XX_CLKSEL_TIMER5_CLK,
+	.clksel_mask	= AM33XX_CLKSEL_0_1_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
+};
+
+static struct clk timer5_fck = {
+	.name		= "timer5_fck",
+	.clkdm_name	= "l4ls_clkdm",
+	.parent		= &timer5_fck_mux_ck,
+	.enable_reg	= AM33XX_CM_PER_TIMER5_CLKCTRL,
+	.enable_bit	= AM33XX_MODULEMODE_SWCTRL,
+	.ops		= &clkops_omap2_dflt,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk timer6_fck_mux_ck = {
+	.name		= "timer6_fck_mux_ck",
+	.clkdm_name	= "l4ls_clkdm",
+	.parent		= &sys_clkin_ck,
+	.init		= &am33xx_init_timer_parent,
+	.clksel		= timer2_to_7_clksel,
+	.clksel_reg	= AM33XX_CLKSEL_TIMER6_CLK,
+	.clksel_mask	= AM33XX_CLKSEL_0_1_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
+};
+
+static struct clk timer6_fck = {
+	.name		= "timer6_fck",
+	.clkdm_name	= "l4ls_clkdm",
+	.parent		= &timer6_fck_mux_ck,
+	.enable_reg	= AM33XX_CM_PER_TIMER6_CLKCTRL,
+	.enable_bit	= AM33XX_MODULEMODE_SWCTRL,
+	.ops		= &clkops_omap2_dflt,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk timer7_fck_mux_ck = {
+	.name		= "timer7_fck_mux_ck",
+	.clkdm_name	= "l4ls_clkdm",
+	.parent		= &sys_clkin_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel		= timer2_to_7_clksel,
+	.clksel_reg	= AM33XX_CLKSEL_TIMER7_CLK,
+	.clksel_mask	= AM33XX_CLKSEL_0_1_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
+};
+
+static struct clk timer7_fck = {
+	.name		= "timer7_fck",
+	.clkdm_name	= "l4ls_clkdm",
+	.parent		= &timer7_fck_mux_ck,
+	.enable_reg	= AM33XX_CM_PER_TIMER7_CLKCTRL,
+	.enable_bit	= AM33XX_MODULEMODE_SWCTRL,
+	.ops		= &clkops_omap2_dflt,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk cpsw_125mhz_gclk = {
+	.name		= "cpsw_125mhz_gclk",
+	.clkdm_name	= "cpsw_125mhz_clkdm",
+	.parent		= &dpll_core_m5_ck,
+	.ops		= &clkops_null,
+	.fixed_div	= 2,
+	.recalc		= &omap_fixed_divisor_recalc,
+};
+
+/*
+ * TODO: As per clock tree @OPP50 /2 is used, but there is not register
+ * to configure this. @ normal OPP, /5 is used - 250MHz/5 = 50MHz
+ */
+static struct clk cpsw_50mhz_clk = {
+	.name		= "cpsw_50mhz_clk",
+	.clkdm_name	= "l4hs_clkdm",
+	.parent		= &dpll_core_m5_ck,
+	.ops		= &clkops_null,
+	.fixed_div	= 5,
+	.recalc		= &omap_fixed_divisor_recalc,
+};
+
+static struct clk cpsw_5mhz_clk = {
+	.name		= "cpsw_5mhz_clk",
+	.clkdm_name	= "l4hs_clkdm",
+	.parent		= &cpsw_50mhz_clk,
+	.ops		= &clkops_null,
+	.fixed_div	= 10,
+	.recalc		= &omap_fixed_divisor_recalc,
+};
+
+/*
+ * This clock can be removed once drivers/net/ethernet/ti/cpsw.c is converted
+ * to use runtime PM.
+ */
+static struct clk cpgmac0_ifck = {
+	.name		= "cpgmac0_ifck",
+	.clkdm_name	= "cpsw_125mhz_clkdm",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= AM33XX_CM_PER_CPGMAC0_CLKCTRL,
+	.enable_bit	= AM33XX_MODULEMODE_SWCTRL,
+	.parent		= &cpsw_125mhz_gclk,
+	.recalc		= &followparent_recalc,
+};
+
+static const struct clksel cpsw_cpts_rft_clkmux_sel[] = {
+	{ .parent = &dpll_core_m5_ck, .rates = div_1_0_rates },
+	{ .parent = &dpll_core_m4_ck, .rates = div_1_1_rates },
+	{ .parent = NULL },
+};
+
+static struct clk cpsw_cpts_rft_clk = {
+	.name		= "cpsw_cpts_rft_clk",
+	.clkdm_name	= "l3_clkdm",
+	.parent		= &dpll_core_m5_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel		= cpsw_cpts_rft_clkmux_sel,
+	.clksel_reg	= AM33XX_CM_CPTS_RFT_CLKSEL,
+	.clksel_mask	= AM33XX_CLKSEL_0_0_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
+};
+
+static struct clk usbotg_fck = {
+	.name		= "usbotg_fck",
+	.clkdm_name	= "l3s_clkdm",
+	.parent		= &dpll_per_ck,
+	.enable_reg	= AM33XX_CM_CLKDCOLDO_DPLL_PER,
+	.enable_bit	= AM33XX_ST_DPLL_CLKDCOLDO_SHIFT,
+	.ops		= &clkops_omap2_dflt,
+	.recalc		= &followparent_recalc,
+};
+
+/* gpio */
+static const struct clksel gpio0_dbclk_mux_sel[] = {
+	{ .parent = &clk_rc32k_ck, .rates = div_1_0_rates },
+	{ .parent = &clk_32768_ck, .rates = div_1_1_rates },
+	{ .parent = &clkdiv32k_ick, .rates = div_1_2_rates },
+	{ .parent = NULL },
+};
+
+static struct clk gpio0_dbclk_mux_ck = {
+	.name		= "gpio0_dbclk_mux_ck",
+	.clkdm_name	= "l4_wkup_clkdm",
+	.parent		= &clk_rc32k_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel		= gpio0_dbclk_mux_sel,
+	.clksel_reg	= AM33XX_CLKSEL_GPIO0_DBCLK,
+	.clksel_mask	= AM33XX_CLKSEL_0_1_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
+};
+
+static struct clk gpio0_dbclk = {
+	.name		= "gpio0_dbclk",
+	.clkdm_name	= "l4_wkup_clkdm",
+	.parent		= &gpio0_dbclk_mux_ck,
+	.enable_reg	= AM33XX_CM_WKUP_GPIO0_CLKCTRL,
+	.enable_bit	= AM33XX_OPTFCLKEN_GPIO0_GDBCLK_SHIFT,
+	.ops		= &clkops_omap2_dflt,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk gpio1_dbclk = {
+	.name		= "gpio1_dbclk",
+	.clkdm_name	= "l4ls_clkdm",
+	.parent		= &clkdiv32k_ick,
+	.enable_reg	= AM33XX_CM_PER_GPIO1_CLKCTRL,
+	.enable_bit	= AM33XX_OPTFCLKEN_GPIO_1_GDBCLK_SHIFT,
+	.ops		= &clkops_omap2_dflt,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk gpio2_dbclk = {
+	.name		= "gpio2_dbclk",
+	.clkdm_name	= "l4ls_clkdm",
+	.parent		= &clkdiv32k_ick,
+	.enable_reg	= AM33XX_CM_PER_GPIO2_CLKCTRL,
+	.enable_bit	= AM33XX_OPTFCLKEN_GPIO_2_GDBCLK_SHIFT,
+	.ops		= &clkops_omap2_dflt,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk gpio3_dbclk = {
+	.name		= "gpio3_dbclk",
+	.clkdm_name	= "l4ls_clkdm",
+	.parent		= &clkdiv32k_ick,
+	.enable_reg	= AM33XX_CM_PER_GPIO3_CLKCTRL,
+	.enable_bit	= AM33XX_OPTFCLKEN_GPIO_3_GDBCLK_SHIFT,
+	.ops		= &clkops_omap2_dflt,
+	.recalc		= &followparent_recalc,
+};
+
+static const struct clksel pruss_ocp_clk_mux_sel[] = {
+	{ .parent = &dpll_core_m4_ck, .rates = div_1_0_rates },
+	{ .parent = &dpll_disp_m2_ck, .rates = div_1_1_rates },
+	{ .parent = NULL },
+};
+
+static struct clk pruss_ocp_gclk = {
+	.name		= "pruss_ocp_gclk",
+	.parent		= &dpll_core_m4_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel		= pruss_ocp_clk_mux_sel,
+	.clksel_reg	= AM33XX_CLKSEL_PRUSS_OCP_CLK,
+	.clksel_mask	= AM33XX_CLKSEL_0_0_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
+};
+
+static const struct clksel lcd_clk_mux_sel[] = {
+	{ .parent = &dpll_disp_m2_ck, .rates = div_1_0_rates },
+	{ .parent = &dpll_core_m5_ck, .rates = div_1_1_rates },
+	{ .parent = &dpll_per_m2_ck, .rates = div_1_2_rates },
+	{ .parent = NULL },
+};
+
+static struct clk lcd_gclk = {
+	.name		= "lcd_gclk",
+	.parent		= &dpll_disp_m2_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel		= lcd_clk_mux_sel,
+	.clksel_reg	= AM33XX_CLKSEL_LCDC_PIXEL_CLK,
+	.clksel_mask	= AM33XX_CLKSEL_0_1_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
+};
+
+/*
+ * It should be possible to remove this after drivers/video/da8xx-fb.c
+ * is converted to use runtime PM
+ */
+static struct clk lcdc_fck = {
+	.name		= "lcdc_fck",
+	.clkdm_name	= "lcdc_clkdm",
+	.parent		= &lcd_gclk,
+	.enable_reg	= AM33XX_CM_PER_LCDC_CLKCTRL,
+	.enable_bit	= AM33XX_MODULEMODE_SWCTRL,
+	.ops		= &clkops_omap2_dflt,
+	.recalc		= &followparent_recalc,
+};
+
+/* MMC0, MMC1 functional clock */
+static struct clk mmc_clk = {
+	.name		= "mmc_clk",
+	.parent		= &dpll_per_m2_ck,
+	.ops		= &clkops_null,
+	.fixed_div	= 2,
+	.recalc		= &omap_fixed_divisor_recalc,
+};
+
+static const struct clksel gfx_clksel_sel[] = {
+	{ .parent = &dpll_core_m4_ck, .rates = div_1_0_rates },
+	{ .parent = &dpll_per_m2_ck, .rates = div_1_1_rates },
+	{ .parent = NULL },
+};
+
+static struct clk gfx_fck_clksel_ck = {
+	.name		= "gfx_fck_clksel_ck",
+	.parent		= &dpll_core_m4_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel		= gfx_clksel_sel,
+	.clksel_reg	= AM33XX_CLKSEL_GFX_FCLK,
+	.clksel_mask	= AM33XX_CLKSEL_GFX_FCLK_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
+};
+
+static const struct clksel_rate div_1_0_2_1_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_AM33XX },
+	{ .div = 2, .val = 1, .flags = RATE_IN_AM33XX },
+	{ .div = 0 },
+};
+
+static const struct clksel gfx_div_sel[] = {
+	{ .parent = &gfx_fck_clksel_ck, .rates = div_1_0_2_1_rates },
+	{ .parent = NULL },
+};
+
+/* gfx functional clock */
+static struct clk gfx_fck_div_ck = {
+	.name		= "gfx_fck_div_ck",
+	.clkdm_name	= "gfx_l3_clkdm",
+	.parent		= &gfx_fck_clksel_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel		= gfx_div_sel,
+	.clksel_reg	= AM33XX_CLKSEL_GFX_FCLK,
+	.clksel_mask	= AM33XX_CLKSEL_0_0_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
+};
+
+static const struct clksel sysclkout_pre_sel[] = {
+	{ .parent = &clk_32768_ck, .rates = div_1_0_rates },
+	{ .parent = &dpll_core_m4_ck, .rates = div_1_1_rates },
+	{ .parent = &dpll_ddr_m2_ck, .rates = div_1_2_rates },
+	{ .parent = &dpll_per_m2_ck, .rates = div_1_3_rates },
+	{ .parent = &lcd_gclk, .rates = div_1_4_rates },
+	{ .parent = NULL },
+};
+
+static struct clk sysclkout_pre_ck = {
+	.name		= "sysclkout_pre_ck",
+	.parent		= &clk_32768_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel		= sysclkout_pre_sel,
+	.clksel_reg	= AM33XX_CM_CLKOUT_CTRL,
+	.clksel_mask	= AM33XX_CLKOUT2SOURCE_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
+};
+
+/* Divide by 8 clock rates with default clock is 1/1 */
+static const struct clksel_rate div8_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_AM33XX },
+	{ .div = 2, .val = 1, .flags = RATE_IN_AM33XX },
+	{ .div = 3, .val = 2, .flags = RATE_IN_AM33XX },
+	{ .div = 4, .val = 3, .flags = RATE_IN_AM33XX },
+	{ .div = 5, .val = 4, .flags = RATE_IN_AM33XX },
+	{ .div = 6, .val = 5, .flags = RATE_IN_AM33XX },
+	{ .div = 7, .val = 6, .flags = RATE_IN_AM33XX },
+	{ .div = 8, .val = 7, .flags = RATE_IN_AM33XX },
+	{ .div = 0 },
+};
+
+static const struct clksel clkout2_div[] = {
+	{ .parent = &sysclkout_pre_ck, .rates = div8_rates },
+	{ .parent = NULL },
+};
+
+static struct clk clkout2_ck = {
+	.name		= "clkout2_ck",
+	.parent		= &sysclkout_pre_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel		= clkout2_div,
+	.clksel_reg	= AM33XX_CM_CLKOUT_CTRL,
+	.clksel_mask	= AM33XX_CLKOUT2DIV_MASK,
+	.enable_reg	= AM33XX_CM_CLKOUT_CTRL,
+	.enable_bit	= AM33XX_CLKOUT2EN_SHIFT,
+	.ops		= &clkops_omap2_dflt,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
+};
+
+static struct clk vtp_clk = {
+	.name		= "vtp_clk",
+	.parent		= &sys_clkin_ck,
+	.ops		= &clkops_null,
+	.fixed_div	= 2,
+	.recalc		= &omap_fixed_divisor_recalc,
+};
+
+static const struct clksel wdt_clkmux_sel[] = {
+	{ .parent = &clk_rc32k_ck, .rates = div_1_0_rates },
+	{ .parent = &clkdiv32k_ick, .rates = div_1_1_rates },
+	{ .parent = NULL },
+};
+
+/* WDT0 functional clock */
+static struct clk wdt0_fck_mux_ck = {
+	.name		= "wdt0_fck_mux_ck",
+	.clkdm_name	= "l4_wkup_clkdm",
+	.parent		= &clk_rc32k_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel		= wdt_clkmux_sel,
+	.clksel_reg	= AM33XX_CTRL_REGADDR(AM33XX_CONTROL_SEC_CLK_CTRL),
+	.clksel_mask	= AM33XX_CLKSEL_0_0_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+/* WDT1 functional clock */
+static struct clk wdt1_fck_mux_ck = {
+	.name		= "wdt1_fck_mux_ck",
+	.clkdm_name	= "l4_wkup_clkdm",
+	.parent		= &clk_rc32k_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel		= wdt_clkmux_sel,
+	.clksel_reg	= AM33XX_CLKSEL_WDT1_CLK,
+	.clksel_mask	= AM33XX_CLKSEL_0_1_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+	.set_rate	= &omap2_clksel_set_rate,
+	.round_rate	= &omap2_clksel_round_rate,
+};
+
+/*
+ * clkdev
+ */
+static struct omap_clk am33xx_clks[] = {
+	CLK(NULL,	"clk_32768_ck",		&clk_32768_ck,	CK_AM33XX),
+	CLK(NULL,	"clk_rc32k_ck",		&clk_rc32k_ck,	CK_AM33XX),
+	CLK(NULL,	"virt_19200000_ck",	&virt_19200000_ck,	CK_AM33XX),
+	CLK(NULL,	"virt_24m_ck",		&virt_24m_ck,	CK_AM33XX),
+	CLK(NULL,	"virt_25m_ck",		&virt_25m_ck,	CK_AM33XX),
+	CLK(NULL,	"virt_26000000_ck",	&virt_26000000_ck,	CK_AM33XX),
+	CLK(NULL,	"sys_clkin_ck",		&sys_clkin_ck,	CK_AM33XX),
+	CLK(NULL,	"tclkin_ck",		&tclkin_ck,	CK_AM33XX),
+	CLK(NULL,	"dpll_core_ck",		&dpll_core_ck,	CK_AM33XX),
+	CLK(NULL,	"dpll_core_x2_ck",	&dpll_core_x2_ck,	CK_AM33XX),
+	CLK(NULL,	"dpll_core_m4_ck",	&dpll_core_m4_ck,	CK_AM33XX),
+	CLK(NULL,	"dpll_core_m5_ck",	&dpll_core_m5_ck,	CK_AM33XX),
+	CLK(NULL,	"dpll_core_m6_ck",	&dpll_core_m6_ck,	CK_AM33XX),
+	CLK(NULL,	"dpll_mpu_ck",		&dpll_mpu_ck,	CK_AM33XX),
+	CLK(NULL,	"dpll_mpu_m2_ck",	&dpll_mpu_m2_ck,	CK_AM33XX),
+	CLK(NULL,	"dpll_ddr_ck",		&dpll_ddr_ck,	CK_AM33XX),
+	CLK(NULL,	"dpll_ddr_m2_ck",	&dpll_ddr_m2_ck,	CK_AM33XX),
+	CLK(NULL,	"dpll_ddr_m2_div2_ck",	&dpll_ddr_m2_div2_ck,	CK_AM33XX),
+	CLK(NULL,	"dpll_disp_ck",		&dpll_disp_ck,	CK_AM33XX),
+	CLK(NULL,	"dpll_disp_m2_ck",	&dpll_disp_m2_ck,	CK_AM33XX),
+	CLK(NULL,	"dpll_per_ck",		&dpll_per_ck,	CK_AM33XX),
+	CLK(NULL,	"dpll_per_m2_ck",	&dpll_per_m2_ck,	CK_AM33XX),
+	CLK(NULL,	"core_100mhz_ck",	&core_100mhz_ck,	CK_AM33XX),
+	CLK(NULL,	"dpll_per_m2_div4_ck",	&dpll_per_m2_div4_ck,	CK_AM33XX),
+	CLK(NULL,	"clkdiv32k_ick",	&clkdiv32k_ick,	CK_AM33XX),
+	CLK("cpsw.0",	NULL,			&cpgmac0_ifck,	CK_AM33XX),
+	CLK(NULL,	"pruss_ocp_gclk",	&pruss_ocp_gclk,	CK_AM33XX),
+	CLK("da8xx_lcdc.0",	NULL,		&lcdc_fck,	CK_AM33XX),
+	CLK("davinci-mcasp.0",	NULL,		&mcasp0_fck,	CK_AM33XX),
+	CLK("davinci-mcasp.1",	NULL,		&mcasp1_fck,	CK_AM33XX),
+	CLK(NULL,	"timer0_fck_mux_ck",	&timer0_fck_mux_ck,	CK_AM33XX),
+	CLK(NULL,	"timer1_fck_mux_ck",	&timer1_fck_mux_ck,	CK_AM33XX),
+	CLK(NULL,	"timer2_fck_mux_ck",	&timer2_fck_mux_ck,	CK_AM33XX),
+	CLK(NULL,	"timer3_fck_mux_ck",	&timer3_fck_mux_ck,	CK_AM33XX),
+	CLK(NULL,	"timer4_fck_mux_ck",	&timer4_fck_mux_ck,	CK_AM33XX),
+	CLK(NULL,	"timer5_fck_mux_ck",	&timer5_fck_mux_ck,	CK_AM33XX),
+	CLK(NULL,	"timer6_fck_mux_ck",	&timer6_fck_mux_ck,	CK_AM33XX),
+	CLK(NULL,	"timer7_fck_mux_ck",	&timer7_fck_mux_ck,	CK_AM33XX),
+	CLK(NULL,	"gpt0_fck",		&timer0_fck,	CK_AM33XX),
+	CLK(NULL,	"gpt1_fck",		&timer1_fck,	CK_AM33XX),
+	CLK(NULL,	"gpt2_fck",		&timer2_fck,	CK_AM33XX),
+	CLK(NULL,	"gpt3_fck",		&timer3_fck,	CK_AM33XX),
+	CLK(NULL,	"gpt4_fck",		&timer4_fck,	CK_AM33XX),
+	CLK(NULL,	"gpt5_fck",		&timer5_fck,	CK_AM33XX),
+	CLK(NULL,	"gpt6_fck",		&timer6_fck,	CK_AM33XX),
+	CLK(NULL,	"gpt7_fck",		&timer7_fck,	CK_AM33XX),
+	CLK(NULL,	"gpt0_ick",		&dpll_core_m4_ck,	CK_AM33XX),
+	CLK(NULL,	"gpt1_ick",		&dpll_core_m4_ck,	CK_AM33XX),
+	CLK(NULL,	"gpt2_ick",		&dpll_core_m4_ck,	CK_AM33XX),
+	CLK(NULL,	"gpt3_ick",		&dpll_core_m4_ck,	CK_AM33XX),
+	CLK(NULL,	"gpt4_ick",		&dpll_core_m4_ck,	CK_AM33XX),
+	CLK(NULL,	"gpt5_ick",		&dpll_core_m4_ck,	CK_AM33XX),
+	CLK(NULL,	"gpt6_ick",		&dpll_core_m4_ck,	CK_AM33XX),
+	CLK(NULL,	"gpt7_ick",		&dpll_core_m4_ck,	CK_AM33XX),
+	CLK(NULL,	"usbotg_fck",		&usbotg_fck,	CK_AM33XX),
+	CLK(NULL,	"clk_24mhz",		&clk_24mhz,	CK_AM33XX),
+	CLK(NULL,	"cpsw_125mhz_gclk",	&cpsw_125mhz_gclk,	CK_AM33XX),
+	CLK(NULL,	"cpsw_50mhz_clk",	&cpsw_50mhz_clk,	CK_AM33XX),
+	CLK(NULL,	"cpsw_5mhz_clk",	&cpsw_5mhz_clk,	CK_AM33XX),
+	CLK(NULL,	"cpsw_cpts_rft_clk",	&cpsw_cpts_rft_clk,	CK_AM33XX),
+	CLK(NULL,	"gpio0_dbclk_mux_ck",	&gpio0_dbclk_mux_ck,	CK_AM33XX),
+	CLK(NULL,	"gpio0_dbclk",		&gpio0_dbclk,	CK_AM33XX),
+	CLK(NULL,	"gpio1_dbclk",		&gpio1_dbclk,	CK_AM33XX),
+	CLK(NULL,	"gpio2_dbclk",		&gpio2_dbclk,	CK_AM33XX),
+	CLK(NULL,	"gpio3_dbclk",		&gpio3_dbclk,	CK_AM33XX),
+	CLK(NULL,	"lcd_gclk",		&lcd_gclk,	CK_AM33XX),
+	CLK(NULL,	"mmc_clk",		&mmc_clk,	CK_AM33XX),
+	CLK(NULL,	"gfx_fck_clksel_ck",	&gfx_fck_clksel_ck,	CK_AM33XX),
+	CLK(NULL,	"gfx_fck_div_ck",	&gfx_fck_div_ck,	CK_AM33XX),
+	CLK(NULL,	"sysclkout_pre_ck",	&sysclkout_pre_ck,	CK_AM33XX),
+	CLK(NULL,	"clkout2_ck",		&clkout2_ck,	CK_AM33XX),
+	CLK(NULL,	"vtp_clk",		&vtp_clk,	CK_AM33XX),
+	CLK(NULL,	"wdt0_fck_mux_ck",	&wdt0_fck_mux_ck,	CK_AM33XX),
+	CLK(NULL,	"wdt1_fck_mux_ck",	&wdt1_fck_mux_ck,	CK_AM33XX),
+};
+
+int __init am33xx_clk_init(void)
+{
+	struct omap_clk *c;
+	u32 cpu_clkflg;
+
+	if (cpu_is_am33xx()) {
+		cpu_mask = RATE_IN_AM33XX;
+		cpu_clkflg = CK_AM33XX;
+	} else {
+		return 0;
+	}
+
+	clk_init(&omap2_clk_functions);
+
+	/*
+	 * Must stay commented until all SoC device drivers are
+	 * converted to runtime PM, or drivers may start crashing
+	 *
+	 * omap2_clk_disable_clkdm_control();
+	 */
+
+	for (c = am33xx_clks; c < am33xx_clks + ARRAY_SIZE(am33xx_clks); c++)
+		clk_preinit(c->lk.clk);
+
+	for (c = am33xx_clks; c < am33xx_clks + ARRAY_SIZE(am33xx_clks); c++) {
+		if (c->cpu & cpu_clkflg) {
+			clkdev_add(&c->lk);
+			clk_register(c->lk.clk);
+			omap2_init_clk_clkdm(c->lk.clk);
+		}
+	}
+
+	recalculate_root_clocks();
+
+	/*
+	 * Only enable those clocks we will need, let the drivers
+	 * enable other clocks as necessary
+	 */
+	clk_enable_init_clocks();
+
+	return 0;
+}
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index f4a626f..2643200 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -93,18 +93,6 @@ static struct clk virt_16_8m_ck = {
 	.rate		= 16800000,
 };
 
-static struct clk virt_19_2m_ck = {
-	.name		= "virt_19_2m_ck",
-	.ops		= &clkops_null,
-	.rate		= 19200000,
-};
-
-static struct clk virt_26m_ck = {
-	.name		= "virt_26m_ck",
-	.ops		= &clkops_null,
-	.rate		= 26000000,
-};
-
 static struct clk virt_38_4m_ck = {
 	.name		= "virt_38_4m_ck",
 	.ops		= &clkops_null,
@@ -145,8 +133,8 @@ static const struct clksel osc_sys_clksel[] = {
 	{ .parent = &virt_12m_ck,   .rates = osc_sys_12m_rates },
 	{ .parent = &virt_13m_ck,   .rates = osc_sys_13m_rates },
 	{ .parent = &virt_16_8m_ck, .rates = osc_sys_16_8m_rates },
-	{ .parent = &virt_19_2m_ck, .rates = osc_sys_19_2m_rates },
-	{ .parent = &virt_26m_ck,   .rates = osc_sys_26m_rates },
+	{ .parent = &virt_19200000_ck, .rates = osc_sys_19_2m_rates },
+	{ .parent = &virt_26000000_ck, .rates = osc_sys_26m_rates },
 	{ .parent = &virt_38_4m_ck, .rates = osc_sys_38_4m_rates },
 	{ .parent = NULL },
 };
@@ -3229,8 +3217,8 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"virt_12m_ck",	&virt_12m_ck,	CK_3XXX),
 	CLK(NULL,	"virt_13m_ck",	&virt_13m_ck,	CK_3XXX),
 	CLK(NULL,	"virt_16_8m_ck", &virt_16_8m_ck, CK_3430ES2PLUS | CK_AM35XX  | CK_36XX),
-	CLK(NULL,	"virt_19_2m_ck", &virt_19_2m_ck, CK_3XXX),
-	CLK(NULL,	"virt_26m_ck",	&virt_26m_ck,	CK_3XXX),
+	CLK(NULL,	"virt_19200000_ck", &virt_19200000_ck, CK_3XXX),
+	CLK(NULL,	"virt_26000000_ck", &virt_26000000_ck, CK_3XXX),
 	CLK(NULL,	"virt_38_4m_ck", &virt_38_4m_ck, CK_3XXX),
 	CLK(NULL,	"osc_sys_ck",	&osc_sys_ck,	CK_3XXX),
 	CLK(NULL,	"sys_ck",	&sys_ck,	CK_3XXX),
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index fa6ea65..fdb819a6 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -106,18 +106,6 @@ static struct clk virt_16800000_ck = {
 	.rate		= 16800000,
 };
 
-static struct clk virt_19200000_ck = {
-	.name		= "virt_19200000_ck",
-	.ops		= &clkops_null,
-	.rate		= 19200000,
-};
-
-static struct clk virt_26000000_ck = {
-	.name		= "virt_26000000_ck",
-	.ops		= &clkops_null,
-	.rate		= 26000000,
-};
-
 static struct clk virt_27000000_ck = {
 	.name		= "virt_27000000_ck",
 	.ops		= &clkops_null,
@@ -130,31 +118,6 @@ static struct clk virt_38400000_ck = {
 	.rate		= 38400000,
 };
 
-static const struct clksel_rate div_1_0_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_4430 },
-	{ .div = 0 },
-};
-
-static const struct clksel_rate div_1_1_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_4430 },
-	{ .div = 0 },
-};
-
-static const struct clksel_rate div_1_2_rates[] = {
-	{ .div = 1, .val = 2, .flags = RATE_IN_4430 },
-	{ .div = 0 },
-};
-
-static const struct clksel_rate div_1_3_rates[] = {
-	{ .div = 1, .val = 3, .flags = RATE_IN_4430 },
-	{ .div = 0 },
-};
-
-static const struct clksel_rate div_1_4_rates[] = {
-	{ .div = 1, .val = 4, .flags = RATE_IN_4430 },
-	{ .div = 0 },
-};
-
 static const struct clksel_rate div_1_5_rates[] = {
 	{ .div = 1, .val = 5, .flags = RATE_IN_4430 },
 	{ .div = 0 },
@@ -288,41 +251,6 @@ static struct clk dpll_abe_x2_ck = {
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
-static const struct clksel_rate div31_1to31_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_4430 },
-	{ .div = 2, .val = 2, .flags = RATE_IN_4430 },
-	{ .div = 3, .val = 3, .flags = RATE_IN_4430 },
-	{ .div = 4, .val = 4, .flags = RATE_IN_4430 },
-	{ .div = 5, .val = 5, .flags = RATE_IN_4430 },
-	{ .div = 6, .val = 6, .flags = RATE_IN_4430 },
-	{ .div = 7, .val = 7, .flags = RATE_IN_4430 },
-	{ .div = 8, .val = 8, .flags = RATE_IN_4430 },
-	{ .div = 9, .val = 9, .flags = RATE_IN_4430 },
-	{ .div = 10, .val = 10, .flags = RATE_IN_4430 },
-	{ .div = 11, .val = 11, .flags = RATE_IN_4430 },
-	{ .div = 12, .val = 12, .flags = RATE_IN_4430 },
-	{ .div = 13, .val = 13, .flags = RATE_IN_4430 },
-	{ .div = 14, .val = 14, .flags = RATE_IN_4430 },
-	{ .div = 15, .val = 15, .flags = RATE_IN_4430 },
-	{ .div = 16, .val = 16, .flags = RATE_IN_4430 },
-	{ .div = 17, .val = 17, .flags = RATE_IN_4430 },
-	{ .div = 18, .val = 18, .flags = RATE_IN_4430 },
-	{ .div = 19, .val = 19, .flags = RATE_IN_4430 },
-	{ .div = 20, .val = 20, .flags = RATE_IN_4430 },
-	{ .div = 21, .val = 21, .flags = RATE_IN_4430 },
-	{ .div = 22, .val = 22, .flags = RATE_IN_4430 },
-	{ .div = 23, .val = 23, .flags = RATE_IN_4430 },
-	{ .div = 24, .val = 24, .flags = RATE_IN_4430 },
-	{ .div = 25, .val = 25, .flags = RATE_IN_4430 },
-	{ .div = 26, .val = 26, .flags = RATE_IN_4430 },
-	{ .div = 27, .val = 27, .flags = RATE_IN_4430 },
-	{ .div = 28, .val = 28, .flags = RATE_IN_4430 },
-	{ .div = 29, .val = 29, .flags = RATE_IN_4430 },
-	{ .div = 30, .val = 30, .flags = RATE_IN_4430 },
-	{ .div = 31, .val = 31, .flags = RATE_IN_4430 },
-	{ .div = 0 },
-};
-
 static const struct clksel dpll_abe_m2x2_div[] = {
 	{ .parent = &dpll_abe_x2_ck, .rates = div31_1to31_rates },
 	{ .parent = NULL },
diff --git a/arch/arm/mach-omap2/clock_common_data.c b/arch/arm/mach-omap2/clock_common_data.c
index 6424d46..81e22f2 100644
--- a/arch/arm/mach-omap2/clock_common_data.c
+++ b/arch/arm/mach-omap2/clock_common_data.c
@@ -43,3 +43,80 @@ const struct clksel_rate dsp_ick_rates[] = {
 	{ .div = 3, .val = 3, .flags = RATE_IN_243X },
 	{ .div = 0 },
 };
+
+/* clksel_rate blocks shared between OMAP44xx and AM33xx */
+
+const struct clksel_rate div_1_0_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 0 },
+};
+
+const struct clksel_rate div_1_1_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 0 },
+};
+
+const struct clksel_rate div_1_2_rates[] = {
+	{ .div = 1, .val = 2, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 0 },
+};
+
+const struct clksel_rate div_1_3_rates[] = {
+	{ .div = 1, .val = 3, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 0 },
+};
+
+const struct clksel_rate div_1_4_rates[] = {
+	{ .div = 1, .val = 4, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 0 },
+};
+
+const struct clksel_rate div31_1to31_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 2, .val = 2, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 3, .val = 3, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 4, .val = 4, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 5, .val = 5, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 6, .val = 6, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 7, .val = 7, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 8, .val = 8, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 9, .val = 9, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 10, .val = 10, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 11, .val = 11, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 12, .val = 12, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 13, .val = 13, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 14, .val = 14, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 15, .val = 15, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 16, .val = 16, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 17, .val = 17, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 18, .val = 18, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 19, .val = 19, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 20, .val = 20, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 21, .val = 21, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 22, .val = 22, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 23, .val = 23, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 24, .val = 24, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 25, .val = 25, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 26, .val = 26, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 27, .val = 27, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 28, .val = 28, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 29, .val = 29, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 30, .val = 30, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 31, .val = 31, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
+	{ .div = 0 },
+};
+
+/* Clocks shared between various OMAP SoCs */
+
+struct clk virt_19200000_ck = {
+	.name		= "virt_19200000_ck",
+	.ops		= &clkops_null,
+	.rate		= 19200000,
+};
+
+struct clk virt_26000000_ck = {
+	.name		= "virt_26000000_ck",
+	.ops		= &clkops_null,
+	.rate		= 26000000,
+};
+
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index ec60e9b..c43f03c 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -318,15 +318,15 @@
 						OMAP343X_SCRATCHPAD + reg)
 
 /* AM35XX_CONTROL_IPSS_CLK_CTRL bits */
-#define AM35XX_USBOTG_VBUSP_CLK_SHIFT   0
-#define AM35XX_CPGMAC_VBUSP_CLK_SHIFT   1
-#define AM35XX_VPFE_VBUSP_CLK_SHIFT     2
-#define AM35XX_HECC_VBUSP_CLK_SHIFT     3
-#define AM35XX_USBOTG_FCLK_SHIFT        8
-#define AM35XX_CPGMAC_FCLK_SHIFT        9
-#define AM35XX_VPFE_FCLK_SHIFT          10
-
-/*AM35XX CONTROL_LVL_INTR_CLEAR bits*/
+#define AM35XX_USBOTG_VBUSP_CLK_SHIFT	0
+#define AM35XX_CPGMAC_VBUSP_CLK_SHIFT	1
+#define AM35XX_VPFE_VBUSP_CLK_SHIFT	2
+#define AM35XX_HECC_VBUSP_CLK_SHIFT	3
+#define AM35XX_USBOTG_FCLK_SHIFT	8
+#define AM35XX_CPGMAC_FCLK_SHIFT	9
+#define AM35XX_VPFE_FCLK_SHIFT		10
+
+/* AM35XX CONTROL_LVL_INTR_CLEAR bits */
 #define AM35XX_CPGMAC_C0_MISC_PULSE_CLR	BIT(0)
 #define AM35XX_CPGMAC_C0_RX_PULSE_CLR	BIT(1)
 #define AM35XX_CPGMAC_C0_RX_THRESH_CLR	BIT(2)
@@ -336,22 +336,22 @@
 #define AM35XX_VPFE_CCDC_VD1_INT_CLR	BIT(6)
 #define AM35XX_VPFE_CCDC_VD2_INT_CLR	BIT(7)
 
-/*AM35XX CONTROL_IP_SW_RESET bits*/
+/* AM35XX CONTROL_IP_SW_RESET bits */
 #define AM35XX_USBOTGSS_SW_RST		BIT(0)
 #define AM35XX_CPGMACSS_SW_RST		BIT(1)
 #define AM35XX_VPFE_VBUSP_SW_RST	BIT(2)
 #define AM35XX_HECC_SW_RST		BIT(3)
 #define AM35XX_VPFE_PCLK_SW_RST		BIT(4)
 
-/*
- * CONTROL AM33XX STATUS register
- */
+/* AM33XX CONTROL_STATUS register */
 #define AM33XX_CONTROL_STATUS		0x040
 #define AM33XX_CONTROL_SEC_CLK_CTRL	0x1bc
 
-/*
- * CONTROL OMAP STATUS register to identify OMAP3 features
- */
+/* AM33XX CONTROL_STATUS bitfields (partial) */
+#define AM33XX_CONTROL_STATUS_SYSBOOT1_SHIFT		22
+#define AM33XX_CONTROL_STATUS_SYSBOOT1_MASK		(0x3 << 22)
+
+/* CONTROL OMAP STATUS register to identify OMAP3 features */
 #define OMAP3_CONTROL_OMAP_STATUS	0x044c
 
 #define OMAP3_SGX_SHIFT			13
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 3d06561..1e54705 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -37,6 +37,7 @@
 #include "powerdomain.h"
 #include "clockdomain.h"
 #include "common.h"
+#include "clock.h"
 #include "clock2xxx.h"
 #include "clock3xxx.h"
 #include "clock44xx.h"
@@ -460,7 +461,7 @@ void __init am33xx_init_early(void)
 	am33xx_voltagedomains_init();
 	am33xx_powerdomains_init();
 	am33xx_clockdomains_init();
-	omap3xxx_clk_init();
+	am33xx_clk_init();
 }
 
 void __init ti81xx_init_early(void)
diff --git a/arch/arm/plat-omap/include/plat/clkdev_omap.h b/arch/arm/plat-omap/include/plat/clkdev_omap.h
index b299b8d..7b9a934 100644
--- a/arch/arm/plat-omap/include/plat/clkdev_omap.h
+++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
@@ -40,6 +40,7 @@ struct omap_clk {
 #define CK_443X		(1 << 11)
 #define CK_TI816X	(1 << 12)
 #define CK_446X		(1 << 13)
+#define CK_AM33XX	(1 << 14)	/* AM33xx specific clocks */
 #define CK_1710		(1 << 15)	/* 1710 extra for rate selection */
 
 
-- 
1.7.10

