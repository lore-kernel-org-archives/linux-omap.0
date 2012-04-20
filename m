From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 4/8] ARM: OMAP4: hwmod: flag hwmods/modules supporting module level context status
Date: Fri, 20 Apr 2012 12:19:47 +0300
Message-ID: <1334913591-26312-5-git-send-email-t-kristo@ti.com>
References: <1334913591-26312-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50518 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752264Ab2DTJUX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Apr 2012 05:20:23 -0400
In-Reply-To: <1334913591-26312-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

On OMAP4 most modules/hwmods support module level context status. On
OMAP3 and earlier, we relyed on the power domain level context status.
Identify all such modules using a 'HWMOD_CONTEXT_REG' flag, all such
hwmods already have a valid 'context_offs' populated in .prcm structure.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |  104 ++++++++++++++++++++++----
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +
 2 files changed, 91 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 86e1b96..6c36e63 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -128,6 +128,7 @@ static struct omap_hwmod omap44xx_dmm_hwmod = {
 	.name		= "dmm",
 	.class		= &omap44xx_dmm_hwmod_class,
 	.clkdm_name	= "l3_emif_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_MEMIF_DMM_CLKCTRL_OFFSET,
@@ -184,6 +185,7 @@ static struct omap_hwmod omap44xx_emif_fw_hwmod = {
 	.name		= "emif_fw",
 	.class		= &omap44xx_emif_fw_hwmod_class,
 	.clkdm_name	= "l3_emif_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_MEMIF_EMIF_FW_CLKCTRL_OFFSET,
@@ -229,6 +231,7 @@ static struct omap_hwmod omap44xx_l3_instr_hwmod = {
 	.name		= "l3_instr",
 	.class		= &omap44xx_l3_hwmod_class,
 	.clkdm_name	= "l3_instr_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3INSTR_L3_INSTR_CLKCTRL_OFFSET,
@@ -328,6 +331,7 @@ static struct omap_hwmod omap44xx_l3_main_1_hwmod = {
 	.name		= "l3_main_1",
 	.class		= &omap44xx_l3_hwmod_class,
 	.clkdm_name	= "l3_1_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_l3_main_1_irqs,
 	.prcm = {
 		.omap4 = {
@@ -430,6 +434,7 @@ static struct omap_hwmod omap44xx_l3_main_2_hwmod = {
 	.name		= "l3_main_2",
 	.class		= &omap44xx_l3_hwmod_class,
 	.clkdm_name	= "l3_2_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3_2_L3_2_CLKCTRL_OFFSET,
@@ -486,6 +491,7 @@ static struct omap_hwmod omap44xx_l3_main_3_hwmod = {
 	.name		= "l3_main_3",
 	.class		= &omap44xx_l3_hwmod_class,
 	.clkdm_name	= "l3_instr_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3INSTR_L3_3_CLKCTRL_OFFSET,
@@ -577,6 +583,7 @@ static struct omap_hwmod omap44xx_l4_cfg_hwmod = {
 	.name		= "l4_cfg",
 	.class		= &omap44xx_l4_hwmod_class,
 	.clkdm_name	= "l4_cfg_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4CFG_L4_CFG_CLKCTRL_OFFSET,
@@ -605,6 +612,7 @@ static struct omap_hwmod omap44xx_l4_per_hwmod = {
 	.name		= "l4_per",
 	.class		= &omap44xx_l4_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_L4PER_CLKCTRL_OFFSET,
@@ -633,6 +641,7 @@ static struct omap_hwmod omap44xx_l4_wkup_hwmod = {
 	.name		= "l4_wkup",
 	.class		= &omap44xx_l4_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_WKUP_L4WKUP_CLKCTRL_OFFSET,
@@ -807,6 +816,7 @@ static struct omap_hwmod omap44xx_aess_hwmod = {
 	.name		= "aess",
 	.class		= &omap44xx_aess_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_aess_irqs,
 	.sdma_reqs	= omap44xx_aess_sdma_reqs,
 	.main_clk	= "aess_fck",
@@ -898,7 +908,7 @@ static struct omap_hwmod omap44xx_counter_32k_hwmod = {
 	.name		= "counter_32k",
 	.class		= &omap44xx_counter_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
-	.flags		= HWMOD_SWSUP_SIDLE,
+	.flags		= HWMOD_CONTEXT_REG | HWMOD_SWSUP_SIDLE,
 	.main_clk	= "sys_32k_ck",
 	.prcm = {
 		.omap4 = {
@@ -982,6 +992,7 @@ static struct omap_hwmod omap44xx_dma_system_hwmod = {
 	.name		= "dma_system",
 	.class		= &omap44xx_dma_hwmod_class,
 	.clkdm_name	= "l3_dma_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_dma_system_irqs,
 	.main_clk	= "l3_div_ck",
 	.prcm = {
@@ -1077,6 +1088,7 @@ static struct omap_hwmod omap44xx_dmic_hwmod = {
 	.name		= "dmic",
 	.class		= &omap44xx_dmic_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_dmic_irqs,
 	.sdma_reqs	= omap44xx_dmic_sdma_reqs,
 	.main_clk	= "dmic_fck",
@@ -1160,7 +1172,7 @@ static struct omap_hwmod omap44xx_dsp_hwmod = {
 	.name		= "dsp",
 	.class		= &omap44xx_dsp_hwmod_class,
 	.clkdm_name	= "tesla_clkdm",
-	.flags		= HWMOD_INIT_NO_RESET,
+	.flags		= HWMOD_INIT_NO_RESET | HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_dsp_irqs,
 	.rst_lines	= omap44xx_dsp_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_dsp_resets),
@@ -1252,7 +1264,8 @@ static struct omap_hwmod_opt_clk dss_opt_clks[] = {
 
 static struct omap_hwmod omap44xx_dss_hwmod = {
 	.name		= "dss_core",
-	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
+	.flags		= HWMOD_CONTEXT_REG |
+			  HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.class		= &omap44xx_dss_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
 	.main_clk	= "dss_dss_clk",
@@ -1356,6 +1369,7 @@ static struct omap_hwmod omap44xx_dss_dispc_hwmod = {
 	.name		= "dss_dispc",
 	.class		= &omap44xx_dispc_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_dss_dispc_irqs,
 	.sdma_reqs	= omap44xx_dss_dispc_sdma_reqs,
 	.main_clk	= "dss_dss_clk",
@@ -1453,6 +1467,7 @@ static struct omap_hwmod omap44xx_dss_dsi1_hwmod = {
 	.name		= "dss_dsi1",
 	.class		= &omap44xx_dsi_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_dss_dsi1_irqs,
 	.sdma_reqs	= omap44xx_dss_dsi1_sdma_reqs,
 	.main_clk	= "dss_dss_clk",
@@ -1530,6 +1545,7 @@ static struct omap_hwmod omap44xx_dss_dsi2_hwmod = {
 	.name		= "dss_dsi2",
 	.class		= &omap44xx_dsi_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_dss_dsi2_irqs,
 	.sdma_reqs	= omap44xx_dss_dsi2_sdma_reqs,
 	.main_clk	= "dss_dss_clk",
@@ -1627,6 +1643,7 @@ static struct omap_hwmod omap44xx_dss_hdmi_hwmod = {
 	.name		= "dss_hdmi",
 	.class		= &omap44xx_hdmi_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_dss_hdmi_irqs,
 	.sdma_reqs	= omap44xx_dss_hdmi_sdma_reqs,
 	.main_clk	= "dss_48mhz_clk",
@@ -1719,6 +1736,7 @@ static struct omap_hwmod omap44xx_dss_rfbi_hwmod = {
 	.name		= "dss_rfbi",
 	.class		= &omap44xx_rfbi_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.sdma_reqs	= omap44xx_dss_rfbi_sdma_reqs,
 	.main_clk	= "dss_dss_clk",
 	.prcm = {
@@ -1790,6 +1808,7 @@ static struct omap_hwmod omap44xx_dss_venc_hwmod = {
 	.name		= "dss_venc",
 	.class		= &omap44xx_venc_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.main_clk	= "dss_tv_clk",
 	.prcm = {
 		.omap4 = {
@@ -1868,6 +1887,7 @@ static struct omap_hwmod omap44xx_gpio1_hwmod = {
 	.name		= "gpio1",
 	.class		= &omap44xx_gpio_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_gpio1_irqs,
 	.main_clk	= "gpio1_ick",
 	.prcm = {
@@ -1922,7 +1942,8 @@ static struct omap_hwmod omap44xx_gpio2_hwmod = {
 	.name		= "gpio2",
 	.class		= &omap44xx_gpio_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
+	.flags		= HWMOD_CONTEXT_REG |
+			  HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap44xx_gpio2_irqs,
 	.main_clk	= "gpio2_ick",
 	.prcm = {
@@ -1977,7 +1998,8 @@ static struct omap_hwmod omap44xx_gpio3_hwmod = {
 	.name		= "gpio3",
 	.class		= &omap44xx_gpio_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
+	.flags		= HWMOD_CONTEXT_REG |
+			  HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap44xx_gpio3_irqs,
 	.main_clk	= "gpio3_ick",
 	.prcm = {
@@ -2032,7 +2054,8 @@ static struct omap_hwmod omap44xx_gpio4_hwmod = {
 	.name		= "gpio4",
 	.class		= &omap44xx_gpio_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
+	.flags		= HWMOD_CONTEXT_REG |
+			  HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap44xx_gpio4_irqs,
 	.main_clk	= "gpio4_ick",
 	.prcm = {
@@ -2087,7 +2110,8 @@ static struct omap_hwmod omap44xx_gpio5_hwmod = {
 	.name		= "gpio5",
 	.class		= &omap44xx_gpio_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
+	.flags		= HWMOD_CONTEXT_REG |
+			  HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap44xx_gpio5_irqs,
 	.main_clk	= "gpio5_ick",
 	.prcm = {
@@ -2142,7 +2166,8 @@ static struct omap_hwmod omap44xx_gpio6_hwmod = {
 	.name		= "gpio6",
 	.class		= &omap44xx_gpio_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
+	.flags		= HWMOD_CONTEXT_REG |
+			  HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap44xx_gpio6_irqs,
 	.main_clk	= "gpio6_ick",
 	.prcm = {
@@ -2223,6 +2248,7 @@ static struct omap_hwmod omap44xx_hsi_hwmod = {
 	.name		= "hsi",
 	.class		= &omap44xx_hsi_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_hsi_irqs,
 	.main_clk	= "hsi_fck",
 	.prcm = {
@@ -2306,7 +2332,8 @@ static struct omap_hwmod omap44xx_i2c1_hwmod = {
 	.name		= "i2c1",
 	.class		= &omap44xx_i2c_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
+	.flags		= HWMOD_CONTEXT_REG | HWMOD_16BIT_REG |
+			  HWMOD_SET_DEFAULT_CLOCKACT,
 	.mpu_irqs	= omap44xx_i2c1_irqs,
 	.sdma_reqs	= omap44xx_i2c1_sdma_reqs,
 	.main_clk	= "i2c1_fck",
@@ -2362,7 +2389,8 @@ static struct omap_hwmod omap44xx_i2c2_hwmod = {
 	.name		= "i2c2",
 	.class		= &omap44xx_i2c_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
+	.flags		= HWMOD_CONTEXT_REG | HWMOD_16BIT_REG |
+			  HWMOD_SET_DEFAULT_CLOCKACT,
 	.mpu_irqs	= omap44xx_i2c2_irqs,
 	.sdma_reqs	= omap44xx_i2c2_sdma_reqs,
 	.main_clk	= "i2c2_fck",
@@ -2418,7 +2446,8 @@ static struct omap_hwmod omap44xx_i2c3_hwmod = {
 	.name		= "i2c3",
 	.class		= &omap44xx_i2c_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
+	.flags		= HWMOD_CONTEXT_REG | HWMOD_16BIT_REG |
+			  HWMOD_SET_DEFAULT_CLOCKACT,
 	.mpu_irqs	= omap44xx_i2c3_irqs,
 	.sdma_reqs	= omap44xx_i2c3_sdma_reqs,
 	.main_clk	= "i2c3_fck",
@@ -2474,7 +2503,8 @@ static struct omap_hwmod omap44xx_i2c4_hwmod = {
 	.name		= "i2c4",
 	.class		= &omap44xx_i2c_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
+	.flags		= HWMOD_CONTEXT_REG | HWMOD_16BIT_REG |
+			  HWMOD_SET_DEFAULT_CLOCKACT,
 	.mpu_irqs	= omap44xx_i2c4_irqs,
 	.sdma_reqs	= omap44xx_i2c4_sdma_reqs,
 	.main_clk	= "i2c4_fck",
@@ -2569,6 +2599,7 @@ static struct omap_hwmod omap44xx_ipu_hwmod = {
 	.name		= "ipu",
 	.class		= &omap44xx_ipu_hwmod_class,
 	.clkdm_name	= "ducati_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_ipu_irqs,
 	.rst_lines	= omap44xx_ipu_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_ipu_resets),
@@ -2658,6 +2689,7 @@ static struct omap_hwmod omap44xx_iss_hwmod = {
 	.name		= "iss",
 	.class		= &omap44xx_iss_hwmod_class,
 	.clkdm_name	= "iss_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_iss_irqs,
 	.sdma_reqs	= omap44xx_iss_sdma_reqs,
 	.main_clk	= "iss_fck",
@@ -2769,6 +2801,7 @@ static struct omap_hwmod omap44xx_iva_hwmod = {
 	.name		= "iva",
 	.class		= &omap44xx_iva_hwmod_class,
 	.clkdm_name	= "ivahd_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_iva_irqs,
 	.rst_lines	= omap44xx_iva_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_iva_resets),
@@ -2843,6 +2876,7 @@ static struct omap_hwmod omap44xx_kbd_hwmod = {
 	.name		= "kbd",
 	.class		= &omap44xx_kbd_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_kbd_irqs,
 	.main_clk	= "kbd_fck",
 	.prcm = {
@@ -2910,6 +2944,7 @@ static struct omap_hwmod omap44xx_mailbox_hwmod = {
 	.name		= "mailbox",
 	.class		= &omap44xx_mailbox_hwmod_class,
 	.clkdm_name	= "l4_cfg_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_mailbox_irqs,
 	.prcm = {
 		.omap4 = {
@@ -3006,6 +3041,7 @@ static struct omap_hwmod omap44xx_mcbsp1_hwmod = {
 	.name		= "mcbsp1",
 	.class		= &omap44xx_mcbsp_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_mcbsp1_irqs,
 	.sdma_reqs	= omap44xx_mcbsp1_sdma_reqs,
 	.main_clk	= "mcbsp1_fck",
@@ -3088,6 +3124,7 @@ static struct omap_hwmod omap44xx_mcbsp2_hwmod = {
 	.name		= "mcbsp2",
 	.class		= &omap44xx_mcbsp_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_mcbsp2_irqs,
 	.sdma_reqs	= omap44xx_mcbsp2_sdma_reqs,
 	.main_clk	= "mcbsp2_fck",
@@ -3170,6 +3207,7 @@ static struct omap_hwmod omap44xx_mcbsp3_hwmod = {
 	.name		= "mcbsp3",
 	.class		= &omap44xx_mcbsp_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_mcbsp3_irqs,
 	.sdma_reqs	= omap44xx_mcbsp3_sdma_reqs,
 	.main_clk	= "mcbsp3_fck",
@@ -3231,6 +3269,7 @@ static struct omap_hwmod omap44xx_mcbsp4_hwmod = {
 	.name		= "mcbsp4",
 	.class		= &omap44xx_mcbsp_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_mcbsp4_irqs,
 	.sdma_reqs	= omap44xx_mcbsp4_sdma_reqs,
 	.main_clk	= "mcbsp4_fck",
@@ -3327,6 +3366,7 @@ static struct omap_hwmod omap44xx_mcpdm_hwmod = {
 	.name		= "mcpdm",
 	.class		= &omap44xx_mcpdm_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_mcpdm_irqs,
 	.sdma_reqs	= omap44xx_mcpdm_sdma_reqs,
 	.main_clk	= "mcpdm_fck",
@@ -3414,6 +3454,7 @@ static struct omap_hwmod omap44xx_mcspi1_hwmod = {
 	.name		= "mcspi1",
 	.class		= &omap44xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_mcspi1_irqs,
 	.sdma_reqs	= omap44xx_mcspi1_sdma_reqs,
 	.main_clk	= "mcspi1_fck",
@@ -3476,6 +3517,7 @@ static struct omap_hwmod omap44xx_mcspi2_hwmod = {
 	.name		= "mcspi2",
 	.class		= &omap44xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_mcspi2_irqs,
 	.sdma_reqs	= omap44xx_mcspi2_sdma_reqs,
 	.main_clk	= "mcspi2_fck",
@@ -3538,6 +3580,7 @@ static struct omap_hwmod omap44xx_mcspi3_hwmod = {
 	.name		= "mcspi3",
 	.class		= &omap44xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_mcspi3_irqs,
 	.sdma_reqs	= omap44xx_mcspi3_sdma_reqs,
 	.main_clk	= "mcspi3_fck",
@@ -3598,6 +3641,7 @@ static struct omap_hwmod omap44xx_mcspi4_hwmod = {
 	.name		= "mcspi4",
 	.class		= &omap44xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_mcspi4_irqs,
 	.sdma_reqs	= omap44xx_mcspi4_sdma_reqs,
 	.main_clk	= "mcspi4_fck",
@@ -3684,6 +3728,7 @@ static struct omap_hwmod omap44xx_mmc1_hwmod = {
 	.name		= "mmc1",
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_mmc1_irqs,
 	.sdma_reqs	= omap44xx_mmc1_sdma_reqs,
 	.main_clk	= "mmc1_fck",
@@ -3745,6 +3790,7 @@ static struct omap_hwmod omap44xx_mmc2_hwmod = {
 	.name		= "mmc2",
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_mmc2_irqs,
 	.sdma_reqs	= omap44xx_mmc2_sdma_reqs,
 	.main_clk	= "mmc2_fck",
@@ -3801,6 +3847,7 @@ static struct omap_hwmod omap44xx_mmc3_hwmod = {
 	.name		= "mmc3",
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_mmc3_irqs,
 	.sdma_reqs	= omap44xx_mmc3_sdma_reqs,
 	.main_clk	= "mmc3_fck",
@@ -3855,6 +3902,7 @@ static struct omap_hwmod omap44xx_mmc4_hwmod = {
 	.name		= "mmc4",
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_mmc4_irqs,
 
 	.sdma_reqs	= omap44xx_mmc4_sdma_reqs,
@@ -3910,6 +3958,7 @@ static struct omap_hwmod omap44xx_mmc5_hwmod = {
 	.name		= "mmc5",
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_mmc5_irqs,
 	.sdma_reqs	= omap44xx_mmc5_sdma_reqs,
 	.main_clk	= "mmc5_fck",
@@ -3952,7 +4001,8 @@ static struct omap_hwmod omap44xx_mpu_hwmod = {
 	.name		= "mpu",
 	.class		= &omap44xx_mpu_hwmod_class,
 	.clkdm_name	= "mpuss_clkdm",
-	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
+	.flags		= HWMOD_CONTEXT_REG | HWMOD_INIT_NO_IDLE |
+			  HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_mpu_irqs,
 	.main_clk	= "dpll_mpu_m2_ck",
 	.prcm = {
@@ -4029,6 +4079,7 @@ static struct omap_hwmod omap44xx_smartreflex_core_hwmod = {
 	.name		= "smartreflex_core",
 	.class		= &omap44xx_smartreflex_hwmod_class,
 	.clkdm_name	= "l4_ao_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_smartreflex_core_irqs,
 
 	.main_clk	= "smartreflex_core_fck",
@@ -4082,6 +4133,7 @@ static struct omap_hwmod omap44xx_smartreflex_iva_hwmod = {
 	.name		= "smartreflex_iva",
 	.class		= &omap44xx_smartreflex_hwmod_class,
 	.clkdm_name	= "l4_ao_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_smartreflex_iva_irqs,
 	.main_clk	= "smartreflex_iva_fck",
 	.prcm = {
@@ -4134,6 +4186,7 @@ static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod = {
 	.name		= "smartreflex_mpu",
 	.class		= &omap44xx_smartreflex_hwmod_class,
 	.clkdm_name	= "l4_ao_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_smartreflex_mpu_irqs,
 	.main_clk	= "smartreflex_mpu_fck",
 	.prcm = {
@@ -4200,6 +4253,7 @@ static struct omap_hwmod omap44xx_spinlock_hwmod = {
 	.name		= "spinlock",
 	.class		= &omap44xx_spinlock_hwmod_class,
 	.clkdm_name	= "l4_cfg_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4CFG_HW_SEM_CLKCTRL_OFFSET,
@@ -4292,6 +4346,7 @@ static struct omap_hwmod omap44xx_timer1_hwmod = {
 	.name		= "timer1",
 	.class		= &omap44xx_timer_1ms_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_timer1_irqs,
 	.main_clk	= "timer1_fck",
 	.prcm = {
@@ -4340,6 +4395,7 @@ static struct omap_hwmod omap44xx_timer2_hwmod = {
 	.name		= "timer2",
 	.class		= &omap44xx_timer_1ms_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_timer2_irqs,
 	.main_clk	= "timer2_fck",
 	.prcm = {
@@ -4388,6 +4444,7 @@ static struct omap_hwmod omap44xx_timer3_hwmod = {
 	.name		= "timer3",
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_timer3_irqs,
 	.main_clk	= "timer3_fck",
 	.prcm = {
@@ -4436,6 +4493,7 @@ static struct omap_hwmod omap44xx_timer4_hwmod = {
 	.name		= "timer4",
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_timer4_irqs,
 	.main_clk	= "timer4_fck",
 	.prcm = {
@@ -4503,6 +4561,7 @@ static struct omap_hwmod omap44xx_timer5_hwmod = {
 	.name		= "timer5",
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_timer5_irqs,
 	.main_clk	= "timer5_fck",
 	.prcm = {
@@ -4570,6 +4629,7 @@ static struct omap_hwmod omap44xx_timer6_hwmod = {
 	.name		= "timer6",
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_timer6_irqs,
 
 	.main_clk	= "timer6_fck",
@@ -4638,6 +4698,7 @@ static struct omap_hwmod omap44xx_timer7_hwmod = {
 	.name		= "timer7",
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_timer7_irqs,
 	.main_clk	= "timer7_fck",
 	.prcm = {
@@ -4705,6 +4766,7 @@ static struct omap_hwmod omap44xx_timer8_hwmod = {
 	.name		= "timer8",
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_timer8_irqs,
 	.main_clk	= "timer8_fck",
 	.prcm = {
@@ -4753,6 +4815,7 @@ static struct omap_hwmod omap44xx_timer9_hwmod = {
 	.name		= "timer9",
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_timer9_irqs,
 	.main_clk	= "timer9_fck",
 	.prcm = {
@@ -4801,6 +4864,7 @@ static struct omap_hwmod omap44xx_timer10_hwmod = {
 	.name		= "timer10",
 	.class		= &omap44xx_timer_1ms_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_timer10_irqs,
 	.main_clk	= "timer10_fck",
 	.prcm = {
@@ -4849,6 +4913,7 @@ static struct omap_hwmod omap44xx_timer11_hwmod = {
 	.name		= "timer11",
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_timer11_irqs,
 	.main_clk	= "timer11_fck",
 	.prcm = {
@@ -4925,6 +4990,7 @@ static struct omap_hwmod omap44xx_uart1_hwmod = {
 	.name		= "uart1",
 	.class		= &omap44xx_uart_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_uart1_irqs,
 	.sdma_reqs	= omap44xx_uart1_sdma_reqs,
 	.main_clk	= "uart1_fck",
@@ -4979,6 +5045,7 @@ static struct omap_hwmod omap44xx_uart2_hwmod = {
 	.name		= "uart2",
 	.class		= &omap44xx_uart_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_uart2_irqs,
 	.sdma_reqs	= omap44xx_uart2_sdma_reqs,
 	.main_clk	= "uart2_fck",
@@ -5033,7 +5100,8 @@ static struct omap_hwmod omap44xx_uart3_hwmod = {
 	.name		= "uart3",
 	.class		= &omap44xx_uart_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
+	.flags		= HWMOD_CONTEXT_REG | HWMOD_INIT_NO_IDLE |
+			  HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_uart3_irqs,
 	.sdma_reqs	= omap44xx_uart3_sdma_reqs,
 	.main_clk	= "uart3_fck",
@@ -5088,6 +5156,7 @@ static struct omap_hwmod omap44xx_uart4_hwmod = {
 	.name		= "uart4",
 	.class		= &omap44xx_uart_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_uart4_irqs,
 	.sdma_reqs	= omap44xx_uart4_sdma_reqs,
 	.main_clk	= "uart4_fck",
@@ -5168,7 +5237,8 @@ static struct omap_hwmod omap44xx_usb_otg_hs_hwmod = {
 	.name		= "usb_otg_hs",
 	.class		= &omap44xx_usb_otg_hs_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
-	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
+	.flags		= HWMOD_CONTEXT_REG | HWMOD_SWSUP_SIDLE |
+			  HWMOD_SWSUP_MSTANDBY,
 	.mpu_irqs	= omap44xx_usb_otg_hs_irqs,
 	.main_clk	= "usb_otg_hs_ick",
 	.prcm = {
@@ -5243,6 +5313,7 @@ static struct omap_hwmod omap44xx_wd_timer2_hwmod = {
 	.name		= "wd_timer2",
 	.class		= &omap44xx_wd_timer_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_wd_timer2_irqs,
 	.main_clk	= "wd_timer2_fck",
 	.prcm = {
@@ -5309,6 +5380,7 @@ static struct omap_hwmod omap44xx_wd_timer3_hwmod = {
 	.name		= "wd_timer3",
 	.class		= &omap44xx_wd_timer_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.mpu_irqs	= omap44xx_wd_timer3_irqs,
 	.main_clk	= "wd_timer3_fck",
 	.prcm = {
@@ -5396,6 +5468,7 @@ static struct omap_hwmod omap44xx_usb_host_hs_hwmod = {
 	.name		= "usb_host_hs",
 	.class		= &omap44xx_usb_host_hs_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.main_clk	= "usb_host_hs_fck",
 	.prcm = {
 		.omap4 = {
@@ -5510,6 +5583,7 @@ static struct omap_hwmod omap44xx_usb_tll_hs_hwmod = {
 	.name		= "usb_tll_hs",
 	.class		= &omap44xx_usb_tll_hs_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
+	.flags		= HWMOD_CONTEXT_REG,
 	.main_clk	= "usb_tll_hs_ick",
 	.prcm = {
 		.omap4 = {
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 8070145..4e5513b 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -399,6 +399,7 @@ struct omap_hwmod_omap4_prcm {
  *     in order to complete the reset. Optional clocks will be disabled
  *     again after the reset.
  * HWMOD_16BIT_REG: Module has 16bit registers
+ * HWMOD_CONTEXT_REG: Module has a valid context register
  */
 #define HWMOD_SWSUP_SIDLE			(1 << 0)
 #define HWMOD_SWSUP_MSTANDBY			(1 << 1)
@@ -409,6 +410,7 @@ struct omap_hwmod_omap4_prcm {
 #define HWMOD_NO_IDLEST				(1 << 6)
 #define HWMOD_CONTROL_OPT_CLKS_IN_RESET		(1 << 7)
 #define HWMOD_16BIT_REG				(1 << 8)
+#define HWMOD_CONTEXT_REG			(1 << 9)
 
 /*
  * omap_hwmod._int_flags definitions
-- 
1.7.4.1

