From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v2 11/18] GPIO: OMAP: Clean set_gpio_triggering function
Date: Fri, 17 Jun 2011 10:46:57 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037B9AC579@dbde02.ent.ti.com>
References: <1308111806-29152-1-git-send-email-tarun.kanti@ti.com>
	<1308111806-29152-2-git-send-email-tarun.kanti@ti.com>
 <87mxhhn088.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56918 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751560Ab1FQFRH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jun 2011 01:17:07 -0400
In-Reply-To: <87mxhhn088.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>

> -----Original Message-----
> From: Hilman, Kevin
> Sent: Thursday, June 16, 2011 11:11 PM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Shilimkar, Santosh; tony@atomide.com
> Subject: Re: [PATCH v2 11/18] GPIO: OMAP: Clean set_gpio_triggering
> function
> 
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
> 
> > From: Charulatha V <charu@ti.com>
> >
> > Getting rid of ifdefs within the function by adding register offset
> intctrl
> > and associating OMAPXXXX_GPIO_INT_CONTROL in respective SoC specific
> files.
> >
> > Signed-off-by: Charulatha V <charu@ti.com>
> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> 
> [...]
> 
> > diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
> > index 0a8f637..3c96855 100644
> > --- a/arch/arm/mach-omap2/gpio.c
> > +++ b/arch/arm/mach-omap2/gpio.c
> > @@ -83,6 +83,10 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh,
> void *unused)
> >  		return -ENOMEM;
> >  	}
> >
> > +	pdata->regs->irqctrl = USHRT_MAX;
> > +	pdata->regs->edgectrl1 = USHRT_MAX;
> > +	pdata->regs->edgectrl2 = USHRT_MAX;
> 
> As with all the other undefined values, please use zero.
Yes.

> 
> The driver check is checking for non-zero values which would be true
> with USHRT_MAX.  You don't happen to see this because of the OMAP1 #ifdef.
Ok, I will change.

> 
> [...]
> 
> >  	if (likely(!(bank->non_wakeup_gpios & gpio_bit))) {
> >  		if (cpu_is_omap44xx()) {
> > -			MOD_REG_BIT(OMAP4_GPIO_IRQWAKEN0, gpio_bit,
> > +			MOD_REG_BIT(bank->regs->wkup_status, gpio_bit,
> >  				trigger != 0);
> >  		} else {
> >  			/*
> > @@ -233,10 +222,10 @@ static inline void set_24xx_gpio_triggering(struct
> gpio_bank *bank, int gpio,
> >  			 */
> >  			if (trigger & IRQ_TYPE_EDGE_BOTH)
> >  				__raw_writel(1 << gpio, bank->base
> > -					+ OMAP24XX_GPIO_SETWKUENA);
> > +					+ bank->regs->wkup_set);
> >  			else
> >  				__raw_writel(1 << gpio, bank->base
> > -					+ OMAP24XX_GPIO_CLEARWKUENA);
> > +					+ bank->regs->wkup_clear);
> >  		}
> 
> Probably should be done in an additional patch, but the cpu_is_44xx()
> above could be removed too.
> 
> The 44xx TRM recommends using the wkup_status only (not using set/clear
> registers) and the same could be done for the other SoCs.
Ok, I will change for other SoC's as well.
--
Tarun

> 
> Kevin
