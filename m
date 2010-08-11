From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2: Fix a cpu type check problem.
Date: Wed, 11 Aug 2010 12:20:05 +0300
Message-ID: <20100811092005.GB26637@atomide.com>
References: <1281443797-7062-1-git-send-email-stanley.miao@windriver.com>
 <4C6162F4.7030500@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55975 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753925Ab0HKJUM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 05:20:12 -0400
Content-Disposition: inline
In-Reply-To: <4C6162F4.7030500@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: "Stanley.Miao" <stanley.miao@windriver.com>, linux-omap@vger.kernel.org

* Igor Grinberg <grinberg@compulab.co.il> [100810 17:25]:
> On 08/10/10 15:36, Stanley.Miao wrote:
> > cpu_is_omap3517() and cpu_is_omap3505() are the subgroups of cpu_is_omap34xx(),
> > so we should check cpu_is_omap3517() and cpu_is_omap3505() first, then check
> > cpu_is_omap34xx().
> >
> > Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
> >   
> 
> Tested-by: Igor Grinberg <grinberg@compulab.co.il>
> 
> I've just ran into this yesterday evening.
> Having a patch for this on the next day made me :)
> Tested on AM3517.

Can you please describe what breaks so we can merge this as a fix?

Regards,

Tony
 
> > ---
> >  arch/arm/mach-omap2/clock3xxx_data.c |   14 +++++++-------
> >  1 files changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
> > index 138646d..dfdce2d 100644
> > --- a/arch/arm/mach-omap2/clock3xxx_data.c
> > +++ b/arch/arm/mach-omap2/clock3xxx_data.c
> > @@ -3417,7 +3417,13 @@ int __init omap3xxx_clk_init(void)
> >  	struct omap_clk *c;
> >  	u32 cpu_clkflg = CK_3XXX;
> >  
> > -	if (cpu_is_omap34xx()) {
> > +	if (cpu_is_omap3517()) {
> > +		cpu_mask = RATE_IN_3XXX | RATE_IN_3430ES2PLUS;
> > +		cpu_clkflg |= CK_3517;
> > +	} else if (cpu_is_omap3505()) {
> > +		cpu_mask = RATE_IN_3XXX | RATE_IN_3430ES2PLUS;
> > +		cpu_clkflg |= CK_3505;
> > +	} else if (cpu_is_omap34xx()) {
> >  		cpu_mask = RATE_IN_3XXX;
> >  		cpu_clkflg |= CK_343X;
> >  
> > @@ -3432,12 +3438,6 @@ int __init omap3xxx_clk_init(void)
> >  			cpu_mask |= RATE_IN_3430ES2PLUS;
> >  			cpu_clkflg |= CK_3430ES2;
> >  		}
> > -	} else if (cpu_is_omap3517()) {
> > -		cpu_mask = RATE_IN_3XXX | RATE_IN_3430ES2PLUS;
> > -		cpu_clkflg |= CK_3517;
> > -	} else if (cpu_is_omap3505()) {
> > -		cpu_mask = RATE_IN_3XXX | RATE_IN_3430ES2PLUS;
> > -		cpu_clkflg |= CK_3505;
> >  	}
> >  
> >  	if (omap3_has_192mhz_clk())
> >   
> 
> -- 
> Regards,
> Igor.
> 
