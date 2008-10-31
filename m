From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] HSMMC: Make hsmmc use omap_ctrl_read/write and existing defines
Date: Thu, 30 Oct 2008 19:04:14 -0700
Message-ID: <1225418657-31775-2-git-send-email-tony@atomide.com>
References: <1225418657-31775-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50473 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803AbYJaCEV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Oct 2008 22:04:21 -0400
In-Reply-To: <1225418657-31775-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

Make hsmmc use omap_ctrl_read/write and existing defines

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/hsmmc.c               |  116 +++++++++++++++-------------
 arch/arm/plat-omap/include/mach/control.h |   17 ++++
 2 files changed, 79 insertions(+), 54 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index b1b18e3..b5ef975 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -19,6 +19,7 @@
 #include <linux/i2c/twl4030.h>
 
 #include <mach/hardware.h>
+#include <mach/control.h>
 #include <mach/mmc.h>
 #include <mach/board.h>
 
@@ -35,16 +36,22 @@
 #define VSEL_S2_CLR		0x40
 #define GPIO_0_BIT_POS		(1 << 0)
 
-#define OMAP2_CONTROL_DEVCONF0	0x48002274
-#define OMAP2_CONTROL_DEVCONF1	0x490022E8
-
-#define OMAP2_CONTROL_DEVCONF0_LBCLK	(1 << 24)
-#define OMAP2_CONTROL_DEVCONF1_ACTOV	(1 << 31)
-
-#define OMAP2_CONTROL_PBIAS_VMODE	(1 << 0)
-#define OMAP2_CONTROL_PBIAS_PWRDNZ	(1 << 1)
-#define OMAP2_CONTROL_PBIAS_SCTRL	(1 << 2)
+static u16 control_pbias_offset;
 
+static struct hsmmc_controller {
+	u16		control_devconf_offset;
+	u32		devconf_loopback_clock;
+	int		mmc1_cd_gpio;
+} hsmmc[] = {
+	{
+		.control_devconf_offset		= OMAP2_CONTROL_DEVCONF0,
+		.devconf_loopback_clock		= OMAP2_MMCSDIO1ADPCLKISEL,
+	},
+	{
+		/* control_devconf_offset set dynamically */
+		.devconf_loopback_clock		= OMAP2_MMCSDIO2ADPCLKISEL,
+	},
+};
 
 static const int mmc1_cd_gpio = OMAP_MAX_GPIO_LINES;		/* HACK!! */
 
@@ -140,53 +147,45 @@ static int hsmmc_resume(struct device *dev, int slot)
 
 #endif
 
-static int hsmmc_set_power(struct device *dev, int slot, int power_on,
+static int hsmmc1_set_power(struct device *dev, int slot, int power_on,
 				int vdd)
 {
-	u32 vdd_sel = 0, devconf = 0, reg = 0;
+	u32 reg;
 	int ret = 0;
-
-	/* REVISIT: Using address directly till the control.h defines
-	 * are settled.
-	 */
-#if defined(CONFIG_ARCH_OMAP2430)
-	#define OMAP2_CONTROL_PBIAS 0x490024A0
-#else
-	#define OMAP2_CONTROL_PBIAS 0x48002520
-#endif
+	u16 control_devconf_offset = hsmmc[0].control_devconf_offset;
 
 	if (power_on) {
-		if (cpu_is_omap24xx())
-			devconf = omap_readl(OMAP2_CONTROL_DEVCONF1);
-		else
-			devconf = omap_readl(OMAP2_CONTROL_DEVCONF0);
+		u32 vdd_sel = 0;
 
 		switch (1 << vdd) {
 		case MMC_VDD_33_34:
 		case MMC_VDD_32_33:
 			vdd_sel = VSEL_3V;
-			if (cpu_is_omap24xx())
-				devconf |= OMAP2_CONTROL_DEVCONF1_ACTOV;
 			break;
 		case MMC_VDD_165_195:
 			vdd_sel = VSEL_18V;
-			if (cpu_is_omap24xx())
-				devconf &= ~OMAP2_CONTROL_DEVCONF1_ACTOV;
 		}
 
-		if (cpu_is_omap24xx())
-			omap_writel(devconf, OMAP2_CONTROL_DEVCONF1);
-		else
-			omap_writel(devconf | OMAP2_CONTROL_DEVCONF0_LBCLK,
-				    OMAP2_CONTROL_DEVCONF0);
+		if (cpu_is_omap2430()) {
+			reg = omap_ctrl_readl(OMAP243X_CONTROL_DEVCONF1);
+			if (vdd_sel == VSEL_3V)
+				reg |= OMAP243X_MMC1_ACTIVE_OVERWRITE;
+			else
+				reg &= ~OMAP243X_MMC1_ACTIVE_OVERWRITE;
+			omap_ctrl_writel(reg, OMAP243X_CONTROL_DEVCONF1);
+		}
 
-		reg = omap_readl(OMAP2_CONTROL_PBIAS);
-		reg |= OMAP2_CONTROL_PBIAS_SCTRL;
-		omap_writel(reg, OMAP2_CONTROL_PBIAS);
+		/* REVISIT: Loop back clock not needed for 2430? */
+		if (!cpu_is_omap2430()) {
+			reg = omap_ctrl_readl(control_devconf_offset);
+			reg |= OMAP2_MMCSDIO1ADPCLKISEL;
+			omap_ctrl_writel(reg, control_devconf_offset);
+		}
 
-		reg = omap_readl(OMAP2_CONTROL_PBIAS);
-		reg &= ~OMAP2_CONTROL_PBIAS_PWRDNZ;
-		omap_writel(reg, OMAP2_CONTROL_PBIAS);
+		reg = omap_ctrl_readl(control_pbias_offset);
+		reg |= OMAP2_PBIASSPEEDCTRL0;
+		reg &= ~OMAP2_PBIASLITEPWRDNZ0;
+		omap_ctrl_writel(reg, control_pbias_offset);
 
 		ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 						P1_DEV_GRP, VMMC1_DEV_GRP);
@@ -198,15 +197,16 @@ static int hsmmc_set_power(struct device *dev, int slot, int power_on,
 		if (ret)
 			goto err;
 
+		/* 100ms delay required for PBIAS configuration */
 		msleep(100);
-		reg = omap_readl(OMAP2_CONTROL_PBIAS);
-		reg |= (OMAP2_CONTROL_PBIAS_SCTRL |
-			OMAP2_CONTROL_PBIAS_PWRDNZ);
+
+		reg = omap_ctrl_readl(control_pbias_offset);
+		reg |= (OMAP2_PBIASLITEPWRDNZ0 | OMAP2_PBIASSPEEDCTRL0);
 		if (vdd_sel == VSEL_18V)
-			reg &= ~OMAP2_CONTROL_PBIAS_VMODE;
+			reg &= ~OMAP2_PBIASLITEVMODE0;
 		else
-			reg |= OMAP2_CONTROL_PBIAS_VMODE;
-		omap_writel(reg, OMAP2_CONTROL_PBIAS);
+			reg |= OMAP2_PBIASLITEVMODE0;
+		omap_ctrl_writel(reg, control_pbias_offset);
 
 		return ret;
 
@@ -214,9 +214,9 @@ static int hsmmc_set_power(struct device *dev, int slot, int power_on,
 		/* Power OFF */
 
 		/* For MMC1, Toggle PBIAS before every power up sequence */
-		reg = omap_readl(OMAP2_CONTROL_PBIAS);
-		reg &= ~OMAP2_CONTROL_PBIAS_PWRDNZ;
-		omap_writel(reg, OMAP2_CONTROL_PBIAS);
+		reg = omap_ctrl_readl(control_pbias_offset);
+		reg &= ~OMAP2_PBIASLITEPWRDNZ0;
+		omap_ctrl_writel(reg, control_pbias_offset);
 
 		ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 						LDO_CLR, VMMC1_DEV_GRP);
@@ -230,11 +230,11 @@ static int hsmmc_set_power(struct device *dev, int slot, int power_on,
 
 		/* 100ms delay required for PBIAS configuration */
 		msleep(100);
-		reg = omap_readl(OMAP2_CONTROL_PBIAS);
-		reg |= (OMAP2_CONTROL_PBIAS_VMODE |
-			OMAP2_CONTROL_PBIAS_PWRDNZ |
-			OMAP2_CONTROL_PBIAS_SCTRL);
-		omap_writel(reg, OMAP2_CONTROL_PBIAS);
+
+		reg = omap_ctrl_readl(control_pbias_offset);
+		reg |= (OMAP2_PBIASSPEEDCTRL0 | OMAP2_PBIASLITEPWRDNZ0 |
+			OMAP2_PBIASLITEVMODE0);
+		omap_ctrl_writel(reg, control_pbias_offset);
 	}
 
 	return 0;
@@ -254,7 +254,7 @@ static struct omap_mmc_platform_data mmc1_data = {
 	.dma_mask			= 0xffffffff,
 	.slots[0] = {
 		.wire4			= 1,
-		.set_power		= hsmmc_set_power,
+		.set_power		= hsmmc1_set_power,
 		.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34 |
 						MMC_VDD_165_195,
 		.name			= "first slot",
@@ -268,6 +268,14 @@ static struct omap_mmc_platform_data *hsmmc_data[OMAP34XX_NR_MMC];
 
 void __init hsmmc_init(void)
 {
+	if (cpu_is_omap2430()) {
+		control_pbias_offset = OMAP243X_CONTROL_PBIAS_LITE;
+		hsmmc[1].control_devconf_offset = OMAP243X_CONTROL_DEVCONF1;
+	} else {
+		control_pbias_offset = OMAP343X_CONTROL_PBIAS_LITE;
+		hsmmc[1].control_devconf_offset = OMAP343X_CONTROL_DEVCONF1;
+	}
+
 	hsmmc_data[0] = &mmc1_data;
 	omap2_init_mmc(hsmmc_data, OMAP34XX_NR_MMC);
 }
diff --git a/arch/arm/plat-omap/include/mach/control.h b/arch/arm/plat-omap/include/mach/control.h
index 9ca0e08..b950e1e 100644
--- a/arch/arm/plat-omap/include/mach/control.h
+++ b/arch/arm/plat-omap/include/mach/control.h
@@ -74,6 +74,7 @@
 #define OMAP243X_CONTROL_IVA2_BOOTADDR	(OMAP2_CONTROL_GENERAL + 0x0190)
 #define OMAP243X_CONTROL_IVA2_BOOTMOD	(OMAP2_CONTROL_GENERAL + 0x0194)
 #define OMAP243X_CONTROL_IVA2_GEMCFG	(OMAP2_CONTROL_GENERAL + 0x0198)
+#define OMAP243X_CONTROL_PBIAS_LITE	(OMAP2_CONTROL_GENERAL + 0x0230)
 
 /* 24xx-only CONTROL_GENERAL register offsets */
 #define OMAP24XX_CONTROL_DEBOBS		(OMAP2_CONTROL_GENERAL + 0x0000)
@@ -149,6 +150,7 @@
 #define OMAP343X_CONTROL_FUSE_SR	(OMAP2_CONTROL_GENERAL + 0x0130)
 #define OMAP343X_CONTROL_IVA2_BOOTADDR	(OMAP2_CONTROL_GENERAL + 0x0190)
 #define OMAP343X_CONTROL_IVA2_BOOTMOD	(OMAP2_CONTROL_GENERAL + 0x0194)
+#define OMAP343X_CONTROL_PBIAS_LITE	(OMAP2_CONTROL_GENERAL + 0x02b0)
 #define OMAP343X_CONTROL_TEMP_SENSOR	(OMAP2_CONTROL_GENERAL + 0x02b4)
 
 /*
@@ -163,11 +165,14 @@
  * and the security mode (secure, non-secure, don't care)
  */
 /* CONTROL_DEVCONF0 bits */
+#define OMAP2_MMCSDIO1ADPCLKISEL	(1 << 24) /* MMC1 loop back clock */
 #define OMAP24XX_USBSTANDBYCTRL		(1 << 15)
 #define OMAP2_MCBSP2_CLKS_MASK		(1 << 6)
 #define OMAP2_MCBSP1_CLKS_MASK		(1 << 2)
 
 /* CONTROL_DEVCONF1 bits */
+#define OMAP243X_MMC1_ACTIVE_OVERWRITE	(1 << 31)
+#define OMAP2_MMCSDIO2ADPCLKISEL	(1 << 6) /* MMC2 loop back clock */
 #define OMAP2_MCBSP5_CLKS_MASK		(1 << 4) /* > 242x */
 #define OMAP2_MCBSP4_CLKS_MASK		(1 << 2) /* > 242x */
 #define OMAP2_MCBSP3_CLKS_MASK		(1 << 0) /* > 242x */
@@ -191,6 +196,18 @@
 #define OMAP343X_SR1_SENPENABLE_MASK	(0x3 << 0)
 #define OMAP343X_SR1_SENPENABLE_SHIFT	0
 
+/* CONTROL_PBIAS_LITE bits */
+#define OMAP343X_PBIASLITESUPPLY_HIGH1	(1 << 15)
+#define OMAP343X_PBIASLITEVMODEERROR1	(1 << 11)
+#define OMAP343X_PBIASSPEEDCTRL1	(1 << 10)
+#define OMAP343X_PBIASLITEPWRDNZ1	(1 << 9)
+#define OMAP343X_PBIASLITEVMODE1	(1 << 8)
+#define OMAP343X_PBIASLITESUPPLY_HIGH0	(1 << 7)
+#define OMAP343X_PBIASLITEVMODEERROR0	(1 << 3)
+#define OMAP2_PBIASSPEEDCTRL0		(1 << 2)
+#define OMAP2_PBIASLITEPWRDNZ0		(1 << 1)
+#define OMAP2_PBIASLITEVMODE0		(1 << 0)
+
 #ifndef __ASSEMBLY__
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 extern void __iomem *omap_ctrl_base_get(void);
-- 
1.5.6.rc3.21.g8c6b5

