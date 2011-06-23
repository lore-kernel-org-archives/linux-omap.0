From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 15/16] OMAP4: hwmod data: Fix typo and alignement
Date: Thu, 23 Jun 2011 19:43:44 +0200
Message-ID: <1308851025-26313-16-git-send-email-b-cousson@ti.com>
References: <1308851025-26313-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60165 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934021Ab1FWRoe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 13:44:34 -0400
In-Reply-To: <1308851025-26313-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, rnayak@ti.com
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Fix a typo in the mailbox description comment.

Fix .prcm alignement and usb_otg_hs class and hwmod structures.

Add a couple of more potential hwmods in the comment.
Remove hsi, since it is already included in the data.

Remove one blank line.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   49 ++++++++++++++-------------
 1 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 199e689..1ba676b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -632,7 +632,9 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
  *  gpmc
  *  gpu
  *  hdq1w
- *  hsi
+ *  mcasp
+ *  mpu_c0
+ *  mpu_c1
  *  ocmc_ram
  *  ocp2scp_usb_phy
  *  ocp_wp_noc
@@ -739,7 +741,7 @@ static struct omap_hwmod omap44xx_aess_hwmod = {
 	.sdma_reqs	= omap44xx_aess_sdma_reqs,
 	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_aess_sdma_reqs),
 	.main_clk	= "aess_fck",
-	.prcm		= {
+	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM1_ABE_AESS_CLKCTRL,
 		},
@@ -768,7 +770,7 @@ static struct omap_hwmod_opt_clk bandgap_opt_clks[] = {
 static struct omap_hwmod omap44xx_bandgap_hwmod = {
 	.name		= "bandgap",
 	.class		= &omap44xx_bandgap_hwmod_class,
-	.prcm		= {
+	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_WKUP_BANDGAP_CLKCTRL,
 		},
@@ -827,7 +829,7 @@ static struct omap_hwmod omap44xx_counter_32k_hwmod = {
 	.class		= &omap44xx_counter_hwmod_class,
 	.flags		= HWMOD_SWSUP_SIDLE,
 	.main_clk	= "sys_32k_ck",
-	.prcm		= {
+	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_WKUP_SYNCTIMER_CLKCTRL,
 		},
@@ -1003,7 +1005,7 @@ static struct omap_hwmod omap44xx_dmic_hwmod = {
 	.sdma_reqs	= omap44xx_dmic_sdma_reqs,
 	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_dmic_sdma_reqs),
 	.main_clk	= "dmic_fck",
-	.prcm		= {
+	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM1_ABE_DMIC_CLKCTRL,
 		},
@@ -2093,7 +2095,7 @@ static struct omap_hwmod omap44xx_hsi_hwmod = {
 	.mpu_irqs	= omap44xx_hsi_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_hsi_irqs),
 	.main_clk	= "hsi_fck",
-	.prcm		= {
+	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_L3INIT_HSI_CLKCTRL,
 		},
@@ -2389,7 +2391,7 @@ static struct omap_hwmod omap44xx_ipu_c0_hwmod = {
 	.flags		= HWMOD_INIT_NO_RESET,
 	.rst_lines	= omap44xx_ipu_c0_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_ipu_c0_resets),
-	.prcm		= {
+	.prcm = {
 		.omap4 = {
 			.rstctrl_reg = OMAP4430_RM_DUCATI_RSTCTRL,
 		},
@@ -2404,7 +2406,7 @@ static struct omap_hwmod omap44xx_ipu_c1_hwmod = {
 	.flags		= HWMOD_INIT_NO_RESET,
 	.rst_lines	= omap44xx_ipu_c1_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_ipu_c1_resets),
-	.prcm		= {
+	.prcm = {
 		.omap4 = {
 			.rstctrl_reg = OMAP4430_RM_DUCATI_RSTCTRL,
 		},
@@ -2420,7 +2422,7 @@ static struct omap_hwmod omap44xx_ipu_hwmod = {
 	.rst_lines	= omap44xx_ipu_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_ipu_resets),
 	.main_clk	= "ipu_fck",
-	.prcm		= {
+	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_DUCATI_DUCATI_CLKCTRL,
 			.rstctrl_reg = OMAP4430_RM_DUCATI_RSTCTRL,
@@ -2506,7 +2508,7 @@ static struct omap_hwmod omap44xx_iss_hwmod = {
 	.sdma_reqs	= omap44xx_iss_sdma_reqs,
 	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_iss_sdma_reqs),
 	.main_clk	= "iss_fck",
-	.prcm		= {
+	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_CAM_ISS_CLKCTRL,
 		},
@@ -2686,7 +2688,7 @@ static struct omap_hwmod omap44xx_kbd_hwmod = {
 	.mpu_irqs	= omap44xx_kbd_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_kbd_irqs),
 	.main_clk	= "kbd_fck",
-	.prcm		= {
+	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_WKUP_KEYBOARD_CLKCTRL,
 		},
@@ -2698,8 +2700,8 @@ static struct omap_hwmod omap44xx_kbd_hwmod = {
 
 /*
  * 'mailbox' class
- * mailbox module allowing communication between the on-chip processors using a
- * queued mailbox-interrupt mechanism.
+ * mailbox module allowing communication between the on-chip processors
+ * useusing a queued mailbox-interrupt mechanism.
  */
 
 static struct omap_hwmod_class_sysconfig omap44xx_mailbox_sysc = {
@@ -2750,7 +2752,7 @@ static struct omap_hwmod omap44xx_mailbox_hwmod = {
 	.class		= &omap44xx_mailbox_hwmod_class,
 	.mpu_irqs	= omap44xx_mailbox_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mailbox_irqs),
-	.prcm		= {
+	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_L4CFG_MAILBOX_CLKCTRL,
 		},
@@ -3132,7 +3134,7 @@ static struct omap_hwmod omap44xx_mcpdm_hwmod = {
 	.sdma_reqs	= omap44xx_mcpdm_sdma_reqs,
 	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mcpdm_sdma_reqs),
 	.main_clk	= "mcpdm_fck",
-	.prcm		= {
+	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM1_ABE_PDM_CLKCTRL,
 		},
@@ -3429,7 +3431,6 @@ static struct omap_hwmod_class omap44xx_mmc_hwmod_class = {
 };
 
 /* mmc1 */
-
 static struct omap_hwmod_irq_info omap44xx_mmc1_irqs[] = {
 	{ .irq = 83 + OMAP44XX_IRQ_GIC_START },
 };
@@ -3480,7 +3481,7 @@ static struct omap_hwmod omap44xx_mmc1_hwmod = {
 	.sdma_reqs	= omap44xx_mmc1_sdma_reqs,
 	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mmc1_sdma_reqs),
 	.main_clk	= "mmc1_fck",
-	.prcm		= {
+	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_L3INIT_MMC1_CLKCTRL,
 		},
@@ -3539,7 +3540,7 @@ static struct omap_hwmod omap44xx_mmc2_hwmod = {
 	.sdma_reqs	= omap44xx_mmc2_sdma_reqs,
 	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mmc2_sdma_reqs),
 	.main_clk	= "mmc2_fck",
-	.prcm		= {
+	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_L3INIT_MMC2_CLKCTRL,
 		},
@@ -3593,7 +3594,7 @@ static struct omap_hwmod omap44xx_mmc3_hwmod = {
 	.sdma_reqs	= omap44xx_mmc3_sdma_reqs,
 	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mmc3_sdma_reqs),
 	.main_clk	= "mmc3_fck",
-	.prcm		= {
+	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_MMCSD3_CLKCTRL,
 		},
@@ -3645,7 +3646,7 @@ static struct omap_hwmod omap44xx_mmc4_hwmod = {
 	.sdma_reqs	= omap44xx_mmc4_sdma_reqs,
 	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mmc4_sdma_reqs),
 	.main_clk	= "mmc4_fck",
-	.prcm		= {
+	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_MMCSD4_CLKCTRL,
 		},
@@ -3697,7 +3698,7 @@ static struct omap_hwmod omap44xx_mmc5_hwmod = {
 	.sdma_reqs	= omap44xx_mmc5_sdma_reqs,
 	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mmc5_sdma_reqs),
 	.main_clk	= "mmc5_fck",
-	.prcm		= {
+	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_MMCSD5_CLKCTRL,
 		},
@@ -4831,8 +4832,8 @@ static struct omap_hwmod_class_sysconfig omap44xx_usb_otg_hs_sysc = {
 };
 
 static struct omap_hwmod_class omap44xx_usb_otg_hs_hwmod_class = {
-	.name = "usb_otg_hs",
-	.sysc = &omap44xx_usb_otg_hs_sysc,
+	.name	= "usb_otg_hs",
+	.sysc	= &omap44xx_usb_otg_hs_sysc,
 };
 
 /* usb_otg_hs */
@@ -4886,7 +4887,7 @@ static struct omap_hwmod omap44xx_usb_otg_hs_hwmod = {
 		},
 	},
 	.opt_clks	= usb_otg_hs_opt_clks,
-	.opt_clks_cnt = ARRAY_SIZE(usb_otg_hs_opt_clks),
+	.opt_clks_cnt	= ARRAY_SIZE(usb_otg_hs_opt_clks),
 	.slaves		= omap44xx_usb_otg_hs_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_usb_otg_hs_slaves),
 	.masters	= omap44xx_usb_otg_hs_masters,
-- 
1.7.0.4

