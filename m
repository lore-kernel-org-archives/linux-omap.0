From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 4/7] gpio: omap: protect regs access in omap_gpio_irq_handler
Date: Tue, 18 Aug 2015 14:10:55 +0300
Message-ID: <1439896258-26449-5-git-send-email-grygorii.strashko@ti.com>
References: <1439896258-26449-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439896258-26449-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, tony@atomide.com
Cc: Javier Martinez Canillas <javier@dowhile0.org>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

The access to HW registers has to be be protected in
omap_gpio_irq_handler(), as it may race with code executed on
another CPUs.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/gpio/gpio-omap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 9ed5a67..1f02acd 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -718,6 +718,7 @@ static void omap_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	int unmasked = 0;
 	struct irq_chip *irqchip = irq_desc_get_chip(desc);
 	struct gpio_chip *chip = irq_desc_get_handler_data(desc);
+	unsigned long lock_flags;
 
 	chained_irq_enter(irqchip, desc);
 
@@ -732,6 +733,8 @@ static void omap_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 		u32 isr_saved, level_mask = 0;
 		u32 enabled;
 
+		raw_spin_lock_irqsave(&bank->lock, lock_flags);
+
 		enabled = omap_get_gpio_irqbank_mask(bank);
 		isr_saved = isr = readl_relaxed(isr_reg) & enabled;
 
@@ -745,6 +748,8 @@ static void omap_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 		omap_clear_gpio_irqbank(bank, isr_saved & ~level_mask);
 		omap_enable_gpio_irqbank(bank, isr_saved & ~level_mask);
 
+		raw_spin_unlock_irqrestore(&bank->lock, lock_flags);
+
 		/* if there is only edge sensitive GPIO pin interrupts
 		configured, we could unmask GPIO bank interrupt immediately */
 		if (!level_mask && !unmasked) {
@@ -759,6 +764,7 @@ static void omap_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 			bit = __ffs(isr);
 			isr &= ~(BIT(bit));
 
+			raw_spin_lock_irqsave(&bank->lock, lock_flags);
 			/*
 			 * Some chips can't respond to both rising and falling
 			 * at the same time.  If this irq was requested with
@@ -769,6 +775,8 @@ static void omap_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 			if (bank->toggle_mask & (BIT(bit)))
 				omap_toggle_gpio_edge_triggering(bank, bit);
 
+			raw_spin_unlock_irqrestore(&bank->lock, lock_flags);
+
 			generic_handle_irq(irq_find_mapping(bank->chip.irqdomain,
 							    bit));
 		}
-- 
2.5.0
