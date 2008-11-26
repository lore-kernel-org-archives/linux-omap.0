From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3: Fixes for suspend / resume GPIO wake-up handling
Date: Wed, 26 Nov 2008 14:37:39 -0800
Message-ID: <20081126223736.GH11997@atomide.com>
References: <1227700030-28295-1-git-send-email-tero.kristo@nokia.com> <87bpw2jozi.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50318 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbYKZWhk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 17:37:40 -0500
Content-Disposition: inline
In-Reply-To: <87bpw2jozi.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tero Kristo <tero.kristo@nokia.com>, linux-omap@vger.kernel.org

* Kevin Hilman <khilman@deeprootsystems.com> [081126 10:56]:
> Tero Kristo <tero.kristo@nokia.com> writes:
> 
> > Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> > ---
> >  arch/arm/plat-omap/gpio.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> Thanks, I'll pull this into the next PM branch, and this
> can go straight into linux-omap.
>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

Pushing to l-o and adding to omap-fixes queue.

Tony


> > diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> > index f4ec3af..62349fd 100644
> > --- a/arch/arm/plat-omap/gpio.c
> > +++ b/arch/arm/plat-omap/gpio.c
> > @@ -1585,7 +1585,7 @@ static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
> >  #endif
> >  #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> >  		case METHOD_GPIO_24XX:
> > -			wake_status = bank->base + OMAP24XX_GPIO_SETWKUENA;
> > +			wake_status = bank->base + OMAP24XX_GPIO_WAKE_EN;
> >  			wake_clear = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
> >  			wake_set = bank->base + OMAP24XX_GPIO_SETWKUENA;
> >  			break;
> > @@ -1608,7 +1608,7 @@ static int omap_gpio_resume(struct sys_device *dev)
> >  {
> >  	int i;
> >  
> > -	if (!cpu_is_omap24xx() && !cpu_is_omap16xx())
> > +	if (!cpu_class_is_omap2() && !cpu_is_omap16xx())
> >  		return 0;
> >  
> >  	for (i = 0; i < gpio_bank_count; i++) {
> > -- 
> > 1.5.4.3
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
