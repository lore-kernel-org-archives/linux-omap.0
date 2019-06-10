From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH-next 04/20] gpio: gpio-omap: clean up edge interrupt handling
Date: Mon, 10 Jun 2019 20:10:47 +0300
Message-ID: <20190610171103.30903-5-grygorii.strashko@ti.com>
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

The edge interrupt handling was effectively:

	isr = ISR_reg & enabled;
	if (bank->level_mask)
		level_mask = bank->level_mask & enabled;
	else
		level_mask = 0;

	edge = isr & ~level_mask;

When bank->level_mask is zero, level_mask will be computed as zero
anyway, so the if() statement is redundant.  We are then left with:

	isr = ISR_reg & enabled;
	level_mask = bank->level_mask & enabled;
	edge = isr & ~level_mask;

This can be simplified further to:

	isr = ISR_reg & enabled;
	edge = isr & ~bank->level_mask;

since the second mask with 'enabled' is redundant.

Improve the associated comment as well.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/gpio/gpio-omap.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 708a135e2f0c..01da1c17bb20 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -733,7 +733,7 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 static irqreturn_t omap_gpio_irq_handler(int irq, void *gpiobank)
 {
 	void __iomem *isr_reg = NULL;
-	u32 enabled, isr, level_mask;
+	u32 enabled, isr, edge;
 	unsigned int bit;
 	struct gpio_bank *bank = gpiobank;
 	unsigned long wa_lock_flags;
@@ -753,16 +753,14 @@ static irqreturn_t omap_gpio_irq_handler(int irq, void *gpiobank)
 		enabled = omap_get_gpio_irqbank_mask(bank);
 		isr = readl_relaxed(isr_reg) & enabled;
 
-		if (bank->level_mask)
-			level_mask = bank->level_mask & enabled;
-		else
-			level_mask = 0;
-
-		/* clear edge sensitive interrupts before handler(s) are
-		called so that we don't miss any interrupt occurred while
-		executing them */
-		if (isr & ~level_mask)
-			omap_clear_gpio_irqbank(bank, isr & ~level_mask);
+		/*
+		 * Clear edge sensitive interrupts before calling handler(s)
+		 * so subsequent edge transitions are not missed while the
+		 * handlers are running.
+		 */
+		edge = isr & ~bank->level_mask;
+		if (edge)
+			omap_clear_gpio_irqbank(bank, edge);
 
 		raw_spin_unlock_irqrestore(&bank->lock, lock_flags);
 
-- 
2.17.1
