From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 09/11] OMAP4: clock: Rename leaf clock nodes to end with a
	_ick or _fck
Date: Mon, 22 Feb 2010 21:50:56 -0700
Message-ID: <20100223045055.18888.46077.stgit@localhost.localdomain>
References: <20100223044915.18888.83242.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60274 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867Ab0BWE5k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Feb 2010 23:57:40 -0500
In-Reply-To: <20100223044915.18888.83242.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

All leaf clock nodes are renamed for OMAP4 to have a clk name which
end with a _ick or a _fck. This is done so that the naming convention
is same as that followed on older OMAPs.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |  561 ++++++++++++++++++----------------
 1 files changed, 297 insertions(+), 264 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 6deca1e..c0825cf 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -1,8 +1,8 @@
 /*
  * OMAP4 Clock data
  *
- * Copyright (C) 2009 Texas Instruments, Inc.
- * Copyright (C) 2009 Nokia Corporation
+ * Copyright (C) 2009-2010 Texas Instruments, Inc.
+ * Copyright (C) 2009-2010 Nokia Corporation
  *
  * Paul Walmsley (paul@pwsan.com)
  * Rajendra Nayak (rnayak@ti.com)
@@ -1254,8 +1254,8 @@ static struct clk syc_clk_div_ck = {
 
 /* Leaf clocks controlled by modules */
 
-static struct clk aes1_ck = {
-	.name		= "aes1_ck",
+static struct clk aes1_fck = {
+	.name		= "aes1_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4SEC_AES1_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -1264,8 +1264,8 @@ static struct clk aes1_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk aes2_ck = {
-	.name		= "aes2_ck",
+static struct clk aes2_fck = {
+	.name		= "aes2_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4SEC_AES2_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -1274,8 +1274,8 @@ static struct clk aes2_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk aess_ck = {
-	.name		= "aess_ck",
+static struct clk aess_fck = {
+	.name		= "aess_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM1_ABE_AESS_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -1284,8 +1284,8 @@ static struct clk aess_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk cust_efuse_ck = {
-	.name		= "cust_efuse_ck",
+static struct clk cust_efuse_fck = {
+	.name		= "cust_efuse_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_CEFUSE_CEFUSE_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -1294,8 +1294,8 @@ static struct clk cust_efuse_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk des3des_ck = {
-	.name		= "des3des_ck",
+static struct clk des3des_fck = {
+	.name		= "des3des_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4SEC_DES3DES_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -1329,9 +1329,9 @@ static const struct clksel func_dmic_abe_gfclk_sel[] = {
 	{ .parent = NULL },
 };
 
-/* Merged func_dmic_abe_gfclk into dmic_ck */
-static struct clk dmic_ck = {
-	.name		= "dmic_ck",
+/* Merged func_dmic_abe_gfclk into dmic */
+static struct clk dmic_fck = {
+	.name		= "dmic_fck",
 	.parent		= &dmic_sync_mux_ck,
 	.clksel		= func_dmic_abe_gfclk_sel,
 	.init		= &omap2_init_clksel_parent,
@@ -1344,8 +1344,8 @@ static struct clk dmic_ck = {
 	.clkdm_name	= "abe_clkdm",
 };
 
-static struct clk dss_ck = {
-	.name		= "dss_ck",
+static struct clk dss_fck = {
+	.name		= "dss_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_DSS_DSS_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -1354,8 +1354,8 @@ static struct clk dss_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk ducati_ck = {
-	.name		= "ducati_ck",
+static struct clk ducati_ick = {
+	.name		= "ducati_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_DUCATI_DUCATI_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
@@ -1364,8 +1364,8 @@ static struct clk ducati_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk emif1_ck = {
-	.name		= "emif1_ck",
+static struct clk emif1_ick = {
+	.name		= "emif1_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_MEMIF_EMIF_1_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
@@ -1374,8 +1374,8 @@ static struct clk emif1_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk emif2_ck = {
-	.name		= "emif2_ck",
+static struct clk emif2_ick = {
+	.name		= "emif2_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_MEMIF_EMIF_2_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
@@ -1389,9 +1389,9 @@ static const struct clksel fdif_fclk_div[] = {
 	{ .parent = NULL },
 };
 
-/* Merged fdif_fclk into fdif_ck */
-static struct clk fdif_ck = {
-	.name		= "fdif_ck",
+/* Merged fdif_fclk into fdif */
+static struct clk fdif_fck = {
+	.name		= "fdif_fck",
 	.parent		= &dpll_per_m4_ck,
 	.clksel		= fdif_fclk_div,
 	.clksel_reg	= OMAP4430_CM_CAM_FDIF_CLKCTRL,
@@ -1428,9 +1428,9 @@ static const struct clksel sgx_clk_mux_sel[] = {
 	{ .parent = NULL },
 };
 
-/* Merged sgx_clk_mux into gfx_ck */
-static struct clk gfx_ck = {
-	.name		= "gfx_ck",
+/* Merged sgx_clk_mux into gfx */
+static struct clk gfx_fck = {
+	.name		= "gfx_fck",
 	.parent		= &dpll_core_m7_ck,
 	.clksel		= sgx_clk_mux_sel,
 	.init		= &omap2_init_clksel_parent,
@@ -1443,8 +1443,8 @@ static struct clk gfx_ck = {
 	.clkdm_name	= "l3_gfx_clkdm",
 };
 
-static struct clk gpio1_ck = {
-	.name		= "gpio1_ck",
+static struct clk gpio1_ick = {
+	.name		= "gpio1_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_WKUP_GPIO1_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
@@ -1453,8 +1453,8 @@ static struct clk gpio1_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio2_ck = {
-	.name		= "gpio2_ck",
+static struct clk gpio2_ick = {
+	.name		= "gpio2_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_GPIO2_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
@@ -1463,8 +1463,8 @@ static struct clk gpio2_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio3_ck = {
-	.name		= "gpio3_ck",
+static struct clk gpio3_ick = {
+	.name		= "gpio3_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_GPIO3_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
@@ -1473,8 +1473,8 @@ static struct clk gpio3_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio4_ck = {
-	.name		= "gpio4_ck",
+static struct clk gpio4_ick = {
+	.name		= "gpio4_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_GPIO4_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
@@ -1483,8 +1483,8 @@ static struct clk gpio4_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio5_ck = {
-	.name		= "gpio5_ck",
+static struct clk gpio5_ick = {
+	.name		= "gpio5_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_GPIO5_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
@@ -1493,8 +1493,8 @@ static struct clk gpio5_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio6_ck = {
-	.name		= "gpio6_ck",
+static struct clk gpio6_ick = {
+	.name		= "gpio6_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_GPIO6_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
@@ -1503,8 +1503,8 @@ static struct clk gpio6_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpmc_ck = {
-	.name		= "gpmc_ck",
+static struct clk gpmc_ick = {
+	.name		= "gpmc_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3_2_GPMC_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
@@ -1519,9 +1519,12 @@ static const struct clksel dmt1_clk_mux_sel[] = {
 	{ .parent = NULL },
 };
 
-/* Merged dmt1_clk_mux into gptimer1_ck */
-static struct clk gptimer1_ck = {
-	.name		= "gptimer1_ck",
+/*
+ * Merged dmt1_clk_mux into gptimer1
+ * gptimer1 renamed temporarily into gpt1 to match OMAP3 convention
+ */
+static struct clk gpt1_fck = {
+	.name		= "gpt1_fck",
 	.parent		= &sys_clkin_ck,
 	.clksel		= dmt1_clk_mux_sel,
 	.init		= &omap2_init_clksel_parent,
@@ -1534,9 +1537,12 @@ static struct clk gptimer1_ck = {
 	.clkdm_name	= "l4_wkup_clkdm",
 };
 
-/* Merged cm2_dm10_mux into gptimer10_ck */
-static struct clk gptimer10_ck = {
-	.name		= "gptimer10_ck",
+/*
+ * Merged cm2_dm10_mux into gptimer10
+ * gptimer10 renamed temporarily into gpt10 to match OMAP3 convention
+ */
+static struct clk gpt10_fck = {
+	.name		= "gpt10_fck",
 	.parent		= &sys_clkin_ck,
 	.clksel		= dmt1_clk_mux_sel,
 	.init		= &omap2_init_clksel_parent,
@@ -1549,9 +1555,12 @@ static struct clk gptimer10_ck = {
 	.clkdm_name	= "l4_per_clkdm",
 };
 
-/* Merged cm2_dm11_mux into gptimer11_ck */
-static struct clk gptimer11_ck = {
-	.name		= "gptimer11_ck",
+/*
+ * Merged cm2_dm11_mux into gptimer11
+ * gptimer11 renamed temporarily into gpt11 to match OMAP3 convention
+ */
+static struct clk gpt11_fck = {
+	.name		= "gpt11_fck",
 	.parent		= &sys_clkin_ck,
 	.clksel		= dmt1_clk_mux_sel,
 	.init		= &omap2_init_clksel_parent,
@@ -1564,9 +1573,12 @@ static struct clk gptimer11_ck = {
 	.clkdm_name	= "l4_per_clkdm",
 };
 
-/* Merged cm2_dm2_mux into gptimer2_ck */
-static struct clk gptimer2_ck = {
-	.name		= "gptimer2_ck",
+/*
+ * Merged cm2_dm2_mux into gptimer2
+ * gptimer2 renamed temporarily into gpt2 to match OMAP3 convention
+ */
+static struct clk gpt2_fck = {
+	.name		= "gpt2_fck",
 	.parent		= &sys_clkin_ck,
 	.clksel		= dmt1_clk_mux_sel,
 	.init		= &omap2_init_clksel_parent,
@@ -1579,9 +1591,12 @@ static struct clk gptimer2_ck = {
 	.clkdm_name	= "l4_per_clkdm",
 };
 
-/* Merged cm2_dm3_mux into gptimer3_ck */
-static struct clk gptimer3_ck = {
-	.name		= "gptimer3_ck",
+/*
+ * Merged cm2_dm3_mux into gptimer3
+ * gptimer3 renamed temporarily into gpt3 to match OMAP3 convention
+ */
+static struct clk gpt3_fck = {
+	.name		= "gpt3_fck",
 	.parent		= &sys_clkin_ck,
 	.clksel		= dmt1_clk_mux_sel,
 	.init		= &omap2_init_clksel_parent,
@@ -1594,9 +1609,12 @@ static struct clk gptimer3_ck = {
 	.clkdm_name	= "l4_per_clkdm",
 };
 
-/* Merged cm2_dm4_mux into gptimer4_ck */
-static struct clk gptimer4_ck = {
-	.name		= "gptimer4_ck",
+/*
+ * Merged cm2_dm4_mux into gptimer4
+ * gptimer4 renamed temporarily into gpt4 to match OMAP3 convention
+ */
+static struct clk gpt4_fck = {
+	.name		= "gpt4_fck",
 	.parent		= &sys_clkin_ck,
 	.clksel		= dmt1_clk_mux_sel,
 	.init		= &omap2_init_clksel_parent,
@@ -1615,9 +1633,12 @@ static const struct clksel timer5_sync_mux_sel[] = {
 	{ .parent = NULL },
 };
 
-/* Merged timer5_sync_mux into gptimer5_ck */
-static struct clk gptimer5_ck = {
-	.name		= "gptimer5_ck",
+/*
+ * Merged timer5_sync_mux into gptimer5
+ * gptimer5 renamed temporarily into gpt5 to match OMAP3 convention
+ */
+static struct clk gpt5_fck = {
+	.name		= "gpt5_fck",
 	.parent		= &syc_clk_div_ck,
 	.clksel		= timer5_sync_mux_sel,
 	.init		= &omap2_init_clksel_parent,
@@ -1630,9 +1651,12 @@ static struct clk gptimer5_ck = {
 	.clkdm_name	= "abe_clkdm",
 };
 
-/* Merged timer6_sync_mux into gptimer6_ck */
-static struct clk gptimer6_ck = {
-	.name		= "gptimer6_ck",
+/*
+ * Merged timer6_sync_mux into gptimer6
+ * gptimer6 renamed temporarily into gpt6 to match OMAP3 convention
+ */
+static struct clk gpt6_fck = {
+	.name		= "gpt6_fck",
 	.parent		= &syc_clk_div_ck,
 	.clksel		= timer5_sync_mux_sel,
 	.init		= &omap2_init_clksel_parent,
@@ -1645,9 +1669,12 @@ static struct clk gptimer6_ck = {
 	.clkdm_name	= "abe_clkdm",
 };
 
-/* Merged timer7_sync_mux into gptimer7_ck */
-static struct clk gptimer7_ck = {
-	.name		= "gptimer7_ck",
+/*
+ * Merged timer7_sync_mux into gptimer7
+ * gptimer7 renamed temporarily into gpt7 to match OMAP3 convention
+ */
+static struct clk gpt7_fck = {
+	.name		= "gpt7_fck",
 	.parent		= &syc_clk_div_ck,
 	.clksel		= timer5_sync_mux_sel,
 	.init		= &omap2_init_clksel_parent,
@@ -1660,9 +1687,12 @@ static struct clk gptimer7_ck = {
 	.clkdm_name	= "abe_clkdm",
 };
 
-/* Merged timer8_sync_mux into gptimer8_ck */
-static struct clk gptimer8_ck = {
-	.name		= "gptimer8_ck",
+/*
+ * Merged timer8_sync_mux into gptimer8
+ * gptimer8 renamed temporarily into gpt8 to match OMAP3 convention
+ */
+static struct clk gpt8_fck = {
+	.name		= "gpt8_fck",
 	.parent		= &syc_clk_div_ck,
 	.clksel		= timer5_sync_mux_sel,
 	.init		= &omap2_init_clksel_parent,
@@ -1675,9 +1705,12 @@ static struct clk gptimer8_ck = {
 	.clkdm_name	= "abe_clkdm",
 };
 
-/* Merged cm2_dm9_mux into gptimer9_ck */
-static struct clk gptimer9_ck = {
-	.name		= "gptimer9_ck",
+/*
+ * Merged cm2_dm9_mux into gptimer9
+ * gptimer9 renamed temporarily into gpt9 to match OMAP3 convention
+ */
+static struct clk gpt9_fck = {
+	.name		= "gpt9_fck",
 	.parent		= &sys_clkin_ck,
 	.clksel		= dmt1_clk_mux_sel,
 	.init		= &omap2_init_clksel_parent,
@@ -1690,8 +1723,8 @@ static struct clk gptimer9_ck = {
 	.clkdm_name	= "l4_per_clkdm",
 };
 
-static struct clk hdq1w_ck = {
-	.name		= "hdq1w_ck",
+static struct clk hdq1w_fck = {
+	.name		= "hdq1w_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_HDQ1W_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -1700,9 +1733,9 @@ static struct clk hdq1w_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-/* Merged hsi_fclk into hsi_ck */
-static struct clk hsi_ck = {
-	.name		= "hsi_ck",
+/* Merged hsi_fclk into hsi */
+static struct clk hsi_ick = {
+	.name		= "hsi_ick",
 	.parent		= &dpll_per_m2x2_ck,
 	.clksel		= per_sgx_fclk_div,
 	.clksel_reg	= OMAP4430_CM_L3INIT_HSI_CLKCTRL,
@@ -1716,8 +1749,8 @@ static struct clk hsi_ck = {
 	.clkdm_name	= "l3_init_clkdm",
 };
 
-static struct clk i2c1_ck = {
-	.name		= "i2c1_ck",
+static struct clk i2c1_fck = {
+	.name		= "i2c1_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_I2C1_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -1726,8 +1759,8 @@ static struct clk i2c1_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk i2c2_ck = {
-	.name		= "i2c2_ck",
+static struct clk i2c2_fck = {
+	.name		= "i2c2_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_I2C2_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -1736,8 +1769,8 @@ static struct clk i2c2_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk i2c3_ck = {
-	.name		= "i2c3_ck",
+static struct clk i2c3_fck = {
+	.name		= "i2c3_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_I2C3_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -1746,8 +1779,8 @@ static struct clk i2c3_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk i2c4_ck = {
-	.name		= "i2c4_ck",
+static struct clk i2c4_fck = {
+	.name		= "i2c4_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_I2C4_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -1756,8 +1789,8 @@ static struct clk i2c4_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk iss_ck = {
-	.name		= "iss_ck",
+static struct clk iss_fck = {
+	.name		= "iss_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_CAM_ISS_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -1766,8 +1799,8 @@ static struct clk iss_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk ivahd_ck = {
-	.name		= "ivahd_ck",
+static struct clk ivahd_ick = {
+	.name		= "ivahd_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_IVAHD_IVAHD_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
@@ -1776,8 +1809,8 @@ static struct clk ivahd_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk keyboard_ck = {
-	.name		= "keyboard_ck",
+static struct clk keyboard_fck = {
+	.name		= "keyboard_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_WKUP_KEYBOARD_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -1786,8 +1819,8 @@ static struct clk keyboard_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk l3_instr_interconnect_ck = {
-	.name		= "l3_instr_interconnect_ck",
+static struct clk l3_instr_interconnect_ick = {
+	.name		= "l3_instr_interconnect_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INSTR_L3_INSTR_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
@@ -1796,8 +1829,8 @@ static struct clk l3_instr_interconnect_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk l3_interconnect_3_ck = {
-	.name		= "l3_interconnect_3_ck",
+static struct clk l3_interconnect_3_ick = {
+	.name		= "l3_interconnect_3_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INSTR_L3_3_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
@@ -1824,9 +1857,9 @@ static const struct clksel func_mcasp_abe_gfclk_sel[] = {
 	{ .parent = NULL },
 };
 
-/* Merged func_mcasp_abe_gfclk into mcasp_ck */
-static struct clk mcasp_ck = {
-	.name		= "mcasp_ck",
+/* Merged func_mcasp_abe_gfclk into mcasp */
+static struct clk mcasp_fck = {
+	.name		= "mcasp_fck",
 	.parent		= &mcasp_sync_mux_ck,
 	.clksel		= func_mcasp_abe_gfclk_sel,
 	.init		= &omap2_init_clksel_parent,
@@ -1857,9 +1890,9 @@ static const struct clksel func_mcbsp1_gfclk_sel[] = {
 	{ .parent = NULL },
 };
 
-/* Merged func_mcbsp1_gfclk into mcbsp1_ck */
-static struct clk mcbsp1_ck = {
-	.name		= "mcbsp1_ck",
+/* Merged func_mcbsp1_gfclk into mcbsp1 */
+static struct clk mcbsp1_fck = {
+	.name		= "mcbsp1_fck",
 	.parent		= &mcbsp1_sync_mux_ck,
 	.clksel		= func_mcbsp1_gfclk_sel,
 	.init		= &omap2_init_clksel_parent,
@@ -1890,9 +1923,9 @@ static const struct clksel func_mcbsp2_gfclk_sel[] = {
 	{ .parent = NULL },
 };
 
-/* Merged func_mcbsp2_gfclk into mcbsp2_ck */
-static struct clk mcbsp2_ck = {
-	.name		= "mcbsp2_ck",
+/* Merged func_mcbsp2_gfclk into mcbsp2 */
+static struct clk mcbsp2_fck = {
+	.name		= "mcbsp2_fck",
 	.parent		= &mcbsp2_sync_mux_ck,
 	.clksel		= func_mcbsp2_gfclk_sel,
 	.init		= &omap2_init_clksel_parent,
@@ -1923,9 +1956,9 @@ static const struct clksel func_mcbsp3_gfclk_sel[] = {
 	{ .parent = NULL },
 };
 
-/* Merged func_mcbsp3_gfclk into mcbsp3_ck */
-static struct clk mcbsp3_ck = {
-	.name		= "mcbsp3_ck",
+/* Merged func_mcbsp3_gfclk into mcbsp3 */
+static struct clk mcbsp3_fck = {
+	.name		= "mcbsp3_fck",
 	.parent		= &mcbsp3_sync_mux_ck,
 	.clksel		= func_mcbsp3_gfclk_sel,
 	.init		= &omap2_init_clksel_parent,
@@ -1955,9 +1988,9 @@ static const struct clksel per_mcbsp4_gfclk_sel[] = {
 	{ .parent = NULL },
 };
 
-/* Merged per_mcbsp4_gfclk into mcbsp4_ck */
-static struct clk mcbsp4_ck = {
-	.name		= "mcbsp4_ck",
+/* Merged per_mcbsp4_gfclk into mcbsp4 */
+static struct clk mcbsp4_fck = {
+	.name		= "mcbsp4_fck",
 	.parent		= &mcbsp4_sync_mux_ck,
 	.clksel		= per_mcbsp4_gfclk_sel,
 	.init		= &omap2_init_clksel_parent,
@@ -1970,8 +2003,8 @@ static struct clk mcbsp4_ck = {
 	.clkdm_name	= "l4_per_clkdm",
 };
 
-static struct clk mcspi1_ck = {
-	.name		= "mcspi1_ck",
+static struct clk mcspi1_fck = {
+	.name		= "mcspi1_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_MCSPI1_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -1980,8 +2013,8 @@ static struct clk mcspi1_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mcspi2_ck = {
-	.name		= "mcspi2_ck",
+static struct clk mcspi2_fck = {
+	.name		= "mcspi2_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_MCSPI2_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -1990,8 +2023,8 @@ static struct clk mcspi2_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mcspi3_ck = {
-	.name		= "mcspi3_ck",
+static struct clk mcspi3_fck = {
+	.name		= "mcspi3_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_MCSPI3_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -2000,8 +2033,8 @@ static struct clk mcspi3_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mcspi4_ck = {
-	.name		= "mcspi4_ck",
+static struct clk mcspi4_fck = {
+	.name		= "mcspi4_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_MCSPI4_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -2010,9 +2043,9 @@ static struct clk mcspi4_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-/* Merged hsmmc1_fclk into mmc1_ck */
-static struct clk mmc1_ck = {
-	.name		= "mmc1_ck",
+/* Merged hsmmc1_fclk into mmc1 */
+static struct clk mmc1_fck = {
+	.name		= "mmc1_fck",
 	.parent		= &func_64m_fclk,
 	.clksel		= hsmmc6_fclk_sel,
 	.init		= &omap2_init_clksel_parent,
@@ -2025,9 +2058,9 @@ static struct clk mmc1_ck = {
 	.clkdm_name	= "l3_init_clkdm",
 };
 
-/* Merged hsmmc2_fclk into mmc2_ck */
-static struct clk mmc2_ck = {
-	.name		= "mmc2_ck",
+/* Merged hsmmc2_fclk into mmc2 */
+static struct clk mmc2_fck = {
+	.name		= "mmc2_fck",
 	.parent		= &func_64m_fclk,
 	.clksel		= hsmmc6_fclk_sel,
 	.init		= &omap2_init_clksel_parent,
@@ -2040,8 +2073,8 @@ static struct clk mmc2_ck = {
 	.clkdm_name	= "l3_init_clkdm",
 };
 
-static struct clk mmc3_ck = {
-	.name		= "mmc3_ck",
+static struct clk mmc3_fck = {
+	.name		= "mmc3_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_MMCSD3_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -2050,8 +2083,8 @@ static struct clk mmc3_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mmc4_ck = {
-	.name		= "mmc4_ck",
+static struct clk mmc4_fck = {
+	.name		= "mmc4_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_MMCSD4_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -2060,8 +2093,8 @@ static struct clk mmc4_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mmc5_ck = {
-	.name		= "mmc5_ck",
+static struct clk mmc5_fck = {
+	.name		= "mmc5_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_MMCSD5_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -2070,8 +2103,8 @@ static struct clk mmc5_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk ocp_wp1_ck = {
-	.name		= "ocp_wp1_ck",
+static struct clk ocp_wp1_ick = {
+	.name		= "ocp_wp1_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INSTR_OCP_WP1_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
@@ -2080,8 +2113,8 @@ static struct clk ocp_wp1_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk pdm_ck = {
-	.name		= "pdm_ck",
+static struct clk pdm_fck = {
+	.name		= "pdm_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM1_ABE_PDM_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -2090,8 +2123,8 @@ static struct clk pdm_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk pkaeip29_ck = {
-	.name		= "pkaeip29_ck",
+static struct clk pkaeip29_fck = {
+	.name		= "pkaeip29_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4SEC_PKAEIP29_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -2100,8 +2133,8 @@ static struct clk pkaeip29_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk rng_ck = {
-	.name		= "rng_ck",
+static struct clk rng_ick = {
+	.name		= "rng_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4SEC_RNG_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
@@ -2110,8 +2143,8 @@ static struct clk rng_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk sha2md51_ck = {
-	.name		= "sha2md51_ck",
+static struct clk sha2md51_fck = {
+	.name		= "sha2md51_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4SEC_SHA2MD51_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -2120,8 +2153,8 @@ static struct clk sha2md51_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk sl2_ck = {
-	.name		= "sl2_ck",
+static struct clk sl2_ick = {
+	.name		= "sl2_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_IVAHD_SL2_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
@@ -2130,8 +2163,8 @@ static struct clk sl2_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk slimbus1_ck = {
-	.name		= "slimbus1_ck",
+static struct clk slimbus1_fck = {
+	.name		= "slimbus1_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -2140,8 +2173,8 @@ static struct clk slimbus1_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk slimbus2_ck = {
-	.name		= "slimbus2_ck",
+static struct clk slimbus2_fck = {
+	.name		= "slimbus2_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -2150,8 +2183,8 @@ static struct clk slimbus2_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk sr_core_ck = {
-	.name		= "sr_core_ck",
+static struct clk sr_core_fck = {
+	.name		= "sr_core_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_ALWON_SR_CORE_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -2160,8 +2193,8 @@ static struct clk sr_core_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk sr_iva_ck = {
-	.name		= "sr_iva_ck",
+static struct clk sr_iva_fck = {
+	.name		= "sr_iva_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_ALWON_SR_IVA_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -2170,8 +2203,8 @@ static struct clk sr_iva_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk sr_mpu_ck = {
-	.name		= "sr_mpu_ck",
+static struct clk sr_mpu_fck = {
+	.name		= "sr_mpu_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_ALWON_SR_MPU_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -2180,8 +2213,8 @@ static struct clk sr_mpu_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk tesla_ck = {
-	.name		= "tesla_ck",
+static struct clk tesla_ick = {
+	.name		= "tesla_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_TESLA_TESLA_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
@@ -2190,8 +2223,8 @@ static struct clk tesla_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk uart1_ck = {
-	.name		= "uart1_ck",
+static struct clk uart1_fck = {
+	.name		= "uart1_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_UART1_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -2200,8 +2233,8 @@ static struct clk uart1_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk uart2_ck = {
-	.name		= "uart2_ck",
+static struct clk uart2_fck = {
+	.name		= "uart2_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_UART2_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -2210,8 +2243,8 @@ static struct clk uart2_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk uart3_ck = {
-	.name		= "uart3_ck",
+static struct clk uart3_fck = {
+	.name		= "uart3_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_UART3_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -2220,8 +2253,8 @@ static struct clk uart3_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk uart4_ck = {
-	.name		= "uart4_ck",
+static struct clk uart4_fck = {
+	.name		= "uart4_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_UART4_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -2230,8 +2263,8 @@ static struct clk uart4_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk unipro1_ck = {
-	.name		= "unipro1_ck",
+static struct clk unipro1_fck = {
+	.name		= "unipro1_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INIT_UNIPRO1_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -2240,8 +2273,8 @@ static struct clk unipro1_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk usb_host_ck = {
-	.name		= "usb_host_ck",
+static struct clk usb_host_fck = {
+	.name		= "usb_host_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -2250,8 +2283,8 @@ static struct clk usb_host_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk usb_host_fs_ck = {
-	.name		= "usb_host_fs_ck",
+static struct clk usb_host_fs_fck = {
+	.name		= "usb_host_fs_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INIT_USB_HOST_FS_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -2260,8 +2293,8 @@ static struct clk usb_host_fs_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk usb_otg_ck = {
-	.name		= "usb_otg_ck",
+static struct clk usb_otg_ick = {
+	.name		= "usb_otg_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
@@ -2270,8 +2303,8 @@ static struct clk usb_otg_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk usb_tll_ck = {
-	.name		= "usb_tll_ck",
+static struct clk usb_tll_ick = {
+	.name		= "usb_tll_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
@@ -2280,8 +2313,8 @@ static struct clk usb_tll_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk usbphyocp2scp_ck = {
-	.name		= "usbphyocp2scp_ck",
+static struct clk usbphyocp2scp_ick = {
+	.name		= "usbphyocp2scp_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
@@ -2290,8 +2323,8 @@ static struct clk usbphyocp2scp_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk usim_ck = {
-	.name		= "usim_ck",
+static struct clk usim_fck = {
+	.name		= "usim_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_WKUP_USIM_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -2300,8 +2333,8 @@ static struct clk usim_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk wdt2_ck = {
-	.name		= "wdt2_ck",
+static struct clk wdt2_fck = {
+	.name		= "wdt2_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_WKUP_WDT2_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -2310,8 +2343,8 @@ static struct clk wdt2_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk wdt3_ck = {
-	.name		= "wdt3_ck",
+static struct clk wdt3_fck = {
+	.name		= "wdt3_fck",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM1_ABE_WDT3_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -2519,93 +2552,93 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"pmd_stm_clock_mux_ck",		&pmd_stm_clock_mux_ck,	CK_443X),
 	CLK(NULL,	"pmd_trace_clk_mux_ck",		&pmd_trace_clk_mux_ck,	CK_443X),
 	CLK(NULL,	"syc_clk_div_ck",		&syc_clk_div_ck,	CK_443X),
-	CLK(NULL,	"aes1_ck",			&aes1_ck,	CK_443X),
-	CLK(NULL,	"aes2_ck",			&aes2_ck,	CK_443X),
-	CLK(NULL,	"aess_ck",			&aess_ck,	CK_443X),
-	CLK(NULL,	"cust_efuse_ck",		&cust_efuse_ck,	CK_443X),
-	CLK(NULL,	"des3des_ck",			&des3des_ck,	CK_443X),
+	CLK(NULL,	"aes1_fck",			&aes1_fck,	CK_443X),
+	CLK(NULL,	"aes2_fck",			&aes2_fck,	CK_443X),
+	CLK(NULL,	"aess_fck",			&aess_fck,	CK_443X),
+	CLK(NULL,	"cust_efuse_fck",		&cust_efuse_fck,	CK_443X),
+	CLK(NULL,	"des3des_fck",			&des3des_fck,	CK_443X),
 	CLK(NULL,	"dmic_sync_mux_ck",		&dmic_sync_mux_ck,	CK_443X),
-	CLK(NULL,	"dmic_ck",			&dmic_ck,	CK_443X),
-	CLK(NULL,	"dss_ck",			&dss_ck,	CK_443X),
-	CLK(NULL,	"ducati_ck",			&ducati_ck,	CK_443X),
-	CLK(NULL,	"emif1_ck",			&emif1_ck,	CK_443X),
-	CLK(NULL,	"emif2_ck",			&emif2_ck,	CK_443X),
-	CLK(NULL,	"fdif_ck",			&fdif_ck,	CK_443X),
+	CLK(NULL,	"dmic_fck",			&dmic_fck,	CK_443X),
+	CLK(NULL,	"dss_fck",			&dss_fck,	CK_443X),
+	CLK(NULL,	"ducati_ick",			&ducati_ick,	CK_443X),
+	CLK(NULL,	"emif1_ick",			&emif1_ick,	CK_443X),
+	CLK(NULL,	"emif2_ick",			&emif2_ick,	CK_443X),
+	CLK(NULL,	"fdif_fck",			&fdif_fck,	CK_443X),
 	CLK(NULL,	"per_sgx_fclk",			&per_sgx_fclk,	CK_443X),
-	CLK(NULL,	"gfx_ck",			&gfx_ck,	CK_443X),
-	CLK(NULL,	"gpio1_ck",			&gpio1_ck,	CK_443X),
-	CLK(NULL,	"gpio2_ck",			&gpio2_ck,	CK_443X),
-	CLK(NULL,	"gpio3_ck",			&gpio3_ck,	CK_443X),
-	CLK(NULL,	"gpio4_ck",			&gpio4_ck,	CK_443X),
-	CLK(NULL,	"gpio5_ck",			&gpio5_ck,	CK_443X),
-	CLK(NULL,	"gpio6_ck",			&gpio6_ck,	CK_443X),
-	CLK(NULL,	"gpmc_ck",			&gpmc_ck,	CK_443X),
-	CLK(NULL,	"gptimer1_ck",			&gptimer1_ck,	CK_443X),
-	CLK(NULL,	"gptimer10_ck",			&gptimer10_ck,	CK_443X),
-	CLK(NULL,	"gptimer11_ck",			&gptimer11_ck,	CK_443X),
-	CLK(NULL,	"gptimer2_ck",			&gptimer2_ck,	CK_443X),
-	CLK(NULL,	"gptimer3_ck",			&gptimer3_ck,	CK_443X),
-	CLK(NULL,	"gptimer4_ck",			&gptimer4_ck,	CK_443X),
-	CLK(NULL,	"gptimer5_ck",			&gptimer5_ck,	CK_443X),
-	CLK(NULL,	"gptimer6_ck",			&gptimer6_ck,	CK_443X),
-	CLK(NULL,	"gptimer7_ck",			&gptimer7_ck,	CK_443X),
-	CLK(NULL,	"gptimer8_ck",			&gptimer8_ck,	CK_443X),
-	CLK(NULL,	"gptimer9_ck",			&gptimer9_ck,	CK_443X),
-	CLK("omap2_hdq.0",	"ick",				&hdq1w_ck,	CK_443X),
-	CLK(NULL,	"hsi_ck",			&hsi_ck,	CK_443X),
-	CLK("i2c_omap.1",	"ick",				&i2c1_ck,	CK_443X),
-	CLK("i2c_omap.2",	"ick",				&i2c2_ck,	CK_443X),
-	CLK("i2c_omap.3",	"ick",				&i2c3_ck,	CK_443X),
-	CLK("i2c_omap.4",	"ick",				&i2c4_ck,	CK_443X),
-	CLK(NULL,	"iss_ck",			&iss_ck,	CK_443X),
-	CLK(NULL,	"ivahd_ck",			&ivahd_ck,	CK_443X),
-	CLK(NULL,	"keyboard_ck",			&keyboard_ck,	CK_443X),
-	CLK(NULL,	"l3_instr_interconnect_ck",	&l3_instr_interconnect_ck,	CK_443X),
-	CLK(NULL,	"l3_interconnect_3_ck",		&l3_interconnect_3_ck,	CK_443X),
+	CLK(NULL,	"gfx_fck",			&gfx_fck,	CK_443X),
+	CLK(NULL,	"gpio1_ick",			&gpio1_ick,	CK_443X),
+	CLK(NULL,	"gpio2_ick",			&gpio2_ick,	CK_443X),
+	CLK(NULL,	"gpio3_ick",			&gpio3_ick,	CK_443X),
+	CLK(NULL,	"gpio4_ick",			&gpio4_ick,	CK_443X),
+	CLK(NULL,	"gpio5_ick",			&gpio5_ick,	CK_443X),
+	CLK(NULL,	"gpio6_ick",			&gpio6_ick,	CK_443X),
+	CLK(NULL,	"gpmc_ick",			&gpmc_ick,	CK_443X),
+	CLK(NULL,	"gpt1_fck",			&gpt1_fck,	CK_443X),
+	CLK(NULL,	"gpt10_fck",			&gpt10_fck,	CK_443X),
+	CLK(NULL,	"gpt11_fck",			&gpt11_fck,	CK_443X),
+	CLK(NULL,	"gpt2_fck",			&gpt2_fck,	CK_443X),
+	CLK(NULL,	"gpt3_fck",			&gpt3_fck,	CK_443X),
+	CLK(NULL,	"gpt4_fck",			&gpt4_fck,	CK_443X),
+	CLK(NULL,	"gpt5_fck",			&gpt5_fck,	CK_443X),
+	CLK(NULL,	"gpt6_fck",			&gpt6_fck,	CK_443X),
+	CLK(NULL,	"gpt7_fck",			&gpt7_fck,	CK_443X),
+	CLK(NULL,	"gpt8_fck",			&gpt8_fck,	CK_443X),
+	CLK(NULL,	"gpt9_fck",			&gpt9_fck,	CK_443X),
+	CLK("omap2_hdq.0",	"fck",				&hdq1w_fck,	CK_443X),
+	CLK(NULL,	"hsi_ick",			&hsi_ick,	CK_443X),
+	CLK("i2c_omap.1",	"fck",				&i2c1_fck,	CK_443X),
+	CLK("i2c_omap.2",	"fck",				&i2c2_fck,	CK_443X),
+	CLK("i2c_omap.3",	"fck",				&i2c3_fck,	CK_443X),
+	CLK("i2c_omap.4",	"fck",				&i2c4_fck,	CK_443X),
+	CLK(NULL,	"iss_fck",			&iss_fck,	CK_443X),
+	CLK(NULL,	"ivahd_ick",			&ivahd_ick,	CK_443X),
+	CLK(NULL,	"keyboard_fck",			&keyboard_fck,	CK_443X),
+	CLK(NULL,	"l3_instr_interconnect_ick",	&l3_instr_interconnect_ick,	CK_443X),
+	CLK(NULL,	"l3_interconnect_3_ick",	&l3_interconnect_3_ick,	CK_443X),
 	CLK(NULL,	"mcasp_sync_mux_ck",		&mcasp_sync_mux_ck,	CK_443X),
-	CLK(NULL,	"mcasp_ck",			&mcasp_ck,	CK_443X),
+	CLK(NULL,	"mcasp_fck",			&mcasp_fck,	CK_443X),
 	CLK(NULL,	"mcbsp1_sync_mux_ck",		&mcbsp1_sync_mux_ck,	CK_443X),
-	CLK("omap-mcbsp.1",	"fck",				&mcbsp1_ck,	CK_443X),
+	CLK("omap-mcbsp.1",	"fck",				&mcbsp1_fck,	CK_443X),
 	CLK(NULL,	"mcbsp2_sync_mux_ck",		&mcbsp2_sync_mux_ck,	CK_443X),
-	CLK("omap-mcbsp.2",	"fck",				&mcbsp2_ck,	CK_443X),
+	CLK("omap-mcbsp.2",	"fck",				&mcbsp2_fck,	CK_443X),
 	CLK(NULL,	"mcbsp3_sync_mux_ck",		&mcbsp3_sync_mux_ck,	CK_443X),
-	CLK("omap-mcbsp.3",	"fck",				&mcbsp3_ck,	CK_443X),
+	CLK("omap-mcbsp.3",	"fck",				&mcbsp3_fck,	CK_443X),
 	CLK(NULL,	"mcbsp4_sync_mux_ck",		&mcbsp4_sync_mux_ck,	CK_443X),
-	CLK("omap-mcbsp.4",	"fck",				&mcbsp4_ck,	CK_443X),
-	CLK("omap2_mcspi.1",	"fck",				&mcspi1_ck,	CK_443X),
-	CLK("omap2_mcspi.2",	"fck",				&mcspi2_ck,	CK_443X),
-	CLK("omap2_mcspi.3",	"fck",				&mcspi3_ck,	CK_443X),
-	CLK("omap2_mcspi.4",	"fck",				&mcspi4_ck,	CK_443X),
-	CLK("mmci-omap-hs.0",	"fck",				&mmc1_ck,	CK_443X),
-	CLK("mmci-omap-hs.1",	"fck",				&mmc2_ck,	CK_443X),
-	CLK("mmci-omap-hs.2",	"fck",				&mmc3_ck,	CK_443X),
-	CLK("mmci-omap-hs.3",	"fck",				&mmc4_ck,	CK_443X),
-	CLK("mmci-omap-hs.4",	"fck",				&mmc5_ck,	CK_443X),
-	CLK(NULL,	"ocp_wp1_ck",			&ocp_wp1_ck,	CK_443X),
-	CLK(NULL,	"pdm_ck",			&pdm_ck,	CK_443X),
-	CLK(NULL,	"pkaeip29_ck",			&pkaeip29_ck,	CK_443X),
-	CLK("omap_rng",	"ick",				&rng_ck,	CK_443X),
-	CLK(NULL,	"sha2md51_ck",			&sha2md51_ck,	CK_443X),
-	CLK(NULL,	"sl2_ck",			&sl2_ck,	CK_443X),
-	CLK(NULL,	"slimbus1_ck",			&slimbus1_ck,	CK_443X),
-	CLK(NULL,	"slimbus2_ck",			&slimbus2_ck,	CK_443X),
-	CLK(NULL,	"sr_core_ck",			&sr_core_ck,	CK_443X),
-	CLK(NULL,	"sr_iva_ck",			&sr_iva_ck,	CK_443X),
-	CLK(NULL,	"sr_mpu_ck",			&sr_mpu_ck,	CK_443X),
-	CLK(NULL,	"tesla_ck",			&tesla_ck,	CK_443X),
-	CLK(NULL,	"uart1_ck",			&uart1_ck,	CK_443X),
-	CLK(NULL,	"uart2_ck",			&uart2_ck,	CK_443X),
-	CLK(NULL,	"uart3_ck",			&uart3_ck,	CK_443X),
-	CLK(NULL,	"uart4_ck",			&uart4_ck,	CK_443X),
-	CLK(NULL,	"unipro1_ck",			&unipro1_ck,	CK_443X),
-	CLK(NULL,	"usb_host_ck",			&usb_host_ck,	CK_443X),
-	CLK(NULL,	"usb_host_fs_ck",		&usb_host_fs_ck,	CK_443X),
-	CLK("musb_hdrc",	"ick",				&usb_otg_ck,	CK_443X),
-	CLK(NULL,	"usb_tll_ck",			&usb_tll_ck,	CK_443X),
-	CLK(NULL,	"usbphyocp2scp_ck",		&usbphyocp2scp_ck,	CK_443X),
-	CLK(NULL,	"usim_ck",			&usim_ck,	CK_443X),
-	CLK("omap_wdt",	"fck",				&wdt2_ck,	CK_443X),
-	CLK(NULL,	"wdt3_ck",			&wdt3_ck,	CK_443X),
+	CLK("omap-mcbsp.4",	"fck",				&mcbsp4_fck,	CK_443X),
+	CLK("omap2_mcspi.1",	"fck",				&mcspi1_fck,	CK_443X),
+	CLK("omap2_mcspi.2",	"fck",				&mcspi2_fck,	CK_443X),
+	CLK("omap2_mcspi.3",	"fck",				&mcspi3_fck,	CK_443X),
+	CLK("omap2_mcspi.4",	"fck",				&mcspi4_fck,	CK_443X),
+	CLK("mmci-omap-hs.0",	"fck",				&mmc1_fck,	CK_443X),
+	CLK("mmci-omap-hs.1",	"fck",				&mmc2_fck,	CK_443X),
+	CLK("mmci-omap-hs.2",	"fck",				&mmc3_fck,	CK_443X),
+	CLK("mmci-omap-hs.3",	"fck",				&mmc4_fck,	CK_443X),
+	CLK("mmci-omap-hs.4",	"fck",				&mmc5_fck,	CK_443X),
+	CLK(NULL,	"ocp_wp1_ick",			&ocp_wp1_ick,	CK_443X),
+	CLK(NULL,	"pdm_fck",			&pdm_fck,	CK_443X),
+	CLK(NULL,	"pkaeip29_fck",			&pkaeip29_fck,	CK_443X),
+	CLK("omap_rng",	"ick",				&rng_ick,	CK_443X),
+	CLK(NULL,	"sha2md51_fck",			&sha2md51_fck,	CK_443X),
+	CLK(NULL,	"sl2_ick",			&sl2_ick,	CK_443X),
+	CLK(NULL,	"slimbus1_fck",			&slimbus1_fck,	CK_443X),
+	CLK(NULL,	"slimbus2_fck",			&slimbus2_fck,	CK_443X),
+	CLK(NULL,	"sr_core_fck",			&sr_core_fck,	CK_443X),
+	CLK(NULL,	"sr_iva_fck",			&sr_iva_fck,	CK_443X),
+	CLK(NULL,	"sr_mpu_fck",			&sr_mpu_fck,	CK_443X),
+	CLK(NULL,	"tesla_ick",			&tesla_ick,	CK_443X),
+	CLK(NULL,	"uart1_fck",			&uart1_fck,	CK_443X),
+	CLK(NULL,	"uart2_fck",			&uart2_fck,	CK_443X),
+	CLK(NULL,	"uart3_fck",			&uart3_fck,	CK_443X),
+	CLK(NULL,	"uart4_fck",			&uart4_fck,	CK_443X),
+	CLK(NULL,	"unipro1_fck",			&unipro1_fck,	CK_443X),
+	CLK(NULL,	"usb_host_fck",			&usb_host_fck,	CK_443X),
+	CLK(NULL,	"usb_host_fs_fck",		&usb_host_fs_fck,	CK_443X),
+	CLK("musb_hdrc",	"ick",				&usb_otg_ick,	CK_443X),
+	CLK(NULL,	"usb_tll_ick",			&usb_tll_ick,	CK_443X),
+	CLK(NULL,	"usbphyocp2scp_ick",		&usbphyocp2scp_ick,	CK_443X),
+	CLK(NULL,	"usim_fck",			&usim_fck,	CK_443X),
+	CLK("omap_wdt",	"fck",				&wdt2_fck,	CK_443X),
+	CLK(NULL,	"wdt3_fck",			&wdt3_fck,	CK_443X),
 	CLK(NULL,	"otg_60m_gfclk_ck",		&otg_60m_gfclk_ck,	CK_443X),
 	CLK(NULL,	"stm_clk_div_ck",		&stm_clk_div_ck,	CK_443X),
 	CLK(NULL,	"trace_clk_div_ck",		&trace_clk_div_ck,	CK_443X),


