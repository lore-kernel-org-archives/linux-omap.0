From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: omap: IORESOURCE_IRQ flags not set when defining a GPIO-IRQ
	from DT
Date: Fri, 1 Mar 2013 17:30:01 +0000
Message-ID: <20130301173001.GC30923@n2100.arm.linux.org.uk>
References: <CAAwP0s3ZzGf+_diZiQ7DSfWj74Sh=E9F+j=4UGnw8meHDR2AZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52503 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100Ab3CARdY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Mar 2013 12:33:24 -0500
Content-Disposition: inline
In-Reply-To: <CAAwP0s3ZzGf+_diZiQ7DSfWj74Sh=E9F+j=4UGnw8meHDR2AZQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Jon Hunter <jon-hunter@ti.com>, Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Grant Likely <grant.likely@secretlab.ca>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Mar 01, 2013 at 05:17:57PM +0100, Javier Martinez Canillas wrote:
> >> unsigned long irq_flags = SMC_IRQ_FLAGS;
> >> ...
> >>        if (irq_flags == -1 || ires->flags & IRQF_TRIGGER_MASK)
> >>                 irq_flags = ires->flags & IRQF_TRIGGER_MASK;
> >>
> >> while smsc911x driver's probe function uses the flags from the
> >> resource unconditionally:
> >>
> >> irq_flags = irq_res->flags & IRQF_TRIGGER_MASK;
> >>
> >> So, at the end both will set irq_flags to whatever is on the
> >> IORESOURCE_IRQ struct resource flags member.
> >
> > Actually, that's not the case for smc91x. By default SMC_IRQ_FLAGS != -1
> > (for omap) and so it will not set irq_flags to ires->flags &
> > IRQF_TRIGGER_MASK. However, if I force irq_flags to be -1, then I see
> > that irq_flags are to 0.

smc91x is complicated by the fact that it started off life before there
was any possibility to pass IRQ flags through resources.  So we ended
up with smc91x.h containing _lots_ of platform specific data, and the
driver could only be built for one platform.

I fixed that by sorting out this IRQ passing method, and changing smc91x
to support both the fixed configuration, and the dynamic-through-IRQflags
method.

There is no reason for any other driver to support the fixed method; that
would be a completely backwards step.
