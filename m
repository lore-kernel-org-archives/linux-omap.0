From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] gpio: omap: switch to use irq_chip pm runtime
Date: Tue, 25 Sep 2018 14:14:46 -0500
Message-ID: <20180925191446.31504-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

The PM runtime management can be delegated from OMAP GPIO driver to the IRQ
chip core, since commit be45beb2df69 ("genirq: Add runtime power management
support for IRQ chips") introduces runtime power management support for IRQ
chips.

Hence, drop custom PM runtime support for OMAP GPIO IRQs and switch to IRQ
chip core PM runtime (set irq_chip->parent_device).

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
Based on:
 "[PATCHv2 0/3] omap gpio add level idle, cpu_pm and drop runtime_irq_safe"
 https://www.spinics.net/lists/arm-kernel/msg677583.html

 drivers/gpio/gpio-omap.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index c0d7ae7..f292796 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -860,26 +860,6 @@ static void omap_gpio_irq_shutdown(struct irq_data *d)
 	raw_spin_unlock_irqrestore(&bank->lock, flags);
 }
 
-static void omap_gpio_irq_bus_lock(struct irq_data *data)
-{
-	struct gpio_bank *bank = omap_irq_data_get_bank(data);
-
-	if (!BANK_USED(bank))
-		pm_runtime_get_sync(bank->chip.parent);
-}
-
-static void gpio_irq_bus_sync_unlock(struct irq_data *data)
-{
-	struct gpio_bank *bank = omap_irq_data_get_bank(data);
-
-	/*
-	 * If this is the last IRQ to be freed in the bank,
-	 * disable the bank module.
-	 */
-	if (!BANK_USED(bank))
-		pm_runtime_put(bank->chip.parent);
-}
-
 static void omap_gpio_ack_irq(struct irq_data *d)
 {
 	struct gpio_bank *bank = omap_irq_data_get_bank(d);
@@ -1383,10 +1363,9 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	irqc->irq_unmask = omap_gpio_unmask_irq,
 	irqc->irq_set_type = omap_gpio_irq_type,
 	irqc->irq_set_wake = omap_gpio_wake_enable,
-	irqc->irq_bus_lock = omap_gpio_irq_bus_lock,
-	irqc->irq_bus_sync_unlock = gpio_irq_bus_sync_unlock,
 	irqc->name = dev_name(&pdev->dev);
 	irqc->flags = IRQCHIP_MASK_ON_SUSPEND;
+	irqc->parent_device = dev;
 
 	bank->irq = platform_get_irq(pdev, 0);
 	if (bank->irq <= 0) {
-- 
2.10.5
