From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] gpio: omap: be more aggressive with pm_runtime
Date: Wed,  8 Feb 2012 15:26:54 +0200
Message-ID: <1328707614-20146-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:48824 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754593Ab2BHN1C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 08:27:02 -0500
Received: by mail-lpp01m020-f173.google.com with SMTP id gf7so322786lbb.32
        for <linux-omap@vger.kernel.org>; Wed, 08 Feb 2012 05:26:59 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, grant.likely@secretlab.ca, linus.walleij@stericsson.com, tarun.kanti@ti.com, Felipe Balbi <balbi@ti.com>

try to keep gpio block suspended as much as possible.

Tested with pandaboard and a sysfs exported gpio.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

I couldn't see any issues with this patch. I managed to export
a gpio and change the direction with a while true loop with
no issues whatsoever.

Any chance someone tells me how to reproduce the original
wakeup problem we had ?

I wrote a simple script to dump gpio states while I had:

while true; do echo in > /sys/class/gpio/gpio2/direction; \
	echo out > /sys/class/gpio/gpio2/direction; done &

running. Here's the ouput:

./show_gpios.sh 
omap_gpio.0
control auto
runtime_status suspended
runtime_active_time 11945
runtime_suspended_time 1214578

omap_gpio.1
control auto
runtime_status suspended
runtime_active_time 78
runtime_suspended_time 1226468

omap_gpio.2
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1226562

omap_gpio.3
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1226578

omap_gpio.4
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1226593

root@legolas:~# ./show_gpios.sh 
omap_gpio.0
control auto
runtime_status suspended
runtime_active_time 12234
runtime_suspended_time 1215257

omap_gpio.1
control auto
runtime_status suspended
runtime_active_time 78
runtime_suspended_time 1227437

omap_gpio.2
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1227531

omap_gpio.3
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1227546

omap_gpio.4
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1227562

root@legolas:~# ./show_gpios.sh 
omap_gpio.0
control auto
runtime_status suspended
runtime_active_time 12460
runtime_suspended_time 1215882

omap_gpio.1
control auto
runtime_status suspended
runtime_active_time 78
runtime_suspended_time 1228289

omap_gpio.2
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1228382

omap_gpio.3
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1228398

omap_gpio.4
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1228414

root@legolas:~# ./show_gpios.sh 
omap_gpio.0
control auto
runtime_status suspended
runtime_active_time 12734
runtime_suspended_time 1216453

omap_gpio.1
control auto
runtime_status suspended
runtime_active_time 78
runtime_suspended_time 1229132

omap_gpio.2
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1229226

omap_gpio.3
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1229242

omap_gpio.4
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1229257

root@legolas:~# ./show_gpios.sh 
omap_gpio.0
control auto
runtime_status active
runtime_active_time 13007
runtime_suspended_time 1216960

omap_gpio.1
control auto
runtime_status suspended
runtime_active_time 78
runtime_suspended_time 1229914

omap_gpio.2
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1230007

omap_gpio.3
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1230023

omap_gpio.4
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1230039

root@legolas:~# ./show_gpios.sh 
omap_gpio.0
control auto
runtime_status suspended
runtime_active_time 13234
runtime_suspended_time 1217492

omap_gpio.1
control auto
runtime_status suspended
runtime_active_time 78
runtime_suspended_time 1230671

omap_gpio.2
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1230765

omap_gpio.3
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1230781

omap_gpio.4
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1230796

root@legolas:~# ./show_gpios.sh 
omap_gpio.0
control auto
runtime_status suspended
runtime_active_time 13453
runtime_suspended_time 1218023

omap_gpio.1
control auto
runtime_status suspended
runtime_active_time 78
runtime_suspended_time 1231421

omap_gpio.2
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1231515

omap_gpio.3
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1231531

omap_gpio.4
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1231546

root@legolas:~# ./show_gpios.sh 
omap_gpio.0
control auto
runtime_status suspended
runtime_active_time 13703
runtime_suspended_time 1218539

omap_gpio.1
control auto
runtime_status suspended
runtime_active_time 78
runtime_suspended_time 1232187

omap_gpio.2
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1232281

omap_gpio.3
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1232296

omap_gpio.4
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1232312

root@legolas:~# ./show_gpios.sh 
omap_gpio.0
control auto
runtime_status active
runtime_active_time 13890
runtime_suspended_time 1219125

omap_gpio.1
control auto
runtime_status suspended
runtime_active_time 78
runtime_suspended_time 1232960

omap_gpio.2
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1233054

omap_gpio.3
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1233070

omap_gpio.4
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1233085

root@legolas:~# ./show_gpios.sh 
omap_gpio.0
control auto
runtime_status suspended
runtime_active_time 14109
runtime_suspended_time 1219601

omap_gpio.1
control auto
runtime_status suspended
runtime_active_time 78
runtime_suspended_time 1233656

omap_gpio.2
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1233750

omap_gpio.3
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1233765

omap_gpio.4
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1233781

root@legolas:~# ./show_gpios.sh 
omap_gpio.0
control auto
runtime_status suspended
runtime_active_time 14367
runtime_suspended_time 1220109

omap_gpio.1
control auto
runtime_status suspended
runtime_active_time 78
runtime_suspended_time 1234421

omap_gpio.2
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1234515

omap_gpio.3
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1234531

omap_gpio.4
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1234546

root@legolas:~# ./show_gpios.sh 
omap_gpio.0
control auto
runtime_status suspended
runtime_active_time 14531
runtime_suspended_time 1220648

omap_gpio.1
control auto
runtime_status suspended
runtime_active_time 78
runtime_suspended_time 1235125

omap_gpio.2
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1235218

omap_gpio.3
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1235234

omap_gpio.4
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 1235250

see that the active time changes for omap_gpio.0 (first gpio bank)
because I'm constantly changing direction of the exported gpio2, but
the other banks are kept in suspend state. I even managed to catch
the gpio bank while it was still in active state. Before suspending
again.

 drivers/gpio/gpio-omap.c |   61 +++++++++++++++++++++++++++++++++-------------
 1 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 4273401..2dd9ced 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -537,12 +537,7 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 	struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
 	unsigned long flags;
 
-	/*
-	 * If this is the first gpio_request for the bank,
-	 * enable the bank module.
-	 */
-	if (!bank->mod_usage)
-		pm_runtime_get_sync(bank->dev);
+	pm_runtime_get_sync(bank->dev);
 
 	spin_lock_irqsave(&bank->lock, flags);
 	/* Set trigger to none. You need to enable the desired trigger with
@@ -572,6 +567,8 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 
 	spin_unlock_irqrestore(&bank->lock, flags);
 
+	pm_runtime_put(bank->dev);
+
 	return 0;
 }
 
@@ -581,6 +578,8 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 	void __iomem *base = bank->base;
 	unsigned long flags;
 
+	pm_runtime_get_sync(bank->dev);
+
 	spin_lock_irqsave(&bank->lock, flags);
 
 	if (bank->regs->wkup_en) {
@@ -606,12 +605,7 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 	_reset_gpio(bank, bank->chip.base + offset);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
-	/*
-	 * If this is the last gpio to be freed in the bank,
-	 * disable the bank module.
-	 */
-	if (!bank->mod_usage)
-		pm_runtime_put(bank->dev);
+	pm_runtime_put(bank->dev);
 }
 
 /*
@@ -707,9 +701,11 @@ static void gpio_irq_shutdown(struct irq_data *d)
 	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
 	unsigned long flags;
 
+	pm_runtime_get_sync(bank->dev);
 	spin_lock_irqsave(&bank->lock, flags);
 	_reset_gpio(bank, gpio);
 	spin_unlock_irqrestore(&bank->lock, flags);
+	pm_runtime_put(bank->dev);
 }
 
 static void gpio_ack_irq(struct irq_data *d)
@@ -717,7 +713,9 @@ static void gpio_ack_irq(struct irq_data *d)
 	unsigned int gpio = d->irq - IH_GPIO_BASE;
 	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
 
+	pm_runtime_get_sync(bank->dev);
 	_clear_gpio_irqstatus(bank, gpio);
+	pm_runtime_put(bank->dev);
 }
 
 static void gpio_mask_irq(struct irq_data *d)
@@ -726,10 +724,12 @@ static void gpio_mask_irq(struct irq_data *d)
 	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
 	unsigned long flags;
 
+	pm_runtime_get_sync(bank->dev);
 	spin_lock_irqsave(&bank->lock, flags);
 	_set_gpio_irqenable(bank, gpio, 0);
 	_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), IRQ_TYPE_NONE);
 	spin_unlock_irqrestore(&bank->lock, flags);
+	pm_runtime_put(bank->dev);
 }
 
 static void gpio_unmask_irq(struct irq_data *d)
@@ -740,6 +740,7 @@ static void gpio_unmask_irq(struct irq_data *d)
 	u32 trigger = irqd_get_trigger_type(d);
 	unsigned long flags;
 
+	pm_runtime_get_sync(bank->dev);
 	spin_lock_irqsave(&bank->lock, flags);
 	if (trigger)
 		_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), trigger);
@@ -753,6 +754,7 @@ static void gpio_unmask_irq(struct irq_data *d)
 
 	_set_gpio_irqenable(bank, gpio, 1);
 	spin_unlock_irqrestore(&bank->lock, flags);
+	pm_runtime_put(bank->dev);
 }
 
 static struct irq_chip gpio_irq_chip = {
@@ -836,17 +838,26 @@ static int gpio_input(struct gpio_chip *chip, unsigned offset)
 	unsigned long flags;
 
 	bank = container_of(chip, struct gpio_bank, chip);
+	pm_runtime_get_sync(bank->dev);
+
 	spin_lock_irqsave(&bank->lock, flags);
 	_set_gpio_direction(bank, offset, 1);
 	spin_unlock_irqrestore(&bank->lock, flags);
+	pm_runtime_put(bank->dev);
+
 	return 0;
 }
 
 static int gpio_is_input(struct gpio_bank *bank, int mask)
 {
 	void __iomem *reg = bank->base + bank->regs->direction;
+	u32 val;
 
-	return __raw_readl(reg) & mask;
+	pm_runtime_get_sync(bank->dev);
+	val = __raw_readl(reg) & mask;
+	pm_runtime_put(bank->dev);
+
+	return val;
 }
 
 static int gpio_get(struct gpio_chip *chip, unsigned offset)
@@ -856,15 +867,20 @@ static int gpio_get(struct gpio_chip *chip, unsigned offset)
 	int gpio;
 	u32 mask;
 
+	int val;
 	gpio = chip->base + offset;
 	bank = container_of(chip, struct gpio_bank, chip);
 	reg = bank->base;
 	mask = GPIO_BIT(bank, gpio);
 
+	pm_runtime_get_sync(bank->dev);
 	if (gpio_is_input(bank, mask))
-		return _get_gpio_datain(bank, gpio);
+		val = _get_gpio_datain(bank, gpio);
 	else
-		return _get_gpio_dataout(bank, gpio);
+		val = _get_gpio_dataout(bank, gpio);
+	pm_runtime_put(bank->dev);
+
+	return val;
 }
 
 static int gpio_output(struct gpio_chip *chip, unsigned offset, int value)
@@ -873,10 +889,14 @@ static int gpio_output(struct gpio_chip *chip, unsigned offset, int value)
 	unsigned long flags;
 
 	bank = container_of(chip, struct gpio_bank, chip);
+
+	pm_runtime_get_sync(bank->dev);
 	spin_lock_irqsave(&bank->lock, flags);
 	bank->set_dataout(bank, offset, value);
 	_set_gpio_direction(bank, offset, 0);
 	spin_unlock_irqrestore(&bank->lock, flags);
+	pm_runtime_put(bank->dev);
+
 	return 0;
 }
 
@@ -894,9 +914,11 @@ static int gpio_debounce(struct gpio_chip *chip, unsigned offset,
 			dev_err(bank->dev, "Could not get gpio dbck\n");
 	}
 
+	pm_runtime_get_sync(bank->dev);
 	spin_lock_irqsave(&bank->lock, flags);
 	_set_gpio_debounce(bank, offset, debounce);
 	spin_unlock_irqrestore(&bank->lock, flags);
+	pm_runtime_put(bank->dev);
 
 	return 0;
 }
@@ -907,9 +929,12 @@ static void gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	unsigned long flags;
 
 	bank = container_of(chip, struct gpio_bank, chip);
+
+	pm_runtime_get_sync(bank->dev);
 	spin_lock_irqsave(&bank->lock, flags);
 	bank->set_dataout(bank, offset, value);
 	spin_unlock_irqrestore(&bank->lock, flags);
+	pm_runtime_put(bank->dev);
 }
 
 static int gpio_2irq(struct gpio_chip *chip, unsigned offset)
@@ -1330,7 +1355,8 @@ void omap2_gpio_prepare_for_idle(int pwr_mode)
 
 		bank->power_mode = pwr_mode;
 
-		pm_runtime_put_sync_suspend(bank->dev);
+		if (!pm_runtime_suspended(bank->dev))
+			pm_runtime_suspend(bank->dev);
 	}
 }
 
@@ -1342,7 +1368,8 @@ void omap2_gpio_resume_after_idle(void)
 		if (!bank->mod_usage || !bank->loses_context)
 			continue;
 
-		pm_runtime_get_sync(bank->dev);
+		if (pm_runtime_suspended(bank->dev))
+			pm_runtime_resume(bank->dev);
 	}
 }
 
-- 
1.7.9

