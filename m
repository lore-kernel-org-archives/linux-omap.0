From: Samuel Ortiz <sameo@openedhand.com>
Subject: Re: [PATCH 4/7] Hook twl4030 power code into twl4030 core.
Date: Tue, 21 Oct 2008 00:27:24 +0200
Message-ID: <20081020222724.GC4197@sortiz.org>
References: <1223657776-16544-1-git-send-email-peter.de-schrijver@nokia.com> <1223657776-16544-2-git-send-email-peter.de-schrijver@nokia.com> <1223657776-16544-3-git-send-email-peter.de-schrijver@nokia.com> <1223657776-16544-4-git-send-email-peter.de-schrijver@nokia.com> <1223657776-16544-5-git-send-email-peter.de-schrijver@nokia.com> <20081011185036.GD20247@frodo>
Reply-To: Samuel Ortiz <sameo@openedhand.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 3a.49.1343.static.theplanet.com ([67.19.73.58]:58986 "EHLO
	pug.o-hand.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753591AbYJTWYr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Oct 2008 18:24:47 -0400
Content-Disposition: inline
In-Reply-To: <20081011185036.GD20247@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>, linux-omap@vger.kernel.org

On Sat, Oct 11, 2008 at 09:50:36PM +0300, Felipe Balbi wrote:
> On Fri, Oct 10, 2008 at 07:56:13PM +0300, Peter 'p2' De Schrijver wrote:
> > This patch makes twl4030 core call the power code in case the scripts are present in the platform data.
> > 
> > Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
> > ---
> >  drivers/mfd/twl4030-core.c |   11 +++++++++++
> >  1 files changed, 11 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/mfd/twl4030-core.c b/drivers/mfd/twl4030-core.c
> > index fd9a016..7a5c9d0 100644
> > --- a/drivers/mfd/twl4030-core.c
> > +++ b/drivers/mfd/twl4030-core.c
> > @@ -81,6 +81,12 @@
> >  #define twl_has_madc()	false
> >  #endif
> >  
> > +#ifdef CONFIG_TWL4030_POWER
> > +#define twl_has_power()        true
> > +#else
> > +#define twl_has_power()        false
> > +#endif
> > +
> >  #if defined(CONFIG_RTC_DRV_TWL4030) || defined(CONFIG_RTC_DRV_TWL4030_MODULE)
> >  #define twl_has_rtc()	true
> >  #else
> > @@ -106,6 +112,8 @@ static inline void activate_irq(int irq)
> >  #endif
> >  }
> >  
> > +extern void twl4030_power_init(struct twl4030_power_data *triton2_scripts);
> 
> normally we avoid extern prototypes in C files. Tony and Sam, any
> comments ??
checkpatch will bitch about it at least.
No big deal, but it's probably cleaner to have that in some header file.

Cheers,
Samuel.

> > +
> >  /* Primary Interrupt Handler on TWL4030 Registers */
> >  
> >  /* Register Definitions */
> > @@ -794,6 +802,9 @@ static int add_children(struct twl4030_platform_data *pdata)
> >  		}
> >  	}
> >  
> > +	if (twl_has_power() && pdata->power)
> > +		twl4030_power_init(pdata->power);
> > +
> >  	if (twl_has_rtc()) {
> >  		twl = &twl4030_modules[3];
> >  
> > -- 
> > 1.5.6.3
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> balbi

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
