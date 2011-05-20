From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 13/14] GPIO: OMAP: debounce remove SoC specific registers, use pdata
Date: Fri, 20 May 2011 17:14:56 +0200
Message-ID: <1305904497-26013-14-git-send-email-khilman@ti.com>
References: <1305904497-26013-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:52738 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933776Ab1ETPPr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 May 2011 11:15:47 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so4117481wya.33
        for <linux-omap@vger.kernel.org>; Fri, 20 May 2011 08:15:46 -0700 (PDT)
In-Reply-To: <1305904497-26013-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org

Use register offsets passed in from pdata for accessing debounce registers.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/gpio.c             |    4 ++++
 arch/arm/plat-omap/include/plat/gpio.h |    2 ++
 drivers/gpio/gpio_omap.c               |   15 +++------------
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
diff --git a/drivers/gpio/gpio_omap.c b/drivers/gpio/gpio_omap.c
index b5e2e94..072d568 100644
--- a/drivers/gpio/gpio_omap.c
+++ b/drivers/gpio/gpio_omap.c
@@ -168,7 +168,7 @@ do {	\
 static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
 		unsigned debounce)
 {
-	void __iomem		*reg = bank->base;
+	void __iomem		*reg;
 	u32			val;
 	u32			l;
 
@@ -184,19 +184,10 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
 
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
-- 
1.7.3.4

