From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] gpio: omap: get rid of the conditional PM runtime calls
Date: Fri, 28 Sep 2018 16:39:50 -0500
Message-ID: <20180928213950.27415-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

OMAP GPIO driver is checking !BANK_USED() used condition before calling PM
runtime API, because of PM runtime calls in
omap2_gpio_prepare/resume_for_idle(). It's not required any more since
"omap gpio add level idle, cpu_pm and drop runtime_irq_safe" series [1]
from Tony Lindgren was accepted and PM runtime management was enabled in
IRQ chip core by commit be45beb2df69 ("genirq: Add runtime power management
support for IRQ chips") .

As result safely drop !BANK_USED() checks from omap_gpio_request/free(),
omap_gpio_irq_bus_lock/unlock() and enable PM runtime management for OMAP
GPIO IRQ chip.

[1] https://www.spinics.net/lists/arm-kernel/msg677583.html
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/gpio/gpio-omap.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 287c933..c081f39 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -702,12 +702,7 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 	struct gpio_bank *bank = gpiochip_get_data(chip);
 	unsigned long flags;
 
-	/*
-	 * If this is the first gpio_request for the bank,
-	 * enable the bank module.
-	 */
-	if (!BANK_USED(bank))
-		pm_runtime_get_sync(chip->parent);
+	pm_runtime_get_sync(chip->parent);
 
 	raw_spin_lock_irqsave(&bank->lock, flags);
 	omap_enable_gpio_module(bank, offset);
@@ -731,12 +726,7 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 	omap_disable_gpio_module(bank, offset);
 	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
-	/*
-	 * If this is the last gpio to be freed in the bank,
-	 * disable the bank module.
-	 */
-	if (!BANK_USED(bank))
-		pm_runtime_put(chip->parent);
+	pm_runtime_put(chip->parent);
 }
 
 /*
@@ -862,20 +852,14 @@ static void omap_gpio_irq_bus_lock(struct irq_data *data)
 {
 	struct gpio_bank *bank = omap_irq_data_get_bank(data);
 
-	if (!BANK_USED(bank))
-		pm_runtime_get_sync(bank->chip.parent);
+	pm_runtime_get_sync(bank->chip.parent);
 }
 
 static void gpio_irq_bus_sync_unlock(struct irq_data *data)
 {
 	struct gpio_bank *bank = omap_irq_data_get_bank(data);
 
-	/*
-	 * If this is the last IRQ to be freed in the bank,
-	 * disable the bank module.
-	 */
-	if (!BANK_USED(bank))
-		pm_runtime_put(bank->chip.parent);
+	pm_runtime_put(bank->chip.parent);
 }
 
 static void omap_gpio_ack_irq(struct irq_data *d)
@@ -1385,6 +1369,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	irqc->irq_bus_sync_unlock = gpio_irq_bus_sync_unlock,
 	irqc->name = dev_name(&pdev->dev);
 	irqc->flags = IRQCHIP_MASK_ON_SUSPEND;
+	irqc->parent_device = dev;
 
 	bank->irq = platform_get_irq(pdev, 0);
 	if (bank->irq <= 0) {
-- 
2.10.5
