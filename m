From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] gpio: do not set up hardware for IRQ_TYPE_NONE
Date: Wed, 23 Apr 2014 16:50:10 +0200
Message-ID: <1398264610-12663-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:41208 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314AbaDWOuQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Apr 2014 10:50:16 -0400
Received: by mail-we0-f177.google.com with SMTP id u57so954388wes.22
        for <linux-omap@vger.kernel.org>; Wed, 23 Apr 2014 07:50:15 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-gpio@vger.kernel.org
Cc: Alexandre Courbot <acourbot@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Javier Martinez Canillas <javier@dowhile0.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap <linux-omap@vger.kernel.org>

Some GPIO irqchip drivers exploit the irqdomain mapping
function to set up the IRQ default type in the hardware,
make sure that if we pass IRQ_TYPE_NONE, no hardware setup
whatsoever takes place (this should be the norm) until
later when the IRQ gets utilized.

Cc: Nishanth Menon <nm@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
TI folks: can you provide a Tested-by tag if this makes your
OMAPs work? I am pretty sure the other platforms will be
unaffected, if they aren't I will switch them over to react
to IRQ_TYPE_DEFAULT.
---
 drivers/gpio/gpiolib.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index ee1819fdcf35..97d173e9aa2d 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1409,7 +1409,12 @@ static int gpiochip_irq_map(struct irq_domain *d, unsigned int irq,
 #else
 	irq_set_noprobe(irq);
 #endif
-	irq_set_irq_type(irq, chip->irq_default_type);
+	/*
+	 * No set-up of the hardware will happen if IRQ_TYPE_NONE
+	 * is passed as default type.
+	 */
+	if (chip->irq_default_type != IRQ_TYPE_NONE)
+		irq_set_irq_type(irq, chip->irq_default_type);
 
 	return 0;
 }
@@ -1490,7 +1495,8 @@ static void gpiochip_irqchip_remove(struct gpio_chip *gpiochip)
  * @first_irq: if not dynamically assigned, the base (first) IRQ to
  * allocate gpiochip irqs from
  * @handler: the irq handler to use (often a predefined irq core function)
- * @type: the default type for IRQs on this irqchip
+ * @type: the default type for IRQs on this irqchip, pass IRQ_TYPE_NONE
+ * to have the core avoid setting up any default type in the hardware.
  *
  * This function closely associates a certain irqchip with a certain
  * gpiochip, providing an irq domain to translate the local IRQs to
-- 
1.9.0

