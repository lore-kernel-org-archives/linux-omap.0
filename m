From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH v3 0/2]: auto request GPIO as input if used as IRQ via DT
Date: Tue, 2 Jul 2013 19:31:44 +0200
Message-ID: <CAAwP0s1QpvSUgt0f1r4acKNCuzNdLb6qG-poOHMcyN2gUCjQUg@mail.gmail.com>
References: <1372276203-21755-1-git-send-email-javier.martinez@collabora.co.uk>
 <CAGa+x87OnYmnCQjLzyc5CFJE_n8GXaka2iPjCUdGj=yx1uqd4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:47580 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085Ab3GBRcG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jul 2013 13:32:06 -0400
Received: by mail-ie0-f171.google.com with SMTP id qd12so13250162ieb.30
        for <linux-omap@vger.kernel.org>; Tue, 02 Jul 2013 10:32:05 -0700 (PDT)
In-Reply-To: <CAGa+x87OnYmnCQjLzyc5CFJE_n8GXaka2iPjCUdGj=yx1uqd4Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Grant Likely <grant.likely@linaro.org>, jgchunter@gmail.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, eballetbo@gmail.com, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-omap <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, aaro.koskinen@iki.fi

On Tue, Jul 2, 2013 at 6:10 PM, Kevin Hilman <khilman@linaro.org> wrote:
> On Wed, Jun 26, 2013 at 12:50 PM, Javier Martinez Canillas
> <javier.martinez@collabora.co.uk> wrote:
>
> [...]
>
>> Aaro, could you please test if these changes break any of your OMAP1 boards?
>> Although it shouldn't do it as far as I can tell.
>
> This doesn't build for omap1_defconfig (at least in next-20130702):
>
> /work/kernel/next/drivers/gpio/gpio-omap.c: In function 'omap_gpio_chip_init':
> /work/kernel/next/drivers/gpio/gpio-omap.c:1080:17: error: 'struct
> gpio_chip' has no member named 'of_node'
> /work/kernel/next/drivers/gpio/gpio-omap.c: In function 'omap_gpio_irq_map':
> /work/kernel/next/drivers/gpio/gpio-omap.c:1116:16: error: 'struct
> gpio_chip' has no member named 'of_node'
>
> Probably because OMAP1 is non-DT?
>
> Kevin
> --

Hi Kevin,

Yes, sorry about that. In the a previous version of the patch-set
of_have_populated_dt() was used instead of chip.of_node and it built
correctly with OMAP1 since it just default to return false.

Then I was told to check if the struct gpio_chip has an associated
device node instead and forget to build test for OMAP1 :-(

Could you please tell me if the following patch looks like a good fix
to you so I can do a proper post?

>From 2d14bcc7c300a9451d7d8a37eeff4e0285c977a0 Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Date: Tue, 2 Jul 2013 19:04:14 +0200
Subject: [PATCH 1/1] gpio/omap: fix build error when CONFIG_OF_GPIO is not
 defined.

The OMAP GPIO driver check if the chip has an associated
DT device node using the struct gpio_chip of_node member.

But this is only built if CONFIG_OF_GPIO is defined which
leads to the following error when using omap1_defconfig:

linux/drivers/gpio/gpio-omap.c: In function 'omap_gpio_chip_init':
linux/drivers/gpio/gpio-omap.c:1080:17: error: 'struct gpio_chip' has
no member named 'of_node'
linux/drivers/gpio/gpio-omap.c: In function 'omap_gpio_irq_map':
linux/drivers/gpio/gpio-omap.c:1116:16: error: 'struct gpio_chip' has
no member named 'of_node'

Reported-by: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/gpio/gpio-omap.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index c4f0aa2..bd536f1 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1037,6 +1037,18 @@ omap_mpuio_alloc_gc(struct gpio_bank *bank,
unsigned int irq_start,
 			       IRQ_NOREQUEST | IRQ_NOPROBE, 0);
 }

+#if defined(CONFIG_OF_GPIO)
+static inline bool omap_gpio_chip_dt_boot(struct gpio_chip *chip)
+{
+	return chip->of_node != NULL;
+}
+#else
+static inline bool omap_gpio_chip_dt_boot(struct gpio_chip *chip)
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
+	if (!omap_gpio_chip_dt_boot(&bank->chip))
 		for (j = 0; j < bank->width; j++)
 			irq_create_mapping(bank->domain, j);
 	irq_set_chained_handler(bank->irq, gpio_irq_handler);
@@ -1113,7 +1125,7 @@ static int omap_gpio_irq_map(struct irq_domain
*d, unsigned int virq,
 	 * but until then this has to be done on a per driver
 	 * basis. Remove this once this is managed by the core.
 	 */
-	if (bank->chip.of_node) {
+	if (omap_gpio_chip_dt_boot(&bank->chip)) {
 		gpio = irq_to_gpio(bank, hwirq);
 		ret = gpio_request_one(gpio, GPIOF_IN, NULL);
 		if (ret) {
-- 
1.7.7.6
