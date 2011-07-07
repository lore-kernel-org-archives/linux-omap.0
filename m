From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v3 09/20] GPIO: OMAP: Use level/edge detect reg offsets
Date: Thu, 7 Jul 2011 10:17:35 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037BD02D55@dbde02.ent.ti.com>
References: <1309513634-20971-1-git-send-email-tarun.kanti@ti.com>
	<1309513634-20971-10-git-send-email-tarun.kanti@ti.com>
 <87hb6zgp1h.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38258 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750756Ab1GGErn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jul 2011 00:47:43 -0400
In-Reply-To: <87hb6zgp1h.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Varadarajan, Charulatha" <charu@ti.com>

[...]
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
> Looks good.   One very minor nit below...
> 
> [...]
> 
> > @@ -1247,40 +1240,18 @@ void omap2_gpio_prepare_for_idle(int off_mode)
> >  		if (!(bank->enabled_non_wakeup_gpios))
> >  			goto save_gpio_ctx;
> >
> > -		if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
> > -			bank->saved_datain = __raw_readl(bank->base +
> > -					OMAP24XX_GPIO_DATAIN);
> > -			l1 = __raw_readl(bank->base +
> > -					OMAP24XX_GPIO_FALLINGDETECT);
> > -			l2 = __raw_readl(bank->base +
> > -					OMAP24XX_GPIO_RISINGDETECT);
> > -		}
> > -
> > -		if (cpu_is_omap44xx()) {
> > -			bank->saved_datain = __raw_readl(bank->base +
> > -						OMAP4_GPIO_DATAIN);
> > -			l1 = __raw_readl(bank->base +
> > -						OMAP4_GPIO_FALLINGDETECT);
> > -			l2 = __raw_readl(bank->base +
> > -						OMAP4_GPIO_RISINGDETECT);
> > -		}
> > +		bank->saved_datain = __raw_readl(bank->base +
> > +							bank->regs->datain);
> > +		l1 = __raw_readl(bank->base + bank->regs->fallingdetect);
> > +		l2 = __raw_readl(bank->base + bank->regs->risingdetect);
> 
> The l1 = 0, l2 = 0 assignments can now be removed at the beginning of
> this function also.  Similarily for the 'l = 0' assignment in the
> runtime_resume function.
Ok.
--
Tarun
> 
> Kevin
