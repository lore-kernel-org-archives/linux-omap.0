From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Fri, 12 Apr 2013 00:16:55 +0200
Message-ID: <CACRpkdbf32Ef77GmXk9id9+RRjcDRTr7S+F4nznoeZU8y=BT_Q@mail.gmail.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
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
	<CACRpkdYbs4-uudpRUY8e+7icYYkZrfM0kReP3pLL5DMiURJ4dg@mail.gmail.com>
	<5165CB9D.1090202@wwwdotorg.org>
	<CACRpkdYirFNqmGhA4K9CL4ve4NYhs8Rd3SFt1iwW9vHBkrcz8g@mail.gmail.com>
	<51671D7B.5060303@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f179.google.com ([209.85.210.179]:39737 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754731Ab3DKWQ4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Apr 2013 18:16:56 -0400
Received: by mail-ia0-f179.google.com with SMTP id l25so1856750iad.38
        for <linux-omap@vger.kernel.org>; Thu, 11 Apr 2013 15:16:55 -0700 (PDT)
In-Reply-To: <51671D7B.5060303@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Jon Hunter <jon-hunter@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Alexandre Courbot <acourbot@nvidia.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, Stephen Warren <swarren@nvidia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Apr 11, 2013 at 10:30 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 04/10/2013 03:28 PM, Linus Walleij wrote:

>> So the only reason I'm rambing on about this is that it breaks the
>
> I'm not sure I understand this paragraph; what is "it" in the line above.
>
> If "it" is this patch, then should "breaks" be re-establishes?

No I'm replying to Javier Martinez Canillas mail in this thread:
http://marc.info/?l=linux-arm-kernel&m=136334655902407&w=2
which is stating a question to grand, and contains the below
hunk:

> +static int gpio_irq_request(struct irq_data *d)
> +{
> +       struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
> +
> +       return gpio_request(irq_to_gpio(bank, d->irq), "gpio-irq");
> +}

irq_to_gpio(). Notice that. not my_funny_driver_irq_to_gpio().

It's the same thing you mention below:

> If I recall the patch I'm replying to correctly, the idea was to add an
> "IRQ request" operation that would (internally to the GPIO/IRQ driver
> itself) map IRQ->GPIO, and call gpio_request(). That would then prevent
> exactly the situation you mention above.

So the above does not look like it's internal to the driver does it?

I think this is irq_to_gpio sneaking back in, and requiring that every
driver of this sort follow the same design pattern. And then maybe
you see my persistance ... are we talking about different things?

So I'd be happy with something local to the driver, foo_irq_to_gpio()
and that we also back out a bit and see what the subsystem can do
to avoid this kind of code having to be duplicated everywhere, that's
all.

Yours,
Linus Walleij
