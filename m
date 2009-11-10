From: charu@ti.com
Subject: [PATCH V3] [OMAP] GPIO module enable/disable
Date: Tue, 10 Nov 2009 17:58:38 +0530
Message-ID: <1257856118-30950-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55764 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753438AbZKJM2h (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Nov 2009 07:28:37 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAACSe8F008694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2009 06:28:43 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Charulatha V <charu@ti.com>

From: Charulatha V <charu@ti.com>

This patch disables a GPIO module when all pins of a GPIO
module are inactive (clock gating forced at module level) and
enables the module when any gpio in the module is requested.

The module is enabled only when "mod_usage" indicates that no GPIO
in that module is currently active and the GPIO being requested
is the 1st one to be active in that module.

Each module would be disabled in omap_gpio_free() API when all
GPIOs in a particular module becomes inactive. The module is
re-enabled in omap_gpio_request() API when a GPIO is requested
from the module that was previously disabled.

Since individual GPIO's bookkeeping is added in this patch
via "mod_usage", the same is used in omap_set_gpio_debounce()
& omap_set_gpio_debounce_time() APIs to ensure that the gpio being
used is actually "requested" prior to being used (Nishant Menon's
Suggestion <nm@ti.com>)

GPIO module level details are specific to hardware and hence
introducing this patch in low level layer (plat-omap/gpio.c)

Signed-off-by: Charulatha V <charu@ti.com>
Acked-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/plat-omap/gpio.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 4c35f9f..06a391b 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -199,6 +199,7 @@ struct gpio_bank {
 	struct gpio_chip chip;
 	struct clk *dbck;
 	u32 dbck_enable_mask;
+	u32 mod_usage;
 };
 
 #define METHOD_MPUIO		0
@@ -690,6 +691,10 @@ void omap_set_gpio_debounce(int gpio, int enable)
 #else
 	reg += OMAP24XX_GPIO_DEBOUNCE_EN;
 #endif
+	if (!(bank->mod_usage & l)) {
+		printk(KERN_ERR "GPIO %d not requested\n", gpio);
+		return;
+	}
 
 	spin_lock_irqsave(&bank->lock, flags);
 	val = __raw_readl(reg);
@@ -726,6 +731,11 @@ void omap_set_gpio_debounce_time(int gpio, int enc_time)
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
@@ -1219,6 +1229,16 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
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
@@ -1245,6 +1265,16 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
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
@@ -1879,6 +1909,8 @@ static int __init _omap_gpio_init(void)
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

