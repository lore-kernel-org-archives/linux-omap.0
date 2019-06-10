From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH-next 05/20] gpio: gpio-omap: remove irq_ack method
Date: Mon, 10 Jun 2019 20:10:48 +0300
Message-ID: <20190610171103.30903-6-grygorii.strashko@ti.com>
References: <20190610171103.30903-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610171103.30903-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Santosh Shilimkar <ssantosh@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

The irq_ack method does not fit our hardware requirements. Edge
interrupts must be cleared before we handle them, and level interrupts
must be cleared after handling them.

We handle the interrupt clearance in our interrupt handler for edge IRQs
and in the unmask method for level IRQs.

Replace the irq_ack method with the no-op method from the dummy irq
chip.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/gpio/gpio-omap.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 01da1c17bb20..04e3da55e39c 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -852,14 +852,6 @@ static void gpio_irq_bus_sync_unlock(struct irq_data *data)
 	pm_runtime_put(bank->chip.parent);
 }
 
-static void omap_gpio_ack_irq(struct irq_data *d)
-{
-	struct gpio_bank *bank = omap_irq_data_get_bank(d);
-	unsigned offset = d->hwirq;
-
-	omap_clear_gpio_irqstatus(bank, offset);
-}
-
 static void omap_gpio_mask_irq(struct irq_data *d)
 {
 	struct gpio_bank *bank = omap_irq_data_get_bank(d);
@@ -1181,11 +1173,8 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
 #endif
 
 	/* MPUIO is a bit different, reading IRQ status clears it */
-	if (bank->is_mpuio) {
-		irqc->irq_ack = dummy_irq_chip.irq_ack;
-		if (!bank->regs->wkup_en)
-			irqc->irq_set_wake = NULL;
-	}
+	if (bank->is_mpuio && !bank->regs->wkup_en)
+		irqc->irq_set_wake = NULL;
 
 	irq = &bank->chip.irq;
 	irq->chip = irqc;
@@ -1531,7 +1520,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 
 	irqc->irq_startup = omap_gpio_irq_startup,
 	irqc->irq_shutdown = omap_gpio_irq_shutdown,
-	irqc->irq_ack = omap_gpio_ack_irq,
+	irqc->irq_ack = dummy_irq_chip.irq_ack,
 	irqc->irq_mask = omap_gpio_mask_irq,
 	irqc->irq_unmask = omap_gpio_unmask_irq,
 	irqc->irq_set_type = omap_gpio_irq_type,
-- 
2.17.1
