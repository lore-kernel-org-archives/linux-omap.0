From: Charulatha V <charu@ti.com>
Subject: [PATCH 1/5] OMAP: GPIO: make gpio_context part of gpio_bank structure
Date: Mon, 28 Feb 2011 16:27:46 +0530
Message-ID: <1298890670-5481-2-git-send-email-charu@ti.com>
References: <1298890670-5481-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58346 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753524Ab1B1K4d (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 05:56:33 -0500
In-Reply-To: <1298890670-5481-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, paul@pwsan.com, Charulatha V <charu@ti.com>

gpio_context array, which is used to save gpio bank's context,
is used only for OMAP3 architecture.

Move gpio_context as part of gpio_bank structure so that
it can be specific to each gpio bank and can be used for
any OMAP architecture

Signed-off-by: Charulatha V <charu@ti.com>

Tested-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
(2430-SDP testing)
---
TODO: extend the gpio save/restore context function for OMAP4
architecture. This is done in one of the next patches in this
series

 arch/arm/plat-omap/gpio.c |   72 +++++++++++++++++++++-----------------------
 1 files changed, 34 insertions(+), 38 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 971d186..c6ab0ff 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -133,6 +133,19 @@
 #define OMAP4_GPIO_CLEARDATAOUT		0x0190
 #define OMAP4_GPIO_SETDATAOUT		0x0194
 
+struct gpio_regs {
+	u32 irqenable1;
+	u32 irqenable2;
+	u32 wake_en;
+	u32 ctrl;
+	u32 oe;
+	u32 leveldetect0;
+	u32 leveldetect1;
+	u32 risingdetect;
+	u32 fallingdetect;
+	u32 dataout;
+};
+
 struct gpio_bank {
 	unsigned long pbase;
 	void __iomem *base;
@@ -145,7 +158,7 @@ struct gpio_bank {
 #endif
 	u32 non_wakeup_gpios;
 	u32 enabled_non_wakeup_gpios;
-
+	struct gpio_regs context;
 	u32 saved_datain;
 	u32 saved_fallingdetect;
 	u32 saved_risingdetect;
@@ -161,23 +174,6 @@ struct gpio_bank {
 	int stride;
 };
 
-#ifdef CONFIG_ARCH_OMAP3
-struct omap3_gpio_regs {
-	u32 irqenable1;
-	u32 irqenable2;
-	u32 wake_en;
-	u32 ctrl;
-	u32 oe;
-	u32 leveldetect0;
-	u32 leveldetect1;
-	u32 risingdetect;
-	u32 fallingdetect;
-	u32 dataout;
-};
-
-static struct omap3_gpio_regs gpio_context[OMAP34XX_NR_GPIOS];
-#endif
-
 /*
  * TODO: Cleanup gpio_bank usage as it is having information
  * related to all instances of the device
@@ -2043,25 +2039,25 @@ void omap_gpio_save_context(void)
 	/* saving banks from 2-6 only since GPIO1 is in WKUP */
 	for (i = 1; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
-		gpio_context[i].irqenable1 =
+		bank->context.irqenable1 =
 			__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE1);
-		gpio_context[i].irqenable2 =
+		bank->context.irqenable2 =
 			__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE2);
-		gpio_context[i].wake_en =
+		bank->context.wake_en =
 			__raw_readl(bank->base + OMAP24XX_GPIO_WAKE_EN);
-		gpio_context[i].ctrl =
+		bank->context.ctrl =
 			__raw_readl(bank->base + OMAP24XX_GPIO_CTRL);
-		gpio_context[i].oe =
+		bank->context.oe =
 			__raw_readl(bank->base + OMAP24XX_GPIO_OE);
-		gpio_context[i].leveldetect0 =
+		bank->context.leveldetect0 =
 			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0);
-		gpio_context[i].leveldetect1 =
+		bank->context.leveldetect1 =
 			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
-		gpio_context[i].risingdetect =
+		bank->context.risingdetect =
 			__raw_readl(bank->base + OMAP24XX_GPIO_RISINGDETECT);
-		gpio_context[i].fallingdetect =
+		bank->context.fallingdetect =
 			__raw_readl(bank->base + OMAP24XX_GPIO_FALLINGDETECT);
-		gpio_context[i].dataout =
+		bank->context.dataout =
 			__raw_readl(bank->base + OMAP24XX_GPIO_DATAOUT);
 	}
 }
@@ -2073,25 +2069,25 @@ void omap_gpio_restore_context(void)
 
 	for (i = 1; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
-		__raw_writel(gpio_context[i].irqenable1,
+		__raw_writel(bank->context.irqenable1,
 				bank->base + OMAP24XX_GPIO_IRQENABLE1);
-		__raw_writel(gpio_context[i].irqenable2,
+		__raw_writel(bank->context.irqenable2,
 				bank->base + OMAP24XX_GPIO_IRQENABLE2);
-		__raw_writel(gpio_context[i].wake_en,
+		__raw_writel(bank->context.wake_en,
 				bank->base + OMAP24XX_GPIO_WAKE_EN);
-		__raw_writel(gpio_context[i].ctrl,
+		__raw_writel(bank->context.ctrl,
 				bank->base + OMAP24XX_GPIO_CTRL);
-		__raw_writel(gpio_context[i].oe,
+		__raw_writel(bank->context.oe,
 				bank->base + OMAP24XX_GPIO_OE);
-		__raw_writel(gpio_context[i].leveldetect0,
+		__raw_writel(bank->context.leveldetect0,
 				bank->base + OMAP24XX_GPIO_LEVELDETECT0);
-		__raw_writel(gpio_context[i].leveldetect1,
+		__raw_writel(bank->context.leveldetect1,
 				bank->base + OMAP24XX_GPIO_LEVELDETECT1);
-		__raw_writel(gpio_context[i].risingdetect,
+		__raw_writel(bank->context.risingdetect,
 				bank->base + OMAP24XX_GPIO_RISINGDETECT);
-		__raw_writel(gpio_context[i].fallingdetect,
+		__raw_writel(bank->context.fallingdetect,
 				bank->base + OMAP24XX_GPIO_FALLINGDETECT);
-		__raw_writel(gpio_context[i].dataout,
+		__raw_writel(bank->context.dataout,
 				bank->base + OMAP24XX_GPIO_DATAOUT);
 	}
 }
-- 
1.7.1

