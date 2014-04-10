From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 4/5] gpio: omap: convert driver to use gpiolib irqchip
Date: Thu, 10 Apr 2014 20:58:31 +0200
Message-ID: <CABxcv=ktiH346PBueYKtitKWVXznjdYOJe=qvOfxfT37MTL_Kw@mail.gmail.com>
References: <1396796297-13002-1-git-send-email-javier.martinez@collabora.co.uk>
	<1396796297-13002-5-git-send-email-javier.martinez@collabora.co.uk>
	<5346D758.5020103@ti.com>
	<CACRpkdazRZvNwZcdkn1EQpv7PEGv83pL+yaFRHA8z0SSXw2gkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:50939 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934295AbaDJS6d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Apr 2014 14:58:33 -0400
Received: by mail-wg0-f43.google.com with SMTP id x13so4359830wgg.2
        for <linux-omap@vger.kernel.org>; Thu, 10 Apr 2014 11:58:31 -0700 (PDT)
In-Reply-To: <CACRpkdazRZvNwZcdkn1EQpv7PEGv83pL+yaFRHA8z0SSXw2gkg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hello Linus and Santosh,

On Thu, Apr 10, 2014 at 7:45 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Apr 10, 2014 at 7:39 PM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
>> On Sunday 06 April 2014 10:58 AM, Javier Martinez Canillas wrote:
>
>>> +#ifdef CONFIG_ARCH_OMAP1
>>> +     /*
>>> +      * REVISIT: Once we have OMAP1 supporting SPARSE_IRQ, we can drop
>>> +      * irq_alloc_descs() since a base IRQ offset will no longer be needed.
>>> +      */
>>> +     irq_base = irq_alloc_descs(-1, 0, bank->width, 0);
>>> +     if (irq_base < 0) {
>>> +             dev_err(bank->dev, "Couldn't allocate IRQ numbers\n");
>>> +             return -ENODEV;
>>> +     }
>>> +#endif
>>> +
>> Do we still need above after first patch ? Would be good
>> to get rid of above ugly #ifdef on the middle of the code.

When working on this series I tried to remove the #ifdef but as far as
I understood is not currently possible until OMAP1 supports sparse irq
numbering.

Not so long ago the GPIO OMAP driver used the legacy domain mapping
for all OMAP SoCs and Jon Hunter converted to use linear domain
mapping on commit ede4d7a ("gpio/omap: convert gpio irq domain to
linear mapping").

Unfortunately that change caused a regression on OMAP1 platforms as
reported by Aaro [0] so I had to partially revert the linear domain
mapping for OMAP1 platforms on commit 397ead ("gpio/omap: don't use
linear domain mapping for OMAP1") introducing this ugly ifdefery in
the middle of the code.

>
> I don't think so actually, simple irqdomain adds descriptors
> for irqbase != 0, and the gpiochip irqchip helpers call
> irq_create_mapping() on all offsets.
>

Looking at irq_domain_add_simple() [1] I see that it only calls
irq_alloc_descs() and irq_domain_associate_many() if first_irq > 0 and
CONFIG_SPARSE_IRQ is enabled (which is not the case for
omap1_defconfig).

So, if I got this correctly removing the #ifdef for OMAP1 and calling
irq_domain_add_simple() is functionally equivalent to what Jon's patch
did that broke omap1. That is would have the same effect that just
calling irq_domain_add_linear() [2] for OMAP1.

> Preferably a separate patch on top of this removing that code
> though so it's bisectable.
>

If I remember correctly we did that partial revert because we were in
a -rc cycle and I didn't have time to investigate why
irq_domain_add_linear() does not work on omap1. I could try to do this
as a follow up patch but unfortunately I don't have access to any
omap1 platform to do further debug.

Please let me know if I got something wrong while looking at the code.

> Yours,
> Linus Walleij
> --

Thanks a lot and best regards,
Javier

[0]: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg89005.html
[1]: http://lxr.free-electrons.com/source/kernel/irq/irqdomain.c#L123
[2]: http://lxr.free-electrons.com/source/include/linux/irqdomain.h#L139
