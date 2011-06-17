From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v2 09/18] GPIO: OMAP: Use level/edge detect reg offsets
Date: Fri, 17 Jun 2011 10:56:32 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037B9AC592@dbde02.ent.ti.com>
References: <1308111776-29130-1-git-send-email-tarun.kanti@ti.com>
	<1308111776-29130-8-git-send-email-tarun.kanti@ti.com>
 <87y611ognl.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33171 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560Ab1FQF0k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jun 2011 01:26:40 -0400
In-Reply-To: <87y611ognl.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>

> -----Original Message-----
> From: Hilman, Kevin
> Sent: Thursday, June 16, 2011 10:31 PM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Shilimkar, Santosh; tony@atomide.com
> Subject: Re: [PATCH v2 09/18] GPIO: OMAP: Use level/edge detect reg
> offsets
> 
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
> 
> > By adding level and edge detection register offsets and then
> initializing them
> > correctly according to OMAP versions during device registrations we can
> now remove
> > lot of revision checks in these functions.
> >
> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > Signed-off-by: Charulatha V <charu@ti.com>
> 
> Looks mostly good, but...
> 
> [...]
> 
> > @@ -661,9 +655,8 @@ static void gpio_irq_handler(unsigned int irq,
> struct irq_desc *desc)
> >  		if (cpu_is_omap15xx() && (bank->method == METHOD_MPUIO))
> >  			isr &= 0x0000ffff;
> >
> > -		if (cpu_class_is_omap2()) {
> > +		if (bank->regs->leveldetect0)
> 
> Rather than checking for the presence of the register, this should just
> be 'if (bank->level_mask)'.  bank->level_mask will should already be
> zero on platforms without the register.
Ok. I will make the change.
--
Tarun

> 
> Kevin
