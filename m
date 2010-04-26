From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 03/10] OMAP3 PRCM: convert OMAP3 PRCM macros to the
	_SHIFT/_MASK suffixes
Date: Mon, 26 Apr 2010 01:04:24 -0600
Message-ID: <20100426070423.9743.40808.stgit@localhost.localdomain>
References: <20100426070217.9743.92728.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52233 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754242Ab0DZHHe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 03:07:34 -0400
In-Reply-To: <20100426070217.9743.92728.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

Fix all of the remaining OMAP3 PRCM register shift/bitmask macros that
did not use the _SHIFT/_MASK suffixes to use them.  This makes the use
of these macros consistent.  It is intended to reduce error, as code
can be inspected visually by reviewers to ensure that bitshifts and
bitmasks are used in the appropriate places.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/cm-regbits-34xx.h  |  222 ++++++++++----------
 arch/arm/mach-omap2/control.c          |    7 -
 arch/arm/mach-omap2/pm34xx.c           |  175 ++++++++--------
 arch/arm/mach-omap2/powerdomain.c      |   24 +-
 arch/arm/mach-omap2/prm-regbits-34xx.h |  360 ++++++++++++++++----------------
 5 files changed, 397 insertions(+), 391 deletions(-)

diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index a3a3ca0..fe82b79 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -21,15 +21,15 @@
 /* CM_FCLKEN1_CORE and CM_ICLKEN1_CORE shared bits */
 #define OMAP3430ES2_EN_MMC3_MASK			(1 << 30)
 #define OMAP3430ES2_EN_MMC3_SHIFT			30
-#define OMAP3430_EN_MSPRO				(1 << 23)
+#define OMAP3430_EN_MSPRO_MASK				(1 << 23)
 #define OMAP3430_EN_MSPRO_SHIFT				23
-#define OMAP3430_EN_HDQ					(1 << 22)
+#define OMAP3430_EN_HDQ_MASK				(1 << 22)
 #define OMAP3430_EN_HDQ_SHIFT				22
-#define OMAP3430ES1_EN_FSHOSTUSB			(1 << 5)
+#define OMAP3430ES1_EN_FSHOSTUSB_MASK			(1 << 5)
 #define OMAP3430ES1_EN_FSHOSTUSB_SHIFT			5
-#define OMAP3430ES1_EN_D2D				(1 << 3)
+#define OMAP3430ES1_EN_D2D_MASK				(1 << 3)
 #define OMAP3430ES1_EN_D2D_SHIFT			3
-#define OMAP3430_EN_SSI					(1 << 0)
+#define OMAP3430_EN_SSI_MASK				(1 << 0)
 #define OMAP3430_EN_SSI_SHIFT				0
 
 /* CM_FCLKEN3_CORE and CM_ICLKEN3_CORE shared bits */
@@ -37,19 +37,19 @@
 #define OMAP3430ES2_EN_USBTLL_MASK			(1 << 2)
 
 /* CM_FCLKEN_WKUP and CM_ICLKEN_WKUP shared bits */
-#define OMAP3430_EN_WDT2				(1 << 5)
+#define OMAP3430_EN_WDT2_MASK				(1 << 5)
 #define OMAP3430_EN_WDT2_SHIFT				5
 
 /* CM_ICLKEN_CAM, CM_FCLKEN_CAM shared bits */
-#define OMAP3430_EN_CAM					(1 << 0)
+#define OMAP3430_EN_CAM_MASK				(1 << 0)
 #define OMAP3430_EN_CAM_SHIFT				0
 
 /* CM_FCLKEN_PER, CM_ICLKEN_PER shared bits */
-#define OMAP3430_EN_WDT3				(1 << 12)
+#define OMAP3430_EN_WDT3_MASK				(1 << 12)
 #define OMAP3430_EN_WDT3_SHIFT				12
 
 /* CM_CLKSEL2_EMU, CM_CLKSEL3_EMU shared bits */
-#define OMAP3430_OVERRIDE_ENABLE			(1 << 19)
+#define OMAP3430_OVERRIDE_ENABLE_MASK			(1 << 19)
 
 
 /* Bits specific to each register */
@@ -69,7 +69,7 @@
 #define OMAP3430_EN_IVA2_DPLL_MASK			(0x7 << 0)
 
 /* CM_IDLEST_IVA2 */
-#define OMAP3430_ST_IVA2				(1 << 0)
+#define OMAP3430_ST_IVA2_MASK				(1 << 0)
 
 /* CM_IDLEST_PLL_IVA2 */
 #define OMAP3430_ST_IVA2_CLK_SHIFT			0
@@ -114,7 +114,7 @@
 #define OMAP3430_EN_MPU_DPLL_MASK			(0x7 << 0)
 
 /* CM_IDLEST_MPU */
-#define OMAP3430_ST_MPU					(1 << 0)
+#define OMAP3430_ST_MPU_MASK				(1 << 0)
 
 /* CM_IDLEST_PLL_MPU */
 #define OMAP3430_ST_MPU_CLK_SHIFT			0
@@ -145,50 +145,50 @@
 #define OMAP3430_CLKACTIVITY_MPU_MASK			(1 << 0)
 
 /* CM_FCLKEN1_CORE specific bits */
-#define OMAP3430_EN_MODEM				(1 << 31)
+#define OMAP3430_EN_MODEM_MASK				(1 << 31)
 #define OMAP3430_EN_MODEM_SHIFT				31
 
 /* CM_ICLKEN1_CORE specific bits */
-#define OMAP3430_EN_ICR					(1 << 29)
+#define OMAP3430_EN_ICR_MASK				(1 << 29)
 #define OMAP3430_EN_ICR_SHIFT				29
-#define OMAP3430_EN_AES2				(1 << 28)
+#define OMAP3430_EN_AES2_MASK				(1 << 28)
 #define OMAP3430_EN_AES2_SHIFT				28
-#define OMAP3430_EN_SHA12				(1 << 27)
+#define OMAP3430_EN_SHA12_MASK				(1 << 27)
 #define OMAP3430_EN_SHA12_SHIFT				27
-#define OMAP3430_EN_DES2				(1 << 26)
+#define OMAP3430_EN_DES2_MASK				(1 << 26)
 #define OMAP3430_EN_DES2_SHIFT				26
-#define OMAP3430ES1_EN_FAC				(1 << 8)
+#define OMAP3430ES1_EN_FAC_MASK				(1 << 8)
 #define OMAP3430ES1_EN_FAC_SHIFT			8
-#define OMAP3430_EN_MAILBOXES				(1 << 7)
+#define OMAP3430_EN_MAILBOXES_MASK			(1 << 7)
 #define OMAP3430_EN_MAILBOXES_SHIFT			7
-#define OMAP3430_EN_OMAPCTRL				(1 << 6)
+#define OMAP3430_EN_OMAPCTRL_MASK			(1 << 6)
 #define OMAP3430_EN_OMAPCTRL_SHIFT			6
-#define OMAP3430_EN_SAD2D				(1 << 3)
+#define OMAP3430_EN_SAD2D_MASK				(1 << 3)
 #define OMAP3430_EN_SAD2D_SHIFT				3
-#define OMAP3430_EN_SDRC				(1 << 1)
+#define OMAP3430_EN_SDRC_MASK				(1 << 1)
 #define OMAP3430_EN_SDRC_SHIFT				1
 
 /* AM35XX specific CM_ICLKEN1_CORE bits */
 #define AM35XX_EN_IPSS_MASK				(1 << 4)
 #define AM35XX_EN_IPSS_SHIFT				4
-#define AM35XX_EN_UART4_MASK			(1 << 23)
+#define AM35XX_EN_UART4_MASK				(1 << 23)
 #define AM35XX_EN_UART4_SHIFT				23
 
 /* CM_ICLKEN2_CORE */
-#define OMAP3430_EN_PKA					(1 << 4)
+#define OMAP3430_EN_PKA_MASK				(1 << 4)
 #define OMAP3430_EN_PKA_SHIFT				4
-#define OMAP3430_EN_AES1				(1 << 3)
+#define OMAP3430_EN_AES1_MASK				(1 << 3)
 #define OMAP3430_EN_AES1_SHIFT				3
-#define OMAP3430_EN_RNG					(1 << 2)
+#define OMAP3430_EN_RNG_MASK				(1 << 2)
 #define OMAP3430_EN_RNG_SHIFT				2
-#define OMAP3430_EN_SHA11				(1 << 1)
+#define OMAP3430_EN_SHA11_MASK				(1 << 1)
 #define OMAP3430_EN_SHA11_SHIFT				1
-#define OMAP3430_EN_DES1				(1 << 0)
+#define OMAP3430_EN_DES1_MASK				(1 << 0)
 #define OMAP3430_EN_DES1_SHIFT				0
 
 /* CM_ICLKEN3_CORE */
 #define OMAP3430_EN_MAD2D_SHIFT				3
-#define OMAP3430_EN_MAD2D				(1 << 3)
+#define OMAP3430_EN_MAD2D_MASK				(1 << 3)
 
 /* CM_FCLKEN3_CORE specific bits */
 #define OMAP3430ES2_EN_TS_SHIFT				1
@@ -249,79 +249,79 @@
 #define OMAP3430ES2_ST_CPEFUSE_MASK			(1 << 0)
 
 /* CM_AUTOIDLE1_CORE */
-#define OMAP3430_AUTO_MODEM				(1 << 31)
+#define OMAP3430_AUTO_MODEM_MASK			(1 << 31)
 #define OMAP3430_AUTO_MODEM_SHIFT			31
-#define OMAP3430ES2_AUTO_MMC3				(1 << 30)
+#define OMAP3430ES2_AUTO_MMC3_MASK			(1 << 30)
 #define OMAP3430ES2_AUTO_MMC3_SHIFT			30
-#define OMAP3430ES2_AUTO_ICR				(1 << 29)
+#define OMAP3430ES2_AUTO_ICR_MASK			(1 << 29)
 #define OMAP3430ES2_AUTO_ICR_SHIFT			29
-#define OMAP3430_AUTO_AES2				(1 << 28)
+#define OMAP3430_AUTO_AES2_MASK				(1 << 28)
 #define OMAP3430_AUTO_AES2_SHIFT			28
-#define OMAP3430_AUTO_SHA12				(1 << 27)
+#define OMAP3430_AUTO_SHA12_MASK			(1 << 27)
 #define OMAP3430_AUTO_SHA12_SHIFT			27
-#define OMAP3430_AUTO_DES2				(1 << 26)
+#define OMAP3430_AUTO_DES2_MASK				(1 << 26)
 #define OMAP3430_AUTO_DES2_SHIFT			26
-#define OMAP3430_AUTO_MMC2				(1 << 25)
+#define OMAP3430_AUTO_MMC2_MASK				(1 << 25)
 #define OMAP3430_AUTO_MMC2_SHIFT			25
-#define OMAP3430_AUTO_MMC1				(1 << 24)
+#define OMAP3430_AUTO_MMC1_MASK				(1 << 24)
 #define OMAP3430_AUTO_MMC1_SHIFT			24
-#define OMAP3430_AUTO_MSPRO				(1 << 23)
+#define OMAP3430_AUTO_MSPRO_MASK			(1 << 23)
 #define OMAP3430_AUTO_MSPRO_SHIFT			23
-#define OMAP3430_AUTO_HDQ				(1 << 22)
+#define OMAP3430_AUTO_HDQ_MASK				(1 << 22)
 #define OMAP3430_AUTO_HDQ_SHIFT				22
-#define OMAP3430_AUTO_MCSPI4				(1 << 21)
+#define OMAP3430_AUTO_MCSPI4_MASK			(1 << 21)
 #define OMAP3430_AUTO_MCSPI4_SHIFT			21
-#define OMAP3430_AUTO_MCSPI3				(1 << 20)
+#define OMAP3430_AUTO_MCSPI3_MASK			(1 << 20)
 #define OMAP3430_AUTO_MCSPI3_SHIFT			20
-#define OMAP3430_AUTO_MCSPI2				(1 << 19)
+#define OMAP3430_AUTO_MCSPI2_MASK			(1 << 19)
 #define OMAP3430_AUTO_MCSPI2_SHIFT			19
-#define OMAP3430_AUTO_MCSPI1				(1 << 18)
+#define OMAP3430_AUTO_MCSPI1_MASK			(1 << 18)
 #define OMAP3430_AUTO_MCSPI1_SHIFT			18
-#define OMAP3430_AUTO_I2C3				(1 << 17)
+#define OMAP3430_AUTO_I2C3_MASK				(1 << 17)
 #define OMAP3430_AUTO_I2C3_SHIFT			17
-#define OMAP3430_AUTO_I2C2				(1 << 16)
+#define OMAP3430_AUTO_I2C2_MASK				(1 << 16)
 #define OMAP3430_AUTO_I2C2_SHIFT			16
-#define OMAP3430_AUTO_I2C1				(1 << 15)
+#define OMAP3430_AUTO_I2C1_MASK				(1 << 15)
 #define OMAP3430_AUTO_I2C1_SHIFT			15
-#define OMAP3430_AUTO_UART2				(1 << 14)
+#define OMAP3430_AUTO_UART2_MASK			(1 << 14)
 #define OMAP3430_AUTO_UART2_SHIFT			14
-#define OMAP3430_AUTO_UART1				(1 << 13)
+#define OMAP3430_AUTO_UART1_MASK			(1 << 13)
 #define OMAP3430_AUTO_UART1_SHIFT			13
-#define OMAP3430_AUTO_GPT11				(1 << 12)
+#define OMAP3430_AUTO_GPT11_MASK			(1 << 12)
 #define OMAP3430_AUTO_GPT11_SHIFT			12
-#define OMAP3430_AUTO_GPT10				(1 << 11)
+#define OMAP3430_AUTO_GPT10_MASK			(1 << 11)
 #define OMAP3430_AUTO_GPT10_SHIFT			11
-#define OMAP3430_AUTO_MCBSP5				(1 << 10)
+#define OMAP3430_AUTO_MCBSP5_MASK			(1 << 10)
 #define OMAP3430_AUTO_MCBSP5_SHIFT			10
-#define OMAP3430_AUTO_MCBSP1				(1 << 9)
+#define OMAP3430_AUTO_MCBSP1_MASK			(1 << 9)
 #define OMAP3430_AUTO_MCBSP1_SHIFT			9
-#define OMAP3430ES1_AUTO_FAC				(1 << 8)
+#define OMAP3430ES1_AUTO_FAC_MASK			(1 << 8)
 #define OMAP3430ES1_AUTO_FAC_SHIFT			8
-#define OMAP3430_AUTO_MAILBOXES				(1 << 7)
+#define OMAP3430_AUTO_MAILBOXES_MASK			(1 << 7)
 #define OMAP3430_AUTO_MAILBOXES_SHIFT			7
-#define OMAP3430_AUTO_OMAPCTRL				(1 << 6)
+#define OMAP3430_AUTO_OMAPCTRL_MASK			(1 << 6)
 #define OMAP3430_AUTO_OMAPCTRL_SHIFT			6
-#define OMAP3430ES1_AUTO_FSHOSTUSB			(1 << 5)
+#define OMAP3430ES1_AUTO_FSHOSTUSB_MASK			(1 << 5)
 #define OMAP3430ES1_AUTO_FSHOSTUSB_SHIFT		5
-#define OMAP3430_AUTO_HSOTGUSB				(1 << 4)
+#define OMAP3430_AUTO_HSOTGUSB_MASK			(1 << 4)
 #define OMAP3430_AUTO_HSOTGUSB_SHIFT			4
-#define OMAP3430ES1_AUTO_D2D				(1 << 3)
+#define OMAP3430ES1_AUTO_D2D_MASK			(1 << 3)
 #define OMAP3430ES1_AUTO_D2D_SHIFT			3
-#define OMAP3430_AUTO_SAD2D				(1 << 3)
+#define OMAP3430_AUTO_SAD2D_MASK			(1 << 3)
 #define OMAP3430_AUTO_SAD2D_SHIFT			3
-#define OMAP3430_AUTO_SSI				(1 << 0)
+#define OMAP3430_AUTO_SSI_MASK				(1 << 0)
 #define OMAP3430_AUTO_SSI_SHIFT				0
 
 /* CM_AUTOIDLE2_CORE */
-#define OMAP3430_AUTO_PKA				(1 << 4)
+#define OMAP3430_AUTO_PKA_MASK				(1 << 4)
 #define OMAP3430_AUTO_PKA_SHIFT				4
-#define OMAP3430_AUTO_AES1				(1 << 3)
+#define OMAP3430_AUTO_AES1_MASK				(1 << 3)
 #define OMAP3430_AUTO_AES1_SHIFT			3
-#define OMAP3430_AUTO_RNG				(1 << 2)
+#define OMAP3430_AUTO_RNG_MASK				(1 << 2)
 #define OMAP3430_AUTO_RNG_SHIFT				2
-#define OMAP3430_AUTO_SHA11				(1 << 1)
+#define OMAP3430_AUTO_SHA11_MASK			(1 << 1)
 #define OMAP3430_AUTO_SHA11_SHIFT			1
-#define OMAP3430_AUTO_DES1				(1 << 0)
+#define OMAP3430_AUTO_DES1_MASK				(1 << 0)
 #define OMAP3430_AUTO_DES1_SHIFT			0
 
 /* CM_AUTOIDLE3_CORE */
@@ -331,7 +331,7 @@
 #define OMAP3430ES2_AUTO_USBTLL_SHIFT			2
 #define OMAP3430ES2_AUTO_USBTLL_MASK			(1 << 2)
 #define OMAP3430_AUTO_MAD2D_SHIFT			3
-#define OMAP3430_AUTO_MAD2D				(1 << 3)
+#define OMAP3430_AUTO_MAD2D_MASK			(1 << 3)
 
 /* CM_CLKSEL_CORE */
 #define OMAP3430_CLKSEL_SSI_SHIFT			8
@@ -366,9 +366,9 @@
 #define OMAP3430_CLKACTIVITY_L3_MASK			(1 << 0)
 
 /* CM_FCLKEN_GFX */
-#define OMAP3430ES1_EN_3D				(1 << 2)
+#define OMAP3430ES1_EN_3D_MASK				(1 << 2)
 #define OMAP3430ES1_EN_3D_SHIFT				2
-#define OMAP3430ES1_EN_2D				(1 << 1)
+#define OMAP3430ES1_EN_2D_MASK				(1 << 1)
 #define OMAP3430ES1_EN_2D_SHIFT				1
 
 /* CM_ICLKEN_GFX specific bits */
@@ -416,9 +416,9 @@
 #define OMAP3430ES2_EN_USIMOCP_MASK			(1 << 9)
 
 /* CM_ICLKEN_WKUP specific bits */
-#define OMAP3430_EN_WDT1				(1 << 4)
+#define OMAP3430_EN_WDT1_MASK				(1 << 4)
 #define OMAP3430_EN_WDT1_SHIFT				4
-#define OMAP3430_EN_32KSYNC				(1 << 2)
+#define OMAP3430_EN_32KSYNC_MASK			(1 << 2)
 #define OMAP3430_EN_32KSYNC_SHIFT			2
 
 /* CM_IDLEST_WKUP specific bits */
@@ -432,19 +432,19 @@
 #define OMAP3430_ST_32KSYNC_MASK			(1 << 2)
 
 /* CM_AUTOIDLE_WKUP */
-#define OMAP3430ES2_AUTO_USIMOCP				(1 << 9)
+#define OMAP3430ES2_AUTO_USIMOCP_MASK			(1 << 9)
 #define OMAP3430ES2_AUTO_USIMOCP_SHIFT			9
-#define OMAP3430_AUTO_WDT2				(1 << 5)
+#define OMAP3430_AUTO_WDT2_MASK				(1 << 5)
 #define OMAP3430_AUTO_WDT2_SHIFT			5
-#define OMAP3430_AUTO_WDT1				(1 << 4)
+#define OMAP3430_AUTO_WDT1_MASK				(1 << 4)
 #define OMAP3430_AUTO_WDT1_SHIFT			4
-#define OMAP3430_AUTO_GPIO1				(1 << 3)
+#define OMAP3430_AUTO_GPIO1_MASK			(1 << 3)
 #define OMAP3430_AUTO_GPIO1_SHIFT			3
-#define OMAP3430_AUTO_32KSYNC				(1 << 2)
+#define OMAP3430_AUTO_32KSYNC_MASK			(1 << 2)
 #define OMAP3430_AUTO_32KSYNC_SHIFT			2
-#define OMAP3430_AUTO_GPT12				(1 << 1)
+#define OMAP3430_AUTO_GPT12_MASK			(1 << 1)
 #define OMAP3430_AUTO_GPT12_SHIFT			1
-#define OMAP3430_AUTO_GPT1				(1 << 0)
+#define OMAP3430_AUTO_GPT1_MASK				(1 << 0)
 #define OMAP3430_AUTO_GPT1_SHIFT			0
 
 /* CM_CLKSEL_WKUP */
@@ -479,7 +479,7 @@
 #define OMAP3430_EN_CORE_DPLL_MASK			(0x7 << 0)
 
 /* CM_CLKEN2_PLL */
-#define OMAP3430ES2_EN_PERIPH2_DPLL_LPMODE_SHIFT		10
+#define OMAP3430ES2_EN_PERIPH2_DPLL_LPMODE_SHIFT	10
 #define OMAP3430ES2_PERIPH2_DPLL_RAMPTIME_MASK		(0x3 << 8)
 #define OMAP3430ES2_PERIPH2_DPLL_FREQSEL_SHIFT		4
 #define OMAP3430ES2_PERIPH2_DPLL_FREQSEL_MASK		(0xf << 4)
@@ -488,10 +488,10 @@
 #define OMAP3430ES2_EN_PERIPH2_DPLL_MASK		(0x7 << 0)
 
 /* CM_IDLEST_CKGEN */
-#define OMAP3430_ST_54M_CLK				(1 << 5)
-#define OMAP3430_ST_12M_CLK				(1 << 4)
-#define OMAP3430_ST_48M_CLK				(1 << 3)
-#define OMAP3430_ST_96M_CLK				(1 << 2)
+#define OMAP3430_ST_54M_CLK_MASK			(1 << 5)
+#define OMAP3430_ST_12M_CLK_MASK			(1 << 4)
+#define OMAP3430_ST_48M_CLK_MASK			(1 << 3)
+#define OMAP3430_ST_96M_CLK_MASK			(1 << 2)
 #define OMAP3430_ST_PERIPH_CLK_SHIFT			1
 #define OMAP3430_ST_PERIPH_CLK_MASK			(1 << 1)
 #define OMAP3430_ST_CORE_CLK_SHIFT			0
@@ -558,22 +558,22 @@
 
 /* CM_CLKOUT_CTRL */
 #define OMAP3430_CLKOUT2_EN_SHIFT			7
-#define OMAP3430_CLKOUT2_EN				(1 << 7)
+#define OMAP3430_CLKOUT2_EN_MASK			(1 << 7)
 #define OMAP3430_CLKOUT2_DIV_SHIFT			3
 #define OMAP3430_CLKOUT2_DIV_MASK			(0x7 << 3)
 #define OMAP3430_CLKOUT2SOURCE_SHIFT			0
 #define OMAP3430_CLKOUT2SOURCE_MASK			(0x3 << 0)
 
 /* CM_FCLKEN_DSS */
-#define OMAP3430_EN_TV					(1 << 2)
+#define OMAP3430_EN_TV_MASK				(1 << 2)
 #define OMAP3430_EN_TV_SHIFT				2
-#define OMAP3430_EN_DSS2				(1 << 1)
+#define OMAP3430_EN_DSS2_MASK				(1 << 1)
 #define OMAP3430_EN_DSS2_SHIFT				1
-#define OMAP3430_EN_DSS1				(1 << 0)
+#define OMAP3430_EN_DSS1_MASK				(1 << 0)
 #define OMAP3430_EN_DSS1_SHIFT				0
 
 /* CM_ICLKEN_DSS */
-#define OMAP3430_CM_ICLKEN_DSS_EN_DSS			(1 << 0)
+#define OMAP3430_CM_ICLKEN_DSS_EN_DSS_MASK		(1 << 0)
 #define OMAP3430_CM_ICLKEN_DSS_EN_DSS_SHIFT		0
 
 /* CM_IDLEST_DSS */
@@ -585,7 +585,7 @@
 #define OMAP3430ES1_ST_DSS_MASK				(1 << 0)
 
 /* CM_AUTOIDLE_DSS */
-#define OMAP3430_AUTO_DSS				(1 << 0)
+#define OMAP3430_AUTO_DSS_MASK				(1 << 0)
 #define OMAP3430_AUTO_DSS_SHIFT				0
 
 /* CM_CLKSEL_DSS */
@@ -607,16 +607,16 @@
 #define OMAP3430_CLKACTIVITY_DSS_MASK			(1 << 0)
 
 /* CM_FCLKEN_CAM specific bits */
-#define OMAP3430_EN_CSI2				(1 << 1)
+#define OMAP3430_EN_CSI2_MASK				(1 << 1)
 #define OMAP3430_EN_CSI2_SHIFT				1
 
 /* CM_ICLKEN_CAM specific bits */
 
 /* CM_IDLEST_CAM */
-#define OMAP3430_ST_CAM					(1 << 0)
+#define OMAP3430_ST_CAM_MASK				(1 << 0)
 
 /* CM_AUTOIDLE_CAM */
-#define OMAP3430_AUTO_CAM				(1 << 0)
+#define OMAP3430_AUTO_CAM_MASK				(1 << 0)
 #define OMAP3430_AUTO_CAM_SHIFT				0
 
 /* CM_CLKSEL_CAM */
@@ -649,41 +649,41 @@
 #define OMAP3430_ST_MCBSP2_MASK				(1 << 0)
 
 /* CM_AUTOIDLE_PER */
-#define OMAP3430_AUTO_GPIO6				(1 << 17)
+#define OMAP3430_AUTO_GPIO6_MASK			(1 << 17)
 #define OMAP3430_AUTO_GPIO6_SHIFT			17
-#define OMAP3430_AUTO_GPIO5				(1 << 16)
+#define OMAP3430_AUTO_GPIO5_MASK			(1 << 16)
 #define OMAP3430_AUTO_GPIO5_SHIFT			16
-#define OMAP3430_AUTO_GPIO4				(1 << 15)
+#define OMAP3430_AUTO_GPIO4_MASK			(1 << 15)
 #define OMAP3430_AUTO_GPIO4_SHIFT			15
-#define OMAP3430_AUTO_GPIO3				(1 << 14)
+#define OMAP3430_AUTO_GPIO3_MASK			(1 << 14)
 #define OMAP3430_AUTO_GPIO3_SHIFT			14
-#define OMAP3430_AUTO_GPIO2				(1 << 13)
+#define OMAP3430_AUTO_GPIO2_MASK			(1 << 13)
 #define OMAP3430_AUTO_GPIO2_SHIFT			13
-#define OMAP3430_AUTO_WDT3				(1 << 12)
+#define OMAP3430_AUTO_WDT3_MASK				(1 << 12)
 #define OMAP3430_AUTO_WDT3_SHIFT			12
-#define OMAP3430_AUTO_UART3				(1 << 11)
+#define OMAP3430_AUTO_UART3_MASK			(1 << 11)
 #define OMAP3430_AUTO_UART3_SHIFT			11
-#define OMAP3430_AUTO_GPT9				(1 << 10)
+#define OMAP3430_AUTO_GPT9_MASK				(1 << 10)
 #define OMAP3430_AUTO_GPT9_SHIFT			10
-#define OMAP3430_AUTO_GPT8				(1 << 9)
+#define OMAP3430_AUTO_GPT8_MASK				(1 << 9)
 #define OMAP3430_AUTO_GPT8_SHIFT			9
-#define OMAP3430_AUTO_GPT7				(1 << 8)
+#define OMAP3430_AUTO_GPT7_MASK				(1 << 8)
 #define OMAP3430_AUTO_GPT7_SHIFT			8
-#define OMAP3430_AUTO_GPT6				(1 << 7)
+#define OMAP3430_AUTO_GPT6_MASK				(1 << 7)
 #define OMAP3430_AUTO_GPT6_SHIFT			7
-#define OMAP3430_AUTO_GPT5				(1 << 6)
+#define OMAP3430_AUTO_GPT5_MASK				(1 << 6)
 #define OMAP3430_AUTO_GPT5_SHIFT			6
-#define OMAP3430_AUTO_GPT4				(1 << 5)
+#define OMAP3430_AUTO_GPT4_MASK				(1 << 5)
 #define OMAP3430_AUTO_GPT4_SHIFT			5
-#define OMAP3430_AUTO_GPT3				(1 << 4)
+#define OMAP3430_AUTO_GPT3_MASK				(1 << 4)
 #define OMAP3430_AUTO_GPT3_SHIFT			4
-#define OMAP3430_AUTO_GPT2				(1 << 3)
+#define OMAP3430_AUTO_GPT2_MASK				(1 << 3)
 #define OMAP3430_AUTO_GPT2_SHIFT			3
-#define OMAP3430_AUTO_MCBSP4				(1 << 2)
+#define OMAP3430_AUTO_MCBSP4_MASK			(1 << 2)
 #define OMAP3430_AUTO_MCBSP4_SHIFT			2
-#define OMAP3430_AUTO_MCBSP3				(1 << 1)
+#define OMAP3430_AUTO_MCBSP3_MASK			(1 << 1)
 #define OMAP3430_AUTO_MCBSP3_SHIFT			1
-#define OMAP3430_AUTO_MCBSP2				(1 << 0)
+#define OMAP3430_AUTO_MCBSP2_MASK			(1 << 0)
 #define OMAP3430_AUTO_MCBSP2_SHIFT			0
 
 /* CM_CLKSEL_PER */
@@ -705,7 +705,7 @@
 #define OMAP3430_CLKSEL_GPT2_SHIFT			0
 
 /* CM_SLEEPDEP_PER specific bits */
-#define OMAP3430_CM_SLEEPDEP_PER_EN_IVA2		(1 << 2)
+#define OMAP3430_CM_SLEEPDEP_PER_EN_IVA2_MASK		(1 << 2)
 
 /* CM_CLKSTCTRL_PER */
 #define OMAP3430_CLKTRCTRL_PER_SHIFT			0
@@ -755,10 +755,10 @@
 #define OMAP3430_PERIPH_DPLL_EMU_DIV_MASK		(0x7f << 0)
 
 /* CM_POLCTRL */
-#define OMAP3430_CLKOUT2_POL				(1 << 0)
+#define OMAP3430_CLKOUT2_POL_MASK			(1 << 0)
 
 /* CM_IDLEST_NEON */
-#define OMAP3430_ST_NEON				(1 << 0)
+#define OMAP3430_ST_NEON_MASK				(1 << 0)
 
 /* CM_CLKSTCTRL_NEON */
 #define OMAP3430_CLKTRCTRL_NEON_SHIFT			0
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 43f8a33..a8d20ee 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -194,11 +194,12 @@ void omap3_clear_scratchpad_contents(void)
 	u32 offset = 0;
 	v_addr = OMAP2_L4_IO_ADDRESS(OMAP343X_SCRATCHPAD_ROM);
 	if (prm_read_mod_reg(OMAP3430_GR_MOD, OMAP3_PRM_RSTST_OFFSET) &
-		OMAP3430_GLOBAL_COLD_RST) {
+	    OMAP3430_GLOBAL_COLD_RST_MASK) {
 		for ( ; offset <= max_offset; offset += 0x4)
 			__raw_writel(0x0, (v_addr + offset));
-		prm_set_mod_reg_bits(OMAP3430_GLOBAL_COLD_RST, OMAP3430_GR_MOD,
-			OMAP3_PRM_RSTST_OFFSET);
+		prm_set_mod_reg_bits(OMAP3430_GLOBAL_COLD_RST_MASK,
+				     OMAP3430_GR_MOD,
+				     OMAP3_PRM_RSTST_OFFSET);
 	}
 }
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index fee2efb..b5ea831 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -92,19 +92,20 @@ static void omap3_enable_io_chain(void)
 	int timeout = 0;
 
 	if (omap_rev() >= OMAP3430_REV_ES3_1) {
-		prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN, WKUP_MOD, PM_WKEN);
+		prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
+				     PM_WKEN);
 		/* Do a readback to assure write has been done */
 		prm_read_mod_reg(WKUP_MOD, PM_WKEN);
 
 		while (!(prm_read_mod_reg(WKUP_MOD, PM_WKST) &
-			 OMAP3430_ST_IO_CHAIN)) {
+			 OMAP3430_ST_IO_CHAIN_MASK)) {
 			timeout++;
 			if (timeout > 1000) {
 				printk(KERN_ERR "Wake up daisy chain "
 				       "activation failed.\n");
 				return;
 			}
-			prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN,
+			prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN_MASK,
 					     WKUP_MOD, PM_WKST);
 		}
 	}
@@ -113,7 +114,8 @@ static void omap3_enable_io_chain(void)
 static void omap3_disable_io_chain(void)
 {
 	if (omap_rev() >= OMAP3430_REV_ES3_1)
-		prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN, WKUP_MOD, PM_WKEN);
+		prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
+				       PM_WKEN);
 }
 
 static void omap3_core_save_context(void)
@@ -273,7 +275,8 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 		irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
 					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
 
-		if (irqstatus_mpu & (OMAP3430_WKUP_ST | OMAP3430_IO_ST)) {
+		if (irqstatus_mpu & (OMAP3430_WKUP_ST_MASK |
+				     OMAP3430_IO_ST_MASK)) {
 			c = _prcm_int_handle_wakeup();
 
 			/*
@@ -398,7 +401,7 @@ void omap_sram_idle(void)
 			omap3_prcm_save_context();
 		}
 		/* Enable IO-PAD and IO-CHAIN wakeups */
-		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
+		prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
 		omap3_enable_io_chain();
 	}
 	omap3_intc_prepare_idle();
@@ -444,7 +447,7 @@ void omap_sram_idle(void)
 		omap_uart_resume_idle(0);
 		omap_uart_resume_idle(1);
 		if (core_next_state == PWRDM_POWER_OFF)
-			prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF,
+			prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF_MASK,
 					       OMAP3430_GR_MOD,
 					       OMAP3_PRM_VOLTCTRL_OFFSET);
 	}
@@ -463,7 +466,7 @@ void omap_sram_idle(void)
 
 	/* Disable IO-PAD and IO-CHAIN wakeup */
 	if (core_next_state < PWRDM_POWER_ON) {
-		prm_clear_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
+		prm_clear_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
 		omap3_disable_io_chain();
 	}
 
@@ -682,9 +685,9 @@ static void __init omap3_iva_idle(void)
 		return;
 
 	/* Reset IVA2 */
-	prm_write_mod_reg(OMAP3430_RST1_IVA2 |
-			  OMAP3430_RST2_IVA2 |
-			  OMAP3430_RST3_IVA2,
+	prm_write_mod_reg(OMAP3430_RST1_IVA2_MASK |
+			  OMAP3430_RST2_IVA2_MASK |
+			  OMAP3430_RST3_IVA2_MASK,
 			  OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
 
 	/* Enable IVA2 clock */
@@ -702,9 +705,9 @@ static void __init omap3_iva_idle(void)
 	cm_write_mod_reg(0, OMAP3430_IVA2_MOD, CM_FCLKEN);
 
 	/* Reset IVA2 */
-	prm_write_mod_reg(OMAP3430_RST1_IVA2 |
-			  OMAP3430_RST2_IVA2 |
-			  OMAP3430_RST3_IVA2,
+	prm_write_mod_reg(OMAP3430_RST1_IVA2_MASK |
+			  OMAP3430_RST2_IVA2_MASK |
+			  OMAP3430_RST3_IVA2_MASK,
 			  OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
 }
 
@@ -726,8 +729,8 @@ static void __init omap3_d2d_idle(void)
 	omap_ctrl_writew(padconf, OMAP3_PADCONF_SAD2D_IDLEACK);
 
 	/* reset modem */
-	prm_write_mod_reg(OMAP3430_RM_RSTCTRL_CORE_MODEM_SW_RSTPWRON |
-			  OMAP3430_RM_RSTCTRL_CORE_MODEM_SW_RST,
+	prm_write_mod_reg(OMAP3430_RM_RSTCTRL_CORE_MODEM_SW_RSTPWRON_MASK |
+			  OMAP3430_RM_RSTCTRL_CORE_MODEM_SW_RST_MASK,
 			  CORE_MOD, OMAP2_RM_RSTCTRL);
 	prm_write_mod_reg(0, CORE_MOD, OMAP2_RM_RSTCTRL);
 }
@@ -753,97 +756,97 @@ static void __init prcm_setup_regs(void)
 	 * Note that in the long run this should be done by clockfw
 	 */
 	cm_write_mod_reg(
-		OMAP3430_AUTO_MODEM |
-		OMAP3430ES2_AUTO_MMC3 |
-		OMAP3430ES2_AUTO_ICR |
-		OMAP3430_AUTO_AES2 |
-		OMAP3430_AUTO_SHA12 |
-		OMAP3430_AUTO_DES2 |
-		OMAP3430_AUTO_MMC2 |
-		OMAP3430_AUTO_MMC1 |
-		OMAP3430_AUTO_MSPRO |
-		OMAP3430_AUTO_HDQ |
-		OMAP3430_AUTO_MCSPI4 |
-		OMAP3430_AUTO_MCSPI3 |
-		OMAP3430_AUTO_MCSPI2 |
-		OMAP3430_AUTO_MCSPI1 |
-		OMAP3430_AUTO_I2C3 |
-		OMAP3430_AUTO_I2C2 |
-		OMAP3430_AUTO_I2C1 |
-		OMAP3430_AUTO_UART2 |
-		OMAP3430_AUTO_UART1 |
-		OMAP3430_AUTO_GPT11 |
-		OMAP3430_AUTO_GPT10 |
-		OMAP3430_AUTO_MCBSP5 |
-		OMAP3430_AUTO_MCBSP1 |
-		OMAP3430ES1_AUTO_FAC | /* This is es1 only */
-		OMAP3430_AUTO_MAILBOXES |
-		OMAP3430_AUTO_OMAPCTRL |
-		OMAP3430ES1_AUTO_FSHOSTUSB |
-		OMAP3430_AUTO_HSOTGUSB |
-		OMAP3430_AUTO_SAD2D |
-		OMAP3430_AUTO_SSI,
+		OMAP3430_AUTO_MODEM_MASK |
+		OMAP3430ES2_AUTO_MMC3_MASK |
+		OMAP3430ES2_AUTO_ICR_MASK |
+		OMAP3430_AUTO_AES2_MASK |
+		OMAP3430_AUTO_SHA12_MASK |
+		OMAP3430_AUTO_DES2_MASK |
+		OMAP3430_AUTO_MMC2_MASK |
+		OMAP3430_AUTO_MMC1_MASK |
+		OMAP3430_AUTO_MSPRO_MASK |
+		OMAP3430_AUTO_HDQ_MASK |
+		OMAP3430_AUTO_MCSPI4_MASK |
+		OMAP3430_AUTO_MCSPI3_MASK |
+		OMAP3430_AUTO_MCSPI2_MASK |
+		OMAP3430_AUTO_MCSPI1_MASK |
+		OMAP3430_AUTO_I2C3_MASK |
+		OMAP3430_AUTO_I2C2_MASK |
+		OMAP3430_AUTO_I2C1_MASK |
+		OMAP3430_AUTO_UART2_MASK |
+		OMAP3430_AUTO_UART1_MASK |
+		OMAP3430_AUTO_GPT11_MASK |
+		OMAP3430_AUTO_GPT10_MASK |
+		OMAP3430_AUTO_MCBSP5_MASK |
+		OMAP3430_AUTO_MCBSP1_MASK |
+		OMAP3430ES1_AUTO_FAC_MASK | /* This is es1 only */
+		OMAP3430_AUTO_MAILBOXES_MASK |
+		OMAP3430_AUTO_OMAPCTRL_MASK |
+		OMAP3430ES1_AUTO_FSHOSTUSB_MASK |
+		OMAP3430_AUTO_HSOTGUSB_MASK |
+		OMAP3430_AUTO_SAD2D_MASK |
+		OMAP3430_AUTO_SSI_MASK,
 		CORE_MOD, CM_AUTOIDLE1);
 
 	cm_write_mod_reg(
-		OMAP3430_AUTO_PKA |
-		OMAP3430_AUTO_AES1 |
-		OMAP3430_AUTO_RNG |
-		OMAP3430_AUTO_SHA11 |
-		OMAP3430_AUTO_DES1,
+		OMAP3430_AUTO_PKA_MASK |
+		OMAP3430_AUTO_AES1_MASK |
+		OMAP3430_AUTO_RNG_MASK |
+		OMAP3430_AUTO_SHA11_MASK |
+		OMAP3430_AUTO_DES1_MASK,
 		CORE_MOD, CM_AUTOIDLE2);
 
 	if (omap_rev() > OMAP3430_REV_ES1_0) {
 		cm_write_mod_reg(
-			OMAP3430_AUTO_MAD2D |
-			OMAP3430ES2_AUTO_USBTLL,
+			OMAP3430_AUTO_MAD2D_MASK |
+			OMAP3430ES2_AUTO_USBTLL_MASK,
 			CORE_MOD, CM_AUTOIDLE3);
 	}
 
 	cm_write_mod_reg(
-		OMAP3430_AUTO_WDT2 |
-		OMAP3430_AUTO_WDT1 |
-		OMAP3430_AUTO_GPIO1 |
-		OMAP3430_AUTO_32KSYNC |
-		OMAP3430_AUTO_GPT12 |
-		OMAP3430_AUTO_GPT1 ,
+		OMAP3430_AUTO_WDT2_MASK |
+		OMAP3430_AUTO_WDT1_MASK |
+		OMAP3430_AUTO_GPIO1_MASK |
+		OMAP3430_AUTO_32KSYNC_MASK |
+		OMAP3430_AUTO_GPT12_MASK |
+		OMAP3430_AUTO_GPT1_MASK,
 		WKUP_MOD, CM_AUTOIDLE);
 
 	cm_write_mod_reg(
-		OMAP3430_AUTO_DSS,
+		OMAP3430_AUTO_DSS_MASK,
 		OMAP3430_DSS_MOD,
 		CM_AUTOIDLE);
 
 	cm_write_mod_reg(
-		OMAP3430_AUTO_CAM,
+		OMAP3430_AUTO_CAM_MASK,
 		OMAP3430_CAM_MOD,
 		CM_AUTOIDLE);
 
 	cm_write_mod_reg(
-		OMAP3430_AUTO_GPIO6 |
-		OMAP3430_AUTO_GPIO5 |
-		OMAP3430_AUTO_GPIO4 |
-		OMAP3430_AUTO_GPIO3 |
-		OMAP3430_AUTO_GPIO2 |
-		OMAP3430_AUTO_WDT3 |
-		OMAP3430_AUTO_UART3 |
-		OMAP3430_AUTO_GPT9 |
-		OMAP3430_AUTO_GPT8 |
-		OMAP3430_AUTO_GPT7 |
-		OMAP3430_AUTO_GPT6 |
-		OMAP3430_AUTO_GPT5 |
-		OMAP3430_AUTO_GPT4 |
-		OMAP3430_AUTO_GPT3 |
-		OMAP3430_AUTO_GPT2 |
-		OMAP3430_AUTO_MCBSP4 |
-		OMAP3430_AUTO_MCBSP3 |
-		OMAP3430_AUTO_MCBSP2,
+		OMAP3430_AUTO_GPIO6_MASK |
+		OMAP3430_AUTO_GPIO5_MASK |
+		OMAP3430_AUTO_GPIO4_MASK |
+		OMAP3430_AUTO_GPIO3_MASK |
+		OMAP3430_AUTO_GPIO2_MASK |
+		OMAP3430_AUTO_WDT3_MASK |
+		OMAP3430_AUTO_UART3_MASK |
+		OMAP3430_AUTO_GPT9_MASK |
+		OMAP3430_AUTO_GPT8_MASK |
+		OMAP3430_AUTO_GPT7_MASK |
+		OMAP3430_AUTO_GPT6_MASK |
+		OMAP3430_AUTO_GPT5_MASK |
+		OMAP3430_AUTO_GPT4_MASK |
+		OMAP3430_AUTO_GPT3_MASK |
+		OMAP3430_AUTO_GPT2_MASK |
+		OMAP3430_AUTO_MCBSP4_MASK |
+		OMAP3430_AUTO_MCBSP3_MASK |
+		OMAP3430_AUTO_MCBSP2_MASK,
 		OMAP3430_PER_MOD,
 		CM_AUTOIDLE);
 
 	if (omap_rev() > OMAP3430_REV_ES1_0) {
 		cm_write_mod_reg(
-			OMAP3430ES2_AUTO_USBHOST,
+			OMAP3430ES2_AUTO_USBHOST_MASK,
 			OMAP3430ES2_USBHOST_MOD,
 			CM_AUTOIDLE);
 	}
@@ -878,7 +881,7 @@ static void __init prcm_setup_regs(void)
 			     OMAP3_PRM_CLKSRC_CTRL_OFFSET);
 
 	/* setup wakup source */
-	prm_write_mod_reg(OMAP3430_EN_IO | OMAP3430_EN_GPIO1 |
+	prm_write_mod_reg(OMAP3430_EN_IO_MASK | OMAP3430_EN_GPIO1 |
 			  OMAP3430_EN_GPT1 | OMAP3430_EN_GPT12,
 			  WKUP_MOD, PM_WKEN);
 	/* No need to write EN_IO, that is always enabled */
@@ -887,11 +890,11 @@ static void __init prcm_setup_regs(void)
 			  WKUP_MOD, OMAP3430_PM_MPUGRPSEL);
 	/* For some reason IO doesn't generate wakeup event even if
 	 * it is selected to mpu wakeup goup */
-	prm_write_mod_reg(OMAP3430_IO_EN | OMAP3430_WKUP_EN,
+	prm_write_mod_reg(OMAP3430_IO_EN_MASK | OMAP3430_WKUP_EN_MASK,
 			  OCP_MOD, OMAP3_PRM_IRQENABLE_MPU_OFFSET);
 
 	/* Enable PM_WKEN to support DSS LPR */
-	prm_write_mod_reg(OMAP3430_PM_WKEN_DSS_EN_DSS,
+	prm_write_mod_reg(OMAP3430_PM_WKEN_DSS_EN_DSS_MASK,
 				OMAP3430_DSS_MOD, PM_WKEN);
 
 	/* Enable wakeups in PER */
@@ -902,9 +905,9 @@ static void __init prcm_setup_regs(void)
 			  OMAP3430_EN_MCBSP4,
 			  OMAP3430_PER_MOD, PM_WKEN);
 	/* and allow them to wake up MPU */
-	prm_write_mod_reg(OMAP3430_GRPSEL_GPIO2 | OMAP3430_EN_GPIO3 |
-			  OMAP3430_GRPSEL_GPIO4 | OMAP3430_EN_GPIO5 |
-			  OMAP3430_GRPSEL_GPIO6 | OMAP3430_EN_UART3 |
+	prm_write_mod_reg(OMAP3430_GRPSEL_GPIO2_MASK | OMAP3430_EN_GPIO3 |
+			  OMAP3430_GRPSEL_GPIO4_MASK | OMAP3430_EN_GPIO5 |
+			  OMAP3430_GRPSEL_GPIO6_MASK | OMAP3430_EN_UART3 |
 			  OMAP3430_EN_MCBSP2 | OMAP3430_EN_MCBSP3 |
 			  OMAP3430_EN_MCBSP4,
 			  OMAP3430_PER_MOD, OMAP3430_PM_MPUGRPSEL);
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index ebfce7d..637fdfe 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -64,10 +64,10 @@ static u16 pwrstst_reg_offs;
 #define OMAP_MEM4_ONSTATE_MASK OMAP4430_OCP_NRET_BANK_ONSTATE_MASK
 
 /* OMAP3 and OMAP4 Memory Retstate Masks (common across all power domains) */
-#define OMAP_MEM0_RETSTATE_MASK OMAP3430_SHAREDL1CACHEFLATRETSTATE
-#define OMAP_MEM1_RETSTATE_MASK OMAP3430_L1FLATMEMRETSTATE
-#define OMAP_MEM2_RETSTATE_MASK OMAP3430_SHAREDL2CACHEFLATRETSTATE
-#define OMAP_MEM3_RETSTATE_MASK OMAP3430_L2FLATMEMRETSTATE
+#define OMAP_MEM0_RETSTATE_MASK OMAP3430_SHAREDL1CACHEFLATRETSTATE_MASK
+#define OMAP_MEM1_RETSTATE_MASK OMAP3430_L1FLATMEMRETSTATE_MASK
+#define OMAP_MEM2_RETSTATE_MASK OMAP3430_SHAREDL2CACHEFLATRETSTATE_MASK
+#define OMAP_MEM3_RETSTATE_MASK OMAP3430_L2FLATMEMRETSTATE_MASK
 #define OMAP_MEM4_RETSTATE_MASK OMAP4430_OCP_NRET_BANK_RETSTATE_MASK
 
 /* OMAP3 and OMAP4 Memory Status bits */
@@ -511,6 +511,8 @@ int pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
  */
 int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
 {
+	u32 v;
+
 	if (!pwrdm)
 		return -EINVAL;
 
@@ -526,9 +528,9 @@ int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
 	 * but the type of value returned is the same for each
 	 * powerdomain.
 	 */
-	prm_rmw_mod_reg_bits(OMAP3430_LOGICL1CACHERETSTATE,
-			     (pwrst << __ffs(OMAP3430_LOGICL1CACHERETSTATE)),
-				 pwrdm->prcm_offs, pwrstctrl_reg_offs);
+	v = pwrst << __ffs(OMAP3430_LOGICL1CACHERETSTATE_MASK);
+	prm_rmw_mod_reg_bits(OMAP3430_LOGICL1CACHERETSTATE_MASK, v,
+			     pwrdm->prcm_offs, pwrstctrl_reg_offs);
 
 	return 0;
 }
@@ -676,8 +678,8 @@ int pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
 	if (!pwrdm)
 		return -EINVAL;
 
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
-				 pwrstst_reg_offs, OMAP3430_LOGICSTATEST);
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs, pwrstst_reg_offs,
+				       OMAP3430_LOGICSTATEST_MASK);
 }
 
 /**
@@ -700,7 +702,7 @@ int pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm)
 	 * powerdomain.
 	 */
 	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP3430_PM_PREPWSTST,
-					OMAP3430_LASTLOGICSTATEENTERED);
+					OMAP3430_LASTLOGICSTATEENTERED_MASK);
 }
 
 /**
@@ -723,7 +725,7 @@ int pwrdm_read_logic_retst(struct powerdomain *pwrdm)
 	 * powerdomain.
 	 */
 	return prm_read_mod_bits_shift(pwrdm->prcm_offs, pwrstctrl_reg_offs,
-					OMAP3430_LOGICSTATEST);
+				       OMAP3430_LOGICSTATEST_MASK);
 }
 
 /**
diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h b/arch/arm/mach-omap2/prm-regbits-34xx.h
index 8f21bae..7fd6023 100644
--- a/arch/arm/mach-omap2/prm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
@@ -35,10 +35,10 @@
 #define OMAP3430_ERRORGAIN_MASK				(0xff << 16)
 #define OMAP3430_INITVOLTAGE_SHIFT			8
 #define OMAP3430_INITVOLTAGE_MASK			(0xff << 8)
-#define OMAP3430_TIMEOUTEN				(1 << 3)
-#define OMAP3430_INITVDD				(1 << 2)
-#define OMAP3430_FORCEUPDATE				(1 << 1)
-#define OMAP3430_VPENABLE				(1 << 0)
+#define OMAP3430_TIMEOUTEN_MASK				(1 << 3)
+#define OMAP3430_INITVDD_MASK				(1 << 2)
+#define OMAP3430_FORCEUPDATE_MASK			(1 << 1)
+#define OMAP3430_VPENABLE_MASK				(1 << 0)
 
 /* PRM_VP1_VSTEPMIN, PRM_VP2_VSTEPMIN shared bits */
 #define OMAP3430_SMPSWAITTIMEMIN_SHIFT			8
@@ -65,53 +65,53 @@
 #define OMAP3430_VPVOLTAGE_MASK				(0xff << 0)
 
 /* PRM_VP1_STATUS, PRM_VP2_STATUS shared bits */
-#define OMAP3430_VPINIDLE				(1 << 0)
+#define OMAP3430_VPINIDLE_MASK				(1 << 0)
 
 /* PM_WKDEP_IVA2, PM_WKDEP_MPU shared bits */
 #define OMAP3430_EN_PER_SHIFT				7
 #define OMAP3430_EN_PER_MASK				(1 << 7)
 
 /* PM_PWSTCTRL_IVA2, PM_PWSTCTRL_MPU, PM_PWSTCTRL_CORE shared bits */
-#define OMAP3430_MEMORYCHANGE				(1 << 3)
+#define OMAP3430_MEMORYCHANGE_MASK			(1 << 3)
 
 /* PM_PWSTST_IVA2, PM_PWSTST_CORE shared bits */
-#define OMAP3430_LOGICSTATEST				(1 << 2)
+#define OMAP3430_LOGICSTATEST_MASK			(1 << 2)
 
 /* PM_PREPWSTST_IVA2, PM_PREPWSTST_CORE shared bits */
-#define OMAP3430_LASTLOGICSTATEENTERED			(1 << 2)
+#define OMAP3430_LASTLOGICSTATEENTERED_MASK		(1 << 2)
 
 /*
  * PM_PREPWSTST_IVA2, PM_PREPWSTST_MPU, PM_PREPWSTST_CORE,
  * PM_PREPWSTST_GFX, PM_PREPWSTST_DSS, PM_PREPWSTST_CAM,
  * PM_PREPWSTST_PER, PM_PREPWSTST_NEON shared bits
  */
-#define OMAP3430_LASTPOWERSTATEENTERED_SHIFT			0
-#define OMAP3430_LASTPOWERSTATEENTERED_MASK			(0x3 << 0)
+#define OMAP3430_LASTPOWERSTATEENTERED_SHIFT		0
+#define OMAP3430_LASTPOWERSTATEENTERED_MASK		(0x3 << 0)
 
 /* PRM_IRQSTATUS_IVA2, PRM_IRQSTATUS_MPU shared bits */
-#define OMAP3430_WKUP_ST				(1 << 0)
+#define OMAP3430_WKUP_ST_MASK				(1 << 0)
 
 /* PRM_IRQENABLE_IVA2, PRM_IRQENABLE_MPU shared bits */
-#define OMAP3430_WKUP_EN					(1 << 0)
+#define OMAP3430_WKUP_EN_MASK				(1 << 0)
 
 /* PM_MPUGRPSEL1_CORE, PM_IVA2GRPSEL1_CORE shared bits */
-#define OMAP3430_GRPSEL_MMC2				(1 << 25)
-#define OMAP3430_GRPSEL_MMC1				(1 << 24)
-#define OMAP3430_GRPSEL_MCSPI4				(1 << 21)
-#define OMAP3430_GRPSEL_MCSPI3				(1 << 20)
-#define OMAP3430_GRPSEL_MCSPI2				(1 << 19)
-#define OMAP3430_GRPSEL_MCSPI1				(1 << 18)
-#define OMAP3430_GRPSEL_I2C3				(1 << 17)
-#define OMAP3430_GRPSEL_I2C2				(1 << 16)
-#define OMAP3430_GRPSEL_I2C1				(1 << 15)
-#define OMAP3430_GRPSEL_UART2				(1 << 14)
-#define OMAP3430_GRPSEL_UART1				(1 << 13)
-#define OMAP3430_GRPSEL_GPT11				(1 << 12)
-#define OMAP3430_GRPSEL_GPT10				(1 << 11)
-#define OMAP3430_GRPSEL_MCBSP5				(1 << 10)
-#define OMAP3430_GRPSEL_MCBSP1				(1 << 9)
-#define OMAP3430_GRPSEL_HSOTGUSB			(1 << 4)
-#define OMAP3430_GRPSEL_D2D				(1 << 3)
+#define OMAP3430_GRPSEL_MMC2_MASK			(1 << 25)
+#define OMAP3430_GRPSEL_MMC1_MASK			(1 << 24)
+#define OMAP3430_GRPSEL_MCSPI4_MASK			(1 << 21)
+#define OMAP3430_GRPSEL_MCSPI3_MASK			(1 << 20)
+#define OMAP3430_GRPSEL_MCSPI2_MASK			(1 << 19)
+#define OMAP3430_GRPSEL_MCSPI1_MASK			(1 << 18)
+#define OMAP3430_GRPSEL_I2C3_MASK			(1 << 17)
+#define OMAP3430_GRPSEL_I2C2_MASK			(1 << 16)
+#define OMAP3430_GRPSEL_I2C1_MASK			(1 << 15)
+#define OMAP3430_GRPSEL_UART2_MASK			(1 << 14)
+#define OMAP3430_GRPSEL_UART1_MASK			(1 << 13)
+#define OMAP3430_GRPSEL_GPT11_MASK			(1 << 12)
+#define OMAP3430_GRPSEL_GPT10_MASK			(1 << 11)
+#define OMAP3430_GRPSEL_MCBSP5_MASK			(1 << 10)
+#define OMAP3430_GRPSEL_MCBSP1_MASK			(1 << 9)
+#define OMAP3430_GRPSEL_HSOTGUSB_MASK			(1 << 4)
+#define OMAP3430_GRPSEL_D2D_MASK			(1 << 3)
 
 /*
  * PM_PWSTCTRL_GFX, PM_PWSTCTRL_DSS, PM_PWSTCTRL_CAM,
@@ -119,49 +119,49 @@
  */
 #define OMAP3430_MEMONSTATE_SHIFT			16
 #define OMAP3430_MEMONSTATE_MASK			(0x3 << 16)
-#define OMAP3430_MEMRETSTATE				(1 << 8)
+#define OMAP3430_MEMRETSTATE_MASK			(1 << 8)
 
 /* PM_MPUGRPSEL_PER, PM_IVA2GRPSEL_PER shared bits */
-#define OMAP3430_GRPSEL_GPIO6				(1 << 17)
-#define OMAP3430_GRPSEL_GPIO5				(1 << 16)
-#define OMAP3430_GRPSEL_GPIO4				(1 << 15)
-#define OMAP3430_GRPSEL_GPIO3				(1 << 14)
-#define OMAP3430_GRPSEL_GPIO2				(1 << 13)
-#define OMAP3430_GRPSEL_UART3				(1 << 11)
-#define OMAP3430_GRPSEL_GPT9				(1 << 10)
-#define OMAP3430_GRPSEL_GPT8				(1 << 9)
-#define OMAP3430_GRPSEL_GPT7				(1 << 8)
-#define OMAP3430_GRPSEL_GPT6				(1 << 7)
-#define OMAP3430_GRPSEL_GPT5				(1 << 6)
-#define OMAP3430_GRPSEL_GPT4				(1 << 5)
-#define OMAP3430_GRPSEL_GPT3				(1 << 4)
-#define OMAP3430_GRPSEL_GPT2				(1 << 3)
-#define OMAP3430_GRPSEL_MCBSP4				(1 << 2)
-#define OMAP3430_GRPSEL_MCBSP3				(1 << 1)
-#define OMAP3430_GRPSEL_MCBSP2				(1 << 0)
+#define OMAP3430_GRPSEL_GPIO6_MASK			(1 << 17)
+#define OMAP3430_GRPSEL_GPIO5_MASK			(1 << 16)
+#define OMAP3430_GRPSEL_GPIO4_MASK			(1 << 15)
+#define OMAP3430_GRPSEL_GPIO3_MASK			(1 << 14)
+#define OMAP3430_GRPSEL_GPIO2_MASK			(1 << 13)
+#define OMAP3430_GRPSEL_UART3_MASK			(1 << 11)
+#define OMAP3430_GRPSEL_GPT9_MASK			(1 << 10)
+#define OMAP3430_GRPSEL_GPT8_MASK			(1 << 9)
+#define OMAP3430_GRPSEL_GPT7_MASK			(1 << 8)
+#define OMAP3430_GRPSEL_GPT6_MASK			(1 << 7)
+#define OMAP3430_GRPSEL_GPT5_MASK			(1 << 6)
+#define OMAP3430_GRPSEL_GPT4_MASK			(1 << 5)
+#define OMAP3430_GRPSEL_GPT3_MASK			(1 << 4)
+#define OMAP3430_GRPSEL_GPT2_MASK			(1 << 3)
+#define OMAP3430_GRPSEL_MCBSP4_MASK			(1 << 2)
+#define OMAP3430_GRPSEL_MCBSP3_MASK			(1 << 1)
+#define OMAP3430_GRPSEL_MCBSP2_MASK			(1 << 0)
 
 /* PM_MPUGRPSEL_WKUP, PM_IVA2GRPSEL_WKUP shared bits */
-#define OMAP3430_GRPSEL_IO				(1 << 8)
-#define OMAP3430_GRPSEL_SR2				(1 << 7)
-#define OMAP3430_GRPSEL_SR1				(1 << 6)
-#define OMAP3430_GRPSEL_GPIO1				(1 << 3)
-#define OMAP3430_GRPSEL_GPT12				(1 << 1)
-#define OMAP3430_GRPSEL_GPT1				(1 << 0)
+#define OMAP3430_GRPSEL_IO_MASK				(1 << 8)
+#define OMAP3430_GRPSEL_SR2_MASK			(1 << 7)
+#define OMAP3430_GRPSEL_SR1_MASK			(1 << 6)
+#define OMAP3430_GRPSEL_GPIO1_MASK			(1 << 3)
+#define OMAP3430_GRPSEL_GPT12_MASK			(1 << 1)
+#define OMAP3430_GRPSEL_GPT1_MASK			(1 << 0)
 
 /* Bits specific to each register */
 
 /* RM_RSTCTRL_IVA2 */
-#define OMAP3430_RST3_IVA2				(1 << 2)
-#define OMAP3430_RST2_IVA2				(1 << 1)
-#define OMAP3430_RST1_IVA2				(1 << 0)
+#define OMAP3430_RST3_IVA2_MASK				(1 << 2)
+#define OMAP3430_RST2_IVA2_MASK				(1 << 1)
+#define OMAP3430_RST1_IVA2_MASK				(1 << 0)
 
 /* RM_RSTST_IVA2 specific bits */
-#define OMAP3430_EMULATION_VSEQ_RST			(1 << 13)
-#define OMAP3430_EMULATION_VHWA_RST			(1 << 12)
-#define OMAP3430_EMULATION_IVA2_RST			(1 << 11)
-#define OMAP3430_IVA2_SW_RST3				(1 << 10)
-#define OMAP3430_IVA2_SW_RST2				(1 << 9)
-#define OMAP3430_IVA2_SW_RST1				(1 << 8)
+#define OMAP3430_EMULATION_VSEQ_RST_MASK		(1 << 13)
+#define OMAP3430_EMULATION_VHWA_RST_MASK		(1 << 12)
+#define OMAP3430_EMULATION_IVA2_RST_MASK		(1 << 11)
+#define OMAP3430_IVA2_SW_RST3_MASK			(1 << 10)
+#define OMAP3430_IVA2_SW_RST2_MASK			(1 << 9)
+#define OMAP3430_IVA2_SW_RST1_MASK			(1 << 8)
 
 /* PM_WKDEP_IVA2 specific bits */
 
@@ -174,10 +174,10 @@
 #define OMAP3430_L1FLATMEMONSTATE_MASK			(0x3 << 18)
 #define OMAP3430_SHAREDL1CACHEFLATONSTATE_SHIFT		16
 #define OMAP3430_SHAREDL1CACHEFLATONSTATE_MASK		(0x3 << 16)
-#define OMAP3430_L2FLATMEMRETSTATE			(1 << 11)
-#define OMAP3430_SHAREDL2CACHEFLATRETSTATE		(1 << 10)
-#define OMAP3430_L1FLATMEMRETSTATE			(1 << 9)
-#define OMAP3430_SHAREDL1CACHEFLATRETSTATE		(1 << 8)
+#define OMAP3430_L2FLATMEMRETSTATE_MASK			(1 << 11)
+#define OMAP3430_SHAREDL2CACHEFLATRETSTATE_MASK		(1 << 10)
+#define OMAP3430_L1FLATMEMRETSTATE_MASK			(1 << 9)
+#define OMAP3430_SHAREDL1CACHEFLATRETSTATE_MASK		(1 << 8)
 
 /* PM_PWSTST_IVA2 specific bits */
 #define OMAP3430_L2FLATMEMSTATEST_SHIFT			10
@@ -200,12 +200,12 @@
 #define OMAP3430_LASTSHAREDL1CACHEFLATSTATEENTERED_MASK		(0x3 << 4)
 
 /* PRM_IRQSTATUS_IVA2 specific bits */
-#define OMAP3430_PRM_IRQSTATUS_IVA2_IVA2_DPLL_ST	(1 << 2)
-#define OMAP3430_FORCEWKUP_ST				(1 << 1)
+#define OMAP3430_PRM_IRQSTATUS_IVA2_IVA2_DPLL_ST_MASK	(1 << 2)
+#define OMAP3430_FORCEWKUP_ST_MASK			(1 << 1)
 
 /* PRM_IRQENABLE_IVA2 specific bits */
-#define OMAP3430_PRM_IRQENABLE_IVA2_IVA2_DPLL_RECAL_EN		(1 << 2)
-#define OMAP3430_FORCEWKUP_EN					(1 << 1)
+#define OMAP3430_PRM_IRQENABLE_IVA2_IVA2_DPLL_RECAL_EN_MASK	(1 << 2)
+#define OMAP3430_FORCEWKUP_EN_MASK				(1 << 1)
 
 /* PRM_REVISION specific bits */
 
@@ -213,70 +213,70 @@
 
 /* PRM_IRQSTATUS_MPU specific bits */
 #define OMAP3430ES2_SND_PERIPH_DPLL_ST_SHIFT		25
-#define OMAP3430ES2_SND_PERIPH_DPLL_ST			(1 << 25)
-#define OMAP3430_VC_TIMEOUTERR_ST			(1 << 24)
-#define OMAP3430_VC_RAERR_ST				(1 << 23)
-#define OMAP3430_VC_SAERR_ST				(1 << 22)
-#define OMAP3430_VP2_TRANXDONE_ST			(1 << 21)
-#define OMAP3430_VP2_EQVALUE_ST				(1 << 20)
-#define OMAP3430_VP2_NOSMPSACK_ST			(1 << 19)
-#define OMAP3430_VP2_MAXVDD_ST				(1 << 18)
-#define OMAP3430_VP2_MINVDD_ST				(1 << 17)
-#define OMAP3430_VP2_OPPCHANGEDONE_ST			(1 << 16)
-#define OMAP3430_VP1_TRANXDONE_ST			(1 << 15)
-#define OMAP3430_VP1_EQVALUE_ST				(1 << 14)
-#define OMAP3430_VP1_NOSMPSACK_ST			(1 << 13)
-#define OMAP3430_VP1_MAXVDD_ST				(1 << 12)
-#define OMAP3430_VP1_MINVDD_ST				(1 << 11)
-#define OMAP3430_VP1_OPPCHANGEDONE_ST			(1 << 10)
-#define OMAP3430_IO_ST					(1 << 9)
-#define OMAP3430_PRM_IRQSTATUS_MPU_IVA2_DPLL_ST		(1 << 8)
+#define OMAP3430ES2_SND_PERIPH_DPLL_ST_MASK		(1 << 25)
+#define OMAP3430_VC_TIMEOUTERR_ST_MASK			(1 << 24)
+#define OMAP3430_VC_RAERR_ST_MASK			(1 << 23)
+#define OMAP3430_VC_SAERR_ST_MASK			(1 << 22)
+#define OMAP3430_VP2_TRANXDONE_ST_MASK			(1 << 21)
+#define OMAP3430_VP2_EQVALUE_ST_MASK			(1 << 20)
+#define OMAP3430_VP2_NOSMPSACK_ST_MASK			(1 << 19)
+#define OMAP3430_VP2_MAXVDD_ST_MASK			(1 << 18)
+#define OMAP3430_VP2_MINVDD_ST_MASK			(1 << 17)
+#define OMAP3430_VP2_OPPCHANGEDONE_ST_MASK		(1 << 16)
+#define OMAP3430_VP1_TRANXDONE_ST_MASK			(1 << 15)
+#define OMAP3430_VP1_EQVALUE_ST_MASK			(1 << 14)
+#define OMAP3430_VP1_NOSMPSACK_ST_MASK			(1 << 13)
+#define OMAP3430_VP1_MAXVDD_ST_MASK			(1 << 12)
+#define OMAP3430_VP1_MINVDD_ST_MASK			(1 << 11)
+#define OMAP3430_VP1_OPPCHANGEDONE_ST_MASK		(1 << 10)
+#define OMAP3430_IO_ST_MASK				(1 << 9)
+#define OMAP3430_PRM_IRQSTATUS_MPU_IVA2_DPLL_ST_MASK	(1 << 8)
 #define OMAP3430_PRM_IRQSTATUS_MPU_IVA2_DPLL_ST_SHIFT	8
-#define OMAP3430_MPU_DPLL_ST				(1 << 7)
+#define OMAP3430_MPU_DPLL_ST_MASK			(1 << 7)
 #define OMAP3430_MPU_DPLL_ST_SHIFT			7
-#define OMAP3430_PERIPH_DPLL_ST				(1 << 6)
+#define OMAP3430_PERIPH_DPLL_ST_MASK			(1 << 6)
 #define OMAP3430_PERIPH_DPLL_ST_SHIFT			6
-#define OMAP3430_CORE_DPLL_ST				(1 << 5)
+#define OMAP3430_CORE_DPLL_ST_MASK			(1 << 5)
 #define OMAP3430_CORE_DPLL_ST_SHIFT			5
-#define OMAP3430_TRANSITION_ST				(1 << 4)
-#define OMAP3430_EVGENOFF_ST				(1 << 3)
-#define OMAP3430_EVGENON_ST				(1 << 2)
-#define OMAP3430_FS_USB_WKUP_ST				(1 << 1)
+#define OMAP3430_TRANSITION_ST_MASK			(1 << 4)
+#define OMAP3430_EVGENOFF_ST_MASK			(1 << 3)
+#define OMAP3430_EVGENON_ST_MASK			(1 << 2)
+#define OMAP3430_FS_USB_WKUP_ST_MASK			(1 << 1)
 
 /* PRM_IRQENABLE_MPU specific bits */
 #define OMAP3430ES2_SND_PERIPH_DPLL_RECAL_EN_SHIFT		25
-#define OMAP3430ES2_SND_PERIPH_DPLL_RECAL_EN			(1 << 25)
-#define OMAP3430_VC_TIMEOUTERR_EN				(1 << 24)
-#define OMAP3430_VC_RAERR_EN					(1 << 23)
-#define OMAP3430_VC_SAERR_EN					(1 << 22)
-#define OMAP3430_VP2_TRANXDONE_EN				(1 << 21)
-#define OMAP3430_VP2_EQVALUE_EN					(1 << 20)
-#define OMAP3430_VP2_NOSMPSACK_EN				(1 << 19)
-#define OMAP3430_VP2_MAXVDD_EN					(1 << 18)
-#define OMAP3430_VP2_MINVDD_EN					(1 << 17)
-#define OMAP3430_VP2_OPPCHANGEDONE_EN				(1 << 16)
-#define OMAP3430_VP1_TRANXDONE_EN				(1 << 15)
-#define OMAP3430_VP1_EQVALUE_EN					(1 << 14)
-#define OMAP3430_VP1_NOSMPSACK_EN				(1 << 13)
-#define OMAP3430_VP1_MAXVDD_EN					(1 << 12)
-#define OMAP3430_VP1_MINVDD_EN					(1 << 11)
-#define OMAP3430_VP1_OPPCHANGEDONE_EN				(1 << 10)
-#define OMAP3430_IO_EN						(1 << 9)
-#define OMAP3430_PRM_IRQENABLE_MPU_IVA2_DPLL_RECAL_EN		(1 << 8)
+#define OMAP3430ES2_SND_PERIPH_DPLL_RECAL_EN_MASK		(1 << 25)
+#define OMAP3430_VC_TIMEOUTERR_EN_MASK				(1 << 24)
+#define OMAP3430_VC_RAERR_EN_MASK				(1 << 23)
+#define OMAP3430_VC_SAERR_EN_MASK				(1 << 22)
+#define OMAP3430_VP2_TRANXDONE_EN_MASK				(1 << 21)
+#define OMAP3430_VP2_EQVALUE_EN_MASK				(1 << 20)
+#define OMAP3430_VP2_NOSMPSACK_EN_MASK				(1 << 19)
+#define OMAP3430_VP2_MAXVDD_EN_MASK				(1 << 18)
+#define OMAP3430_VP2_MINVDD_EN_MASK				(1 << 17)
+#define OMAP3430_VP2_OPPCHANGEDONE_EN_MASK			(1 << 16)
+#define OMAP3430_VP1_TRANXDONE_EN_MASK				(1 << 15)
+#define OMAP3430_VP1_EQVALUE_EN_MASK				(1 << 14)
+#define OMAP3430_VP1_NOSMPSACK_EN_MASK				(1 << 13)
+#define OMAP3430_VP1_MAXVDD_EN_MASK				(1 << 12)
+#define OMAP3430_VP1_MINVDD_EN_MASK				(1 << 11)
+#define OMAP3430_VP1_OPPCHANGEDONE_EN_MASK			(1 << 10)
+#define OMAP3430_IO_EN_MASK					(1 << 9)
+#define OMAP3430_PRM_IRQENABLE_MPU_IVA2_DPLL_RECAL_EN_MASK	(1 << 8)
 #define OMAP3430_PRM_IRQENABLE_MPU_IVA2_DPLL_RECAL_EN_SHIFT	8
-#define OMAP3430_MPU_DPLL_RECAL_EN				(1 << 7)
+#define OMAP3430_MPU_DPLL_RECAL_EN_MASK				(1 << 7)
 #define OMAP3430_MPU_DPLL_RECAL_EN_SHIFT			7
-#define OMAP3430_PERIPH_DPLL_RECAL_EN				(1 << 6)
+#define OMAP3430_PERIPH_DPLL_RECAL_EN_MASK			(1 << 6)
 #define OMAP3430_PERIPH_DPLL_RECAL_EN_SHIFT			6
-#define OMAP3430_CORE_DPLL_RECAL_EN				(1 << 5)
+#define OMAP3430_CORE_DPLL_RECAL_EN_MASK			(1 << 5)
 #define OMAP3430_CORE_DPLL_RECAL_EN_SHIFT			5
-#define OMAP3430_TRANSITION_EN					(1 << 4)
-#define OMAP3430_EVGENOFF_EN					(1 << 3)
-#define OMAP3430_EVGENON_EN					(1 << 2)
-#define OMAP3430_FS_USB_WKUP_EN					(1 << 1)
+#define OMAP3430_TRANSITION_EN_MASK				(1 << 4)
+#define OMAP3430_EVGENOFF_EN_MASK				(1 << 3)
+#define OMAP3430_EVGENON_EN_MASK				(1 << 2)
+#define OMAP3430_FS_USB_WKUP_EN_MASK				(1 << 1)
 
 /* RM_RSTST_MPU specific bits */
-#define OMAP3430_EMULATION_MPU_RST			(1 << 11)
+#define OMAP3430_EMULATION_MPU_RST_MASK			(1 << 11)
 
 /* PM_WKDEP_MPU specific bits */
 #define OMAP3430_PM_WKDEP_MPU_EN_DSS_SHIFT		5
@@ -289,7 +289,7 @@
 #define OMAP3430_OFFLOADMODE_MASK			(0x3 << 3)
 #define OMAP3430_ONLOADMODE_SHIFT			1
 #define OMAP3430_ONLOADMODE_MASK			(0x3 << 1)
-#define OMAP3430_ENABLE					(1 << 0)
+#define OMAP3430_ENABLE_MASK				(1 << 0)
 
 /* PM_EVGENONTIM_MPU */
 #define OMAP3430_ONTIMEVAL_SHIFT			0
@@ -302,32 +302,32 @@
 /* PM_PWSTCTRL_MPU specific bits */
 #define OMAP3430_L2CACHEONSTATE_SHIFT			16
 #define OMAP3430_L2CACHEONSTATE_MASK			(0x3 << 16)
-#define OMAP3430_L2CACHERETSTATE			(1 << 8)
-#define OMAP3430_LOGICL1CACHERETSTATE			(1 << 2)
+#define OMAP3430_L2CACHERETSTATE_MASK			(1 << 8)
+#define OMAP3430_LOGICL1CACHERETSTATE_MASK		(1 << 2)
 
 /* PM_PWSTST_MPU specific bits */
 #define OMAP3430_L2CACHESTATEST_SHIFT			6
 #define OMAP3430_L2CACHESTATEST_MASK			(0x3 << 6)
-#define OMAP3430_LOGICL1CACHESTATEST			(1 << 2)
+#define OMAP3430_LOGICL1CACHESTATEST_MASK		(1 << 2)
 
 /* PM_PREPWSTST_MPU specific bits */
 #define OMAP3430_LASTL2CACHESTATEENTERED_SHIFT		6
 #define OMAP3430_LASTL2CACHESTATEENTERED_MASK		(0x3 << 6)
-#define OMAP3430_LASTLOGICL1CACHESTATEENTERED		(1 << 2)
+#define OMAP3430_LASTLOGICL1CACHESTATEENTERED_MASK	(1 << 2)
 
 /* RM_RSTCTRL_CORE */
-#define OMAP3430_RM_RSTCTRL_CORE_MODEM_SW_RSTPWRON		(1 << 1)
-#define OMAP3430_RM_RSTCTRL_CORE_MODEM_SW_RST			(1 << 0)
+#define OMAP3430_RM_RSTCTRL_CORE_MODEM_SW_RSTPWRON_MASK		(1 << 1)
+#define OMAP3430_RM_RSTCTRL_CORE_MODEM_SW_RST_MASK		(1 << 0)
 
 /* RM_RSTST_CORE specific bits */
-#define OMAP3430_MODEM_SECURITY_VIOL_RST		(1 << 10)
-#define OMAP3430_RM_RSTST_CORE_MODEM_SW_RSTPWRON	(1 << 9)
-#define OMAP3430_RM_RSTST_CORE_MODEM_SW_RST		(1 << 8)
+#define OMAP3430_MODEM_SECURITY_VIOL_RST_MASK		(1 << 10)
+#define OMAP3430_RM_RSTST_CORE_MODEM_SW_RSTPWRON_MASK	(1 << 9)
+#define OMAP3430_RM_RSTST_CORE_MODEM_SW_RST_MASK	(1 << 8)
 
 /* PM_WKEN1_CORE specific bits */
 
 /* PM_MPUGRPSEL1_CORE specific bits */
-#define OMAP3430_GRPSEL_FSHOSTUSB			(1 << 5)
+#define OMAP3430_GRPSEL_FSHOSTUSB_MASK			(1 << 5)
 
 /* PM_IVA2GRPSEL1_CORE specific bits */
 
@@ -338,8 +338,8 @@
 #define OMAP3430_MEM2ONSTATE_MASK			(0x3 << 18)
 #define OMAP3430_MEM1ONSTATE_SHIFT			16
 #define OMAP3430_MEM1ONSTATE_MASK			(0x3 << 16)
-#define OMAP3430_MEM2RETSTATE				(1 << 9)
-#define OMAP3430_MEM1RETSTATE				(1 << 8)
+#define OMAP3430_MEM2RETSTATE_MASK			(1 << 9)
+#define OMAP3430_MEM1RETSTATE_MASK			(1 << 8)
 
 /* PM_PWSTST_CORE specific bits */
 #define OMAP3430_MEM2STATEST_SHIFT			6
@@ -356,7 +356,7 @@
 /* RM_RSTST_GFX specific bits */
 
 /* PM_WKDEP_GFX specific bits */
-#define OMAP3430_PM_WKDEP_GFX_EN_IVA2			(1 << 2)
+#define OMAP3430_PM_WKDEP_GFX_EN_IVA2_MASK		(1 << 2)
 
 /* PM_PWSTCTRL_GFX specific bits */
 
@@ -365,33 +365,33 @@
 /* PM_PREPWSTST_GFX specific bits */
 
 /* PM_WKEN_WKUP specific bits */
-#define OMAP3430_EN_IO_CHAIN				(1 << 16)
-#define OMAP3430_EN_IO					(1 << 8)
-#define OMAP3430_EN_GPIO1				(1 << 3)
+#define OMAP3430_EN_IO_CHAIN_MASK			(1 << 16)
+#define OMAP3430_EN_IO_MASK				(1 << 8)
+#define OMAP3430_EN_GPIO1_MASK				(1 << 3)
 
 /* PM_MPUGRPSEL_WKUP specific bits */
 
 /* PM_IVA2GRPSEL_WKUP specific bits */
 
 /* PM_WKST_WKUP specific bits */
-#define OMAP3430_ST_IO_CHAIN				(1 << 16)
-#define OMAP3430_ST_IO					(1 << 8)
+#define OMAP3430_ST_IO_CHAIN_MASK			(1 << 16)
+#define OMAP3430_ST_IO_MASK				(1 << 8)
 
 /* PRM_CLKSEL */
 #define OMAP3430_SYS_CLKIN_SEL_SHIFT			0
 #define OMAP3430_SYS_CLKIN_SEL_MASK			(0x7 << 0)
 
 /* PRM_CLKOUT_CTRL */
-#define OMAP3430_CLKOUT_EN				(1 << 7)
+#define OMAP3430_CLKOUT_EN_MASK				(1 << 7)
 #define OMAP3430_CLKOUT_EN_SHIFT			7
 
 /* RM_RSTST_DSS specific bits */
 
 /* PM_WKEN_DSS */
-#define OMAP3430_PM_WKEN_DSS_EN_DSS			(1 << 0)
+#define OMAP3430_PM_WKEN_DSS_EN_DSS_MASK		(1 << 0)
 
 /* PM_WKDEP_DSS specific bits */
-#define OMAP3430_PM_WKDEP_DSS_EN_IVA2			(1 << 2)
+#define OMAP3430_PM_WKDEP_DSS_EN_IVA2_MASK		(1 << 2)
 
 /* PM_PWSTCTRL_DSS specific bits */
 
@@ -402,7 +402,7 @@
 /* RM_RSTST_CAM specific bits */
 
 /* PM_WKDEP_CAM specific bits */
-#define OMAP3430_PM_WKDEP_CAM_EN_IVA2			(1 << 2)
+#define OMAP3430_PM_WKDEP_CAM_EN_IVA2_MASK		(1 << 2)
 
 /* PM_PWSTCTRL_CAM specific bits */
 
@@ -424,7 +424,7 @@
 /* PM_WKST_PER specific bits */
 
 /* PM_WKDEP_PER specific bits */
-#define OMAP3430_PM_WKDEP_PER_EN_IVA2			(1 << 2)
+#define OMAP3430_PM_WKDEP_PER_EN_IVA2_MASK		(1 << 2)
 
 /* PM_PWSTCTRL_PER specific bits */
 
@@ -467,26 +467,26 @@
 /* PRM_VC_CMD_VAL_1 specific bits */
 
 /* PRM_VC_CH_CONF */
-#define OMAP3430_CMD1					(1 << 20)
-#define OMAP3430_RACEN1					(1 << 19)
-#define OMAP3430_RAC1					(1 << 18)
-#define OMAP3430_RAV1					(1 << 17)
-#define OMAP3430_PRM_VC_CH_CONF_SA1			(1 << 16)
-#define OMAP3430_CMD0					(1 << 4)
-#define OMAP3430_RACEN0					(1 << 3)
-#define OMAP3430_RAC0					(1 << 2)
-#define OMAP3430_RAV0					(1 << 1)
-#define OMAP3430_PRM_VC_CH_CONF_SA0			(1 << 0)
+#define OMAP3430_CMD1_MASK				(1 << 20)
+#define OMAP3430_RACEN1_MASK				(1 << 19)
+#define OMAP3430_RAC1_MASK				(1 << 18)
+#define OMAP3430_RAV1_MASK				(1 << 17)
+#define OMAP3430_PRM_VC_CH_CONF_SA1_MASK		(1 << 16)
+#define OMAP3430_CMD0_MASK				(1 << 4)
+#define OMAP3430_RACEN0_MASK				(1 << 3)
+#define OMAP3430_RAC0_MASK				(1 << 2)
+#define OMAP3430_RAV0_MASK				(1 << 1)
+#define OMAP3430_PRM_VC_CH_CONF_SA0_MASK		(1 << 0)
 
 /* PRM_VC_I2C_CFG */
-#define OMAP3430_HSMASTER				(1 << 5)
-#define OMAP3430_SREN					(1 << 4)
-#define OMAP3430_HSEN					(1 << 3)
+#define OMAP3430_HSMASTER_MASK				(1 << 5)
+#define OMAP3430_SREN_MASK				(1 << 4)
+#define OMAP3430_HSEN_MASK				(1 << 3)
 #define OMAP3430_MCODE_SHIFT				0
 #define OMAP3430_MCODE_MASK				(0x7 << 0)
 
 /* PRM_VC_BYPASS_VAL */
-#define OMAP3430_VALID					(1 << 24)
+#define OMAP3430_VALID_MASK				(1 << 24)
 #define OMAP3430_DATA_SHIFT				16
 #define OMAP3430_DATA_MASK				(0xff << 16)
 #define OMAP3430_REGADDR_SHIFT				8
@@ -495,8 +495,8 @@
 #define OMAP3430_SLAVEADDR_MASK				(0x7f << 0)
 
 /* PRM_RSTCTRL */
-#define OMAP3430_RST_DPLL3				(1 << 2)
-#define OMAP3430_RST_GS					(1 << 1)
+#define OMAP3430_RST_DPLL3_MASK				(1 << 2)
+#define OMAP3430_RST_GS_MASK				(1 << 1)
 
 /* PRM_RSTTIME */
 #define OMAP3430_RSTTIME2_SHIFT				8
@@ -505,23 +505,23 @@
 #define OMAP3430_RSTTIME1_MASK				(0xff << 0)
 
 /* PRM_RSTST */
-#define OMAP3430_ICECRUSHER_RST				(1 << 10)
-#define OMAP3430_ICEPICK_RST				(1 << 9)
-#define OMAP3430_VDD2_VOLTAGE_MANAGER_RST		(1 << 8)
-#define OMAP3430_VDD1_VOLTAGE_MANAGER_RST		(1 << 7)
-#define OMAP3430_EXTERNAL_WARM_RST			(1 << 6)
-#define OMAP3430_SECURE_WD_RST				(1 << 5)
-#define OMAP3430_MPU_WD_RST				(1 << 4)
-#define OMAP3430_SECURITY_VIOL_RST			(1 << 3)
-#define OMAP3430_GLOBAL_SW_RST				(1 << 1)
-#define OMAP3430_GLOBAL_COLD_RST			(1 << 0)
+#define OMAP3430_ICECRUSHER_RST_MASK			(1 << 10)
+#define OMAP3430_ICEPICK_RST_MASK			(1 << 9)
+#define OMAP3430_VDD2_VOLTAGE_MANAGER_RST_MASK		(1 << 8)
+#define OMAP3430_VDD1_VOLTAGE_MANAGER_RST_MASK		(1 << 7)
+#define OMAP3430_EXTERNAL_WARM_RST_MASK			(1 << 6)
+#define OMAP3430_SECURE_WD_RST_MASK			(1 << 5)
+#define OMAP3430_MPU_WD_RST_MASK			(1 << 4)
+#define OMAP3430_SECURITY_VIOL_RST_MASK			(1 << 3)
+#define OMAP3430_GLOBAL_SW_RST_MASK			(1 << 1)
+#define OMAP3430_GLOBAL_COLD_RST_MASK			(1 << 0)
 
 /* PRM_VOLTCTRL */
-#define OMAP3430_SEL_VMODE				(1 << 4)
-#define OMAP3430_SEL_OFF				(1 << 3)
-#define OMAP3430_AUTO_OFF				(1 << 2)
-#define OMAP3430_AUTO_RET				(1 << 1)
-#define OMAP3430_AUTO_SLEEP				(1 << 0)
+#define OMAP3430_SEL_VMODE_MASK				(1 << 4)
+#define OMAP3430_SEL_OFF_MASK				(1 << 3)
+#define OMAP3430_AUTO_OFF_MASK				(1 << 2)
+#define OMAP3430_AUTO_RET_MASK				(1 << 1)
+#define OMAP3430_AUTO_SLEEP_MASK			(1 << 0)
 
 /* PRM_SRAM_PCHARGE */
 #define OMAP3430_PCHARGE_TIME_SHIFT			0
@@ -550,10 +550,10 @@
 #define OMAP3430_SETUP_TIME_MASK			(0xffff << 0)
 
 /* PRM_POLCTRL */
-#define OMAP3430_OFFMODE_POL				(1 << 3)
-#define OMAP3430_CLKOUT_POL				(1 << 2)
-#define OMAP3430_CLKREQ_POL				(1 << 1)
-#define OMAP3430_EXTVOL_POL				(1 << 0)
+#define OMAP3430_OFFMODE_POL_MASK			(1 << 3)
+#define OMAP3430_CLKOUT_POL_MASK			(1 << 2)
+#define OMAP3430_CLKREQ_POL_MASK			(1 << 1)
+#define OMAP3430_EXTVOL_POL_MASK			(1 << 0)
 
 /* PRM_VOLTSETUP2 */
 #define OMAP3430_OFFMODESETUPTIME_SHIFT			0


