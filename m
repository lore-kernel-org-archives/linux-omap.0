From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH 11/15] OMAP: GPIO: Remove hardcoded offsets in ctxt save/restore
Date: Tue, 24 May 2011 19:54:50 +0530
Message-ID: <1306247094-25372-12-git-send-email-tarun.kanti@ti.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49784 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756373Ab1EXOZT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 May 2011 10:25:19 -0400
In-Reply-To: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Charulatha V <charu@ti.com>

It is not required to use hard-coded offsets any more in context
save and restore functions and instead use the generic offsets
which have been correctly initialized during device registration.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap2/gpio.c             |    2 +
 arch/arm/plat-omap/include/plat/gpio.h |    1 +
 drivers/gpio/gpio_omap.c               |  123 ++++++++++----------------------
 3 files changed, 40 insertions(+), 86 deletions(-)

diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 0f8782f..5c888dd 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -106,6 +106,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		pdata->regs->irqstatus = OMAP24XX_GPIO_IRQSTATUS1;
 		pdata->regs->irqstatus2 = OMAP24XX_GPIO_IRQSTATUS2;
 		pdata->regs->irqenable = OMAP24XX_GPIO_IRQENABLE1;
+		pdata->regs->irqenable2 = OMAP24XX_GPIO_IRQENABLE2;
 		pdata->regs->set_irqenable = OMAP24XX_GPIO_SETIRQENABLE1;
 		pdata->regs->clr_irqenable = OMAP24XX_GPIO_CLEARIRQENABLE1;
 		pdata->regs->debounce = OMAP24XX_GPIO_DEBOUNCE_VAL;
@@ -130,6 +131,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		pdata->regs->irqstatus = OMAP4_GPIO_IRQSTATUS0;
 		pdata->regs->irqstatus2 = OMAP4_GPIO_IRQSTATUS1;
 		pdata->regs->irqenable = OMAP4_GPIO_IRQSTATUSSET0;
+		pdata->regs->irqenable2 = OMAP4_GPIO_IRQSTATUSSET1;
 		pdata->regs->set_irqenable = OMAP4_GPIO_IRQSTATUSSET0;
 		pdata->regs->clr_irqenable = OMAP4_GPIO_IRQSTATUSCLR0;
 		pdata->regs->debounce = OMAP4_GPIO_DEBOUNCINGTIME;
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 7712e97..a341790 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -184,6 +184,7 @@ struct omap_gpio_reg_offs {
 	u16 irqstatus;
 	u16 irqstatus2;
 	u16 irqenable;
+	u16 irqenable2;
 	u16 set_irqenable;
 	u16 clr_irqenable;
 	u16 debounce;
diff --git a/drivers/gpio/gpio_omap.c b/drivers/gpio/gpio_omap.c
index 28390a9..05c2857 100644
--- a/drivers/gpio/gpio_omap.c
+++ b/drivers/gpio/gpio_omap.c
@@ -1395,96 +1395,47 @@ restore_gpio_ctx:
 
 void omap_gpio_save_context(struct gpio_bank *bank)
 {
-	if (bank->method == METHOD_GPIO_24XX) {
-		bank->context.irqenable1 = __raw_readl(
-					bank->base + OMAP24XX_GPIO_IRQENABLE1);
-		bank->context.irqenable2 = __raw_readl(
-					bank->base + OMAP24XX_GPIO_IRQENABLE2);
-		bank->context.wake_en = __raw_readl(
-					bank->base + OMAP24XX_GPIO_WAKE_EN);
-		bank->context.ctrl = __raw_readl(
-					bank->base + OMAP24XX_GPIO_CTRL);
-		bank->context.oe = __raw_readl(
-					bank->base + OMAP24XX_GPIO_OE);
-		bank->context.leveldetect0 = __raw_readl(bank->base +
-					OMAP24XX_GPIO_LEVELDETECT0);
-		bank->context.leveldetect1 = __raw_readl(bank->base +
-					OMAP24XX_GPIO_LEVELDETECT1);
-		bank->context.risingdetect = __raw_readl(bank->base +
-					OMAP24XX_GPIO_RISINGDETECT);
-		bank->context.fallingdetect = __raw_readl(bank->base +
-					OMAP24XX_GPIO_FALLINGDETECT);
-		bank->context.dataout = __raw_readl(
-					bank->base + OMAP24XX_GPIO_DATAOUT);
-	} else if (bank->method == METHOD_GPIO_44XX) {
-		bank->context.irqenable1 = __raw_readl(
-					bank->base + OMAP4_GPIO_IRQSTATUSSET0);
-		bank->context.irqenable2 = __raw_readl(
-					bank->base + OMAP4_GPIO_IRQSTATUSSET1);
-		bank->context.wake_en = __raw_readl(
-					bank->base + OMAP4_GPIO_IRQWAKEN0);
-		bank->context.ctrl = __raw_readl(
-					bank->base + OMAP4_GPIO_CTRL);
-		bank->context.oe = __raw_readl(
-					bank->base + OMAP24XX_GPIO_OE);
-		bank->context.leveldetect0 = __raw_readl(bank->base +
-					OMAP4_GPIO_LEVELDETECT0);
-		bank->context.leveldetect1 = __raw_readl(bank->base +
-					OMAP4_GPIO_LEVELDETECT1);
-		bank->context.risingdetect = __raw_readl(bank->base +
-					OMAP4_GPIO_RISINGDETECT);
-		bank->context.fallingdetect = __raw_readl(bank->base +
-					OMAP4_GPIO_FALLINGDETECT);
-		bank->context.dataout = __raw_readl(
-					bank->base + OMAP4_GPIO_DATAOUT);
-	}
+	bank->context.irqenable1 =
+			__raw_readl(bank->base + bank->regs->irqenable);
+	bank->context.irqenable2 =
+			__raw_readl(bank->base + bank->regs->irqenable2);
+	bank->context.wake_en =
+			__raw_readl(bank->base + bank->regs->wkupstatus);
+	bank->context.ctrl = __raw_readl(bank->base + bank->regs->ctrl);
+	bank->context.oe = __raw_readl(bank->base + bank->regs->direction);
+	bank->context.leveldetect0 =
+			__raw_readl(bank->base + bank->regs->leveldetect0);
+	bank->context.leveldetect1 =
+			__raw_readl(bank->base + bank->regs->leveldetect1);
+	bank->context.risingdetect =
+			__raw_readl(bank->base + bank->regs->risingdetect);
+	bank->context.fallingdetect =
+			__raw_readl(bank->base + bank->regs->fallingdetect);
+	bank->context.dataout = __raw_readl(bank->base + bank->regs->dataout);
 }
 
 void omap_gpio_restore_context(struct gpio_bank *bank)
 {
-	if (bank->method == METHOD_GPIO_24XX) {
-		__raw_writel(bank->context.irqenable1, bank->base +
-						OMAP24XX_GPIO_IRQENABLE1);
-		__raw_writel(bank->context.irqenable2, bank->base +
-						OMAP24XX_GPIO_IRQENABLE2);
-		__raw_writel(bank->context.wake_en, bank->base +
-						OMAP24XX_GPIO_WAKE_EN);
-		__raw_writel(bank->context.ctrl, bank->base +
-						OMAP24XX_GPIO_CTRL);
-		__raw_writel(bank->context.oe, bank->base +
-						OMAP24XX_GPIO_OE);
-		__raw_writel(bank->context.leveldetect0, bank->base +
-						OMAP24XX_GPIO_LEVELDETECT0);
-		__raw_writel(bank->context.leveldetect1, bank->base +
-						OMAP24XX_GPIO_LEVELDETECT1);
-		__raw_writel(bank->context.risingdetect, bank->base +
-						OMAP24XX_GPIO_RISINGDETECT);
-		__raw_writel(bank->context.fallingdetect, bank->base +
-						OMAP24XX_GPIO_FALLINGDETECT);
-		__raw_writel(bank->context.dataout, bank->base +
-						OMAP24XX_GPIO_DATAOUT);
-	} else if (bank->method == METHOD_GPIO_44XX) {
-		__raw_writel(bank->context.irqenable1, bank->base +
-						OMAP4_GPIO_IRQSTATUSSET0);
-		__raw_writel(bank->context.irqenable2, bank->base +
-						OMAP4_GPIO_IRQSTATUSSET1);
-		__raw_writel(bank->context.wake_en, bank->base +
-						OMAP4_GPIO_IRQWAKEN0);
-		__raw_writel(bank->context.ctrl, bank->base +
-						OMAP4_GPIO_CTRL);
-		__raw_writel(bank->context.oe, bank->base +
-						OMAP24XX_GPIO_OE);
-		__raw_writel(bank->context.leveldetect0, bank->base +
-						OMAP4_GPIO_LEVELDETECT0);
-		__raw_writel(bank->context.leveldetect1, bank->base +
-						OMAP4_GPIO_LEVELDETECT1);
-		__raw_writel(bank->context.risingdetect, bank->base +
-						OMAP4_GPIO_RISINGDETECT);
-		__raw_writel(bank->context.fallingdetect, bank->base +
-						OMAP4_GPIO_FALLINGDETECT);
-		__raw_writel(bank->context.dataout, bank->base +
-						OMAP4_GPIO_DATAOUT);
-	}
+	__raw_writel(bank->context.irqenable1,
+				bank->base + bank->regs->irqenable);
+	__raw_writel(bank->context.irqenable2,
+				bank->base + bank->regs->irqenable2);
+	__raw_writel(bank->context.wake_en,
+				bank->base + bank->regs->wkupstatus);
+	__raw_writel(bank->context.ctrl,
+				bank->base + bank->regs->ctrl);
+	__raw_writel(bank->context.oe,
+				bank->base + bank->regs->direction);
+	__raw_writel(bank->context.leveldetect0,
+				bank->base + bank->regs->leveldetect0);
+	__raw_writel(bank->context.leveldetect1,
+				bank->base + bank->regs->leveldetect1);
+	__raw_writel(bank->context.risingdetect,
+				bank->base + bank->regs->risingdetect);
+	__raw_writel(bank->context.fallingdetect,
+				bank->base + bank->regs->fallingdetect);
+	__raw_writel(bank->context.dataout,
+				bank->base + bank->regs->dataout);
 }
 
 #endif
-- 
1.6.0.4

