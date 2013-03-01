From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: omap: IORESOURCE_IRQ flags not set when defining a GPIO-IRQ from
 DT
Date: Fri, 1 Mar 2013 16:41:37 -0600
Message-ID: <51312EA1.8000600@ti.com>
References: <CAAwP0s3ZzGf+_diZiQ7DSfWj74Sh=E9F+j=4UGnw8meHDR2AZQ@mail.gmail.com> <20130301173001.GC30923@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49973 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223Ab3CAWl6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Mar 2013 17:41:58 -0500
In-Reply-To: <20130301173001.GC30923@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Grant Likely <grant.likely@secretlab.ca>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


On 03/01/2013 11:30 AM, Russell King - ARM Linux wrote:
> On Fri, Mar 01, 2013 at 05:17:57PM +0100, Javier Martinez Canillas wrote:
>>>> unsigned long irq_flags = SMC_IRQ_FLAGS;
>>>> ...
>>>>        if (irq_flags == -1 || ires->flags & IRQF_TRIGGER_MASK)
>>>>                 irq_flags = ires->flags & IRQF_TRIGGER_MASK;
>>>>
>>>> while smsc911x driver's probe function uses the flags from the
>>>> resource unconditionally:
>>>>
>>>> irq_flags = irq_res->flags & IRQF_TRIGGER_MASK;
>>>>
>>>> So, at the end both will set irq_flags to whatever is on the
>>>> IORESOURCE_IRQ struct resource flags member.
>>>
>>> Actually, that's not the case for smc91x. By default SMC_IRQ_FLAGS != -1
>>> (for omap) and so it will not set irq_flags to ires->flags &
>>> IRQF_TRIGGER_MASK. However, if I force irq_flags to be -1, then I see
>>> that irq_flags are to 0.
> 
> smc91x is complicated by the fact that it started off life before there
> was any possibility to pass IRQ flags through resources.  So we ended
> up with smc91x.h containing _lots_ of platform specific data, and the
> driver could only be built for one platform.
> 
> I fixed that by sorting out this IRQ passing method, and changing smc91x
> to support both the fixed configuration, and the dynamic-through-IRQflags
> method.
> 
> There is no reason for any other driver to support the fixed method; that
> would be a completely backwards step.

Thanks for the history. For OMAP I see SMC_IRQ_FLAGS getting defined as
follows in smc91x.h ...

#ifndef SMC_IRQ_FLAGS
#define SMC_IRQ_FLAGS           IRQF_TRIGGER_RISING
#endif

And so for OMAP devices using smc91x, it is always being configured as
rising-edge. So it would be good to move OMAP to use a dynamic
configuration too.

Cheers
Jon
