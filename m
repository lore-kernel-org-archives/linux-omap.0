From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Fri, 22 Mar 2013 09:10:58 +0100
Message-ID: <CACRpkdYHj-rEF3Rk_CWnmmMw_Amr7m8SgQ=-2zsDYuLeuu3azw@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f181.google.com ([209.85.210.181]:39385 "EHLO
	mail-ia0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933092Ab3CVIK7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Mar 2013 04:10:59 -0400
Received: by mail-ia0-f181.google.com with SMTP id o25so3300954iad.12
        for <linux-omap@vger.kernel.org>; Fri, 22 Mar 2013 01:10:58 -0700 (PDT)
In-Reply-To: <CAAwP0s1CFRO-rf==p5sYs1n0gigMif7wuT8Yv0N_iLUDMrtcOg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Stephen Warren <swarren@nvidia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Mar 15, 2013 at 12:21 PM, Javier Martinez Canillas
<martinez.javier@gmail.com> wrote:

> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 159f5c5..f5feb43 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -807,6 +807,13 @@ static void gpio_unmask_irq(struct irq_data *d)
>         spin_unlock_irqrestore(&bank->lock, flags);
>  }
>
> +static int gpio_irq_request(struct irq_data *d)
> +{
> +       struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
> +
> +       return gpio_request(irq_to_gpio(bank, d->irq), "gpio-irq");
> +}
> +
>  static struct irq_chip gpio_irq_chip = {
>         .name           = "GPIO",
>         .irq_shutdown   = gpio_irq_shutdown,
> @@ -815,6 +822,7 @@ static struct irq_chip gpio_irq_chip = {
>         .irq_unmask     = gpio_unmask_irq,
>         .irq_set_type   = gpio_irq_type,
>         .irq_set_wake   = gpio_wake_enable,
> +       .irq_request    = gpio_irq_request,
>  };

This is just turning everything on it's head. The normal order of things
is this sequence for GPIO 14 something like:

gpio_request(14);
int irq = gpio_to_irq(14);
request_any_context_irq(irq);

I understand that the approach take make things easier for device tree
but it screws up the semantics of the entire kernel (the lockdep etc
warnings are just a symptom), we are locked to the above semantic
sequence: you know the GPIO, *then* you get the IRQ, not the
other way around.

irq_to_gpio has been deemed a legacy thing that we want to get
rid of. The reason being that it is ambiguous on most every GPIO
expander out there. It is not supported by GPIOLIB. This is the
reason to why the implementation in the GPIOLIB in
<linux/gpio.h> looks like this:

static inline int irq_to_gpio(unsigned int irq)
{
        return -EINVAL;
}

The only chance to have the function is in a non-gpiolib platform
that override it.

The irq_to_gpio() in gpio-omap.c overrides this and should
cause compile warnings, does it not?

There is a reason every other driver in drivers/gpio has renamed
this function to things like pxa_irq_to_gpio, msm_irq_to_gpio:
we just don't support it generically.

I know I'm not very helpful, I can just say this is not going to work. :-/

It seems you need a way to get the GPIO corresponding to a certain
IRQ from the device tree, not from the kernel as is done here, then
follow the mentioned sequence.

Yours,
Linus Walleij
