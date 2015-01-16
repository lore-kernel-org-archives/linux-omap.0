From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/1] gpio: omap: Fix bad device access with setup_irq()
Date: Fri, 16 Jan 2015 14:50:50 -0800
Message-ID: <1421448650-15904-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:31989 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbbAPWyr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2015 17:54:47 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>, Kevin Hilman <khilman@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>

Similar to omap_gpio_irq_type() let's make sure that the GPIO
is usable as an interrupt if the platform init code did not
call gpio_request(). Otherwise we can get invalid device access
after setup_irq():

WARNING: CPU: 0 PID: 1 at drivers/bus/omap_l3_noc.c:147 l3_interrupt_handler+0x214/0x340()
44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4CFG (Idle): Data Access in Supervisor mode during Functional access
...
[<c05f21e4>] (__irq_svc) from [<c05f1974>] (_raw_spin_unlock_irqrestore+0x34/0x44)
[<c05f1974>] (_raw_spin_unlock_irqrestore) from [<c00914a8>] (__setup_irq+0x244/0x530)
[<c00914a8>] (__setup_irq) from [<c00917d4>] (setup_irq+0x40/0x8c)
[<c00917d4>] (setup_irq) from [<c0039c8c>] (omap_system_dma_probe+0x1d4/0x2b4)
[<c0039c8c>] (omap_system_dma_probe) from [<c03b2200>] (platform_drv_probe+0x44/0xa4)
...

We can fix this the same way omap_gpio_irq_type() is handling it.

Note that the long term solution is to change the gpio-omap driver
to handle the banks as separate driver instances. This will allow
us to rely on just runtime PM for tracking the bank specific state.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/gpio/gpio-omap.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 30646cf..f476ae2 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -88,6 +88,8 @@ struct gpio_bank {
 #define BANK_USED(bank) (bank->mod_usage || bank->irq_usage)
 #define LINE_USED(line, offset) (line & (BIT(offset)))
 
+static void omap_gpio_unmask_irq(struct irq_data *d);
+
 static int omap_irq_to_gpio(struct gpio_bank *bank, unsigned int gpio_irq)
 {
 	return bank->chip.base + gpio_irq;
@@ -477,6 +479,16 @@ static int omap_gpio_is_input(struct gpio_bank *bank, int mask)
 	return readl_relaxed(reg) & mask;
 }
 
+static void omap_gpio_init_irq(struct gpio_bank *bank, unsigned gpio,
+			       unsigned offset)
+{
+	if (!LINE_USED(bank->mod_usage, offset)) {
+		omap_enable_gpio_module(bank, offset);
+		omap_set_gpio_direction(bank, offset, 1);
+	}
+	bank->irq_usage |= BIT(GPIO_INDEX(bank, gpio));
+}
+
 static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
 {
 	struct gpio_bank *bank = omap_irq_data_get_bank(d);
@@ -506,15 +518,11 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
 	spin_lock_irqsave(&bank->lock, flags);
 	offset = GPIO_INDEX(bank, gpio);
 	retval = omap_set_gpio_triggering(bank, offset, type);
-	if (!LINE_USED(bank->mod_usage, offset)) {
-		omap_enable_gpio_module(bank, offset);
-		omap_set_gpio_direction(bank, offset, 1);
-	} else if (!omap_gpio_is_input(bank, BIT(offset))) {
+	omap_gpio_init_irq(bank, gpio, offset);
+	if (!omap_gpio_is_input(bank, BIT(offset))) {
 		spin_unlock_irqrestore(&bank->lock, flags);
 		return -EINVAL;
 	}
-
-	bank->irq_usage |= BIT(GPIO_INDEX(bank, gpio));
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
@@ -792,6 +800,24 @@ exit:
 	pm_runtime_put(bank->dev);
 }
 
+static unsigned int omap_gpio_irq_startup(struct irq_data *d)
+{
+	struct gpio_bank *bank = omap_irq_data_get_bank(d);
+	unsigned int gpio = omap_irq_to_gpio(bank, d->hwirq);
+	unsigned long flags;
+	unsigned offset = GPIO_INDEX(bank, gpio);
+
+	if (!BANK_USED(bank))
+		pm_runtime_get_sync(bank->dev);
+
+	spin_lock_irqsave(&bank->lock, flags);
+	omap_gpio_init_irq(bank, gpio, offset);
+	spin_unlock_irqrestore(&bank->lock, flags);
+	omap_gpio_unmask_irq(d);
+
+	return 0;
+}
+
 static void omap_gpio_irq_shutdown(struct irq_data *d)
 {
 	struct gpio_bank *bank = omap_irq_data_get_bank(d);
@@ -1181,6 +1207,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	if (!irqc)
 		return -ENOMEM;
 
+	irqc->irq_startup = omap_gpio_irq_startup,
 	irqc->irq_shutdown = omap_gpio_irq_shutdown,
 	irqc->irq_ack = omap_gpio_ack_irq,
 	irqc->irq_mask = omap_gpio_mask_irq,
-- 
2.1.4

