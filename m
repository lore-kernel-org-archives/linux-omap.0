From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 18/23] twl4030-gpio irq_chip.set_type
Date: Tue, 30 Sep 2008 13:05:55 +0300
Message-ID: <1222769160-31615-19-git-send-email-felipe.balbi@nokia.com>
References: <1222769160-31615-1-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-2-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-3-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-4-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-5-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-6-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-7-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-8-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-9-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-10-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-11-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-12-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-13-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-14-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-15-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-16-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-17-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-18-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:34989 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395AbYI3KGy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 06:06:54 -0400
In-Reply-To: <1222769160-31615-18-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <felipe.balbi@nokia.com>

From: David Brownell <dbrownell@users.sourceforge.net>

Make twl4030 GPIO support set_type() request.
Plus a bit of cleanup for the simple functions.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/gpio/twl4030-gpio.c |   84 +++++++++++++++++++++++++++++++++++++-----
 1 files changed, 74 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/twl4030-gpio.c b/drivers/gpio/twl4030-gpio.c
index b65d476..e709fbb 100644
--- a/drivers/gpio/twl4030-gpio.c
+++ b/drivers/gpio/twl4030-gpio.c
@@ -153,6 +153,9 @@ static unsigned int gpio_imr_shadow;
 /* bitmask of pending requests to unmask gpio interrupts */
 static unsigned int gpio_pending_unmask;
 
+/* bitmask of requests to set gpio irq trigger type */
+static unsigned int gpio_pending_trigger;
+
 /* pointer to gpio unmask thread struct */
 static struct task_struct *gpio_unmask_thread;
 
@@ -241,10 +244,15 @@ static void twl4030_gpio_unmask(unsigned int irq)
  * controller to a kernel thread.  We only need to support the unmask method.
  */
 
-static void twl4030_gpio_mask_and_ack_irqchip(unsigned int irq) {}
-static void twl4030_gpio_mask_irqchip(unsigned int irq) {}
+static void twl4030_gpio_irq_mask_and_ack(unsigned int irq)
+{
+}
+
+static void twl4030_gpio_irq_mask(unsigned int irq)
+{
+}
 
-static void twl4030_gpio_unmask_irqchip(unsigned int irq)
+static void twl4030_gpio_irq_unmask(unsigned int irq)
 {
 	int gpio = irq - twl4030_gpio_irq_base;
 
@@ -253,11 +261,36 @@ static void twl4030_gpio_unmask_irqchip(unsigned int irq)
 		wake_up_process(gpio_unmask_thread);
 }
 
+static int twl4030_gpio_irq_set_type(unsigned int irq, unsigned trigger)
+{
+	struct irq_desc *desc = irq_desc + irq;
+	int gpio = irq - twl4030_gpio_irq_base;
+
+	trigger &= IRQ_TYPE_SENSE_MASK;
+	if (trigger & ~IRQ_TYPE_EDGE_BOTH)
+		return -EINVAL;
+	if ((desc->status & IRQ_TYPE_SENSE_MASK) == trigger)
+		return 0;
+
+	desc->status &= ~IRQ_TYPE_SENSE_MASK;
+	desc->status |= trigger;
+
+	/* REVISIT This makes the "unmask" thread do double duty,
+	 * updating IRQ trigger modes too.  Rename appropriately...
+	 */
+	gpio_pending_trigger |= (1 << gpio);
+	if (gpio_unmask_thread && gpio_unmask_thread->state != TASK_RUNNING)
+		wake_up_process(gpio_unmask_thread);
+
+	return 0;
+}
+
 static struct irq_chip twl4030_gpio_irq_chip = {
-	.name	= "twl4030",
-	.ack	= twl4030_gpio_mask_and_ack_irqchip,
-	.mask	= twl4030_gpio_mask_irqchip,
-	.unmask	= twl4030_gpio_unmask_irqchip,
+	.name		= "twl4030",
+	.ack		= twl4030_gpio_irq_mask_and_ack,
+	.mask		= twl4030_gpio_irq_mask,
+	.unmask		= twl4030_gpio_irq_unmask,
+	.set_type	= twl4030_gpio_irq_set_type,
 };
 
 /*
@@ -478,8 +511,6 @@ int twl4030_set_gpio_pull(int gpio, int pull_dircn)
 
 /*
  * Configure Edge control for a GPIO pin on TWL4030
- *
- * FIXME this should just be the irq_chip.set_type() method
  */
 int twl4030_set_gpio_edge_ctrl(int gpio, int edge)
 {
@@ -601,10 +632,14 @@ static int twl4030_gpio_unmask_thread(void *data)
 	while (!kthread_should_stop()) {
 		int irq;
 		unsigned int gpio_unmask;
+		unsigned int gpio_trigger;
 
 		local_irq_disable();
 		gpio_unmask = gpio_pending_unmask;
 		gpio_pending_unmask = 0;
+
+		gpio_trigger = gpio_pending_trigger;
+		gpio_pending_trigger = 0;
 		local_irq_enable();
 
 		for (irq = twl4030_gpio_irq_base; 0 != gpio_unmask;
@@ -613,8 +648,37 @@ static int twl4030_gpio_unmask_thread(void *data)
 				twl4030_gpio_unmask(irq);
 		}
 
+		for (irq = twl4030_gpio_irq_base;
+				gpio_trigger;
+				gpio_trigger >>= 1, irq++) {
+			struct irq_desc *desc;
+			unsigned type, edge;
+
+			if (!(gpio_trigger & 0x1))
+				continue;
+
+			desc = irq_desc + irq;
+			spin_lock_irq(&desc->lock);
+			type = desc->status & IRQ_TYPE_SENSE_MASK;
+			spin_unlock_irq(&desc->lock);
+
+			switch (type) {
+			case IRQ_TYPE_EDGE_RISING:
+				edge = TWL4030_GPIO_EDGE_RISING;
+				break;
+			case IRQ_TYPE_EDGE_FALLING:
+				edge = TWL4030_GPIO_EDGE_FALLING;
+				break;
+			default:
+				edge = TWL4030_GPIO_EDGE_RISING
+					| TWL4030_GPIO_EDGE_FALLING;
+				break;
+			}
+			twl4030_set_gpio_edge_ctrl(irq, edge);
+		}
+
 		local_irq_disable();
-		if (!gpio_pending_unmask)
+		if (!gpio_pending_unmask && !gpio_pending_trigger)
 			set_current_state(TASK_INTERRUPTIBLE);
 		local_irq_enable();
 
-- 
1.6.0.2.307.gc427

