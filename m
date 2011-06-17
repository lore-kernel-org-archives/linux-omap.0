From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v2 14/18] GPIO: OMAP: Fix use of readl/readw to access
 isr_reg
Date: Fri, 17 Jun 2011 10:35:07 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037B9AC55F@dbde02.ent.ti.com>
References: <1308111806-29152-1-git-send-email-tarun.kanti@ti.com>
	<1308111806-29152-5-git-send-email-tarun.kanti@ti.com>
 <871uytmzfx.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60407 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754943Ab1FQFFv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jun 2011 01:05:51 -0400
In-Reply-To: <871uytmzfx.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>

> -----Original Message-----
> From: Hilman, Kevin
> Sent: Thursday, June 16, 2011 11:28 PM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Shilimkar, Santosh; tony@atomide.com
> Subject: Re: [PATCH v2 14/18] GPIO: OMAP: Fix use of readl/readw to access
> isr_reg
> 
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
> 
> > From: Charulatha V <charu@ti.com>
> >
> > In gpio_irq_handler, isr register is always accessed as 32 bit register
> and only
> > for OMAP15xx the first 16 MSBs are masked. Correct this by using the
> appropriate
> > readl/readw registers as per the bank width.
> >
> > Signed-off-by: Charulatha V <charu@ti.com>
> > ---
> >  drivers/gpio/gpio-omap.c |    8 +++++---
> >  1 files changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> > index c6987f2..01b568f 100644
> > --- a/drivers/gpio/gpio-omap.c
> > +++ b/drivers/gpio/gpio-omap.c
> > @@ -590,10 +590,12 @@ static void gpio_irq_handler(unsigned int irq,
> struct irq_desc *desc)
> >  		u32 enabled;
> >
> >  		enabled = _get_gpio_irqbank_mask(bank);
> > -		isr_saved = isr = __raw_readl(isr_reg) & enabled;
> >
> > -		if (cpu_is_omap15xx() && (bank->method == METHOD_MPUIO))
> > -			isr &= 0x0000ffff;
> > +		if (bank->width == 32)
> > +			isr = __raw_readl(isr_reg) & enabled;
> > +		else if (bank->width == 16)
> > +			isr = (__raw_readw(isr_reg) & enabled) & 0x0000ffff;
> > +		isr_saved = isr;
> 
> Come to think of it, even when bank->width is 16, all the OMAP1
> registers are 4-byte aligned, so just use a 4-byte read.  The 'enabled'
> mask is already taking care to mask for bank width.
Yes, that makes sense. I will change.
--
Tarun
--

> 
> Kevin
