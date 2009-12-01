From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 2/5] ARM: OMAP4: PM: Basic OMAP4 clock framework
Date: Tue,  1 Dec 2009 17:57:25 +0530
Message-ID: <1259670448-19840-2-git-send-email-rnayak@ti.com>
References: <1259670448-19840-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50262 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231AbZLAM1d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 07:27:33 -0500
In-Reply-To: <1259670448-19840-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

This patch registers the OMAP4430 clock
nodes with the CLKDEV framework.
Enables CLKDEV for OMAP4.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/Makefile            |    8 +-
 arch/arm/mach-omap2/clock.c             |    8 +
 arch/arm/mach-omap2/clock44xx.c         |  331 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/cm.h                |    4 +
 arch/arm/mach-omap2/gpmc.c              |    2 +-
 arch/arm/mach-omap2/io.c                |    4 +-
 arch/arm/plat-omap/Kconfig              |    1 +
 arch/arm/plat-omap/clock.c              |   26 ---
 arch/arm/plat-omap/include/mach/clock.h |    3 +
 9 files changed, 354 insertions(+), 33 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clock44xx.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 8cb1677..229dac7 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -3,11 +3,12 @@
 #
 
 # Common support
-obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o
+obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o prcm.o \
+	 clock.o
 
 omap-2-3-common				= irq.o sdrc.o omap_hwmod.o
-prcm-common				= prcm.o powerdomain.o
-clock-common				= clock.o clockdomain.o
+prcm-common				= powerdomain.o
+clock-common				= clockdomain.o
 
 obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(prcm-common) $(clock-common)
 obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(prcm-common) $(clock-common)
@@ -43,6 +44,7 @@ obj-$(CONFIG_ARCH_OMAP4)		+= cm4xxx.o
 # Clock framework
 obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o
+obj-$(CONFIG_ARCH_OMAP4)		+= clock44xx.o
 
 iommu-y					+= iommu2.o
 iommu-$(CONFIG_ARCH_OMAP3)		+= omap3-iommu.o
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index f2a92d6..adf1a78 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -149,6 +149,7 @@ static int _dpll_test_fint(struct clk *clk, u8 n)
  * clockdomain pointer, and save it into the struct clk.  Intended to be
  * called during clk_register().  No return value.
  */
+#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once clkdm f/w is in place */
 void omap2_init_clk_clkdm(struct clk *clk)
 {
 	struct clockdomain *clkdm;
@@ -166,6 +167,7 @@ void omap2_init_clk_clkdm(struct clk *clk)
 			 "clkdm %s\n", clk->name, clk->clkdm_name);
 	}
 }
+#endif
 
 /**
  * omap2_init_clksel_parent - set a clksel clk's parent field from the hardware
@@ -437,8 +439,10 @@ void omap2_clk_disable(struct clk *clk)
 		_omap2_clk_disable(clk);
 		if (clk->parent)
 			omap2_clk_disable(clk->parent);
+#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once clkdm f/w is in place */
 		if (clk->clkdm)
 			omap2_clkdm_clk_disable(clk->clkdm, clk);
+#endif
 
 	}
 }
@@ -448,8 +452,10 @@ int omap2_clk_enable(struct clk *clk)
 	int ret = 0;
 
 	if (clk->usecount++ == 0) {
+#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once clkdm f/w is in place */
 		if (clk->clkdm)
 			omap2_clkdm_clk_enable(clk->clkdm, clk);
+#endif
 
 		if (clk->parent) {
 			ret = omap2_clk_enable(clk->parent);
@@ -468,8 +474,10 @@ int omap2_clk_enable(struct clk *clk)
 	return ret;
 
 err:
+#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once clkdm f/w is in place */
 	if (clk->clkdm)
 		omap2_clkdm_clk_disable(clk->clkdm, clk);
+#endif
 	clk->usecount--;
 	return ret;
 }
diff --git a/arch/arm/mach-omap2/clock44xx.c b/arch/arm/mach-omap2/clock44xx.c
new file mode 100644
index 0000000..e015200
--- /dev/null
+++ b/arch/arm/mach-omap2/clock44xx.c
@@ -0,0 +1,331 @@
+/*
+ * OMAP4-specific clock framework functions
+ *
+ * Copyright (C) 2009 Texas Instruments, Inc.
+ *
+ * Rajendra Nayak (rnayak@ti.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#undef DEBUG
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/limits.h>
+#include <linux/bitops.h>
+
+#include <mach/clock.h>
+#include <mach/sram.h>
+#include <asm/div64.h>
+#include <asm/clkdev.h>
+
+#include <mach/sdrc.h>
+#include "clock.h"
+#include "prm.h"
+#include "prm-regbits-44xx.h"
+#include "cm.h"
+#include "cm-regbits-44xx.h"
+
+
+static const struct clkops clkops_noncore_dpll_ops;
+
+#include "clock44xx.h"
+
+struct omap_clk {
+	u32		cpu;
+	struct clk_lookup lk;
+};
+
+#define CLK(dev, con, ck, cp) 		\
+	{				\
+		 .cpu = cp,		\
+		.lk = {			\
+			.dev_id = dev,	\
+			.con_id = con,	\
+			.clk = ck,	\
+		},			\
+	}
+
+#define CK_443X		(1 << 0)
+
+static struct omap_clk omap44xx_clks[] = {
+	CLK(NULL,	"extalt_clkin_ck",		&extalt_clkin_ck,	CK_443X),
+	CLK(NULL,	"pad_clks_ck",			&pad_clks_ck,	CK_443X),
+	CLK(NULL,	"pad_slimbus_core_clks_ck",	&pad_slimbus_core_clks_ck,	CK_443X),
+	CLK(NULL,	"secure_32k_clk_src_ck",	&secure_32k_clk_src_ck,	CK_443X),
+	CLK(NULL,	"slimbus_clk",			&slimbus_clk,	CK_443X),
+	CLK(NULL,	"sys_32k_ck",			&sys_32k_ck,	CK_443X),
+	CLK(NULL,	"virt_12000000_ck",		&virt_12000000_ck,	CK_443X),
+	CLK(NULL,	"virt_13000000_ck",		&virt_13000000_ck,	CK_443X),
+	CLK(NULL,	"virt_16800000_ck",		&virt_16800000_ck,	CK_443X),
+	CLK(NULL,	"virt_19200000_ck",		&virt_19200000_ck,	CK_443X),
+	CLK(NULL,	"virt_26000000_ck",		&virt_26000000_ck,	CK_443X),
+	CLK(NULL,	"virt_27000000_ck",		&virt_27000000_ck,	CK_443X),
+	CLK(NULL,	"virt_38400000_ck",		&virt_38400000_ck,	CK_443X),
+	CLK(NULL,	"sys_clkin_ck",			&sys_clkin_ck,	CK_443X),
+	CLK(NULL,	"utmi_phy_clkout_ck",		&utmi_phy_clkout_ck,	CK_443X),
+	CLK(NULL,	"xclk60mhsp1_ck",		&xclk60mhsp1_ck,	CK_443X),
+	CLK(NULL,	"xclk60mhsp2_ck",		&xclk60mhsp2_ck,	CK_443X),
+	CLK(NULL,	"xclk60motg_ck",		&xclk60motg_ck,	CK_443X),
+	CLK(NULL,	"dpll_sys_ref_clk",		&dpll_sys_ref_clk,	CK_443X),
+	CLK(NULL,	"abe_dpll_refclk_mux_ck",	&abe_dpll_refclk_mux_ck,	CK_443X),
+	CLK(NULL,	"dpll_abe_ck",			&dpll_abe_ck,	CK_443X),
+	CLK(NULL,	"dpll_abe_m2x2_ck",		&dpll_abe_m2x2_ck,	CK_443X),
+	CLK(NULL,	"abe_24m_fclk",			&abe_24m_fclk,	CK_443X),
+	CLK(NULL,	"abe_clk",			&abe_clk,	CK_443X),
+	CLK(NULL,	"aess_fclk",			&aess_fclk,	CK_443X),
+	CLK(NULL,	"dpll_abe_m3_ck",		&dpll_abe_m3_ck,	CK_443X),
+	CLK(NULL,	"core_hsd_byp_clk_mux_ck",	&core_hsd_byp_clk_mux_ck,	CK_443X),
+	CLK(NULL,	"dpll_core_ck",			&dpll_core_ck,	CK_443X),
+	CLK(NULL,	"dpll_core_m6_ck",		&dpll_core_m6_ck,	CK_443X),
+	CLK(NULL,	"dbgclk_mux_ck",		&dbgclk_mux_ck,	CK_443X),
+	CLK(NULL,	"dpll_core_m2_ck",		&dpll_core_m2_ck,	CK_443X),
+	CLK(NULL,	"ddrphy_ck",			&ddrphy_ck,	CK_443X),
+	CLK(NULL,	"dpll_core_m5_ck",		&dpll_core_m5_ck,	CK_443X),
+	CLK(NULL,	"div_core_ck",			&div_core_ck,	CK_443X),
+	CLK(NULL,	"div_iva_hs_clk",		&div_iva_hs_clk,	CK_443X),
+	CLK(NULL,	"div_mpu_hs_clk",		&div_mpu_hs_clk,	CK_443X),
+	CLK(NULL,	"dpll_core_m4_ck",		&dpll_core_m4_ck,	CK_443X),
+	CLK(NULL,	"dll_clk_div_ck",		&dll_clk_div_ck,	CK_443X),
+	CLK(NULL,	"dpll_abe_m2_ck",		&dpll_abe_m2_ck,	CK_443X),
+	CLK(NULL,	"dpll_core_m3_ck",		&dpll_core_m3_ck,	CK_443X),
+	CLK(NULL,	"dpll_core_m7_ck",		&dpll_core_m7_ck,	CK_443X),
+	CLK(NULL,	"iva_hsd_byp_clk_mux_ck",	&iva_hsd_byp_clk_mux_ck,	CK_443X),
+	CLK(NULL,	"dpll_iva_ck",			&dpll_iva_ck,	CK_443X),
+	CLK(NULL,	"dpll_iva_m4_ck",		&dpll_iva_m4_ck,	CK_443X),
+	CLK(NULL,	"dpll_iva_m5_ck",		&dpll_iva_m5_ck,	CK_443X),
+	CLK(NULL,	"dpll_mpu_ck",			&dpll_mpu_ck,	CK_443X),
+	CLK(NULL,	"dpll_mpu_m2_ck",		&dpll_mpu_m2_ck,	CK_443X),
+	CLK(NULL,	"per_hs_clk_div_ck",		&per_hs_clk_div_ck,	CK_443X),
+	CLK(NULL,	"per_hsd_byp_clk_mux_ck",	&per_hsd_byp_clk_mux_ck,	CK_443X),
+	CLK(NULL,	"dpll_per_ck",			&dpll_per_ck,	CK_443X),
+	CLK(NULL,	"dpll_per_m2_ck",		&dpll_per_m2_ck,	CK_443X),
+	CLK(NULL,	"dpll_per_m2x2_ck",		&dpll_per_m2x2_ck,	CK_443X),
+	CLK(NULL,	"dpll_per_m3_ck",		&dpll_per_m3_ck,	CK_443X),
+	CLK(NULL,	"dpll_per_m4_ck",		&dpll_per_m4_ck,	CK_443X),
+	CLK(NULL,	"dpll_per_m5_ck",		&dpll_per_m5_ck,	CK_443X),
+	CLK(NULL,	"dpll_per_m6_ck",		&dpll_per_m6_ck,	CK_443X),
+	CLK(NULL,	"dpll_per_m7_ck",		&dpll_per_m7_ck,	CK_443X),
+	CLK(NULL,	"dpll_unipro_ck",		&dpll_unipro_ck,	CK_443X),
+	CLK(NULL,	"dpll_unipro_m2x2_ck",		&dpll_unipro_m2x2_ck,	CK_443X),
+	CLK(NULL,	"usb_hs_clk_div_ck",		&usb_hs_clk_div_ck,	CK_443X),
+	CLK(NULL,	"dpll_usb_ck",			&dpll_usb_ck,	CK_443X),
+	CLK(NULL,	"dpll_usb_clkdcoldo_ck",	&dpll_usb_clkdcoldo_ck,	CK_443X),
+	CLK(NULL,	"dpll_usb_m2_ck",		&dpll_usb_m2_ck,	CK_443X),
+	CLK(NULL,	"ducati_clk_mux_ck",		&ducati_clk_mux_ck,	CK_443X),
+	CLK(NULL,	"func_12m_fclk",		&func_12m_fclk,	CK_443X),
+	CLK(NULL,	"func_24m_clk",			&func_24m_clk,	CK_443X),
+	CLK(NULL,	"func_24mc_fclk",		&func_24mc_fclk,	CK_443X),
+	CLK(NULL,	"func_48m_fclk",		&func_48m_fclk,	CK_443X),
+	CLK(NULL,	"func_48mc_fclk",		&func_48mc_fclk,	CK_443X),
+	CLK(NULL,	"func_64m_fclk",		&func_64m_fclk,	CK_443X),
+	CLK(NULL,	"func_96m_fclk",		&func_96m_fclk,	CK_443X),
+	CLK(NULL,	"hsmmc6_fclk",			&hsmmc6_fclk,	CK_443X),
+	CLK(NULL,	"init_60m_fclk",		&init_60m_fclk,	CK_443X),
+	CLK(NULL,	"l3_div_ck",			&l3_div_ck,	CK_443X),
+	CLK(NULL,	"l4_div_ck",			&l4_div_ck,	CK_443X),
+	CLK(NULL,	"lp_clk_div_ck",		&lp_clk_div_ck,	CK_443X),
+	CLK(NULL,	"l4_wkup_clk_mux_ck",		&l4_wkup_clk_mux_ck,	CK_443X),
+	CLK(NULL,	"per_abe_nc_fclk",		&per_abe_nc_fclk,	CK_443X),
+	CLK(NULL,	"mcasp2_fclk",			&mcasp2_fclk,	CK_443X),
+	CLK(NULL,	"mcasp3_fclk",			&mcasp3_fclk,	CK_443X),
+	CLK(NULL,	"ocp_abe_iclk",			&ocp_abe_iclk,	CK_443X),
+	CLK(NULL,	"per_abe_24m_fclk",		&per_abe_24m_fclk,	CK_443X),
+	CLK(NULL,	"pmd_stm_clock_mux_ck",		&pmd_stm_clock_mux_ck,	CK_443X),
+	CLK(NULL,	"pmd_trace_clk_mux_ck",		&pmd_trace_clk_mux_ck,	CK_443X),
+	CLK(NULL,	"syc_clk_div_ck",		&syc_clk_div_ck,	CK_443X),
+	CLK(NULL,	"aes1_ck",			&aes1_ck,	CK_443X),
+	CLK(NULL,	"aes2_ck",			&aes2_ck,	CK_443X),
+	CLK(NULL,	"aess_ck",			&aess_ck,	CK_443X),
+	CLK(NULL,	"cust_efuse_ck",		&cust_efuse_ck,	CK_443X),
+	CLK(NULL,	"des3des_ck",			&des3des_ck,	CK_443X),
+	CLK(NULL,	"dmic_sync_mux_ck",		&dmic_sync_mux_ck,	CK_443X),
+	CLK(NULL,	"dmic_ck",			&dmic_ck,	CK_443X),
+	CLK(NULL,	"dss_ck",			&dss_ck,	CK_443X),
+	CLK(NULL,	"ducati_ck",			&ducati_ck,	CK_443X),
+	CLK(NULL,	"emif1_ck",			&emif1_ck,	CK_443X),
+	CLK(NULL,	"emif2_ck",			&emif2_ck,	CK_443X),
+	CLK(NULL,	"fdif_ck",			&fdif_ck,	CK_443X),
+	CLK(NULL,	"per_sgx_fclk",			&per_sgx_fclk,	CK_443X),
+	CLK(NULL,	"gfx_ck",			&gfx_ck,	CK_443X),
+	CLK(NULL,	"gpio1_ck",			&gpio1_ck,	CK_443X),
+	CLK(NULL,	"gpio2_ck",			&gpio2_ck,	CK_443X),
+	CLK(NULL,	"gpio3_ck",			&gpio3_ck,	CK_443X),
+	CLK(NULL,	"gpio4_ck",			&gpio4_ck,	CK_443X),
+	CLK(NULL,	"gpio5_ck",			&gpio5_ck,	CK_443X),
+	CLK(NULL,	"gpio6_ck",			&gpio6_ck,	CK_443X),
+	CLK(NULL,	"gpmc_ck",			&gpmc_ck,	CK_443X),
+	CLK(NULL,	"gptimer1_ck",			&gptimer1_ck,	CK_443X),
+	CLK(NULL,	"gptimer10_ck",			&gptimer10_ck,	CK_443X),
+	CLK(NULL,	"gptimer11_ck",			&gptimer11_ck,	CK_443X),
+	CLK(NULL,	"gptimer2_ck",			&gptimer2_ck,	CK_443X),
+	CLK(NULL,	"gptimer3_ck",			&gptimer3_ck,	CK_443X),
+	CLK(NULL,	"gptimer4_ck",			&gptimer4_ck,	CK_443X),
+	CLK(NULL,	"gptimer5_ck",			&gptimer5_ck,	CK_443X),
+	CLK(NULL,	"gptimer6_ck",			&gptimer6_ck,	CK_443X),
+	CLK(NULL,	"gptimer7_ck",			&gptimer7_ck,	CK_443X),
+	CLK(NULL,	"gptimer8_ck",			&gptimer8_ck,	CK_443X),
+	CLK(NULL,	"gptimer9_ck",			&gptimer9_ck,	CK_443X),
+	CLK("omap2_hdq.0",	"ick",				&hdq1w_ck,	CK_443X),
+	CLK(NULL,	"hsi_ck",			&hsi_ck,	CK_443X),
+	CLK("i2c_omap.1",	"ick",				&i2c1_ck,	CK_443X),
+	CLK("i2c_omap.2",	"ick",				&i2c2_ck,	CK_443X),
+	CLK("i2c_omap.3",	"ick",				&i2c3_ck,	CK_443X),
+	CLK("i2c_omap.4",	"ick",				&i2c4_ck,	CK_443X),
+	CLK(NULL,	"iss_ck",			&iss_ck,	CK_443X),
+	CLK(NULL,	"ivahd_ck",			&ivahd_ck,	CK_443X),
+	CLK(NULL,	"keyboard_ck",			&keyboard_ck,	CK_443X),
+	CLK(NULL,	"l3_instr_interconnect_ck",	&l3_instr_interconnect_ck,	CK_443X),
+	CLK(NULL,	"l3_interconnect_3_ck",		&l3_interconnect_3_ck,	CK_443X),
+	CLK(NULL,	"mcasp_sync_mux_ck",		&mcasp_sync_mux_ck,	CK_443X),
+	CLK(NULL,	"mcasp_ck",			&mcasp_ck,	CK_443X),
+	CLK(NULL,	"mcbsp1_sync_mux_ck",		&mcbsp1_sync_mux_ck,	CK_443X),
+	CLK("omap-mcbsp.1",	"fck",				&mcbsp1_ck,	CK_443X),
+	CLK(NULL,	"mcbsp2_sync_mux_ck",		&mcbsp2_sync_mux_ck,	CK_443X),
+	CLK("omap-mcbsp.2",	"fck",				&mcbsp2_ck,	CK_443X),
+	CLK(NULL,	"mcbsp3_sync_mux_ck",		&mcbsp3_sync_mux_ck,	CK_443X),
+	CLK("omap-mcbsp.3",	"fck",				&mcbsp3_ck,	CK_443X),
+	CLK(NULL,	"mcbsp4_sync_mux_ck",		&mcbsp4_sync_mux_ck,	CK_443X),
+	CLK("omap-mcbsp.4",	"fck",				&mcbsp4_ck,	CK_443X),
+	CLK("omap2_mcspi.1",	"fck",				&mcspi1_ck,	CK_443X),
+	CLK("omap2_mcspi.2",	"fck",				&mcspi2_ck,	CK_443X),
+	CLK("omap2_mcspi.3",	"fck",				&mcspi3_ck,	CK_443X),
+	CLK("omap2_mcspi.4",	"fck",				&mcspi4_ck,	CK_443X),
+	CLK("mmci-omap-hs.0",	"fck",				&mmc1_ck,	CK_443X),
+	CLK("mmci-omap-hs.1",	"fck",				&mmc2_ck,	CK_443X),
+	CLK("mmci-omap-hs.2",	"fck",				&mmc3_ck,	CK_443X),
+	CLK("mmci-omap-hs.3",	"fck",				&mmc4_ck,	CK_443X),
+	CLK("mmci-omap-hs.4",	"fck",				&mmc5_ck,	CK_443X),
+	CLK(NULL,	"ocp_wp1_ck",			&ocp_wp1_ck,	CK_443X),
+	CLK(NULL,	"pdm_ck",			&pdm_ck,	CK_443X),
+	CLK(NULL,	"pkaeip29_ck",			&pkaeip29_ck,	CK_443X),
+	CLK("omap_rng",	"ick",				&rng_ck,	CK_443X),
+	CLK(NULL,	"sha2md51_ck",			&sha2md51_ck,	CK_443X),
+	CLK(NULL,	"sl2_ck",			&sl2_ck,	CK_443X),
+	CLK(NULL,	"slimbus1_ck",			&slimbus1_ck,	CK_443X),
+	CLK(NULL,	"slimbus2_ck",			&slimbus2_ck,	CK_443X),
+	CLK(NULL,	"sr_core_ck",			&sr_core_ck,	CK_443X),
+	CLK(NULL,	"sr_iva_ck",			&sr_iva_ck,	CK_443X),
+	CLK(NULL,	"sr_mpu_ck",			&sr_mpu_ck,	CK_443X),
+	CLK(NULL,	"tesla_ck",			&tesla_ck,	CK_443X),
+	CLK(NULL,	"uart1_ck",			&uart1_ck,	CK_443X),
+	CLK(NULL,	"uart2_ck",			&uart2_ck,	CK_443X),
+	CLK(NULL,	"uart3_ck",			&uart3_ck,	CK_443X),
+	CLK(NULL,	"uart4_ck",			&uart4_ck,	CK_443X),
+	CLK(NULL,	"unipro1_ck",			&unipro1_ck,	CK_443X),
+	CLK(NULL,	"usb_host_ck",			&usb_host_ck,	CK_443X),
+	CLK(NULL,	"usb_host_fs_ck",		&usb_host_fs_ck,	CK_443X),
+	CLK("musb_hdrc",	"ick",				&usb_otg_ck,	CK_443X),
+	CLK(NULL,	"usb_tll_ck",			&usb_tll_ck,	CK_443X),
+	CLK(NULL,	"usbphyocp2scp_ck",		&usbphyocp2scp_ck,	CK_443X),
+	CLK(NULL,	"usim_ck",			&usim_ck,	CK_443X),
+	CLK("omap_wdt",	"fck",				&wdt2_ck,	CK_443X),
+	CLK(NULL,	"wdt3_ck",			&wdt3_ck,	CK_443X),
+	CLK(NULL,	"otg_60m_gfclk_ck",		&otg_60m_gfclk_ck,	CK_443X),
+	CLK(NULL,	"stm_clk_div_ck",		&stm_clk_div_ck,	CK_443X),
+	CLK(NULL,	"trace_clk_div_ck",		&trace_clk_div_ck,	CK_443X),
+	CLK(NULL,	"usim_fclk",			&usim_fclk,	CK_443X),
+	CLK(NULL,	"utmi_p1_gfclk_ck",		&utmi_p1_gfclk_ck,	CK_443X),
+	CLK(NULL,	"utmi_p2_gfclk_ck",		&utmi_p2_gfclk_ck,	CK_443X),
+};
+
+static struct clk_functions omap2_clk_functions = {
+	.clk_enable		= omap2_clk_enable,
+	.clk_disable		= omap2_clk_disable,
+	.clk_round_rate		= omap2_clk_round_rate,
+	.clk_set_rate		= omap2_clk_set_rate,
+	.clk_set_parent		= omap2_clk_set_parent,
+	.clk_disable_unused	= omap2_clk_disable_unused,
+};
+
+/*
+ * Dummy functions for DPLL control. Plan is to re-use
+ * existing OMAP3 dpll control functions.
+ */
+
+static unsigned long omap3_dpll_recalc(struct clk *clk)
+{
+	return 0;
+}
+
+static int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
+{
+	return 0;
+}
+
+static int omap3_noncore_dpll_enable(struct clk *clk)
+{
+	return 0;
+}
+
+static void omap3_noncore_dpll_disable(struct clk *clk)
+{
+	return;
+}
+
+static const struct clkops clkops_noncore_dpll_ops = {
+	.enable		= &omap3_noncore_dpll_enable,
+	.disable	= &omap3_noncore_dpll_disable,
+};
+
+void omap2_clk_prepare_for_reboot(void)
+{
+	return;
+}
+
+static int __init omap2_clk_arch_init(void)
+{
+	if (!mpurate)
+		return -EINVAL;
+
+	recalculate_root_clocks();
+	return 0;
+}
+arch_initcall(omap2_clk_arch_init);
+
+int __init omap2_clk_init(void)
+{
+	/* struct prcm_config *prcm; */
+	struct omap_clk *c;
+	/* u32 clkrate; */
+	u32 cpu_clkflg;
+
+	if (cpu_is_omap44xx()) {
+		cpu_mask = RATE_IN_4430;
+		cpu_clkflg = CK_443X;
+	}
+
+	clk_init(&omap2_clk_functions);
+
+	for (c = omap44xx_clks; c < omap44xx_clks + ARRAY_SIZE(omap44xx_clks);
+									  c++)
+		clk_preinit(c->lk.clk);
+
+	for (c = omap44xx_clks; c < omap44xx_clks + ARRAY_SIZE(omap44xx_clks);
+									  c++)
+		if (c->cpu & cpu_clkflg) {
+			clkdev_add(&c->lk);
+			clk_register(c->lk.clk);
+			/* TODO
+			omap2_init_clk_clkdm(c->lk.clk);
+			*/
+		}
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
diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index af312e6..027af00 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -97,6 +97,10 @@
 
 /* CM2.CEFUSE_CM2 register offsets */
 
+/* OMAP4 modulemode control */
+#define OMAP4430_MODULEMODE_HWCTRL			0
+#define OMAP4430_MODULEMODE_SWCTRL			1
+
 /* Clock management domain register get/set */
 
 #ifndef __ASSEMBLER__
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index f3c992e..2e13741 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -490,7 +490,7 @@ void __init gpmc_init(void)
 		ck = "gpmc_fck";
 		l = OMAP34XX_GPMC_BASE;
 	} else if (cpu_is_omap44xx()) {
-		ck = "gpmc_fck";
+		ck = "gpmc_ck";
 		l = OMAP44XX_GPMC_BASE;
 	}
 
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 56be87d..9ab8f8b 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -34,7 +34,6 @@
 #include <mach/gpmc.h>
 #include <mach/serial.h>
 
-#ifndef CONFIG_ARCH_OMAP4	/* FIXME: Remove this once clkdev is ready */
 #include "clock.h"
 
 #include <mach/omap-pm.h>
@@ -43,7 +42,6 @@
 
 #include <mach/clockdomain.h>
 #include "clockdomains.h"
-#endif
 #include <mach/omap_hwmod.h>
 #include "omap_hwmod_2420.h"
 #include "omap_hwmod_2430.h"
@@ -301,8 +299,8 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 	omap_pm_if_early_init(mpu_opps, dsp_opps, l3_opps);
 	pwrdm_init(powerdomains_omap);
 	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
-	omap2_clk_init();
 #endif
+	omap2_clk_init();
 	omap_serial_early_init();
 #ifndef CONFIG_ARCH_OMAP4
 	omap_hwmod_late_init();
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 64b3f52..8287b93 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -27,6 +27,7 @@ config ARCH_OMAP4
 	bool "TI OMAP4"
 	select CPU_V7
 	select ARM_GIC
+	select COMMON_CLKDEV
 
 endchoice
 
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index bf880e9..9f99503 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -40,36 +40,10 @@ static struct clk_functions *arch_clock;
  * clock framework is not up , it is defined here to avoid rework in
  * every driver. Also dummy prcm reset function is added */
 
-/* Dummy hooks only for OMAP4.For rest OMAPs, common clkdev is used */
-#if defined(CONFIG_ARCH_OMAP4)
-struct clk *clk_get(struct device *dev, const char *id)
-{
-	return NULL;
-}
-EXPORT_SYMBOL(clk_get);
-
-void clk_put(struct clk *clk)
-{
-}
-EXPORT_SYMBOL(clk_put);
-
-void omap2_clk_prepare_for_reboot(void)
-{
-}
-EXPORT_SYMBOL(omap2_clk_prepare_for_reboot);
-
-void omap_prcm_arch_reset(char mode)
-{
-}
-EXPORT_SYMBOL(omap_prcm_arch_reset);
-#endif
 int clk_enable(struct clk *clk)
 {
 	unsigned long flags;
 	int ret = 0;
-	if (cpu_is_omap44xx())
-		/* OMAP4 clk framework not supported yet */
-		return 0;
 
 	if (clk == NULL || IS_ERR(clk))
 		return -EINVAL;
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index 4b8b0d6..e9472c9 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -148,6 +148,8 @@ extern const struct clkops clkops_null;
 #define CONFIG_PARTICIPANT	(1 << 10)	/* Fundamental clock */
 #define ENABLE_ON_INIT		(1 << 11)	/* Enable upon framework init */
 #define INVERT_ENABLE           (1 << 12)       /* 0 enables, 1 disables */
+#define CLOCK_IN_OMAP4430	(1 << 13)
+#define ALWAYS_ENABLED		(1 << 14)
 /* bits 13-31 are currently free */
 
 /* Clksel_rate flags */
@@ -156,6 +158,7 @@ extern const struct clkops clkops_null;
 #define RATE_IN_243X		(1 << 2)
 #define RATE_IN_343X		(1 << 3)	/* rates common to all 343X */
 #define RATE_IN_3430ES2		(1 << 4)	/* 3430ES2 rates only */
+#define RATE_IN_4430            (1 << 5)
 
 #define RATE_IN_24XX		(RATE_IN_242X | RATE_IN_243X)
 
-- 
1.5.4.7

