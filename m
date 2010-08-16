From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 4/4] omap4: control: Fix the control module register accesses
Date: Mon, 16 Aug 2010 19:36:22 +0530
Message-ID: <1281967582-9773-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56265 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750962Ab0HPOG3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Aug 2010 10:06:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch has multiple fixes together. To ensure that git bisect work across
commits, all changes are clubbed together

1. Move the common control base address to control core
2. Remove the manually coeded defines and use the ones from headers.
3. Fix the the status register define in id.c for OMAP4
4. Fix all the register define in hsmmc.c
5. Use the control pad accessor API for omap4 hsmmc register accesses

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/hsmmc.c               |   67 +++++++++++++++-------------
 arch/arm/mach-omap2/id.c                  |    2 +-
 arch/arm/plat-omap/common.c               |    2 +-
 arch/arm/plat-omap/include/plat/control.h |   23 ----------
 4 files changed, 38 insertions(+), 56 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index c8f647b..87bdb7b 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -135,10 +135,11 @@ static void omap4_hsmmc1_before_set_reg(struct device *dev, int slot,
 	 *
 	 * FIXME handle VMMC1A as needed ...
 	 */
-	reg = omap_ctrl_readl(control_pbias_offset);
-	reg &= ~(OMAP4_MMC1_PBIASLITE_PWRDNZ | OMAP4_MMC1_PWRDNZ |
-					OMAP4_USBC1_ICUSB_PWRDNZ);
-	omap_ctrl_writel(reg, control_pbias_offset);
+	reg = omap4_ctrl_pad_readl(control_pbias_offset);
+	reg &= ~(OMAP4_MMC1_PBIASLITE_PWRDNZ_MASK |
+		OMAP4_MMC1_PWRDNZ_MASK |
+		OMAP4_USBC1_ICUSB_PWRDNZ_MASK);
+	omap4_ctrl_pad_writel(reg, control_pbias_offset);
 }
 
 static void omap4_hsmmc1_after_set_reg(struct device *dev, int slot,
@@ -147,30 +148,33 @@ static void omap4_hsmmc1_after_set_reg(struct device *dev, int slot,
 	u32 reg;
 
 	if (power_on) {
-		reg = omap_ctrl_readl(control_pbias_offset);
-		reg |= OMAP4_MMC1_PBIASLITE_PWRDNZ;
+		reg = omap4_ctrl_pad_readl(control_pbias_offset);
+		reg |= OMAP4_MMC1_PBIASLITE_PWRDNZ_MASK;
 		if ((1 << vdd) <= MMC_VDD_165_195)
-			reg &= ~OMAP4_MMC1_PBIASLITE_VMODE;
+			reg &= ~OMAP4_MMC1_PBIASLITE_VMODE_MASK;
 		else
-			reg |= OMAP4_MMC1_PBIASLITE_VMODE;
-		reg |= (OMAP4_MMC1_PBIASLITE_PWRDNZ | OMAP4_MMC1_PWRDNZ |
-						OMAP4_USBC1_ICUSB_PWRDNZ);
-		omap_ctrl_writel(reg, control_pbias_offset);
+			reg |= OMAP4_MMC1_PBIASLITE_VMODE_MASK;
+		reg |= (OMAP4_MMC1_PBIASLITE_PWRDNZ_MASK |
+			OMAP4_MMC1_PWRDNZ_MASK |
+			OMAP4_USBC1_ICUSB_PWRDNZ_MASK);
+		omap4_ctrl_pad_writel(reg, control_pbias_offset);
 		/* 4 microsec delay for comparator to generate an error*/
 		udelay(4);
-		reg = omap_ctrl_readl(control_pbias_offset);
-		if (reg & OMAP4_MMC1_PBIASLITE_VMODE_ERROR) {
+		reg = omap4_ctrl_pad_readl(control_pbias_offset);
+		if (reg & OMAP4_MMC1_PBIASLITE_VMODE_ERROR_MASK) {
 			pr_err("Pbias Voltage is not same as LDO\n");
 			/* Caution : On VMODE_ERROR Power Down MMC IO */
-			reg &= ~(OMAP4_MMC1_PWRDNZ | OMAP4_USBC1_ICUSB_PWRDNZ);
-			omap_ctrl_writel(reg, control_pbias_offset);
+			reg &= ~(OMAP4_MMC1_PWRDNZ_MASK |
+				OMAP4_USBC1_ICUSB_PWRDNZ_MASK);
+			omap4_ctrl_pad_writel(reg, control_pbias_offset);
 		}
 	} else {
-		reg = omap_ctrl_readl(control_pbias_offset);
-		 reg |= (OMAP4_MMC1_PBIASLITE_PWRDNZ |
-			OMAP4_MMC1_PBIASLITE_VMODE | OMAP4_MMC1_PWRDNZ |
-			OMAP4_USBC1_ICUSB_PWRDNZ);
-		omap_ctrl_writel(reg, control_pbias_offset);
+		reg = omap4_ctrl_pad_readl(control_pbias_offset);
+		reg |= (OMAP4_MMC1_PBIASLITE_PWRDNZ_MASK |
+			OMAP4_MMC1_PWRDNZ_MASK |
+			OMAP4_MMC1_PBIASLITE_VMODE_MASK |
+			OMAP4_USBC1_ICUSB_PWRDNZ_MASK);
+		omap4_ctrl_pad_writel(reg, control_pbias_offset);
 	}
 }
 
@@ -218,17 +222,18 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 			control_devconf1_offset = OMAP343X_CONTROL_DEVCONF1;
 		}
 	} else {
-		control_pbias_offset = OMAP44XX_CONTROL_PBIAS_LITE;
-		control_mmc1 = OMAP44XX_CONTROL_MMC1;
-		reg = omap_ctrl_readl(control_mmc1);
-		reg |= (OMAP4_CONTROL_SDMMC1_PUSTRENGTHGRP0 |
-			OMAP4_CONTROL_SDMMC1_PUSTRENGTHGRP1);
-		reg &= ~(OMAP4_CONTROL_SDMMC1_PUSTRENGTHGRP2 |
-			OMAP4_CONTROL_SDMMC1_PUSTRENGTHGRP3);
-		reg |= (OMAP4_CONTROL_SDMMC1_DR0_SPEEDCTRL |
-			OMAP4_CONTROL_SDMMC1_DR1_SPEEDCTRL |
-			OMAP4_CONTROL_SDMMC1_DR2_SPEEDCTRL);
-		omap_ctrl_writel(reg, control_mmc1);
+		control_pbias_offset =
+			OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_PBIASLITE;
+		control_mmc1 = OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_MMC1;
+		reg = omap4_ctrl_pad_readl(control_mmc1);
+		reg |= (OMAP4_SDMMC1_PUSTRENGTH_GRP0_MASK |
+			OMAP4_SDMMC1_PUSTRENGTH_GRP1_MASK);
+		reg &= ~(OMAP4_SDMMC1_PUSTRENGTH_GRP2_MASK |
+			OMAP4_SDMMC1_PUSTRENGTH_GRP3_MASK);
+		reg |= (OMAP4_USBC1_DR0_SPEEDCTRL_MASK|
+			OMAP4_SDMMC1_DR1_SPEEDCTRL_MASK |
+			OMAP4_SDMMC1_DR2_SPEEDCTRL_MASK);
+		omap4_ctrl_pad_writel(reg, control_mmc1);
 	}
 
 	for (c = controllers; c->mmc; c++) {
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 9a879f9..4808bc9 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -60,7 +60,7 @@ int omap_type(void)
 	} else if (cpu_is_omap34xx()) {
 		val = omap_ctrl_readl(OMAP343X_CONTROL_STATUS);
 	} else if (cpu_is_omap44xx()) {
-		val = omap_ctrl_readl(OMAP44XX_CONTROL_STATUS);
+		val = omap_ctrl_readl(OMAP4_CTRL_MODULE_CORE_STATUS);
 	} else {
 		pr_err("Cannot detect omap type!\n");
 		goto out;
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 480718b..7d668b3 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -336,7 +336,7 @@ void __init omap3_map_io(void)
 static struct omap_globals omap4_globals = {
 	.class	= OMAP443X_CLASS,
 	.tap	= OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE),
-	.ctrl	= OMAP443X_CTRL_BASE,	/* FIXME: Move this to control core */
+	.ctrl	= OMAP443X_SCM_BASE,
 	.ctrl_pad	= OMAP443X_CTRL_BASE,
 	.prm	= OMAP4430_PRM_BASE,
 	.cm	= OMAP4430_CM_BASE,
diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-omap/include/plat/control.h
index f571af7..19c9b2a 100644
--- a/arch/arm/plat-omap/include/plat/control.h
+++ b/arch/arm/plat-omap/include/plat/control.h
@@ -208,12 +208,6 @@
 #define OMAP3_PADCONF_SAD2D_MSTANDBY   0x250
 #define OMAP3_PADCONF_SAD2D_IDLEACK    0x254
 
-/* 44xx control status register offset */
-#define OMAP44XX_CONTROL_STATUS		0x2c4
-
-/* 44xx-only CONTROL_GENERAL register offsets */
-#define OMAP44XX_CONTROL_MMC1			0x628
-#define OMAP44XX_CONTROL_PBIAS_LITE		0x600
 /*
  * REVISIT: This list of registers is not comprehensive - there are more
  * that should be added.
@@ -259,23 +253,6 @@
 #define OMAP2_PBIASLITEPWRDNZ0		(1 << 1)
 #define OMAP2_PBIASLITEVMODE0		(1 << 0)
 
-/* CONTROL_PBIAS_LITE bits for OMAP4 */
-#define OMAP4_MMC1_PWRDNZ			(1 << 26)
-#define OMAP4_MMC1_PBIASLITE_HIZ_MODE		(1 << 25)
-#define OMAP4_MMC1_PBIASLITE_SUPPLY_HI_OUT	(1 << 24)
-#define OMAP4_MMC1_PBIASLITE_VMODE_ERROR	(1 << 23)
-#define OMAP4_MMC1_PBIASLITE_PWRDNZ		(1 << 22)
-#define OMAP4_MMC1_PBIASLITE_VMODE		(1 << 21)
-#define OMAP4_USBC1_ICUSB_PWRDNZ		(1 << 20)
-
-#define OMAP4_CONTROL_SDMMC1_PUSTRENGTHGRP0	(1 << 31)
-#define OMAP4_CONTROL_SDMMC1_PUSTRENGTHGRP1	(1 << 30)
-#define OMAP4_CONTROL_SDMMC1_PUSTRENGTHGRP2	(1 << 29)
-#define OMAP4_CONTROL_SDMMC1_PUSTRENGTHGRP3	(1 << 28)
-#define OMAP4_CONTROL_SDMMC1_DR0_SPEEDCTRL	(1 << 27)
-#define OMAP4_CONTROL_SDMMC1_DR1_SPEEDCTRL	(1 << 26)
-#define OMAP4_CONTROL_SDMMC1_DR2_SPEEDCTRL	(1 << 25)
-
 /* CONTROL_PROG_IO1 bits */
 #define OMAP3630_PRG_SDMMC1_SPEEDCTRL	(1 << 20)
 
-- 
1.6.0.4

