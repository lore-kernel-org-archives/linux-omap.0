From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH] gpio/omap: fix pm_runtime for IRQ functions
Date: Tue, 22 Jan 2013 09:22:47 +0100
Message-ID: <CACRpkdYpCbWtk6PbgLm0HWFBihDqA_G_1btYQ38+WfeXridPJA@mail.gmail.com>
References: <1358531362-27933-1-git-send-email-jlu@pengutronix.de>
	<50FCE27D.7060500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:47931 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867Ab3AVIWs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jan 2013 03:22:48 -0500
Received: by mail-ie0-f182.google.com with SMTP id s9so11287354iec.13
        for <linux-omap@vger.kernel.org>; Tue, 22 Jan 2013 00:22:48 -0800 (PST)
In-Reply-To: <50FCE27D.7060500@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: Jan Luebbe <jlu@pengutronix.de>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, kernel@pengutronix.de, Rajendra Nayak <rnayak@ti.com>

On Mon, Jan 21, 2013 at 7:38 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:

Need Grant to look at this too...

> Whats your suggestion on above mentioned issue. How gpio_request()
> can be triggered from the framework when a gpio irq binding is found
> in DT blob() ?

Just as usual the GPIO has to be requested.

In the Nomadik I had a similar situation with a GPIO used for the
ethernet IRQ. I put the GPIO number in a special board-specific
node and added this to the machine, but it could as well be in a device
driver:

/*
 * The SMSC911x IRQ is connected to a GPIO pin, but the driver expects
 * to simply request an IRQ passed as a resource. So the GPIO pin needs
 * to be requested by this hog and set as input.
 */
static int __init cpu8815_eth_init(void)
{
        struct device_node *eth;
        int gpio, irq, err;

        eth = of_find_node_by_path("/usb-s8815/ethernet-gpio");
        if (!eth) {
                pr_info("could not find any ethernet GPIO\n");
                return 0;
        }
        gpio = of_get_gpio(eth, 0);
        err = gpio_request(gpio, "eth_irq");
        if (err) {
                pr_info("failed to request ethernet GPIO\n");
                return -ENODEV;
        }
        err = gpio_direction_input(gpio);
        if (err) {
                pr_info("failed to set ethernet GPIO as input\n");
                return -ENODEV;
        }
        irq = gpio_to_irq(gpio);
        pr_info("enabled USB-S8815 ethernet GPIO %d, IRQ %d\n", gpio, irq);
        return 0;
}
device_initcall(cpu8815_eth_init);

Note that I just map the IRQ to print it, the actual request of that IRQ
is done elsewhere.

I think something like the above should be added to:

1) The device driver, if an interrupt source on a GPIO pin is
   "normal" for this device, i.e. if the GPIO is part of that device's
   DT node. No need to use of_find_node_by_path().

2) To the board file if it's something optional, like in this ethernet
   example, the IRQ for an SMSC91 is usually routed directly
   to the CPU, so having a GPIO IRQ being used instead is
   pretty odd and we set it up as input and the driver will just
   request it as "any irq".

> Rajendra cooked up a patch while back on the same
> topic which am attaching for the reference. Please let us know
> your input whether attached patch make sense or any other
> alternative you have.

This doesn't seem right. It changes the semantics of a DT kernel from
that of a non-DT kernel. It will certainly lead to breakage and
weirdness if we apply it.

But it does look convenient.

If we proceed in this way I would use a more cautious approach:
what about adding a GPIO irq-hog property to any GPIO controller?
So when registering that gpio_chip, gpiolib can optionally hog
and set up GPIOs as IRQs?

That would be an approach to set default values on some GPIOs
as well, and then set some to be used as IRQs and leave it at
that.

Such as:


        gpio0: gpio@101e4000 {
                compatible = "st,nomadik-gpio";
                reg =  <0x101e4000 0x80>;
                interrupt-parent = <&vica>;
                interrupts = <6>;
                interrupt-controller;
                #interrupt-cells = <2>;
                gpio-controller;
                #gpio-cells = <2>;
                gpio-bank = <0>;
+                input-hog-gpios = <4>, <5>;
+                output-low-hog-gpios = <8>, <9>;
+                output-high-hog-gpios = <10>, <11>;
        };

So in this case that GPIO, when being registered, would set
(local number!) pin 4,5 as inputs, pin 8,9 as outputs low,
and 10, 11 as outputs high.

This makes it possible to just request the IRQ on one
of the input pins (4, 5) later.

However it is a bit awkward since you're never using
gpio_to_irq() to figure out the IRQ number, so I still think
the explicit code up above is better.

Yours,
Linus Walleij
