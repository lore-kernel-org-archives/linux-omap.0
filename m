From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP2+: Drop unused legacy data for prcm_reg_id and
 module_bit
Date: Wed, 13 Dec 2017 16:46:19 -0800
Message-ID: <20171214004619.29329-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We are now using clock drivers in driver/clk/ti for enabling and disabling
modules and these are all unused.

Let's also remove the related unused defines in cm-regbits-24xx.h and
cm-regbits-34xx.h.

Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/cm-regbits-24xx.h              |  81 -----------
 arch/arm/mach-omap2/cm-regbits-34xx.h              | 162 ---------------------
 arch/arm/mach-omap2/omap_hwmod.h                   |   6 -
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |  14 --
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |  28 ----
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  64 --------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         | 131 -----------------
 7 files changed, 486 deletions(-)

diff --git a/arch/arm/mach-omap2/cm-regbits-24xx.h b/arch/arm/mach-omap2/cm-regbits-24xx.h
--- a/arch/arm/mach-omap2/cm-regbits-24xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-24xx.h
@@ -14,38 +14,8 @@
  * published by the Free Software Foundation.
  */
 
-#define OMAP24XX_EN_CAM_SHIFT				31
-#define OMAP24XX_EN_WDT4_SHIFT				29
-#define OMAP2420_EN_WDT3_SHIFT				28
-#define OMAP24XX_EN_MSPRO_SHIFT				27
-#define OMAP24XX_EN_FAC_SHIFT				25
-#define OMAP2420_EN_EAC_SHIFT				24
-#define OMAP24XX_EN_HDQ_SHIFT				23
-#define OMAP2420_EN_I2C2_SHIFT				20
-#define OMAP2420_EN_I2C1_SHIFT				19
-#define OMAP2430_EN_MCBSP5_SHIFT			5
-#define OMAP2430_EN_MCBSP4_SHIFT			4
-#define OMAP2430_EN_MCBSP3_SHIFT			3
-#define OMAP24XX_EN_SSI_SHIFT				1
-#define OMAP24XX_EN_MPU_WDT_SHIFT			3
-#define OMAP24XX_CLKSEL_MPU_SHIFT			0
-#define OMAP24XX_CLKSEL_MPU_WIDTH			5
 #define OMAP24XX_AUTOSTATE_MPU_MASK			(1 << 0)
-#define OMAP24XX_EN_TV_SHIFT				2
-#define OMAP24XX_EN_DSS2_SHIFT				1
-#define OMAP24XX_EN_DSS1_SHIFT				0
 #define OMAP24XX_EN_DSS1_MASK				(1 << 0)
-#define OMAP2430_EN_I2CHS2_SHIFT			20
-#define OMAP2430_EN_I2CHS1_SHIFT			19
-#define OMAP2430_EN_MMCHSDB2_SHIFT			17
-#define OMAP2430_EN_MMCHSDB1_SHIFT			16
-#define OMAP24XX_EN_MAILBOXES_SHIFT			30
-#define OMAP2430_EN_SDRC_SHIFT				2
-#define OMAP24XX_EN_PKA_SHIFT				4
-#define OMAP24XX_EN_AES_SHIFT				3
-#define OMAP24XX_EN_RNG_SHIFT				2
-#define OMAP24XX_EN_SHA_SHIFT				1
-#define OMAP24XX_EN_DES_SHIFT				0
 #define OMAP24XX_ST_MAILBOXES_SHIFT			30
 #define OMAP24XX_ST_HDQ_SHIFT				23
 #define OMAP2420_ST_I2C2_SHIFT				20
@@ -54,81 +24,30 @@
 #define OMAP2430_ST_I2CHS2_SHIFT			20
 #define OMAP24XX_ST_MCBSP2_SHIFT			16
 #define OMAP24XX_ST_MCBSP1_SHIFT			15
-#define OMAP24XX_ST_DSS_SHIFT				0
 #define OMAP2430_ST_MCBSP5_SHIFT			5
 #define OMAP2430_ST_MCBSP4_SHIFT			4
 #define OMAP2430_ST_MCBSP3_SHIFT			3
 #define OMAP24XX_ST_AES_SHIFT				3
 #define OMAP24XX_ST_RNG_SHIFT				2
 #define OMAP24XX_ST_SHA_SHIFT				1
-#define OMAP24XX_AUTO_SDRC_SHIFT			2
-#define OMAP24XX_AUTO_GPMC_SHIFT			1
-#define OMAP24XX_AUTO_SDMA_SHIFT			0
-#define OMAP24XX_CLKSEL_USB_MASK			(0x7 << 25)
-#define OMAP24XX_CLKSEL_SSI_MASK			(0x1f << 20)
-#define OMAP2420_CLKSEL_VLYNQ_MASK			(0x1f << 15)
 #define OMAP24XX_CLKSEL_DSS2_MASK			(0x1 << 13)
-#define OMAP24XX_CLKSEL_DSS1_MASK			(0x1f << 8)
-#define OMAP24XX_CLKSEL_L4_SHIFT			5
-#define OMAP24XX_CLKSEL_L4_WIDTH			2
-#define OMAP24XX_CLKSEL_L3_SHIFT			0
-#define OMAP24XX_CLKSEL_L3_WIDTH			5
-#define OMAP24XX_CLKSEL_GPT12_MASK			(0x3 << 22)
-#define OMAP24XX_CLKSEL_GPT11_MASK			(0x3 << 20)
-#define OMAP24XX_CLKSEL_GPT10_MASK			(0x3 << 18)
-#define OMAP24XX_CLKSEL_GPT9_MASK			(0x3 << 16)
-#define OMAP24XX_CLKSEL_GPT8_MASK			(0x3 << 14)
-#define OMAP24XX_CLKSEL_GPT7_MASK			(0x3 << 12)
-#define OMAP24XX_CLKSEL_GPT6_MASK			(0x3 << 10)
-#define OMAP24XX_CLKSEL_GPT5_MASK			(0x3 << 8)
-#define OMAP24XX_CLKSEL_GPT4_MASK			(0x3 << 6)
-#define OMAP24XX_CLKSEL_GPT3_MASK			(0x3 << 4)
-#define OMAP24XX_CLKSEL_GPT2_MASK			(0x3 << 2)
 #define OMAP24XX_AUTOSTATE_DSS_MASK			(1 << 2)
 #define OMAP24XX_AUTOSTATE_L4_MASK			(1 << 1)
 #define OMAP24XX_AUTOSTATE_L3_MASK			(1 << 0)
-#define OMAP24XX_EN_3D_SHIFT				2
-#define OMAP24XX_EN_2D_SHIFT				1
 #define OMAP24XX_AUTOSTATE_GFX_MASK			(1 << 0)
-#define OMAP2430_EN_ICR_SHIFT				6
-#define OMAP24XX_EN_OMAPCTRL_SHIFT			5
-#define OMAP24XX_EN_WDT1_SHIFT				4
-#define OMAP24XX_EN_32KSYNC_SHIFT			1
 #define OMAP24XX_ST_MPU_WDT_SHIFT			3
 #define OMAP24XX_ST_32KSYNC_SHIFT			1
-#define OMAP24XX_CLKSEL_GPT1_MASK			(0x3 << 0)
 #define OMAP24XX_EN_54M_PLL_SHIFT			6
 #define OMAP24XX_EN_96M_PLL_SHIFT			2
-#define OMAP24XX_EN_DPLL_MASK				(0x3 << 0)
 #define OMAP24XX_ST_54M_APLL_SHIFT			9
 #define OMAP24XX_ST_96M_APLL_SHIFT			8
 #define OMAP24XX_AUTO_54M_MASK				(0x3 << 6)
 #define OMAP24XX_AUTO_96M_MASK				(0x3 << 2)
 #define OMAP24XX_AUTO_DPLL_SHIFT			0
 #define OMAP24XX_AUTO_DPLL_MASK				(0x3 << 0)
-#define OMAP24XX_APLLS_CLKIN_SHIFT			23
-#define OMAP24XX_APLLS_CLKIN_WIDTH			3
-#define OMAP24XX_APLLS_CLKIN_MASK			(0x7 << 23)
-#define OMAP24XX_DPLL_MULT_MASK				(0x3ff << 12)
-#define OMAP24XX_DPLL_DIV_MASK				(0xf << 8)
-#define OMAP24XX_54M_SOURCE_SHIFT			5
-#define OMAP24XX_54M_SOURCE_WIDTH			1
-#define OMAP2430_96M_SOURCE_SHIFT			4
-#define OMAP2430_96M_SOURCE_WIDTH			1
-#define OMAP24XX_48M_SOURCE_MASK			(1 << 3)
 #define OMAP24XX_CORE_CLK_SRC_MASK			(0x3 << 0)
-#define OMAP2420_EN_IVA_COP_SHIFT			10
-#define OMAP2420_EN_IVA_MPU_SHIFT			8
-#define OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT		0
-#define OMAP2420_EN_DSP_IPI_SHIFT			1
-#define OMAP2420_CLKSEL_IVA_MASK			(0x1f << 8)
-#define OMAP24XX_CLKSEL_DSP_IF_MASK			(0x3 << 5)
-#define OMAP24XX_CLKSEL_DSP_MASK			(0x1f << 0)
 #define OMAP2420_AUTOSTATE_IVA_MASK			(1 << 8)
 #define OMAP24XX_AUTOSTATE_DSP_MASK			(1 << 0)
-#define OMAP2430_EN_OSC_SHIFT				1
-#define OMAP2430_CM_ICLKEN_MDM_EN_MDM_SHIFT		0
-#define OMAP2430_CLKSEL_MDM_MASK			(0xf << 0)
 #define OMAP2430_AUTOSTATE_MDM_MASK			(1 << 0)
 #define OMAP24XX_CLKSTCTRL_DISABLE_AUTO		0x0
 #define OMAP24XX_CLKSTCTRL_ENABLE_AUTO		0x1
diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -14,68 +14,11 @@
  * published by the Free Software Foundation.
  */
 
-#define OMAP3430ES2_EN_MMC3_SHIFT			30
-#define OMAP3430_EN_MSPRO_SHIFT				23
-#define OMAP3430_EN_HDQ_SHIFT				22
-#define OMAP3430ES1_EN_FSHOSTUSB_SHIFT			5
-#define OMAP3430ES1_EN_D2D_SHIFT			3
-#define OMAP3430_EN_SSI_SHIFT				0
-#define OMAP3430ES2_EN_USBTLL_SHIFT			2
-#define OMAP3430_EN_WDT2_SHIFT				5
-#define OMAP3430_EN_CAM_SHIFT				0
-#define OMAP3430_EN_WDT3_SHIFT				12
 #define OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_MASK		(1 << 0)
-#define OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_SHIFT		0
-#define OMAP3430_IVA2_DPLL_FREQSEL_SHIFT		4
-#define OMAP3430_IVA2_DPLL_FREQSEL_MASK			(0xf << 4)
-#define OMAP3430_EN_IVA2_DPLL_DRIFTGUARD_SHIFT		3
-#define OMAP3430_EN_IVA2_DPLL_SHIFT			0
-#define OMAP3430_EN_IVA2_DPLL_MASK			(0x7 << 0)
 #define OMAP3430_ST_IVA2_SHIFT				0
-#define OMAP3430_ST_IVA2_CLK_MASK			(1 << 0)
-#define OMAP3430_AUTO_IVA2_DPLL_SHIFT			0
-#define OMAP3430_AUTO_IVA2_DPLL_MASK			(0x7 << 0)
-#define OMAP3430_IVA2_CLK_SRC_SHIFT			19
-#define OMAP3430_IVA2_CLK_SRC_WIDTH			3
-#define OMAP3430_IVA2_DPLL_MULT_MASK			(0x7ff << 8)
-#define OMAP3430_IVA2_DPLL_DIV_MASK			(0x7f << 0)
-#define OMAP3430_IVA2_DPLL_CLKOUT_DIV_SHIFT		0
-#define OMAP3430_IVA2_DPLL_CLKOUT_DIV_WIDTH		5
 #define OMAP3430_CLKTRCTRL_IVA2_MASK			(0x3 << 0)
 #define OMAP3430_CLKACTIVITY_IVA2_MASK			(1 << 0)
-#define OMAP3430_MPU_DPLL_FREQSEL_MASK			(0xf << 4)
-#define OMAP3430_EN_MPU_DPLL_DRIFTGUARD_SHIFT		3
-#define OMAP3430_EN_MPU_DPLL_MASK			(0x7 << 0)
-#define OMAP3430_ST_MPU_CLK_SHIFT			0
-#define OMAP3430_ST_MPU_CLK_MASK			(1 << 0)
-#define OMAP3430_ST_MPU_CLK_WIDTH			1
-#define OMAP3430_AUTO_MPU_DPLL_MASK			(0x7 << 0)
-#define OMAP3430_MPU_CLK_SRC_SHIFT			19
-#define OMAP3430_MPU_CLK_SRC_WIDTH			3
-#define OMAP3430_MPU_DPLL_MULT_MASK			(0x7ff << 8)
-#define OMAP3430_MPU_DPLL_DIV_MASK			(0x7f << 0)
-#define OMAP3430_MPU_DPLL_CLKOUT_DIV_SHIFT		0
-#define OMAP3430_MPU_DPLL_CLKOUT_DIV_WIDTH		5
 #define OMAP3430_CLKTRCTRL_MPU_MASK			(0x3 << 0)
-#define OMAP3430_EN_MODEM_SHIFT				31
-#define OMAP3430_EN_ICR_SHIFT				29
-#define OMAP3430_EN_AES2_SHIFT				28
-#define OMAP3430_EN_SHA12_SHIFT				27
-#define OMAP3430_EN_DES2_SHIFT				26
-#define OMAP3430ES1_EN_FAC_SHIFT			8
-#define OMAP3430_EN_MAILBOXES_SHIFT			7
-#define OMAP3430_EN_OMAPCTRL_SHIFT			6
-#define OMAP3430_EN_SAD2D_SHIFT				3
-#define OMAP3430_EN_SDRC_SHIFT				1
-#define AM35XX_EN_IPSS_SHIFT				4
-#define OMAP3430_EN_PKA_SHIFT				4
-#define OMAP3430_EN_AES1_SHIFT				3
-#define OMAP3430_EN_RNG_SHIFT				2
-#define OMAP3430_EN_SHA11_SHIFT				1
-#define OMAP3430_EN_DES1_SHIFT				0
-#define OMAP3430_EN_MAD2D_SHIFT				3
-#define OMAP3430ES2_EN_TS_SHIFT				1
-#define OMAP3430ES2_EN_CPEFUSE_SHIFT			0
 #define OMAP3430_ST_AES2_SHIFT				28
 #define OMAP3430_ST_SHA12_SHIFT				27
 #define AM35XX_ST_UART4_SHIFT				23
@@ -84,131 +27,26 @@
 #define OMAP3430_ST_MAILBOXES_SHIFT			7
 #define OMAP3430_ST_SAD2D_SHIFT				3
 #define OMAP3430_ST_SDMA_SHIFT				2
-#define AM35XX_ST_IPSS_SHIFT				5
 #define OMAP3430ES2_ST_USBTLL_SHIFT			2
-#define OMAP3430_CLKSEL_SSI_MASK			(0xf << 8)
-#define OMAP3430_CLKSEL_GPT11_MASK			(1 << 7)
-#define OMAP3430_CLKSEL_GPT10_MASK			(1 << 6)
-#define OMAP3430ES1_CLKSEL_FSHOSTUSB_MASK		(0x3 << 4)
-#define OMAP3430_CLKSEL_L4_SHIFT			2
-#define OMAP3430_CLKSEL_L4_WIDTH			2
-#define OMAP3430_CLKSEL_L3_SHIFT			0
-#define OMAP3430_CLKSEL_L3_WIDTH			2
-#define OMAP3630_CLKSEL_96M_MASK			(0x3 << 12)
 #define OMAP3430ES1_CLKTRCTRL_D2D_MASK			(0x3 << 4)
 #define OMAP3430_CLKTRCTRL_L4_MASK			(0x3 << 2)
 #define OMAP3430_CLKTRCTRL_L3_MASK			(0x3 << 0)
-#define OMAP3430ES1_EN_3D_SHIFT				2
-#define OMAP3430ES1_EN_2D_SHIFT				1
 #define OMAP3430ES1_CLKTRCTRL_GFX_MASK			(0x3 << 0)
-#define OMAP3430ES2_CM_FCLKEN_SGX_EN_SGX_SHIFT		1
-#define OMAP3430ES2_CM_ICLKEN_SGX_EN_SGX_SHIFT		0
-#define OMAP3430ES2_CLKSEL_SGX_MASK			(0x7 << 0)
 #define OMAP3430ES2_CLKTRCTRL_SGX_MASK			(0x3 << 0)
-#define OMAP3430ES2_EN_USIMOCP_SHIFT			9
-#define OMAP3430_EN_WDT1_SHIFT				4
-#define OMAP3430_EN_32KSYNC_SHIFT			2
 #define OMAP3430_ST_WDT2_SHIFT				5
 #define OMAP3430_ST_32KSYNC_SHIFT			2
-#define OMAP3430ES2_CLKSEL_USIMOCP_MASK			(0xf << 3)
-#define OMAP3430_CLKSEL_RM_SHIFT			1
-#define OMAP3430_CLKSEL_RM_WIDTH			2
-#define OMAP3430_CLKSEL_GPT1_MASK			(1 << 0)
-#define OMAP3430_PWRDN_EMU_PERIPH_SHIFT			31
-#define OMAP3430_PWRDN_CAM_SHIFT			30
-#define OMAP3430_PWRDN_DSS1_SHIFT			29
-#define OMAP3430_PWRDN_TV_SHIFT				28
-#define OMAP3430_PWRDN_96M_SHIFT			27
-#define OMAP3430_PERIPH_DPLL_FREQSEL_MASK		(0xf << 20)
-#define OMAP3430_EN_PERIPH_DPLL_DRIFTGUARD_SHIFT	19
-#define OMAP3430_EN_PERIPH_DPLL_MASK			(0x7 << 16)
-#define OMAP3430_PWRDN_EMU_CORE_SHIFT			12
-#define OMAP3430_CORE_DPLL_FREQSEL_MASK			(0xf << 4)
-#define OMAP3430_EN_CORE_DPLL_DRIFTGUARD_SHIFT		3
-#define OMAP3430_EN_CORE_DPLL_MASK			(0x7 << 0)
-#define OMAP3430ES2_PERIPH2_DPLL_FREQSEL_MASK		(0xf << 4)
-#define OMAP3430ES2_EN_PERIPH2_DPLL_DRIFTGUARD_SHIFT	3
-#define OMAP3430ES2_EN_PERIPH2_DPLL_MASK		(0x7 << 0)
-#define OMAP3430_ST_PERIPH_CLK_MASK			(1 << 1)
-#define OMAP3430_ST_CORE_CLK_MASK			(1 << 0)
-#define OMAP3430ES2_ST_PERIPH2_CLK_MASK			(1 << 0)
 #define OMAP3430_AUTO_PERIPH_DPLL_MASK			(0x7 << 3)
-#define OMAP3430_AUTO_CORE_DPLL_MASK			(0x7 << 0)
-#define OMAP3430ES2_AUTO_PERIPH2_DPLL_MASK		(0x7 << 0)
-#define OMAP3430_CORE_DPLL_CLKOUT_DIV_SHIFT		27
-#define OMAP3430_CORE_DPLL_CLKOUT_DIV_WIDTH		5
-#define OMAP3430_CORE_DPLL_MULT_MASK			(0x7ff << 16)
-#define OMAP3430_CORE_DPLL_DIV_MASK			(0x7f << 8)
-#define OMAP3430_SOURCE_96M_SHIFT			6
-#define OMAP3430_SOURCE_96M_WIDTH			1
-#define OMAP3430_SOURCE_54M_SHIFT			5
-#define OMAP3430_SOURCE_54M_WIDTH			1
-#define OMAP3430_SOURCE_48M_MASK			(1 << 3)
-#define OMAP3430_PERIPH_DPLL_MULT_MASK			(0x7ff << 8)
-#define OMAP3630_PERIPH_DPLL_MULT_MASK			(0xfff << 8)
-#define OMAP3430_PERIPH_DPLL_DIV_MASK			(0x7f << 0)
-#define OMAP3630_PERIPH_DPLL_DCO_SEL_MASK		(0x7 << 21)
-#define OMAP3630_PERIPH_DPLL_SD_DIV_MASK		(0xff << 24)
-#define OMAP3430_DIV_96M_SHIFT				0
-#define OMAP3630_DIV_96M_WIDTH				6
-#define OMAP3430ES2_PERIPH2_DPLL_MULT_MASK		(0x7ff << 8)
-#define OMAP3430ES2_PERIPH2_DPLL_DIV_MASK		(0x7f << 0)
-#define OMAP3430ES2_DIV_120M_SHIFT			0
-#define OMAP3430ES2_DIV_120M_WIDTH			5
-#define OMAP3430_CLKOUT2_EN_SHIFT			7
-#define OMAP3430_CLKOUT2_DIV_SHIFT			3
-#define OMAP3430_CLKOUT2_DIV_WIDTH			3
-#define OMAP3430_CLKOUT2SOURCE_MASK			(0x3 << 0)
-#define OMAP3430_EN_TV_SHIFT				2
-#define OMAP3430_EN_DSS2_SHIFT				1
-#define OMAP3430_EN_DSS1_SHIFT				0
-#define OMAP3430_CM_ICLKEN_DSS_EN_DSS_SHIFT		0
 #define OMAP3430ES2_ST_DSS_IDLE_SHIFT			1
-#define OMAP3430ES2_ST_DSS_STDBY_SHIFT			0
-#define OMAP3430ES1_ST_DSS_SHIFT			0
-#define OMAP3430_CLKSEL_TV_SHIFT			8
-#define OMAP3630_CLKSEL_TV_WIDTH			6
-#define OMAP3430_CLKSEL_DSS1_SHIFT			0
-#define OMAP3630_CLKSEL_DSS1_WIDTH			6
 #define OMAP3430_CLKTRCTRL_DSS_MASK			(0x3 << 0)
-#define OMAP3430_EN_CSI2_SHIFT				1
-#define OMAP3430_CLKSEL_CAM_SHIFT			0
-#define OMAP3630_CLKSEL_CAM_WIDTH			6
 #define OMAP3430_CLKTRCTRL_CAM_MASK			(0x3 << 0)
 #define OMAP3430_ST_MCBSP4_SHIFT			2
 #define OMAP3430_ST_MCBSP3_SHIFT			1
 #define OMAP3430_ST_MCBSP2_SHIFT			0
-#define OMAP3430_CLKSEL_GPT9_MASK			(1 << 7)
-#define OMAP3430_CLKSEL_GPT8_MASK			(1 << 6)
-#define OMAP3430_CLKSEL_GPT7_MASK			(1 << 5)
-#define OMAP3430_CLKSEL_GPT6_MASK			(1 << 4)
-#define OMAP3430_CLKSEL_GPT5_MASK			(1 << 3)
-#define OMAP3430_CLKSEL_GPT4_MASK			(1 << 2)
-#define OMAP3430_CLKSEL_GPT3_MASK			(1 << 1)
-#define OMAP3430_CLKSEL_GPT2_MASK			(1 << 0)
 #define OMAP3430_CLKTRCTRL_PER_MASK			(0x3 << 0)
-#define OMAP3430_DIV_DPLL4_SHIFT			24
-#define OMAP3630_DIV_DPLL4_WIDTH			6
-#define OMAP3430_DIV_DPLL3_SHIFT			16
-#define OMAP3430_DIV_DPLL3_WIDTH			5
-#define OMAP3430_CLKSEL_TRACECLK_SHIFT			11
-#define OMAP3430_CLKSEL_TRACECLK_WIDTH			3
-#define OMAP3430_CLKSEL_PCLK_SHIFT			8
-#define OMAP3430_CLKSEL_PCLK_WIDTH			3
-#define OMAP3430_CLKSEL_PCLKX2_SHIFT			6
-#define OMAP3430_CLKSEL_PCLKX2_WIDTH			2
-#define OMAP3430_CLKSEL_ATCLK_SHIFT			4
-#define OMAP3430_CLKSEL_ATCLK_WIDTH			2
-#define OMAP3430_TRACE_MUX_CTRL_SHIFT			2
-#define OMAP3430_TRACE_MUX_CTRL_WIDTH			2
-#define OMAP3430_MUX_CTRL_MASK				(0x3 << 0)
 #define OMAP3430_CLKTRCTRL_EMU_MASK			(0x3 << 0)
 #define OMAP3430_CLKTRCTRL_NEON_MASK			(0x3 << 0)
 #define OMAP3430ES2_EN_USBHOST2_SHIFT			1
-#define OMAP3430ES2_EN_USBHOST1_SHIFT			0
-#define OMAP3430ES2_EN_USBHOST_SHIFT			0
 #define OMAP3430ES2_ST_USBHOST_IDLE_SHIFT		1
-#define OMAP3430ES2_ST_USBHOST_STDBY_SHIFT		0
 #define OMAP3430ES2_CLKTRCTRL_USBHOST_MASK		(3 << 0)
 #define OMAP34XX_CLKSTCTRL_DISABLE_AUTO		0x0
 #define OMAP34XX_CLKSTCTRL_FORCE_SLEEP		0x1
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -329,11 +329,8 @@ struct omap_hwmod_class_sysconfig {
 /**
  * struct omap_hwmod_omap2_prcm - OMAP2/3-specific PRCM data
  * @module_offs: PRCM submodule offset from the start of the PRM/CM
- * @prcm_reg_id: PRCM register ID (e.g., 3 for CM_AUTOIDLE3)
- * @module_bit: register bit shift for AUTOIDLE, WKST, WKEN, GRPSEL regs
  * @idlest_reg_id: IDLEST register ID (e.g., 3 for CM_IDLEST3)
  * @idlest_idle_bit: register bit shift for CM_IDLEST slave idle bit
- * @idlest_stdby_bit: register bit shift for CM_IDLEST master standby bit
  *
  * @prcm_reg_id and @module_bit are specific to the AUTOIDLE, WKST,
  * WKEN, GRPSEL registers.  In an ideal world, no extra information
@@ -343,11 +340,8 @@ struct omap_hwmod_class_sysconfig {
  */
 struct omap_hwmod_omap2_prcm {
 	s16 module_offs;
-	u8 prcm_reg_id;
-	u8 module_bit;
 	u8 idlest_reg_id;
 	u8 idlest_idle_bit;
-	u8 idlest_stdby_bit;
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -111,8 +111,6 @@ static struct omap_hwmod omap2420_i2c1_hwmod = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP2420_EN_I2C1_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP2420_ST_I2C1_SHIFT,
 		},
@@ -134,8 +132,6 @@ static struct omap_hwmod omap2420_i2c2_hwmod = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP2420_EN_I2C2_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP2420_ST_I2C2_SHIFT,
 		},
@@ -167,8 +163,6 @@ static struct omap_hwmod omap2420_mailbox_hwmod = {
 	.main_clk	= "mailboxes_ick",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_MAILBOXES_SHIFT,
 			.module_offs = CORE_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP24XX_ST_MAILBOXES_SHIFT,
@@ -197,8 +191,6 @@ static struct omap_hwmod omap2420_mcbsp1_hwmod = {
 	.main_clk	= "mcbsp1_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_MCBSP1_SHIFT,
 			.module_offs = CORE_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP24XX_ST_MCBSP1_SHIFT,
@@ -215,8 +207,6 @@ static struct omap_hwmod omap2420_mcbsp2_hwmod = {
 	.main_clk	= "mcbsp2_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_MCBSP2_SHIFT,
 			.module_offs = CORE_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP24XX_ST_MCBSP2_SHIFT,
@@ -247,8 +237,6 @@ static struct omap_hwmod omap2420_msdi1_hwmod = {
 	.main_clk	= "mmc_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP2420_EN_MMC_SHIFT,
 			.module_offs = CORE_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP2420_ST_MMC_SHIFT,
@@ -264,8 +252,6 @@ static struct omap_hwmod omap2420_hdq1w_hwmod = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_HDQ_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP24XX_ST_HDQ_SHIFT,
 		},
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -97,8 +97,6 @@ static struct omap_hwmod omap2430_i2c1_hwmod = {
 			 * to hwmod framework.
 			 */
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP2430_EN_I2CHS1_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP2430_ST_I2CHS1_SHIFT,
 		},
@@ -115,8 +113,6 @@ static struct omap_hwmod omap2430_i2c2_hwmod = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP2430_EN_I2CHS2_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP2430_ST_I2CHS2_SHIFT,
 		},
@@ -132,8 +128,6 @@ static struct omap_hwmod omap2430_gpio5_hwmod = {
 	.main_clk	= "gpio5_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 2,
-			.module_bit = OMAP2430_EN_GPIO5_SHIFT,
 			.module_offs = CORE_MOD,
 			.idlest_reg_id = 2,
 			.idlest_idle_bit = OMAP2430_ST_GPIO5_SHIFT,
@@ -165,8 +159,6 @@ static struct omap_hwmod omap2430_mailbox_hwmod = {
 	.main_clk	= "mailboxes_ick",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_MAILBOXES_SHIFT,
 			.module_offs = CORE_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP24XX_ST_MAILBOXES_SHIFT,
@@ -185,8 +177,6 @@ static struct omap_hwmod omap2430_mcspi3_hwmod = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 2,
-			.module_bit = OMAP2430_EN_MCSPI3_SHIFT,
 			.idlest_reg_id = 2,
 			.idlest_idle_bit = OMAP2430_ST_MCSPI3_SHIFT,
 		},
@@ -219,8 +209,6 @@ static struct omap_hwmod omap2430_usbhsotg_hwmod = {
 	.main_clk	= "usbhs_ick",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP2430_EN_USBHS_MASK,
 			.module_offs = CORE_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP2430_ST_USBHS_SHIFT,
@@ -266,8 +254,6 @@ static struct omap_hwmod omap2430_mcbsp1_hwmod = {
 	.main_clk	= "mcbsp1_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_MCBSP1_SHIFT,
 			.module_offs = CORE_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP24XX_ST_MCBSP1_SHIFT,
@@ -284,8 +270,6 @@ static struct omap_hwmod omap2430_mcbsp2_hwmod = {
 	.main_clk	= "mcbsp2_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_MCBSP2_SHIFT,
 			.module_offs = CORE_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP24XX_ST_MCBSP2_SHIFT,
@@ -302,8 +286,6 @@ static struct omap_hwmod omap2430_mcbsp3_hwmod = {
 	.main_clk	= "mcbsp3_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP2430_EN_MCBSP3_SHIFT,
 			.module_offs = CORE_MOD,
 			.idlest_reg_id = 2,
 			.idlest_idle_bit = OMAP2430_ST_MCBSP3_SHIFT,
@@ -320,8 +302,6 @@ static struct omap_hwmod omap2430_mcbsp4_hwmod = {
 	.main_clk	= "mcbsp4_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP2430_EN_MCBSP4_SHIFT,
 			.module_offs = CORE_MOD,
 			.idlest_reg_id = 2,
 			.idlest_idle_bit = OMAP2430_ST_MCBSP4_SHIFT,
@@ -338,8 +318,6 @@ static struct omap_hwmod omap2430_mcbsp5_hwmod = {
 	.main_clk	= "mcbsp5_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP2430_EN_MCBSP5_SHIFT,
 			.module_offs = CORE_MOD,
 			.idlest_reg_id = 2,
 			.idlest_idle_bit = OMAP2430_ST_MCBSP5_SHIFT,
@@ -384,8 +362,6 @@ static struct omap_hwmod omap2430_mmc1_hwmod = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 2,
-			.module_bit  = OMAP2430_EN_MMCHS1_SHIFT,
 			.idlest_reg_id = 2,
 			.idlest_idle_bit = OMAP2430_ST_MMCHS1_SHIFT,
 		},
@@ -408,8 +384,6 @@ static struct omap_hwmod omap2430_mmc2_hwmod = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 2,
-			.module_bit  = OMAP2430_EN_MMCHS2_SHIFT,
 			.idlest_reg_id = 2,
 			.idlest_idle_bit = OMAP2430_ST_MMCHS2_SHIFT,
 		},
@@ -424,8 +398,6 @@ static struct omap_hwmod omap2430_hdq1w_hwmod = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_HDQ_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP24XX_ST_HDQ_SHIFT,
 		},
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -242,8 +242,6 @@ struct omap_hwmod omap2xxx_timer1_hwmod = {
 	.main_clk	= "gpt1_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT1_SHIFT,
 			.module_offs = WKUP_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP24XX_ST_GPT1_SHIFT,
@@ -261,8 +259,6 @@ struct omap_hwmod omap2xxx_timer2_hwmod = {
 	.main_clk	= "gpt2_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT2_SHIFT,
 			.module_offs = CORE_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP24XX_ST_GPT2_SHIFT,
@@ -279,8 +275,6 @@ struct omap_hwmod omap2xxx_timer3_hwmod = {
 	.main_clk	= "gpt3_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT3_SHIFT,
 			.module_offs = CORE_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP24XX_ST_GPT3_SHIFT,
@@ -297,8 +291,6 @@ struct omap_hwmod omap2xxx_timer4_hwmod = {
 	.main_clk	= "gpt4_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT4_SHIFT,
 			.module_offs = CORE_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP24XX_ST_GPT4_SHIFT,
@@ -315,8 +307,6 @@ struct omap_hwmod omap2xxx_timer5_hwmod = {
 	.main_clk	= "gpt5_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT5_SHIFT,
 			.module_offs = CORE_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP24XX_ST_GPT5_SHIFT,
@@ -334,8 +324,6 @@ struct omap_hwmod omap2xxx_timer6_hwmod = {
 	.main_clk	= "gpt6_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT6_SHIFT,
 			.module_offs = CORE_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP24XX_ST_GPT6_SHIFT,
@@ -353,8 +341,6 @@ struct omap_hwmod omap2xxx_timer7_hwmod = {
 	.main_clk	= "gpt7_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT7_SHIFT,
 			.module_offs = CORE_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP24XX_ST_GPT7_SHIFT,
@@ -372,8 +358,6 @@ struct omap_hwmod omap2xxx_timer8_hwmod = {
 	.main_clk	= "gpt8_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT8_SHIFT,
 			.module_offs = CORE_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP24XX_ST_GPT8_SHIFT,
@@ -391,8 +375,6 @@ struct omap_hwmod omap2xxx_timer9_hwmod = {
 	.main_clk	= "gpt9_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT9_SHIFT,
 			.module_offs = CORE_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP24XX_ST_GPT9_SHIFT,
@@ -410,8 +392,6 @@ struct omap_hwmod omap2xxx_timer10_hwmod = {
 	.main_clk	= "gpt10_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT10_SHIFT,
 			.module_offs = CORE_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP24XX_ST_GPT10_SHIFT,
@@ -429,8 +409,6 @@ struct omap_hwmod omap2xxx_timer11_hwmod = {
 	.main_clk	= "gpt11_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT11_SHIFT,
 			.module_offs = CORE_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP24XX_ST_GPT11_SHIFT,
@@ -448,8 +426,6 @@ struct omap_hwmod omap2xxx_timer12_hwmod = {
 	.main_clk	= "gpt12_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPT12_SHIFT,
 			.module_offs = CORE_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP24XX_ST_GPT12_SHIFT,
@@ -467,8 +443,6 @@ struct omap_hwmod omap2xxx_wd_timer2_hwmod = {
 	.main_clk	= "mpu_wdt_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_MPU_WDT_SHIFT,
 			.module_offs = WKUP_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP24XX_ST_MPU_WDT_SHIFT,
@@ -485,8 +459,6 @@ struct omap_hwmod omap2xxx_uart1_hwmod = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_UART1_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP24XX_EN_UART1_SHIFT,
 		},
@@ -503,8 +475,6 @@ struct omap_hwmod omap2xxx_uart2_hwmod = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_UART2_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP24XX_EN_UART2_SHIFT,
 		},
@@ -521,8 +491,6 @@ struct omap_hwmod omap2xxx_uart3_hwmod = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 2,
-			.module_bit = OMAP24XX_EN_UART3_SHIFT,
 			.idlest_reg_id = 2,
 			.idlest_idle_bit = OMAP24XX_EN_UART3_SHIFT,
 		},
@@ -547,11 +515,8 @@ struct omap_hwmod omap2xxx_dss_core_hwmod = {
 	.main_clk	= "dss1_fck", /* instead of dss_fck */
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_DSS1_SHIFT,
 			.module_offs = CORE_MOD,
 			.idlest_reg_id = 1,
-			.idlest_stdby_bit = OMAP24XX_ST_DSS_SHIFT,
 		},
 	},
 	.opt_clks	= dss_opt_clks,
@@ -565,11 +530,8 @@ struct omap_hwmod omap2xxx_dss_dispc_hwmod = {
 	.main_clk	= "dss1_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_DSS1_SHIFT,
 			.module_offs = CORE_MOD,
 			.idlest_reg_id = 1,
-			.idlest_stdby_bit = OMAP24XX_ST_DSS_SHIFT,
 		},
 	},
 	.flags		= HWMOD_NO_IDLEST,
@@ -586,8 +548,6 @@ struct omap_hwmod omap2xxx_dss_rfbi_hwmod = {
 	.main_clk	= "dss1_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_DSS1_SHIFT,
 			.module_offs = CORE_MOD,
 		},
 	},
@@ -602,8 +562,6 @@ struct omap_hwmod omap2xxx_dss_venc_hwmod = {
 	.main_clk	= "dss_54m_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_DSS1_SHIFT,
 			.module_offs = CORE_MOD,
 		},
 	},
@@ -623,8 +581,6 @@ struct omap_hwmod omap2xxx_gpio1_hwmod = {
 	.main_clk	= "gpios_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPIOS_SHIFT,
 			.module_offs = WKUP_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP24XX_ST_GPIOS_SHIFT,
@@ -641,8 +597,6 @@ struct omap_hwmod omap2xxx_gpio2_hwmod = {
 	.main_clk	= "gpios_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPIOS_SHIFT,
 			.module_offs = WKUP_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP24XX_ST_GPIOS_SHIFT,
@@ -659,8 +613,6 @@ struct omap_hwmod omap2xxx_gpio3_hwmod = {
 	.main_clk	= "gpios_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPIOS_SHIFT,
 			.module_offs = WKUP_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP24XX_ST_GPIOS_SHIFT,
@@ -677,8 +629,6 @@ struct omap_hwmod omap2xxx_gpio4_hwmod = {
 	.main_clk	= "gpios_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_GPIOS_SHIFT,
 			.module_offs = WKUP_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP24XX_ST_GPIOS_SHIFT,
@@ -699,8 +649,6 @@ struct omap_hwmod omap2xxx_mcspi1_hwmod = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_MCSPI1_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP24XX_ST_MCSPI1_SHIFT,
 		},
@@ -720,8 +668,6 @@ struct omap_hwmod omap2xxx_mcspi2_hwmod = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_EN_MCSPI2_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP24XX_ST_MCSPI2_SHIFT,
 		},
@@ -740,8 +686,6 @@ struct omap_hwmod omap2xxx_counter_32k_hwmod = {
 	.prcm		= {
 		.omap2	= {
 			.module_offs = WKUP_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP24XX_ST_32KSYNC_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP24XX_ST_32KSYNC_SHIFT,
 		},
@@ -758,8 +702,6 @@ struct omap_hwmod omap2xxx_gpmc_hwmod = {
 	.flags		= HWMOD_NO_IDLEST | DEBUG_OMAP_GPMC_HWMOD_FLAGS,
 	.prcm		= {
 		.omap2	= {
-			.prcm_reg_id = 3,
-			.module_bit = OMAP24XX_EN_GPMC_MASK,
 			.module_offs = CORE_MOD,
 		},
 	},
@@ -787,8 +729,6 @@ struct omap_hwmod omap2xxx_rng_hwmod = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 4,
-			.module_bit = OMAP24XX_EN_RNG_SHIFT,
 			.idlest_reg_id = 4,
 			.idlest_idle_bit = OMAP24XX_ST_RNG_SHIFT,
 		},
@@ -825,8 +765,6 @@ struct omap_hwmod omap2xxx_sham_hwmod = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 4,
-			.module_bit = OMAP24XX_EN_SHA_SHIFT,
 			.idlest_reg_id = 4,
 			.idlest_idle_bit = OMAP24XX_ST_SHA_SHIFT,
 		},
@@ -856,8 +794,6 @@ struct omap_hwmod omap2xxx_aes_hwmod = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 4,
-			.module_bit = OMAP24XX_EN_AES_SHIFT,
 			.idlest_reg_id = 4,
 			.idlest_idle_bit = OMAP24XX_ST_AES_SHIFT,
 		},
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -113,8 +113,6 @@ static struct omap_hwmod omap3xxx_iva_hwmod = {
 	.prcm = {
 		.omap2 = {
 			.module_offs = OMAP3430_IVA2_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_IVA2_SHIFT,
 		},
@@ -188,8 +186,6 @@ static struct omap_hwmod omap3xxx_timer1_hwmod = {
 	.main_clk	= "gpt1_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_GPT1_SHIFT,
 			.module_offs = WKUP_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_GPT1_SHIFT,
@@ -206,8 +202,6 @@ static struct omap_hwmod omap3xxx_timer2_hwmod = {
 	.main_clk	= "gpt2_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_GPT2_SHIFT,
 			.module_offs = OMAP3430_PER_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_GPT2_SHIFT,
@@ -223,8 +217,6 @@ static struct omap_hwmod omap3xxx_timer3_hwmod = {
 	.main_clk	= "gpt3_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_GPT3_SHIFT,
 			.module_offs = OMAP3430_PER_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_GPT3_SHIFT,
@@ -240,8 +232,6 @@ static struct omap_hwmod omap3xxx_timer4_hwmod = {
 	.main_clk	= "gpt4_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_GPT4_SHIFT,
 			.module_offs = OMAP3430_PER_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_GPT4_SHIFT,
@@ -257,8 +247,6 @@ static struct omap_hwmod omap3xxx_timer5_hwmod = {
 	.main_clk	= "gpt5_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_GPT5_SHIFT,
 			.module_offs = OMAP3430_PER_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_GPT5_SHIFT,
@@ -275,8 +263,6 @@ static struct omap_hwmod omap3xxx_timer6_hwmod = {
 	.main_clk	= "gpt6_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_GPT6_SHIFT,
 			.module_offs = OMAP3430_PER_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_GPT6_SHIFT,
@@ -293,8 +279,6 @@ static struct omap_hwmod omap3xxx_timer7_hwmod = {
 	.main_clk	= "gpt7_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_GPT7_SHIFT,
 			.module_offs = OMAP3430_PER_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_GPT7_SHIFT,
@@ -311,8 +295,6 @@ static struct omap_hwmod omap3xxx_timer8_hwmod = {
 	.main_clk	= "gpt8_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_GPT8_SHIFT,
 			.module_offs = OMAP3430_PER_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_GPT8_SHIFT,
@@ -329,8 +311,6 @@ static struct omap_hwmod omap3xxx_timer9_hwmod = {
 	.main_clk	= "gpt9_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_GPT9_SHIFT,
 			.module_offs = OMAP3430_PER_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_GPT9_SHIFT,
@@ -347,8 +327,6 @@ static struct omap_hwmod omap3xxx_timer10_hwmod = {
 	.main_clk	= "gpt10_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_GPT10_SHIFT,
 			.module_offs = CORE_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_GPT10_SHIFT,
@@ -365,8 +343,6 @@ static struct omap_hwmod omap3xxx_timer11_hwmod = {
 	.main_clk	= "gpt11_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_GPT11_SHIFT,
 			.module_offs = CORE_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_GPT11_SHIFT,
@@ -384,8 +360,6 @@ static struct omap_hwmod omap3xxx_timer12_hwmod = {
 	.main_clk	= "gpt12_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_GPT12_SHIFT,
 			.module_offs = WKUP_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_GPT12_SHIFT,
@@ -439,8 +413,6 @@ static struct omap_hwmod omap3xxx_wd_timer2_hwmod = {
 	.main_clk	= "wdt2_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_WDT2_SHIFT,
 			.module_offs = WKUP_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_WDT2_SHIFT,
@@ -461,8 +433,6 @@ static struct omap_hwmod omap3xxx_uart1_hwmod = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_UART1_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_EN_UART1_SHIFT,
 		},
@@ -478,8 +448,6 @@ static struct omap_hwmod omap3xxx_uart2_hwmod = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_UART2_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_EN_UART2_SHIFT,
 		},
@@ -496,8 +464,6 @@ static struct omap_hwmod omap3xxx_uart3_hwmod = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = OMAP3430_PER_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_UART3_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_EN_UART3_SHIFT,
 		},
@@ -515,8 +481,6 @@ static struct omap_hwmod omap36xx_uart4_hwmod = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = OMAP3430_PER_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3630_EN_UART4_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3630_EN_UART4_SHIFT,
 		},
@@ -546,8 +510,6 @@ static struct omap_hwmod am35xx_uart4_hwmod = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = AM35XX_EN_UART4_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = AM35XX_ST_UART4_SHIFT,
 		},
@@ -583,11 +545,8 @@ static struct omap_hwmod omap3430es1_dss_core_hwmod = {
 	.main_clk	= "dss1_alwon_fck", /* instead of dss_fck */
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_DSS1_SHIFT,
 			.module_offs = OMAP3430_DSS_MOD,
 			.idlest_reg_id = 1,
-			.idlest_stdby_bit = OMAP3430ES1_ST_DSS_SHIFT,
 		},
 	},
 	.opt_clks	= dss_opt_clks,
@@ -602,12 +561,9 @@ static struct omap_hwmod omap3xxx_dss_core_hwmod = {
 	.main_clk	= "dss1_alwon_fck", /* instead of dss_fck */
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_DSS1_SHIFT,
 			.module_offs = OMAP3430_DSS_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430ES2_ST_DSS_IDLE_SHIFT,
-			.idlest_stdby_bit = OMAP3430ES2_ST_DSS_STDBY_SHIFT,
 		},
 	},
 	.opt_clks	= dss_opt_clks,
@@ -642,8 +598,6 @@ static struct omap_hwmod omap3xxx_dss_dispc_hwmod = {
 	.main_clk	= "dss1_alwon_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_DSS1_SHIFT,
 			.module_offs = OMAP3430_DSS_MOD,
 		},
 	},
@@ -683,8 +637,6 @@ static struct omap_hwmod omap3xxx_dss_dsi1_hwmod = {
 	.main_clk	= "dss1_alwon_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_DSS1_SHIFT,
 			.module_offs = OMAP3430_DSS_MOD,
 		},
 	},
@@ -703,8 +655,6 @@ static struct omap_hwmod omap3xxx_dss_rfbi_hwmod = {
 	.main_clk	= "dss1_alwon_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_DSS1_SHIFT,
 			.module_offs = OMAP3430_DSS_MOD,
 		},
 	},
@@ -724,8 +674,6 @@ static struct omap_hwmod omap3xxx_dss_venc_hwmod = {
 	.main_clk	= "dss_tv_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_DSS1_SHIFT,
 			.module_offs = OMAP3430_DSS_MOD,
 		},
 	},
@@ -747,8 +695,6 @@ static struct omap_hwmod omap3xxx_i2c1_hwmod = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_I2C1_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_I2C1_SHIFT,
 		},
@@ -770,8 +716,6 @@ static struct omap_hwmod omap3xxx_i2c2_hwmod = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_I2C2_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_I2C2_SHIFT,
 		},
@@ -795,8 +739,6 @@ static struct omap_hwmod omap3xxx_i2c3_hwmod = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_I2C3_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_I2C3_SHIFT,
 		},
@@ -846,8 +788,6 @@ static struct omap_hwmod omap3xxx_gpio1_hwmod = {
 	.opt_clks_cnt	= ARRAY_SIZE(gpio1_opt_clks),
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_GPIO1_SHIFT,
 			.module_offs = WKUP_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_GPIO1_SHIFT,
@@ -870,8 +810,6 @@ static struct omap_hwmod omap3xxx_gpio2_hwmod = {
 	.opt_clks_cnt	= ARRAY_SIZE(gpio2_opt_clks),
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_GPIO2_SHIFT,
 			.module_offs = OMAP3430_PER_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_GPIO2_SHIFT,
@@ -894,8 +832,6 @@ static struct omap_hwmod omap3xxx_gpio3_hwmod = {
 	.opt_clks_cnt	= ARRAY_SIZE(gpio3_opt_clks),
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_GPIO3_SHIFT,
 			.module_offs = OMAP3430_PER_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_GPIO3_SHIFT,
@@ -918,8 +854,6 @@ static struct omap_hwmod omap3xxx_gpio4_hwmod = {
 	.opt_clks_cnt	= ARRAY_SIZE(gpio4_opt_clks),
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_GPIO4_SHIFT,
 			.module_offs = OMAP3430_PER_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_GPIO4_SHIFT,
@@ -943,8 +877,6 @@ static struct omap_hwmod omap3xxx_gpio5_hwmod = {
 	.opt_clks_cnt	= ARRAY_SIZE(gpio5_opt_clks),
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_GPIO5_SHIFT,
 			.module_offs = OMAP3430_PER_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_GPIO5_SHIFT,
@@ -968,8 +900,6 @@ static struct omap_hwmod omap3xxx_gpio6_hwmod = {
 	.opt_clks_cnt	= ARRAY_SIZE(gpio6_opt_clks),
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_GPIO6_SHIFT,
 			.module_offs = OMAP3430_PER_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_GPIO6_SHIFT,
@@ -1012,8 +942,6 @@ static struct omap_hwmod omap3xxx_dma_system_hwmod = {
 	.prcm = {
 		.omap2 = {
 			.module_offs		= CORE_MOD,
-			.prcm_reg_id		= 1,
-			.module_bit		= OMAP3430_ST_SDMA_SHIFT,
 			.idlest_reg_id		= 1,
 			.idlest_idle_bit	= OMAP3430_ST_SDMA_SHIFT,
 		},
@@ -1060,8 +988,6 @@ static struct omap_hwmod omap3xxx_mcbsp1_hwmod = {
 	.main_clk	= "mcbsp1_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_MCBSP1_SHIFT,
 			.module_offs = CORE_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_MCBSP1_SHIFT,
@@ -1083,8 +1009,6 @@ static struct omap_hwmod omap3xxx_mcbsp2_hwmod = {
 	.main_clk	= "mcbsp2_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_MCBSP2_SHIFT,
 			.module_offs = OMAP3430_PER_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_MCBSP2_SHIFT,
@@ -1107,8 +1031,6 @@ static struct omap_hwmod omap3xxx_mcbsp3_hwmod = {
 	.main_clk	= "mcbsp3_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_MCBSP3_SHIFT,
 			.module_offs = OMAP3430_PER_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_MCBSP3_SHIFT,
@@ -1128,8 +1050,6 @@ static struct omap_hwmod omap3xxx_mcbsp4_hwmod = {
 	.main_clk	= "mcbsp4_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_MCBSP4_SHIFT,
 			.module_offs = OMAP3430_PER_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_MCBSP4_SHIFT,
@@ -1148,8 +1068,6 @@ static struct omap_hwmod omap3xxx_mcbsp5_hwmod = {
 	.main_clk	= "mcbsp5_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_MCBSP5_SHIFT,
 			.module_offs = CORE_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_MCBSP5_SHIFT,
@@ -1228,8 +1146,6 @@ static struct omap_hwmod omap34xx_sr1_hwmod = {
 	.main_clk	= "sr1_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_SR1_SHIFT,
 			.module_offs = WKUP_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_EN_SR1_SHIFT,
@@ -1245,8 +1161,6 @@ static struct omap_hwmod omap36xx_sr1_hwmod = {
 	.main_clk	= "sr1_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_SR1_SHIFT,
 			.module_offs = WKUP_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_EN_SR1_SHIFT,
@@ -1267,8 +1181,6 @@ static struct omap_hwmod omap34xx_sr2_hwmod = {
 	.main_clk	= "sr2_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_SR2_SHIFT,
 			.module_offs = WKUP_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_EN_SR2_SHIFT,
@@ -1284,8 +1196,6 @@ static struct omap_hwmod omap36xx_sr2_hwmod = {
 	.main_clk	= "sr2_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_SR2_SHIFT,
 			.module_offs = WKUP_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_EN_SR2_SHIFT,
@@ -1321,8 +1231,6 @@ static struct omap_hwmod omap3xxx_mailbox_hwmod = {
 	.main_clk	= "mailboxes_ick",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_MAILBOXES_SHIFT,
 			.module_offs = CORE_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_MAILBOXES_SHIFT,
@@ -1364,8 +1272,6 @@ static struct omap_hwmod omap34xx_mcspi1 = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_MCSPI1_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_MCSPI1_SHIFT,
 		},
@@ -1385,8 +1291,6 @@ static struct omap_hwmod omap34xx_mcspi2 = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_MCSPI2_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_MCSPI2_SHIFT,
 		},
@@ -1408,8 +1312,6 @@ static struct omap_hwmod omap34xx_mcspi3 = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_MCSPI3_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_MCSPI3_SHIFT,
 		},
@@ -1431,8 +1333,6 @@ static struct omap_hwmod omap34xx_mcspi4 = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_MCSPI4_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_MCSPI4_SHIFT,
 		},
@@ -1466,12 +1366,9 @@ static struct omap_hwmod omap3xxx_usbhsotg_hwmod = {
 	.main_clk	= "hsotgusb_ick",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_HSOTGUSB_SHIFT,
 			.module_offs = CORE_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430ES2_ST_HSOTGUSB_IDLE_SHIFT,
-			.idlest_stdby_bit = OMAP3430ES2_ST_HSOTGUSB_STDBY_SHIFT,
 		},
 	},
 	.class		= &usbotg_class,
@@ -1546,8 +1443,6 @@ static struct omap_hwmod omap3xxx_pre_es3_mmc1_hwmod = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_MMC1_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_MMC1_SHIFT,
 		},
@@ -1564,8 +1459,6 @@ static struct omap_hwmod omap3xxx_es3plus_mmc1_hwmod = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_MMC1_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_MMC1_SHIFT,
 		},
@@ -1595,8 +1488,6 @@ static struct omap_hwmod omap3xxx_pre_es3_mmc2_hwmod = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_MMC2_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_MMC2_SHIFT,
 		},
@@ -1613,8 +1504,6 @@ static struct omap_hwmod omap3xxx_es3plus_mmc2_hwmod = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_MMC2_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_MMC2_SHIFT,
 		},
@@ -1638,8 +1527,6 @@ static struct omap_hwmod omap3xxx_mmc3_hwmod = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_MMC3_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_MMC3_SHIFT,
 		},
@@ -1679,11 +1566,8 @@ static struct omap_hwmod omap3xxx_usb_host_hs_hwmod = {
 	.prcm = {
 		.omap2 = {
 			.module_offs = OMAP3430ES2_USBHOST_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430ES2_EN_USBHOST1_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430ES2_ST_USBHOST_IDLE_SHIFT,
-			.idlest_stdby_bit = OMAP3430ES2_ST_USBHOST_STDBY_SHIFT,
 		},
 	},
 
@@ -1757,8 +1641,6 @@ static struct omap_hwmod omap3xxx_usb_tll_hs_hwmod = {
 	.prcm = {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 3,
-			.module_bit = OMAP3430ES2_EN_USBTLL_SHIFT,
 			.idlest_reg_id = 3,
 			.idlest_idle_bit = OMAP3430ES2_ST_USBTLL_SHIFT,
 		},
@@ -1771,8 +1653,6 @@ static struct omap_hwmod omap3xxx_hdq1w_hwmod = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_HDQ_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_HDQ_SHIFT,
 		},
@@ -1798,8 +1678,6 @@ static struct omap_hwmod omap3xxx_sad2d_hwmod = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_SAD2D_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_SAD2D_SHIFT,
 		},
@@ -1833,8 +1711,6 @@ static struct omap_hwmod omap3xxx_counter_32k_hwmod = {
 	.prcm		= {
 		.omap2	= {
 			.module_offs = WKUP_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_ST_32KSYNC_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_32KSYNC_SHIFT,
 		},
@@ -2445,7 +2321,6 @@ static struct omap_hwmod omap3xxx_mmu_iva_hwmod = {
 	.prcm = {
 		.omap2 = {
 			.module_offs = OMAP3430_IVA2_MOD,
-			.module_bit = OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_IVA2_SHIFT,
 		},
@@ -2745,8 +2620,6 @@ static struct omap_hwmod omap3xxx_sham_hwmod = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_SHA12_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_SHA12_SHIFT,
 		},
@@ -2785,8 +2658,6 @@ static struct omap_hwmod omap3xxx_aes_hwmod = {
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
-			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_AES2_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_AES2_SHIFT,
 		},
@@ -2829,8 +2700,6 @@ static struct omap_hwmod omap3xxx_ssi_hwmod = {
 	.main_clk	= "ssi_ssr_fck",
 	.prcm		= {
 		.omap2 = {
-			.prcm_reg_id		= 1,
-			.module_bit		= OMAP3430_EN_SSI_SHIFT,
 			.module_offs		= CORE_MOD,
 			.idlest_reg_id		= 1,
 			.idlest_idle_bit	= OMAP3430ES2_ST_SSI_IDLE_SHIFT,
-- 
2.15.0
