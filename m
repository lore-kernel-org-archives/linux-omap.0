From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-rc8-omap 6/7] OMAP gpios implement new to_irq()
Date: Fri, 3 Oct 2008 09:04:12 -0700
Message-ID: <200810030904.12309.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:32651 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752875AbYJCQbj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 12:31:39 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Make OMAP use the new __gpio_to_irq() hook, to make it easier to
support IRQs coming in from off-chip gpio controllers like the
TWL4030/TPS65930 chip used on OMAP3 boads like Beagleboard.org and
the Gumstix Overo.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 arch/arm/plat-omap/gpio.c              |    9 +++++++++
 arch/arm/plat-omap/include/mach/gpio.h |   16 ++++++++++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1287,6 +1287,14 @@ static void gpio_set(struct gpio_chip *c
 	spin_unlock_irqrestore(&bank->lock, flags);
 }
 
+static int gpio_2irq(struct gpio_chip *chip, unsigned offset)
+{
+	struct gpio_bank *bank;
+
+	bank = container_of(chip, struct gpio_bank, chip);
+	return bank->virtual_irq_start + offset;
+}
+
 /*---------------------------------------------------------------------*/
 
 static int initialized;
@@ -1482,6 +1490,7 @@ static int __init _omap_gpio_init(void)
 		bank->chip.get = gpio_get;
 		bank->chip.direction_output = gpio_output;
 		bank->chip.set = gpio_set;
+		bank->chip.to_irq = gpio_2irq;
 		if (bank_is_mpuio(bank)) {
 			bank->chip.label = "mpuio";
 #ifdef CONFIG_ARCH_OMAP16XX
--- a/arch/arm/plat-omap/include/mach/gpio.h
+++ b/arch/arm/plat-omap/include/mach/gpio.h
@@ -109,16 +109,24 @@ static inline int gpio_cansleep(unsigned
 
 static inline int gpio_to_irq(unsigned gpio)
 {
-	if (gpio < (OMAP_MAX_GPIO_LINES + 16))
-		return OMAP_GPIO_IRQ(gpio);
-	return -EINVAL;
+	return __gpio_to_irq(gpio);
 }
 
 static inline int irq_to_gpio(unsigned irq)
 {
+	int tmp;
+
+	/* omap1 SOC mpuio */
 	if (cpu_class_is_omap1() && (irq < (IH_MPUIO_BASE + 16)))
 		return (irq - IH_MPUIO_BASE) + OMAP_MAX_GPIO_LINES;
-	return irq - IH_GPIO_BASE;
+
+	/* SOC gpio */
+	tmp = irq - IH_GPIO_BASE;
+	if (tmp < OMAP_MAX_GPIO_LINES)
+		return tmp;
+
+	/* we don't supply reverse mappings for non-SOC gpios */
+	return -EIO;
 }
 
 #endif
