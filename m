From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 4/6] ARM: OMAP4: PMU: Add runtime PM support
Date: Sat, 2 Jun 2012 17:42:29 +0100
Message-ID: <20120602164228.GA14903@mudshark.cambridge.arm.com>
References: <4FC54D3B.10301@ti.com>
 <87pq9l7306.fsf@ti.com>
 <20120531012923.GB8506@mudshark.cambridge.arm.com>
 <4FC7B465.60703@ti.com>
 <87r4u0ytd9.fsf@ti.com>
 <4FC7E161.1080400@ti.com>
 <87d35kyo3v.fsf@ti.com>
 <4FC7F87C.9080709@ti.com>
 <87obp3vptz.fsf@ti.com>
 <4FC8D4F0.6040806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:61337 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754291Ab2FBQml (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 Jun 2012 12:42:41 -0400
Content-Disposition: inline
In-Reply-To: <4FC8D4F0.6040806@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Ming Lei <ming.lei@canonical.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi Jon, Kevin,

I've been between timezones, so sorry for the slow response.

On Fri, Jun 01, 2012 at 03:42:56PM +0100, Jon Hunter wrote:
> On 05/31/2012 07:27 PM, Kevin Hilman wrote:
> >> Hmmm ... however, now looking at the history behind the plat->irq_*
> >> hooks, I see that Ming specifically added these for omap4 [1]. I was
> >> under the impression other architectures may be using this. I guess not.
> >> So if it is preferred we could do-away with the plat->irq_* and replace
> >> with the plat->runtime_*.
> > 
> > Yes, that would certainly be my preference from a runtime PM readability
> > PoV.  I guess it's Will's call since it's his code.
> 
> Ok great.
> 
> Will, let me know your thoughts. I have a V2 series ready to post, I
> just need to know your thoughts on handling this runtime PM business. Or
> if you would just like me to send it out for review anyway, I can do
> that too.

>From my perspective, we have up to three pairs of functions on the PMU:

1. enable/disable irq
2. reserve/release pmu
3. suspend/resume pmu

As you pointed out, (1) was added purely for OMAP so I'd definitely like
to remove that if we can. What I wonder is whether (2) and (3) can also be
combined into a single pair of functions. The default behaviour could be the
simple bit lock that we have in pmu.c. If a platform wants to do more, then
it can supply its own functions for these and do PM there as well as the
mutual exclusion (which we may well get for free). This also fits with my
previous plans for making reserve/release PMU-specific and killing the
arm_pmu_type enumeration.

So, if we can condense this all down into one pair of functions that also
work correctly for the non-PM case (including mutual exclusion) then I'd
love to see that merged.

Cheers,

Will
