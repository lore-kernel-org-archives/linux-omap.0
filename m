From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: (unknown)
Date: Sat, 22 Jun 2013 00:50:52 +0200
Message-ID: <1371855054-27958-1-git-send-email-javier.martinez@collabora.co.uk>
References: <[PATCH v2 0/2]: auto request GPIO as input if used as IRQ via DT>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:34160 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946172Ab3FUWvG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Jun 2013 18:51:06 -0400
Subject: 
In-Reply-To: <[PATCH v2 0/2]: auto request GPIO as input if used as IRQ via DT>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@linaro.org>
Cc: jgchunter@gmail.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, eballetbo@gmail.com, thomas.petazzoni@free-electrons.com, linux-omap@vger.kernel.org, Florian Vaussard <florian.vaussard@epfl.ch>

When an OMAP GPIO is used as an IRQ line, a call to gpio_request()
has to be made to initialize the OMAP GPIO bank before a driver
request the IRQ. Otherwise the call to request_irq() fails.

Drivers should not be aware of this neither care wether an IRQ line
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
is never made. Ideally this has to be handled by the IRQ core and
there are some work-in-progress to add this logic to the core but
until this general solution gets into mainline we need to solve this
on a per irq_chip driver basis.

Some drivers solve this by calling gpio_request() using a custom
.xlate function handler. But .xlate could get called many times
while the irq domain .map function handler is called just once
when a IRQ mapping is created with a call to irq_create_mapping().

This patch-set adds a custom .map function handler for the gpio-omap
irq_chip driver that automatically call gpio_request() when a IRQ
mapping is created for the GPIO line used as interrupt. This is
just a temporary solution (a.k.a a hack) until a kernel wide approach
is implemented and added to mainline.

The patch-set is composed of the following patches:

[PATCH v2 1/2] gpio/omap: don't create an IRQ mapping for every GPIO on DT
[PATCH v2 2/2] gpio/omap: auto request GPIO as input if used as IRQ via DT

This was tested on an OMAP3 DM3735 board (IGEPv2) and all the supported
peripherals are working correctly with both legacy and DT booting. Further
testing will be highly appreciated.

Many thanks to Jon Hunter and Grant Likely for their feedback and
suggestions on how to solve this.

Best regards,
Javier
