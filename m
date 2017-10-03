From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RESEND PATCH] gpio: omap: Fix lost edge interrupts
Date: Tue, 3 Oct 2017 11:17:05 -0500
Message-ID: <20171003161705.23398-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Ladislav Michl <ladis@linux-mips.org>
List-Id: linux-omap@vger.kernel.org

Now acking of edge irqs happens the following way:
- omap_gpio_irq_handler
  - "isr" = read irq status
  - omap_clear_gpio_irqbank(bank, isr_saved & ~level_mask); 
	^ clear edge status, so irq can be accepted
  - loop while "isr"
	generic_handle_irq()
	 - handle_edge_irq()
	    - desc->irq_data.chip->irq_ack(&desc->irq_data); 
		- omap_gpio_ack_irq()
it might be that at this moment edge IRQ was triggered again and it will be
cleared and IRQ will be lost.

Use handle_simple_irq and clear edge interrupts early without disabling them in
omap_gpio_irq_handler to avoid loosing interrupts.

[1] https://marc.info/?l=linux-omap&m=149004465313534&w=2
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
Resend with proper cc list.

 drivers/gpio/gpio-omap.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index dbf869f..0c80052 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -518,7 +518,13 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
 	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
 		irq_set_handler_locked(d, handle_level_irq);
 	else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
-		irq_set_handler_locked(d, handle_edge_irq);
+		/*
+		 * Edge IRQs are already cleared/acked in irq_handler and
+		 * not need to be masked, as result handle_edge_irq()
+		 * logic is excessed here and may cause lose of interrupts.
+		 * So just use handle_simple_irq.
+		 */
+		irq_set_handler_locked(d, handle_simple_irq);
 
 	return 0;
 
@@ -678,7 +684,7 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 static irqreturn_t omap_gpio_irq_handler(int irq, void *gpiobank)
 {
 	void __iomem *isr_reg = NULL;
-	u32 isr;
+	u32 enabled, isr, level_mask;
 	unsigned int bit;
 	struct gpio_bank *bank = gpiobank;
 	unsigned long wa_lock_flags;
@@ -691,23 +697,21 @@ static irqreturn_t omap_gpio_irq_handler(int irq, void *gpiobank)
 	pm_runtime_get_sync(bank->chip.parent);
 
 	while (1) {
-		u32 isr_saved, level_mask = 0;
-		u32 enabled;
-
 		raw_spin_lock_irqsave(&bank->lock, lock_flags);
 
 		enabled = omap_get_gpio_irqbank_mask(bank);
-		isr_saved = isr = readl_relaxed(isr_reg) & enabled;
+		isr = readl_relaxed(isr_reg) & enabled;
 
 		if (bank->level_mask)
 			level_mask = bank->level_mask & enabled;
+		else
+			level_mask = 0;
 
 		/* clear edge sensitive interrupts before handler(s) are
 		called so that we don't miss any interrupt occurred while
 		executing them */
-		omap_disable_gpio_irqbank(bank, isr_saved & ~level_mask);
-		omap_clear_gpio_irqbank(bank, isr_saved & ~level_mask);
-		omap_enable_gpio_irqbank(bank, isr_saved & ~level_mask);
+		if (isr & ~level_mask)
+			omap_clear_gpio_irqbank(bank, isr & ~level_mask);
 
 		raw_spin_unlock_irqrestore(&bank->lock, lock_flags);
 
-- 
2.10.1

