From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: [PATCH 1/3] gpio: omap: Remove unnecessary lockdep class
Date: Fri, 27 Jun 2014 22:17:35 +0200
Message-ID: <1403900258-20717-2-git-send-email-jmartinez@softcrates.net>
References: <1403900258-20717-1-git-send-email-jmartinez@softcrates.net>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1403900258-20717-1-git-send-email-jmartinez@softcrates.net>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, Javier Martinez Canillas <jmartinez@softcrates.net>
List-Id: linux-omap@vger.kernel.org

GPIO irqchips assign to the cascaded IRQs their own lock class
in order to avoid warnings about lockdep recursions since that
allow the lockdep core to keep track of things.

Since commit e45d1c80 ("gpio: put GPIO IRQs into their own lock class")
there is no need to do this in a driver if it's using the GPIO
irqchip helpers since gpiolib already assigns a lockdep class.

Signed-off-by: Javier Martinez Canillas <jmartinez@softcrates.net>
---
 drivers/gpio/gpio-omap.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 00f29aa..4b4e1b4 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1025,11 +1025,6 @@ static void __init omap_gpio_show_rev(struct gpio_bank *bank)
 	called = true;
 }
 
-/* This lock class tells lockdep that GPIO irqs are in a different
- * category than their parents, so it won't report false recursion.
- */
-static struct lock_class_key gpio_lock_class;
-
 static void omap_gpio_mod_init(struct gpio_bank *bank)
 {
 	void __iomem *base = bank->base;
@@ -1152,7 +1147,6 @@ static int omap_gpio_chip_init(struct gpio_bank *bank)
 
 	for (j = 0; j < bank->width; j++) {
 		int irq = irq_find_mapping(bank->chip.irqdomain, j);
-		irq_set_lockdep_class(irq, &gpio_lock_class);
 		if (bank->is_mpuio) {
 			omap_mpuio_alloc_gc(bank, irq, bank->width);
 			irq_set_chip_and_handler(irq, NULL, NULL);
-- 
2.0.0.rc2

