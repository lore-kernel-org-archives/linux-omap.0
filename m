From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH 06/15] OMAP4: GPIO: Save/restore context
Date: Tue, 24 May 2011 19:54:45 +0530
Message-ID: <1306247094-25372-7-git-send-email-tarun.kanti@ti.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43524 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756651Ab1EXOZP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 May 2011 10:25:15 -0400
In-Reply-To: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

From: Charulatha V <charu@ti.com>

Modify the omap_gpio_save/restore_context to support OMAP4
architecture so that the OMAP GPIO driver need not be modified
when OMAP4 off mode support is available.

Signed-off-by: Charulatha V <charu@ti.com>
---
 drivers/gpio/gpio_omap.c |  130 +++++++++++++++++++++++++++++++---------------
 1 files changed, 87 insertions(+), 43 deletions(-)

diff --git a/drivers/gpio/gpio_omap.c b/drivers/gpio/gpio_omap.c
index 5673951..9d55b7d 100644
--- a/drivers/gpio/gpio_omap.c
+++ b/drivers/gpio/gpio_omap.c
@@ -1476,9 +1476,6 @@ void omap2_gpio_resume_after_idle(void)
 
 }
 
-#endif
-
-#ifdef CONFIG_ARCH_OMAP3
 void omap_gpio_save_context(void)
 {
 	struct gpio_bank *bank;
@@ -1488,26 +1485,49 @@ void omap_gpio_save_context(void)
 		if (!bank->loses_context)
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
 
@@ -1520,28 +1540,52 @@ void omap_gpio_restore_context(void)
 		if (!bank->loses_context)
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
+
 #endif
 
 static struct platform_driver omap_gpio_driver = {
-- 
1.6.0.4

