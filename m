From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Thu, 28 Feb 2013 13:17:39 +0100
Message-ID: <CAAwP0s0ncaZx4F6KuLGihyrykRssyFtb5euCNRutriANH=z4Ng@mail.gmail.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
 <1329321854-24490-4-git-send-email-b-cousson@ti.com> <4F44FA56.7020000@gmail.com>
 <4F44FC37.2000701@ti.com> <4F452484.5080503@gmail.com> <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC6C1@HQMAIL01.nvidia.com>
 <4F47AD08.4030504@ti.com> <CAAwP0s0cB368R2mtbJpTZJreR-5GSRLfxC+8DJLo5nw3_OwBuA@mail.gmail.com>
 <512D39DA.7020306@ti.com> <512D3AB1.1080202@wwwdotorg.org>
 <512D3EC2.6050408@ti.com> <512D3FE6.1010300@wwwdotorg.org>
 <512D490B.70900@ti.com> <512D4FC4.2060505@wwwdotorg.org> <512D5C58.4090500@ti.com>
 <CAAwP0s3rbExrSf-W325uCPfMO=Zk9LefRP0VD4JC1tg_sxS_gQ@mail.gmail.com> <512E93B9.8020806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f182.google.com ([209.85.210.182]:43178 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442Ab3B1MSA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Feb 2013 07:18:00 -0500
Received: by mail-ia0-f182.google.com with SMTP id k38so1451537iah.13
        for <linux-omap@vger.kernel.org>; Thu, 28 Feb 2013 04:17:59 -0800 (PST)
In-Reply-To: <512E93B9.8020806@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren <swarren@nvidia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>

On Thu, Feb 28, 2013 at 12:16 AM, Jon Hunter <jon-hunter@ti.com> wrote:
>
> On 02/26/2013 09:57 PM, Javier Martinez Canillas wrote:
>
> [snip]
>
>> Something like that would definitely solve the GPIO request issue but
>> we still have the issue that the current OMAP GPIO controller binding
>> does not support #interrupt-cells = <2>.
>>
>> So, we can't pass the trigger type and level flags for an IRQ-GPIO
>> when using an GPIO controller as the interrupt-parent for a device
>> node.
>>
>> Do you have any comments on that issue?
>
> Can you elaborate a bit more on why you say this is not supported?
>
> I have been playing with this today on an omap board and if I set the
> #interrupt-cells = <2>, then I do see that irq_domain_xlate_onetwocell()
> is called and the irq number and flags read as expected. Following which
> I then see it will call the omap_irq_type() to set type. So AFAICT it works.
>

Yes, it does.

I (wrongly) assumed that it was not working since the GPIO OMAP
binding documentation says that #interrupt-cells should be <2> but all
OMAP2+ DTs use <1> instead. Also, when trying to change to <2> I had
the kernel hang.

But it was indeed that the GPIO bank was not enabled before calling
gpio_irq_type() and this made the kernel to hang. Your patch fixed the
issue and allowed me to find the cause.

The problem was that when using the DT hack of defining the GPIO in
the ethernet chip regulator,  the calls to
irq_domain_xlate_onetwocell() and gpio_irq_type() were made before the
call to gpio_request_one() so the GPIO bank was not enabled.

If gpio_request() is called in gpmc_probe_dt(), then the GPIO bank is
enabled and gpio_irq_type() succeeds.

So, it was just me being stupid and don't understanding the implementation.

> Please note I do see that when the SMC driver calls request_irq() in
> smc_drv_probe() it is also settings the trigger type to
> IRQ_TYPE_EDGE_RISING (default). So if you are setting to low-level
> sensitive in DT, then this is being overwritten. We could fix this by
> setting SMC_IRQ_FLAGS to -1 for OMAP.
>

Please note that I'm using a SMSC 911x chip and not a SMSC 91x, so the
driver is not smc91x but smc911x. It has the same behaviour though
(IRQ flags overwritten somehow), just to be sure that we are on the
same page.

I don't know if just setting SMC_IRQ_FLAGS to -1 will be enough to fix
the smc91x since request_irq() is just passing whatever value is in
irq_flags.

By looking at the two drivers (smc91x and smsc911x) it seems that the
only difference on how they manage the flags is that smc91x does:

unsigned long irq_flags = SMC_IRQ_FLAGS;
...
       if (irq_flags == -1 || ires->flags & IRQF_TRIGGER_MASK)
                irq_flags = ires->flags & IRQF_TRIGGER_MASK;

while smsc911x driver's probe function uses the flags from the
resource unconditionally:

irq_flags = irq_res->flags & IRQF_TRIGGER_MASK;

So, at the end both will set irq_flags to whatever is on the
IORESOURCE_IRQ struct resource flags member.

The real problem is irq_flags to be 0 instead of the value defined on
the second cell of the "interrupts" property.

when irq_domain_xlate_onetwocell() is called for the ethernet GPIO-IRQ
I see that both the cells size and the second cell with the flag
values are set correctly (2 and IRQF_TRIGGER_LOW).

But even when gpio_irq_type() succeeds it seems that the struct
resource IRQ flags passed to the smsc911x driver is still overwritten
or not set correctly since flags & IRQF_TRIGGER_MASK is always 0.

> In general we do need to fix the gpio binding for omap to default to
> #interrupt-cell = <2>, as this should work. However, before we can do
> that we need to fix the issue of ensuring the gpio module is enabled if
> being used as an interrupt source without having to call gpio_request()
> first.
>

Indeed, although I still wonder why the flags are not set correctly
for the smsc911x driver.

I had only tested it with this device so I don't know if this is a
general issue of IORESOURCE_IRQ structs not been initialized correctly
when using GPIOs as IRQ on OMAP or if is only related to this driver.

> We should probably add the following patch as well to avoid any hangs if
> the bank is not enabled, when omap_irq_type is called.
>
> commit 5e298de564e09f5ca4148a9bc0ed5d16b4742f14
> Author: Jon Hunter <jon-hunter@ti.com>
> Date:   Wed Feb 27 17:14:11 2013 -0600
>
>     gpio/omap: warn if gpio bank is not enabled on setting irq type
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index f1fbedb2..cbdc796 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -421,6 +421,9 @@ static int gpio_irq_type(struct irq_data *d,
> unsigned type)
>         int retval;
>         unsigned long flags;
>
> +       if (WARN_ON(!bank->mod_usage))
> +               return -EINVAL;
> +
>  #ifdef CONFIG_ARCH_OMAP1
>         if (d->irq > IH_MPUIO_BASE)
>                 gpio = OMAP_MPUIO(d->irq - IH_MPUIO_BASE);
>
>
> Cheers
> Jon
>
>

Thanks a lot for your help and best regards,
Javier
