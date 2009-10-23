From: charu@ti.com
Subject: [PATCH] [OMAP] GPIO Module disable if all pins inactive
Date: Fri, 23 Oct 2009 21:25:17 +0530
Message-ID: <1256313317-24653-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45558 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752126AbZJWPzW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Oct 2009 11:55:22 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9NFtNbo001583
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 10:55:26 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Charulatha V <charu@ti.com>

From: Charulatha V <charu@ti.com>

This patch disables a GPIO module when all the pins of GPIO
module are inactive (clock gating forced at module level) and
enables the module when any gpio in the module is requested.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/plat-omap/gpio.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index cdc2a58..2304a5d 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -194,6 +194,7 @@ struct gpio_bank {
 	spinlock_t lock;
 	struct gpio_chip chip;
 	struct clk *dbck;
+	u32 gpio_status;
 };
 
 #define METHOD_MPUIO		0
@@ -1080,6 +1081,7 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 {
 	struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
 	unsigned long flags;
+	u32 ctrl = 0;
 
 	spin_lock_irqsave(&bank->lock, flags);
 
@@ -1097,6 +1099,15 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 		__raw_writel(__raw_readl(reg) | (1 << offset), reg);
 	}
 #endif
+	if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
+		if (!bank->gpio_status) {
+			ctrl = __raw_readl(bank->base + OMAP24XX_GPIO_CTRL);
+			/* Module is enabled, clocks are not gated */
+			ctrl &= 0xFFFFFFFE;
+			__raw_writel(ctrl, bank->base + OMAP24XX_GPIO_CTRL);
+		}
+		bank->gpio_status |= 1 << offset;
+	}
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
@@ -1106,6 +1117,7 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 {
 	struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
 	unsigned long flags;
+	u32 ctrl = 0;
 
 	spin_lock_irqsave(&bank->lock, flags);
 #ifdef CONFIG_ARCH_OMAP16XX
@@ -1123,6 +1135,15 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 		__raw_writel(1 << offset, reg);
 	}
 #endif
+	if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
+		bank->gpio_status &= ~(1 << offset);
+		if (!bank->gpio_status) {
+			ctrl = __raw_readl(bank->base + OMAP24XX_GPIO_CTRL);
+			/* Module is disabled, clocks are gated */
+			ctrl |= 1;
+			__raw_writel(ctrl, bank->base + OMAP24XX_GPIO_CTRL);
+		}
+	}
 	_reset_gpio(bank, bank->chip.base + offset);
 	spin_unlock_irqrestore(&bank->lock, flags);
 }
@@ -1700,6 +1721,7 @@ static int __init _omap_gpio_init(void)
 			gpio_count = 32;
 		}
 #endif
+		bank->gpio_status = 0;
 		/* REVISIT eventually switch from OMAP-specific gpio structs
 		 * over to the generic ones
 		 */
-- 
1.6.0.4

