From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH v2 2/2] gpio/omap: auto request GPIO as input if used as IRQ via DT
Date: Sat, 22 Jun 2013 00:50:54 +0200
Message-ID: <1371855054-27958-3-git-send-email-javier.martinez@collabora.co.uk>
References: <[PATCH v2 0/2]: auto request GPIO as input if used as IRQ via DT>
 <1371855054-27958-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:34174 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946200Ab3FUWvH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Jun 2013 18:51:07 -0400
In-Reply-To: <1371855054-27958-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@linaro.org>
Cc: jgchunter@gmail.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, eballetbo@gmail.com, thomas.petazzoni@free-electrons.com, linux-omap@vger.kernel.org, Florian Vaussard <florian.vaussard@epfl.ch>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

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
---

Changes since v1:
  - Split the irq domain mapping function handler and the GPIO
    request in two different patches.

 drivers/gpio/gpio-omap.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 31cbe65..5ec6a00 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1092,6 +1092,8 @@ static int omap_gpio_irq_map(struct irq_domain *d, unsigned int virq,
 			     irq_hw_number_t hwirq)
 {
 	struct gpio_bank *bank = d->host_data;
+	int gpio;
+	int ret;
 
 	if (!bank)
 		return -EINVAL;
@@ -1106,6 +1108,13 @@ static int omap_gpio_irq_map(struct irq_domain *d, unsigned int virq,
 						 handle_simple_irq);
 			set_irq_flags(virq, IRQF_VALID);
 		}
+
+		gpio = irq_to_gpio(bank, hwirq);
+		ret = gpio_request_one(gpio, GPIOF_IN, NULL);
+		if (ret) {
+			dev_err(bank->dev, "Could not request GPIO%d\n", gpio);
+			return ret;
+		}
 	}
 
 	return 0;
-- 
1.7.7.6

