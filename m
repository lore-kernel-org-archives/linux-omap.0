From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v3 12/20] GPIO: OMAP: Use wkup_status for all SoCs
Date: Tue, 12 Jul 2011 05:34:50 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037BE78072@dbde02.ent.ti.com>
References: <1309513634-20971-1-git-send-email-tarun.kanti@ti.com>
	<1309513634-20971-13-git-send-email-tarun.kanti@ti.com>
 <87k4bwkz9y.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35471 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755180Ab1GLAE7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jul 2011 20:04:59 -0400
In-Reply-To: <87k4bwkz9y.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>

Kevin,
[...]
> 
> >  		set_gpio_trigger(bank, gpio, trigger);
> >  	} else if (bank->regs->irqctrl) {
> >  		reg += bank->regs->irqctrl;
> > @@ -295,13 +296,7 @@ static int _set_gpio_triggering(struct gpio_bank
> *bank, int gpio, int trigger)
> >  		if (trigger & IRQ_TYPE_EDGE_FALLING)
> >  			l |= 1 << (gpio << 1);
> >
> > -		if (trigger)
> > -			/* Enable wake-up during idle for dynamic tick */
> > -			__raw_writel(1 << gpio, bank->base
> > -						+ bank->regs->wkup_set);
> > -		else
> > -			__raw_writel(1 << gpio, bank->base
> > -						+ bank->regs->wkup_clear);
> > +		MOD_REG_BIT(bank->regs->wkup_status, 1 << gpio, trigger != 0);
> 
> This isn't right, so I'm not sure how this is working. At this point:
> 
>      base = bank->base;
>      reg = bank->base + bank->regs->edgectrl[12];
Right so far...

> 
> but if you look at MOD_REG_BIT(), it does register access using 'base +
> reg', but here that will be 'bank->base + bank->base + reg offset',
> which will be doing a read/modify/write to who-knows-where.
My understanding was MOD_REG_BIT(bank->regs->wkup_status, ...) translate to:
bank->base + bank->regs->wkup_status, for the following reason:

In the following macro, reg is equivalent to bank->regs->wkup_status.
But this is not the case with base, which remains as bank->base.
Please correct me.

#define MOD_REG_BIT(reg, bit_mask, set) \
do {    \
        int l = __raw_readl(base + reg); \
        if (set) l |= bit_mask; \
        else l &= ~bit_mask; \
        __raw_writel(l, base + reg); \
} while(0)

> 
> >  		__raw_writel(l, reg);
> 
> Oh, now I see why it works: because you have an additional write here,
> which isn't right either because MOD_REG_BIT() already does the read
> *and* write.
This should be writing to following still.
reg = bank->base + bank->regs->edgectrl[12];
--
Tarun
> 
[...]
