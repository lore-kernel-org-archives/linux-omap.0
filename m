From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 4/5] gpio/omap: force restore if context loss is not detectable
Date: Thu, 4 Apr 2013 15:16:15 -0500
Message-ID: <1365106576-31816-5-git-send-email-jon-hunter@ti.com>
References: <1365106576-31816-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60940 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764438Ab3DDUQh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Apr 2013 16:16:37 -0400
In-Reply-To: <1365106576-31816-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

When booting with device-tree the function pointer for detecting context
loss is not populated. Ideally, the pm_runtime framework should be
enhanced to allow a means for reporting context/state loss and we could
avoid populating such function pointers altogether. In the interim until
a generic non-device specific solution is in place, force a restore of
the gpio bank when enabling the gpio controller.

Adds a new device-tree property for the OMAP GPIO controller to indicate
if the GPIO controller is located in a power-domain that never loses
power and hence will always maintain its logic state.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 .../devicetree/bindings/gpio/gpio-omap.txt         |    7 ++++--
 drivers/gpio/gpio-omap.c                           |   25 +++++++++++++-------
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-omap.txt b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
index a56e3a5..8d95052 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-omap.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
@@ -20,8 +20,11 @@ Required properties:
       8 = active low level-sensitive.
 
 OMAP specific properties:
-- ti,hwmods: Name of the hwmod associated to the GPIO:
-  "gpio<X>", <X> being the 1-based instance number from the HW spec
+- ti,hwmods:		Name of the hwmod associated to the GPIO:
+			"gpio<X>", <X> being the 1-based instance number
+			from the HW spec.
+- ti,gpio-always-on: 	Indicates if a GPIO bank is always powered and
+			so will never lose its logic state.
 
 
 Example:
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 685e850..0557529 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1120,11 +1120,17 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	bank->width = pdata->bank_width;
 	bank->is_mpuio = pdata->is_mpuio;
 	bank->non_wakeup_gpios = pdata->non_wakeup_gpios;
-	bank->loses_context = pdata->loses_context;
 	bank->regs = pdata->regs;
 #ifdef CONFIG_OF_GPIO
 	bank->chip.of_node = of_node_get(node);
 #endif
+	if (node) {
+		if (!of_property_read_bool(node, "ti,gpio-always-on"))
+			bank->loses_context = true;
+	} else {
+		bank->loses_context = pdata->loses_context;
+	}
+
 
 	bank->domain = irq_domain_add_linear(node, bank->width,
 					     &irq_domain_simple_ops, NULL);
@@ -1258,9 +1264,9 @@ static int omap_gpio_runtime_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct gpio_bank *bank = platform_get_drvdata(pdev);
-	int context_lost_cnt_after;
 	u32 l = 0, gen, gen0, gen1;
 	unsigned long flags;
+	int c;
 
 	spin_lock_irqsave(&bank->lock, flags);
 	_gpio_dbck_enable(bank);
@@ -1276,14 +1282,17 @@ static int omap_gpio_runtime_resume(struct device *dev)
 	__raw_writel(bank->context.risingdetect,
 		     bank->base + bank->regs->risingdetect);
 
-	if (bank->get_context_loss_count) {
-		context_lost_cnt_after =
-			bank->get_context_loss_count(bank->dev);
-		if (context_lost_cnt_after != bank->context_loss_count) {
+	if (bank->loses_context) {
+		if (!bank->get_context_loss_count) {
 			omap_gpio_restore_context(bank);
 		} else {
-			spin_unlock_irqrestore(&bank->lock, flags);
-			return 0;
+			c = bank->get_context_loss_count(bank->dev);
+			if (c != bank->context_loss_count) {
+				omap_gpio_restore_context(bank);
+			} else {
+				spin_unlock_irqrestore(&bank->lock, flags);
+				return 0;
+			}
 		}
 	}
 
-- 
1.7.10.4

