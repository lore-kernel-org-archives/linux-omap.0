From: "Wang Sawsd-A24013" <cqwang@motorola.com>
Subject: [PATCH] OMAP2/3 Avoid GPIO pending irq status been set after irq_disable
Date: Tue, 2 Jun 2009 07:24:39 +0800
Message-ID: <B00E06E2766C2744B022DE9BAF3C59D532D196@zmy16exm69.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail119.messagelabs.com ([216.82.241.195]:42727 "EHLO
	mail119.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122AbZFAXZR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jun 2009 19:25:17 -0400
Received: from il27exr04.cig.mot.com (il27exr04.mot.com [10.17.196.73])
	by motgate4.mot.com (8.14.3/8.14.3) with ESMTP id n51NPIFg003230
	for <linux-omap@vger.kernel.org>; Mon, 1 Jun 2009 16:25:18 -0700 (MST)
Received: from il27vts03 (il27vts03.cig.mot.com [10.17.196.87])
	by il27exr04.cig.mot.com (8.13.1/Vontu) with SMTP id n51NPIq5008367
	for <linux-omap@vger.kernel.org>; Mon, 1 Jun 2009 18:25:18 -0500 (CDT)
Received: from zmy16exm69.ds.mot.com (zmy16exm69.ap.mot.com [10.179.4.36])
	by il27exr04.cig.mot.com (8.13.1/8.13.0) with ESMTP id n51NPHoA008347
	for <linux-omap@vger.kernel.org>; Mon, 1 Jun 2009 18:25:17 -0500 (CDT)
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch adds irq_enable and irq_disable for OMAP GPIO IRQ chip, and
also only enable WAKEUPEN
When GPIO edge detection is enabled, also clear the gpio event
triggering configurations to avoid
Pending interrupt status which is generated regardless of the IRQEN and
WKUPEN bit, the pending
IRQ status may prevent GPIO module acknowledge IDLE request and prevent
PER and thus RETENTION.

This is only applied for OMAP2/3 GPIO IRQs.

Signed-off-by: Chunqiu Wang <cqwang@motorola.com>
---
 arch/arm/plat-omap/gpio.c |   44
++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index bd04b40..19e0461 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -581,7 +581,7 @@ void omap_set_gpio_debounce_time(int gpio, int
enc_time)
 EXPORT_SYMBOL(omap_set_gpio_debounce_time);
 
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
-static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int
gpio,
+static void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
 						int trigger)
 {
 	void __iomem *base = bank->base;
@@ -597,7 +597,12 @@ static inline void set_24xx_gpio_triggering(struct
gpio_bank *bank, int gpio,
 		trigger & IRQ_TYPE_EDGE_FALLING);
 
 	if (likely(!(bank->non_wakeup_gpios & gpio_bit))) {
-		if (trigger != 0)
+		/*
+		 * GPIO wakeup request can only be generated on edge
+		 * transitions, see OMAP34xx_ES3.1_TRM_V_Q G25.5.3.1
+		 * wake-up request note for detail
+		 */
+		if ((trigger & IRQ_TYPE_EDGE_BOTH) != 0)
 			__raw_writel(1 << gpio, bank->base
 					+ OMAP24XX_GPIO_SETWKUENA);
 		else
@@ -1133,6 +1138,39 @@ static void gpio_ack_irq(unsigned int irq)
 	_clear_gpio_irqstatus(bank, gpio);
 }
 
+static void gpio_enable_irq(unsigned int irq)
+{
+	unsigned int gpio = irq - IH_GPIO_BASE;
+	struct gpio_bank *bank = get_irq_chip_data(irq);
+	int trigger = irq_desc[irq].status & IRQ_TYPE_SENSE_MASK;
+
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+	set_24xx_gpio_triggering(bank, get_gpio_index(gpio), trigger);
+#endif
+	_set_gpio_irqenable(bank, gpio, 1);
+}
+
+static void gpio_disable_irq(unsigned int irq)
+{
+	unsigned int gpio = irq - IH_GPIO_BASE;
+	struct gpio_bank *bank = get_irq_chip_data(irq);
+
+	_set_gpio_irqenable(bank, gpio, 0);
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+	/*
+	 * Clear the event detect setting and IRQ status to prevent
+	 * IRQ staus been set or pending there While IRQ is disabled,
+	 * otherwise GPIO module will not acknowledge the IDLE request
+	 * from PER power domain, this may prevent System wide retention
+	 * See OMAP34xx_ES3.1_TRM_V_Q G25.5.3.1 GPIO interrupt and
wakeup
+	 * enable note for detail
+	 */
+	set_24xx_gpio_triggering(bank, get_gpio_index(gpio),
IRQ_TYPE_NONE);
+	_clear_gpio_irqstatus(bank, gpio);
+#endif
+
+}
+
 static void gpio_mask_irq(unsigned int irq)
 {
 	unsigned int gpio = irq - IH_GPIO_BASE;
@@ -1160,6 +1198,8 @@ static void gpio_unmask_irq(unsigned int irq)
 static struct irq_chip gpio_irq_chip = {
 	.name		= "GPIO",
 	.shutdown	= gpio_irq_shutdown,
+	.enable		= gpio_enable_irq,
+	.disable	= gpio_disable_irq,
 	.ack		= gpio_ack_irq,
 	.mask		= gpio_mask_irq,
 	.unmask		= gpio_unmask_irq,
-- 
1.5.4.3
