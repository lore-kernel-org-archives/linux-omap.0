From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 10/13] OMAP4: hwmod data: Add PRM context register offset
Date: Mon, 27 Jun 2011 17:47:18 +0200
Message-ID: <1309189641-25010-11-git-send-email-b-cousson@ti.com>
References: <1309189641-25010-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58139 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751192Ab1F0Prr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Jun 2011 11:47:47 -0400
In-Reply-To: <1309189641-25010-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, rnayak@ti.com
Cc: santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Add a 'context_offs' entry in the prcm.omap4 structure to all
IPs when applicable.
The offset will be used to retrieve the per module context lost
information now available on OMAP4.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |   74 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 2 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 06df473..0f692fd 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -126,6 +126,7 @@ static struct omap_hwmod omap44xx_dmm_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_MEMIF_DMM_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_MEMIF_DMM_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_dmm_slaves,
@@ -181,6 +182,7 @@ static struct omap_hwmod omap44xx_emif_fw_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_MEMIF_EMIF_FW_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_MEMIF_EMIF_FW_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_emif_fw_slaves,
@@ -226,6 +228,7 @@ static struct omap_hwmod omap44xx_l3_instr_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3INSTR_L3_INSTR_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L3INSTR_L3_INSTR_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_l3_instr_slaves,
@@ -325,6 +328,7 @@ static struct omap_hwmod omap44xx_l3_main_1_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3_1_L3_1_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L3_1_L3_1_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_l3_main_1_slaves,
@@ -426,6 +430,7 @@ static struct omap_hwmod omap44xx_l3_main_2_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3_2_L3_2_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L3_2_L3_2_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_l3_main_2_slaves,
@@ -482,6 +487,7 @@ static struct omap_hwmod omap44xx_l3_main_3_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3INSTR_L3_3_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L3INSTR_L3_3_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_l3_main_3_slaves,
@@ -573,6 +579,7 @@ static struct omap_hwmod omap44xx_l4_cfg_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4CFG_L4_CFG_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4CFG_L4_CFG_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_l4_cfg_slaves,
@@ -601,6 +608,7 @@ static struct omap_hwmod omap44xx_l4_per_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_L4PER_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4PER_L4_PER_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_l4_per_slaves,
@@ -629,6 +637,7 @@ static struct omap_hwmod omap44xx_l4_wkup_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_WKUP_L4WKUP_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_WKUP_L4WKUP_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_l4_wkup_slaves,
@@ -807,6 +816,7 @@ static struct omap_hwmod omap44xx_aess_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_AESS_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_ABE_AESS_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_aess_slaves,
@@ -897,6 +907,7 @@ static struct omap_hwmod omap44xx_counter_32k_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_WKUP_SYNCTIMER_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_WKUP_SYNCTIMER_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_counter_32k_slaves,
@@ -981,6 +992,7 @@ static struct omap_hwmod omap44xx_dma_system_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_SDMA_SDMA_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_SDMA_SDMA_CONTEXT_OFFSET,
 		},
 	},
 	.dev_attr	= &dma_dev_attr,
@@ -1075,6 +1087,7 @@ static struct omap_hwmod omap44xx_dmic_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_DMIC_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_ABE_DMIC_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_dmic_slaves,
@@ -1160,6 +1173,7 @@ static struct omap_hwmod omap44xx_dsp_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_TESLA_TESLA_CLKCTRL_OFFSET,
 			.rstctrl_offs = OMAP4_RM_TESLA_RSTCTRL_OFFSET,
+			.context_offs = OMAP4_RM_TESLA_TESLA_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_dsp_slaves,
@@ -1248,6 +1262,7 @@ static struct omap_hwmod omap44xx_dss_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_DSS_DSS_CONTEXT_OFFSET,
 		},
 	},
 	.opt_clks	= dss_opt_clks,
@@ -1346,6 +1361,7 @@ static struct omap_hwmod omap44xx_dss_dispc_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_DSS_DSS_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_dss_dispc_slaves,
@@ -1438,6 +1454,7 @@ static struct omap_hwmod omap44xx_dss_dsi1_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_DSS_DSS_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_dss_dsi1_slaves,
@@ -1509,6 +1526,7 @@ static struct omap_hwmod omap44xx_dss_dsi2_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_DSS_DSS_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_dss_dsi2_slaves,
@@ -1600,6 +1618,7 @@ static struct omap_hwmod omap44xx_dss_hdmi_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_DSS_DSS_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_dss_hdmi_slaves,
@@ -1685,6 +1704,7 @@ static struct omap_hwmod omap44xx_dss_rfbi_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_DSS_DSS_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_dss_rfbi_slaves,
@@ -1753,6 +1773,7 @@ static struct omap_hwmod omap44xx_dss_venc_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_DSS_DSS_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_dss_venc_slaves,
@@ -1832,6 +1853,7 @@ static struct omap_hwmod omap44xx_gpio1_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_WKUP_GPIO1_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_WKUP_GPIO1_CONTEXT_OFFSET,
 		},
 	},
 	.opt_clks	= gpio1_opt_clks,
@@ -1886,6 +1908,7 @@ static struct omap_hwmod omap44xx_gpio2_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_GPIO2_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4PER_GPIO2_CONTEXT_OFFSET,
 		},
 	},
 	.opt_clks	= gpio2_opt_clks,
@@ -1940,6 +1963,7 @@ static struct omap_hwmod omap44xx_gpio3_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_GPIO3_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4PER_GPIO3_CONTEXT_OFFSET,
 		},
 	},
 	.opt_clks	= gpio3_opt_clks,
@@ -1994,6 +2018,7 @@ static struct omap_hwmod omap44xx_gpio4_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_GPIO4_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4PER_GPIO4_CONTEXT_OFFSET,
 		},
 	},
 	.opt_clks	= gpio4_opt_clks,
@@ -2048,6 +2073,7 @@ static struct omap_hwmod omap44xx_gpio5_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_GPIO5_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4PER_GPIO5_CONTEXT_OFFSET,
 		},
 	},
 	.opt_clks	= gpio5_opt_clks,
@@ -2102,6 +2128,7 @@ static struct omap_hwmod omap44xx_gpio6_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_GPIO6_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4PER_GPIO6_CONTEXT_OFFSET,
 		},
 	},
 	.opt_clks	= gpio6_opt_clks,
@@ -2181,6 +2208,7 @@ static struct omap_hwmod omap44xx_hsi_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3INIT_HSI_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L3INIT_HSI_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_hsi_slaves,
@@ -2258,6 +2286,7 @@ static struct omap_hwmod omap44xx_i2c1_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_I2C1_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4PER_I2C1_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_i2c1_slaves,
@@ -2312,6 +2341,7 @@ static struct omap_hwmod omap44xx_i2c2_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_I2C2_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4PER_I2C2_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_i2c2_slaves,
@@ -2366,6 +2396,7 @@ static struct omap_hwmod omap44xx_i2c3_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_I2C3_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4PER_I2C3_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_i2c3_slaves,
@@ -2420,6 +2451,7 @@ static struct omap_hwmod omap44xx_i2c4_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_I2C4_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4PER_I2C4_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_i2c4_slaves,
@@ -2516,6 +2548,7 @@ static struct omap_hwmod omap44xx_ipu_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_DUCATI_DUCATI_CLKCTRL_OFFSET,
 			.rstctrl_offs = OMAP4_RM_DUCATI_RSTCTRL_OFFSET,
+			.context_offs = OMAP4_RM_DUCATI_DUCATI_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_ipu_slaves,
@@ -2602,6 +2635,7 @@ static struct omap_hwmod omap44xx_iss_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_CAM_ISS_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_CAM_ISS_CONTEXT_OFFSET,
 		},
 	},
 	.opt_clks	= iss_opt_clks,
@@ -2716,6 +2750,7 @@ static struct omap_hwmod omap44xx_iva_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_IVAHD_IVAHD_CLKCTRL_OFFSET,
 			.rstctrl_offs = OMAP4_RM_IVAHD_RSTCTRL_OFFSET,
+			.context_offs = OMAP4_RM_IVAHD_IVAHD_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_iva_slaves,
@@ -2786,6 +2821,7 @@ static struct omap_hwmod omap44xx_kbd_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_WKUP_KEYBOARD_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_WKUP_KEYBOARD_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_kbd_slaves,
@@ -2851,6 +2887,7 @@ static struct omap_hwmod omap44xx_mailbox_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4CFG_MAILBOX_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4CFG_MAILBOX_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_mailbox_slaves,
@@ -2944,6 +2981,7 @@ static struct omap_hwmod omap44xx_mcbsp1_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_MCBSP1_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_ABE_MCBSP1_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_mcbsp1_slaves,
@@ -3018,6 +3056,7 @@ static struct omap_hwmod omap44xx_mcbsp2_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_MCBSP2_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_ABE_MCBSP2_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_mcbsp2_slaves,
@@ -3092,6 +3131,7 @@ static struct omap_hwmod omap44xx_mcbsp3_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_MCBSP3_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_ABE_MCBSP3_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_mcbsp3_slaves,
@@ -3145,6 +3185,7 @@ static struct omap_hwmod omap44xx_mcbsp4_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_MCBSP4_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4PER_MCBSP4_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_mcbsp4_slaves,
@@ -3238,6 +3279,7 @@ static struct omap_hwmod omap44xx_mcpdm_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_PDM_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_ABE_PDM_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_mcpdm_slaves,
@@ -3324,6 +3366,7 @@ static struct omap_hwmod omap44xx_mcspi1_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_MCSPI1_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4PER_MCSPI1_CONTEXT_OFFSET,
 		},
 	},
 	.dev_attr	= &mcspi1_dev_attr,
@@ -3385,6 +3428,7 @@ static struct omap_hwmod omap44xx_mcspi2_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_MCSPI2_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4PER_MCSPI2_CONTEXT_OFFSET,
 		},
 	},
 	.dev_attr	= &mcspi2_dev_attr,
@@ -3446,6 +3490,7 @@ static struct omap_hwmod omap44xx_mcspi3_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_MCSPI3_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4PER_MCSPI3_CONTEXT_OFFSET,
 		},
 	},
 	.dev_attr	= &mcspi3_dev_attr,
@@ -3505,6 +3550,7 @@ static struct omap_hwmod omap44xx_mcspi4_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_MCSPI4_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4PER_MCSPI4_CONTEXT_OFFSET,
 		},
 	},
 	.dev_attr	= &mcspi4_dev_attr,
@@ -3590,6 +3636,7 @@ static struct omap_hwmod omap44xx_mmc1_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3INIT_MMC1_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L3INIT_MMC1_CONTEXT_OFFSET,
 		},
 	},
 	.dev_attr	= &mmc1_dev_attr,
@@ -3650,6 +3697,7 @@ static struct omap_hwmod omap44xx_mmc2_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3INIT_MMC2_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L3INIT_MMC2_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_mmc2_slaves,
@@ -3705,6 +3753,7 @@ static struct omap_hwmod omap44xx_mmc3_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_MMCSD3_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4PER_MMCSD3_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_mmc3_slaves,
@@ -3758,6 +3807,7 @@ static struct omap_hwmod omap44xx_mmc4_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_MMCSD4_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4PER_MMCSD4_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_mmc4_slaves,
@@ -3811,6 +3861,7 @@ static struct omap_hwmod omap44xx_mmc5_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_MMCSD5_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4PER_MMCSD5_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_mmc5_slaves,
@@ -3852,6 +3903,7 @@ static struct omap_hwmod omap44xx_mpu_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_MPU_MPU_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_MPU_MPU_CONTEXT_OFFSET,
 		},
 	},
 	.masters	= omap44xx_mpu_masters,
@@ -3925,6 +3977,7 @@ static struct omap_hwmod omap44xx_smartreflex_core_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_ALWON_SR_CORE_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_ALWON_SR_CORE_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_smartreflex_core_slaves,
@@ -3972,6 +4025,7 @@ static struct omap_hwmod omap44xx_smartreflex_iva_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_ALWON_SR_IVA_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_ALWON_SR_IVA_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_smartreflex_iva_slaves,
@@ -4019,6 +4073,7 @@ static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_ALWON_SR_MPU_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_ALWON_SR_MPU_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_smartreflex_mpu_slaves,
@@ -4081,6 +4136,7 @@ static struct omap_hwmod omap44xx_spinlock_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4CFG_HW_SEM_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4CFG_HW_SEM_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_spinlock_slaves,
@@ -4165,6 +4221,7 @@ static struct omap_hwmod omap44xx_timer1_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_WKUP_TIMER1_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_WKUP_TIMER1_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_timer1_slaves,
@@ -4211,6 +4268,7 @@ static struct omap_hwmod omap44xx_timer2_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER2_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4PER_DMTIMER2_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_timer2_slaves,
@@ -4257,6 +4315,7 @@ static struct omap_hwmod omap44xx_timer3_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER3_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4PER_DMTIMER3_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_timer3_slaves,
@@ -4303,6 +4362,7 @@ static struct omap_hwmod omap44xx_timer4_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER4_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4PER_DMTIMER4_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_timer4_slaves,
@@ -4368,6 +4428,7 @@ static struct omap_hwmod omap44xx_timer5_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_TIMER5_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_ABE_TIMER5_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_timer5_slaves,
@@ -4433,6 +4494,7 @@ static struct omap_hwmod omap44xx_timer6_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_TIMER6_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_ABE_TIMER6_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_timer6_slaves,
@@ -4498,6 +4560,7 @@ static struct omap_hwmod omap44xx_timer7_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_TIMER7_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_ABE_TIMER7_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_timer7_slaves,
@@ -4563,6 +4626,7 @@ static struct omap_hwmod omap44xx_timer8_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_TIMER8_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_ABE_TIMER8_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_timer8_slaves,
@@ -4609,6 +4673,7 @@ static struct omap_hwmod omap44xx_timer9_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER9_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4PER_DMTIMER9_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_timer9_slaves,
@@ -4655,6 +4720,7 @@ static struct omap_hwmod omap44xx_timer10_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER10_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4PER_DMTIMER10_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_timer10_slaves,
@@ -4701,6 +4767,7 @@ static struct omap_hwmod omap44xx_timer11_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER11_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4PER_DMTIMER11_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_timer11_slaves,
@@ -4776,6 +4843,7 @@ static struct omap_hwmod omap44xx_uart1_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_UART1_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4PER_UART1_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_uart1_slaves,
@@ -4829,6 +4897,7 @@ static struct omap_hwmod omap44xx_uart2_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_UART2_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4PER_UART2_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_uart2_slaves,
@@ -4883,6 +4952,7 @@ static struct omap_hwmod omap44xx_uart3_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_UART3_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4PER_UART3_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_uart3_slaves,
@@ -4936,6 +5006,7 @@ static struct omap_hwmod omap44xx_uart4_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_UART4_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4PER_UART4_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_uart4_slaves,
@@ -5015,6 +5086,7 @@ static struct omap_hwmod omap44xx_usb_otg_hs_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3INIT_USB_OTG_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L3INIT_USB_OTG_CONTEXT_OFFSET,
 		},
 	},
 	.opt_clks	= usb_otg_hs_opt_clks,
@@ -5088,6 +5160,7 @@ static struct omap_hwmod omap44xx_wd_timer2_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_WKUP_WDT2_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_WKUP_WDT2_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_wd_timer2_slaves,
@@ -5153,6 +5226,7 @@ static struct omap_hwmod omap44xx_wd_timer3_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_WDT3_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_ABE_WDT3_CONTEXT_OFFSET,
 		},
 	},
 	.slaves		= omap44xx_wd_timer3_slaves,
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 75bf4fa..40e561e 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -365,6 +365,7 @@ struct omap_hwmod_omap2_prcm {
 struct omap_hwmod_omap4_prcm {
 	u16		clkctrl_offs;
 	u16		rstctrl_offs;
+	u16		context_offs;
 	u8		submodule_wkdep_bit;
 };
 
-- 
1.7.0.4

