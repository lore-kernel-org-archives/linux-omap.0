From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: clockdomain: Wait for powerdomain to be ON when
 using clockdomain force wakeup
Date: Fri, 12 Aug 2011 08:27:35 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1108120730220.10963@utopia.booyaka.com>
References: <1310527588-13022-1-git-send-email-santosh.shilimkar@ti.com> <1310527588-13022-2-git-send-email-santosh.shilimkar@ti.com> <alpine.DEB.2.00.1107150159580.16606@utopia.booyaka.com> <4E214267.2090700@ti.com> <4E43E23C.2080207@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46693 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954Ab1HLO1f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Aug 2011 10:27:35 -0400
In-Reply-To: <4E43E23C.2080207@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh <santosh.shilimkar@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org, khilman@ti.com, p-titiano@ti.com, b-cousson@ti.com

(cc Tero)

Hi Santosh,

On Thu, 11 Aug 2011, Santosh wrote:

> On Saturday 16 July 2011 01:18 PM, Santosh Shilimkar wrote:
> > On 7/15/2011 1:03 AM, Paul Walmsley wrote:
> > > On Wed, 13 Jul 2011, Santosh Shilimkar wrote:
> > > 
> > > > - return arch_clkdm->clkdm_wakeup(clkdm);
> > > > + ret = arch_clkdm->clkdm_wakeup(clkdm);
> > > > + ret |= pwrdm_wait_transition(clkdm->pwrdm.ptr);
> > > 
> > > Seems like this should just call pwrdm_state_switch() or
> > > pwrdm_clkdm_state_switch()? (This second function looks superfluous, we
> > > should probably get rid of it.)
> > > 
> > This comment was expected since initially we thought of using
> > pwrdm_clkdm_state_switch
> > 
> > pwrdm_clkdm_state_switch()
> > |--> pwrdm_wait_transition()
> > |--> pwrdm_state_switch()
> > 
> > What we need is only first function to ensure that we don't
> > proceed when PD is in middle of transition.
> > 
> > The second function is actually just doing those debug counter
> > updates and we wanted to avoid that since it's a live path.

Those counters are now also used by pwrdm_get_context_loss_count() which 
ultimately is exposed to device drivers as
omap_pm_get_dev_context_loss_count().

If clkdm_wakeup() causes the powerdomain to wake up from a state that 
caused context to be lost, don't we need to update the counters due to 
that dependency?

> > Rajendra observed some huge latencies while doing the
> > profiling and the suspect was "pwrdm_state_switch()" which
> > actually keeps adding overhead because of those counter
> > updates.

Probably we'd better deal with the latency issue in a separate patch.

If I recall correctly, the high latency operation in the counters is the 
PREPWSTST register read.  That could probably be optimized out under many 
circumstances.  The counter functionality could be made dependent on 
CONFIG_PM_DEBUG or something similar.

> > > Shouldn't this be added to all of
> > > clkdm_{wakeup,sleep,allow_idle,deny_idle}() if it isn't there already?
> > > 
> > clkdm_allow_idle() already has the power-domain wait.
> > This patch adds it for clkdm_wakeup() function.
> > clkdm_sleep(), this shouldn't be applicable since power
> > domain sleep transition is depdent on other clockdomains
> > in the PD and it's a lazy operation.

That's a good question.  Could you ping the PRCM designers on that issue 
to see if there's any risk that not waiting for a clockdomain force-sleep 
might cause some FSM issue?  We should probably handle this in a separate 
patch anyway so it doesn't retard this patch.

> > That leaves clkdm_deny_idle() and I guess we should
> > address this API as well.
> > 
> > If you agree with above, I can update the patch to address

I'd propose:

1. changing the patch to use pwrdm_state_switch()

2. adding that to clkdm_deny_idle() also

What do you think?


- Paul
