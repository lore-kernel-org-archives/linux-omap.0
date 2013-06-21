From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 1/1] gpio/omap: auto request GPIO as input if used as IRQ via DT
Date: Fri, 21 Jun 2013 03:42:51 +0200
Message-ID: <1371778971-17561-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:33252 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758483Ab3FUBnK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Jun 2013 21:43:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@linaro.org>
Cc: jgchunter@gmail.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, eballetbo@gmail.com, thomas.petazzoni@free-electrons.com, linux-omap@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

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
is never made. So, let's add a custom .map function handler that
setups and configures the GPIO as input automatically.

Many thanks to Jon Hunter and Grant Likely for their feedback and
suggestions on how to solve this.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---

NOTE: Ideally this has to be handled by the IRQ core instead
each irq_chip driver implementing a custom .map or .xlate
function handler. There are some work-in-progress to add this
logic to the core but until this general solution gets into
mainline let's add this temporary solution that can be later
reverted when is not needed anymore.

Tested on a OMAP3 DM3735 board (IGEPv2) to make its smsc911x
LAN chip to work with DeviceTree booting.

 drivers/gpio/gpio-omap.c |   29 ++++++++++++++++++++++++++++-
 1 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index d3f7d2d..b3e5f75 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1086,6 +1086,33 @@ static void omap_gpio_chip_init(struct gpio_bank *bank)
 
 static const struct of_device_id omap_gpio_match[];
 
+static int omap_gpio_irq_map(struct irq_domain *d, unsigned int virq,
+			     irq_hw_number_t hwirq)
+{
+	struct gpio_bank *bank = d->host_data;
+	int gpio;
+	int ret;
+
+	if (!bank)
+		return -EINVAL;
+
+	gpio = irq_to_gpio(bank, hwirq);
+
+	ret = gpio_request_one(gpio, GPIOF_IN, NULL);
+
+	if (ret) {
+		dev_err(bank->dev, "Could not request GPIO%d\n", gpio);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct irq_domain_ops omap_gpio_irq_ops = {
+	.xlate  = irq_domain_xlate_onetwocell,
+	.map    = omap_gpio_irq_map,
+};
+
 static int omap_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1137,7 +1164,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 
 
 	bank->domain = irq_domain_add_linear(node, bank->width,
-					     &irq_domain_simple_ops, NULL);
+					     &omap_gpio_irq_ops, bank);
 	if (!bank->domain)
 		return -ENODEV;
 
-- 
1.7.7.6

