From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 10/16] OMAP4: clock data: Remove UNIPRO clock nodes
Date: Thu, 23 Jun 2011 19:43:39 +0200
Message-ID: <1308851025-26313-11-git-send-email-b-cousson@ti.com>
References: <1308851025-26313-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60157 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934011Ab1FWRo3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 13:44:29 -0400
In-Reply-To: <1308851025-26313-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, rnayak@ti.com
Cc: linux-omap@vger.kernel.org, Jon Hunter <jon-hunter@ti.com>, Benoit Cousson <b-cousson@ti.com>

From: Jon Hunter <jon-hunter@ti.com>

UNIPRO was removed from OMAP4 devices from ES2.0 onwards.
Since this IP was anyway non-functional and not supported,
it is best to remove it completely.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
[b-cousson@ti.com: Update the changelog]
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock44xx_data.c   |   60 --------------------------------
 arch/arm/mach-omap2/cm-regbits-44xx.h  |   29 ++++++---------
 arch/arm/mach-omap2/cm2_44xx.h         |    2 -
 arch/arm/mach-omap2/prm-regbits-44xx.h |   12 +-----
 arch/arm/mach-omap2/prm44xx.h          |    4 --
 5 files changed, 14 insertions(+), 93 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index ad3e1cf..b6791cd 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -935,63 +935,6 @@ static struct clk dpll_per_m7x2_ck = {
 	.set_rate	= &omap2_clksel_set_rate,
 };
 
-/* DPLL_UNIPRO */
-static struct dpll_data dpll_unipro_dd = {
-	.mult_div1_reg	= OMAP4430_CM_CLKSEL_DPLL_UNIPRO,
-	.clk_bypass	= &sys_clkin_ck,
-	.clk_ref	= &sys_clkin_ck,
-	.control_reg	= OMAP4430_CM_CLKMODE_DPLL_UNIPRO,
-	.modes		= (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
-	.autoidle_reg	= OMAP4430_CM_AUTOIDLE_DPLL_UNIPRO,
-	.idlest_reg	= OMAP4430_CM_IDLEST_DPLL_UNIPRO,
-	.mult_mask	= OMAP4430_DPLL_MULT_MASK,
-	.div1_mask	= OMAP4430_DPLL_DIV_MASK,
-	.enable_mask	= OMAP4430_DPLL_EN_MASK,
-	.autoidle_mask	= OMAP4430_AUTO_DPLL_MODE_MASK,
-	.idlest_mask	= OMAP4430_ST_DPLL_CLK_MASK,
-	.max_multiplier	= 2047,
-	.max_divider	= 128,
-	.min_divider	= 1,
-};
-
-
-static struct clk dpll_unipro_ck = {
-	.name		= "dpll_unipro_ck",
-	.parent		= &sys_clkin_ck,
-	.dpll_data	= &dpll_unipro_dd,
-	.init		= &omap2_init_dpll_parent,
-	.ops		= &clkops_omap3_noncore_dpll_ops,
-	.recalc		= &omap3_dpll_recalc,
-	.round_rate	= &omap2_dpll_round_rate,
-	.set_rate	= &omap3_noncore_dpll_set_rate,
-};
-
-static struct clk dpll_unipro_x2_ck = {
-	.name		= "dpll_unipro_x2_ck",
-	.parent		= &dpll_unipro_ck,
-	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_UNIPRO,
-	.flags		= CLOCK_CLKOUTX2,
-	.ops		= &clkops_omap4_dpllmx_ops,
-	.recalc		= &omap3_clkoutx2_recalc,
-};
-
-static const struct clksel dpll_unipro_m2x2_div[] = {
-	{ .parent = &dpll_unipro_x2_ck, .rates = div31_1to31_rates },
-	{ .parent = NULL },
-};
-
-static struct clk dpll_unipro_m2x2_ck = {
-	.name		= "dpll_unipro_m2x2_ck",
-	.parent		= &dpll_unipro_x2_ck,
-	.clksel		= dpll_unipro_m2x2_div,
-	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_UNIPRO,
-	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_MASK,
-	.ops		= &clkops_omap4_dpllmx_ops,
-	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate,
-};
-
 static struct clk usb_hs_clk_div_ck = {
 	.name		= "usb_hs_clk_div_ck",
 	.parent		= &dpll_abe_m3x2_ck,
@@ -3057,9 +3000,6 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"dpll_per_m5x2_ck",		&dpll_per_m5x2_ck,	CK_44XX),
 	CLK(NULL,	"dpll_per_m6x2_ck",		&dpll_per_m6x2_ck,	CK_44XX),
 	CLK(NULL,	"dpll_per_m7x2_ck",		&dpll_per_m7x2_ck,	CK_44XX),
-	CLK(NULL,	"dpll_unipro_ck",		&dpll_unipro_ck,	CK_44XX),
-	CLK(NULL,	"dpll_unipro_x2_ck",		&dpll_unipro_x2_ck,	CK_44XX),
-	CLK(NULL,	"dpll_unipro_m2x2_ck",		&dpll_unipro_m2x2_ck,	CK_44XX),
 	CLK(NULL,	"usb_hs_clk_div_ck",		&usb_hs_clk_div_ck,	CK_44XX),
 	CLK(NULL,	"dpll_usb_ck",			&dpll_usb_ck,	CK_44XX),
 	CLK(NULL,	"dpll_usb_clkdcoldo_ck",	&dpll_usb_clkdcoldo_ck,	CK_44XX),
diff --git a/arch/arm/mach-omap2/cm-regbits-44xx.h b/arch/arm/mach-omap2/cm-regbits-44xx.h
index 094758d..733f93e 100644
--- a/arch/arm/mach-omap2/cm-regbits-44xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-44xx.h
@@ -862,10 +862,10 @@
  * CM_IVAHD_SL2_CLKCTRL, CM_L3INIT_CCPTX_CLKCTRL, CM_L3INIT_EMAC_CLKCTRL,
  * CM_L3INIT_HSI_CLKCTRL, CM_L3INIT_MMC1_CLKCTRL, CM_L3INIT_MMC2_CLKCTRL,
  * CM_L3INIT_P1500_CLKCTRL, CM_L3INIT_PCIESS_CLKCTRL, CM_L3INIT_SATA_CLKCTRL,
- * CM_L3INIT_TPPSS_CLKCTRL, CM_L3INIT_UNIPRO1_CLKCTRL,
- * CM_L3INIT_USBPHYOCP2SCP_CLKCTRL, CM_L3INIT_USB_HOST_CLKCTRL,
- * CM_L3INIT_USB_HOST_FS_CLKCTRL, CM_L3INIT_USB_OTG_CLKCTRL,
- * CM_L3INIT_USB_TLL_CLKCTRL, CM_L3INIT_XHPI_CLKCTRL, CM_L3INSTR_L3_3_CLKCTRL,
+ * CM_L3INIT_TPPSS_CLKCTRL, CM_L3INIT_USBPHYOCP2SCP_CLKCTRL,
+ * CM_L3INIT_USB_HOST_CLKCTRL, CM_L3INIT_USB_HOST_FS_CLKCTRL,
+ * CM_L3INIT_USB_OTG_CLKCTRL, CM_L3INIT_USB_TLL_CLKCTRL,
+ * CM_L3INIT_XHPI_CLKCTRL, CM_L3INSTR_L3_3_CLKCTRL,
  * CM_L3INSTR_L3_INSTR_CLKCTRL, CM_L3INSTR_OCP_WP1_CLKCTRL,
  * CM_L3_1_L3_1_CLKCTRL, CM_L3_2_GPMC_CLKCTRL, CM_L3_2_L3_2_CLKCTRL,
  * CM_L3_2_OCMC_RAM_CLKCTRL, CM_L4CFG_HW_SEM_CLKCTRL, CM_L4CFG_L4_CFG_CLKCTRL,
@@ -1057,10 +1057,10 @@
  * CM_IVAHD_SL2_CLKCTRL, CM_L3INIT_CCPTX_CLKCTRL, CM_L3INIT_EMAC_CLKCTRL,
  * CM_L3INIT_HSI_CLKCTRL, CM_L3INIT_MMC1_CLKCTRL, CM_L3INIT_MMC2_CLKCTRL,
  * CM_L3INIT_P1500_CLKCTRL, CM_L3INIT_PCIESS_CLKCTRL, CM_L3INIT_SATA_CLKCTRL,
- * CM_L3INIT_TPPSS_CLKCTRL, CM_L3INIT_UNIPRO1_CLKCTRL,
- * CM_L3INIT_USBPHYOCP2SCP_CLKCTRL, CM_L3INIT_USB_HOST_CLKCTRL,
- * CM_L3INIT_USB_HOST_FS_CLKCTRL, CM_L3INIT_USB_OTG_CLKCTRL,
- * CM_L3INIT_USB_TLL_CLKCTRL, CM_L3INIT_XHPI_CLKCTRL, CM_L3INSTR_L3_3_CLKCTRL,
+ * CM_L3INIT_TPPSS_CLKCTRL, CM_L3INIT_USBPHYOCP2SCP_CLKCTRL,
+ * CM_L3INIT_USB_HOST_CLKCTRL, CM_L3INIT_USB_HOST_FS_CLKCTRL,
+ * CM_L3INIT_USB_OTG_CLKCTRL, CM_L3INIT_USB_TLL_CLKCTRL,
+ * CM_L3INIT_XHPI_CLKCTRL, CM_L3INSTR_L3_3_CLKCTRL,
  * CM_L3INSTR_L3_INSTR_CLKCTRL, CM_L3INSTR_OCP_WP1_CLKCTRL,
  * CM_L3_1_L3_1_CLKCTRL, CM_L3_2_GPMC_CLKCTRL, CM_L3_2_L3_2_CLKCTRL,
  * CM_L3_2_OCMC_RAM_CLKCTRL, CM_L4CFG_HW_SEM_CLKCTRL, CM_L4CFG_L4_CFG_CLKCTRL,
@@ -1187,10 +1187,6 @@
 #define OMAP4430_OPTFCLKEN_TV_CLK_SHIFT				11
 #define OMAP4430_OPTFCLKEN_TV_CLK_MASK				(1 << 11)
 
-/* Used by CM_L3INIT_UNIPRO1_CLKCTRL */
-#define OMAP4430_OPTFCLKEN_TXPHYCLK_SHIFT			8
-#define OMAP4430_OPTFCLKEN_TXPHYCLK_MASK			(1 << 8)
-
 /* Used by CM_L3INIT_USB_TLL_CLKCTRL */
 #define OMAP4430_OPTFCLKEN_USB_CH0_CLK_SHIFT			8
 #define OMAP4430_OPTFCLKEN_USB_CH0_CLK_MASK			(1 << 8)
@@ -1298,11 +1294,10 @@
  * CM_IVAHD_IVAHD_CLKCTRL, CM_L3INIT_CCPTX_CLKCTRL, CM_L3INIT_EMAC_CLKCTRL,
  * CM_L3INIT_HSI_CLKCTRL, CM_L3INIT_MMC1_CLKCTRL, CM_L3INIT_MMC2_CLKCTRL,
  * CM_L3INIT_P1500_CLKCTRL, CM_L3INIT_PCIESS_CLKCTRL, CM_L3INIT_SATA_CLKCTRL,
- * CM_L3INIT_TPPSS_CLKCTRL, CM_L3INIT_UNIPRO1_CLKCTRL,
- * CM_L3INIT_USB_HOST_CLKCTRL, CM_L3INIT_USB_HOST_FS_CLKCTRL,
- * CM_L3INIT_USB_OTG_CLKCTRL, CM_L3INIT_XHPI_CLKCTRL,
- * CM_L4SEC_CRYPTODMA_CLKCTRL, CM_MPU_MPU_CLKCTRL, CM_SDMA_SDMA_CLKCTRL,
- * CM_TESLA_TESLA_CLKCTRL
+ * CM_L3INIT_TPPSS_CLKCTRL, CM_L3INIT_USB_HOST_CLKCTRL,
+ * CM_L3INIT_USB_HOST_FS_CLKCTRL, CM_L3INIT_USB_OTG_CLKCTRL,
+ * CM_L3INIT_XHPI_CLKCTRL, CM_L4SEC_CRYPTODMA_CLKCTRL, CM_MPU_MPU_CLKCTRL,
+ * CM_SDMA_SDMA_CLKCTRL, CM_TESLA_TESLA_CLKCTRL
  */
 #define OMAP4430_STBYST_SHIFT					18
 #define OMAP4430_STBYST_MASK					(1 << 18)
diff --git a/arch/arm/mach-omap2/cm2_44xx.h b/arch/arm/mach-omap2/cm2_44xx.h
index d3db16b..4130c73 100644
--- a/arch/arm/mach-omap2/cm2_44xx.h
+++ b/arch/arm/mach-omap2/cm2_44xx.h
@@ -310,8 +310,6 @@
 #define OMAP4430_CM_L3INIT_MMC2_CLKCTRL			OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L3INIT_INST, 0x0030)
 #define OMAP4_CM_L3INIT_HSI_CLKCTRL_OFFSET		0x0038
 #define OMAP4430_CM_L3INIT_HSI_CLKCTRL			OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L3INIT_INST, 0x0038)
-#define OMAP4_CM_L3INIT_UNIPRO1_CLKCTRL_OFFSET		0x0040
-#define OMAP4430_CM_L3INIT_UNIPRO1_CLKCTRL		OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L3INIT_INST, 0x0040)
 #define OMAP4_CM_L3INIT_USB_HOST_CLKCTRL_OFFSET		0x0058
 #define OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL		OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L3INIT_INST, 0x0058)
 #define OMAP4_CM_L3INIT_USB_OTG_CLKCTRL_OFFSET		0x0060
diff --git a/arch/arm/mach-omap2/prm-regbits-44xx.h b/arch/arm/mach-omap2/prm-regbits-44xx.h
index 60fbab9..052d424 100644
--- a/arch/arm/mach-omap2/prm-regbits-44xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-44xx.h
@@ -533,7 +533,7 @@
  * RM_DUCATI_DUCATI_CONTEXT, RM_EMU_DEBUGSS_CONTEXT, RM_GFX_GFX_CONTEXT,
  * RM_IVAHD_IVAHD_CONTEXT, RM_IVAHD_SL2_CONTEXT, RM_L3INIT_CCPTX_CONTEXT,
  * RM_L3INIT_EMAC_CONTEXT, RM_L3INIT_P1500_CONTEXT, RM_L3INIT_PCIESS_CONTEXT,
- * RM_L3INIT_SATA_CONTEXT, RM_L3INIT_TPPSS_CONTEXT, RM_L3INIT_UNIPRO1_CONTEXT,
+ * RM_L3INIT_SATA_CONTEXT, RM_L3INIT_TPPSS_CONTEXT,
  * RM_L3INIT_USBPHYOCP2SCP_CONTEXT, RM_L3INIT_XHPI_CONTEXT,
  * RM_L3INSTR_L3_3_CONTEXT, RM_L3INSTR_L3_INSTR_CONTEXT,
  * RM_L3INSTR_OCP_WP1_CONTEXT, RM_L3_1_L3_1_CONTEXT, RM_L3_2_L3_2_CONTEXT,
@@ -635,7 +635,7 @@
  * Used by RM_L3INIT_CCPTX_CONTEXT, RM_L3INIT_EMAC_CONTEXT,
  * RM_L3INIT_HSI_CONTEXT, RM_L3INIT_MMC1_CONTEXT, RM_L3INIT_MMC2_CONTEXT,
  * RM_L3INIT_PCIESS_CONTEXT, RM_L3INIT_SATA_CONTEXT, RM_L3INIT_TPPSS_CONTEXT,
- * RM_L3INIT_UNIPRO1_CONTEXT, RM_L3INIT_USB_OTG_CONTEXT, RM_L3INIT_XHPI_CONTEXT
+ * RM_L3INIT_USB_OTG_CONTEXT, RM_L3INIT_XHPI_CONTEXT
  */
 #define OMAP4430_LOSTMEM_L3INIT_BANK1_SHIFT				8
 #define OMAP4430_LOSTMEM_L3INIT_BANK1_MASK				(1 << 8)
@@ -2185,14 +2185,6 @@
 #define OMAP4430_WKUPDEP_UART4_SDMA_SHIFT				3
 #define OMAP4430_WKUPDEP_UART4_SDMA_MASK				(1 << 3)
 
-/* Used by PM_L3INIT_UNIPRO1_WKDEP */
-#define OMAP4430_WKUPDEP_UNIPRO1_DUCATI_SHIFT				1
-#define OMAP4430_WKUPDEP_UNIPRO1_DUCATI_MASK				(1 << 1)
-
-/* Used by PM_L3INIT_UNIPRO1_WKDEP */
-#define OMAP4430_WKUPDEP_UNIPRO1_MPU_SHIFT				0
-#define OMAP4430_WKUPDEP_UNIPRO1_MPU_MASK				(1 << 0)
-
 /* Used by PM_L3INIT_USB_HOST_WKDEP */
 #define OMAP4430_WKUPDEP_USB_HOST_DUCATI_SHIFT				1
 #define OMAP4430_WKUPDEP_USB_HOST_DUCATI_MASK				(1 << 1)
diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm44xx.h
index 93abfb9..abed936 100644
--- a/arch/arm/mach-omap2/prm44xx.h
+++ b/arch/arm/mach-omap2/prm44xx.h
@@ -315,10 +315,6 @@
 #define OMAP4430_PM_L3INIT_HSI_WKDEP			OMAP44XX_PRM_REGADDR(OMAP4430_PRM_L3INIT_INST, 0x0038)
 #define OMAP4_RM_L3INIT_HSI_CONTEXT_OFFSET		0x003c
 #define OMAP4430_RM_L3INIT_HSI_CONTEXT			OMAP44XX_PRM_REGADDR(OMAP4430_PRM_L3INIT_INST, 0x003c)
-#define OMAP4_PM_L3INIT_UNIPRO1_WKDEP_OFFSET		0x0040
-#define OMAP4430_PM_L3INIT_UNIPRO1_WKDEP		OMAP44XX_PRM_REGADDR(OMAP4430_PRM_L3INIT_INST, 0x0040)
-#define OMAP4_RM_L3INIT_UNIPRO1_CONTEXT_OFFSET		0x0044
-#define OMAP4430_RM_L3INIT_UNIPRO1_CONTEXT		OMAP44XX_PRM_REGADDR(OMAP4430_PRM_L3INIT_INST, 0x0044)
 #define OMAP4_PM_L3INIT_USB_HOST_WKDEP_OFFSET		0x0058
 #define OMAP4430_PM_L3INIT_USB_HOST_WKDEP		OMAP44XX_PRM_REGADDR(OMAP4430_PRM_L3INIT_INST, 0x0058)
 #define OMAP4_RM_L3INIT_USB_HOST_CONTEXT_OFFSET		0x005c
-- 
1.7.0.4

