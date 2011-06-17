From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v2 05/18] GPIO: OMAP: Handle save/restore ctx in GPIO
 driver
Date: Fri, 17 Jun 2011 11:11:07 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037B9AC5AE@dbde02.ent.ti.com>
References: <1308111776-29130-1-git-send-email-tarun.kanti@ti.com>
	<1308111776-29130-4-git-send-email-tarun.kanti@ti.com>
 <8739j9raz6.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55450 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751585Ab1FQFlP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jun 2011 01:41:15 -0400
In-Reply-To: <8739j9raz6.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>

> -----Original Message-----
> From: Hilman, Kevin
> Sent: Thursday, June 16, 2011 10:05 PM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Shilimkar, Santosh; tony@atomide.com
> Subject: Re: [PATCH v2 05/18] GPIO: OMAP: Handle save/restore ctx in GPIO
> driver
> 
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
> 
> > From: Charulatha V <charu@ti.com>
> >
> > Modify omap_gpio_prepare_for_idle() & omap_gpio_resume_after_idle()
> functions
> > to handle save context & restore context respectively in the OMAP GPIO
> driver
> > itself instead of calling these functions from pm specific files.
> > For this, in gpio_prepare_for_idle(), call *_get_context_loss_count()
> and in
> > gpio_resume_after_idle() call it again. If the count is different, do
> restore
> > context. The workaround_enabled flag is no more required and is removed.
> >
> > Signed-off-by: Charulatha V <charu@ti.com>
> 
> [...]
> 
> > @@ -1396,8 +1399,12 @@ void omap2_gpio_resume_after_idle(void)
> >  		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
> >  			clk_enable(bank->dbck);
> >
> > -		if (!workaround_enabled)
> > -			continue;
> > +		if (bank->get_context_loss_count) {
> > +			ctx_lost_cnt_after =
> > +				bank->get_context_loss_count(bank->dev);
> > +			if (ctx_lost_cnt_after != bank->ctx_loss_count)
> > +				omap_gpio_restore_context(bank);
> > +		}
> 
> Context should be also be restored if you cant know if it's been lost.
> IOW, it should also be restored if !bank->get_context_loss_count.
Ok, I will incorporate this condition as well.

> 
> >  		if (!(bank->enabled_non_wakeup_gpios))
> >  			continue;
> > @@ -1475,74 +1482,50 @@ void omap2_gpio_resume_after_idle(void)
> >  			}
> >  		}
> >  	}
> > -
> >  }
> >
> > -#endif
> > -
> > -#ifdef CONFIG_ARCH_OMAP3
> > -void omap_gpio_save_context(void)
> > +void omap_gpio_save_context(struct gpio_bank *bank)
> 
> Should also be made static.  Same for restore below.
Sure. Thanks.

BTW, there is another bug in this patch which I noticed later.
In *_probe, the following assignment got missed:

bank->get_context_loss_count = pdata->get_context_loss_count;

--
Tarun
> 
> Kevin
