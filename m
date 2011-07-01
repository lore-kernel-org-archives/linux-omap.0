From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v3 11/13] OMAP4: hwmod data: Add modulemode entry in omap_hwmod structure
Date: Fri, 1 Jul 2011 23:09:16 +0200
Message-ID: <1309554558-19819-12-git-send-email-b-cousson@ti.com>
References: <1309554558-19819-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58902 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757036Ab1GAVJx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 17:09:53 -0400
In-Reply-To: <1309554558-19819-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

Add a new field to provide the mode supported by the module.
The mode will control the way mandatory clocks are managed by the PRCM.

  0 : Module is temporarily disabled by SW. OCP access to module are stalled.
      Can be used to change timing parameter of GPMC module.
  1 : Module is managed automatically by HW according to clock domain
      transition. A clock domain sleep transition put module into idle.
      A wakeup domain transition put it back into function.
      If CLKTRCTRL=3, any OCP access to module is always granted.
      Module clocks may be gated according to the clock domain state.
  2 : Module is explicitly enabled. Interface clock (if not used for
      functions) may be gated according to the clock domain state.
      Functional clocks are guarantied to stay present. As long as
      in this configuration, power domain sleep transition cannot happen.

Some modules will have a modulemode initialized at 1 (HWCTRL) by default.
This is the case for interconnect and simple module like GPIO, WDT, MAILBOX.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |   55 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    6 +++
 2 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 2585ef5..160c77a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -229,6 +229,7 @@ static struct omap_hwmod omap44xx_l3_instr_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3INSTR_L3_INSTR_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L3INSTR_L3_INSTR_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.slaves		= omap44xx_l3_instr_slaves,
@@ -488,6 +489,7 @@ static struct omap_hwmod omap44xx_l3_main_3_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3INSTR_L3_3_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L3INSTR_L3_3_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.slaves		= omap44xx_l3_main_3_slaves,
@@ -817,6 +819,7 @@ static struct omap_hwmod omap44xx_aess_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_AESS_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ABE_AESS_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_aess_slaves,
@@ -1088,6 +1091,7 @@ static struct omap_hwmod omap44xx_dmic_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_DMIC_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ABE_DMIC_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_dmic_slaves,
@@ -1174,6 +1178,7 @@ static struct omap_hwmod omap44xx_dsp_hwmod = {
 			.clkctrl_offs = OMAP4_CM_TESLA_TESLA_CLKCTRL_OFFSET,
 			.rstctrl_offs = OMAP4_RM_TESLA_RSTCTRL_OFFSET,
 			.context_offs = OMAP4_RM_TESLA_TESLA_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.slaves		= omap44xx_dsp_slaves,
@@ -1898,6 +1903,7 @@ static struct omap_hwmod omap44xx_gpio1_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_WKUP_GPIO1_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_WKUP_GPIO1_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= gpio1_opt_clks,
@@ -1953,6 +1959,7 @@ static struct omap_hwmod omap44xx_gpio2_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_GPIO2_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_GPIO2_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= gpio2_opt_clks,
@@ -2008,6 +2015,7 @@ static struct omap_hwmod omap44xx_gpio3_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_GPIO3_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_GPIO3_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= gpio3_opt_clks,
@@ -2063,6 +2071,7 @@ static struct omap_hwmod omap44xx_gpio4_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_GPIO4_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_GPIO4_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= gpio4_opt_clks,
@@ -2118,6 +2127,7 @@ static struct omap_hwmod omap44xx_gpio5_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_GPIO5_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_GPIO5_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= gpio5_opt_clks,
@@ -2173,6 +2183,7 @@ static struct omap_hwmod omap44xx_gpio6_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_GPIO6_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_GPIO6_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= gpio6_opt_clks,
@@ -2253,6 +2264,7 @@ static struct omap_hwmod omap44xx_hsi_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3INIT_HSI_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L3INIT_HSI_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.slaves		= omap44xx_hsi_slaves,
@@ -2331,6 +2343,7 @@ static struct omap_hwmod omap44xx_i2c1_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_I2C1_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_I2C1_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_i2c1_slaves,
@@ -2386,6 +2399,7 @@ static struct omap_hwmod omap44xx_i2c2_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_I2C2_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_I2C2_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_i2c2_slaves,
@@ -2441,6 +2455,7 @@ static struct omap_hwmod omap44xx_i2c3_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_I2C3_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_I2C3_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_i2c3_slaves,
@@ -2496,6 +2511,7 @@ static struct omap_hwmod omap44xx_i2c4_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_I2C4_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_I2C4_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_i2c4_slaves,
@@ -2593,6 +2609,7 @@ static struct omap_hwmod omap44xx_ipu_hwmod = {
 			.clkctrl_offs = OMAP4_CM_DUCATI_DUCATI_CLKCTRL_OFFSET,
 			.rstctrl_offs = OMAP4_RM_DUCATI_RSTCTRL_OFFSET,
 			.context_offs = OMAP4_RM_DUCATI_DUCATI_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.slaves		= omap44xx_ipu_slaves,
@@ -2680,6 +2697,7 @@ static struct omap_hwmod omap44xx_iss_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_CAM_ISS_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_CAM_ISS_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.opt_clks	= iss_opt_clks,
@@ -2795,6 +2813,7 @@ static struct omap_hwmod omap44xx_iva_hwmod = {
 			.clkctrl_offs = OMAP4_CM_IVAHD_IVAHD_CLKCTRL_OFFSET,
 			.rstctrl_offs = OMAP4_RM_IVAHD_RSTCTRL_OFFSET,
 			.context_offs = OMAP4_RM_IVAHD_IVAHD_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.slaves		= omap44xx_iva_slaves,
@@ -2866,6 +2885,7 @@ static struct omap_hwmod omap44xx_kbd_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_WKUP_KEYBOARD_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_WKUP_KEYBOARD_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_kbd_slaves,
@@ -3026,6 +3046,7 @@ static struct omap_hwmod omap44xx_mcbsp1_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_MCBSP1_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ABE_MCBSP1_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_mcbsp1_slaves,
@@ -3101,6 +3122,7 @@ static struct omap_hwmod omap44xx_mcbsp2_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_MCBSP2_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ABE_MCBSP2_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_mcbsp2_slaves,
@@ -3176,6 +3198,7 @@ static struct omap_hwmod omap44xx_mcbsp3_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_MCBSP3_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ABE_MCBSP3_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_mcbsp3_slaves,
@@ -3230,6 +3253,7 @@ static struct omap_hwmod omap44xx_mcbsp4_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_MCBSP4_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_MCBSP4_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_mcbsp4_slaves,
@@ -3324,6 +3348,7 @@ static struct omap_hwmod omap44xx_mcpdm_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_PDM_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ABE_PDM_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_mcpdm_slaves,
@@ -3411,6 +3436,7 @@ static struct omap_hwmod omap44xx_mcspi1_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_MCSPI1_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_MCSPI1_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &mcspi1_dev_attr,
@@ -3473,6 +3499,7 @@ static struct omap_hwmod omap44xx_mcspi2_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_MCSPI2_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_MCSPI2_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &mcspi2_dev_attr,
@@ -3535,6 +3562,7 @@ static struct omap_hwmod omap44xx_mcspi3_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_MCSPI3_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_MCSPI3_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &mcspi3_dev_attr,
@@ -3595,6 +3623,7 @@ static struct omap_hwmod omap44xx_mcspi4_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_MCSPI4_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_MCSPI4_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &mcspi4_dev_attr,
@@ -3681,6 +3710,7 @@ static struct omap_hwmod omap44xx_mmc1_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3INIT_MMC1_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L3INIT_MMC1_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &mmc1_dev_attr,
@@ -3742,6 +3772,7 @@ static struct omap_hwmod omap44xx_mmc2_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3INIT_MMC2_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L3INIT_MMC2_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_mmc2_slaves,
@@ -3798,6 +3829,7 @@ static struct omap_hwmod omap44xx_mmc3_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_MMCSD3_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_MMCSD3_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_mmc3_slaves,
@@ -3852,6 +3884,7 @@ static struct omap_hwmod omap44xx_mmc4_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_MMCSD4_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_MMCSD4_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_mmc4_slaves,
@@ -3906,6 +3939,7 @@ static struct omap_hwmod omap44xx_mmc5_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_MMCSD5_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_MMCSD5_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_mmc5_slaves,
@@ -4022,6 +4056,7 @@ static struct omap_hwmod omap44xx_smartreflex_core_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_ALWON_SR_CORE_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ALWON_SR_CORE_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_smartreflex_core_slaves,
@@ -4070,6 +4105,7 @@ static struct omap_hwmod omap44xx_smartreflex_iva_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_ALWON_SR_IVA_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ALWON_SR_IVA_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_smartreflex_iva_slaves,
@@ -4118,6 +4154,7 @@ static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_ALWON_SR_MPU_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ALWON_SR_MPU_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_smartreflex_mpu_slaves,
@@ -4266,6 +4303,7 @@ static struct omap_hwmod omap44xx_timer1_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_WKUP_TIMER1_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_WKUP_TIMER1_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_timer1_slaves,
@@ -4313,6 +4351,7 @@ static struct omap_hwmod omap44xx_timer2_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER2_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_DMTIMER2_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_timer2_slaves,
@@ -4360,6 +4399,7 @@ static struct omap_hwmod omap44xx_timer3_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER3_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_DMTIMER3_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_timer3_slaves,
@@ -4407,6 +4447,7 @@ static struct omap_hwmod omap44xx_timer4_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER4_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_DMTIMER4_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_timer4_slaves,
@@ -4473,6 +4514,7 @@ static struct omap_hwmod omap44xx_timer5_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_TIMER5_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ABE_TIMER5_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_timer5_slaves,
@@ -4539,6 +4581,7 @@ static struct omap_hwmod omap44xx_timer6_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_TIMER6_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ABE_TIMER6_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_timer6_slaves,
@@ -4605,6 +4648,7 @@ static struct omap_hwmod omap44xx_timer7_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_TIMER7_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ABE_TIMER7_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_timer7_slaves,
@@ -4671,6 +4715,7 @@ static struct omap_hwmod omap44xx_timer8_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_TIMER8_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ABE_TIMER8_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_timer8_slaves,
@@ -4718,6 +4763,7 @@ static struct omap_hwmod omap44xx_timer9_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER9_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_DMTIMER9_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_timer9_slaves,
@@ -4765,6 +4811,7 @@ static struct omap_hwmod omap44xx_timer10_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER10_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_DMTIMER10_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_timer10_slaves,
@@ -4812,6 +4859,7 @@ static struct omap_hwmod omap44xx_timer11_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER11_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_DMTIMER11_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_timer11_slaves,
@@ -4888,6 +4936,7 @@ static struct omap_hwmod omap44xx_uart1_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_UART1_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_UART1_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_uart1_slaves,
@@ -4942,6 +4991,7 @@ static struct omap_hwmod omap44xx_uart2_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_UART2_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_UART2_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_uart2_slaves,
@@ -4997,6 +5047,7 @@ static struct omap_hwmod omap44xx_uart3_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_UART3_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_UART3_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_uart3_slaves,
@@ -5051,6 +5102,7 @@ static struct omap_hwmod omap44xx_uart4_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_UART4_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_UART4_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_uart4_slaves,
@@ -5131,6 +5183,7 @@ static struct omap_hwmod omap44xx_usb_otg_hs_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3INIT_USB_OTG_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L3INIT_USB_OTG_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= usb_otg_hs_opt_clks,
@@ -5205,6 +5258,7 @@ static struct omap_hwmod omap44xx_wd_timer2_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_WKUP_WDT2_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_WKUP_WDT2_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_wd_timer2_slaves,
@@ -5271,6 +5325,7 @@ static struct omap_hwmod omap44xx_wd_timer3_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_WDT3_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ABE_WDT3_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.slaves		= omap44xx_wd_timer3_slaves,
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 40e561e..7df9fa2 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -80,6 +80,11 @@ extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type2;
 #define HWMOD_IDLEMODE_SMART		(1 << 2)
 #define HWMOD_IDLEMODE_SMART_WKUP	(1 << 3)
 
+/* modulemode control type (SW or HW) */
+#define MODULEMODE_HWCTRL		1
+#define MODULEMODE_SWCTRL		2
+
+
 /**
  * struct omap_hwmod_mux_info - hwmod specific mux configuration
  * @pads:              array of omap_device_pad entries
@@ -367,6 +372,7 @@ struct omap_hwmod_omap4_prcm {
 	u16		rstctrl_offs;
 	u16		context_offs;
 	u8		submodule_wkdep_bit;
+	u8		modulemode;
 };
 
 
-- 
1.7.0.4

