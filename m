From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v3 09/20] GPIO: OMAP: Use level/edge detect reg offsets
Date: Wed, 6 Jul 2011 09:45:10 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037BD028E8@dbde02.ent.ti.com>
References: <1309513634-20971-1-git-send-email-tarun.kanti@ti.com>
	<1309513634-20971-10-git-send-email-tarun.kanti@ti.com>
 <87d3hop9pw.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46331 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760Ab1GFEPV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 00:15:21 -0400
In-Reply-To: <87d3hop9pw.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Varadarajan, Charulatha" <charu@ti.com>

> -----Original Message-----
> From: Hilman, Kevin
> Sent: Wednesday, July 06, 2011 5:22 AM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Shilimkar, Santosh; tony@atomide.com;
> Varadarajan, Charulatha
> Subject: Re: [PATCH v3 09/20] GPIO: OMAP: Use level/edge detect reg
> offsets
> 
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
> 
> > From: Charulatha V <charu@ti.com>
> >
> > By adding level and edge detection register offsets and then
> initializing them
> > correctly according to OMAP versions during device registrations we can
> now remove
> > lot of revision checks in these functions.
> >
> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > Signed-off-by: Charulatha V <charu@ti.com>
> 
> Found the bug causing GPIO IRQ triggering failures for Blaze and Zoom3
> GPIO-based network IRQs...
> 
> > @@ -400,12 +394,12 @@ static int gpio_irq_type(struct irq_data *d,
> unsigned type)
> >  	if (type & ~IRQ_TYPE_SENSE_MASK)
> >  		return -EINVAL;
> >
> > -	/* OMAP1 allows only only edge triggering */
> > -	if (!cpu_class_is_omap2()
> > -			&& (type & (IRQ_TYPE_LEVEL_LOW|IRQ_TYPE_LEVEL_HIGH)))
> > +	bank = irq_data_get_irq_chip_data(d);
> > +
> > +	if (bank->regs->leveldetect0 && (type &
> > +			(IRQ_TYPE_LEVEL_LOW|IRQ_TYPE_LEVEL_HIGH)))
> 
> This check is not the same as the one it replaced.  This check should
> be:
> 
> 	if (!bank->regs->leveldetect0 &&
> 	    (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH)))
> 		return -EINVAL;
> 
> Note the formatting changes also for readability, but the bugfix is just
> adding the '!' before regs->leveldetect0.
Yes, thanks. I will make the correction.
--
Tarun

> 
> Kevin
