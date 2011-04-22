From: Charulatha V <charu@ti.com>
Subject: [RFC PATCH 08/18] OMAP: GPIO: req/free: Remove reg offset macros usage
Date: Fri, 22 Apr 2011 16:38:22 +0530
Message-ID: <1303470512-19671-9-git-send-email-charu@ti.com>
References: <1303470512-19671-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38709 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755121Ab1DVLFD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Apr 2011 07:05:03 -0400
In-Reply-To: <1303470512-19671-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, Charulatha V <charu@ti.com>

Remove the usage of register offset macros from
gpio_request/free() APIs.

Instead use the enum omap_gpio_reg_offsets and SoC specific
gpio_read/write functions to access the GPIO registers.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/plat-omap/gpio.c |   65 +++++++++++++-------------------------------
 1 files changed, 19 insertions(+), 46 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 115916d..28f58c6 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -700,28 +700,17 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 	 */
 	_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
 
-#ifdef CONFIG_ARCH_OMAP15XX
 	if (bank->method == METHOD_GPIO_1510) {
-		void __iomem *reg;
-
 		/* Claim the pin for MPU */
-		reg = bank->base + OMAP1510_GPIO_PIN_CONTROL;
-		__raw_writel(__raw_readl(reg) | (1 << offset), reg);
+		u32 ctrl = gpio_fn.gpio_read(bank->base, CTRL);
+		gpio_fn.gpio_write(ctrl | (1 << offset), bank->base, CTRL);
 	}
-#endif
-	if (!cpu_class_is_omap1()) {
+
+	if (bank->method >= METHOD_GPIO_24XX) {
 		if (!bank->mod_usage) {
-			void __iomem *reg = bank->base;
-			u32 ctrl;
-
-			if (cpu_is_omap24xx() || cpu_is_omap34xx())
-				reg += OMAP24XX_GPIO_CTRL;
-			else if (cpu_is_omap44xx())
-				reg += OMAP4_GPIO_CTRL;
-			ctrl = __raw_readl(reg);
+			u32 ctrl = gpio_fn.gpio_read(bank->base, CTRL);
 			/* Module is enabled, clocks are not gated */
-			ctrl &= 0xFFFFFFFE;
-			__raw_writel(ctrl, reg);
+			gpio_fn.gpio_write(ctrl & ~0x1, bank->base, CTRL);
 		}
 		bank->mod_usage |= 1 << offset;
 	}
@@ -736,43 +725,27 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 	unsigned long flags;
 
 	spin_lock_irqsave(&bank->lock, flags);
-#ifdef CONFIG_ARCH_OMAP16XX
-	if (bank->method == METHOD_GPIO_1610) {
-		/* Disable wake-up during idle for dynamic tick */
-		void __iomem *reg = bank->base + OMAP1610_GPIO_CLEAR_WAKEUPENA;
-		__raw_writel(1 << offset, reg);
-	}
-#endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-	if (bank->method == METHOD_GPIO_24XX) {
+
+	if ((bank->method == METHOD_GPIO_1610) ||
+			(bank->method == METHOD_GPIO_24XX)) {
 		/* Disable wake-up during idle for dynamic tick */
-		void __iomem *reg = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
-		__raw_writel(1 << offset, reg);
-	}
-#endif
-#ifdef CONFIG_ARCH_OMAP4
-	if (bank->method == METHOD_GPIO_44XX) {
+		gpio_fn.gpio_write(1 << offset, bank->base, CLEARWKUENA);
+	} else if (bank->method == METHOD_GPIO_44XX) {
 		/* Disable wake-up during idle for dynamic tick */
-		void __iomem *reg = bank->base + OMAP4_GPIO_IRQWAKEN0;
-		__raw_writel(1 << offset, reg);
+		gpio_fn.gpio_write(1 << offset, bank->base, IRQWAKEN0);
 	}
-#endif
-	if (!cpu_class_is_omap1()) {
+
+
+	if (bank->method >= METHOD_GPIO_24XX) {
 		bank->mod_usage &= ~(1 << offset);
+
 		if (!bank->mod_usage) {
-			void __iomem *reg = bank->base;
-			u32 ctrl;
-
-			if (cpu_is_omap24xx() || cpu_is_omap34xx())
-				reg += OMAP24XX_GPIO_CTRL;
-			else if (cpu_is_omap44xx())
-				reg += OMAP4_GPIO_CTRL;
-			ctrl = __raw_readl(reg);
+			u32 ctrl = gpio_fn.gpio_read(bank->base, CTRL);
 			/* Module is disabled, clocks are gated */
-			ctrl |= 1;
-			__raw_writel(ctrl, reg);
+			gpio_fn.gpio_write(ctrl | 1, bank->base, CTRL);
 		}
 	}
+
 	_reset_gpio(bank, bank->chip.base + offset);
 	spin_unlock_irqrestore(&bank->lock, flags);
 }
-- 
1.7.1

