From: Charulatha V <charu@ti.com>
Subject: [PATCH 3/5] OMAP4: GPIO: save/restore context
Date: Mon, 28 Feb 2011 16:27:48 +0530
Message-ID: <1298890670-5481-4-git-send-email-charu@ti.com>
References: <1298890670-5481-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54288 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525Ab1B1K4d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Feb 2011 05:56:33 -0500
In-Reply-To: <1298890670-5481-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, paul@pwsan.com, Charulatha V <charu@ti.com>

Modify the omap_gpio_save/restore_context to support OMAP4
architecture so that the GPIO driver need not be modified
when OMAP4 off mode support is available.

Signed-off-by: Charulatha V <charu@ti.com>

Tested-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
(2430-SDP testing)
---
 arch/arm/plat-omap/gpio.c |  131 +++++++++++++++++++++++++++++---------------
 1 files changed, 86 insertions(+), 45 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index ff341ec..1da3233 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -2031,43 +2031,62 @@ void omap2_gpio_resume_after_idle(void)
 
 #endif
 
-#ifdef CONFIG_ARCH_OMAP3
-/* save the registers of bank 2-6 */
 void omap_gpio_save_context(void)
 {
 	int i;
 
-	/* saving banks from 2-6 only since GPIO1 is in WKUP */
 	for (i = 0; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
 
 		if (!strcmp(bank->pwrdm_name, "wkup_pwrdm"))
 			continue;
 
-		bank->context.irqenable1 =
-			__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE1);
-		bank->context.irqenable2 =
-			__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE2);
-		bank->context.wake_en =
-			__raw_readl(bank->base + OMAP24XX_GPIO_WAKE_EN);
-		bank->context.ctrl =
-			__raw_readl(bank->base + OMAP24XX_GPIO_CTRL);
-		bank->context.oe =
-			__raw_readl(bank->base + OMAP24XX_GPIO_OE);
-		bank->context.leveldetect0 =
-			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0);
-		bank->context.leveldetect1 =
-			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
-		bank->context.risingdetect =
-			__raw_readl(bank->base + OMAP24XX_GPIO_RISINGDETECT);
-		bank->context.fallingdetect =
-			__raw_readl(bank->base + OMAP24XX_GPIO_FALLINGDETECT);
-		bank->context.dataout =
-			__raw_readl(bank->base + OMAP24XX_GPIO_DATAOUT);
+		if (bank->method == METHOD_GPIO_24XX) {
+			bank->context.irqenable1 = __raw_readl(
+					bank->base + OMAP24XX_GPIO_IRQENABLE1);
+			bank->context.irqenable2 = __raw_readl(
+					bank->base + OMAP24XX_GPIO_IRQENABLE2);
+			bank->context.wake_en = __raw_readl(
+					bank->base + OMAP24XX_GPIO_WAKE_EN);
+			bank->context.ctrl = __raw_readl(
+					bank->base + OMAP24XX_GPIO_CTRL);
+			bank->context.oe = __raw_readl(
+					bank->base + OMAP24XX_GPIO_OE);
+			bank->context.leveldetect0 = __raw_readl(bank->base +
+					OMAP24XX_GPIO_LEVELDETECT0);
+			bank->context.leveldetect1 = __raw_readl(bank->base +
+					OMAP24XX_GPIO_LEVELDETECT1);
+			bank->context.risingdetect = __raw_readl(bank->base +
+					OMAP24XX_GPIO_RISINGDETECT);
+			bank->context.fallingdetect = __raw_readl(bank->base +
+					OMAP24XX_GPIO_FALLINGDETECT);
+			bank->context.dataout = __raw_readl(
+					bank->base + OMAP24XX_GPIO_DATAOUT);
+		} else if (bank->method == METHOD_GPIO_44XX) {
+			bank->context.irqenable1 = __raw_readl(
+					bank->base + OMAP4_GPIO_IRQSTATUSSET0);
+			bank->context.irqenable2 = __raw_readl(
+					bank->base + OMAP4_GPIO_IRQSTATUSSET1);
+			bank->context.wake_en = __raw_readl(
+					bank->base + OMAP4_GPIO_IRQWAKEN0);
+			bank->context.ctrl = __raw_readl(
+					bank->base + OMAP4_GPIO_CTRL);
+			bank->context.oe = __raw_readl(
+					bank->base + OMAP24XX_GPIO_OE);
+			bank->context.leveldetect0 = __raw_readl(bank->base +
+					OMAP4_GPIO_LEVELDETECT0);
+			bank->context.leveldetect1 = __raw_readl(bank->base +
+					OMAP4_GPIO_LEVELDETECT1);
+			bank->context.risingdetect = __raw_readl(bank->base +
+					OMAP4_GPIO_RISINGDETECT);
+			bank->context.fallingdetect = __raw_readl(bank->base +
+					OMAP4_GPIO_FALLINGDETECT);
+			bank->context.dataout = __raw_readl(
+					bank->base + OMAP4_GPIO_DATAOUT);
+		}
 	}
 }
 
-/* restore the required registers of bank 2-6 */
 void omap_gpio_restore_context(void)
 {
 	int i;
@@ -2078,29 +2097,51 @@ void omap_gpio_restore_context(void)
 		if (!strcmp(bank->pwrdm_name, "wkup_pwrdm"))
 			continue;
 
-		__raw_writel(bank->context.irqenable1,
-				bank->base + OMAP24XX_GPIO_IRQENABLE1);
-		__raw_writel(bank->context.irqenable2,
-				bank->base + OMAP24XX_GPIO_IRQENABLE2);
-		__raw_writel(bank->context.wake_en,
-				bank->base + OMAP24XX_GPIO_WAKE_EN);
-		__raw_writel(bank->context.ctrl,
-				bank->base + OMAP24XX_GPIO_CTRL);
-		__raw_writel(bank->context.oe,
-				bank->base + OMAP24XX_GPIO_OE);
-		__raw_writel(bank->context.leveldetect0,
-				bank->base + OMAP24XX_GPIO_LEVELDETECT0);
-		__raw_writel(bank->context.leveldetect1,
-				bank->base + OMAP24XX_GPIO_LEVELDETECT1);
-		__raw_writel(bank->context.risingdetect,
-				bank->base + OMAP24XX_GPIO_RISINGDETECT);
-		__raw_writel(bank->context.fallingdetect,
-				bank->base + OMAP24XX_GPIO_FALLINGDETECT);
-		__raw_writel(bank->context.dataout,
-				bank->base + OMAP24XX_GPIO_DATAOUT);
+		if (bank->method == METHOD_GPIO_24XX) {
+			__raw_writel(bank->context.irqenable1, bank->base +
+						OMAP24XX_GPIO_IRQENABLE1);
+			__raw_writel(bank->context.irqenable2, bank->base +
+						OMAP24XX_GPIO_IRQENABLE2);
+			__raw_writel(bank->context.wake_en, bank->base +
+						OMAP24XX_GPIO_WAKE_EN);
+			__raw_writel(bank->context.ctrl, bank->base +
+						OMAP24XX_GPIO_CTRL);
+			__raw_writel(bank->context.oe, bank->base +
+						OMAP24XX_GPIO_OE);
+			__raw_writel(bank->context.leveldetect0, bank->base +
+						OMAP24XX_GPIO_LEVELDETECT0);
+			__raw_writel(bank->context.leveldetect1, bank->base +
+						OMAP24XX_GPIO_LEVELDETECT1);
+			__raw_writel(bank->context.risingdetect, bank->base +
+						OMAP24XX_GPIO_RISINGDETECT);
+			__raw_writel(bank->context.fallingdetect, bank->base +
+						OMAP24XX_GPIO_FALLINGDETECT);
+			__raw_writel(bank->context.dataout, bank->base +
+						OMAP24XX_GPIO_DATAOUT);
+		} else if (bank->method == METHOD_GPIO_44XX) {
+			__raw_writel(bank->context.irqenable1, bank->base +
+						OMAP4_GPIO_IRQSTATUSSET0);
+			__raw_writel(bank->context.irqenable2, bank->base +
+						OMAP4_GPIO_IRQSTATUSSET1);
+			__raw_writel(bank->context.wake_en, bank->base +
+						OMAP4_GPIO_IRQWAKEN0);
+			__raw_writel(bank->context.ctrl, bank->base +
+						OMAP4_GPIO_CTRL);
+			__raw_writel(bank->context.oe, bank->base +
+						OMAP24XX_GPIO_OE);
+			__raw_writel(bank->context.leveldetect0, bank->base +
+						OMAP4_GPIO_LEVELDETECT0);
+			__raw_writel(bank->context.leveldetect1, bank->base +
+						OMAP4_GPIO_LEVELDETECT1);
+			__raw_writel(bank->context.risingdetect, bank->base +
+						OMAP4_GPIO_RISINGDETECT);
+			__raw_writel(bank->context.fallingdetect, bank->base +
+						OMAP4_GPIO_FALLINGDETECT);
+			__raw_writel(bank->context.dataout, bank->base +
+						OMAP4_GPIO_DATAOUT);
+		}
 	}
 }
-#endif
 
 static struct platform_driver omap_gpio_driver = {
 	.probe		= omap_gpio_probe,
-- 
1.7.1

