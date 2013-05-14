From: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Subject: [PATCH v3 3/3] gpio/omap: split irq_mask callback fucntion into irq_disable/irq_mask.
Date: Tue, 14 May 2013 22:54:27 +0200
Message-ID: <1368564867-11142-3-git-send-email-andreas.fenkart@streamunlimited.com>
References: <1368564867-11142-1-git-send-email-andreas.fenkart@streamunlimited.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:50685 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757791Ab3ENUyr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 May 2013 16:54:47 -0400
Received: from mailout-de.gmx.net ([10.1.76.28]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0MOEEk-1UZ4S20uLU-005aCX for
 <linux-omap@vger.kernel.org>; Tue, 14 May 2013 22:54:46 +0200
In-Reply-To: <1368564867-11142-1-git-send-email-andreas.fenkart@streamunlimited.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh.shilimkar@ti.com
Cc: khilman@deeprootsystems.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, balbi@ti.com, linux-omap@vger.kernel.org, daniel@zonque.org, jon-hunter@ti.com, Andreas Fenkart <andreas.fenkart@streamunlimited.com>

Disabling an IRQ is turning off interrupt generating mechanisms in the
hardware. Masking means, the interrupt doesn't get delivered to the OS,
but the interrupt status register is still getting updated. The
difference is apparent when unmasking or re-enabling the interrupt. In
case of masking you might get an interrupt straight away, but never if
the interrupt was disabled.

This is the definition Jon Hunter formulated as a question in a earlier
thread of this patchset, the exact formulation is from ppwaskie on
#kernelnewbies. It sounds reasonable to me so I will stick to it from now
on. Neither Documentation/, source code, LDD or Google search gave a me
better definition.

The omap has separate trigger and interrupt enable registers, so it can
express the the subtle difference between masking and disabling an
interrupt. But the current implementation does not make use of it.
The public disable_irq function, uses the genirq 'lazy disable'
functionality as fallback when irq_disable is not implemented. In short
lazy disable marks the interrupt as disabled, but leaves the hardware
unmasked. If an interrupt happens, the interrupt flow handler masks the
line at the hardware level and marks the interrupt as pending.

void irq_disable(struct irq_desc *desc)
{
        irq_state_set_disabled(desc);
        if (desc->irq_data.chip->irq_disable) {
                desc->irq_data.chip->irq_disable(&desc->irq_data);
                irq_state_set_masked(desc);
        }
}

This is a contradiction with above definition of disable, since in
disabled state the interrupt should not be marked pending. So the
behavior -- at least on ARM, see HARDIRQS_SW_RESEND -- is more
similar to masking than disable.
The advantage of lazy interrupt is, that it allows to latch a pending
interrupt on a hardware that has no separate registers for signalling and
triggering. Depending on the use case, it might also be an optimization,
since it avoids a hardware access, for the common case where no interrupt
happens between marking it disabled and reenabling it again.

Getting to the point, this patch implements a feature, supported
by the HW and foreseen by the struct irq_chip. But unfortunately
no real benefit seems to emerge from that.

The basic advantage of this patch is a) while being masked, a pending
interrupt could now be latched in HW and not SW. b) with the current
implementation, there is no latching of pending interrupts while masked,
because currently triggering is disabled when masked.

Unfortunately no no code path makes use of this;
1) while there is global disable_irq, there is not global mask_irq.
2) being a chained irq, the irq of the gpio bank is masked while the
chain handler is running, hence masking individual edge type interrupts
is unnecessary, because the aggregated bank irq is already masked
3) level type interrupts are cleared after the handler has run,
since there is no earlier time it can be cleared/re-enabled.

Major drawback of the patch:
- no more pending when enable_irq, which is in contradiction with
  above definition anyway, but maybe some drivers have relied on
  that behavior
- wake-up path might be affected which depends on the interplay of
  several register, so we might introduce a nasty regression here

The only other irq chip driver having distinctive functions for
enable/disable and mask/unmask is drivers/gpio/gpio-ml-ioh.c

Implementation itself is straightfoward: mask/unmaks modifies
only the interrupt enable register, so it keeps latching new
interrupts into the status register. Enable/disable goes one step
further, also disabling latching of new interrupts.

Testing was done on AM335x, by using gpio-keys. While IRQ was
masked/disabled key was pressed. So upon unmask there had to be
an IRQ, while for enable no IRQ must be generated.
Masking/enabling the first gpio was controlled using a second
gpio-key. Selecting masking or disable the IRQ used was hardcoded
at compile time.

Wakeup functionality is completely untested, since the AM335x
lacks a IRQWAKEN register.

Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
---
 drivers/gpio/gpio-omap.c |   71 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 62 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 44a93be..83e77a1 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -732,6 +732,13 @@ static void gpio_ack_irq(struct irq_data *d)
 	_clear_gpio_irqstatus(bank, gpio);
 }
 
+/**
+ * gpio_mask_irq - mask IRQ signaling
+ * @d : the gpio data we're acting upon
+ *
+ * Only signaling is masked. IRQs are still latched to status
+ * register.
+ */
 static void gpio_mask_irq(struct irq_data *d)
 {
 	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
@@ -740,33 +747,77 @@ static void gpio_mask_irq(struct irq_data *d)
 
 	spin_lock_irqsave(&bank->lock, flags);
 	_set_gpio_irqenable(bank, gpio, 0);
-	_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), IRQ_TYPE_NONE);
 	spin_unlock_irqrestore(&bank->lock, flags);
 }
 
+/**
+ * gpio_unmask_irq - unmask IRQ signaling
+ * @d : the gpio data we're acting upon
+ *
+ * If an IRQ occured while masked, there will be an IRQ straight
+ * away.
+ */
 static void gpio_unmask_irq(struct irq_data *d)
 {
 	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
 	unsigned int gpio = irq_to_gpio(bank, d->irq);
 	unsigned int irq_mask = GPIO_BIT(bank, gpio);
-	u32 trigger = irqd_get_trigger_type(d);
 	unsigned long flags;
 
 	spin_lock_irqsave(&bank->lock, flags);
-	if (trigger)
-		_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), trigger);
 
-	/* For level-triggered GPIOs, the clearing must be done after
-	 * the HW source is cleared, thus after the handler has run */
-	if (bank->level_mask & irq_mask) {
-		_set_gpio_irqenable(bank, gpio, 0);
+	/*
+	 * For level-triggered GPIOs, the clearing must be done after
+	 * the HW source is cleared, thus after the handler has run
+	 */
+	if (bank->level_mask & irq_mask)
 		_clear_gpio_irqstatus(bank, gpio);
-	}
 
 	_set_gpio_irqenable(bank, gpio, 1);
 	spin_unlock_irqrestore(&bank->lock, flags);
 }
 
+/**
+ * gpio_disable_irq - disable the interrupt
+ * @d : the gpio data we're acting upon
+ *
+ * While disabled all IRQ events are ignored. IRQs are not latched
+ * into status register.
+ */
+static void gpio_disable_irq(struct irq_data *d)
+{
+	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
+	unsigned int gpio = irq_to_gpio(bank, d->irq);
+	unsigned long flags;
+
+	spin_lock_irqsave(&bank->lock, flags);
+	_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), IRQ_TYPE_NONE);
+	_set_gpio_irqenable(bank, gpio, 0);
+	spin_unlock_irqrestore(&bank->lock, flags);
+}
+
+/**
+ * gpio_enable_irq - enable the interrupt
+ * @d : the gpio data we're acting upon
+ *
+ * Enables latching and signaling of new IRQ. Pending IRQs
+ * are cleared.
+ */
+static void gpio_enable_irq(struct irq_data *d)
+{
+	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
+	unsigned int gpio = irq_to_gpio(bank, d->irq);
+	u32 trigger = irqd_get_trigger_type(d);
+	unsigned long flags;
+
+	spin_lock_irqsave(&bank->lock, flags);
+	if (trigger)
+		_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), trigger);
+	_clear_gpio_irqstatus(bank, gpio);
+	_set_gpio_irqenable(bank, gpio, 1);
+	spin_unlock_irqrestore(&bank->lock, flags);
+}
+
 static struct irq_chip gpio_irq_chip = {
 	.name		= "GPIO",
 	.irq_shutdown	= gpio_irq_shutdown,
@@ -775,6 +826,8 @@ static struct irq_chip gpio_irq_chip = {
 	.irq_unmask	= gpio_unmask_irq,
 	.irq_set_type	= gpio_irq_type,
 	.irq_set_wake	= gpio_wake_enable,
+	.irq_disable    = gpio_disable_irq,
+	.irq_enable     = gpio_enable_irq,
 };
 
 /*---------------------------------------------------------------------*/
-- 
1.7.10.4

