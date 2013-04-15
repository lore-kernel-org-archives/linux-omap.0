From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Mon, 15 Apr 2013 10:58:43 -0600
Message-ID: <516C31C3.9040505@wwwdotorg.org>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com> <20130302200524.D230F3E1571@localhost> <51391F41.5000303@ti.com> <CAAwP0s1CFRO-rf==p5sYs1n0gigMif7wuT8Yv0N_iLUDMrtcOg@mail.gmail.com> <CACRpkdYHj-rEF3Rk_CWnmmMw_Amr7m8SgQ=-2zsDYuLeuu3azw@mail.gmail.com> <514C79E1.4090106@wwwdotorg.org> <514CE0AB.6060207@ti.com> <CACRpkdZmv-rAoKSQYpkHHSMzKJOn5TixVW_P3=m7ZNagBYCUPw@mail.gmail.com> <515319D5.20105@wwwdotorg.org> <CACRpkdYXVLgCz1Tyu-Ls2V2OTc4R3cGNJhfQJB6Hiz_K9dkZYQ@mail.gmail.com> <5155C902.7080207@wwwdotorg.org> <CACRpkdYbs4-uudpRUY8e+7icYYkZrfM0kReP3pLL5DMiURJ4dg@mail.gmail.com> <5165CB9D.1090202@wwwdotorg.org> <CACRpkdYirFNqmGhA4K9CL4ve4NYhs8Rd3SFt1iwW9vHBkrcz8g@mail.gmail.com> <51671D7B.5060303@wwwdotorg.org> <CACRpkdbf32Ef77GmXk9id9+RRjcDRTr7S+F4nznoeZU8y=BT_Q@mail.gmail.com
 > <51673D70.3010503@wwwdotorg.org> <CAAwP0s0e2x33jZQhFRY+Hoo61SFqYKRgWk=1mL2+DNxSDJHz+A@mail.gmail.com> <CACRpkda4h+qXTvsirPAS7E7sjXhMLE62q=VDy53W8UchsYjbNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:37335 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933415Ab3DOQ6s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Apr 2013 12:58:48 -0400
In-Reply-To: <CACRpkda4h+qXTvsirPAS7E7sjXhMLE62q=VDy53W8UchsYjbNg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, Jon Hunter <jon-hunter@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Alexandre Courbot <acourbot@nvidia.com>, Stephen Warren <swarren@nvidia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 04/14/2013 02:53 PM, Linus Walleij wrote:
> On Sun, Apr 14, 2013 at 3:35 AM, Javier Martinez Canillas
> <martinez.javier@gmail.com> wrote:
> 
>> Is the following inlined patch [1] what you were thinking that would
>> be the right approach?
> 
> This looks sort of OK, but I'm still struggling with the question of
> what we could do to help other implementations facing the same issue.
> 
> This is a pretty hard design pattern to properly replicate in every such
> driver is it not?

Well, instead of adding .request_irq() to the irqchip, and then making
each driver call gpio_request() from the implementation, perhaps you
could add a .irq_to_gpio() to the irqchip, have the IRQ core call that,
and if it gets back a non-error response, the IRQ core could call
gpio_request(). That means that the change to each GPIO+IRQ driver is
simply to implement a standalone data transformation function
.irq_to_gpio().

Now, this does re-introduce irq_to_gpio() in some way, but with the
following advantages:

1) The implementation is per-controller, not a single global function,
so isn't introducing any kind of centralized mapping scheme again.

2) This irq-chip-specific .irq_to_gpio() would only be implemented for
IRQ+GPIO chips that actually have a 1:1 mapping between GPIOs and IRQs.
Its potential existence doesn't imply that all IRQ chips need implement
this; it would be very specifically be for this one particular case.

So, I think it's reasonable to introduce this.
