From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH] Input: gpio-keys: Support for one-directional interrupts
Date: Sat,  5 Dec 2009 14:38:14 -0800
Message-ID: <1260052694-17223-1-git-send-email-darkstar6262@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:36619 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755929AbZLEWiU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Dec 2009 17:38:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-input@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Cory Maccarrone <darkstar6262@gmail.com>

The current gpio-keys driver assumes that each given GPIO has
the ability to respond to both rising and falling interrupts
at the same time.  For some GPIOs on certain devices, the interrupt
is only one-directional -- either rising or falling, depending on
what's being listened for.  In particular, the HTC Herald keyboard
slide switch interrupt must be switched from rising to falling and
back on each event, otherwise only one transition will be detected.

This change adds a new entry to the gpio_keys_button structure to
allow for this condition to be specified in board configurations.
When set, the driver detects the current state of the GPIO and sets
the direction of the interrupt accordingly.  Then, on each event,
the interrupt direction is switched.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
---
 drivers/input/keyboard/gpio_keys.c |   27 +++++++++++++++++++++++----
 include/linux/gpio_keys.h          |    1 +
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 77d1309..05c599a 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -45,7 +45,18 @@ static void gpio_keys_report_event(struct work_struct *work)
 	struct gpio_keys_button *button = bdata->button;
 	struct input_dev *input = bdata->input;
 	unsigned int type = button->type ?: EV_KEY;
-	int state = (gpio_get_value(button->gpio) ? 1 : 0) ^ button->active_low;
+	int state = gpio_get_value(button->gpio) ? 1 : 0;
+
+	/* If the hardware can't do both edges, set the appropriate
+	 * interrupt control */
+	if (button->not_both_edges) {
+		if (state)
+			set_irq_type(gpio_to_irq(button->gpio), IRQ_TYPE_EDGE_FALLING);
+		else
+			set_irq_type(gpio_to_irq(button->gpio), IRQ_TYPE_EDGE_RISING);
+	}
+
+	state ^= button->active_low;
 
 	input_event(input, type, button->code, !!state);
 	input_sync(input);
@@ -79,7 +90,7 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
 	struct gpio_keys_drvdata *ddata;
 	struct input_dev *input;
-	int i, error;
+	int i, error, trigger;
 	int wakeup = 0;
 
 	ddata = kzalloc(sizeof(struct gpio_keys_drvdata) +
@@ -146,9 +157,17 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 			goto fail2;
 		}
 
+		if (button->not_both_edges) {
+			if (gpio_get_value(button->gpio))
+				trigger = IRQF_TRIGGER_FALLING;
+			else
+				trigger = IRQF_TRIGGER_RISING;
+		} else {
+			trigger = IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING;
+		}
+
 		error = request_irq(irq, gpio_keys_isr,
-				    IRQF_SHARED |
-				    IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				    IRQF_SHARED | trigger,
 				    button->desc ? button->desc : "gpio_keys",
 				    bdata);
 		if (error) {
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index 1289fa7..493426d 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -10,6 +10,7 @@ struct gpio_keys_button {
 	int type;		/* input event type (EV_KEY, EV_SW) */
 	int wakeup;		/* configure the button as a wake-up source */
 	int debounce_interval;	/* debounce ticks interval in msecs */
+	int not_both_edges;	/* some hardware can't do interrupts on both edges */
 };
 
 struct gpio_keys_platform_data {
-- 
1.6.3.3

