From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH/RFC 3/3] OMAP3: PM: SmartReflex driver integration
Date: Tue,  3 Feb 2009 18:03:49 -0800
Message-ID: <1233713029-14904-4-git-send-email-khilman@deeprootsystems.com>
References: <1233713029-14904-1-git-send-email-khilman@deeprootsystems.com>
 <1233713029-14904-2-git-send-email-khilman@deeprootsystems.com>
 <1233713029-14904-3-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:20893 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbZBDCEH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Feb 2009 21:04:07 -0500
Received: by wf-out-1314.google.com with SMTP id 27so2575471wfd.4
        for <linux-omap@vger.kernel.org>; Tue, 03 Feb 2009 18:04:07 -0800 (PST)
In-Reply-To: <1233713029-14904-3-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

Originally from linux-omap tree, and original commit message follows.
This also includes various updates, cleanups and fixes by the folks
CC'd below.

>From : Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

This patch integrates TI's SmartReflex driver into
linux-omap. SmartReflex is a module that adjusts OMAP3 VDD1 and VDD2
operating voltages around the nominal values of current operating
point depending on silicon characteristics and operating conditions.

The patch adds Kconfig options "SmartReflex support" and a sub-option
"SmartReflex testing support" under "System type"->"TI OMAP
implementations" menu. The testing support can be used to test
SmartReflex functionality, if the E-fuse values have not been set for
the device. It however uses software hard coded sensor parameters,
which may not work on all devices. Beware.

The driver creates two sysfs entries into /sys/power/ named
"sr_vdd1_autocomp" and "sr_vdd2_autocomp" which can be used to
activate voltage autocompensation feature of SmartReflex modules 1 and
2.

Use the following commands to enable autocompensation:

echo -n 1 > /sys/power/sr_vdd1_autocomp
echo -n 1 > /sys/power/sr_vdd2_autocomp

To disable:

echo -n 0 > /sys/power/sr_vdd1_autocomp
echo -n 0 > /sys/power/sr_vdd2_autocomp

Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/Makefile               |    1 +
 arch/arm/mach-omap2/pm34xx.c               |   87 ++++
 arch/arm/mach-omap2/prm-regbits-34xx.h     |   20 +-
 arch/arm/mach-omap2/smartreflex.c          |  762 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/smartreflex.h          |  259 ++++++++++
 arch/arm/plat-omap/Kconfig                 |   31 ++
 arch/arm/plat-omap/include/mach/control.h  |   18 +
 arch/arm/plat-omap/include/mach/omap34xx.h |    3 +-
 8 files changed, 1169 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/mach-omap2/smartreflex.c
 create mode 100644 arch/arm/mach-omap2/smartreflex.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index a98057a..c69221c 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
 obj-$(CONFIG_ARCH_OMAP24XX)		+= sleep24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
+obj-$(CONFIG_OMAP_SMARTREFLEX)		+= smartreflex.o
 endif
 
 # Clock framework
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 6f50e93..bb39e12 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -35,6 +35,7 @@
 
 #include "prm.h"
 #include "pm.h"
+#include "smartreflex.h"
 
 struct power_state {
 	struct powerdomain *pwrdm;
@@ -170,11 +171,19 @@ static void omap_sram_idle(void)
 		printk(KERN_ERR "Invalid mpu state in sram_idle\n");
 		return;
 	}
+	/* Disable smartreflex before entering WFI */
+	disable_smartreflex(SR1);
+	disable_smartreflex(SR2);
+
 	omap2_gpio_prepare_for_retention();
 
 	_omap_sram_idle(NULL, save_state);
 
 	omap2_gpio_resume_after_retention();
+
+	/* Enable smartreflex after WFI */
+	enable_smartreflex(SR1);
+	enable_smartreflex(SR2);
 }
 
 /*
@@ -606,3 +615,81 @@ err2:
 	}
 	return ret;
 }
+
+/* PRM_VC_CMD_VAL_0 specific bits */
+#define OMAP3430_VC_CMD_VAL0_ON				(0x3 << 4)
+#define OMAP3430_VC_CMD_VAL0_ONLP			(0x3 << 3)
+#define OMAP3430_VC_CMD_VAL0_RET			(0x3 << 3)
+#define OMAP3430_VC_CMD_VAL0_OFF			(0x3 << 3)
+
+/* PRM_VC_CMD_VAL_1 specific bits */
+#define OMAP3430_VC_CMD_VAL1_ON				(0xB << 2)
+#define OMAP3430_VC_CMD_VAL1_ONLP			(0x3 << 3)
+#define OMAP3430_VC_CMD_VAL1_RET			(0x3 << 3)
+#define OMAP3430_VC_CMD_VAL1_OFF			(0x3 << 3)
+
+/* Constants to define setup durations */
+#define OMAP3430_CLKSETUP_DURATION			0xff
+#define OMAP3430_VOLTSETUP_TIME2			0xfff
+#define OMAP3430_VOLTSETUP_TIME1			0xfff
+#define OMAP3430_VOLTOFFSET_DURATION			0xff
+#define OMAP3430_VOLTSETUP2_DURATION			0xff
+
+static void __init configure_vc(void)
+{
+	prm_write_mod_reg((R_SRI2C_SLAVE_ADDR << OMAP3430_SMPS_SA1_SHIFT) |
+			  (R_SRI2C_SLAVE_ADDR << OMAP3430_SMPS_SA0_SHIFT),
+			  OMAP3430_GR_MOD, OMAP3_PRM_VC_SMPS_SA_OFFSET);
+	prm_write_mod_reg((R_VDD2_SR_CONTROL << OMAP3430_VOLRA1_SHIFT) |
+			  (R_VDD1_SR_CONTROL << OMAP3430_VOLRA0_SHIFT),
+			  OMAP3430_GR_MOD, OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET);
+
+	prm_write_mod_reg(
+		(OMAP3430_VC_CMD_VAL0_ON << OMAP3430_VC_CMD_ON_SHIFT) |
+		(OMAP3430_VC_CMD_VAL0_ONLP << OMAP3430_VC_CMD_ONLP_SHIFT) |
+		(OMAP3430_VC_CMD_VAL0_RET << OMAP3430_VC_CMD_RET_SHIFT) |
+		(OMAP3430_VC_CMD_VAL0_OFF << OMAP3430_VC_CMD_OFF_SHIFT),
+		OMAP3430_GR_MOD, OMAP3_PRM_VC_CMD_VAL_0_OFFSET);
+
+	prm_write_mod_reg(
+		(OMAP3430_VC_CMD_VAL1_ON << OMAP3430_VC_CMD_ON_SHIFT) |
+		(OMAP3430_VC_CMD_VAL1_ONLP << OMAP3430_VC_CMD_ONLP_SHIFT) |
+		(OMAP3430_VC_CMD_VAL1_RET << OMAP3430_VC_CMD_RET_SHIFT) |
+		(OMAP3430_VC_CMD_VAL1_OFF << OMAP3430_VC_CMD_OFF_SHIFT),
+		OMAP3430_GR_MOD, OMAP3_PRM_VC_CMD_VAL_1_OFFSET);
+
+	prm_write_mod_reg(OMAP3430_CMD1 | OMAP3430_RAV1, OMAP3430_GR_MOD,
+			  OMAP3_PRM_VC_CH_CONF_OFFSET);
+
+	prm_write_mod_reg(OMAP3430_MCODE_SHIFT | OMAP3430_HSEN | OMAP3430_SREN,
+			  OMAP3430_GR_MOD,
+			  OMAP3_PRM_VC_I2C_CFG_OFFSET);
+
+	/* Setup voltctrl and other setup times */
+	prm_write_mod_reg(OMAP3430_AUTO_RET, OMAP3430_GR_MOD,
+			  OMAP3_PRM_VOLTCTRL_OFFSET);
+
+	prm_write_mod_reg(OMAP3430_CLKSETUP_DURATION, OMAP3430_GR_MOD,
+			  OMAP3_PRM_CLKSETUP_OFFSET);
+	prm_write_mod_reg(
+		(OMAP3430_VOLTSETUP_TIME2 << OMAP3430_SETUP_TIME2_SHIFT) |
+		(OMAP3430_VOLTSETUP_TIME1 << OMAP3430_SETUP_TIME1_SHIFT),
+		OMAP3430_GR_MOD, OMAP3_PRM_VOLTSETUP1_OFFSET);
+
+	prm_write_mod_reg(OMAP3430_VOLTOFFSET_DURATION, OMAP3430_GR_MOD,
+			OMAP3_PRM_VOLTOFFSET_OFFSET);
+	prm_write_mod_reg(OMAP3430_VOLTSETUP2_DURATION, OMAP3430_GR_MOD,
+			OMAP3_PRM_VOLTSETUP2_OFFSET);
+}
+
+static int __init omap3_pm_early_init(void)
+{
+	prm_clear_mod_reg_bits(OMAP3430_OFFMODE_POL, OMAP3430_GR_MOD,
+				OMAP3_PRM_POLCTRL_OFFSET);
+
+	configure_vc();
+
+	return 0;
+}
+
+arch_initcall(omap3_pm_early_init);
diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h b/arch/arm/mach-omap2/prm-regbits-34xx.h
index c6a7940..da1897b 100644
--- a/arch/arm/mach-omap2/prm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
@@ -435,10 +435,10 @@
 /* PM_PWSTST_EMU specific bits */
 
 /* PRM_VC_SMPS_SA */
-#define OMAP3430_PRM_VC_SMPS_SA_SA1_SHIFT		16
-#define OMAP3430_PRM_VC_SMPS_SA_SA1_MASK		(0x7f << 16)
-#define OMAP3430_PRM_VC_SMPS_SA_SA0_SHIFT		0
-#define OMAP3430_PRM_VC_SMPS_SA_SA0_MASK		(0x7f << 0)
+#define OMAP3430_SMPS_SA1_SHIFT				16
+#define OMAP3430_SMPS_SA1_MASK				(0x7f << 16)
+#define OMAP3430_SMPS_SA0_SHIFT				0
+#define OMAP3430_SMPS_SA0_MASK				(0x7f << 0)
 
 /* PRM_VC_SMPS_VOL_RA */
 #define OMAP3430_VOLRA1_SHIFT				16
@@ -452,17 +452,15 @@
 #define OMAP3430_CMDRA0_SHIFT				0
 #define OMAP3430_CMDRA0_MASK				(0xff << 0)
 
-/* PRM_VC_CMD_VAL_0 specific bits */
+/* PRM_VC_CMD_VAL specific bits */
 #define OMAP3430_VC_CMD_ON_SHIFT			24
-#define OMAP3430_VC_CMD_ON_MASK				(0xFF << 24)
+#define OMAP3430_VC_CMD_ON_MASK				(0xff << 24)
 #define OMAP3430_VC_CMD_ONLP_SHIFT			16
-#define OMAP3430_VC_CMD_ONLP_MASK			(0xFF << 16)
+#define OMAP3430_VC_CMD_ONLP_MASK			(0xff << 16)
 #define OMAP3430_VC_CMD_RET_SHIFT			8
-#define OMAP3430_VC_CMD_RET_MASK			(0xFF << 8)
+#define OMAP3430_VC_CMD_RET_MASK			(0xff << 8)
 #define OMAP3430_VC_CMD_OFF_SHIFT			0
-#define OMAP3430_VC_CMD_OFF_MASK			(0xFF << 0)
-
-/* PRM_VC_CMD_VAL_1 specific bits */
+#define OMAP3430_VC_CMD_OFF_MASK			(0xff << 0)
 
 /* PRM_VC_CH_CONF */
 #define OMAP3430_CMD1					(1 << 20)
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
new file mode 100644
index 0000000..5be9ecd
--- /dev/null
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -0,0 +1,762 @@
+/*
+ * linux/arch/arm/mach-omap3/smartreflex.c
+ *
+ * OMAP34XX SmartReflex Voltage Control
+ *
+ * Copyright (C) 2008 Nokia Corporation
+ * Kalle Jokiniemi
+ *
+ * Copyright (C) 2007 Texas Instruments, Inc.
+ * Lesly A M <x0080970@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/sysfs.h>
+#include <linux/kobject.h>
+#include <linux/i2c/twl4030.h>
+#include <linux/io.h>
+
+#include <mach/omap34xx.h>
+#include <mach/control.h>
+#include <mach/clock.h>
+
+#include "prm.h"
+#include "smartreflex.h"
+#include "prm-regbits-34xx.h"
+
+/* XXX: These should be relocated where-ever the OPP implementation will be */
+u32 current_vdd1_opp;
+u32 current_vdd2_opp;
+
+struct omap_sr {
+	int		srid;
+	int		is_sr_reset;
+	int		is_autocomp_active;
+	struct clk	*clk;
+	u32		clk_length;
+	u32		req_opp_no;
+	u32		opp1_nvalue, opp2_nvalue, opp3_nvalue, opp4_nvalue;
+	u32		opp5_nvalue;
+	u32		senp_mod, senn_mod;
+	void __iomem	*srbase_addr;
+	void __iomem	*vpbase_addr;
+};
+
+#define SR_REGADDR(offs)	(sr->srbase_addr + offset)
+
+static inline void sr_write_reg(struct omap_sr *sr, unsigned offset, u32 value)
+{
+	__raw_writel(value, SR_REGADDR(offset));
+}
+
+static inline void sr_modify_reg(struct omap_sr *sr, unsigned offset, u32 mask,
+					u32 value)
+{
+	u32 reg_val;
+
+	reg_val = __raw_readl(SR_REGADDR(offset));
+	reg_val &= ~mask;
+	reg_val |= value;
+
+	__raw_writel(reg_val, SR_REGADDR(offset));
+}
+
+static inline u32 sr_read_reg(struct omap_sr *sr, unsigned offset)
+{
+	return __raw_readl(SR_REGADDR(offset));
+}
+
+static int sr_clk_enable(struct omap_sr *sr)
+{
+	if (clk_enable(sr->clk) != 0) {
+		printk(KERN_ERR "Could not enable %s\n", sr->clk->name);
+		return -1;
+	}
+
+	/* set fclk- active , iclk- idle */
+	sr_modify_reg(sr, ERRCONFIG, SR_CLKACTIVITY_MASK,
+		      SR_CLKACTIVITY_IOFF_FON);
+
+	return 0;
+}
+
+static void sr_clk_disable(struct omap_sr *sr)
+{
+	/* set fclk, iclk- idle */
+	sr_modify_reg(sr, ERRCONFIG, SR_CLKACTIVITY_MASK,
+		      SR_CLKACTIVITY_IOFF_FOFF);
+
+	clk_disable(sr->clk);
+	sr->is_sr_reset = 1;
+}
+
+static struct omap_sr sr1 = {
+	.srid			= SR1,
+	.is_sr_reset		= 1,
+	.is_autocomp_active	= 0,
+	.clk_length		= 0,
+	.srbase_addr		= OMAP2_IO_ADDRESS(OMAP34XX_SR1_BASE),
+};
+
+static struct omap_sr sr2 = {
+	.srid			= SR2,
+	.is_sr_reset		= 1,
+	.is_autocomp_active	= 0,
+	.clk_length		= 0,
+	.srbase_addr		= OMAP2_IO_ADDRESS(OMAP34XX_SR2_BASE),
+};
+
+static void cal_reciprocal(u32 sensor, u32 *sengain, u32 *rnsen)
+{
+	u32 gn, rn, mul;
+
+	for (gn = 0; gn < GAIN_MAXLIMIT; gn++) {
+		mul = 1 << (gn + 8);
+		rn = mul / sensor;
+		if (rn < R_MAXLIMIT) {
+			*sengain = gn;
+			*rnsen = rn;
+		}
+	}
+}
+
+static u32 cal_test_nvalue(u32 sennval, u32 senpval)
+{
+	u32 senpgain, senngain;
+	u32 rnsenp, rnsenn;
+
+	/* Calculating the gain and reciprocal of the SenN and SenP values */
+	cal_reciprocal(senpval, &senpgain, &rnsenp);
+	cal_reciprocal(sennval, &senngain, &rnsenn);
+
+	return (senpgain << NVALUERECIPROCAL_SENPGAIN_SHIFT) |
+		(senngain << NVALUERECIPROCAL_SENNGAIN_SHIFT) |
+		(rnsenp << NVALUERECIPROCAL_RNSENP_SHIFT) |
+		(rnsenn << NVALUERECIPROCAL_RNSENN_SHIFT);
+}
+
+static void sr_set_clk_length(struct omap_sr *sr)
+{
+	struct clk *osc_sys_ck;
+	u32 sys_clk = 0;
+
+	osc_sys_ck = clk_get(NULL, "osc_sys_ck");
+	sys_clk = clk_get_rate(osc_sys_ck);
+	clk_put(osc_sys_ck);
+
+	switch (sys_clk) {
+	case 12000000:
+		sr->clk_length = SRCLKLENGTH_12MHZ_SYSCLK;
+		break;
+	case 13000000:
+		sr->clk_length = SRCLKLENGTH_13MHZ_SYSCLK;
+		break;
+	case 19200000:
+		sr->clk_length = SRCLKLENGTH_19MHZ_SYSCLK;
+		break;
+	case 26000000:
+		sr->clk_length = SRCLKLENGTH_26MHZ_SYSCLK;
+		break;
+	case 38400000:
+		sr->clk_length = SRCLKLENGTH_38MHZ_SYSCLK;
+		break;
+	default:
+		printk(KERN_ERR "Invalid sysclk value: %d\n", sys_clk);
+		break;
+	}
+}
+
+static void sr_set_efuse_nvalues(struct omap_sr *sr)
+{
+	if (sr->srid == SR1) {
+		sr->senn_mod = (omap_ctrl_readl(OMAP343X_CONTROL_FUSE_SR) &
+					OMAP343X_SR1_SENNENABLE_MASK) >>
+					OMAP343X_SR1_SENNENABLE_SHIFT;
+
+		sr->senp_mod = (omap_ctrl_readl(OMAP343X_CONTROL_FUSE_SR) &
+					OMAP343X_SR1_SENPENABLE_MASK) >>
+					OMAP343X_SR1_SENPENABLE_SHIFT;
+
+		sr->opp5_nvalue = omap_ctrl_readl(
+					OMAP343X_CONTROL_FUSE_OPP5_VDD1);
+		sr->opp4_nvalue = omap_ctrl_readl(
+					OMAP343X_CONTROL_FUSE_OPP4_VDD1);
+		sr->opp3_nvalue = omap_ctrl_readl(
+					OMAP343X_CONTROL_FUSE_OPP3_VDD1);
+		sr->opp2_nvalue = omap_ctrl_readl(
+					OMAP343X_CONTROL_FUSE_OPP2_VDD1);
+		sr->opp1_nvalue = omap_ctrl_readl(
+					OMAP343X_CONTROL_FUSE_OPP1_VDD1);
+	} else if (sr->srid == SR2) {
+		sr->senn_mod = (omap_ctrl_readl(OMAP343X_CONTROL_FUSE_SR) &
+					OMAP343X_SR2_SENNENABLE_MASK) >>
+					OMAP343X_SR2_SENNENABLE_SHIFT;
+
+		sr->senp_mod = (omap_ctrl_readl(OMAP343X_CONTROL_FUSE_SR) &
+					OMAP343X_SR2_SENPENABLE_MASK) >>
+					OMAP343X_SR2_SENPENABLE_SHIFT;
+
+		sr->opp3_nvalue = omap_ctrl_readl(
+					OMAP343X_CONTROL_FUSE_OPP3_VDD2);
+		sr->opp2_nvalue = omap_ctrl_readl(
+					OMAP343X_CONTROL_FUSE_OPP2_VDD2);
+		sr->opp1_nvalue = omap_ctrl_readl(
+					OMAP343X_CONTROL_FUSE_OPP1_VDD2);
+	}
+}
+
+/* Hard coded nvalues for testing purposes, may cause device to hang! */
+static void sr_set_testing_nvalues(struct omap_sr *sr)
+{
+	if (sr->srid == SR1) {
+		sr->senp_mod = 0x03;	/* SenN-M5 enabled */
+		sr->senn_mod = 0x03;
+
+		/* calculate nvalues for each opp */
+		sr->opp5_nvalue = cal_test_nvalue(0xacd + 0x330, 0x848 + 0x330);
+		sr->opp4_nvalue = cal_test_nvalue(0x964 + 0x2a0, 0x727 + 0x2a0);
+		sr->opp3_nvalue = cal_test_nvalue(0x85b + 0x200, 0x655 + 0x200);
+		sr->opp2_nvalue = cal_test_nvalue(0x506 + 0x1a0, 0x3be + 0x1a0);
+		sr->opp1_nvalue = cal_test_nvalue(0x373 + 0x100, 0x28c + 0x100);
+	} else if (sr->srid == SR2) {
+		sr->senp_mod = 0x03;
+		sr->senn_mod = 0x03;
+
+		sr->opp3_nvalue = cal_test_nvalue(0x76f + 0x200, 0x579 + 0x200);
+		sr->opp2_nvalue = cal_test_nvalue(0x4f5 + 0x1c0, 0x390 + 0x1c0);
+		sr->opp1_nvalue = cal_test_nvalue(0x359, 0x25d);
+	}
+
+}
+
+static void sr_set_nvalues(struct omap_sr *sr)
+{
+	if (SR_TESTING_NVALUES)
+		sr_set_testing_nvalues(sr);
+	else
+		sr_set_efuse_nvalues(sr);
+}
+
+static void sr_configure_vp(int srid)
+{
+	u32 vpconfig;
+
+	if (srid == SR1) {
+		vpconfig = PRM_VP1_CONFIG_ERROROFFSET | PRM_VP1_CONFIG_ERRORGAIN
+					| PRM_VP1_CONFIG_INITVOLTAGE
+					| PRM_VP1_CONFIG_TIMEOUTEN;
+
+		prm_write_mod_reg(vpconfig, OMAP3430_GR_MOD,
+					OMAP3_PRM_VP1_CONFIG_OFFSET);
+		prm_write_mod_reg(PRM_VP1_VSTEPMIN_SMPSWAITTIMEMIN |
+					PRM_VP1_VSTEPMIN_VSTEPMIN,
+					OMAP3430_GR_MOD,
+					OMAP3_PRM_VP1_VSTEPMIN_OFFSET);
+
+		prm_write_mod_reg(PRM_VP1_VSTEPMAX_SMPSWAITTIMEMAX |
+					PRM_VP1_VSTEPMAX_VSTEPMAX,
+					OMAP3430_GR_MOD,
+					OMAP3_PRM_VP1_VSTEPMAX_OFFSET);
+
+		prm_write_mod_reg(PRM_VP1_VLIMITTO_VDDMAX |
+					PRM_VP1_VLIMITTO_VDDMIN |
+					PRM_VP1_VLIMITTO_TIMEOUT,
+					OMAP3430_GR_MOD,
+					OMAP3_PRM_VP1_VLIMITTO_OFFSET);
+
+		/* Trigger initVDD value copy to voltage processor */
+		prm_set_mod_reg_bits(PRM_VP1_CONFIG_INITVDD, OMAP3430_GR_MOD,
+					OMAP3_PRM_VP1_CONFIG_OFFSET);
+		/* Clear initVDD copy trigger bit */
+		prm_clear_mod_reg_bits(PRM_VP1_CONFIG_INITVDD, OMAP3430_GR_MOD,
+					OMAP3_PRM_VP1_CONFIG_OFFSET);
+
+	} else if (srid == SR2) {
+		vpconfig = PRM_VP2_CONFIG_ERROROFFSET | PRM_VP2_CONFIG_ERRORGAIN
+					| PRM_VP2_CONFIG_INITVOLTAGE
+					| PRM_VP2_CONFIG_TIMEOUTEN;
+
+		prm_write_mod_reg(vpconfig, OMAP3430_GR_MOD,
+					OMAP3_PRM_VP2_CONFIG_OFFSET);
+		prm_write_mod_reg(PRM_VP2_VSTEPMIN_SMPSWAITTIMEMIN |
+					PRM_VP2_VSTEPMIN_VSTEPMIN,
+					OMAP3430_GR_MOD,
+					OMAP3_PRM_VP2_VSTEPMIN_OFFSET);
+
+		prm_write_mod_reg(PRM_VP2_VSTEPMAX_SMPSWAITTIMEMAX |
+					PRM_VP2_VSTEPMAX_VSTEPMAX,
+					OMAP3430_GR_MOD,
+					OMAP3_PRM_VP2_VSTEPMAX_OFFSET);
+
+		prm_write_mod_reg(PRM_VP2_VLIMITTO_VDDMAX |
+					PRM_VP2_VLIMITTO_VDDMIN |
+					PRM_VP2_VLIMITTO_TIMEOUT,
+					OMAP3430_GR_MOD,
+					OMAP3_PRM_VP2_VLIMITTO_OFFSET);
+
+		/* Trigger initVDD value copy to voltage processor */
+		prm_set_mod_reg_bits(PRM_VP2_CONFIG_INITVDD, OMAP3430_GR_MOD,
+					OMAP3_PRM_VP2_CONFIG_OFFSET);
+		/* Reset initVDD copy trigger bit */
+		prm_clear_mod_reg_bits(PRM_VP2_CONFIG_INITVDD, OMAP3430_GR_MOD,
+					OMAP3_PRM_VP2_CONFIG_OFFSET);
+
+	}
+}
+
+static void sr_configure(struct omap_sr *sr)
+{
+	u32 sr_config;
+	u32 senp_en , senn_en;
+
+	if (sr->clk_length == 0)
+		sr_set_clk_length(sr);
+
+	senp_en = sr->senp_mod;
+	senn_en = sr->senn_mod;
+	if (sr->srid == SR1) {
+		sr_config = SR1_SRCONFIG_ACCUMDATA |
+			(sr->clk_length << SRCONFIG_SRCLKLENGTH_SHIFT) |
+			SRCONFIG_SENENABLE | SRCONFIG_ERRGEN_EN |
+			SRCONFIG_MINMAXAVG_EN |
+			(senn_en << SRCONFIG_SENNENABLE_SHIFT) |
+			(senp_en << SRCONFIG_SENPENABLE_SHIFT) |
+			SRCONFIG_DELAYCTRL;
+
+		sr_write_reg(sr, SRCONFIG, sr_config);
+		sr_write_reg(sr, AVGWEIGHT, SR1_AVGWEIGHT_SENPAVGWEIGHT |
+					SR1_AVGWEIGHT_SENNAVGWEIGHT);
+
+		sr_modify_reg(sr, ERRCONFIG, (SR_ERRWEIGHT_MASK |
+			SR_ERRMAXLIMIT_MASK | SR_ERRMINLIMIT_MASK),
+			(SR1_ERRWEIGHT | SR1_ERRMAXLIMIT | SR1_ERRMINLIMIT));
+
+	} else if (sr->srid == SR2) {
+		sr_config = SR2_SRCONFIG_ACCUMDATA |
+			(sr->clk_length << SRCONFIG_SRCLKLENGTH_SHIFT) |
+			SRCONFIG_SENENABLE | SRCONFIG_ERRGEN_EN |
+			SRCONFIG_MINMAXAVG_EN |
+			(senn_en << SRCONFIG_SENNENABLE_SHIFT) |
+			(senp_en << SRCONFIG_SENPENABLE_SHIFT) |
+			SRCONFIG_DELAYCTRL;
+
+		sr_write_reg(sr, SRCONFIG, sr_config);
+		sr_write_reg(sr, AVGWEIGHT, SR2_AVGWEIGHT_SENPAVGWEIGHT |
+					SR2_AVGWEIGHT_SENNAVGWEIGHT);
+		sr_modify_reg(sr, ERRCONFIG, (SR_ERRWEIGHT_MASK |
+			SR_ERRMAXLIMIT_MASK | SR_ERRMINLIMIT_MASK),
+			(SR2_ERRWEIGHT | SR2_ERRMAXLIMIT | SR2_ERRMINLIMIT));
+
+	}
+	sr->is_sr_reset = 0;
+}
+
+static int sr_enable(struct omap_sr *sr, u32 target_opp_no)
+{
+	u32 nvalue_reciprocal;
+
+	sr->req_opp_no = target_opp_no;
+
+	if (sr->srid == SR1) {
+		switch (target_opp_no) {
+		case 5:
+			nvalue_reciprocal = sr->opp5_nvalue;
+			break;
+		case 4:
+			nvalue_reciprocal = sr->opp4_nvalue;
+			break;
+		case 3:
+			nvalue_reciprocal = sr->opp3_nvalue;
+			break;
+		case 2:
+			nvalue_reciprocal = sr->opp2_nvalue;
+			break;
+		case 1:
+			nvalue_reciprocal = sr->opp1_nvalue;
+			break;
+		default:
+			nvalue_reciprocal = sr->opp3_nvalue;
+			break;
+		}
+	} else {
+		switch (target_opp_no) {
+		case 3:
+			nvalue_reciprocal = sr->opp3_nvalue;
+			break;
+		case 2:
+			nvalue_reciprocal = sr->opp2_nvalue;
+			break;
+		case 1:
+			nvalue_reciprocal = sr->opp1_nvalue;
+			break;
+		default:
+			nvalue_reciprocal = sr->opp3_nvalue;
+			break;
+		}
+	}
+
+	if (nvalue_reciprocal == 0) {
+		printk(KERN_NOTICE "OPP%d doesn't support SmartReflex\n",
+								target_opp_no);
+		return SR_FALSE;
+	}
+
+	sr_write_reg(sr, NVALUERECIPROCAL, nvalue_reciprocal);
+
+	/* Enable the interrupt */
+	sr_modify_reg(sr, ERRCONFIG,
+			(ERRCONFIG_VPBOUNDINTEN | ERRCONFIG_VPBOUNDINTST),
+			(ERRCONFIG_VPBOUNDINTEN | ERRCONFIG_VPBOUNDINTST));
+	if (sr->srid == SR1) {
+		/* Enable VP1 */
+		prm_set_mod_reg_bits(PRM_VP1_CONFIG_VPENABLE, OMAP3430_GR_MOD,
+				OMAP3_PRM_VP1_CONFIG_OFFSET);
+	} else if (sr->srid == SR2) {
+		/* Enable VP2 */
+		prm_set_mod_reg_bits(PRM_VP2_CONFIG_VPENABLE, OMAP3430_GR_MOD,
+				OMAP3_PRM_VP2_CONFIG_OFFSET);
+	}
+
+	/* SRCONFIG - enable SR */
+	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, SRCONFIG_SRENABLE);
+	return SR_TRUE;
+}
+
+static void sr_disable(struct omap_sr *sr)
+{
+	sr->is_sr_reset = 1;
+
+	/* SRCONFIG - disable SR */
+	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, ~SRCONFIG_SRENABLE);
+
+	if (sr->srid == SR1) {
+		/* Disable VP1 */
+		prm_clear_mod_reg_bits(PRM_VP1_CONFIG_VPENABLE, OMAP3430_GR_MOD,
+					OMAP3_PRM_VP1_CONFIG_OFFSET);
+	} else if (sr->srid == SR2) {
+		/* Disable VP2 */
+		prm_clear_mod_reg_bits(PRM_VP2_CONFIG_VPENABLE, OMAP3430_GR_MOD,
+					OMAP3_PRM_VP2_CONFIG_OFFSET);
+	}
+}
+
+
+void sr_start_vddautocomap(int srid, u32 target_opp_no)
+{
+	struct omap_sr *sr = NULL;
+
+	if (srid == SR1)
+		sr = &sr1;
+	else if (srid == SR2)
+		sr = &sr2;
+
+	if (sr->is_sr_reset == 1) {
+		sr_clk_enable(sr);
+		sr_configure(sr);
+	}
+
+	if (sr->is_autocomp_active == 1)
+		printk(KERN_WARNING "SR%d: VDD autocomp is already active\n",
+									srid);
+
+	sr->is_autocomp_active = 1;
+	if (!sr_enable(sr, target_opp_no)) {
+		printk(KERN_WARNING "SR%d: VDD autocomp not activated\n", srid);
+		sr->is_autocomp_active = 0;
+		if (sr->is_sr_reset == 1)
+			sr_clk_disable(sr);
+	}
+}
+EXPORT_SYMBOL(sr_start_vddautocomap);
+
+int sr_stop_vddautocomap(int srid)
+{
+	struct omap_sr *sr = NULL;
+
+	if (srid == SR1)
+		sr = &sr1;
+	else if (srid == SR2)
+		sr = &sr2;
+
+	if (sr->is_autocomp_active == 1) {
+		sr_disable(sr);
+		sr_clk_disable(sr);
+		sr->is_autocomp_active = 0;
+		return SR_TRUE;
+	} else {
+		printk(KERN_WARNING "SR%d: VDD autocomp is not active\n",
+								srid);
+		return SR_FALSE;
+	}
+
+}
+EXPORT_SYMBOL(sr_stop_vddautocomap);
+
+void enable_smartreflex(int srid)
+{
+	u32 target_opp_no = 0;
+	struct omap_sr *sr = NULL;
+
+	if (srid == SR1)
+		sr = &sr1;
+	else if (srid == SR2)
+		sr = &sr2;
+
+	if (sr->is_autocomp_active == 1) {
+		if (sr->is_sr_reset == 1) {
+			/* Enable SR clks */
+			sr_clk_enable(sr);
+
+			if (srid == SR1)
+				target_opp_no = get_opp_no(current_vdd1_opp);
+			else if (srid == SR2)
+				target_opp_no = get_opp_no(current_vdd2_opp);
+
+			sr_configure(sr);
+
+			if (!sr_enable(sr, target_opp_no))
+				sr_clk_disable(sr);
+		}
+	}
+}
+
+void disable_smartreflex(int srid)
+{
+	struct omap_sr *sr = NULL;
+
+	if (srid == SR1)
+		sr = &sr1;
+	else if (srid == SR2)
+		sr = &sr2;
+
+	if (sr->is_autocomp_active == 1) {
+		if (sr->is_sr_reset == 0) {
+
+			sr->is_sr_reset = 1;
+			/* SRCONFIG - disable SR */
+			sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE,
+							~SRCONFIG_SRENABLE);
+
+			/* Disable SR clk */
+			sr_clk_disable(sr);
+			if (sr->srid == SR1) {
+				/* Disable VP1 */
+				prm_clear_mod_reg_bits(PRM_VP1_CONFIG_VPENABLE,
+						OMAP3430_GR_MOD,
+						OMAP3_PRM_VP1_CONFIG_OFFSET);
+			} else if (sr->srid == SR2) {
+				/* Disable VP2 */
+				prm_clear_mod_reg_bits(PRM_VP2_CONFIG_VPENABLE,
+						OMAP3430_GR_MOD,
+						OMAP3_PRM_VP2_CONFIG_OFFSET);
+			}
+		}
+	}
+}
+
+/* Voltage Scaling using SR VCBYPASS */
+int sr_voltagescale_vcbypass(u32 target_opp, u8 vsel)
+{
+	int sr_status = 0;
+	u32 vdd, target_opp_no;
+	u32 vc_bypass_value;
+	u32 reg_addr = 0;
+	u32 loop_cnt = 0, retries_cnt = 0;
+
+	vdd = get_vdd(target_opp);
+	target_opp_no = get_opp_no(target_opp);
+
+	if (vdd == PRCM_VDD1) {
+		sr_status = sr_stop_vddautocomap(SR1);
+
+		prm_rmw_mod_reg_bits(OMAP3430_VC_CMD_ON_MASK,
+					(vsel << OMAP3430_VC_CMD_ON_SHIFT),
+					OMAP3430_GR_MOD,
+					OMAP3_PRM_VC_CMD_VAL_0_OFFSET);
+		reg_addr = R_VDD1_SR_CONTROL;
+
+	} else if (vdd == PRCM_VDD2) {
+		sr_status = sr_stop_vddautocomap(SR2);
+
+		prm_rmw_mod_reg_bits(OMAP3430_VC_CMD_ON_MASK,
+					(vsel << OMAP3430_VC_CMD_ON_SHIFT),
+					OMAP3430_GR_MOD,
+					OMAP3_PRM_VC_CMD_VAL_1_OFFSET);
+		reg_addr = R_VDD2_SR_CONTROL;
+	}
+
+	vc_bypass_value = (vsel << OMAP3430_DATA_SHIFT) |
+			(reg_addr << OMAP3430_REGADDR_SHIFT) |
+			(R_SRI2C_SLAVE_ADDR << OMAP3430_SLAVEADDR_SHIFT);
+
+	prm_write_mod_reg(vc_bypass_value, OMAP3430_GR_MOD,
+			OMAP3_PRM_VC_BYPASS_VAL_OFFSET);
+
+	vc_bypass_value = prm_set_mod_reg_bits(OMAP3430_VALID, OMAP3430_GR_MOD,
+					OMAP3_PRM_VC_BYPASS_VAL_OFFSET);
+
+	while ((vc_bypass_value & OMAP3430_VALID) != 0x0) {
+		loop_cnt++;
+		if (retries_cnt > 10) {
+			printk(KERN_INFO "Loop count exceeded in check SR I2C"
+								"write\n");
+			return SR_FAIL;
+		}
+		if (loop_cnt > 50) {
+			retries_cnt++;
+			loop_cnt = 0;
+			udelay(10);
+		}
+		vc_bypass_value = prm_read_mod_reg(OMAP3430_GR_MOD,
+					OMAP3_PRM_VC_BYPASS_VAL_OFFSET);
+	}
+
+	udelay(T2_SMPS_UPDATE_DELAY);
+
+	if (sr_status) {
+		if (vdd == PRCM_VDD1)
+			sr_start_vddautocomap(SR1, target_opp_no);
+		else if (vdd == PRCM_VDD2)
+			sr_start_vddautocomap(SR2, target_opp_no);
+	}
+
+	return SR_PASS;
+}
+
+/* Sysfs interface to select SR VDD1 auto compensation */
+static ssize_t omap_sr_vdd1_autocomp_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", sr1.is_autocomp_active);
+}
+
+static ssize_t omap_sr_vdd1_autocomp_store(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					const char *buf, size_t n)
+{
+	u32 current_vdd1opp_no;
+	unsigned short value;
+
+	if (sscanf(buf, "%hu", &value) != 1 || (value > 1)) {
+		printk(KERN_ERR "sr_vdd1_autocomp: Invalid value\n");
+		return -EINVAL;
+	}
+
+	current_vdd1opp_no = get_opp_no(current_vdd1_opp);
+
+	if (value == 0)
+		sr_stop_vddautocomap(SR1);
+	else
+		sr_start_vddautocomap(SR1, current_vdd1opp_no);
+
+	return n;
+}
+
+static struct kobj_attribute sr_vdd1_autocomp = {
+	.attr = {
+	.name = __stringify(sr_vdd1_autocomp),
+	.mode = 0644,
+	},
+	.show = omap_sr_vdd1_autocomp_show,
+	.store = omap_sr_vdd1_autocomp_store,
+};
+
+/* Sysfs interface to select SR VDD2 auto compensation */
+static ssize_t omap_sr_vdd2_autocomp_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", sr2.is_autocomp_active);
+}
+
+static ssize_t omap_sr_vdd2_autocomp_store(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					const char *buf, size_t n)
+{
+	u32 current_vdd2opp_no;
+	unsigned short value;
+
+	if (sscanf(buf, "%hu", &value) != 1 || (value > 1)) {
+		printk(KERN_ERR "sr_vdd2_autocomp: Invalid value\n");
+		return -EINVAL;
+	}
+
+	current_vdd2opp_no = get_opp_no(current_vdd2_opp);
+
+	if (value == 0)
+		sr_stop_vddautocomap(SR2);
+	else
+		sr_start_vddautocomap(SR2, current_vdd2opp_no);
+
+	return n;
+}
+
+static struct kobj_attribute sr_vdd2_autocomp = {
+	.attr = {
+	.name = __stringify(sr_vdd2_autocomp),
+	.mode = 0644,
+	},
+	.show = omap_sr_vdd2_autocomp_show,
+	.store = omap_sr_vdd2_autocomp_store,
+};
+
+
+
+static int __init omap3_sr_init(void)
+{
+	int ret = 0;
+	u8 RdReg;
+
+	if (omap_rev() > OMAP3430_REV_ES1_0) {
+		current_vdd1_opp = PRCM_VDD1_OPP3;
+		current_vdd2_opp = PRCM_VDD2_OPP3;
+	} else {
+		current_vdd1_opp = PRCM_VDD1_OPP1;
+		current_vdd2_opp = PRCM_VDD1_OPP1;
+	}
+	if (cpu_is_omap34xx()) {
+		sr1.clk = clk_get(NULL, "sr1_fck");
+		sr2.clk = clk_get(NULL, "sr2_fck");
+	}
+	sr_set_clk_length(&sr1);
+	sr_set_clk_length(&sr2);
+
+	/* Call the VPConfig, VCConfig, set N Values. */
+	sr_set_nvalues(&sr1);
+	sr_configure_vp(SR1);
+
+	sr_set_nvalues(&sr2);
+	sr_configure_vp(SR2);
+
+	/* Enable SR on T2 */
+	ret = twl4030_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &RdReg,
+					R_DCDC_GLOBAL_CFG);
+
+	RdReg |= DCDC_GLOBAL_CFG_ENABLE_SRFLX;
+	ret |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, RdReg,
+					R_DCDC_GLOBAL_CFG);
+
+	printk(KERN_INFO "SmartReflex driver initialized\n");
+
+	ret = sysfs_create_file(power_kobj, &sr_vdd1_autocomp.attr);
+	if (ret)
+		printk(KERN_ERR "sysfs_create_file failed: %d\n", ret);
+
+	ret = sysfs_create_file(power_kobj, &sr_vdd2_autocomp.attr);
+	if (ret)
+		printk(KERN_ERR "sysfs_create_file failed: %d\n", ret);
+
+	return 0;
+}
+
+late_initcall(omap3_sr_init);
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
new file mode 100644
index 0000000..be6e6b9
--- /dev/null
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -0,0 +1,259 @@
+#ifndef __ARCH_ARM_MACH_OMAP3_SMARTREFLEX_H
+#define __ARCH_ARM_MACH_OMAP3_SMARTREFLEX_H
+/*
+ * linux/arch/arm/mach-omap2/smartreflex.h
+ *
+ * Copyright (C) 2008 Nokia Corporation
+ * Kalle Jokiniemi
+ *
+ * Copyright (C) 2007 Texas Instruments, Inc.
+ * Lesly A M <x0080970@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define PHY_TO_OFF_PM_MASTER(p)		(p - 0x36)
+#define PHY_TO_OFF_PM_RECIEVER(p)	(p - 0x5b)
+#define PHY_TO_OFF_PM_INT(p)		(p - 0x2e)
+
+/* SMART REFLEX REG ADDRESS OFFSET */
+#define SRCONFIG	0x00
+#define SRSTATUS	0x04
+#define SENVAL		0x08
+#define SENMIN		0x0C
+#define SENMAX		0x10
+#define SENAVG		0x14
+#define AVGWEIGHT	0x18
+#define NVALUERECIPROCAL	0x1C
+#define SENERROR	0x20
+#define ERRCONFIG	0x24
+
+/* SR Modules */
+#define SR1		1
+#define SR2		2
+
+#define SR_FAIL		1
+#define SR_PASS		0
+
+#define SR_TRUE		1
+#define SR_FALSE	0
+
+#define GAIN_MAXLIMIT	16
+#define R_MAXLIMIT	256
+
+#define SR1_CLK_ENABLE	(0x1 << 6)
+#define SR2_CLK_ENABLE	(0x1 << 7)
+
+/* PRM_VP1_CONFIG */
+#define PRM_VP1_CONFIG_ERROROFFSET	(0x00 << 24)
+#define PRM_VP1_CONFIG_ERRORGAIN	(0x20 << 16)
+
+#define PRM_VP1_CONFIG_INITVOLTAGE	(0x30 << 8) /* 1.2 volt */
+#define PRM_VP1_CONFIG_TIMEOUTEN	(0x1 << 3)
+#define PRM_VP1_CONFIG_INITVDD		(0x1 << 2)
+#define PRM_VP1_CONFIG_FORCEUPDATE	(0x1 << 1)
+#define PRM_VP1_CONFIG_VPENABLE		(0x1 << 0)
+
+/* PRM_VP1_VSTEPMIN */
+#define PRM_VP1_VSTEPMIN_SMPSWAITTIMEMIN	(0x01F4 << 8)
+#define PRM_VP1_VSTEPMIN_VSTEPMIN		(0x01 << 0)
+
+/* PRM_VP1_VSTEPMAX */
+#define PRM_VP1_VSTEPMAX_SMPSWAITTIMEMAX	(0x01F4 << 8)
+#define PRM_VP1_VSTEPMAX_VSTEPMAX		(0x04 << 0)
+
+/* PRM_VP1_VLIMITTO */
+#define PRM_VP1_VLIMITTO_VDDMAX		(0x3C << 24)
+#define PRM_VP1_VLIMITTO_VDDMIN		(0x0 << 16)
+#define PRM_VP1_VLIMITTO_TIMEOUT	(0xFFFF << 0)
+
+/* PRM_VP2_CONFIG */
+#define PRM_VP2_CONFIG_ERROROFFSET	(0x00 << 24)
+#define PRM_VP2_CONFIG_ERRORGAIN	(0x20 << 16)
+
+#define PRM_VP2_CONFIG_INITVOLTAGE	(0x30 << 8) /* 1.2 volt */
+#define PRM_VP2_CONFIG_TIMEOUTEN	(0x1 << 3)
+#define PRM_VP2_CONFIG_INITVDD		(0x1 << 2)
+#define PRM_VP2_CONFIG_FORCEUPDATE	(0x1 << 1)
+#define PRM_VP2_CONFIG_VPENABLE		(0x1 << 0)
+
+/* PRM_VP2_VSTEPMIN */
+#define PRM_VP2_VSTEPMIN_SMPSWAITTIMEMIN	(0x01F4 << 8)
+#define PRM_VP2_VSTEPMIN_VSTEPMIN		(0x01 << 0)
+
+/* PRM_VP2_VSTEPMAX */
+#define PRM_VP2_VSTEPMAX_SMPSWAITTIMEMAX	(0x01F4 << 8)
+#define PRM_VP2_VSTEPMAX_VSTEPMAX		(0x04 << 0)
+
+/* PRM_VP2_VLIMITTO */
+#define PRM_VP2_VLIMITTO_VDDMAX		(0x2C << 24)
+#define PRM_VP2_VLIMITTO_VDDMIN		(0x0 << 16)
+#define PRM_VP2_VLIMITTO_TIMEOUT	(0xFFFF << 0)
+
+/* SRCONFIG */
+#define SR1_SRCONFIG_ACCUMDATA		(0x1F4 << 22)
+#define SR2_SRCONFIG_ACCUMDATA		(0x1F4 << 22)
+
+#define SRCLKLENGTH_12MHZ_SYSCLK	0x3C
+#define SRCLKLENGTH_13MHZ_SYSCLK	0x41
+#define SRCLKLENGTH_19MHZ_SYSCLK	0x60
+#define SRCLKLENGTH_26MHZ_SYSCLK	0x82
+#define SRCLKLENGTH_38MHZ_SYSCLK	0xC0
+
+#define SRCONFIG_SRCLKLENGTH_SHIFT	12
+#define SRCONFIG_SENNENABLE_SHIFT	5
+#define SRCONFIG_SENPENABLE_SHIFT	3
+
+#define SRCONFIG_SRENABLE		(0x01 << 11)
+#define SRCONFIG_SENENABLE		(0x01 << 10)
+#define SRCONFIG_ERRGEN_EN		(0x01 << 9)
+#define SRCONFIG_MINMAXAVG_EN		(0x01 << 8)
+
+#define SRCONFIG_DELAYCTRL		(0x01 << 2)
+#define SRCONFIG_CLKCTRL		(0x00 << 0)
+
+/* AVGWEIGHT */
+#define SR1_AVGWEIGHT_SENPAVGWEIGHT	(0x03 << 2)
+#define SR1_AVGWEIGHT_SENNAVGWEIGHT	(0x03 << 0)
+
+#define SR2_AVGWEIGHT_SENPAVGWEIGHT	(0x01 << 2)
+#define SR2_AVGWEIGHT_SENNAVGWEIGHT	(0x01 << 0)
+
+/* NVALUERECIPROCAL */
+#define NVALUERECIPROCAL_SENPGAIN_SHIFT	20
+#define NVALUERECIPROCAL_SENNGAIN_SHIFT	16
+#define NVALUERECIPROCAL_RNSENP_SHIFT	8
+#define NVALUERECIPROCAL_RNSENN_SHIFT	0
+
+/* ERRCONFIG */
+#define SR_CLKACTIVITY_MASK		(0x03 << 20)
+#define SR_ERRWEIGHT_MASK		(0x07 << 16)
+#define SR_ERRMAXLIMIT_MASK		(0xFF << 8)
+#define SR_ERRMINLIMIT_MASK		(0xFF << 0)
+
+#define SR_CLKACTIVITY_IOFF_FOFF	(0x00 << 20)
+#define SR_CLKACTIVITY_IOFF_FON		(0x02 << 20)
+
+#define ERRCONFIG_VPBOUNDINTEN		(0x1 << 31)
+#define ERRCONFIG_VPBOUNDINTST		(0x1 << 30)
+
+#define SR1_ERRWEIGHT			(0x07 << 16)
+#define SR1_ERRMAXLIMIT			(0x02 << 8)
+#define SR1_ERRMINLIMIT			(0xFA << 0)
+
+#define SR2_ERRWEIGHT			(0x07 << 16)
+#define SR2_ERRMAXLIMIT			(0x02 << 8)
+#define SR2_ERRMINLIMIT			(0xF9 << 0)
+
+/* T2 SMART REFLEX */
+#define R_SRI2C_SLAVE_ADDR		0x12
+#define R_VDD1_SR_CONTROL		0x00
+#define R_VDD2_SR_CONTROL		0x01
+#define T2_SMPS_UPDATE_DELAY		360	/* In uSec */
+
+/* Vmode control */
+#define R_DCDC_GLOBAL_CFG	PHY_TO_OFF_PM_RECIEVER(0x61)
+
+#define R_VDD1_VSEL		PHY_TO_OFF_PM_RECIEVER(0xb9)
+#define R_VDD1_VMODE_CFG	PHY_TO_OFF_PM_RECIEVER(0xba)
+#define R_VDD1_VFLOOR		PHY_TO_OFF_PM_RECIEVER(0xbb)
+#define R_VDD1_VROOF		PHY_TO_OFF_PM_RECIEVER(0xbc)
+#define R_VDD1_STEP		PHY_TO_OFF_PM_RECIEVER(0xbd)
+
+#define R_VDD2_VSEL		PHY_TO_OFF_PM_RECIEVER(0xc7)
+#define R_VDD2_VMODE_CFG	PHY_TO_OFF_PM_RECIEVER(0xc8)
+#define R_VDD2_VFLOOR		PHY_TO_OFF_PM_RECIEVER(0xc9)
+#define R_VDD2_VROOF		PHY_TO_OFF_PM_RECIEVER(0xca)
+#define R_VDD2_STEP		PHY_TO_OFF_PM_RECIEVER(0xcb)
+
+/* R_DCDC_GLOBAL_CFG register, SMARTREFLEX_ENABLE values */
+#define DCDC_GLOBAL_CFG_ENABLE_SRFLX	0x08
+
+/* VDDs*/
+#define PRCM_VDD1	1
+#define PRCM_VDD2	2
+#define PRCM_MAX_SYSC_REGS 30
+
+/*
+ * XXX: These should be removed/moved from here once we have a working DVFS
+ * implementation in place
+ */
+#define AT_3430		1	/*3430 ES 1.0 */
+#define AT_3430_ES2	2	/*3430 ES 2.0 */
+
+#define ID_OPP			0xE2 	/*OPP*/
+
+/* DEVICE ID/DPLL ID/CLOCK ID: bits 28-31 for OMAP type */
+#define OMAP_TYPE_SHIFT		28
+#define OMAP_TYPE_MASK		0xF
+/* OPP ID: bits: 0-4 for OPP number */
+#define OPP_NO_POS		0
+#define OPP_NO_MASK		0x1F
+/* OPP ID: bits: 5-6 for VDD */
+#define VDD_NO_POS		5
+#define VDD_NO_MASK		0x3
+/* Other IDs: bits 20-27 for ID type */
+/* These IDs have bits 25,26,27 as 1 */
+#define OTHER_ID_TYPE_SHIFT		20
+#define OTHER_ID_TYPE_MASK		0xFF
+
+#define OTHER_ID_TYPE(X) ((X & OTHER_ID_TYPE_MASK) << OTHER_ID_TYPE_SHIFT)
+#define ID_OPP_NO(X)	 ((X & OPP_NO_MASK) << OPP_NO_POS)
+#define ID_VDD(X)	 ((X & VDD_NO_MASK) << VDD_NO_POS)
+#define OMAP(X)		 ((X >> OMAP_TYPE_SHIFT) & OMAP_TYPE_MASK)
+#define get_opp_no(X)	 ((X >> OPP_NO_POS) & OPP_NO_MASK)
+#define get_vdd(X)	 ((X >> VDD_NO_POS) & VDD_NO_MASK)
+
+/* VDD1 OPPs */
+#define PRCM_VDD1_OPP1		(OMAP(AT_3430_ES2) | OTHER_ID_TYPE(ID_OPP) | \
+					ID_VDD(PRCM_VDD1) | ID_OPP_NO(0x1))
+#define PRCM_VDD1_OPP2		(OMAP(AT_3430_ES2) | OTHER_ID_TYPE(ID_OPP) | \
+					ID_VDD(PRCM_VDD1) | ID_OPP_NO(0x2))
+#define PRCM_VDD1_OPP3		(OMAP(AT_3430_ES2) | OTHER_ID_TYPE(ID_OPP) | \
+					ID_VDD(PRCM_VDD1) | ID_OPP_NO(0x3))
+#define PRCM_VDD1_OPP4		(OMAP(AT_3430_ES2) | OTHER_ID_TYPE(ID_OPP) | \
+					ID_VDD(PRCM_VDD1) | ID_OPP_NO(0x4))
+#define PRCM_VDD1_OPP5		(OMAP(AT_3430_ES2) | OTHER_ID_TYPE(ID_OPP) | \
+					ID_VDD(PRCM_VDD1) | ID_OPP_NO(0x5))
+#define PRCM_NO_VDD1_OPPS	5
+
+
+/* VDD2 OPPs */
+#define PRCM_VDD2_OPP1		(OMAP(AT_3430_ES2) | OTHER_ID_TYPE(ID_OPP) | \
+					ID_VDD(PRCM_VDD2) | ID_OPP_NO(0x1))
+#define PRCM_VDD2_OPP2		(OMAP(AT_3430_ES2) | OTHER_ID_TYPE(ID_OPP) | \
+					ID_VDD(PRCM_VDD2) | ID_OPP_NO(0x2))
+#define PRCM_VDD2_OPP3		(OMAP(AT_3430_ES2) | OTHER_ID_TYPE(ID_OPP) | \
+					ID_VDD(PRCM_VDD2) | ID_OPP_NO(0x3))
+#define PRCM_NO_VDD2_OPPS	3
+/* XXX: end remove/move */
+
+/* XXX: find more appropriate place for these once DVFS is in place */
+extern u32 current_vdd1_opp;
+extern u32 current_vdd2_opp;
+
+#ifdef CONFIG_OMAP_SMARTREFLEX_TESTING
+#define SR_TESTING_NVALUES 	1
+#else
+#define SR_TESTING_NVALUES 	0
+#endif
+
+/*
+ * Smartreflex module enable/disable interface.
+ * NOTE: if smartreflex is not enabled from sysfs, these functions will not
+ * do anything.
+ */
+#ifdef CONFIG_OMAP_SMARTREFLEX
+void enable_smartreflex(int srid);
+void disable_smartreflex(int srid);
+int sr_voltagescale_vcbypass(u32 target_opp, u8 vsel);
+void sr_start_vddautocomap(int srid, u32 target_opp_no);
+int sr_stop_vddautocomap(int srid);
+#else
+static inline void enable_smartreflex(int srid) {}
+static inline void disable_smartreflex(int srid) {}
+#endif
+
+#endif
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 46d3b0b..91f8b8b 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -58,6 +58,37 @@ config OMAP_DEBUG_CLOCKDOMAIN
 	  for every clockdomain register write.  However, the
 	  extra detail costs some memory.
 
+config OMAP_SMARTREFLEX
+	bool "SmartReflex support"
+	depends on ARCH_OMAP34XX && TWL4030_CORE && PM
+	help
+	  Say Y if you want to enable SmartReflex.
+
+	  SmartReflex can perform continuous dynamic voltage
+	  scaling around the nominal operating point voltage
+	  according to silicon characteristics and operating
+	  conditions. Enabling SmartReflex reduces power
+	  consumption.
+
+	  Please note, that by default SmartReflex is only
+	  initialized. To enable the automatic voltage
+	  compensation for VDD1 and VDD2, user must write 1 to
+	  /sys/power/sr_vddX_autocomp, where X is 1 or 2.
+
+config OMAP_SMARTREFLEX_TESTING
+	bool "Smartreflex testing support"
+	depends on OMAP_SMARTREFLEX
+	default n
+	help
+	  Say Y if you want to enable SmartReflex testing with SW hardcoded
+	  NVALUES intead of E-fuse NVALUES set in factory silicon testing.
+
+	  In some devices the E-fuse values have not been set, even though
+	  SmartReflex modules are included. Using these hardcoded values set
+	  in software, one can test the SmartReflex features without E-fuse.
+
+	  WARNING: Enabling this option may cause your device to hang!
+
 config OMAP_RESET_CLOCKS
 	bool "Reset unused clocks during boot"
 	depends on ARCH_OMAP
diff --git a/arch/arm/plat-omap/include/mach/control.h b/arch/arm/plat-omap/include/mach/control.h
index 269147f..8a65bd2 100644
--- a/arch/arm/plat-omap/include/mach/control.h
+++ b/arch/arm/plat-omap/include/mach/control.h
@@ -139,6 +139,15 @@
 #define OMAP343X_CONTROL_TEST_KEY_11	(OMAP2_CONTROL_GENERAL + 0x00f4)
 #define OMAP343X_CONTROL_TEST_KEY_12	(OMAP2_CONTROL_GENERAL + 0x00f8)
 #define OMAP343X_CONTROL_TEST_KEY_13	(OMAP2_CONTROL_GENERAL + 0x00fc)
+#define OMAP343X_CONTROL_FUSE_OPP1_VDD1	(OMAP2_CONTROL_GENERAL + 0x0110)
+#define OMAP343X_CONTROL_FUSE_OPP2_VDD1	(OMAP2_CONTROL_GENERAL + 0x0114)
+#define OMAP343X_CONTROL_FUSE_OPP3_VDD1	(OMAP2_CONTROL_GENERAL + 0x0118)
+#define OMAP343X_CONTROL_FUSE_OPP4_VDD1	(OMAP2_CONTROL_GENERAL + 0x011c)
+#define OMAP343X_CONTROL_FUSE_OPP5_VDD1	(OMAP2_CONTROL_GENERAL + 0x0120)
+#define OMAP343X_CONTROL_FUSE_OPP1_VDD2	(OMAP2_CONTROL_GENERAL + 0x0124)
+#define OMAP343X_CONTROL_FUSE_OPP2_VDD2	(OMAP2_CONTROL_GENERAL + 0x0128)
+#define OMAP343X_CONTROL_FUSE_OPP3_VDD2	(OMAP2_CONTROL_GENERAL + 0x012c)
+#define OMAP343X_CONTROL_FUSE_SR	(OMAP2_CONTROL_GENERAL + 0x0130)
 #define OMAP343X_CONTROL_IVA2_BOOTADDR	(OMAP2_CONTROL_GENERAL + 0x0190)
 #define OMAP343X_CONTROL_IVA2_BOOTMOD	(OMAP2_CONTROL_GENERAL + 0x0194)
 #define OMAP343X_CONTROL_PBIAS_LITE	(OMAP2_CONTROL_GENERAL + 0x02b0)
@@ -176,6 +185,15 @@
 #define OMAP2_SYSBOOT_2_MASK		(1 << 2)
 #define OMAP2_SYSBOOT_1_MASK		(1 << 1)
 #define OMAP2_SYSBOOT_0_MASK		(1 << 0)
+/* CONTROL_FUSE_SR bits */
+#define OMAP343X_SR2_SENNENABLE_MASK	(0x3 << 10)
+#define OMAP343X_SR2_SENNENABLE_SHIFT	10
+#define OMAP343X_SR2_SENPENABLE_MASK	(0x3 << 8)
+#define OMAP343X_SR2_SENPENABLE_SHIFT	8
+#define OMAP343X_SR1_SENNENABLE_MASK	(0x3 << 2)
+#define OMAP343X_SR1_SENNENABLE_SHIFT	2
+#define OMAP343X_SR1_SENPENABLE_MASK	(0x3 << 0)
+#define OMAP343X_SR1_SENPENABLE_SHIFT	0
 
 /* CONTROL_PBIAS_LITE bits */
 #define OMAP343X_PBIASLITESUPPLY_HIGH1	(1 << 15)
diff --git a/arch/arm/plat-omap/include/mach/omap34xx.h b/arch/arm/plat-omap/include/mach/omap34xx.h
index 8e0479f..3eb075d 100644
--- a/arch/arm/plat-omap/include/mach/omap34xx.h
+++ b/arch/arm/plat-omap/include/mach/omap34xx.h
@@ -53,7 +53,8 @@
 #define OMAP34XX_HSUSB_OTG_BASE	(L4_34XX_BASE + 0xAB000)
 #define OMAP34XX_HSUSB_HOST_BASE	(L4_34XX_BASE + 0x64000)
 #define OMAP34XX_USBTLL_BASE	(L4_34XX_BASE + 0x62000)
-
+#define OMAP34XX_SR1_BASE	0x480C9000
+#define OMAP34XX_SR2_BASE	0x480CB000
 
 #if defined(CONFIG_ARCH_OMAP3430)
 
-- 
1.6.1

