From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/12] omap: GPIO module enable/disable
Date: Mon, 16 Nov 2009 15:26:58 -0800
Message-ID: <20091116232658.24892.92547.stgit@localhost>
References: <20091116232435.24892.81547.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57366 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755174AbZKPX0y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Nov 2009 18:26:54 -0500
In-Reply-To: <20091116232435.24892.81547.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, Charulatha V <charu@ti.com>

From: Charulatha V <charu@ti.com>

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
Signed-off-by: Tony Lindgren <tony@atomide.com>
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

