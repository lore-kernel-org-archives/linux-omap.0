From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] OMAP2: Fix a cpu type check problem.
Date: Wed, 11 Aug 2010 15:22:05 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E80ACA1F@dbde02.ent.ti.com>
References: <1281443797-7062-1-git-send-email-stanley.miao@windriver.com>
 <4C6162F4.7030500@compulab.co.il> <20100811092005.GB26637@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49170 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756164Ab0HKJwR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 05:52:17 -0400
In-Reply-To: <20100811092005.GB26637@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Igor Grinberg <grinberg@compulab.co.il>
Cc: "Stanley.Miao" <stanley.miao@windriver.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Wednesday, August 11, 2010 2:50 PM
> To: Igor Grinberg
> Cc: Stanley.Miao; linux-omap@vger.kernel.org
> Subject: Re: [PATCH] OMAP2: Fix a cpu type check problem.
> 
> * Igor Grinberg <grinberg@compulab.co.il> [100810 17:25]:
> > On 08/10/10 15:36, Stanley.Miao wrote:
> > > cpu_is_omap3517() and cpu_is_omap3505() are the subgroups 
> of cpu_is_omap34xx(),
> > > so we should check cpu_is_omap3517() and 
> cpu_is_omap3505() first, then check
> > > cpu_is_omap34xx().
> > >
> > > Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
> > >   
> > 
> > Tested-by: Igor Grinberg <grinberg@compulab.co.il>
> > 
> > I've just ran into this yesterday evening.
> > Having a patch for this on the next day made me :)
> > Tested on AM3517.
> 
> Can you please describe what breaks so we can merge this as a fix?
> 

cpu_is_34xx() will be true for all OMAP3 based devices including
AM3517. So, if we want to perform operations specific to AM3517, the
check for AM3517 should be done first else you match for 34xx would
return true; and you wouldn't go far enough to check for am3517.

~sanjeev

> Regards,
> 
> Tony
>  
> > > ---
> > >  arch/arm/mach-omap2/clock3xxx_data.c |   14 +++++++-------
> > >  1 files changed, 7 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/arch/arm/mach-omap2/clock3xxx_data.c 
> b/arch/arm/mach-omap2/clock3xxx_data.c
> > > index 138646d..dfdce2d 100644
> > > --- a/arch/arm/mach-omap2/clock3xxx_data.c
> > > +++ b/arch/arm/mach-omap2/clock3xxx_data.c
> > > @@ -3417,7 +3417,13 @@ int __init omap3xxx_clk_init(void)
> > >  	struct omap_clk *c;
> > >  	u32 cpu_clkflg = CK_3XXX;
> > >  
> > > -	if (cpu_is_omap34xx()) {
> > > +	if (cpu_is_omap3517()) {
> > > +		cpu_mask = RATE_IN_3XXX | RATE_IN_3430ES2PLUS;
> > > +		cpu_clkflg |= CK_3517;
> > > +	} else if (cpu_is_omap3505()) {
> > > +		cpu_mask = RATE_IN_3XXX | RATE_IN_3430ES2PLUS;
> > > +		cpu_clkflg |= CK_3505;
> > > +	} else if (cpu_is_omap34xx()) {
> > >  		cpu_mask = RATE_IN_3XXX;
> > >  		cpu_clkflg |= CK_343X;
> > >  
> > > @@ -3432,12 +3438,6 @@ int __init omap3xxx_clk_init(void)
> > >  			cpu_mask |= RATE_IN_3430ES2PLUS;
> > >  			cpu_clkflg |= CK_3430ES2;
> > >  		}
> > > -	} else if (cpu_is_omap3517()) {
> > > -		cpu_mask = RATE_IN_3XXX | RATE_IN_3430ES2PLUS;
> > > -		cpu_clkflg |= CK_3517;
> > > -	} else if (cpu_is_omap3505()) {
> > > -		cpu_mask = RATE_IN_3XXX | RATE_IN_3430ES2PLUS;
> > > -		cpu_clkflg |= CK_3505;
> > >  	}
> > >  
> > >  	if (omap3_has_192mhz_clk())
> > >   
> > 
> > -- 
> > Regards,
> > Igor.
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 