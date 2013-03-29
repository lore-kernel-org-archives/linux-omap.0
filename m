From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Fri, 29 Mar 2013 11:01:54 -0600
Message-ID: <5155C902.7080207@wwwdotorg.org>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com> <1329321854-24490-4-git-send-email-b-cousson@ti.com> <4F44FA56.7020000@gmail.com> <4F44FC37.2000701@ti.com> <4F452484.5080503@gmail.com> <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC6C1@HQMAIL01.nvidia.com> <4F47AD08.4030504@ti.com> <CAAwP0s0cB368R2mtbJpTZJreR-5GSRLfxC+8DJLo5nw3_OwBuA@mail.gmail.com> <512D39DA.7020306@ti.com> <512D3AB1.1080202@wwwdotorg.org> <512D3EC2.6050408@ti.com> <20130302200524.D230F3E1571@localhost> <51391F41.5000303@ti.com> <CAAwP0s1CFRO-rf==p5sYs1n0gigMif7wuT8Yv0N_iLUDMrtcOg@mail.gmail.com> <CACRpkdYHj-rEF3Rk_CWnmmMw_Amr7m8SgQ=-2zsDYuLeuu3azw@mail.gmail.com> <514C79E1.4090106@wwwdotorg.org> <514CE0AB.6060207@ti.com> <CACRpkdZmv-rAoKSQYpkHHSMzKJOn5TixVW_P3=m7ZNagBYCUPw@mail.gmail.com> <515319D5.20105@wwwdot
 org.org> <CACRpkdYXVLgCz1Tyu-Ls2V2OTc4R3cGNJhfQJB6Hiz_K9dkZYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:54676 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755253Ab3C2RB6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Mar 2013 13:01:58 -0400
In-Reply-To: <CACRpkdYXVLgCz1Tyu-Ls2V2OTc4R3cGNJhfQJB6Hiz_K9dkZYQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jon Hunter <jon-hunter@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Alexandre Courbot <acourbot@nvidia.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, Stephen Warren <swarren@nvidia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 03/27/2013 02:55 PM, Linus Walleij wrote:
> On Wed, Mar 27, 2013 at 5:09 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> 
>> It's simply that if a device emits an IRQ, there's no reason to assume
>> that the IRQ is in fact a GPIO. It might be a dedicated IRQ input pin
>> and not something that gpiolib (or any other GPIO API) knows about.
> 
> OK (following the first example, that's what I have in the Nomadik
> or Snowball already).
> 
>> Another possibility:
>>
>> (Device IRQ output wired directly into dedicated IRQ input pin, and that
>> pin has no GPIO capabilities)
>>
>> +----------------------------+
>> | SoC                        |         +--------+
>> |      IRQ 5                 | DEV_IRQ | Device |
>> | GIC <----------------------|---------|-IRQ    |
>> |                            |         +--------+
>> +----------------------------+
>>
>> As such, the driver /must/ receive an "int irq" in platform data.
> 
> Nah. Lets pass a struct resource * of type IORESOURCE_IRQ.
> But I understand the necessity to pass the IRQ number somehow.

Oh sure. I tend to consider the resources part of platform data,
although I agree they really aren't.

>> If it
>> received an "int gpio", then there would be no way for the driver to
>> support boards that routed that interrupt signal to a dedicated IRQ pin
>> on the SoC, rather than to a GPIO pin that just happened to have
>> interrupt generation capabilities.
> 
> This is the case for some SMSC911x clients like the snowball
> routing it to a GPIO, whereas I think the RealView and Integrator/CP
> has a dedicated IRQ line for it on the FPGA so it's a good example.
> 
> In such cases the right thing to do is for the platform
> code populating the platform data with the int irq field, or device tree
> core, or whatever piece of code that knows about
> the actual GPIO shall start from the GPIO, request it and
> then convert it to an IRQ.

So board code could easily do that; plenty of opportunity to put
whatever custom code is needed right there.

For DT core code to do that, we'd need some alternative way of
specifying interrupts. That would change the DT bindings for interrupts.
I don't think we can do that...

> If it seems like identical boilerplate in every machine we can
> simply centralize it to gpiolib. Something like
> 
> int gpio_add_single_irq_resource(struct platform_device *pdev, int
> gpio, unsigned flags)
... [code to convert GPIO to IRQ and create IORESOURCE_IRQ from it]

> int gpio_populate_irq_resource(struct platform_device *pdev, int gpio,
>                               unsigned flags, struct resource *r)
... [code to create IORESOURCE_IRQ from the IRQ]

...
> gpio_populate_irq_resource(&ethernet, 17,
>      IORESOURCE_IRQ_HIGHEDGE, &ethernet_res[1]);
> platform_device_register(&ethernet);
> 
> That populates the device with the single GPIO IRQ from
> the GPIO number in a smooth way.
> 
> Of course it has to be done after the GPIO driver is up
> and running so may require some other refactoring,
> but it should work.

That latter issue also somewhat scuppers this approach; then you have to
somehow run a bunch of your board file code inter-mixed with various
driver probe() calls. That will quickly get nasy.

And it doesn't address how the DT core will know when to call
gpio_add_single_irq_resource() vs. gpio_populate_irq_resource() without
changing the DT binding for interrupts.

>> And then, given that irq_to_gpio() isn't semantically possible, there's
>> no way for the driver to be able to gpio_request() anything, since it
>> doesn't, can't, and shouldn't know whether there is in fact any GPIO ID
>> that it should request, let alone what that GPIO ID is.
> 
> That's cool. The driver does not have to know the IRQ is backed by a
> GPIO, but somewhere in the system something should know this.

Something already does; the irqchip driver for the IRQ in question would
always know whether it's programming a plain IRQ controller, or an IRQ
controller that's part of a GPIO controller. In the GPIO case, the
irqchip driver also has enought HW-specific information to perform
whatever GPIO<->IRQ number conversion is needed.

> Such as board code or DT core (I'm thinking drivers/of/platform.c code
> calling gpiolib-of.c to do this mapping for DT, for example).
> 
> And by introducing the requirement that such GPIO lines be
> GPIO input hogs in the device tree else warn we can get a nice
> closure in the DT case: the GPIO subsystem knows the actual
> GPIO line as a hog that is request and sets as input at probe,
> the referencing device node only gets the IRQ but at runtime
> the device node instatiation for the IRQ consumer will ask
> the gpiolib to check its hog list to make sure one of these will
> match that IRQ, then request it.

"Hogs" sounds like pinctrl. pinctrl doesn't support the concept of hogs
on GPIOs, since it only knows about pins not GPIOs really; even with the
integration with gpiolib, pinctrl gets informed when GPIOs are
requested, not when setting up pinctrl states ahead of time, and also
this notification is only so we can mark the pin related to the GPIO
in-use, not really to actually hog it. If pinctrl started hogging GPIOs,
I think me might end up with both pinctrl and gpiolib calling
each-other, and hence have nasty circular dependencies.

Or, were you thinking of creating some kind of hogging system for
gpiolib itself?
