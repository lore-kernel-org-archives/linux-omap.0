From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 04/10] OMAP2+ PRCM: convert remaining PRCM macros to the
	_SHIFT/_MASK suffixes
Date: Mon, 26 Apr 2010 01:04:25 -0600
Message-ID: <20100426070424.9743.59832.stgit@localhost.localdomain>
References: <20100426070217.9743.92728.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52237 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754264Ab0DZHHe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 03:07:34 -0400
In-Reply-To: <20100426070217.9743.92728.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

Fix all of the remaining PRCM register shift/bitmask macros that did not
use the _SHIFT/_MASK suffixes to use them.  This makes the use of these
macros consistent.  It is intended to reduce error, as code can be inspected
visually by reviewers to ensure that bitshifts and bitmasks are used in
the appropriate places.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/cm.h          |    5 +
 arch/arm/mach-omap2/pm24xx.c      |   21 +++--
 arch/arm/mach-omap2/pm34xx.c      |   30 ++++----
 arch/arm/mach-omap2/powerdomain.c |    2 -
 arch/arm/mach-omap2/prcm-common.h |  146 +++++++++++++++++++------------------
 arch/arm/mach-omap2/prcm.c        |    4 +
 arch/arm/mach-omap2/prm.h         |   18 ++---
 7 files changed, 114 insertions(+), 112 deletions(-)

diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index 94728b1..b6ab183 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -134,10 +134,11 @@ static inline u32 cm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
 
 /* CM_ICLKEN_GFX */
 #define OMAP_EN_GFX_SHIFT				0
-#define OMAP_EN_GFX					(1 << 0)
+#define OMAP_EN_GFX_MASK				(1 << 0)
 
 /* CM_IDLEST_GFX */
-#define OMAP_ST_GFX					(1 << 0)
+#define OMAP_ST_GFX_MASK				(1 << 0)
+
 
 /* CM_IDLEST indicator */
 #define OMAP24XX_CM_IDLEST_VAL		0
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index ca6d373..3bb34b9 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -70,8 +70,8 @@ static int omap2_fclks_active(void)
 	f2 = cm_read_mod_reg(CORE_MOD, OMAP24XX_CM_FCLKEN2);
 
 	/* Ignore UART clocks.  These are handled by UART core (serial.c) */
-	f1 &= ~(OMAP24XX_EN_UART1 | OMAP24XX_EN_UART2);
-	f2 &= ~OMAP24XX_EN_UART3;
+	f1 &= ~(OMAP24XX_EN_UART1_MASK | OMAP24XX_EN_UART2_MASK);
+	f2 &= ~OMAP24XX_EN_UART3_MASK;
 
 	if (f1 | f2)
 		return 1;
@@ -181,13 +181,13 @@ static int omap2_allow_mpu_retention(void)
 
 	/* Check for MMC, UART2, UART1, McSPI2, McSPI1 and DSS1. */
 	l = cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
-	if (l & (OMAP2420_EN_MMC | OMAP24XX_EN_UART2 |
-		 OMAP24XX_EN_UART1 | OMAP24XX_EN_MCSPI2 |
-		 OMAP24XX_EN_MCSPI1 | OMAP24XX_EN_DSS1_MASK))
+	if (l & (OMAP2420_EN_MMC_MASK | OMAP24XX_EN_UART2_MASK |
+		 OMAP24XX_EN_UART1_MASK | OMAP24XX_EN_MCSPI2_MASK |
+		 OMAP24XX_EN_MCSPI1_MASK | OMAP24XX_EN_DSS1_MASK))
 		return 0;
 	/* Check for UART3. */
 	l = cm_read_mod_reg(CORE_MOD, OMAP24XX_CM_FCLKEN2);
-	if (l & OMAP24XX_EN_UART3)
+	if (l & OMAP24XX_EN_UART3_MASK)
 		return 0;
 	if (sti_console_enabled)
 		return 0;
@@ -215,12 +215,12 @@ static void omap2_enter_mpu_retention(void)
 
 		/* Try to enter MPU retention */
 		prm_write_mod_reg((0x01 << OMAP_POWERSTATE_SHIFT) |
-				  OMAP_LOGICRETSTATE,
+				  OMAP_LOGICRETSTATE_MASK,
 				  MPU_MOD, OMAP2_PM_PWSTCTRL);
 	} else {
 		/* Block MPU retention */
 
-		prm_write_mod_reg(OMAP_LOGICRETSTATE, MPU_MOD,
+		prm_write_mod_reg(OMAP_LOGICRETSTATE_MASK, MPU_MOD,
 						 OMAP2_PM_PWSTCTRL);
 		only_idle = 1;
 	}
@@ -288,7 +288,8 @@ static int omap2_pm_suspend(void)
 	u32 wken_wkup, mir1;
 
 	wken_wkup = prm_read_mod_reg(WKUP_MOD, PM_WKEN);
-	prm_write_mod_reg(wken_wkup & ~OMAP24XX_EN_GPT1, WKUP_MOD, PM_WKEN);
+	wken_wkup &= ~OMAP24XX_EN_GPT1_MASK;
+	prm_write_mod_reg(wken_wkup, WKUP_MOD, PM_WKEN);
 
 	/* Mask GPT1 */
 	mir1 = omap_readl(0x480fe0a4);
@@ -469,7 +470,7 @@ static void __init prcm_setup_regs(void)
 			  OMAP24XX_GR_MOD, OMAP2_PRCM_VOLTCTRL_OFFSET);
 
 	/* Enable wake-up events */
-	prm_write_mod_reg(OMAP24XX_EN_GPIOS | OMAP24XX_EN_GPT1,
+	prm_write_mod_reg(OMAP24XX_EN_GPIOS_MASK | OMAP24XX_EN_GPT1_MASK,
 			  WKUP_MOD, PM_WKEN);
 }
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index b5ea831..e46a5e2 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -851,7 +851,7 @@ static void __init prcm_setup_regs(void)
 			CM_AUTOIDLE);
 	}
 
-	omap_ctrl_writel(OMAP3430_AUTOIDLE, OMAP2_CONTROL_SYSCONFIG);
+	omap_ctrl_writel(OMAP3430_AUTOIDLE_MASK, OMAP2_CONTROL_SYSCONFIG);
 
 	/*
 	 * Set all plls to autoidle. This is needed until autoidle is
@@ -881,12 +881,12 @@ static void __init prcm_setup_regs(void)
 			     OMAP3_PRM_CLKSRC_CTRL_OFFSET);
 
 	/* setup wakup source */
-	prm_write_mod_reg(OMAP3430_EN_IO_MASK | OMAP3430_EN_GPIO1 |
-			  OMAP3430_EN_GPT1 | OMAP3430_EN_GPT12,
+	prm_write_mod_reg(OMAP3430_EN_IO_MASK | OMAP3430_EN_GPIO1_MASK |
+			  OMAP3430_EN_GPT1_MASK | OMAP3430_EN_GPT12_MASK,
 			  WKUP_MOD, PM_WKEN);
 	/* No need to write EN_IO, that is always enabled */
-	prm_write_mod_reg(OMAP3430_EN_GPIO1 | OMAP3430_EN_GPT1 |
-			  OMAP3430_EN_GPT12,
+	prm_write_mod_reg(OMAP3430_EN_GPIO1_MASK | OMAP3430_EN_GPT1_MASK |
+			  OMAP3430_EN_GPT12_MASK,
 			  WKUP_MOD, OMAP3430_PM_MPUGRPSEL);
 	/* For some reason IO doesn't generate wakeup event even if
 	 * it is selected to mpu wakeup goup */
@@ -898,18 +898,18 @@ static void __init prcm_setup_regs(void)
 				OMAP3430_DSS_MOD, PM_WKEN);
 
 	/* Enable wakeups in PER */
-	prm_write_mod_reg(OMAP3430_EN_GPIO2 | OMAP3430_EN_GPIO3 |
-			  OMAP3430_EN_GPIO4 | OMAP3430_EN_GPIO5 |
-			  OMAP3430_EN_GPIO6 | OMAP3430_EN_UART3 |
-			  OMAP3430_EN_MCBSP2 | OMAP3430_EN_MCBSP3 |
-			  OMAP3430_EN_MCBSP4,
+	prm_write_mod_reg(OMAP3430_EN_GPIO2_MASK | OMAP3430_EN_GPIO3_MASK |
+			  OMAP3430_EN_GPIO4_MASK | OMAP3430_EN_GPIO5_MASK |
+			  OMAP3430_EN_GPIO6_MASK | OMAP3430_EN_UART3_MASK |
+			  OMAP3430_EN_MCBSP2_MASK | OMAP3430_EN_MCBSP3_MASK |
+			  OMAP3430_EN_MCBSP4_MASK,
 			  OMAP3430_PER_MOD, PM_WKEN);
 	/* and allow them to wake up MPU */
-	prm_write_mod_reg(OMAP3430_GRPSEL_GPIO2_MASK | OMAP3430_EN_GPIO3 |
-			  OMAP3430_GRPSEL_GPIO4_MASK | OMAP3430_EN_GPIO5 |
-			  OMAP3430_GRPSEL_GPIO6_MASK | OMAP3430_EN_UART3 |
-			  OMAP3430_EN_MCBSP2 | OMAP3430_EN_MCBSP3 |
-			  OMAP3430_EN_MCBSP4,
+	prm_write_mod_reg(OMAP3430_GRPSEL_GPIO2_MASK | OMAP3430_EN_GPIO3_MASK |
+			  OMAP3430_GRPSEL_GPIO4_MASK | OMAP3430_EN_GPIO5_MASK |
+			  OMAP3430_GRPSEL_GPIO6_MASK | OMAP3430_EN_UART3_MASK |
+			  OMAP3430_EN_MCBSP2_MASK | OMAP3430_EN_MCBSP3_MASK |
+			  OMAP3430_EN_MCBSP4_MASK,
 			  OMAP3430_PER_MOD, OMAP3430_PM_MPUGRPSEL);
 
 	/* Don't attach IVA interrupts */
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 637fdfe..4a91d38 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -1004,7 +1004,7 @@ int pwrdm_wait_transition(struct powerdomain *pwrdm)
 
 	/* XXX Is this udelay() value meaningful? */
 	while ((prm_read_mod_reg(pwrdm->prcm_offs, pwrstst_reg_offs) &
-		OMAP_INTRANSITION) &&
+		OMAP_INTRANSITION_MASK) &&
 	       (c++ < PWRDM_TRANSITION_BAILOUT))
 			udelay(1);
 
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index 90f603d..ed2379f 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -132,63 +132,63 @@
 
 /* CM_FCLKEN1_CORE, CM_ICLKEN1_CORE, PM_WKEN1_CORE shared bits */
 #define OMAP2420_EN_MMC_SHIFT				26
-#define OMAP2420_EN_MMC					(1 << 26)
+#define OMAP2420_EN_MMC_MASK				(1 << 26)
 #define OMAP24XX_EN_UART2_SHIFT				22
-#define OMAP24XX_EN_UART2				(1 << 22)
+#define OMAP24XX_EN_UART2_MASK				(1 << 22)
 #define OMAP24XX_EN_UART1_SHIFT				21
-#define OMAP24XX_EN_UART1				(1 << 21)
+#define OMAP24XX_EN_UART1_MASK				(1 << 21)
 #define OMAP24XX_EN_MCSPI2_SHIFT			18
-#define OMAP24XX_EN_MCSPI2				(1 << 18)
+#define OMAP24XX_EN_MCSPI2_MASK				(1 << 18)
 #define OMAP24XX_EN_MCSPI1_SHIFT			17
-#define OMAP24XX_EN_MCSPI1				(1 << 17)
+#define OMAP24XX_EN_MCSPI1_MASK				(1 << 17)
 #define OMAP24XX_EN_MCBSP2_SHIFT			16
-#define OMAP24XX_EN_MCBSP2				(1 << 16)
+#define OMAP24XX_EN_MCBSP2_MASK				(1 << 16)
 #define OMAP24XX_EN_MCBSP1_SHIFT			15
-#define OMAP24XX_EN_MCBSP1				(1 << 15)
+#define OMAP24XX_EN_MCBSP1_MASK				(1 << 15)
 #define OMAP24XX_EN_GPT12_SHIFT				14
-#define OMAP24XX_EN_GPT12				(1 << 14)
+#define OMAP24XX_EN_GPT12_MASK				(1 << 14)
 #define OMAP24XX_EN_GPT11_SHIFT				13
-#define OMAP24XX_EN_GPT11				(1 << 13)
+#define OMAP24XX_EN_GPT11_MASK				(1 << 13)
 #define OMAP24XX_EN_GPT10_SHIFT				12
-#define OMAP24XX_EN_GPT10				(1 << 12)
+#define OMAP24XX_EN_GPT10_MASK				(1 << 12)
 #define OMAP24XX_EN_GPT9_SHIFT				11
-#define OMAP24XX_EN_GPT9				(1 << 11)
+#define OMAP24XX_EN_GPT9_MASK				(1 << 11)
 #define OMAP24XX_EN_GPT8_SHIFT				10
-#define OMAP24XX_EN_GPT8				(1 << 10)
+#define OMAP24XX_EN_GPT8_MASK				(1 << 10)
 #define OMAP24XX_EN_GPT7_SHIFT				9
-#define OMAP24XX_EN_GPT7				(1 << 9)
+#define OMAP24XX_EN_GPT7_MASK				(1 << 9)
 #define OMAP24XX_EN_GPT6_SHIFT				8
-#define OMAP24XX_EN_GPT6				(1 << 8)
+#define OMAP24XX_EN_GPT6_MASK				(1 << 8)
 #define OMAP24XX_EN_GPT5_SHIFT				7
-#define OMAP24XX_EN_GPT5				(1 << 7)
+#define OMAP24XX_EN_GPT5_MASK				(1 << 7)
 #define OMAP24XX_EN_GPT4_SHIFT				6
-#define OMAP24XX_EN_GPT4				(1 << 6)
+#define OMAP24XX_EN_GPT4_MASK				(1 << 6)
 #define OMAP24XX_EN_GPT3_SHIFT				5
-#define OMAP24XX_EN_GPT3				(1 << 5)
+#define OMAP24XX_EN_GPT3_MASK				(1 << 5)
 #define OMAP24XX_EN_GPT2_SHIFT				4
-#define OMAP24XX_EN_GPT2				(1 << 4)
+#define OMAP24XX_EN_GPT2_MASK				(1 << 4)
 #define OMAP2420_EN_VLYNQ_SHIFT				3
-#define OMAP2420_EN_VLYNQ				(1 << 3)
+#define OMAP2420_EN_VLYNQ_MASK				(1 << 3)
 
 /* CM_FCLKEN2_CORE, CM_ICLKEN2_CORE, PM_WKEN2_CORE shared bits */
 #define OMAP2430_EN_GPIO5_SHIFT				10
-#define OMAP2430_EN_GPIO5				(1 << 10)
+#define OMAP2430_EN_GPIO5_MASK				(1 << 10)
 #define OMAP2430_EN_MCSPI3_SHIFT			9
-#define OMAP2430_EN_MCSPI3				(1 << 9)
+#define OMAP2430_EN_MCSPI3_MASK				(1 << 9)
 #define OMAP2430_EN_MMCHS2_SHIFT			8
-#define OMAP2430_EN_MMCHS2				(1 << 8)
+#define OMAP2430_EN_MMCHS2_MASK				(1 << 8)
 #define OMAP2430_EN_MMCHS1_SHIFT			7
-#define OMAP2430_EN_MMCHS1				(1 << 7)
+#define OMAP2430_EN_MMCHS1_MASK				(1 << 7)
 #define OMAP24XX_EN_UART3_SHIFT				2
-#define OMAP24XX_EN_UART3				(1 << 2)
+#define OMAP24XX_EN_UART3_MASK				(1 << 2)
 #define OMAP24XX_EN_USB_SHIFT				0
-#define OMAP24XX_EN_USB					(1 << 0)
+#define OMAP24XX_EN_USB_MASK				(1 << 0)
 
 /* CM_ICLKEN2_CORE, PM_WKEN2_CORE shared bits */
 #define OMAP2430_EN_MDM_INTC_SHIFT			11
-#define OMAP2430_EN_MDM_INTC				(1 << 11)
+#define OMAP2430_EN_MDM_INTC_MASK			(1 << 11)
 #define OMAP2430_EN_USBHS_SHIFT				6
-#define OMAP2430_EN_USBHS				(1 << 6)
+#define OMAP2430_EN_USBHS_MASK				(1 << 6)
 
 /* CM_IDLEST1_CORE, PM_WKST1_CORE shared bits */
 #define OMAP2420_ST_MMC_SHIFT				26
@@ -246,9 +246,9 @@
 
 /* CM_FCLKEN_WKUP, CM_ICLKEN_WKUP, PM_WKEN_WKUP shared bits */
 #define OMAP24XX_EN_GPIOS_SHIFT				2
-#define OMAP24XX_EN_GPIOS				(1 << 2)
+#define OMAP24XX_EN_GPIOS_MASK				(1 << 2)
 #define OMAP24XX_EN_GPT1_SHIFT				0
-#define OMAP24XX_EN_GPT1				(1 << 0)
+#define OMAP24XX_EN_GPT1_MASK				(1 << 0)
 
 /* PM_WKST_WKUP, CM_IDLEST_WKUP shared bits */
 #define OMAP24XX_ST_GPIOS_SHIFT				(1 << 2)
@@ -267,47 +267,47 @@
 #define OMAP3430_REV_MASK				(0xff << 0)
 
 /* CM_SYSCONFIG, PRM_SYSCONFIG shared bits */
-#define OMAP3430_AUTOIDLE				(1 << 0)
+#define OMAP3430_AUTOIDLE_MASK				(1 << 0)
 
 /* CM_FCLKEN1_CORE, CM_ICLKEN1_CORE, PM_WKEN1_CORE shared bits */
-#define OMAP3430_EN_MMC2				(1 << 25)
+#define OMAP3430_EN_MMC2_MASK				(1 << 25)
 #define OMAP3430_EN_MMC2_SHIFT				25
-#define OMAP3430_EN_MMC1				(1 << 24)
+#define OMAP3430_EN_MMC1_MASK				(1 << 24)
 #define OMAP3430_EN_MMC1_SHIFT				24
-#define OMAP3430_EN_MCSPI4				(1 << 21)
+#define OMAP3430_EN_MCSPI4_MASK				(1 << 21)
 #define OMAP3430_EN_MCSPI4_SHIFT			21
-#define OMAP3430_EN_MCSPI3				(1 << 20)
+#define OMAP3430_EN_MCSPI3_MASK				(1 << 20)
 #define OMAP3430_EN_MCSPI3_SHIFT			20
-#define OMAP3430_EN_MCSPI2				(1 << 19)
+#define OMAP3430_EN_MCSPI2_MASK				(1 << 19)
 #define OMAP3430_EN_MCSPI2_SHIFT			19
-#define OMAP3430_EN_MCSPI1				(1 << 18)
+#define OMAP3430_EN_MCSPI1_MASK				(1 << 18)
 #define OMAP3430_EN_MCSPI1_SHIFT			18
-#define OMAP3430_EN_I2C3				(1 << 17)
+#define OMAP3430_EN_I2C3_MASK				(1 << 17)
 #define OMAP3430_EN_I2C3_SHIFT				17
-#define OMAP3430_EN_I2C2				(1 << 16)
+#define OMAP3430_EN_I2C2_MASK				(1 << 16)
 #define OMAP3430_EN_I2C2_SHIFT				16
-#define OMAP3430_EN_I2C1				(1 << 15)
+#define OMAP3430_EN_I2C1_MASK				(1 << 15)
 #define OMAP3430_EN_I2C1_SHIFT				15
-#define OMAP3430_EN_UART2				(1 << 14)
+#define OMAP3430_EN_UART2_MASK				(1 << 14)
 #define OMAP3430_EN_UART2_SHIFT				14
-#define OMAP3430_EN_UART1				(1 << 13)
+#define OMAP3430_EN_UART1_MASK				(1 << 13)
 #define OMAP3430_EN_UART1_SHIFT				13
-#define OMAP3430_EN_GPT11				(1 << 12)
+#define OMAP3430_EN_GPT11_MASK				(1 << 12)
 #define OMAP3430_EN_GPT11_SHIFT				12
-#define OMAP3430_EN_GPT10				(1 << 11)
+#define OMAP3430_EN_GPT10_MASK				(1 << 11)
 #define OMAP3430_EN_GPT10_SHIFT				11
-#define OMAP3430_EN_MCBSP5				(1 << 10)
+#define OMAP3430_EN_MCBSP5_MASK				(1 << 10)
 #define OMAP3430_EN_MCBSP5_SHIFT			10
-#define OMAP3430_EN_MCBSP1				(1 << 9)
+#define OMAP3430_EN_MCBSP1_MASK				(1 << 9)
 #define OMAP3430_EN_MCBSP1_SHIFT			9
-#define OMAP3430_EN_FSHOSTUSB				(1 << 5)
+#define OMAP3430_EN_FSHOSTUSB_MASK			(1 << 5)
 #define OMAP3430_EN_FSHOSTUSB_SHIFT			5
-#define OMAP3430_EN_D2D					(1 << 3)
+#define OMAP3430_EN_D2D_MASK				(1 << 3)
 #define OMAP3430_EN_D2D_SHIFT				3
 
 /* CM_ICLKEN1_CORE, PM_WKEN1_CORE shared bits */
-#define OMAP3430_EN_HSOTGUSB				(1 << 4)
-#define OMAP3430_EN_HSOTGUSB_SHIFT				4
+#define OMAP3430_EN_HSOTGUSB_MASK			(1 << 4)
+#define OMAP3430_EN_HSOTGUSB_SHIFT			4
 
 /* PM_WKST1_CORE, CM_IDLEST1_CORE shared bits */
 #define OMAP3430_ST_MMC2_SHIFT				25
@@ -352,21 +352,21 @@
 #define OMAP3430_ST_D2D_MASK				(1 << 3)
 
 /* CM_FCLKEN_WKUP, CM_ICLKEN_WKUP, PM_WKEN_WKUP shared bits */
-#define OMAP3430_EN_GPIO1				(1 << 3)
+#define OMAP3430_EN_GPIO1_MASK				(1 << 3)
 #define OMAP3430_EN_GPIO1_SHIFT				3
-#define OMAP3430_EN_GPT12				(1 << 1)
+#define OMAP3430_EN_GPT12_MASK				(1 << 1)
 #define OMAP3430_EN_GPT12_SHIFT				1
-#define OMAP3430_EN_GPT1				(1 << 0)
+#define OMAP3430_EN_GPT1_MASK				(1 << 0)
 #define OMAP3430_EN_GPT1_SHIFT				0
 
 /* CM_FCLKEN_WKUP, PM_WKEN_WKUP shared bits */
-#define OMAP3430_EN_SR2					(1 << 7)
+#define OMAP3430_EN_SR2_MASK				(1 << 7)
 #define OMAP3430_EN_SR2_SHIFT				7
-#define OMAP3430_EN_SR1					(1 << 6)
+#define OMAP3430_EN_SR1_MASK				(1 << 6)
 #define OMAP3430_EN_SR1_SHIFT				6
 
 /* CM_ICLKEN_WKUP, PM_WKEN_WKUP shared bits */
-#define OMAP3430_EN_GPT12				(1 << 1)
+#define OMAP3430_EN_GPT12_MASK				(1 << 1)
 #define OMAP3430_EN_GPT12_SHIFT				1
 
 /* CM_IDLEST_WKUP, PM_WKST_WKUP shared bits */
@@ -386,47 +386,47 @@
  * CM_SLEEPDEP_PER, PM_WKDEP_IVA2, PM_WKDEP_GFX,
  * PM_WKDEP_DSS, PM_WKDEP_CAM, PM_WKDEP_PER, PM_WKDEP_NEON shared bits
  */
-#define OMAP3430_EN_MPU					(1 << 1)
+#define OMAP3430_EN_MPU_MASK				(1 << 1)
 #define OMAP3430_EN_MPU_SHIFT				1
 
 /* CM_FCLKEN_PER, CM_ICLKEN_PER, PM_WKEN_PER shared bits */
-#define OMAP3430_EN_GPIO6				(1 << 17)
+#define OMAP3430_EN_GPIO6_MASK				(1 << 17)
 #define OMAP3430_EN_GPIO6_SHIFT				17
-#define OMAP3430_EN_GPIO5				(1 << 16)
+#define OMAP3430_EN_GPIO5_MASK				(1 << 16)
 #define OMAP3430_EN_GPIO5_SHIFT				16
-#define OMAP3430_EN_GPIO4				(1 << 15)
+#define OMAP3430_EN_GPIO4_MASK				(1 << 15)
 #define OMAP3430_EN_GPIO4_SHIFT				15
-#define OMAP3430_EN_GPIO3				(1 << 14)
+#define OMAP3430_EN_GPIO3_MASK				(1 << 14)
 #define OMAP3430_EN_GPIO3_SHIFT				14
-#define OMAP3430_EN_GPIO2				(1 << 13)
+#define OMAP3430_EN_GPIO2_MASK				(1 << 13)
 #define OMAP3430_EN_GPIO2_SHIFT				13
-#define OMAP3430_EN_UART3				(1 << 11)
+#define OMAP3430_EN_UART3_MASK				(1 << 11)
 #define OMAP3430_EN_UART3_SHIFT				11
-#define OMAP3430_EN_GPT9				(1 << 10)
+#define OMAP3430_EN_GPT9_MASK				(1 << 10)
 #define OMAP3430_EN_GPT9_SHIFT				10
-#define OMAP3430_EN_GPT8				(1 << 9)
+#define OMAP3430_EN_GPT8_MASK				(1 << 9)
 #define OMAP3430_EN_GPT8_SHIFT				9
-#define OMAP3430_EN_GPT7				(1 << 8)
+#define OMAP3430_EN_GPT7_MASK				(1 << 8)
 #define OMAP3430_EN_GPT7_SHIFT				8
-#define OMAP3430_EN_GPT6				(1 << 7)
+#define OMAP3430_EN_GPT6_MASK				(1 << 7)
 #define OMAP3430_EN_GPT6_SHIFT				7
-#define OMAP3430_EN_GPT5				(1 << 6)
+#define OMAP3430_EN_GPT5_MASK				(1 << 6)
 #define OMAP3430_EN_GPT5_SHIFT				6
-#define OMAP3430_EN_GPT4				(1 << 5)
+#define OMAP3430_EN_GPT4_MASK				(1 << 5)
 #define OMAP3430_EN_GPT4_SHIFT				5
-#define OMAP3430_EN_GPT3				(1 << 4)
+#define OMAP3430_EN_GPT3_MASK				(1 << 4)
 #define OMAP3430_EN_GPT3_SHIFT				4
-#define OMAP3430_EN_GPT2				(1 << 3)
+#define OMAP3430_EN_GPT2_MASK				(1 << 3)
 #define OMAP3430_EN_GPT2_SHIFT				3
 
 /* CM_FCLKEN_PER, CM_ICLKEN_PER, PM_WKEN_PER, PM_WKST_PER shared bits */
 /* XXX Possible TI documentation bug: should the PM_WKST_PER EN_* bits
  * be ST_* bits instead? */
-#define OMAP3430_EN_MCBSP4				(1 << 2)
+#define OMAP3430_EN_MCBSP4_MASK				(1 << 2)
 #define OMAP3430_EN_MCBSP4_SHIFT			2
-#define OMAP3430_EN_MCBSP3				(1 << 1)
+#define OMAP3430_EN_MCBSP3_MASK				(1 << 1)
 #define OMAP3430_EN_MCBSP3_SHIFT			1
-#define OMAP3430_EN_MCBSP2				(1 << 0)
+#define OMAP3430_EN_MCBSP2_MASK				(1 << 0)
 #define OMAP3430_EN_MCBSP2_SHIFT			0
 
 /* CM_IDLEST_PER, PM_WKST_PER shared bits */
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 07a60f1..c201374 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -158,10 +158,10 @@ void omap_prcm_arch_reset(char mode, const char *cmd)
 		WARN_ON(1);
 
 	if (cpu_is_omap24xx() || cpu_is_omap34xx())
-		prm_set_mod_reg_bits(OMAP_RST_DPLL3, prcm_offs,
+		prm_set_mod_reg_bits(OMAP_RST_DPLL3_MASK, prcm_offs,
 						 OMAP2_RM_RSTCTRL);
 	if (cpu_is_omap44xx())
-		prm_set_mod_reg_bits(OMAP_RST_DPLL3, prcm_offs,
+		prm_set_mod_reg_bits(OMAP_RST_DPLL3_MASK, prcm_offs,
 						 OMAP4_RM_RSTCTRL);
 }
 
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 5fba2aa..7bffb6e 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -284,7 +284,7 @@ static inline u32 prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
 #define OMAP_OFFLOADMODE_MASK				(0x3 << 3)
 #define OMAP_ONLOADMODE_SHIFT				1
 #define OMAP_ONLOADMODE_MASK				(0x3 << 1)
-#define OMAP_ENABLE					(1 << 0)
+#define OMAP_ENABLE_MASK				(1 << 0)
 
 /* PRM_RSTTIME */
 /* Named RM_RSTTIME_WKUP on the 24xx */
@@ -296,8 +296,8 @@ static inline u32 prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
 /* PRM_RSTCTRL */
 /* Named RM_RSTCTRL_WKUP on the 24xx */
 /* 2420 calls RST_DPLL3 'RST_DPLL' */
-#define OMAP_RST_DPLL3					(1 << 2)
-#define OMAP_RST_GS					(1 << 1)
+#define OMAP_RST_DPLL3_MASK				(1 << 2)
+#define OMAP_RST_GS_MASK				(1 << 1)
 
 
 /*
@@ -316,7 +316,7 @@ static inline u32 prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
  *	 PM_PWSTST_DSS, PM_PWSTST_CAM, PM_PWSTST_PER, PM_PWSTST_EMU,
  *	 PM_PWSTST_NEON
  */
-#define OMAP_INTRANSITION				(1 << 20)
+#define OMAP_INTRANSITION_MASK				(1 << 20)
 
 
 /*
@@ -338,7 +338,7 @@ static inline u32 prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
  * 3430: RM_RSTST_IVA2, RM_RSTST_MPU, RM_RSTST_GFX, RM_RSTST_DSS,
  *	 RM_RSTST_CAM, RM_RSTST_PER, RM_RSTST_NEON
  */
-#define OMAP_COREDOMAINWKUP_RST				(1 << 3)
+#define OMAP_COREDOMAINWKUP_RST_MASK			(1 << 3)
 
 /*
  * 24XX: RM_RSTST_MPU, RM_RSTST_GFX, RM_RSTST_DSP
@@ -347,7 +347,7 @@ static inline u32 prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
  *
  * 3430: RM_RSTST_CORE, RM_RSTST_EMU
  */
-#define OMAP_DOMAINWKUP_RST				(1 << 2)
+#define OMAP_DOMAINWKUP_RST_MASK			(1 << 2)
 
 /*
  * 24XX: RM_RSTST_MPU, RM_RSTST_WKUP, RM_RSTST_DSP
@@ -357,8 +357,8 @@ static inline u32 prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
  *
  * 3430: RM_RSTST_CORE, RM_RSTST_EMU
  */
-#define OMAP_GLOBALWARM_RST				(1 << 1)
-#define OMAP_GLOBALCOLD_RST				(1 << 0)
+#define OMAP_GLOBALWARM_RST_MASK			(1 << 1)
+#define OMAP_GLOBALCOLD_RST_MASK			(1 << 0)
 
 /*
  * 24XX: PM_WKDEP_GFX, PM_WKDEP_MPU, PM_WKDEP_CORE, PM_WKDEP_DSP
@@ -382,7 +382,7 @@ static inline u32 prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
  *	 PM_PWSTCTRL_DSS, PM_PWSTCTRL_CAM, PM_PWSTCTRL_PER,
  *	 PM_PWSTCTRL_NEON
  */
-#define OMAP_LOGICRETSTATE				(1 << 2)
+#define OMAP_LOGICRETSTATE_MASK				(1 << 2)
 
 /*
  * 24XX: PM_PWSTCTRL_MPU, PM_PWSTCTRL_CORE, PM_PWSTCTRL_GFX,


