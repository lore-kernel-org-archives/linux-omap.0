From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 14/15] OMAP: GPIO: debounce remove SoC specific registers, use pdata
Date: Fri, 22 Apr 2011 16:02:06 -0700
Message-ID: <1303513327-14532-15-git-send-email-khilman@ti.com>
References: <1303513327-14532-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:41932 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755489Ab1DVXAc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Apr 2011 19:00:32 -0400
Received: by pvg11 with SMTP id 11so624938pvg.13
        for <linux-omap@vger.kernel.org>; Fri, 22 Apr 2011 16:00:30 -0700 (PDT)
In-Reply-To: <1303513327-14532-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: charu@ti.com

Use register offsets passed in from pdata for accessing debounce registers.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/gpio.c             |    4 ++++
 arch/arm/plat-omap/gpio.c              |   15 +++------------
 arch/arm/plat-omap/include/plat/gpio.h |    2 ++
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index cc26677..316d930 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -81,6 +81,8 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		pdata->regs->irqenable = OMAP24XX_GPIO_IRQENABLE1;
 		pdata->regs->set_irqenable = OMAP24XX_GPIO_SETIRQENABLE1;
 		pdata->regs->clr_irqenable = OMAP24XX_GPIO_CLEARIRQENABLE1;
+		pdata->regs->debounce = OMAP24XX_GPIO_DEBOUNCE_VAL;
+		pdata->regs->debounce_en = OMAP24XX_GPIO_DEBOUNCE_EN;
 		break;
 	case 2:
 		pdata->bank_type = METHOD_GPIO_44XX;
@@ -94,6 +96,8 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		pdata->regs->irqenable = OMAP4_GPIO_IRQSTATUSSET0;
 		pdata->regs->set_irqenable = OMAP4_GPIO_IRQSTATUSSET0;
 		pdata->regs->clr_irqenable = OMAP4_GPIO_IRQSTATUSCLR0;
+		pdata->regs->debounce = OMAP4_GPIO_DEBOUNCINGTIME;
+		pdata->regs->debounce_en = OMAP4_GPIO_DEBOUNCENABLE;
 		break;
 	default:
 		WARN(1, "Invalid gpio bank_type\n");
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 82afed8..17f29cc 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -170,7 +170,7 @@ do {	\
 static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
 		unsigned debounce)
 {
-	void __iomem		*reg = bank->base;
+	void __iomem		*reg;
 	u32			val;
 	u32			l;
 
@@ -186,19 +186,10 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
 
 	l = GPIO_BIT(bank, gpio);
 
-	if (bank->method == METHOD_GPIO_44XX)
-		reg += OMAP4_GPIO_DEBOUNCINGTIME;
-	else
-		reg += OMAP24XX_GPIO_DEBOUNCE_VAL;
-
+	reg = bank->base + bank->regs->debounce;
 	__raw_writel(debounce, reg);
 
-	reg = bank->base;
-	if (bank->method == METHOD_GPIO_44XX)
-		reg += OMAP4_GPIO_DEBOUNCENABLE;
-	else
-		reg += OMAP24XX_GPIO_DEBOUNCE_EN;
-
+	reg = bank->base + bank->regs->debounce_en;
 	val = __raw_readl(reg);
 
 	if (debounce) {
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index c7e3a56..7a3f067 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -185,6 +185,8 @@ struct omap_gpio_reg_offs {
 	u16 irqenable;
 	u16 set_irqenable;
 	u16 clr_irqenable;
+	u16 debounce;
+	u16 debounce_en;
 
 	bool irqenable_inv;
 };
-- 
1.7.4

