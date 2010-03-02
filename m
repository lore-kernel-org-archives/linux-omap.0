From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCHv2 2/2] OMAP3: PM: Consistently report cpuidle C-state's
 names
Date: Tue, 2 Mar 2010 09:53:38 +0200
Message-ID: <20100302075338.GB25093@esdhcp037198.research.nokia.com>
References: <1266321499-11858-1-git-send-email-eduardo.valentin@nokia.com>
 <1266321499-11858-3-git-send-email-eduardo.valentin@nokia.com>
 <877hpv7fav.fsf@deeprootsystems.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:52220 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478Ab0CBHyJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Mar 2010 02:54:09 -0500
Content-Disposition: inline
In-Reply-To: <877hpv7fav.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>

Hello Kevin,

On Tue, Mar 02, 2010 at 01:11:52AM +0100, ext Kevin Hilman wrote:
> Eduardo Valentin <eduardo.valentin@nokia.com> writes:
> 
> > From: Eduardo Valentin <eduardo.valentin@nokia.com>
> >
> > This patch changes the naming convention for OMAP3 cpuidle
> > C-states. Currently, depending on which Cstates are enabled/disabled,
> > there is a inconsistency between C-state name and what power domain
> > states it is supposed to reach when that C-state is selected.
> >
> > For instance, if all cstates are enabled, "C1" means mpu on and
> > core on. But if this exact cstate is disabled, then "C1" doesn't mean
> > same power domains state configuration anymore.
> >
> > So, this patch tries changing the cstates naming convention in order
> > to proper and consistently report the cstates names.
> >
> > Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> 
> I like this, however...
> 
> Have you considered patching powertop as well?  Powertop doesn't seem
> to take into consideration the 'desc' field and just names C-states
> in increasing order.
> 
> So this patch combined with current powertop acutally makes things
> even more confusing. :(

Right. I didn't think about powertop in the first place, but you are right.
It is worth to have similar changes also on it, to properly use the 'desc' and name fields.

I will figure out about it as well.

> 
> Kevin
> 
> > ---
> >  arch/arm/mach-omap2/cpuidle34xx.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> > index 50fe9ab..7ab9992 100644
> > --- a/arch/arm/mach-omap2/cpuidle34xx.c
> > +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> > @@ -367,7 +367,7 @@ int __init omap3_idle_init(void)
> >  			omap3_enter_idle_bm : omap3_enter_idle;
> >  		if (cx->type == OMAP3_STATE_C1)
> >  			dev->safe_state = state;
> > -		sprintf(state->name, "C%d", count+1);
> > +		sprintf(state->name, "C%d", cx->type + 1);
> >  		sprintf(state->desc, "MPU=%s NEON=%s CORE=%s",
> >  			pd_states[cx->mpu_state], pd_states[cx->mpu_state],
> >  			pd_states[cx->core_state]);
> > -- 
> > 1.6.5.7.g9ecb2

-- 
Eduardo Valentin
