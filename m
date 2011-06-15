From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v2 13/18] GPIO: OMAP15xx: Use pinctrl offset instead of macro
Date: Wed, 15 Jun 2011 09:53:21 +0530
Message-ID: <1308111806-29152-4-git-send-email-tarun.kanti@ti.com>
References: <1308111806-29152-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42078 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804Ab1FOEWy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Jun 2011 00:22:54 -0400
In-Reply-To: <1308111806-29152-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com

From: Charulatha V <charu@ti.com>

Use regs->pinctrl field instead of using the macro OMAP1510_GPIO_PIN_CONTROL

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap1/gpio15xx.c         |    1 +
 arch/arm/plat-omap/include/plat/gpio.h |    1 +
 drivers/gpio/gpio-omap.c               |    8 +++-----
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
index fd2fe8f..020725f 100644
--- a/arch/arm/mach-omap1/gpio15xx.c
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -85,6 +85,7 @@ static struct omap_gpio_reg_offs omap15xx_gpio_regs = {
 	.irqenable	= OMAP1510_GPIO_INT_MASK,
 	.irqenable_inv	= true,
 	.irqctrl	= OMAP1510_GPIO_INT_CONTROL,
+	.pinctrl	= OMAP1510_GPIO_PIN_CONTROL,
 };
 
 static struct __initdata omap_gpio_platform_data omap15xx_gpio_config = {
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 30db400..8f85700 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -202,6 +202,7 @@ struct omap_gpio_reg_offs {
 	u16 edgectrl2;
 	/* Not applicable for OMAP2+ as hwmod layer takes care of sysconfig */
 	u16 sysconfig;
+	u16 pinctrl;
 
 	bool irqenable_inv;
 };
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 89d1ea5..c6987f2 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -507,15 +507,13 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 	 */
 	_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
 
-#ifdef CONFIG_ARCH_OMAP15XX
-	if (bank->method == METHOD_GPIO_1510) {
-		void __iomem *reg;
+	if (bank->regs->pinctrl) {
+		void __iomem *reg = bank->base + bank->regs->pinctrl;
 
 		/* Claim the pin for MPU */
-		reg = bank->base + OMAP1510_GPIO_PIN_CONTROL;
 		__raw_writel(__raw_readl(reg) | (1 << offset), reg);
 	}
-#endif
+
 	if (bank->regs->ctrl && !bank->mod_usage) {
 		void __iomem *reg = bank->base + bank->regs->ctrl;
 		u32 ctrl;
-- 
1.6.0.4

