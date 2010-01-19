From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 1/1] OMAP3: PM: Fix compilation issue of
 omap3_pm_init_opp_table
Date: Tue, 19 Jan 2010 15:49:27 +0200
Message-ID: <20100119134927.GE12231@esdhcp037198.research.nokia.com>
References: <1263902254-3015-1-git-send-email-eduardo.valentin@nokia.com>
 <4B559F1C.6070802@gmail.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:63387 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118Ab0ASNtw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 08:49:52 -0500
Content-Disposition: inline
In-Reply-To: <4B559F1C.6070802@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Nishanth Menon <menon.nishanth@gmail.com>
Cc: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, Linux-OMAP <linux-omap@vger.kernel.org>

On Tue, Jan 19, 2010 at 01:01:32PM +0100, ext Nishanth Menon wrote:
> Eduardo Valentin said the following on 01/19/2010 05:57 AM:
> > From: Eduardo Valentin <eduardo.valentin@nokia.com>
> >
> > This patch removes the compilation error when compiling
> > kernel with CONFIG_PM=N. The problem was that omap3_pm_init_opp_table
> > was not defined if CONFIG_PM=N.
> >
> > Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> > ---
> >  arch/arm/mach-omap2/pm.h |    6 ++++++
> >  1 files changed, 6 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> > index d257225..5fc056f 100644
> > --- a/arch/arm/mach-omap2/pm.h
> > +++ b/arch/arm/mach-omap2/pm.h
> > @@ -69,7 +69,13 @@ static inline void omap3_pm_init_vc(struct prm_setup_vc *setup_vc)
> >   * Initialize the basic opp table here, board files could choose to modify opp
> >   * table after the basic initialization
> >   */
> > +#ifdef CONFIG_PM
> >  extern void omap3_pm_init_opp_table(void);
> > +#else
> > +static inline void omap3_pm_init_opp_table(void)
> > +{
> > +}
> > +#endif
> >  
> >  extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
> >  extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
> >   
> Err... NAK.. I think you missed 
> http://marc.info/?t=126356119700001&r=1&w=2 ?
> there seems to be an issue else where, I have not dug at it yet..


Yeah. OK, I couldn't see the logs as the dumps has been removed already from that thread.
But if I got the problem correctly, the problem is when CONFIG_PM is not set but cpu freq is.
And if there is any call to new omap opp layer helper functions, then it will BUG the system.
Causing hangs.

I guess one way to solve this is to bind compilation of omap opp layer to CONFIG_PM and CONFIG_CPU_FREQ.
If either is disabled, then omap opp layer must be nops.

What do you think?

I am sending a patch to do the above.

> Regards,
> Nishanth Menon

-- 
Eduardo Valentin
