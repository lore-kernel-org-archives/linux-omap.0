From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Tue, 11 Jun 2013 22:25:49 +0100
Message-ID: <20130611212550.03A823E0D8D@localhost>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com> <515319D5.20105@wwwdotorg.org> <CACRpkdYXVLgCz1Tyu-Ls2V2OTc4R3cGNJhfQJB6Hiz_K9dkZYQ@mail.gmail.com> <5155C902.7080207@wwwdotorg.org> <CACRpkdYbs4-uudpRUY8e+7icYYkZrfM0kReP3pLL5DMiURJ4dg@mail.gmail.com> <5165CB9D.1090202@wwwdotorg.org> <CACRpkdYirFNqmGhA4K9CL4ve4NYhs8Rd3SFt1iwW9vHBkrcz8g@mail.gmail.com> <51671D7B.5060303@wwwdotorg.org> <CACRpkdbf32Ef77GmXk9id9+RRjcDRTr7S+F4nznoeZU8y=BT_Q@mail.gmail.com> <51673D70.3010503@wwwdotorg.org> <CAAwP0s0e2x33jZQhFRY+Hoo61SFqYKRgWk=1mL2+DNxSDJHz+A@mail.gmail.com> <CACRpkda4h+qXTvsirPAS7E7sjXhMLE62q=VDy53W8UchsYjbNg@mail.gmail.com> <516C31C3.9040505@wwwdotorg.org> <516C7C43.3040105@wwwdotorg.org> <516C8760.2050500@ti.com> <516D9B05.1000501@wwwdotorg.org> <516DA60A.5070000@ti.com> <516DCC
 A8.3070108@wwwdotorg.org> <516DDB4D.9020500@ti.com> <CAAwP0s0-VNUoeSKaGbvoDeD7m7kZRdp5rCJ7iVpFoFAaQtXcmQ@mail.gmail.com> <CACRpkdaA_7Feuui-S65m--2FfvpoUkfn6b9SoWavAstZUS23ag@mail.gmail.com> <517AF22
 C.9090901@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38772 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754379Ab3FKVZz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Jun 2013 17:25:55 -0400
Received: by mail-wi0-f174.google.com with SMTP id k10so4470924wiv.13
        for <linux-omap@vger.kernel.org>; Tue, 11 Jun 2013 14:25:54 -0700 (PDT)
In-Reply-To: <517AF22C.9090901@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <acourbot@nvidia.com>, Stephen Warren <swarren@nvidia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, 26 Apr 2013 16:31:24 -0500, Jon Hunter <jon-hunter@ti.com> wrote:
> 
> On 04/26/2013 02:31 AM, Linus Walleij wrote:
> > On Wed, Apr 17, 2013 at 2:41 AM, Javier Martinez Canillas
> > <martinez.javier@gmail.com> wrote:
> > 
> > So:
> > 
> >> +static int omap_gpio_irq_domain_xlate(struct irq_domain *d,
> >> +                                     struct device_node *ctrlr,
> >> +                                     const u32 *intspec, unsigned int intsize,
> >> +                                     irq_hw_number_t *out_hwirq,
> >> +                                     unsigned int *out_type)
> >> +{
> >> +       int ret;
> >> +       struct gpio_bank *bank = d->host_data;
> >> +       int gpio = bank->chip.base + intspec[0];
> >> +
> >> +       if (WARN_ON(intsize < 2))
> >> +               return -EINVAL;
> >> +
> >> +       ret = gpio_request_one(gpio, GPIOF_IN, ctrlr->full_name);
> >> +       if (ret)
> >> +               return ret;
> > 
> > So how to figure out if a device is already requesting this GPIO
> > on some orthogonal axis?
> 
> I really don't think that is necessary. Hopefully, my other email [1]
> elaborates on why. Let me know if this makes sense.

I would agree here. If the irq specified happens to be a GPIO; then the
onus is on the GPIO/IRQ controller driver to make sure that GPIO is
actually set up to work as an IRQ.

g.

