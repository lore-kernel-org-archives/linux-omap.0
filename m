From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/4] OMAP2 PRCM: convert OMAP2 PRCM macros to the _SHIFT/_MASK
	suffixes
Date: Tue, 20 Apr 2010 01:45:47 -0600
Message-ID: <20100420074544.3015.71408.stgit@localhost.localdomain>
References: <20100420074204.3015.56304.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35970 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871Ab0DTHsf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Apr 2010 03:48:35 -0400
In-Reply-To: <20100420074204.3015.56304.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

Fix all of the remaining OMAP2 PRCM register shift/bitmask macros that
did not use the _SHIFT/_MASK suffixes to use them.  This makes the use
of these macros consistent.  It is intended to reduce error, as code
can be inspected visually by reviewers to ensure that bitshifts and
bitmasks are used in the appropriate places.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/clkt2xxx_apll.c    |    4 -
 arch/arm/mach-omap2/clock2420_data.c   |    4 -
 arch/arm/mach-omap2/clockdomain.c      |    4 -
 arch/arm/mach-omap2/cm-regbits-24xx.h  |  236 ++++++++++++++++----------------
 arch/arm/mach-omap2/pm24xx.c           |  107 +++++++--------
 arch/arm/mach-omap2/prm-regbits-24xx.h |  120 ++++++++--------
 6 files changed, 238 insertions(+), 237 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt2xxx_apll.c b/arch/arm/mach-omap2/clkt2xxx_apll.c
index 43d7246..66e01ac 100644
--- a/arch/arm/mach-omap2/clkt2xxx_apll.c
+++ b/arch/arm/mach-omap2/clkt2xxx_apll.c
@@ -70,12 +70,12 @@ static int omap2_clk_apll_enable(struct clk *clk, u32 status_mask)
 
 static int omap2_clk_apll96_enable(struct clk *clk)
 {
-	return omap2_clk_apll_enable(clk, OMAP24XX_ST_96M_APLL);
+	return omap2_clk_apll_enable(clk, OMAP24XX_ST_96M_APLL_MASK);
 }
 
 static int omap2_clk_apll54_enable(struct clk *clk)
 {
-	return omap2_clk_apll_enable(clk, OMAP24XX_ST_54M_APLL);
+	return omap2_clk_apll_enable(clk, OMAP24XX_ST_54M_APLL_MASK);
 }
 
 /* Stop APLL */
diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index d932b14..1381e76 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -177,7 +177,7 @@ static struct clk func_54m_ck = {
 	.clkdm_name	= "wkup_clkdm",
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
-	.clksel_mask	= OMAP24XX_54M_SOURCE,
+	.clksel_mask	= OMAP24XX_54M_SOURCE_MASK,
 	.clksel		= func_54m_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -223,7 +223,7 @@ static struct clk func_48m_ck = {
 	.clkdm_name	= "wkup_clkdm",
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
-	.clksel_mask	= OMAP24XX_48M_SOURCE,
+	.clksel_mask	= OMAP24XX_48M_SOURCE_MASK,
 	.clksel		= func_48m_clksel,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index b87ad66..829db15 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -809,7 +809,7 @@ int omap2_clkdm_sleep(struct clockdomain *clkdm)
 
 	if (cpu_is_omap24xx()) {
 
-		cm_set_mod_reg_bits(OMAP24XX_FORCESTATE,
+		cm_set_mod_reg_bits(OMAP24XX_FORCESTATE_MASK,
 			    clkdm->pwrdm.ptr->prcm_offs, OMAP2_PM_PWSTCTRL);
 
 	} else if (cpu_is_omap34xx() | cpu_is_omap44xx()) {
@@ -853,7 +853,7 @@ int omap2_clkdm_wakeup(struct clockdomain *clkdm)
 
 	if (cpu_is_omap24xx()) {
 
-		cm_clear_mod_reg_bits(OMAP24XX_FORCESTATE,
+		cm_clear_mod_reg_bits(OMAP24XX_FORCESTATE_MASK,
 			      clkdm->pwrdm.ptr->prcm_offs, OMAP2_PM_PWSTCTRL);
 
 	} else if (cpu_is_omap34xx() | cpu_is_omap44xx()) {
diff --git a/arch/arm/mach-omap2/cm-regbits-24xx.h b/arch/arm/mach-omap2/cm-regbits-24xx.h
index 297a2fe..da51cc3 100644
--- a/arch/arm/mach-omap2/cm-regbits-24xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-24xx.h
@@ -20,43 +20,43 @@
 
 /* CM_FCLKEN1_CORE and CM_ICLKEN1_CORE shared bits */
 #define OMAP24XX_EN_CAM_SHIFT				31
-#define OMAP24XX_EN_CAM					(1 << 31)
+#define OMAP24XX_EN_CAM_MASK				(1 << 31)
 #define OMAP24XX_EN_WDT4_SHIFT				29
-#define OMAP24XX_EN_WDT4				(1 << 29)
+#define OMAP24XX_EN_WDT4_MASK				(1 << 29)
 #define OMAP2420_EN_WDT3_SHIFT				28
-#define OMAP2420_EN_WDT3				(1 << 28)
+#define OMAP2420_EN_WDT3_MASK				(1 << 28)
 #define OMAP24XX_EN_MSPRO_SHIFT				27
-#define OMAP24XX_EN_MSPRO				(1 << 27)
+#define OMAP24XX_EN_MSPRO_MASK				(1 << 27)
 #define OMAP24XX_EN_FAC_SHIFT				25
-#define OMAP24XX_EN_FAC					(1 << 25)
+#define OMAP24XX_EN_FAC_MASK				(1 << 25)
 #define OMAP2420_EN_EAC_SHIFT				24
-#define OMAP2420_EN_EAC					(1 << 24)
+#define OMAP2420_EN_EAC_MASK				(1 << 24)
 #define OMAP24XX_EN_HDQ_SHIFT				23
-#define OMAP24XX_EN_HDQ					(1 << 23)
+#define OMAP24XX_EN_HDQ_MASK				(1 << 23)
 #define OMAP2420_EN_I2C2_SHIFT				20
-#define OMAP2420_EN_I2C2				(1 << 20)
+#define OMAP2420_EN_I2C2_MASK				(1 << 20)
 #define OMAP2420_EN_I2C1_SHIFT				19
-#define OMAP2420_EN_I2C1				(1 << 19)
+#define OMAP2420_EN_I2C1_MASK				(1 << 19)
 
 /* CM_FCLKEN2_CORE and CM_ICLKEN2_CORE shared bits */
 #define OMAP2430_EN_MCBSP5_SHIFT			5
-#define OMAP2430_EN_MCBSP5				(1 << 5)
+#define OMAP2430_EN_MCBSP5_MASK				(1 << 5)
 #define OMAP2430_EN_MCBSP4_SHIFT			4
-#define OMAP2430_EN_MCBSP4				(1 << 4)
+#define OMAP2430_EN_MCBSP4_MASK				(1 << 4)
 #define OMAP2430_EN_MCBSP3_SHIFT			3
-#define OMAP2430_EN_MCBSP3				(1 << 3)
+#define OMAP2430_EN_MCBSP3_MASK				(1 << 3)
 #define OMAP24XX_EN_SSI_SHIFT				1
-#define OMAP24XX_EN_SSI					(1 << 1)
+#define OMAP24XX_EN_SSI_MASK				(1 << 1)
 
 /* CM_FCLKEN_WKUP and CM_ICLKEN_WKUP shared bits */
 #define OMAP24XX_EN_MPU_WDT_SHIFT			3
-#define OMAP24XX_EN_MPU_WDT				(1 << 3)
+#define OMAP24XX_EN_MPU_WDT_MASK			(1 << 3)
 
 /* Bits specific to each register */
 
 /* CM_IDLEST_MPU */
 /* 2430 only */
-#define OMAP2430_ST_MPU					(1 << 0)
+#define OMAP2430_ST_MPU_MASK				(1 << 0)
 
 /* CM_CLKSEL_MPU */
 #define OMAP24XX_CLKSEL_MPU_SHIFT			0
@@ -68,46 +68,46 @@
 
 /* CM_FCLKEN1_CORE specific bits*/
 #define OMAP24XX_EN_TV_SHIFT				2
-#define OMAP24XX_EN_TV					(1 << 2)
+#define OMAP24XX_EN_TV_MASK				(1 << 2)
 #define OMAP24XX_EN_DSS2_SHIFT				1
-#define OMAP24XX_EN_DSS2				(1 << 1)
+#define OMAP24XX_EN_DSS2_MASK				(1 << 1)
 #define OMAP24XX_EN_DSS1_SHIFT				0
-#define OMAP24XX_EN_DSS1				(1 << 0)
+#define OMAP24XX_EN_DSS1_MASK				(1 << 0)
 
 /* CM_FCLKEN2_CORE specific bits */
 #define OMAP2430_EN_I2CHS2_SHIFT			20
-#define OMAP2430_EN_I2CHS2				(1 << 20)
+#define OMAP2430_EN_I2CHS2_MASK				(1 << 20)
 #define OMAP2430_EN_I2CHS1_SHIFT			19
-#define OMAP2430_EN_I2CHS1				(1 << 19)
+#define OMAP2430_EN_I2CHS1_MASK				(1 << 19)
 #define OMAP2430_EN_MMCHSDB2_SHIFT			17
-#define OMAP2430_EN_MMCHSDB2				(1 << 17)
+#define OMAP2430_EN_MMCHSDB2_MASK			(1 << 17)
 #define OMAP2430_EN_MMCHSDB1_SHIFT			16
-#define OMAP2430_EN_MMCHSDB1				(1 << 16)
+#define OMAP2430_EN_MMCHSDB1_MASK			(1 << 16)
 
 /* CM_ICLKEN1_CORE specific bits */
 #define OMAP24XX_EN_MAILBOXES_SHIFT			30
-#define OMAP24XX_EN_MAILBOXES				(1 << 30)
+#define OMAP24XX_EN_MAILBOXES_MASK			(1 << 30)
 #define OMAP24XX_EN_DSS_SHIFT				0
-#define OMAP24XX_EN_DSS					(1 << 0)
+#define OMAP24XX_EN_DSS_MASK				(1 << 0)
 
 /* CM_ICLKEN2_CORE specific bits */
 
 /* CM_ICLKEN3_CORE */
 /* 2430 only */
 #define OMAP2430_EN_SDRC_SHIFT				2
-#define OMAP2430_EN_SDRC				(1 << 2)
+#define OMAP2430_EN_SDRC_MASK				(1 << 2)
 
 /* CM_ICLKEN4_CORE */
 #define OMAP24XX_EN_PKA_SHIFT				4
-#define OMAP24XX_EN_PKA					(1 << 4)
+#define OMAP24XX_EN_PKA_MASK				(1 << 4)
 #define OMAP24XX_EN_AES_SHIFT				3
-#define OMAP24XX_EN_AES					(1 << 3)
+#define OMAP24XX_EN_AES_MASK				(1 << 3)
 #define OMAP24XX_EN_RNG_SHIFT				2
-#define OMAP24XX_EN_RNG					(1 << 2)
+#define OMAP24XX_EN_RNG_MASK				(1 << 2)
 #define OMAP24XX_EN_SHA_SHIFT				1
-#define OMAP24XX_EN_SHA					(1 << 1)
+#define OMAP24XX_EN_SHA_MASK				(1 << 1)
 #define OMAP24XX_EN_DES_SHIFT				0
-#define OMAP24XX_EN_DES					(1 << 0)
+#define OMAP24XX_EN_DES_MASK				(1 << 0)
 
 /* CM_IDLEST1_CORE specific bits */
 #define OMAP24XX_ST_MAILBOXES_SHIFT			30
@@ -138,9 +138,9 @@
 /* CM_IDLEST2_CORE */
 #define OMAP2430_ST_MCBSP5_SHIFT			5
 #define OMAP2430_ST_MCBSP5_MASK				(1 << 5)
-#define OMAP2430_ST_MCBSP4_SHIFT				4
+#define OMAP2430_ST_MCBSP4_SHIFT			4
 #define OMAP2430_ST_MCBSP4_MASK				(1 << 4)
-#define OMAP2430_ST_MCBSP3_SHIFT				3
+#define OMAP2430_ST_MCBSP3_SHIFT			3
 #define OMAP2430_ST_MCBSP3_MASK				(1 << 3)
 #define OMAP24XX_ST_SSI_SHIFT				1
 #define OMAP24XX_ST_SSI_MASK				(1 << 1)
@@ -162,62 +162,62 @@
 #define OMAP24XX_ST_DES_MASK				(1 << 0)
 
 /* CM_AUTOIDLE1_CORE */
-#define OMAP24XX_AUTO_CAM				(1 << 31)
-#define OMAP24XX_AUTO_MAILBOXES				(1 << 30)
-#define OMAP24XX_AUTO_WDT4				(1 << 29)
-#define OMAP2420_AUTO_WDT3				(1 << 28)
-#define OMAP24XX_AUTO_MSPRO				(1 << 27)
-#define OMAP2420_AUTO_MMC				(1 << 26)
-#define OMAP24XX_AUTO_FAC				(1 << 25)
-#define OMAP2420_AUTO_EAC				(1 << 24)
-#define OMAP24XX_AUTO_HDQ				(1 << 23)
-#define OMAP24XX_AUTO_UART2				(1 << 22)
-#define OMAP24XX_AUTO_UART1				(1 << 21)
-#define OMAP24XX_AUTO_I2C2				(1 << 20)
-#define OMAP24XX_AUTO_I2C1				(1 << 19)
-#define OMAP24XX_AUTO_MCSPI2				(1 << 18)
-#define OMAP24XX_AUTO_MCSPI1				(1 << 17)
-#define OMAP24XX_AUTO_MCBSP2				(1 << 16)
-#define OMAP24XX_AUTO_MCBSP1				(1 << 15)
-#define OMAP24XX_AUTO_GPT12				(1 << 14)
-#define OMAP24XX_AUTO_GPT11				(1 << 13)
-#define OMAP24XX_AUTO_GPT10				(1 << 12)
-#define OMAP24XX_AUTO_GPT9				(1 << 11)
-#define OMAP24XX_AUTO_GPT8				(1 << 10)
-#define OMAP24XX_AUTO_GPT7				(1 << 9)
-#define OMAP24XX_AUTO_GPT6				(1 << 8)
-#define OMAP24XX_AUTO_GPT5				(1 << 7)
-#define OMAP24XX_AUTO_GPT4				(1 << 6)
-#define OMAP24XX_AUTO_GPT3				(1 << 5)
-#define OMAP24XX_AUTO_GPT2				(1 << 4)
-#define OMAP2420_AUTO_VLYNQ				(1 << 3)
-#define OMAP24XX_AUTO_DSS				(1 << 0)
+#define OMAP24XX_AUTO_CAM_MASK				(1 << 31)
+#define OMAP24XX_AUTO_MAILBOXES_MASK			(1 << 30)
+#define OMAP24XX_AUTO_WDT4_MASK				(1 << 29)
+#define OMAP2420_AUTO_WDT3_MASK				(1 << 28)
+#define OMAP24XX_AUTO_MSPRO_MASK			(1 << 27)
+#define OMAP2420_AUTO_MMC_MASK				(1 << 26)
+#define OMAP24XX_AUTO_FAC_MASK				(1 << 25)
+#define OMAP2420_AUTO_EAC_MASK				(1 << 24)
+#define OMAP24XX_AUTO_HDQ_MASK				(1 << 23)
+#define OMAP24XX_AUTO_UART2_MASK			(1 << 22)
+#define OMAP24XX_AUTO_UART1_MASK			(1 << 21)
+#define OMAP24XX_AUTO_I2C2_MASK				(1 << 20)
+#define OMAP24XX_AUTO_I2C1_MASK				(1 << 19)
+#define OMAP24XX_AUTO_MCSPI2_MASK			(1 << 18)
+#define OMAP24XX_AUTO_MCSPI1_MASK			(1 << 17)
+#define OMAP24XX_AUTO_MCBSP2_MASK			(1 << 16)
+#define OMAP24XX_AUTO_MCBSP1_MASK			(1 << 15)
+#define OMAP24XX_AUTO_GPT12_MASK			(1 << 14)
+#define OMAP24XX_AUTO_GPT11_MASK			(1 << 13)
+#define OMAP24XX_AUTO_GPT10_MASK			(1 << 12)
+#define OMAP24XX_AUTO_GPT9_MASK				(1 << 11)
+#define OMAP24XX_AUTO_GPT8_MASK				(1 << 10)
+#define OMAP24XX_AUTO_GPT7_MASK				(1 << 9)
+#define OMAP24XX_AUTO_GPT6_MASK				(1 << 8)
+#define OMAP24XX_AUTO_GPT5_MASK				(1 << 7)
+#define OMAP24XX_AUTO_GPT4_MASK				(1 << 6)
+#define OMAP24XX_AUTO_GPT3_MASK				(1 << 5)
+#define OMAP24XX_AUTO_GPT2_MASK				(1 << 4)
+#define OMAP2420_AUTO_VLYNQ_MASK			(1 << 3)
+#define OMAP24XX_AUTO_DSS_MASK				(1 << 0)
 
 /* CM_AUTOIDLE2_CORE */
-#define OMAP2430_AUTO_MDM_INTC				(1 << 11)
-#define OMAP2430_AUTO_GPIO5				(1 << 10)
-#define OMAP2430_AUTO_MCSPI3				(1 << 9)
-#define OMAP2430_AUTO_MMCHS2				(1 << 8)
-#define OMAP2430_AUTO_MMCHS1				(1 << 7)
-#define OMAP2430_AUTO_USBHS				(1 << 6)
-#define OMAP2430_AUTO_MCBSP5				(1 << 5)
-#define OMAP2430_AUTO_MCBSP4				(1 << 4)
-#define OMAP2430_AUTO_MCBSP3				(1 << 3)
-#define OMAP24XX_AUTO_UART3				(1 << 2)
-#define OMAP24XX_AUTO_SSI				(1 << 1)
-#define OMAP24XX_AUTO_USB				(1 << 0)
+#define OMAP2430_AUTO_MDM_INTC_MASK			(1 << 11)
+#define OMAP2430_AUTO_GPIO5_MASK			(1 << 10)
+#define OMAP2430_AUTO_MCSPI3_MASK			(1 << 9)
+#define OMAP2430_AUTO_MMCHS2_MASK			(1 << 8)
+#define OMAP2430_AUTO_MMCHS1_MASK			(1 << 7)
+#define OMAP2430_AUTO_USBHS_MASK			(1 << 6)
+#define OMAP2430_AUTO_MCBSP5_MASK			(1 << 5)
+#define OMAP2430_AUTO_MCBSP4_MASK			(1 << 4)
+#define OMAP2430_AUTO_MCBSP3_MASK			(1 << 3)
+#define OMAP24XX_AUTO_UART3_MASK			(1 << 2)
+#define OMAP24XX_AUTO_SSI_MASK				(1 << 1)
+#define OMAP24XX_AUTO_USB_MASK				(1 << 0)
 
 /* CM_AUTOIDLE3_CORE */
-#define OMAP24XX_AUTO_SDRC				(1 << 2)
-#define OMAP24XX_AUTO_GPMC				(1 << 1)
-#define OMAP24XX_AUTO_SDMA				(1 << 0)
+#define OMAP24XX_AUTO_SDRC_MASK				(1 << 2)
+#define OMAP24XX_AUTO_GPMC_MASK				(1 << 1)
+#define OMAP24XX_AUTO_SDMA_MASK				(1 << 0)
 
 /* CM_AUTOIDLE4_CORE */
-#define OMAP24XX_AUTO_PKA				(1 << 4)
-#define OMAP24XX_AUTO_AES				(1 << 3)
-#define OMAP24XX_AUTO_RNG				(1 << 2)
-#define OMAP24XX_AUTO_SHA				(1 << 1)
-#define OMAP24XX_AUTO_DES				(1 << 0)
+#define OMAP24XX_AUTO_PKA_MASK				(1 << 4)
+#define OMAP24XX_AUTO_AES_MASK				(1 << 3)
+#define OMAP24XX_AUTO_RNG_MASK				(1 << 2)
+#define OMAP24XX_AUTO_SHA_MASK				(1 << 1)
+#define OMAP24XX_AUTO_DES_MASK				(1 << 0)
 
 /* CM_CLKSEL1_CORE */
 #define OMAP24XX_CLKSEL_USB_SHIFT			25
@@ -269,9 +269,9 @@
 
 /* CM_FCLKEN_GFX */
 #define OMAP24XX_EN_3D_SHIFT				2
-#define OMAP24XX_EN_3D					(1 << 2)
+#define OMAP24XX_EN_3D_MASK				(1 << 2)
 #define OMAP24XX_EN_2D_SHIFT				1
-#define OMAP24XX_EN_2D					(1 << 1)
+#define OMAP24XX_EN_2D_MASK				(1 << 1)
 
 /* CM_ICLKEN_GFX specific bits */
 
@@ -287,13 +287,13 @@
 
 /* CM_ICLKEN_WKUP specific bits */
 #define OMAP2430_EN_ICR_SHIFT				6
-#define OMAP2430_EN_ICR					(1 << 6)
+#define OMAP2430_EN_ICR_MASK				(1 << 6)
 #define OMAP24XX_EN_OMAPCTRL_SHIFT			5
-#define OMAP24XX_EN_OMAPCTRL				(1 << 5)
+#define OMAP24XX_EN_OMAPCTRL_MASK			(1 << 5)
 #define OMAP24XX_EN_WDT1_SHIFT				4
-#define OMAP24XX_EN_WDT1				(1 << 4)
+#define OMAP24XX_EN_WDT1_MASK				(1 << 4)
 #define OMAP24XX_EN_32KSYNC_SHIFT			1
-#define OMAP24XX_EN_32KSYNC				(1 << 1)
+#define OMAP24XX_EN_32KSYNC_MASK			(1 << 1)
 
 /* CM_IDLEST_WKUP specific bits */
 #define OMAP2430_ST_ICR_SHIFT				6
@@ -308,12 +308,12 @@
 #define OMAP24XX_ST_32KSYNC_MASK			(1 << 1)
 
 /* CM_AUTOIDLE_WKUP */
-#define OMAP24XX_AUTO_OMAPCTRL				(1 << 5)
-#define OMAP24XX_AUTO_WDT1				(1 << 4)
-#define OMAP24XX_AUTO_MPU_WDT				(1 << 3)
-#define OMAP24XX_AUTO_GPIOS				(1 << 2)
-#define OMAP24XX_AUTO_32KSYNC				(1 << 1)
-#define OMAP24XX_AUTO_GPT1				(1 << 0)
+#define OMAP24XX_AUTO_OMAPCTRL_MASK			(1 << 5)
+#define OMAP24XX_AUTO_WDT1_MASK				(1 << 4)
+#define OMAP24XX_AUTO_MPU_WDT_MASK			(1 << 3)
+#define OMAP24XX_AUTO_GPIOS_MASK			(1 << 2)
+#define OMAP24XX_AUTO_32KSYNC_MASK			(1 << 1)
+#define OMAP24XX_AUTO_GPT1_MASK				(1 << 0)
 
 /* CM_CLKSEL_WKUP */
 #define OMAP24XX_CLKSEL_GPT1_SHIFT			0
@@ -328,12 +328,12 @@
 #define OMAP24XX_EN_DPLL_MASK				(0x3 << 0)
 
 /* CM_IDLEST_CKGEN */
-#define OMAP24XX_ST_54M_APLL				(1 << 9)
-#define OMAP24XX_ST_96M_APLL				(1 << 8)
-#define OMAP24XX_ST_54M_CLK				(1 << 6)
-#define OMAP24XX_ST_12M_CLK				(1 << 5)
-#define OMAP24XX_ST_48M_CLK				(1 << 4)
-#define OMAP24XX_ST_96M_CLK				(1 << 2)
+#define OMAP24XX_ST_54M_APLL_MASK			(1 << 9)
+#define OMAP24XX_ST_96M_APLL_MASK			(1 << 8)
+#define OMAP24XX_ST_54M_CLK_MASK			(1 << 6)
+#define OMAP24XX_ST_12M_CLK_MASK			(1 << 5)
+#define OMAP24XX_ST_48M_CLK_MASK			(1 << 4)
+#define OMAP24XX_ST_96M_CLK_MASK			(1 << 2)
 #define OMAP24XX_ST_CORE_CLK_SHIFT			0
 #define OMAP24XX_ST_CORE_CLK_MASK			(0x3 << 0)
 
@@ -355,11 +355,11 @@
 #define OMAP24XX_DPLL_DIV_SHIFT				8
 #define OMAP24XX_DPLL_DIV_MASK				(0xf << 8)
 #define OMAP24XX_54M_SOURCE_SHIFT			5
-#define OMAP24XX_54M_SOURCE				(1 << 5)
+#define OMAP24XX_54M_SOURCE_MASK			(1 << 5)
 #define OMAP2430_96M_SOURCE_SHIFT			4
-#define OMAP2430_96M_SOURCE				(1 << 4)
+#define OMAP2430_96M_SOURCE_MASK			(1 << 4)
 #define OMAP24XX_48M_SOURCE_SHIFT			3
-#define OMAP24XX_48M_SOURCE				(1 << 3)
+#define OMAP24XX_48M_SOURCE_MASK			(1 << 3)
 #define OMAP2430_ALTCLK_SOURCE_SHIFT			0
 #define OMAP2430_ALTCLK_SOURCE_MASK			(0x7 << 0)
 
@@ -369,29 +369,29 @@
 
 /* CM_FCLKEN_DSP */
 #define OMAP2420_EN_IVA_COP_SHIFT			10
-#define OMAP2420_EN_IVA_COP				(1 << 10)
+#define OMAP2420_EN_IVA_COP_MASK			(1 << 10)
 #define OMAP2420_EN_IVA_MPU_SHIFT			8
-#define OMAP2420_EN_IVA_MPU				(1 << 8)
+#define OMAP2420_EN_IVA_MPU_MASK			(1 << 8)
 #define OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT		0
-#define OMAP24XX_CM_FCLKEN_DSP_EN_DSP			(1 << 0)
+#define OMAP24XX_CM_FCLKEN_DSP_EN_DSP_MASK		(1 << 0)
 
 /* CM_ICLKEN_DSP */
 #define OMAP2420_EN_DSP_IPI_SHIFT			1
-#define OMAP2420_EN_DSP_IPI				(1 << 1)
+#define OMAP2420_EN_DSP_IPI_MASK			(1 << 1)
 
 /* CM_IDLEST_DSP */
-#define OMAP2420_ST_IVA					(1 << 8)
-#define OMAP2420_ST_IPI					(1 << 1)
-#define OMAP24XX_ST_DSP					(1 << 0)
+#define OMAP2420_ST_IVA_MASK				(1 << 8)
+#define OMAP2420_ST_IPI_MASK				(1 << 1)
+#define OMAP24XX_ST_DSP_MASK				(1 << 0)
 
 /* CM_AUTOIDLE_DSP */
-#define OMAP2420_AUTO_DSP_IPI				(1 << 1)
+#define OMAP2420_AUTO_DSP_IPI_MASK			(1 << 1)
 
 /* CM_CLKSEL_DSP */
-#define OMAP2420_SYNC_IVA				(1 << 13)
+#define OMAP2420_SYNC_IVA_MASK				(1 << 13)
 #define OMAP2420_CLKSEL_IVA_SHIFT			8
 #define OMAP2420_CLKSEL_IVA_MASK			(0x1f << 8)
-#define OMAP24XX_SYNC_DSP				(1 << 7)
+#define OMAP24XX_SYNC_DSP_MASK				(1 << 7)
 #define OMAP24XX_CLKSEL_DSP_IF_SHIFT			5
 #define OMAP24XX_CLKSEL_DSP_IF_MASK			(0x3 << 5)
 #define OMAP24XX_CLKSEL_DSP_SHIFT			0
@@ -406,24 +406,24 @@
 /* CM_FCLKEN_MDM */
 /* 2430 only */
 #define OMAP2430_EN_OSC_SHIFT				1
-#define OMAP2430_EN_OSC					(1 << 1)
+#define OMAP2430_EN_OSC_MASK				(1 << 1)
 
 /* CM_ICLKEN_MDM */
 /* 2430 only */
 #define OMAP2430_CM_ICLKEN_MDM_EN_MDM_SHIFT		0
-#define OMAP2430_CM_ICLKEN_MDM_EN_MDM			(1 << 0)
+#define OMAP2430_CM_ICLKEN_MDM_EN_MDM_MASK		(1 << 0)
 
 /* CM_IDLEST_MDM specific bits */
 /* 2430 only */
 
 /* CM_AUTOIDLE_MDM */
 /* 2430 only */
-#define OMAP2430_AUTO_OSC				(1 << 1)
-#define OMAP2430_AUTO_MDM				(1 << 0)
+#define OMAP2430_AUTO_OSC_MASK				(1 << 1)
+#define OMAP2430_AUTO_MDM_MASK				(1 << 0)
 
 /* CM_CLKSEL_MDM */
 /* 2430 only */
-#define OMAP2430_SYNC_MDM				(1 << 4)
+#define OMAP2430_SYNC_MDM_MASK				(1 << 4)
 #define OMAP2430_CLKSEL_MDM_SHIFT			0
 #define OMAP2430_CLKSEL_MDM_MASK			(0xf << 0)
 
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 374299e..ca6d373 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -170,7 +170,7 @@ static int omap2_i2c_active(void)
 	u32 l;
 
 	l = cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
-	return l & (OMAP2420_EN_I2C2 | OMAP2420_EN_I2C1);
+	return l & (OMAP2420_EN_I2C2_MASK | OMAP2420_EN_I2C1_MASK);
 }
 
 static int sti_console_enabled;
@@ -183,7 +183,7 @@ static int omap2_allow_mpu_retention(void)
 	l = cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
 	if (l & (OMAP2420_EN_MMC | OMAP24XX_EN_UART2 |
 		 OMAP24XX_EN_UART1 | OMAP24XX_EN_MCSPI2 |
-		 OMAP24XX_EN_MCSPI1 | OMAP24XX_EN_DSS1))
+		 OMAP24XX_EN_MCSPI1 | OMAP24XX_EN_DSS1_MASK))
 		return 0;
 	/* Check for UART3. */
 	l = cm_read_mod_reg(CORE_MOD, OMAP24XX_CM_FCLKEN2);
@@ -351,7 +351,7 @@ static void __init prcm_setup_regs(void)
 	struct powerdomain *pwrdm;
 
 	/* Enable autoidle */
-	prm_write_mod_reg(OMAP24XX_AUTOIDLE, OCP_MOD,
+	prm_write_mod_reg(OMAP24XX_AUTOIDLE_MASK, OCP_MOD,
 			  OMAP2_PRCM_SYSCONFIG_OFFSET);
 
 	/*
@@ -390,53 +390,54 @@ static void __init prcm_setup_regs(void)
 	clkdm_add_wkdep(mpu_clkdm, wkup_clkdm);
 
 	/* Enable clock autoidle for all domains */
-	cm_write_mod_reg(OMAP24XX_AUTO_CAM |
-			 OMAP24XX_AUTO_MAILBOXES |
-			 OMAP24XX_AUTO_WDT4 |
-			 OMAP2420_AUTO_WDT3 |
-			 OMAP24XX_AUTO_MSPRO |
-			 OMAP2420_AUTO_MMC |
-			 OMAP24XX_AUTO_FAC |
-			 OMAP2420_AUTO_EAC |
-			 OMAP24XX_AUTO_HDQ |
-			 OMAP24XX_AUTO_UART2 |
-			 OMAP24XX_AUTO_UART1 |
-			 OMAP24XX_AUTO_I2C2 |
-			 OMAP24XX_AUTO_I2C1 |
-			 OMAP24XX_AUTO_MCSPI2 |
-			 OMAP24XX_AUTO_MCSPI1 |
-			 OMAP24XX_AUTO_MCBSP2 |
-			 OMAP24XX_AUTO_MCBSP1 |
-			 OMAP24XX_AUTO_GPT12 |
-			 OMAP24XX_AUTO_GPT11 |
-			 OMAP24XX_AUTO_GPT10 |
-			 OMAP24XX_AUTO_GPT9 |
-			 OMAP24XX_AUTO_GPT8 |
-			 OMAP24XX_AUTO_GPT7 |
-			 OMAP24XX_AUTO_GPT6 |
-			 OMAP24XX_AUTO_GPT5 |
-			 OMAP24XX_AUTO_GPT4 |
-			 OMAP24XX_AUTO_GPT3 |
-			 OMAP24XX_AUTO_GPT2 |
-			 OMAP2420_AUTO_VLYNQ |
-			 OMAP24XX_AUTO_DSS,
+	cm_write_mod_reg(OMAP24XX_AUTO_CAM_MASK |
+			 OMAP24XX_AUTO_MAILBOXES_MASK |
+			 OMAP24XX_AUTO_WDT4_MASK |
+			 OMAP2420_AUTO_WDT3_MASK |
+			 OMAP24XX_AUTO_MSPRO_MASK |
+			 OMAP2420_AUTO_MMC_MASK |
+			 OMAP24XX_AUTO_FAC_MASK |
+			 OMAP2420_AUTO_EAC_MASK |
+			 OMAP24XX_AUTO_HDQ_MASK |
+			 OMAP24XX_AUTO_UART2_MASK |
+			 OMAP24XX_AUTO_UART1_MASK |
+			 OMAP24XX_AUTO_I2C2_MASK |
+			 OMAP24XX_AUTO_I2C1_MASK |
+			 OMAP24XX_AUTO_MCSPI2_MASK |
+			 OMAP24XX_AUTO_MCSPI1_MASK |
+			 OMAP24XX_AUTO_MCBSP2_MASK |
+			 OMAP24XX_AUTO_MCBSP1_MASK |
+			 OMAP24XX_AUTO_GPT12_MASK |
+			 OMAP24XX_AUTO_GPT11_MASK |
+			 OMAP24XX_AUTO_GPT10_MASK |
+			 OMAP24XX_AUTO_GPT9_MASK |
+			 OMAP24XX_AUTO_GPT8_MASK |
+			 OMAP24XX_AUTO_GPT7_MASK |
+			 OMAP24XX_AUTO_GPT6_MASK |
+			 OMAP24XX_AUTO_GPT5_MASK |
+			 OMAP24XX_AUTO_GPT4_MASK |
+			 OMAP24XX_AUTO_GPT3_MASK |
+			 OMAP24XX_AUTO_GPT2_MASK |
+			 OMAP2420_AUTO_VLYNQ_MASK |
+			 OMAP24XX_AUTO_DSS_MASK,
 			 CORE_MOD, CM_AUTOIDLE1);
-	cm_write_mod_reg(OMAP24XX_AUTO_UART3 |
-			 OMAP24XX_AUTO_SSI |
-			 OMAP24XX_AUTO_USB,
+	cm_write_mod_reg(OMAP24XX_AUTO_UART3_MASK |
+			 OMAP24XX_AUTO_SSI_MASK |
+			 OMAP24XX_AUTO_USB_MASK,
 			 CORE_MOD, CM_AUTOIDLE2);
-	cm_write_mod_reg(OMAP24XX_AUTO_SDRC |
-			 OMAP24XX_AUTO_GPMC |
-			 OMAP24XX_AUTO_SDMA,
+	cm_write_mod_reg(OMAP24XX_AUTO_SDRC_MASK |
+			 OMAP24XX_AUTO_GPMC_MASK |
+			 OMAP24XX_AUTO_SDMA_MASK,
 			 CORE_MOD, CM_AUTOIDLE3);
-	cm_write_mod_reg(OMAP24XX_AUTO_PKA |
-			 OMAP24XX_AUTO_AES |
-			 OMAP24XX_AUTO_RNG |
-			 OMAP24XX_AUTO_SHA |
-			 OMAP24XX_AUTO_DES,
+	cm_write_mod_reg(OMAP24XX_AUTO_PKA_MASK |
+			 OMAP24XX_AUTO_AES_MASK |
+			 OMAP24XX_AUTO_RNG_MASK |
+			 OMAP24XX_AUTO_SHA_MASK |
+			 OMAP24XX_AUTO_DES_MASK,
 			 CORE_MOD, OMAP24XX_CM_AUTOIDLE4);
 
-	cm_write_mod_reg(OMAP2420_AUTO_DSP_IPI, OMAP24XX_DSP_MOD, CM_AUTOIDLE);
+	cm_write_mod_reg(OMAP2420_AUTO_DSP_IPI_MASK, OMAP24XX_DSP_MOD,
+			 CM_AUTOIDLE);
 
 	/* Put DPLL and both APLLs into autoidle mode */
 	cm_write_mod_reg((0x03 << OMAP24XX_AUTO_DPLL_SHIFT) |
@@ -444,12 +445,12 @@ static void __init prcm_setup_regs(void)
 			 (0x03 << OMAP24XX_AUTO_54M_SHIFT),
 			 PLL_MOD, CM_AUTOIDLE);
 
-	cm_write_mod_reg(OMAP24XX_AUTO_OMAPCTRL |
-			 OMAP24XX_AUTO_WDT1 |
-			 OMAP24XX_AUTO_MPU_WDT |
-			 OMAP24XX_AUTO_GPIOS |
-			 OMAP24XX_AUTO_32KSYNC |
-			 OMAP24XX_AUTO_GPT1,
+	cm_write_mod_reg(OMAP24XX_AUTO_OMAPCTRL_MASK |
+			 OMAP24XX_AUTO_WDT1_MASK |
+			 OMAP24XX_AUTO_MPU_WDT_MASK |
+			 OMAP24XX_AUTO_GPIOS_MASK |
+			 OMAP24XX_AUTO_32KSYNC_MASK |
+			 OMAP24XX_AUTO_GPT1_MASK,
 			 WKUP_MOD, CM_AUTOIDLE);
 
 	/* REVISIT: Configure number of 32 kHz clock cycles for sys_clk
@@ -460,9 +461,9 @@ static void __init prcm_setup_regs(void)
 	/* Configure automatic voltage transition */
 	prm_write_mod_reg(2 << OMAP_SETUP_TIME_SHIFT, OMAP24XX_GR_MOD,
 			  OMAP2_PRCM_VOLTSETUP_OFFSET);
-	prm_write_mod_reg(OMAP24XX_AUTO_EXTVOLT |
+	prm_write_mod_reg(OMAP24XX_AUTO_EXTVOLT_MASK |
 			  (0x1 << OMAP24XX_SETOFF_LEVEL_SHIFT) |
-			  OMAP24XX_MEMRETCTRL |
+			  OMAP24XX_MEMRETCTRL_MASK |
 			  (0x1 << OMAP24XX_SETRET_LEVEL_SHIFT) |
 			  (0x0 << OMAP24XX_VOLT_LEVEL_SHIFT),
 			  OMAP24XX_GR_MOD, OMAP2_PRCM_VOLTCTRL_OFFSET);
diff --git a/arch/arm/mach-omap2/prm-regbits-24xx.h b/arch/arm/mach-omap2/prm-regbits-24xx.h
index 4002051..0b188ff 100644
--- a/arch/arm/mach-omap2/prm-regbits-24xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-24xx.h
@@ -19,14 +19,14 @@
 /* Bits shared between registers */
 
 /* PRCM_IRQSTATUS_MPU, PM_IRQSTATUS_DSP, PRCM_IRQSTATUS_IVA shared bits */
-#define OMAP24XX_VOLTTRANS_ST				(1 << 2)
-#define OMAP24XX_WKUP2_ST				(1 << 1)
-#define OMAP24XX_WKUP1_ST				(1 << 0)
+#define OMAP24XX_VOLTTRANS_ST_MASK			(1 << 2)
+#define OMAP24XX_WKUP2_ST_MASK				(1 << 1)
+#define OMAP24XX_WKUP1_ST_MASK				(1 << 0)
 
 /* PRCM_IRQENABLE_MPU, PM_IRQENABLE_DSP, PRCM_IRQENABLE_IVA shared bits */
-#define OMAP24XX_VOLTTRANS_EN				(1 << 2)
-#define OMAP24XX_WKUP2_EN				(1 << 1)
-#define OMAP24XX_WKUP1_EN				(1 << 0)
+#define OMAP24XX_VOLTTRANS_EN_MASK			(1 << 2)
+#define OMAP24XX_WKUP2_EN_MASK				(1 << 1)
+#define OMAP24XX_WKUP1_EN_MASK				(1 << 0)
 
 /* PM_WKDEP_GFX, PM_WKDEP_MPU, PM_WKDEP_DSP, PM_WKDEP_MDM shared bits */
 #define OMAP24XX_EN_MPU_SHIFT				1
@@ -40,16 +40,16 @@
  */
 #define OMAP24XX_MEMONSTATE_SHIFT			10
 #define OMAP24XX_MEMONSTATE_MASK			(0x3 << 10)
-#define OMAP24XX_MEMRETSTATE				(1 << 3)
+#define OMAP24XX_MEMRETSTATE_MASK			(1 << 3)
 
 /* PM_PWSTCTRL_GFX, PM_PWSTCTRL_DSP, PM_PWSTCTRL_MDM shared bits */
-#define OMAP24XX_FORCESTATE				(1 << 18)
+#define OMAP24XX_FORCESTATE_MASK			(1 << 18)
 
 /*
  * PM_PWSTST_CORE, PM_PWSTST_GFX, PM_PWSTST_MPU, PM_PWSTST_DSP,
  * PM_PWSTST_MDM shared bits
  */
-#define OMAP24XX_CLKACTIVITY				(1 << 19)
+#define OMAP24XX_CLKACTIVITY_MASK			(1 << 19)
 
 /* PM_PWSTST_MPU, PM_PWSTST_CORE, PM_PWSTST_DSP shared bits */
 #define OMAP24XX_LASTSTATEENTERED_SHIFT			4
@@ -71,26 +71,26 @@
 #define OMAP24XX_REV_MASK				(0xff << 0)
 
 /* PRCM_SYSCONFIG */
-#define OMAP24XX_AUTOIDLE				(1 << 0)
+#define OMAP24XX_AUTOIDLE_MASK				(1 << 0)
 
 /* PRCM_IRQSTATUS_MPU specific bits */
-#define OMAP2430_DPLL_RECAL_ST				(1 << 6)
-#define OMAP24XX_TRANSITION_ST				(1 << 5)
-#define OMAP24XX_EVGENOFF_ST				(1 << 4)
-#define OMAP24XX_EVGENON_ST				(1 << 3)
+#define OMAP2430_DPLL_RECAL_ST_MASK			(1 << 6)
+#define OMAP24XX_TRANSITION_ST_MASK			(1 << 5)
+#define OMAP24XX_EVGENOFF_ST_MASK			(1 << 4)
+#define OMAP24XX_EVGENON_ST_MASK			(1 << 3)
 
 /* PRCM_IRQENABLE_MPU specific bits */
-#define OMAP2430_DPLL_RECAL_EN				(1 << 6)
-#define OMAP24XX_TRANSITION_EN				(1 << 5)
-#define OMAP24XX_EVGENOFF_EN				(1 << 4)
-#define OMAP24XX_EVGENON_EN				(1 << 3)
+#define OMAP2430_DPLL_RECAL_EN_MASK			(1 << 6)
+#define OMAP24XX_TRANSITION_EN_MASK			(1 << 5)
+#define OMAP24XX_EVGENOFF_EN_MASK			(1 << 4)
+#define OMAP24XX_EVGENON_EN_MASK			(1 << 3)
 
 /* PRCM_VOLTCTRL */
-#define OMAP24XX_AUTO_EXTVOLT				(1 << 15)
-#define OMAP24XX_FORCE_EXTVOLT				(1 << 14)
+#define OMAP24XX_AUTO_EXTVOLT_MASK			(1 << 15)
+#define OMAP24XX_FORCE_EXTVOLT_MASK			(1 << 14)
 #define OMAP24XX_SETOFF_LEVEL_SHIFT			12
 #define OMAP24XX_SETOFF_LEVEL_MASK			(0x3 << 12)
-#define OMAP24XX_MEMRETCTRL				(1 << 8)
+#define OMAP24XX_MEMRETCTRL_MASK			(1 << 8)
 #define OMAP24XX_SETRET_LEVEL_SHIFT			6
 #define OMAP24XX_SETRET_LEVEL_MASK			(0x3 << 6)
 #define OMAP24XX_VOLT_LEVEL_SHIFT			0
@@ -104,13 +104,13 @@
 
 /* PRCM_CLKOUT_CTRL */
 #define OMAP2420_CLKOUT2_EN_SHIFT			15
-#define OMAP2420_CLKOUT2_EN				(1 << 15)
+#define OMAP2420_CLKOUT2_EN_MASK			(1 << 15)
 #define OMAP2420_CLKOUT2_DIV_SHIFT			11
 #define OMAP2420_CLKOUT2_DIV_MASK			(0x7 << 11)
 #define OMAP2420_CLKOUT2_SOURCE_SHIFT			8
 #define OMAP2420_CLKOUT2_SOURCE_MASK			(0x3 << 8)
 #define OMAP24XX_CLKOUT_EN_SHIFT			7
-#define OMAP24XX_CLKOUT_EN				(1 << 7)
+#define OMAP24XX_CLKOUT_EN_MASK				(1 << 7)
 #define OMAP24XX_CLKOUT_DIV_SHIFT			3
 #define OMAP24XX_CLKOUT_DIV_MASK			(0x7 << 3)
 #define OMAP24XX_CLKOUT_SOURCE_SHIFT			0
@@ -118,25 +118,25 @@
 
 /* PRCM_CLKEMUL_CTRL */
 #define OMAP24XX_EMULATION_EN_SHIFT			0
-#define OMAP24XX_EMULATION_EN				(1 << 0)
+#define OMAP24XX_EMULATION_EN_MASK			(1 << 0)
 
 /* PRCM_CLKCFG_CTRL */
-#define OMAP24XX_VALID_CONFIG				(1 << 0)
+#define OMAP24XX_VALID_CONFIG_MASK			(1 << 0)
 
 /* PRCM_CLKCFG_STATUS */
-#define OMAP24XX_CONFIG_STATUS				(1 << 0)
+#define OMAP24XX_CONFIG_STATUS_MASK			(1 << 0)
 
 /* PRCM_VOLTSETUP specific bits */
 
 /* PRCM_CLKSSETUP specific bits */
 
 /* PRCM_POLCTRL */
-#define OMAP2420_CLKOUT2_POL				(1 << 10)
-#define OMAP24XX_CLKOUT_POL				(1 << 9)
-#define OMAP24XX_CLKREQ_POL				(1 << 8)
-#define OMAP2430_USE_POWEROK				(1 << 2)
-#define OMAP2430_POWEROK_POL				(1 << 1)
-#define OMAP24XX_EXTVOL_POL				(1 << 0)
+#define OMAP2420_CLKOUT2_POL_MASK			(1 << 10)
+#define OMAP24XX_CLKOUT_POL_MASK			(1 << 9)
+#define OMAP24XX_CLKREQ_POL_MASK			(1 << 8)
+#define OMAP2430_USE_POWEROK_MASK			(1 << 2)
+#define OMAP2430_POWEROK_POL_MASK			(1 << 1)
+#define OMAP24XX_EXTVOL_POL_MASK			(1 << 0)
 
 /* RM_RSTST_MPU specific bits */
 /* 2430 calls GLOBALWMPU_RST "GLOBALWARM_RST" instead */
@@ -154,7 +154,7 @@
 /* PM_EVEGENOFFTIM_MPU specific bits */
 
 /* PM_PWSTCTRL_MPU specific bits */
-#define OMAP2430_FORCESTATE				(1 << 18)
+#define OMAP2430_FORCESTATE_MASK			(1 << 18)
 
 /* PM_PWSTST_MPU specific bits */
 /* INTRANSITION, CLKACTIVITY, POWERSTATE, MEMSTATEST are 2430 only */
@@ -168,21 +168,21 @@
 /* PM_WKST2_CORE specific bits */
 
 /* PM_WKDEP_CORE specific bits*/
-#define OMAP2430_PM_WKDEP_CORE_EN_MDM			(1 << 5)
-#define OMAP24XX_PM_WKDEP_CORE_EN_GFX			(1 << 3)
-#define OMAP24XX_PM_WKDEP_CORE_EN_DSP			(1 << 2)
+#define OMAP2430_PM_WKDEP_CORE_EN_MDM_MASK		(1 << 5)
+#define OMAP24XX_PM_WKDEP_CORE_EN_GFX_MASK		(1 << 3)
+#define OMAP24XX_PM_WKDEP_CORE_EN_DSP_MASK		(1 << 2)
 
 /* PM_PWSTCTRL_CORE specific bits */
-#define OMAP24XX_MEMORYCHANGE				(1 << 20)
+#define OMAP24XX_MEMORYCHANGE_MASK			(1 << 20)
 #define OMAP24XX_MEM3ONSTATE_SHIFT			14
 #define OMAP24XX_MEM3ONSTATE_MASK			(0x3 << 14)
 #define OMAP24XX_MEM2ONSTATE_SHIFT			12
 #define OMAP24XX_MEM2ONSTATE_MASK			(0x3 << 12)
 #define OMAP24XX_MEM1ONSTATE_SHIFT			10
 #define OMAP24XX_MEM1ONSTATE_MASK			(0x3 << 10)
-#define OMAP24XX_MEM3RETSTATE				(1 << 5)
-#define OMAP24XX_MEM2RETSTATE				(1 << 4)
-#define OMAP24XX_MEM1RETSTATE				(1 << 3)
+#define OMAP24XX_MEM3RETSTATE_MASK			(1 << 5)
+#define OMAP24XX_MEM2RETSTATE_MASK			(1 << 4)
+#define OMAP24XX_MEM1RETSTATE_MASK			(1 << 3)
 
 /* PM_PWSTST_CORE specific bits */
 #define OMAP24XX_MEM3STATEST_SHIFT			14
@@ -193,10 +193,10 @@
 #define OMAP24XX_MEM1STATEST_MASK			(0x3 << 10)
 
 /* RM_RSTCTRL_GFX */
-#define OMAP24XX_GFX_RST				(1 << 0)
+#define OMAP24XX_GFX_RST_MASK				(1 << 0)
 
 /* RM_RSTST_GFX specific bits */
-#define OMAP24XX_GFX_SW_RST				(1 << 4)
+#define OMAP24XX_GFX_SW_RST_MASK			(1 << 4)
 
 /* PM_PWSTCTRL_GFX specific bits */
 
@@ -209,25 +209,25 @@
 
 /* RM_RSTST_WKUP specific bits */
 /* 2430 calls EXTWMPU_RST "EXTWARM_RST" and GLOBALWMPU_RST "GLOBALWARM_RST" */
-#define OMAP24XX_EXTWMPU_RST				(1 << 6)
-#define OMAP24XX_SECU_WD_RST				(1 << 5)
-#define OMAP24XX_MPU_WD_RST				(1 << 4)
-#define OMAP24XX_SECU_VIOL_RST				(1 << 3)
+#define OMAP24XX_EXTWMPU_RST_MASK			(1 << 6)
+#define OMAP24XX_SECU_WD_RST_MASK			(1 << 5)
+#define OMAP24XX_MPU_WD_RST_MASK			(1 << 4)
+#define OMAP24XX_SECU_VIOL_RST_MASK			(1 << 3)
 
 /* PM_WKEN_WKUP specific bits */
 
 /* PM_WKST_WKUP specific bits */
 
 /* RM_RSTCTRL_DSP */
-#define OMAP2420_RST_IVA				(1 << 8)
-#define OMAP24XX_RST2_DSP				(1 << 1)
-#define OMAP24XX_RST1_DSP				(1 << 0)
+#define OMAP2420_RST_IVA_MASK				(1 << 8)
+#define OMAP24XX_RST2_DSP_MASK				(1 << 1)
+#define OMAP24XX_RST1_DSP_MASK				(1 << 0)
 
 /* RM_RSTST_DSP specific bits */
 /* 2430 calls GLOBALWMPU_RST "GLOBALWARM_RST" */
-#define OMAP2420_IVA_SW_RST				(1 << 8)
-#define OMAP24XX_DSP_SW_RST2				(1 << 5)
-#define OMAP24XX_DSP_SW_RST1				(1 << 4)
+#define OMAP2420_IVA_SW_RST_MASK			(1 << 8)
+#define OMAP24XX_DSP_SW_RST2_MASK			(1 << 5)
+#define OMAP24XX_DSP_SW_RST1_MASK			(1 << 4)
 
 /* PM_WKDEP_DSP specific bits */
 
@@ -235,7 +235,7 @@
 /* 2430 only: MEMONSTATE, MEMRETSTATE */
 #define OMAP2420_MEMIONSTATE_SHIFT			12
 #define OMAP2420_MEMIONSTATE_MASK			(0x3 << 12)
-#define OMAP2420_MEMIRETSTATE				(1 << 4)
+#define OMAP2420_MEMIRETSTATE_MASK			(1 << 4)
 
 /* PM_PWSTST_DSP specific bits */
 /* MEMSTATEST is 2430 only */
@@ -248,18 +248,18 @@
 
 /* RM_RSTCTRL_MDM */
 /* 2430 only */
-#define OMAP2430_PWRON1_MDM				(1 << 1)
-#define OMAP2430_RST1_MDM				(1 << 0)
+#define OMAP2430_PWRON1_MDM_MASK			(1 << 1)
+#define OMAP2430_RST1_MDM_MASK				(1 << 0)
 
 /* RM_RSTST_MDM specific bits */
 /* 2430 only */
-#define OMAP2430_MDM_SECU_VIOL				(1 << 6)
-#define OMAP2430_MDM_SW_PWRON1				(1 << 5)
-#define OMAP2430_MDM_SW_RST1				(1 << 4)
+#define OMAP2430_MDM_SECU_VIOL_MASK			(1 << 6)
+#define OMAP2430_MDM_SW_PWRON1_MASK			(1 << 5)
+#define OMAP2430_MDM_SW_RST1_MASK			(1 << 4)
 
 /* PM_WKEN_MDM */
 /* 2430 only */
-#define OMAP2430_PM_WKEN_MDM_EN_MDM			(1 << 0)
+#define OMAP2430_PM_WKEN_MDM_EN_MDM_MASK		(1 << 0)
 
 /* PM_WKST_MDM specific bits */
 /* 2430 only */
@@ -269,7 +269,7 @@
 
 /* PM_PWSTCTRL_MDM specific bits */
 /* 2430 only */
-#define OMAP2430_KILLDOMAINWKUP				(1 << 19)
+#define OMAP2430_KILLDOMAINWKUP_MASK			(1 << 19)
 
 /* PM_PWSTST_MDM specific bits */
 /* 2430 only */


