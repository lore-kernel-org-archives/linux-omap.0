From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: Timer and Counter DT Updates for v3.8
Date: Thu, 8 Nov 2012 09:38:25 -0800
Message-ID: <20121108173824.GE6801@atomide.com>
References: <50941812.2070501@ti.com>
 <20121107004703.GS6801@atomide.com>
 <20121107234403.GS6801@atomide.com>
 <509BE9B0.5040608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:42307 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751493Ab2KHRi2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Nov 2012 12:38:28 -0500
Content-Disposition: inline
In-Reply-To: <509BE9B0.5040608@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, device-tree <devicetree-discuss@lists.ozlabs.org>

* Jon Hunter <jon-hunter@ti.com> [121108 09:21]:
> 
> On 11/07/2012 05:44 PM, Tony Lindgren wrote:
> 
> That's a bugger. I completely missed your patch last week sorry (I will blame the Danish
> beer) and had clearly not folded in to my testing!

:)
 
> > I guess we should apply the following fix somewhere or
> > do we need to check other places too?
> 
> I will re-test your master branch today and put it through my dmtimer tests to double check.
> However, in general I did ensure that we checked pdata was not NULL before accessing when 
> I introduced the dt stuff. In my changelog [1] I had ...
> 
> "5. When device-tree is present the platform_data structure will be NULL and so check for
> this."
> 
> I just need to make sure that get_context_loss_count() is not called before checking it is
> populated.  

OK

  
> > +
> > +	if (pdata) {
> > +		timer->capability = pdata->timer_capability;
> 
> You don't need this it is already handled a few lines before.
> 
> > +		timer->get_context_loss_count = pdata->get_context_loss_count;
> 
> We could probably move this too. For example ...

OK yeah makes sense to me.

Regards,

Tony
 
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index 38c12ef..9dca23e 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -799,12 +799,11 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
>                 timer->id = pdev->id;
>                 timer->capability = pdata->timer_capability;
>                 timer->reserved = omap_dm_timer_reserved_systimer(timer->id);
> +               timer->get_context_loss_count = pdata->get_context_loss_count;
>         }
>  
>         timer->irq = irq->start;
>         timer->pdev = pdev;
> -       timer->capability = pdata->timer_capability;
> -       timer->get_context_loss_count = pdata->get_context_loss_count;
>  
>         /* Skip pm_runtime_enable for OMAP1 */
>         if (!(timer->capability & OMAP_TIMER_NEEDS_RESET)) {
> 
> Cheers
> Jon
> 
> [1] http://marc.info/?l=linux-omap&m=135065877008624&w=2
