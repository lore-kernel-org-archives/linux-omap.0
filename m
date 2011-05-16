From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [RFC PATCH 09/10] OMAP: GPIO: cleanup omap_gpio_free and triggering functions
Date: Mon, 16 May 2011 17:11:43 +0530
Message-ID: <1305546104-1511-10-git-send-email-tarun.kanti@ti.com>
References: <1305546104-1511-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45255 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753501Ab1EPLlx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 May 2011 07:41:53 -0400
In-Reply-To: <1305546104-1511-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, Charulatha V <charu@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>

We can get rid of ifdef / if checks of OMAP revision in set_24xx_gpio_triggering()
and omap_gpio_free().

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: Charulatha V <charu@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/gpio.c |   38 ++++++++------------------------------
 1 files changed, 8 insertions(+), 30 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 714626a..bc07559 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -269,15 +269,9 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
 			bank->enabled_non_wakeup_gpios &= ~gpio_bit;
 	}
 
-	if (cpu_is_omap44xx()) {
-		bank->level_mask =
-			__raw_readl(bank->base + OMAP4_GPIO_LEVELDETECT0) |
-			__raw_readl(bank->base + OMAP4_GPIO_LEVELDETECT1);
-	} else {
-		bank->level_mask =
-			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0) |
-			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
-	}
+	bank->level_mask =
+		__raw_readl(bank->base + bank->regs->leveldetect0) |
+		__raw_readl(bank->base + bank->regs->leveldetect1);
 }
 #endif
 
@@ -609,29 +603,13 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 {
 	struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
 	unsigned long flags;
+	void __iomem *reg;
 
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
-		/* Disable wake-up during idle for dynamic tick */
-		void __iomem *reg = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
-		__raw_writel(1 << offset, reg);
-	}
-#endif
-#ifdef CONFIG_ARCH_OMAP4
-	if (bank->method == METHOD_GPIO_44XX) {
-		/* Disable wake-up during idle for dynamic tick */
-		void __iomem *reg = bank->base + OMAP4_GPIO_IRQWAKEN0;
-		__raw_writel(1 << offset, reg);
-	}
-#endif
+	/* Disable wake-up during idle for dynamic tick */
+	reg = bank->base + bank->regs->wkupclear;
+
+	__raw_writel(1 << offset, reg);
 	bank->mod_usage &= ~(1 << offset);
 
 	if ((bank->regs->ctrl != USHRT_MAX) && (!bank->mod_usage)) {
-- 
1.6.0.4

