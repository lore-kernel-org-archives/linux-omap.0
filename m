From: Charulatha V <charu@ti.com>
Subject: [PATCH v4] OMAP: GPIO module enable/disable
Date: Fri, 13 Nov 2009 18:46:09 +0530
Message-ID: <1258118169-27600-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54783 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751410AbZKMNIW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Nov 2009 08:08:22 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nADD8Per018994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 13 Nov 2009 07:08:27 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Charulatha V <charu@ti.com>

This patch disables a GPIO module when all pins of a GPIO
module are inactive (clock gating forced at module level) and
enables the module when any gpio in the module is requested.

The module is enabled only when "mod_usage" indicates that no GPIO
in that  module is currently active and the GPIO being requested
is the 1st one to be active in that module.

Each module would be disabled in omap_gpio_free() API when all
GPIOs in a particular module becomes inactive. The module is
re-enabled in omap_gpio_request() API when a GPIO is requested
from the module that was previously disabled.

Since individual GPIO's bookkeeping is added in this patch
via "mod_usage", the same is used in omap_set_gpio_debounce()
& omap_set_gpio_debounce_time() APIs to ensure that the gpio being
used is actually "requested" prior to being used (Nishant Menon's
<nm@ti.comSuggestion)

GPIO module level details are specific to hardware and hence
introducing this patch in low level layer (plat-omap/gpio.c)

Signed-off-by: Charulatha V <charu@ti.com>
Acked-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/plat-omap/gpio.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index b71052c..ce4f0cd 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -195,6 +195,7 @@ struct gpio_bank {
 	spinlock_t lock;
 	struct gpio_chip chip;
 	struct clk *dbck;
+	u32 mod_usage;
 };
 
 #define METHOD_MPUIO		0
@@ -628,6 +629,10 @@ void omap_set_gpio_debounce(int gpio, int enable)
 #else
 	reg += OMAP24XX_GPIO_DEBOUNCE_EN;
 #endif
+	if (!(bank->mod_usage & l)) {
+		printk(KERN_ERR "GPIO %d not requested\n", gpio);
+		return;
+	}
 
 	spin_lock_irqsave(&bank->lock, flags);
 	val = __raw_readl(reg);
@@ -663,6 +668,11 @@ void omap_set_gpio_debounce_time(int gpio, int enc_time)
 	bank = get_gpio_bank(gpio);
 	reg = bank->base;
 
+	if (!bank->mod_usage) {
+		printk(KERN_ERR "GPIO not requested\n");
+		return;
+	}
+
 	enc_time &= 0xff;
 #ifdef CONFIG_ARCH_OMAP4
 	reg += OMAP4_GPIO_DEBOUNCINGTIME;
@@ -1144,6 +1154,16 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 		__raw_writel(__raw_readl(reg) | (1 << offset), reg);
 	}
 #endif
+	if (!cpu_class_is_omap1()) {
+		if (!bank->mod_usage) {
+			u32 ctrl;
+			ctrl = __raw_readl(bank->base + OMAP24XX_GPIO_CTRL);
+			ctrl &= 0xFFFFFFFE;
+			/* Module is enabled, clocks are not gated */
+			__raw_writel(ctrl, bank->base + OMAP24XX_GPIO_CTRL);
+		}
+		bank->mod_usage |= 1 << offset;
+	}
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
@@ -1170,6 +1190,16 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 		__raw_writel(1 << offset, reg);
 	}
 #endif
+	if (!cpu_class_is_omap1()) {
+		bank->mod_usage &= ~(1 << offset);
+		if (!bank->mod_usage) {
+			u32 ctrl;
+			ctrl = __raw_readl(bank->base + OMAP24XX_GPIO_CTRL);
+			/* Module is disabled, clocks are gated */
+			ctrl |= 1;
+			__raw_writel(ctrl, bank->base + OMAP24XX_GPIO_CTRL);
+		}
+	}
 	_reset_gpio(bank, bank->chip.base + offset);
 	spin_unlock_irqrestore(&bank->lock, flags);
 }
@@ -1749,6 +1779,8 @@ static int __init _omap_gpio_init(void)
 			gpio_count = 32;
 		}
 #endif
+
+		bank->mod_usage = 0;
 		/* REVISIT eventually switch from OMAP-specific gpio structs
 		 * over to the generic ones
 		 */
-- 
1.6.0.4

