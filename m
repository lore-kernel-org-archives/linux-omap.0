From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: Enable pcf857x GPIO expander for Device Tree
Date: Wed, 19 Jun 2013 21:38:39 +0200
Message-ID: <CACRpkdYTjQ9k=FCC0gG-REJxutSHn98uS9viMYLzywYx3KLCWA@mail.gmail.com>
References: <1370527523-1030-1-git-send-email-archit@ti.com>
	<CACRpkdY-HZ4AGqKr-DA1pvfnaVYEGZoEDn_wfDr8=9Qr+6dpiw@mail.gmail.com>
	<51BEF6FD.3070108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:56367 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935155Ab3FSTik (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jun 2013 15:38:40 -0400
Received: by mail-ob0-f176.google.com with SMTP id v19so6367570obq.35
        for <linux-omap@vger.kernel.org>; Wed, 19 Jun 2013 12:38:39 -0700 (PDT)
In-Reply-To: <51BEF6FD.3070108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>

On Mon, Jun 17, 2013 at 1:46 PM, Archit Taneja <archit@ti.com> wrote:
> On Monday 17 June 2013 02:35 PM, Linus Walleij wrote:

>Just a query, there is an example in gpio.txt in the gpio
> bindings documentation which sets #gpio-cells as 1. Is this is a wrong
> example, or are 1 cell gpio controllers valid?

I don't think so. Try it and see if it works!

(If you want it, you may have to go in and fix drivers/gpio/gpiolib-of.c.)

> About this chip, a change in any of it's GPIOs configured as inputs will
> generate an interrupt, then it's up to the driver to figure out which GPIOs
> changed and handle their corresponding irqs. So shouldn't a device connected
> to the chip describe the gpio number within the pcf857x chip as it's first
> cell?

I guess so...

> I've made a hypothetical example of a pcf8575 chip, which has it's interrupt
> line connected to an omap gpio, and pcf8575's 7th gpio is connected to
> 'pcf_slave'. The pcf_slave's driver requests for an interrupt. Is this the
> correct way to describe this? :
>
> pcf: pcf8575@23 {
>         compatible = "ti,pcf8575";
>         reg = <0x23>;
>         gpio-controller;
>         #gpio-cells = <2>;
>         #interrupt-controller;
>         #interrupt-cells = <1>;
>         interrupt-parent = <&gpio2>;    /* an omap gpio bank */
>         interrupts = <2 8>;             /* gpio line 34, low triggered*/
> };
>
> pcf_slave: slave {
>         ...
>         ...
>         #interrupt-parent = <&pcf>;
>         interrupts = <7>;       /* connected to 7th IO pin of pcf857x*/
> };

There are two paths for dereferencing GPIOs and IRQs.

Simple approach:

give your slave a gpios = <...>;

and in the driver use gpio_to_irq() to dereference an IRQ number
from the GPIO number you get. The IRQdomain etc in the
GPIO driver will take care of the rest.

How to code up a driver so that it can use irqs directly from a GPIO
controller without referring to the GPIO line it is tied into is currently
quite unclear. Atleast to me. It's been discussed for the OMAP
case so search the archives...

Yours,
Linus Walleij
