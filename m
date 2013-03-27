From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Wed, 27 Mar 2013 21:55:47 +0100
Message-ID: <CACRpkdYXVLgCz1Tyu-Ls2V2OTc4R3cGNJhfQJB6Hiz_K9dkZYQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f179.google.com ([209.85.210.179]:55251 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab3C0Uzs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Mar 2013 16:55:48 -0400
Received: by mail-ia0-f179.google.com with SMTP id x24so7649115iak.38
        for <linux-omap@vger.kernel.org>; Wed, 27 Mar 2013 13:55:48 -0700 (PDT)
In-Reply-To: <515319D5.20105@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Jon Hunter <jon-hunter@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Alexandre Courbot <acourbot@nvidia.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, Stephen Warren <swarren@nvidia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Mar 27, 2013 at 5:09 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> It's simply that if a device emits an IRQ, there's no reason to assume
> that the IRQ is in fact a GPIO. It might be a dedicated IRQ input pin
> and not something that gpiolib (or any other GPIO API) knows about.

OK (following the first example, that's what I have in the Nomadik
or Snowball already).

> Another possibility:
>
> (Device IRQ output wired directly into dedicated IRQ input pin, and that
> pin has no GPIO capabilities)
>
> +----------------------------+
> | SoC                        |         +--------+
> |      IRQ 5                 | DEV_IRQ | Device |
> | GIC <----------------------|---------|-IRQ    |
> |                            |         +--------+
> +----------------------------+
>
> As such, the driver /must/ receive an "int irq" in platform data.

Nah. Lets pass a struct resource * of type IORESOURCE_IRQ.
But I understand the necessity to pass the IRQ number somehow.

> If it
> received an "int gpio", then there would be no way for the driver to
> support boards that routed that interrupt signal to a dedicated IRQ pin
> on the SoC, rather than to a GPIO pin that just happened to have
> interrupt generation capabilities.

This is the case for some SMSC911x clients like the snowball
routing it to a GPIO, whereas I think the RealView and Integrator/CP
has a dedicated IRQ line for it on the FPGA so it's a good example.

In such cases the right thing to do is for the platform
code populating the platform data with the int irq field, or device tree
core, or whatever piece of code that knows about
the actual GPIO shall start from the GPIO, request it and
then convert it to an IRQ.

If it seems like identical boilerplate in every machine we can
simply centralize it to gpiolib. Something like

int gpio_add_single_irq_resource(struct platform_device *pdev, int
gpio, unsigned flags)
{
     struct resource *r;
     int irq;
     int err;

     r = devm_kmalloc(&pdev->dev, sizeof(*r), GFP_KERNEL);
     if (!r)
        return -ENOMEM;
     memset(r, 0, sizeof(*r));
     err = request_gpio(gpio);
     if (err)
        return err;
     irq = gpio_to_irq(gpio);
     if (irq < 0)
        return irq;
     r->start = irq;
     r->end = irq;
     r->flags = IORESOURCE_IRQ | flags;
     pdev->num_resources = 1;
     pdev->resource = res;
};

int gpio_populate_irq_resource(struct platform_device *pdev, int gpio,
                              unsigned flags, struct resource *r)
{
     int irq;
     int err;

     err = request_gpio(gpio);
     if (err)
        return err;
     irq = gpio_to_irq(gpio);
     if (irq < 0)
        return irq;
     r->start = irq;
     r->end = irq;
     r->flags = IORESOURCE_IRQ | flags;
};


(Add permutations for either filling in a struct resource *r from
the board code, or krealloc() to extend an existing dynamic allocation
or whatever, surely these helpers can be written.)

So this is for a pure platform data case (based on
arch/arm/mach-ux500/board-mop500.c, which currently
relies on hard-coded GPIO and IRQ numbers):

static struct resource ethernet_res[] = {
        {
                .name = "smsc911x-memory",
                .start = (0x5000 << 16),
                .end  =  (0x5000 << 16) + 0xffff,
                .flags = IORESOURCE_MEM,
        },
        {  }, /* To be filled in with GPIO IRQ */
};

static struct platform_device ethernet = {
        .name           = "smsc911x",
        .dev            = {
                .platform_data = &....,
        },
};

gpio_populate_irq_resource(&ethernet, 17,
     IORESOURCE_IRQ_HIGHEDGE, &ethernet_res[1]);
platform_device_register(&ethernet);

That populates the device with the single GPIO IRQ from
the GPIO number in a smooth way.

Of course it has to be done after the GPIO driver is up
and running so may require some other refactoring,
but it should work.

I can implement this and convert the Snowball if it
helps.

> And then, given that irq_to_gpio() isn't semantically possible, there's
> no way for the driver to be able to gpio_request() anything, since it
> doesn't, can't, and shouldn't know whether there is in fact any GPIO ID
> that it should request, let alone what that GPIO ID is.

That's cool. The driver does not have to know the IRQ is backed by a
GPIO, but somewhere in the system something should know this.
Such as board code or DT core (I'm thinking drivers/of/platform.c code
calling gpiolib-of.c to do this mapping for DT, for example).

And by introducing the requirement that such GPIO lines be
GPIO input hogs in the device tree else warn we can get a nice
closure in the DT case: the GPIO subsystem knows the actual
GPIO line as a hog that is request and sets as input at probe,
the referencing device node only gets the IRQ but at runtime
the device node instatiation for the IRQ consumer will ask
the gpiolib to check its hog list to make sure one of these will
match that IRQ, then request it.

> And finally, even if we ignore dedicated IRQ input pins, and assume that
> every IRQ input is really a GPIO, why should the driver be forced to
> call both request_irq() and gpio_request(); that's something that should
> really be dealt with inside the IRQ subsystem or relevant IRQ driver.
> Otherwise, every other driver that uses IRQs has to be burdened with the
> code to do that.

I agree it need not be in the driver if all it wants is an IRQ.

I was thinking more like the above.

Yours,
Linus Walleij
