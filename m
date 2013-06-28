From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH v4 2/2] gpio/omap: auto request GPIO as input if used as IRQ via DT
Date: Fri, 28 Jun 2013 17:27:03 +0200
Message-ID: <1372433223-9053-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:40777 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754627Ab3F1P1Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Jun 2013 11:27:25 -0400
In-Reply-To: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Grant Likely <grant.likely@linaro.org>, jgchunter@gmail.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, eballetbo@gmail.com, linux-omap@vger.kernel.org, Florian Vaussard <florian.vaussard@epfl.ch>, aaro.koskinen@iki.fi, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

When an OMAP GPIO is used as an IRQ line, a call to gpio_request()
has to be made to initialize the OMAP GPIO bank before a driver
request the IRQ. Otherwise the call to request_irq() fails.

Drives should not be aware of this neither care wether an IRQ line
is a GPIO or not. They should just request the IRQ and this has to
be handled by the irq_chip driver.

With the current OMAP GPIO DT binding, if we define:

    gpio6: gpio@49058000 {
    	   compatible = "ti,omap3-gpio";
	   reg = <0x49058000 0x200>;
	   interrupts = <34>;
	   ti,hwmods = "gpio6";
	   gpio-controller;
	   #gpio-cells = <2>;
	   interrupt-controller;
	   #interrupt-cells = <2>;
    };

	   interrupt-parent = <&gpio6>;
           interrupts = <16 8>;

The GPIO is correctly mapped as an IRQ but a call to gpio_request()
is never made. Since a call to the custom IRQ domain .map function
handler is made for each GPIO used as an IRQ, the GPIO can be setup
and configured as input there automatically.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Enric Balletbo i Serra <eballetbo@gmail.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---

Changes since v3:
  - Use bank->chip.of_node instead of_have_populated_dt() to check
    DT or legacy boot as suggested by Jean-Christophe PLAGNIOL-VILLARD
  - Add a comment that this is just a temporary solution until and
    that it has to be removed once is handled by the IRQ core.

Changes since v2:
 - Only make the call to gpio_request_one() conditional in the DT
   case as suggested by Grant Likely.

Changes since v1:
  - Split the irq domain mapping function handler and the GPIO
    request in two different patches.

 drivers/gpio/gpio-omap.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index e260590..c4f0aa2 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1090,6 +1090,8 @@ static int omap_gpio_irq_map(struct irq_domain *d, unsigned int virq,
 			     irq_hw_number_t hwirq)
 {
 	struct gpio_bank *bank = d->host_data;
+	int gpio;
+	int ret;
 
 	if (!bank)
 		return -EINVAL;
@@ -1104,6 +1106,22 @@ static int omap_gpio_irq_map(struct irq_domain *d, unsigned int virq,
 		set_irq_flags(virq, IRQF_VALID);
 	}
 
+	/*
+	 * REVISIT most GPIO IRQ chip drivers need to call
+	 * gpio_request() before a GPIO line can be used as an
+	 * IRQ. Ideally this should be handled by the IRQ core
+	 * but until then this has to be done on a per driver
+	 * basis. Remove this once this is managed by the core.
+	 */
+	if (bank->chip.of_node) {
+		gpio = irq_to_gpio(bank, hwirq);
+		ret = gpio_request_one(gpio, GPIOF_IN, NULL);
+		if (ret) {
+			dev_err(bank->dev, "Could not request GPIO%d\n", gpio);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
-- 
1.7.7.6

