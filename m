From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v3 14/20] GPIO: OMAP15xx: Use pinctrl offset instead of macro
Date: Fri, 1 Jul 2011 15:17:08 +0530
Message-ID: <1309513634-20971-15-git-send-email-tarun.kanti@ti.com>
References: <1309513634-20971-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59313 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755936Ab1GAJrr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 05:47:47 -0400
In-Reply-To: <1309513634-20971-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, Charulatha V <charu@ti.com>

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
index 3f7b028..e1ef4e4 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -200,6 +200,7 @@ struct omap_gpio_reg_offs {
 	u16 edgectrl2;
 	/* Not applicable for OMAP2+ as hwmod layer takes care of sysconfig */
 	u16 sysconfig;
+	u16 pinctrl;
 
 	bool irqenable_inv;
 };
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 3acbaa9..7f32f7b 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -482,15 +482,13 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
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

