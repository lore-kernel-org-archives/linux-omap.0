From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCHv2 1/2] OMAP3: PM: Add cpuidle C-state description
 information
Date: Tue, 2 Mar 2010 09:50:28 +0200
Message-ID: <20100302075028.GA25093@esdhcp037198.research.nokia.com>
References: <1266321499-11858-1-git-send-email-eduardo.valentin@nokia.com>
 <1266321499-11858-2-git-send-email-eduardo.valentin@nokia.com>
 <87k4tv7fe4.fsf@deeprootsystems.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:51879 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408Ab0CBHvS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Mar 2010 02:51:18 -0500
Content-Disposition: inline
In-Reply-To: <87k4tv7fe4.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>

On Tue, Mar 02, 2010 at 01:09:55AM +0100, ext Kevin Hilman wrote:
> Eduardo Valentin <eduardo.valentin@nokia.com> writes:
> 
> > From: Eduardo Valentin <eduardo.valentin@nokia.com>
> >
> > Add a basic description information for each cpuidle C-state.
> > The info contains only which state the MPU, NEON and CORE
> > power domains should reach when the C-state is selected.
> >
> > Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> 
> I like this series.  Some minor comments...
> 
> > ---
> >  arch/arm/mach-omap2/cpuidle34xx.c |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> > index 1cfa5a6..50fe9ab 100644
> > --- a/arch/arm/mach-omap2/cpuidle34xx.c
> > +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> > @@ -339,6 +339,7 @@ struct cpuidle_driver omap3_idle_driver = {
> >   */
> >  int __init omap3_idle_init(void)
> >  {
> > +	const char *pd_states[4] = {"OFF", "RET", "INA", "ON "};
> 
> I'd rather see something like this for this array, just in case
> those values change for any reason.
> 
> static const char *pd_states[] = {
> 	[PWRDM_POWER_OFF]      = "OFF",
> 	[PWRDM_POWER_RET]      = "RET",
> 	[PWRDM_POWER_INACTIVE] = "INA",
> 	[PWRDM_POWER_ON]       = "ON",

Nice! I'll resend with your proposal.

> };
> 
> >  	int i, count = 0;
> >  	struct omap3_processor_cx *cx;
> >  	struct cpuidle_state *state;
> > @@ -367,6 +368,9 @@ int __init omap3_idle_init(void)
> >  		if (cx->type == OMAP3_STATE_C1)
> >  			dev->safe_state = state;
> >  		sprintf(state->name, "C%d", count+1);
> > +		sprintf(state->desc, "MPU=%s NEON=%s CORE=%s",
> > +			pd_states[cx->mpu_state], pd_states[cx->mpu_state],
> > +			pd_states[cx->core_state]);
> >  		count++;
> >  	}
> >  
> > -- 
> > 1.6.5.7.g9ecb2

-- 
Eduardo Valentin
