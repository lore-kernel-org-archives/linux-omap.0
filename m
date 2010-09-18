From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH v6 11/13] OMAP: GPIO: Make gpio_context as part of gpio_bank structure
Date: Sat, 18 Sep 2010 19:45:51 +0530
Message-ID: <1284819353-8512-12-git-send-email-charu@ti.com>
References: <1284819353-8512-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56488 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755489Ab0IROQS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 18 Sep 2010 10:16:18 -0400
In-Reply-To: <1284819353-8512-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, "Varadarajan, Charulatha" <charu@ti.com>

gpio_context array, which is used to save gpio bank's context,
is used only for OMAP3 architecture.

This patch moves gpio_context as part of gpio_bank structure
so that it can be specific to each gpio bank and can be
used for any OMAP architecture

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/plat-omap/gpio.c |   73 ++++++++++++++++++++++-----------------------
 1 files changed, 36 insertions(+), 37 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index fa324bb..aa0d510 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -133,6 +133,19 @@ static struct powerdomain *per_pwrdm;
 #define OMAP4_GPIO_CLEARDATAOUT		0x0190
 #define OMAP4_GPIO_SETDATAOUT		0x0194
 
+struct omap_gpio_regs {
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
@@ -157,29 +170,13 @@ struct gpio_bank {
 	u32 mod_usage;
 	u32 dbck_enable_mask;
 	struct device *dev;
+	struct omap_gpio_regs gpio_context;
 	bool dbck_flag;
 };
 
 static void omap3_gpio_restore_context(void);
 static void omap3_gpio_save_context(void);
 
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
@@ -2053,25 +2050,26 @@ static void omap3_gpio_save_context(void)
 	/* saving banks from 2-6 only since GPIO1 is in WKUP */
 	for (i = 1; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
-		gpio_context[i].irqenable1 =
+
+		bank->gpio_context.irqenable1 =
 			__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE1);
-		gpio_context[i].irqenable2 =
+		bank->gpio_context.irqenable2 =
 			__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE2);
-		gpio_context[i].wake_en =
+		bank->gpio_context.wake_en =
 			__raw_readl(bank->base + OMAP24XX_GPIO_WAKE_EN);
-		gpio_context[i].ctrl =
+		bank->gpio_context.ctrl =
 			__raw_readl(bank->base + OMAP24XX_GPIO_CTRL);
-		gpio_context[i].oe =
+		bank->gpio_context.oe =
 			__raw_readl(bank->base + OMAP24XX_GPIO_OE);
-		gpio_context[i].leveldetect0 =
+		bank->gpio_context.leveldetect0 =
 			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0);
-		gpio_context[i].leveldetect1 =
+		bank->gpio_context.leveldetect1 =
 			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
-		gpio_context[i].risingdetect =
+		bank->gpio_context.risingdetect =
 			__raw_readl(bank->base + OMAP24XX_GPIO_RISINGDETECT);
-		gpio_context[i].fallingdetect =
+		bank->gpio_context.fallingdetect =
 			__raw_readl(bank->base + OMAP24XX_GPIO_FALLINGDETECT);
-		gpio_context[i].dataout =
+		bank->gpio_context.dataout =
 			__raw_readl(bank->base + OMAP24XX_GPIO_DATAOUT);
 	}
 }
@@ -2083,25 +2081,26 @@ static void omap3_gpio_restore_context(void)
 
 	for (i = 1; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
-		__raw_writel(gpio_context[i].irqenable1,
+
+		__raw_writel(bank->gpio_context.irqenable1,
 				bank->base + OMAP24XX_GPIO_IRQENABLE1);
-		__raw_writel(gpio_context[i].irqenable2,
+		__raw_writel(bank->gpio_context.irqenable2,
 				bank->base + OMAP24XX_GPIO_IRQENABLE2);
-		__raw_writel(gpio_context[i].wake_en,
+		__raw_writel(bank->gpio_context.wake_en,
 				bank->base + OMAP24XX_GPIO_WAKE_EN);
-		__raw_writel(gpio_context[i].ctrl,
+		__raw_writel(bank->gpio_context.ctrl,
 				bank->base + OMAP24XX_GPIO_CTRL);
-		__raw_writel(gpio_context[i].oe,
+		__raw_writel(bank->gpio_context.oe,
 				bank->base + OMAP24XX_GPIO_OE);
-		__raw_writel(gpio_context[i].leveldetect0,
+		__raw_writel(bank->gpio_context.leveldetect0,
 				bank->base + OMAP24XX_GPIO_LEVELDETECT0);
-		__raw_writel(gpio_context[i].leveldetect1,
+		__raw_writel(bank->gpio_context.leveldetect1,
 				bank->base + OMAP24XX_GPIO_LEVELDETECT1);
-		__raw_writel(gpio_context[i].risingdetect,
+		__raw_writel(bank->gpio_context.risingdetect,
 				bank->base + OMAP24XX_GPIO_RISINGDETECT);
-		__raw_writel(gpio_context[i].fallingdetect,
+		__raw_writel(bank->gpio_context.fallingdetect,
 				bank->base + OMAP24XX_GPIO_FALLINGDETECT);
-		__raw_writel(gpio_context[i].dataout,
+		__raw_writel(bank->gpio_context.dataout,
 				bank->base + OMAP24XX_GPIO_DATAOUT);
 	}
 }
-- 
1.7.0.4

