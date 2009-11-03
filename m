From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3: decrease cpufreq transition latency
Date: Tue, 3 Nov 2009 09:08:11 -0800
Message-ID: <20091103170811.GI8981@atomide.com>
References: <1256850129-31618-1-git-send-email-mturquette@ti.com>
 <87k4ydzyvg.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61556 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188AbZKCRIL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 12:08:11 -0500
Content-Disposition: inline
In-Reply-To: <87k4ydzyvg.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Mike Turquette <mturquette@gmail.com>, linux-omap@vger.kernel.org, Mike Turquette <mturquette@ti.com>, Vishwa Sripathy <vishwanath.bs@ti.com>

* Kevin Hilman <khilman@deeprootsystems.com> [091029 14:14]:
> Mike Turquette <mturquette@gmail.com> writes:
> 
> > Adjust OMAP3 frequency transition latency from 10,000,000uS to a more
> > reasonable 300,000uS.  This causes ondemand and conservative governors to
> > sample CPU load more often resulting in more responsive behavior.
> >
> > Tested on Android 2.6.29; using this value and conservative governor, CORE
> > power consumption on Zoom2 was comparable to the old and unresponsive
> > 10,000,000uS value while UI responsiveness was greatly improved.
> >
> > This patch applies against Tony's omap-fixes branch.
> >
> > Signed-off-by: Mike Turquette <mturquette@ti.com>
> > ---
> >  arch/arm/plat-omap/cpu-omap.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
> > index 1868c0d..341235c 100644
> > --- a/arch/arm/plat-omap/cpu-omap.c
> > +++ b/arch/arm/plat-omap/cpu-omap.c
> > @@ -127,7 +127,7 @@ static int __init omap_cpu_init(struct cpufreq_policy *policy)
> >  	}
> >  
> >  	/* FIXME: what's the actual transition time? */
> 
> Can probably drop this 'FIXME' comment now.
> 
> > -	policy->cpuinfo.transition_latency = 10 * 1000 * 1000;
> > +	policy->cpuinfo.transition_latency = 300 * 1000;
> 
> otherwise,
> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> 
> Tony, can this still be queued for .32-rc?

Sure, I'll put together one more omap-fixes series this week.

Regards,

Tony
