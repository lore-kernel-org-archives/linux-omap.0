From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Wed, 10 Apr 2013 20:12:54 +0200
Message-ID: <CACRpkdYbs4-uudpRUY8e+7icYYkZrfM0kReP3pLL5DMiURJ4dg@mail.gmail.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
	<1329321854-24490-4-git-send-email-b-cousson@ti.com>
	<4F44FA56.7020000@gmail.com>
	<4F44FC37.2000701@ti.com>
	<4F452484.5080503@gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF17BD8BC6C1@HQMAIL01.nvidia.com>
	<4F47AD08.4030504@ti.com>
	<CAAwP0s0cB368R2mtbJpTZJreR-5GSRLfxC+8DJLo5nw3_OwBuA@mail.gmail.com>
	<512D39DA.7020306@ti.com>
	<512D3AB1.1080202@wwwdotorg.org>
	<512D3EC2.6050408@ti.com>
	<20130302200524.D230F3E1571@localhost>
	<51391F41.5000303@ti.com>
	<CAAwP0s1CFRO-rf==p5sYs1n0gigMif7wuT8Yv0N_iLUDMrtcOg@mail.gmail.com>
	<CACRpkdYHj-rEF3Rk_CWnmmMw_Amr7m8SgQ=-2zsDYuLeuu3azw@mail.gmail.com>
	<514C79E1.4090106@wwwdotorg.org>
	<514CE0AB.6060207@ti.com>
	<CACRpkdZmv-rAoKSQYpkHHSMzKJOn5TixVW_P3=m7ZNagBYCUPw@mail.gmail.com>
	<515319D5.20105@wwwdotorg.org>
	<CACRpkdYXVLgCz1Tyu-Ls2V2OTc4R3cGNJhfQJB6Hiz_K9dkZYQ@mail.gmail.com>
	<5155C902.7080207@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:51482 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935980Ab3DJSMz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Apr 2013 14:12:55 -0400
Received: by mail-ie0-f169.google.com with SMTP id ar20so528596iec.0
        for <linux-omap@vger.kernel.org>; Wed, 10 Apr 2013 11:12:55 -0700 (PDT)
In-Reply-To: <5155C902.7080207@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Jon Hunter <jon-hunter@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Alexandre Courbot <acourbot@nvidia.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, Stephen Warren <swarren@nvidia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Mar 29, 2013 at 6:01 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 03/27/2013 02:55 PM, Linus Walleij wrote:
>> On Wed, Mar 27, 2013 at 5:09 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>
>> This is the case for some SMSC911x clients like the snowball
>> routing it to a GPIO, whereas I think the RealView and Integrator/CP
>> has a dedicated IRQ line for it on the FPGA so it's a good example.
>>
>> In such cases the right thing to do is for the platform
>> code populating the platform data with the int irq field, or device tree
>> core, or whatever piece of code that knows about
>> the actual GPIO shall start from the GPIO, request it and
>> then convert it to an IRQ.
>
> So board code could easily do that; plenty of opportunity to put
> whatever custom code is needed right there.
>
> For DT core code to do that, we'd need some alternative way of
> specifying interrupts. That would change the DT bindings for interrupts.
> I don't think we can do that...

Sorry, I'm probably not knowledgeable about DT to understand this.
The information for what GPIO corresponds to what IRQ is
present in the device tree, is it not?

If the information is there, whether to convert from IRQ to GPIO
or from GPIO to IRQ is a technicality and any order should be
feasible in some way?

I just can't get the necessity to do it one way preferred over the
other through my head, sorry...

>> If it seems like identical boilerplate in every machine we can
>> simply centralize it to gpiolib. Something like
>>
>> int gpio_add_single_irq_resource(struct platform_device *pdev, int
>> gpio, unsigned flags)
> ... [code to convert GPIO to IRQ and create IORESOURCE_IRQ from it]
>
>> int gpio_populate_irq_resource(struct platform_device *pdev, int gpio,
>>                               unsigned flags, struct resource *r)
> ... [code to create IORESOURCE_IRQ from the IRQ]
>
> ...
>> gpio_populate_irq_resource(&ethernet, 17,
>>      IORESOURCE_IRQ_HIGHEDGE, &ethernet_res[1]);
>> platform_device_register(&ethernet);
>>
>> That populates the device with the single GPIO IRQ from
>> the GPIO number in a smooth way.
>>
>> Of course it has to be done after the GPIO driver is up
>> and running so may require some other refactoring,
>> but it should work.
>
> That latter issue also somewhat scuppers this approach; then you have to
> somehow run a bunch of your board file code inter-mixed with various
> driver probe() calls. That will quickly get nasy.

No, just use a module_init() for the above code in the board
file and it will defer just like any other initcall.

> And it doesn't address how the DT core will know when to call
> gpio_add_single_irq_resource() vs. gpio_populate_irq_resource() without
> changing the DT binding for interrupts.

Is it not possible to do this in
drivers/gpio/gpiolib-of.c: of_gpiochip_add(), if the DT *know*
which GPIOs will be used as plain IRQs? That is the point with
the gpio hogs I talk about ...

GPIO hogs would hog input pins here and immediately
call gpio_to_irq() on them, and from that point on they can
only be used for input, and only for generating IRQs.

>>> And then, given that irq_to_gpio() isn't semantically possible, there's
>>> no way for the driver to be able to gpio_request() anything, since it
>>> doesn't, can't, and shouldn't know whether there is in fact any GPIO ID
>>> that it should request, let alone what that GPIO ID is.
>>
>> That's cool. The driver does not have to know the IRQ is backed by a
>> GPIO, but somewhere in the system something should know this.
>
> Something already does; the irqchip driver for the IRQ in question would
> always know whether it's programming a plain IRQ controller, or an IRQ
> controller that's part of a GPIO controller. In the GPIO case, the
> irqchip driver also has enought HW-specific information to perform
> whatever GPIO<->IRQ number conversion is needed.

So I'm opposed to doing these things both ways because
I think it's getting messy. We have already has irq_to_gpio()
cause problems in the past and this reminds me heavily
about that.

> Or, were you thinking of creating some kind of hogging system for
> gpiolib itself?

Yes.

Yours,
Linus Walleij
