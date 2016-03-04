From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] gpio: omap: drop dev field from gpio_bank structure
Date: Fri, 4 Mar 2016 17:25:35 +0200
Message-ID: <1457105135-28124-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ssantosh@kernel.org, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

GPIO chip structure already has "parent" field which is used for the
same purpose as "dev" field in gpio_bank structure - store pointer on
GPIO device.

Hence, drop duplicated "dev" field from gpio_bank structure.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/gpio/gpio-omap.c | 57 ++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 189f672..551dfa9 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -66,7 +66,6 @@ struct gpio_bank {
 	u32 irq_usage;
 	u32 dbck_enable_mask;
 	bool dbck_enabled;
-	struct device *dev;
 	bool is_mpuio;
 	bool dbck_flag;
 	bool loses_context;
@@ -627,7 +626,7 @@ static int omap_set_gpio_wakeup(struct gpio_bank *bank, unsigned offset,
 	unsigned long flags;
 
 	if (bank->non_wakeup_gpios & gpio_bit) {
-		dev_err(bank->dev,
+		dev_err(bank->chip.parent,
 			"Unable to modify wakeup on non-wakeup GPIO%d\n",
 			offset);
 		return -EINVAL;
@@ -669,7 +668,7 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 	 * enable the bank module.
 	 */
 	if (!BANK_USED(bank))
-		pm_runtime_get_sync(bank->dev);
+		pm_runtime_get_sync(chip->parent);
 
 	raw_spin_lock_irqsave(&bank->lock, flags);
 	omap_enable_gpio_module(bank, offset);
@@ -698,7 +697,7 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 	 * disable the bank module.
 	 */
 	if (!BANK_USED(bank))
-		pm_runtime_put(bank->dev);
+		pm_runtime_put(chip->parent);
 }
 
 /*
@@ -723,7 +722,7 @@ static irqreturn_t omap_gpio_irq_handler(int irq, void *gpiobank)
 	if (WARN_ON(!isr_reg))
 		goto exit;
 
-	pm_runtime_get_sync(bank->dev);
+	pm_runtime_get_sync(bank->chip.parent);
 
 	while (1) {
 		u32 isr_saved, level_mask = 0;
@@ -776,7 +775,7 @@ static irqreturn_t omap_gpio_irq_handler(int irq, void *gpiobank)
 		}
 	}
 exit:
-	pm_runtime_put(bank->dev);
+	pm_runtime_put(bank->chip.parent);
 	return IRQ_HANDLED;
 }
 
@@ -826,7 +825,7 @@ static void omap_gpio_irq_bus_lock(struct irq_data *data)
 	struct gpio_bank *bank = omap_irq_data_get_bank(data);
 
 	if (!BANK_USED(bank))
-		pm_runtime_get_sync(bank->dev);
+		pm_runtime_get_sync(bank->chip.parent);
 }
 
 static void gpio_irq_bus_sync_unlock(struct irq_data *data)
@@ -838,7 +837,7 @@ static void gpio_irq_bus_sync_unlock(struct irq_data *data)
 	 * disable the bank module.
 	 */
 	if (!BANK_USED(bank))
-		pm_runtime_put(bank->dev);
+		pm_runtime_put(bank->chip.parent);
 }
 
 static void omap_gpio_ack_irq(struct irq_data *d)
@@ -1100,7 +1099,8 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
 
 	ret = gpiochip_add_data(&bank->chip, bank);
 	if (ret) {
-		dev_err(bank->dev, "Could not register gpio chip %d\n", ret);
+		dev_err(bank->chip.parent,
+			"Could not register gpio chip %d\n", ret);
 		return ret;
 	}
 
@@ -1114,7 +1114,7 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
 	 */
 	irq_base = irq_alloc_descs(-1, 0, bank->width, 0);
 	if (irq_base < 0) {
-		dev_err(bank->dev, "Couldn't allocate IRQ numbers\n");
+		dev_err(bank->chip.parent, "Couldn't allocate IRQ numbers\n");
 		return -ENODEV;
 	}
 #endif
@@ -1131,15 +1131,17 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
 				   IRQ_TYPE_NONE);
 
 	if (ret) {
-		dev_err(bank->dev, "Couldn't add irqchip to gpiochip %d\n", ret);
+		dev_err(bank->chip.parent,
+			"Couldn't add irqchip to gpiochip %d\n", ret);
 		gpiochip_remove(&bank->chip);
 		return -ENODEV;
 	}
 
 	gpiochip_set_chained_irqchip(&bank->chip, irqc, bank->irq, NULL);
 
-	ret = devm_request_irq(bank->dev, bank->irq, omap_gpio_irq_handler,
-			       0, dev_name(bank->dev), bank);
+	ret = devm_request_irq(bank->chip.parent, bank->irq,
+			       omap_gpio_irq_handler,
+			       0, dev_name(bank->chip.parent), bank);
 	if (ret)
 		gpiochip_remove(&bank->chip);
 
@@ -1196,7 +1198,6 @@ static int omap_gpio_probe(struct platform_device *pdev)
 		return bank->irq;
 	}
 
-	bank->dev = dev;
 	bank->chip.parent = dev;
 	bank->chip.owner = THIS_MODULE;
 	bank->dbck_flag = pdata->dbck_flag;
@@ -1235,9 +1236,9 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	}
 
 	if (bank->dbck_flag) {
-		bank->dbck = devm_clk_get(bank->dev, "dbclk");
+		bank->dbck = devm_clk_get(dev, "dbclk");
 		if (IS_ERR(bank->dbck)) {
-			dev_err(bank->dev,
+			dev_err(dev,
 				"Could not get gpio dbck. Disable debounce\n");
 			bank->dbck_flag = false;
 		} else {
@@ -1247,9 +1248,9 @@ static int omap_gpio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, bank);
 
-	pm_runtime_enable(bank->dev);
-	pm_runtime_irq_safe(bank->dev);
-	pm_runtime_get_sync(bank->dev);
+	pm_runtime_enable(dev);
+	pm_runtime_irq_safe(dev);
+	pm_runtime_get_sync(dev);
 
 	if (bank->is_mpuio)
 		omap_mpuio_init(bank);
@@ -1258,14 +1259,14 @@ static int omap_gpio_probe(struct platform_device *pdev)
 
 	ret = omap_gpio_chip_init(bank, irqc);
 	if (ret) {
-		pm_runtime_put_sync(bank->dev);
-		pm_runtime_disable(bank->dev);
+		pm_runtime_put_sync(dev);
+		pm_runtime_disable(dev);
 		return ret;
 	}
 
 	omap_gpio_show_rev(bank);
 
-	pm_runtime_put(bank->dev);
+	pm_runtime_put(dev);
 
 	list_add_tail(&bank->node, &omap_gpio_list);
 
@@ -1278,7 +1279,7 @@ static int omap_gpio_remove(struct platform_device *pdev)
 
 	list_del(&bank->node);
 	gpiochip_remove(&bank->chip);
-	pm_runtime_disable(bank->dev);
+	pm_runtime_disable(&pdev->dev);
 	if (bank->dbck_flag)
 		clk_unprepare(bank->dbck);
 
@@ -1348,7 +1349,7 @@ static int omap_gpio_runtime_suspend(struct device *dev)
 update_gpio_context_count:
 	if (bank->get_context_loss_count)
 		bank->context_loss_count =
-				bank->get_context_loss_count(bank->dev);
+				bank->get_context_loss_count(dev);
 
 	omap_gpio_dbck_disable(bank);
 	raw_spin_unlock_irqrestore(&bank->lock, flags);
@@ -1378,7 +1379,7 @@ static int omap_gpio_runtime_resume(struct device *dev)
 
 		if (bank->get_context_loss_count)
 			bank->context_loss_count =
-				bank->get_context_loss_count(bank->dev);
+				bank->get_context_loss_count(dev);
 	}
 
 	omap_gpio_dbck_enable(bank);
@@ -1398,7 +1399,7 @@ static int omap_gpio_runtime_resume(struct device *dev)
 		if (!bank->get_context_loss_count) {
 			omap_gpio_restore_context(bank);
 		} else {
-			c = bank->get_context_loss_count(bank->dev);
+			c = bank->get_context_loss_count(dev);
 			if (c != bank->context_loss_count) {
 				omap_gpio_restore_context(bank);
 			} else {
@@ -1481,7 +1482,7 @@ void omap2_gpio_prepare_for_idle(int pwr_mode)
 
 		bank->power_mode = pwr_mode;
 
-		pm_runtime_put_sync_suspend(bank->dev);
+		pm_runtime_put_sync_suspend(bank->chip.parent);
 	}
 }
 
@@ -1493,7 +1494,7 @@ void omap2_gpio_resume_after_idle(void)
 		if (!BANK_USED(bank) || !bank->loses_context)
 			continue;
 
-		pm_runtime_get_sync(bank->dev);
+		pm_runtime_get_sync(bank->chip.parent);
 	}
 }
 #endif
-- 
2.7.2

