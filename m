From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-rc8-omap 5/7] gpiolib to_irq() feature
Date: Fri, 3 Oct 2008 09:02:55 -0700
Message-ID: <200810030902.55834.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:32646 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753117AbYJCQbi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 12:31:38 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Add a new gpiolib mechanism:  gpio_chip instances can provide
mappings between their (input) GPIOs and any associated IRQs.
This makes it easier for platforms to support IRQs that are
provided by board-specific external chips instead of as part
of their core (such as SOC-integrated GPIOs). 

Also update the irq_to_gpio() description, saying to avoid it
becuase it's not always supported.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
Preview of a 2.6.28 feature, taken from MM to let OMAP stage
patches relying on this feature.

 Documentation/gpio.txt     |    5 +++--
 drivers/gpio/gpiolib.c     |   18 ++++++++++++++++++
 include/asm-generic/gpio.h |    7 +++++++
 3 files changed, 28 insertions(+), 2 deletions(-)

--- a/Documentation/gpio.txt
+++ b/Documentation/gpio.txt
@@ -264,7 +264,7 @@ map between them using calls like:
 	/* map GPIO numbers to IRQ numbers */
 	int gpio_to_irq(unsigned gpio);
 
-	/* map IRQ numbers to GPIO numbers */
+	/* map IRQ numbers to GPIO numbers (avoid using this) */
 	int irq_to_gpio(unsigned irq);
 
 Those return either the corresponding number in the other namespace, or
@@ -284,7 +284,8 @@ system wakeup capabilities.
 
 Non-error values returned from irq_to_gpio() would most commonly be used
 with gpio_get_value(), for example to initialize or update driver state
-when the IRQ is edge-triggered.
+when the IRQ is edge-triggered.  Note that some platforms don't support
+this reverse mapping, so you should avoid using it.
 
 
 Emulating Open Drain Signals
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1008,6 +1008,24 @@ int __gpio_cansleep(unsigned gpio)
 }
 EXPORT_SYMBOL_GPL(__gpio_cansleep);
 
+/**
+ * __gpio_to_irq() - return the IRQ corresponding to a GPIO
+ * @gpio: gpio whose IRQ will be returned (already requested)
+ * Context: any
+ *
+ * This is used directly or indirectly to implement gpio_to_irq().
+ * It returns the number of the IRQ signaled by this (input) GPIO,
+ * or a negative errno.
+ */
+int __gpio_to_irq(unsigned gpio)
+{
+	struct gpio_chip	*chip;
+
+	chip = gpio_to_chip(gpio);
+	return chip->to_irq ? chip->to_irq(chip, gpio - chip->base) : -ENXIO;
+}
+EXPORT_SYMBOL_GPL(__gpio_to_irq);
+
 
 
 /* There's no value in making it easy to inline GPIO calls that may sleep.
--- a/include/asm-generic/gpio.h
+++ b/include/asm-generic/gpio.h
@@ -40,6 +40,8 @@ struct module;
  *	returns either the value actually sensed, or zero
  * @direction_output: configures signal "offset" as output, or returns error
  * @set: assigns output value for signal "offset"
+ * @to_irq: optional hook supporting non-static gpio_to_irq() mappings;
+ *	implementation may not sleep
  * @dbg_show: optional routine to show contents in debugfs; default code
  *	will be used when this is omitted, but custom code can show extra
  *	state (such as pullup/pulldown configuration).
@@ -73,6 +75,10 @@ struct gpio_chip {
 						unsigned offset, int value);
 	void			(*set)(struct gpio_chip *chip,
 						unsigned offset, int value);
+
+	int			(*to_irq)(struct gpio_chip *chip,
+						unsigned offset);
+
 	void			(*dbg_show)(struct seq_file *s,
 						struct gpio_chip *chip);
 	int			base;
@@ -112,6 +118,7 @@ extern void __gpio_set_value(unsigned gp
 
 extern int __gpio_cansleep(unsigned gpio);
 
+extern int __gpio_to_irq(unsigned gpio);
 
 #ifdef CONFIG_GPIO_SYSFS
 
