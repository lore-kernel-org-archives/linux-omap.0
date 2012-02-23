From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 5/7] ARM: OMAP2+: Split omap2_hsmmc_init() to
 properly support I2C GPIO pins
Date: Thu, 23 Feb 2012 10:47:51 -0800
Message-ID: <20120223184751.GX18185@atomide.com>
References: <1329997247-27342-1-git-send-email-rnayak@ti.com>
 <1329997247-27342-6-git-send-email-rnayak@ti.com>
 <4F464CFF.3080006@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52106 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823Ab2BWSr4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Feb 2012 13:47:56 -0500
Content-Disposition: inline
In-Reply-To: <4F464CFF.3080006@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Steve Sakoman <steve@sakoman.com>, Steve Sakoman <sakoman@gmail.com>

* Igor Grinberg <grinberg@compulab.co.il> [120223 05:56]:
> > --- a/arch/arm/mach-omap2/board-cm-t35.c
> > +++ b/arch/arm/mach-omap2/board-cm-t35.c
> > @@ -411,9 +411,9 @@ static struct omap2_hsmmc_info mmc[] = {
> >  	{
> >  		.mmc		= 1,
> >  		.caps		= MMC_CAP_4_BIT_DATA,
> > -		.gpio_cd	= -EINVAL,
> > +		.gpio_cd	= OMAP_MAX_GPIO_LINES + 0,
> >  		.gpio_wp	= -EINVAL,

I don't have these changes, in my second revision of the patch.

It's best not to hardcode the values here.

> > -
> > +		.deferred	= true,
> >  	},
> >  	{
> >  		.mmc		= 2,
> > @@ -422,6 +422,7 @@ static struct omap2_hsmmc_info mmc[] = {
> >  		.gpio_cd	= -EINVAL,
> >  		.gpio_wp	= -EINVAL,
> >  		.ocr_mask	= 0x00100000,	/* 3.3V */
> > +		.deferred	= true,
> 
> Why do you defer this one?
> It does not use external GPIO chip, in fact it does not use CD/WP at all.

Why do you have the following then to set gpio_cd?
 
> >  	},
> >  	{}	/* Terminator */
> >  };
> > @@ -469,9 +470,7 @@ static int cm_t35_twl_gpio_setup(struct device *dev, unsigned gpio,
> >  		pr_err("CM-T35: could not obtain gpio for WiFi reset\n");
> >  	}
> >  
> > -	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
> > -	mmc[0].gpio_cd = gpio + 0;
> > -	omap2_hsmmc_init(mmc);
> > +	omap_hsmmc_deferred_add(mmc);
> >  
> >  	return 0;
> >  }

Hmm I don't have omap_hsmmc_deferred_add() in my second version
of the patch either.

Rajendra, please do the patches on that, now it's impossible to
see what else you've changed. That's the version posted here:

http://www.spinics.net/lists/linux-omap/msg64884.html

> > @@ -639,6 +638,7 @@ static void __init cm_t3x_common_init(void)
> >  	omap_serial_init();
> >  	omap_sdrc_init(mt46h32m32lf6_sdrc_params,
> >  			     mt46h32m32lf6_sdrc_params);
> > +	omap_hsmmc_init(mmc);
> >  	cm_t35_init_i2c();
> >  	omap_ads7846_init(1, CM_T35_GPIO_PENDOWN, 0, NULL);
> >  	cm_t35_init_ethernet();
> 
> Other then the comment above, looks fine.
> I will probably be able to test this on Sunday.

OK
 
> > diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
> > index a59ace0..11a6aa4 100644
> > --- a/arch/arm/mach-omap2/board-igep0020.c
> > +++ b/arch/arm/mach-omap2/board-igep0020.c
> > @@ -293,8 +293,9 @@ static struct omap2_hsmmc_info mmc[] = {
> >  	{
> >  		.mmc		= 1,
> >  		.caps		= MMC_CAP_4_BIT_DATA,
> > -		.gpio_cd	= -EINVAL,
> > +		.gpio_cd	= OMAP_MAX_GPIO_LINES + 0,
> >  		.gpio_wp	= -EINVAL,
> > +		.deferred	= true,
> >  	},
> >  #if defined(CONFIG_LIBERTAS_SDIO) || defined(CONFIG_LIBERTAS_SDIO_MODULE)
> >  	{
> > @@ -302,6 +303,7 @@ static struct omap2_hsmmc_info mmc[] = {
> >  		.caps		= MMC_CAP_4_BIT_DATA,
> >  		.gpio_cd	= -EINVAL,
> >  		.gpio_wp	= -EINVAL,
> > +		.deferred	= true,
> 
> same here, why defer it?

Because it too sets gpio_cd in the callback.
 
> ditto

ditto, that too sets gpio_cd..
 
> >  	},
> >  #endif
> >  	{}	/* Terminator */
> > @@ -360,10 +362,8 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
> >  {
> >  	int r, lcd_bl_en;
> >  
> > -	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
> >  	omap_mux_init_gpio(63, OMAP_PIN_INPUT);
> > -	mmc[0].gpio_cd = gpio + 0;

..here. Same for the others. So maybe check is some are wrong?

Tony
