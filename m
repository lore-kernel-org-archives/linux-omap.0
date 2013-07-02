From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 1/1] gpio/omap: fix build error when OF_GPIO is not defined.
Date: Tue,  2 Jul 2013 21:46:30 +0200
Message-ID: <1372794390-9512-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:44454 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754190Ab3GBTqp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jul 2013 15:46:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Grant Likely <grant.likely@linaro.org>, jgchunter@gmail.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, eballetbo@gmail.com, linux-omap@vger.kernel.org, Florian Vaussard <florian.vaussard@epfl.ch>, aaro.koskinen@iki.fi, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

The OMAP GPIO driver check if the chip has an associated
Device Tree node using the struct gpio_chip of_node member.

But this is only build if CONFIG_OF_GPIO is defined which
leads to the following error when using omap1_defconfig:

linux/drivers/gpio/gpio-omap.c: In function 'omap_gpio_chip_init':
linux/drivers/gpio/gpio-omap.c:1080:17: error: 'struct gpio_chip' has no member named 'of_node'
linux/drivers/gpio/gpio-omap.c: In function 'omap_gpio_irq_map':
linux/drivers/gpio/gpio-omap.c:1116:16: error: 'struct gpio_chip' has no member named 'of_node'

Reported-by: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---

Hi Linus,

Sorry for not spoting this issue before. In a previous version of the patch-set:

[PATCH v3 0/2]: auto request GPIO as input if used as IRQ via DT

of_have_populated_dt() was used instead of struct gpio_chip of_node member to
check wether legacy or DT boot was used. I did a build test on every OMAP platform
but later I was asked to use .of_node instead of_have_populated_dt() and forget
to do a built test for OMAP1.

I hope this patch can go as a fix for the v3.11-rc cycle.

Thanks a lot and best regards,
Javier

 drivers/gpio/gpio-omap.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index c4f0aa2..00c6f77 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1037,6 +1037,18 @@ omap_mpuio_alloc_gc(struct gpio_bank *bank, unsigned int irq_start,
 			       IRQ_NOREQUEST | IRQ_NOPROBE, 0);
 }
 
+#if defined(CONFIG_OF_GPIO)
+static inline bool omap_gpio_chip_boot_dt(struct gpio_chip *chip)
+{
+	return chip->of_node != NULL;
+}
+#else
+static inline bool omap_gpio_chip_boot_dt(struct gpio_chip *chip)
+{
+	return false;
+}
+#endif
+
 static void omap_gpio_chip_init(struct gpio_bank *bank)
 {
 	int j;
@@ -1077,7 +1089,7 @@ static void omap_gpio_chip_init(struct gpio_bank *bank)
 	 * irq_create_of_mapping() only for the GPIO lines that
 	 * are used as interrupts.
 	 */
-	if (!bank->chip.of_node)
+	if (!omap_gpio_chip_boot_dt(&bank->chip))
 		for (j = 0; j < bank->width; j++)
 			irq_create_mapping(bank->domain, j);
 	irq_set_chained_handler(bank->irq, gpio_irq_handler);
@@ -1113,7 +1125,7 @@ static int omap_gpio_irq_map(struct irq_domain *d, unsigned int virq,
 	 * but until then this has to be done on a per driver
 	 * basis. Remove this once this is managed by the core.
 	 */
-	if (bank->chip.of_node) {
+	if (omap_gpio_chip_boot_dt(&bank->chip)) {
 		gpio = irq_to_gpio(bank, hwirq);
 		ret = gpio_request_one(gpio, GPIOF_IN, NULL);
 		if (ret) {
-- 
1.7.7.6

