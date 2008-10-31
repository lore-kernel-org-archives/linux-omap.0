From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/4] HSMMC: Fix voltage defines, make card detect gpio controller specific
Date: Thu, 30 Oct 2008 19:04:15 -0700
Message-ID: <1225418657-31775-3-git-send-email-tony@atomide.com>
References: <1225418657-31775-1-git-send-email-tony@atomide.com>
 <1225418657-31775-2-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50503 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753008AbYJaCEW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Oct 2008 22:04:22 -0400
In-Reply-To: <1225418657-31775-2-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

Fix voltage defines, make card detect gpio controller specific

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/hsmmc.c |   60 ++++++++++++++++++++++++------------------
 1 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index b5ef975..f711d7b 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -25,27 +25,32 @@
 
 #if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
 
-#define VMMC1_DEV_GRP		0x27
-#define P1_DEV_GRP		0x20
-#define VMMC1_DEDICATED		0x2A
-#define VSEL_3V			0x02
-#define VSEL_18V		0x00
 #define TWL_GPIO_IMR1A		0x1C
 #define TWL_GPIO_ISR1A		0x19
 #define LDO_CLR			0x00
 #define VSEL_S2_CLR		0x40
 #define GPIO_0_BIT_POS		(1 << 0)
 
+#define VMMC1_DEV_GRP		0x27
+#define VMMC1_DEV_GRP_P1	0x20
+#define VMMC1_DEDICATED		0x2A
+#define VMMC1_CLR		0x00
+#define VMMC1_315V		0x03
+#define VMMC1_300V		0x02
+#define VMMC1_285V		0x01
+#define VMMC1_185V		0x00
+
 static u16 control_pbias_offset;
 
 static struct hsmmc_controller {
 	u16		control_devconf_offset;
 	u32		devconf_loopback_clock;
-	int		mmc1_cd_gpio;
+	int		card_detect_gpio;
 } hsmmc[] = {
 	{
 		.control_devconf_offset		= OMAP2_CONTROL_DEVCONF0,
 		.devconf_loopback_clock		= OMAP2_MMCSDIO1ADPCLKISEL,
+		.card_detect_gpio		= OMAP_MAX_GPIO_LINES,
 	},
 	{
 		/* control_devconf_offset set dynamically */
@@ -53,24 +58,22 @@ static struct hsmmc_controller {
 	},
 };
 
-static const int mmc1_cd_gpio = OMAP_MAX_GPIO_LINES;		/* HACK!! */
-
-static int hsmmc_card_detect(int irq)
+static int hsmmc1_card_detect(int irq)
 {
-	return gpio_get_value_cansleep(mmc1_cd_gpio);
+	return gpio_get_value_cansleep(hsmmc[0].card_detect_gpio);
 }
 
 /*
  * MMC Slot Initialization.
  */
-static int hsmmc_late_init(struct device *dev)
+static int hsmmc1_late_init(struct device *dev)
 {
 	int ret = 0;
 
 	/*
 	 * Configure TWL4030 GPIO parameters for MMC hotplug irq
 	 */
-	ret = gpio_request(mmc1_cd_gpio, "mmc0_cd");
+	ret = gpio_request(hsmmc[0].card_detect_gpio, "mmc0_cd");
 	if (ret)
 		goto err;
 
@@ -85,9 +88,9 @@ err:
 	return ret;
 }
 
-static void hsmmc_cleanup(struct device *dev)
+static void hsmmc1_cleanup(struct device *dev)
 {
-	gpio_free(mmc1_cd_gpio);
+	gpio_free(hsmmc[0].card_detect_gpio);
 }
 
 #ifdef CONFIG_PM
@@ -125,7 +128,7 @@ err:
 	return ret;
 }
 
-static int hsmmc_suspend(struct device *dev, int slot)
+static int hsmmc1_suspend(struct device *dev, int slot)
 {
 	int ret = 0;
 
@@ -135,7 +138,7 @@ static int hsmmc_suspend(struct device *dev, int slot)
 	return ret;
 }
 
-static int hsmmc_resume(struct device *dev, int slot)
+static int hsmmc1_resume(struct device *dev, int slot)
 {
 	int ret = 0;
 
@@ -160,15 +163,20 @@ static int hsmmc1_set_power(struct device *dev, int slot, int power_on,
 		switch (1 << vdd) {
 		case MMC_VDD_33_34:
 		case MMC_VDD_32_33:
-			vdd_sel = VSEL_3V;
+		case MMC_VDD_31_32:
+		case MMC_VDD_30_31:
+			vdd_sel = VMMC1_315V;
+			break;
+		case MMC_VDD_29_30:
+			vdd_sel = VMMC1_300V;
 			break;
 		case MMC_VDD_165_195:
-			vdd_sel = VSEL_18V;
+			vdd_sel = VMMC1_185V;
 		}
 
 		if (cpu_is_omap2430()) {
 			reg = omap_ctrl_readl(OMAP243X_CONTROL_DEVCONF1);
-			if (vdd_sel == VSEL_3V)
+			if (vdd_sel >= VMMC1_300V)
 				reg |= OMAP243X_MMC1_ACTIVE_OVERWRITE;
 			else
 				reg &= ~OMAP243X_MMC1_ACTIVE_OVERWRITE;
@@ -188,7 +196,7 @@ static int hsmmc1_set_power(struct device *dev, int slot, int power_on,
 		omap_ctrl_writel(reg, control_pbias_offset);
 
 		ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
-						P1_DEV_GRP, VMMC1_DEV_GRP);
+						VMMC1_DEV_GRP_P1, VMMC1_DEV_GRP);
 		if (ret)
 			goto err;
 
@@ -202,7 +210,7 @@ static int hsmmc1_set_power(struct device *dev, int slot, int power_on,
 
 		reg = omap_ctrl_readl(control_pbias_offset);
 		reg |= (OMAP2_PBIASLITEPWRDNZ0 | OMAP2_PBIASSPEEDCTRL0);
-		if (vdd_sel == VSEL_18V)
+		if (vdd_sel == VMMC1_185V)
 			reg &= ~OMAP2_PBIASLITEVMODE0;
 		else
 			reg |= OMAP2_PBIASLITEVMODE0;
@@ -245,11 +253,11 @@ err:
 
 static struct omap_mmc_platform_data mmc1_data = {
 	.nr_slots			= 1,
-	.init				= hsmmc_late_init,
-	.cleanup			= hsmmc_cleanup,
+	.init				= hsmmc1_late_init,
+	.cleanup			= hsmmc1_cleanup,
 #ifdef CONFIG_PM
-	.suspend			= hsmmc_suspend,
-	.resume				= hsmmc_resume,
+	.suspend			= hsmmc1_suspend,
+	.resume				= hsmmc1_resume,
 #endif
 	.dma_mask			= 0xffffffff,
 	.slots[0] = {
@@ -260,7 +268,7 @@ static struct omap_mmc_platform_data mmc1_data = {
 		.name			= "first slot",
 
 		.card_detect_irq        = TWL4030_GPIO_IRQ_NO(0),
-		.card_detect            = hsmmc_card_detect,
+		.card_detect            = hsmmc1_card_detect,
 	},
 };
 
-- 
1.5.6.rc3.21.g8c6b5

