From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Fri, 26 Apr 2013 08:59:20 +0200
Message-ID: <CACRpkdZNvTtjto+kpNOvFK-RZb_N8x04=8b-3ZJdO2bnYaBPvQ@mail.gmail.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
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
	<CACRpkdbf32Ef77GmXk9id9+RRjcDRTr7S+F4nznoeZU8y=BT_Q@mail.gmail.com>
	<51673D70.3010503@wwwdotorg.org>
	<CAAwP0s0e2x33jZQhFRY+Hoo61SFqYKRgWk=1mL2+DNxSDJHz+A@mail.gmail.com>
	<CACRpkda4h+qXTvsirPAS7E7sjXhMLE62q=VDy53W8UchsYjbNg@mail.gmail.com>
	<516C31C3.9040505@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f177.google.com ([209.85.210.177]:56425 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175Ab3DZG7V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Apr 2013 02:59:21 -0400
Received: by mail-ia0-f177.google.com with SMTP id y26so3425145iab.22
        for <linux-omap@vger.kernel.org>; Thu, 25 Apr 2013 23:59:21 -0700 (PDT)
In-Reply-To: <516C31C3.9040505@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Grant Likely <grant.likely@secretlab.ca>, Thomas Gleixner <tglx@linutronix.de>
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, Jon Hunter <jon-hunter@ti.com>, Alexandre Courbot <acourbot@nvidia.com>, Stephen Warren <swarren@nvidia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Apr 15, 2013 at 6:58 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 04/14/2013 02:53 PM, Linus Walleij wrote:

>> This is a pretty hard design pattern to properly replicate in every such
>> driver is it not?
>
> Well, instead of adding .request_irq() to the irqchip, and then making
> each driver call gpio_request() from the implementation, perhaps you
> could add a .irq_to_gpio() to the irqchip, have the IRQ core call that,
> and if it gets back a non-error response, the IRQ core could call
> gpio_request(). That means that the change to each GPIO+IRQ driver is
> simply to implement a standalone data transformation function
> .irq_to_gpio().
>
> Now, this does re-introduce irq_to_gpio() in some way, but with the
> following advantages:
>
> 1) The implementation is per-controller, not a single global function,
> so isn't introducing any kind of centralized mapping scheme again.
>
> 2) This irq-chip-specific .irq_to_gpio() would only be implemented for
> IRQ+GPIO chips that actually have a 1:1 mapping between GPIOs and IRQs.
> Its potential existence doesn't imply that all IRQ chips need implement
> this; it would be very specifically be for this one particular case.

I sort of like the idea. It'd have to go past Grant and Thomas G though.

A problem is that this will result in the same kind of dilemma that
the pinctrl subsystem has been facing with mapping the global GPIO
numbers back into local numbers (as is the nature of IRQ numbers).
Such as is done by the GPIO ranges in pinctrl.

The good part is that we now know how to actually contain that, even
how to do it in DT.

Yours,
Linus Walleij
