From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 16/18] OMAP4: hwmod data: Replace CHIP_IS_OMAP4430 by OMAP44XX
Date: Fri, 1 Jul 2011 22:41:39 +0200
Message-ID: <1309552901-8944-17-git-send-email-b-cousson@ti.com>
References: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57620 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756690Ab1GAUmZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 16:42:25 -0400
In-Reply-To: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

In order to make hwmod data usable for all OMAP4430 variants,
rename chip macro CHIP_IS_OMAP44XX.

Create the macro as well in cpu.h

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  164 ++++++++++++++--------------
 arch/arm/plat-omap/include/plat/cpu.h      |    2 +
 2 files changed, 84 insertions(+), 82 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 380d19d..f7f4840 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -124,7 +124,7 @@ static struct omap_hwmod omap44xx_dmm_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dmm_slaves),
 	.mpu_irqs	= omap44xx_dmm_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dmm_irqs),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -173,7 +173,7 @@ static struct omap_hwmod omap44xx_emif_fw_hwmod = {
 	.class		= &omap44xx_emif_fw_hwmod_class,
 	.slaves		= omap44xx_emif_fw_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_emif_fw_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -212,7 +212,7 @@ static struct omap_hwmod omap44xx_l3_instr_hwmod = {
 	.class		= &omap44xx_l3_hwmod_class,
 	.slaves		= omap44xx_l3_instr_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_l3_instr_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* l3_main_1 interface data */
@@ -305,7 +305,7 @@ static struct omap_hwmod omap44xx_l3_main_1_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_l3_main_1_slaves),
 	.mpu_irqs	= omap44xx_l3_main_1_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_l3_main_1_irqs),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* l3_main_2 interface data */
@@ -400,7 +400,7 @@ static struct omap_hwmod omap44xx_l3_main_2_hwmod = {
 	.class		= &omap44xx_l3_hwmod_class,
 	.slaves		= omap44xx_l3_main_2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_l3_main_2_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* l3_main_3 interface data */
@@ -450,7 +450,7 @@ static struct omap_hwmod omap44xx_l3_main_3_hwmod = {
 	.class		= &omap44xx_l3_hwmod_class,
 	.slaves		= omap44xx_l3_main_3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_l3_main_3_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -507,7 +507,7 @@ static struct omap_hwmod omap44xx_l4_abe_hwmod = {
 	.class		= &omap44xx_l4_hwmod_class,
 	.slaves		= omap44xx_l4_abe_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_l4_abe_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* l4_cfg interface data */
@@ -529,7 +529,7 @@ static struct omap_hwmod omap44xx_l4_cfg_hwmod = {
 	.class		= &omap44xx_l4_hwmod_class,
 	.slaves		= omap44xx_l4_cfg_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_l4_cfg_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* l4_per interface data */
@@ -551,7 +551,7 @@ static struct omap_hwmod omap44xx_l4_per_hwmod = {
 	.class		= &omap44xx_l4_hwmod_class,
 	.slaves		= omap44xx_l4_per_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_l4_per_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* l4_wkup interface data */
@@ -573,7 +573,7 @@ static struct omap_hwmod omap44xx_l4_wkup_hwmod = {
 	.class		= &omap44xx_l4_hwmod_class,
 	.slaves		= omap44xx_l4_wkup_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_l4_wkup_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -603,7 +603,7 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
 	.class		= &omap44xx_mpu_bus_hwmod_class,
 	.slaves		= omap44xx_mpu_private_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mpu_private_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -750,7 +750,7 @@ static struct omap_hwmod omap44xx_aess_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_aess_slaves),
 	.masters	= omap44xx_aess_masters,
 	.masters_cnt	= ARRAY_SIZE(omap44xx_aess_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -777,7 +777,7 @@ static struct omap_hwmod omap44xx_bandgap_hwmod = {
 	},
 	.opt_clks	= bandgap_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(bandgap_opt_clks),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -836,7 +836,7 @@ static struct omap_hwmod omap44xx_counter_32k_hwmod = {
 	},
 	.slaves		= omap44xx_counter_32k_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_counter_32k_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -922,7 +922,7 @@ static struct omap_hwmod omap44xx_dma_system_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dma_system_slaves),
 	.masters	= omap44xx_dma_system_masters,
 	.masters_cnt	= ARRAY_SIZE(omap44xx_dma_system_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -1012,7 +1012,7 @@ static struct omap_hwmod omap44xx_dmic_hwmod = {
 	},
 	.slaves		= omap44xx_dmic_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dmic_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -1076,7 +1076,7 @@ static struct omap_hwmod omap44xx_dsp_c0_hwmod = {
 			.rstctrl_reg = OMAP4430_RM_TESLA_RSTCTRL,
 		},
 	},
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct omap_hwmod omap44xx_dsp_hwmod = {
@@ -1097,7 +1097,7 @@ static struct omap_hwmod omap44xx_dsp_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dsp_slaves),
 	.masters	= omap44xx_dsp_masters,
 	.masters_cnt	= ARRAY_SIZE(omap44xx_dsp_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -1186,7 +1186,7 @@ static struct omap_hwmod omap44xx_dss_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dss_slaves),
 	.masters	= omap44xx_dss_masters,
 	.masters_cnt	= ARRAY_SIZE(omap44xx_dss_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -1279,7 +1279,7 @@ static struct omap_hwmod omap44xx_dss_dispc_hwmod = {
 	},
 	.slaves		= omap44xx_dss_dispc_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dss_dispc_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -1370,7 +1370,7 @@ static struct omap_hwmod omap44xx_dss_dsi1_hwmod = {
 	},
 	.slaves		= omap44xx_dss_dsi1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dss_dsi1_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* dss_dsi2 */
@@ -1440,7 +1440,7 @@ static struct omap_hwmod omap44xx_dss_dsi2_hwmod = {
 	},
 	.slaves		= omap44xx_dss_dsi2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dss_dsi2_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -1530,7 +1530,7 @@ static struct omap_hwmod omap44xx_dss_hdmi_hwmod = {
 	},
 	.slaves		= omap44xx_dss_hdmi_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dss_hdmi_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -1614,7 +1614,7 @@ static struct omap_hwmod omap44xx_dss_rfbi_hwmod = {
 	},
 	.slaves		= omap44xx_dss_rfbi_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dss_rfbi_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -1681,7 +1681,7 @@ static struct omap_hwmod omap44xx_dss_venc_hwmod = {
 	},
 	.slaves		= omap44xx_dss_venc_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dss_venc_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -1762,7 +1762,7 @@ static struct omap_hwmod omap44xx_gpio1_hwmod = {
 	.dev_attr	= &gpio_dev_attr,
 	.slaves		= omap44xx_gpio1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio1_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* gpio2 */
@@ -1815,7 +1815,7 @@ static struct omap_hwmod omap44xx_gpio2_hwmod = {
 	.dev_attr	= &gpio_dev_attr,
 	.slaves		= omap44xx_gpio2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio2_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* gpio3 */
@@ -1868,7 +1868,7 @@ static struct omap_hwmod omap44xx_gpio3_hwmod = {
 	.dev_attr	= &gpio_dev_attr,
 	.slaves		= omap44xx_gpio3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio3_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* gpio4 */
@@ -1921,7 +1921,7 @@ static struct omap_hwmod omap44xx_gpio4_hwmod = {
 	.dev_attr	= &gpio_dev_attr,
 	.slaves		= omap44xx_gpio4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio4_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* gpio5 */
@@ -1974,7 +1974,7 @@ static struct omap_hwmod omap44xx_gpio5_hwmod = {
 	.dev_attr	= &gpio_dev_attr,
 	.slaves		= omap44xx_gpio5_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio5_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* gpio6 */
@@ -2027,7 +2027,7 @@ static struct omap_hwmod omap44xx_gpio6_hwmod = {
 	.dev_attr	= &gpio_dev_attr,
 	.slaves		= omap44xx_gpio6_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio6_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -2104,7 +2104,7 @@ static struct omap_hwmod omap44xx_hsi_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_hsi_slaves),
 	.masters	= omap44xx_hsi_masters,
 	.masters_cnt	= ARRAY_SIZE(omap44xx_hsi_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -2178,7 +2178,7 @@ static struct omap_hwmod omap44xx_i2c1_hwmod = {
 	},
 	.slaves		= omap44xx_i2c1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c1_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* i2c2 */
@@ -2231,7 +2231,7 @@ static struct omap_hwmod omap44xx_i2c2_hwmod = {
 	},
 	.slaves		= omap44xx_i2c2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c2_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* i2c3 */
@@ -2284,7 +2284,7 @@ static struct omap_hwmod omap44xx_i2c3_hwmod = {
 	},
 	.slaves		= omap44xx_i2c3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c3_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* i2c4 */
@@ -2337,7 +2337,7 @@ static struct omap_hwmod omap44xx_i2c4_hwmod = {
 	},
 	.slaves		= omap44xx_i2c4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c4_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -2396,7 +2396,7 @@ static struct omap_hwmod omap44xx_ipu_c0_hwmod = {
 			.rstctrl_reg = OMAP4430_RM_DUCATI_RSTCTRL,
 		},
 	},
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* Pseudo hwmod for reset control purpose only */
@@ -2411,7 +2411,7 @@ static struct omap_hwmod omap44xx_ipu_c1_hwmod = {
 			.rstctrl_reg = OMAP4430_RM_DUCATI_RSTCTRL,
 		},
 	},
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct omap_hwmod omap44xx_ipu_hwmod = {
@@ -2432,7 +2432,7 @@ static struct omap_hwmod omap44xx_ipu_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_ipu_slaves),
 	.masters	= omap44xx_ipu_masters,
 	.masters_cnt	= ARRAY_SIZE(omap44xx_ipu_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -2519,7 +2519,7 @@ static struct omap_hwmod omap44xx_iss_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_iss_slaves),
 	.masters	= omap44xx_iss_masters,
 	.masters_cnt	= ARRAY_SIZE(omap44xx_iss_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -2592,7 +2592,7 @@ static struct omap_hwmod omap44xx_iva_seq0_hwmod = {
 			.rstctrl_reg = OMAP4430_RM_IVAHD_RSTCTRL,
 		},
 	},
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* Pseudo hwmod for reset control purpose only */
@@ -2607,7 +2607,7 @@ static struct omap_hwmod omap44xx_iva_seq1_hwmod = {
 			.rstctrl_reg = OMAP4430_RM_IVAHD_RSTCTRL,
 		},
 	},
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static struct omap_hwmod omap44xx_iva_hwmod = {
@@ -2628,7 +2628,7 @@ static struct omap_hwmod omap44xx_iva_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_iva_slaves),
 	.masters	= omap44xx_iva_masters,
 	.masters_cnt	= ARRAY_SIZE(omap44xx_iva_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -2695,7 +2695,7 @@ static struct omap_hwmod omap44xx_kbd_hwmod = {
 	},
 	.slaves		= omap44xx_kbd_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_kbd_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -2759,7 +2759,7 @@ static struct omap_hwmod omap44xx_mailbox_hwmod = {
 	},
 	.slaves		= omap44xx_mailbox_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mailbox_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -2851,7 +2851,7 @@ static struct omap_hwmod omap44xx_mcbsp1_hwmod = {
 	},
 	.slaves		= omap44xx_mcbsp1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcbsp1_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* mcbsp2 */
@@ -2924,7 +2924,7 @@ static struct omap_hwmod omap44xx_mcbsp2_hwmod = {
 	},
 	.slaves		= omap44xx_mcbsp2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcbsp2_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* mcbsp3 */
@@ -2997,7 +2997,7 @@ static struct omap_hwmod omap44xx_mcbsp3_hwmod = {
 	},
 	.slaves		= omap44xx_mcbsp3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcbsp3_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* mcbsp4 */
@@ -3049,7 +3049,7 @@ static struct omap_hwmod omap44xx_mcbsp4_hwmod = {
 	},
 	.slaves		= omap44xx_mcbsp4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcbsp4_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -3141,7 +3141,7 @@ static struct omap_hwmod omap44xx_mcpdm_hwmod = {
 	},
 	.slaves		= omap44xx_mcpdm_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcpdm_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -3227,7 +3227,7 @@ static struct omap_hwmod omap44xx_mcspi1_hwmod = {
 	.dev_attr	= &mcspi1_dev_attr,
 	.slaves		= omap44xx_mcspi1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcspi1_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* mcspi2 */
@@ -3287,7 +3287,7 @@ static struct omap_hwmod omap44xx_mcspi2_hwmod = {
 	.dev_attr	= &mcspi2_dev_attr,
 	.slaves		= omap44xx_mcspi2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcspi2_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* mcspi3 */
@@ -3347,7 +3347,7 @@ static struct omap_hwmod omap44xx_mcspi3_hwmod = {
 	.dev_attr	= &mcspi3_dev_attr,
 	.slaves		= omap44xx_mcspi3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcspi3_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* mcspi4 */
@@ -3405,7 +3405,7 @@ static struct omap_hwmod omap44xx_mcspi4_hwmod = {
 	.dev_attr	= &mcspi4_dev_attr,
 	.slaves		= omap44xx_mcspi4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcspi4_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -3491,7 +3491,7 @@ static struct omap_hwmod omap44xx_mmc1_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mmc1_slaves),
 	.masters	= omap44xx_mmc1_masters,
 	.masters_cnt	= ARRAY_SIZE(omap44xx_mmc1_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* mmc2 */
@@ -3549,7 +3549,7 @@ static struct omap_hwmod omap44xx_mmc2_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mmc2_slaves),
 	.masters	= omap44xx_mmc2_masters,
 	.masters_cnt	= ARRAY_SIZE(omap44xx_mmc2_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* mmc3 */
@@ -3601,7 +3601,7 @@ static struct omap_hwmod omap44xx_mmc3_hwmod = {
 	},
 	.slaves		= omap44xx_mmc3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mmc3_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* mmc4 */
@@ -3653,7 +3653,7 @@ static struct omap_hwmod omap44xx_mmc4_hwmod = {
 	},
 	.slaves		= omap44xx_mmc4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mmc4_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* mmc5 */
@@ -3705,7 +3705,7 @@ static struct omap_hwmod omap44xx_mmc5_hwmod = {
 	},
 	.slaves		= omap44xx_mmc5_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_mmc5_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -3745,7 +3745,7 @@ static struct omap_hwmod omap44xx_mpu_hwmod = {
 	},
 	.masters	= omap44xx_mpu_masters,
 	.masters_cnt	= ARRAY_SIZE(omap44xx_mpu_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -3817,7 +3817,7 @@ static struct omap_hwmod omap44xx_smartreflex_core_hwmod = {
 	},
 	.slaves		= omap44xx_smartreflex_core_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_core_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* smartreflex_iva */
@@ -3863,7 +3863,7 @@ static struct omap_hwmod omap44xx_smartreflex_iva_hwmod = {
 	},
 	.slaves		= omap44xx_smartreflex_iva_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_iva_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* smartreflex_mpu */
@@ -3909,7 +3909,7 @@ static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod = {
 	},
 	.slaves		= omap44xx_smartreflex_mpu_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_mpu_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -3970,7 +3970,7 @@ static struct omap_hwmod omap44xx_spinlock_hwmod = {
 	},
 	.slaves		= omap44xx_spinlock_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_spinlock_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -4053,7 +4053,7 @@ static struct omap_hwmod omap44xx_timer1_hwmod = {
 	},
 	.slaves		= omap44xx_timer1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer1_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* timer2 */
@@ -4098,7 +4098,7 @@ static struct omap_hwmod omap44xx_timer2_hwmod = {
 	},
 	.slaves		= omap44xx_timer2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer2_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* timer3 */
@@ -4143,7 +4143,7 @@ static struct omap_hwmod omap44xx_timer3_hwmod = {
 	},
 	.slaves		= omap44xx_timer3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer3_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* timer4 */
@@ -4188,7 +4188,7 @@ static struct omap_hwmod omap44xx_timer4_hwmod = {
 	},
 	.slaves		= omap44xx_timer4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer4_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* timer5 */
@@ -4252,7 +4252,7 @@ static struct omap_hwmod omap44xx_timer5_hwmod = {
 	},
 	.slaves		= omap44xx_timer5_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer5_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* timer6 */
@@ -4316,7 +4316,7 @@ static struct omap_hwmod omap44xx_timer6_hwmod = {
 	},
 	.slaves		= omap44xx_timer6_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer6_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* timer7 */
@@ -4380,7 +4380,7 @@ static struct omap_hwmod omap44xx_timer7_hwmod = {
 	},
 	.slaves		= omap44xx_timer7_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer7_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* timer8 */
@@ -4444,7 +4444,7 @@ static struct omap_hwmod omap44xx_timer8_hwmod = {
 	},
 	.slaves		= omap44xx_timer8_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer8_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* timer9 */
@@ -4489,7 +4489,7 @@ static struct omap_hwmod omap44xx_timer9_hwmod = {
 	},
 	.slaves		= omap44xx_timer9_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer9_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* timer10 */
@@ -4534,7 +4534,7 @@ static struct omap_hwmod omap44xx_timer10_hwmod = {
 	},
 	.slaves		= omap44xx_timer10_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer10_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* timer11 */
@@ -4579,7 +4579,7 @@ static struct omap_hwmod omap44xx_timer11_hwmod = {
 	},
 	.slaves		= omap44xx_timer11_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer11_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -4653,7 +4653,7 @@ static struct omap_hwmod omap44xx_uart1_hwmod = {
 	},
 	.slaves		= omap44xx_uart1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_uart1_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* uart2 */
@@ -4705,7 +4705,7 @@ static struct omap_hwmod omap44xx_uart2_hwmod = {
 	},
 	.slaves		= omap44xx_uart2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_uart2_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* uart3 */
@@ -4758,7 +4758,7 @@ static struct omap_hwmod omap44xx_uart3_hwmod = {
 	},
 	.slaves		= omap44xx_uart3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_uart3_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* uart4 */
@@ -4810,7 +4810,7 @@ static struct omap_hwmod omap44xx_uart4_hwmod = {
 	},
 	.slaves		= omap44xx_uart4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_uart4_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -4892,7 +4892,7 @@ static struct omap_hwmod omap44xx_usb_otg_hs_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_usb_otg_hs_slaves),
 	.masters	= omap44xx_usb_otg_hs_masters,
 	.masters_cnt	= ARRAY_SIZE(omap44xx_usb_otg_hs_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /*
@@ -4960,7 +4960,7 @@ static struct omap_hwmod omap44xx_wd_timer2_hwmod = {
 	},
 	.slaves		= omap44xx_wd_timer2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_wd_timer2_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 /* wd_timer3 */
@@ -5024,7 +5024,7 @@ static struct omap_hwmod omap44xx_wd_timer3_hwmod = {
 	},
 	.slaves		= omap44xx_wd_timer3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_wd_timer3_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };
 
 static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 8198bb6..96850a6 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -447,6 +447,8 @@ IS_OMAP_TYPE(3517, 0x3517)
 					 CHIP_IS_OMAP4430ES2_1 |	\
 					 CHIP_IS_OMAP4430ES2_2)
 
+#define CHIP_IS_OMAP44XX		(CHIP_IS_OMAP4430)
+
 /*
  * "GE" here represents "greater than or equal to" in terms of ES
  * levels.  So CHIP_GE_OMAP3430ES2 is intended to match all OMAP3430
-- 
1.7.0.4

