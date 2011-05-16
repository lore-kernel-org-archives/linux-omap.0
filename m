From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [RFC PATCH 10/10] OMAP: GPIO: remove harcoded offsets in context save and restore
Date: Mon, 16 May 2011 17:11:44 +0530
Message-ID: <1305546104-1511-11-git-send-email-tarun.kanti@ti.com>
References: <1305546104-1511-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48342 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753500Ab1EPLlx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 May 2011 07:41:53 -0400
In-Reply-To: <1305546104-1511-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, Charulatha V <charu@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>

We don't have to use hard-coded offsets any more in context save and
restore functions and instead use the generic offsets whcih have been
correctly initialized during device registration.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: Charulatha V <charu@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/gpio.c             |    2 +
 arch/arm/plat-omap/gpio.c              |   40 ++++++++++++++++----------------
 arch/arm/plat-omap/include/plat/gpio.h |    1 +
 3 files changed, 23 insertions(+), 20 deletions(-)

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
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 3d34461..171a1ce 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1400,25 +1400,25 @@ void omap_gpio_save_context(void)
 			continue;
 
 		gpio_context[i].irqenable1 =
-			__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE1);
+			__raw_readl(bank->base + bank->regs->irqenable);
 		gpio_context[i].irqenable2 =
-			__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE2);
+			__raw_readl(bank->base + bank->regs->irqenable2);
 		gpio_context[i].wake_en =
-			__raw_readl(bank->base + OMAP24XX_GPIO_WAKE_EN);
+			__raw_readl(bank->base + bank->regs->wkupstatus);
 		gpio_context[i].ctrl =
-			__raw_readl(bank->base + OMAP24XX_GPIO_CTRL);
+			__raw_readl(bank->base + bank->regs->ctrl);
 		gpio_context[i].oe =
-			__raw_readl(bank->base + OMAP24XX_GPIO_OE);
+			__raw_readl(bank->base + bank->regs->direction);
 		gpio_context[i].leveldetect0 =
-			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0);
+			__raw_readl(bank->base + bank->regs->leveldetect0);
 		gpio_context[i].leveldetect1 =
-			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
+			__raw_readl(bank->base + bank->regs->leveldetect1);
 		gpio_context[i].risingdetect =
-			__raw_readl(bank->base + OMAP24XX_GPIO_RISINGDETECT);
+			__raw_readl(bank->base + bank->regs->risingdetect);
 		gpio_context[i].fallingdetect =
-			__raw_readl(bank->base + OMAP24XX_GPIO_FALLINGDETECT);
+			__raw_readl(bank->base + bank->regs->fallingdetect);
 		gpio_context[i].dataout =
-			__raw_readl(bank->base + OMAP24XX_GPIO_DATAOUT);
+			__raw_readl(bank->base + bank->regs->dataout);
 	}
 }
 
@@ -1435,25 +1435,25 @@ void omap_gpio_restore_context(void)
 			continue;
 
 		__raw_writel(gpio_context[i].irqenable1,
-				bank->base + OMAP24XX_GPIO_IRQENABLE1);
+				bank->base + bank->regs->irqenable);
 		__raw_writel(gpio_context[i].irqenable2,
-				bank->base + OMAP24XX_GPIO_IRQENABLE2);
+				bank->base + bank->regs->irqenable2);
 		__raw_writel(gpio_context[i].wake_en,
-				bank->base + OMAP24XX_GPIO_WAKE_EN);
+				bank->base + bank->regs->wkupstatus);
 		__raw_writel(gpio_context[i].ctrl,
-				bank->base + OMAP24XX_GPIO_CTRL);
+				bank->base + bank->regs->ctrl);
 		__raw_writel(gpio_context[i].oe,
-				bank->base + OMAP24XX_GPIO_OE);
+				bank->base + bank->regs->direction);
 		__raw_writel(gpio_context[i].leveldetect0,
-				bank->base + OMAP24XX_GPIO_LEVELDETECT0);
+				bank->base + bank->regs->leveldetect0);
 		__raw_writel(gpio_context[i].leveldetect1,
-				bank->base + OMAP24XX_GPIO_LEVELDETECT1);
+				bank->base + bank->regs->leveldetect1);
 		__raw_writel(gpio_context[i].risingdetect,
-				bank->base + OMAP24XX_GPIO_RISINGDETECT);
+				bank->base + bank->regs->risingdetect);
 		__raw_writel(gpio_context[i].fallingdetect,
-				bank->base + OMAP24XX_GPIO_FALLINGDETECT);
+				bank->base + bank->regs->fallingdetect);
 		__raw_writel(gpio_context[i].dataout,
-				bank->base + OMAP24XX_GPIO_DATAOUT);
+				bank->base + bank->regs->dataout);
 	}
 }
 #endif
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index d4e9f3c..964c7e6 100644
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
-- 
1.6.0.4
