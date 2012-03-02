From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv3 4/6] ARM: OMAP3 PM: Enable IO Wake up
Date: Fri, 2 Mar 2012 11:19:00 +0200
Message-ID: <1330679940.2116.95.camel@sokoban>
References: <1330525621-29836-1-git-send-email-t-kristo@ti.com>
	 <1330525621-29836-5-git-send-email-t-kristo@ti.com>
	 <4F4F1CBA.7040502@ti.com>  <87sjhsdk2y.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47522 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757836Ab2CBJTG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Mar 2012 04:19:06 -0500
In-Reply-To: <87sjhsdk2y.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

On Thu, 2012-03-01 at 14:37 -0800, Kevin Hilman wrote:
> Rajendra Nayak <rnayak@ti.com> writes:
> 
> > On Wednesday 29 February 2012 07:56 PM, Tero Kristo wrote:
> >> From: Vishwanath BS<vishwanath.bs@ti.com>
> >>
> >> Enable IO Wake up for OMAP3 as part of PM Init. Currently this has been
> >> managed in cpuidle path which is not the right place. Subsequent patch
> >> will remove IO Daisy chain handling in cpuidle path once daisy chain is
> >> handled as part of hwmod mux.
> >>
> >> Signed-off-by: Vishwanath BS<vishwanath.bs@ti.com>
> >> Tested-by: Govindraj.R<govindraj.raja@ti.com>
> >> Signed-off-by: Tero Kristo<t-kristo@ti.com>
> >> ---
> >>   arch/arm/mach-omap2/pm34xx.c |    4 ++++
> >>   1 files changed, 4 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> >> index e97ec3f..e6c2d39 100644
> >> --- a/arch/arm/mach-omap2/pm34xx.c
> >> +++ b/arch/arm/mach-omap2/pm34xx.c
> >> @@ -793,6 +793,10 @@ static int __init omap3_pm_init(void)
> >>   		goto err1;
> >>   	}
> >>
> >> +	if (omap3_has_io_wakeup())
> >> +		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD,
> >> +					   PM_WKEN);
> >
> > On OMAP4 this GLOBAL IO chain enable happens as part of the trigger
> > function itself, it might make sense to do that for OMAP3 too to avoid
> > similar issues as seen on OMAP4 when the GLOBAL switch is enabled too
> > late in boot. The best however would be to get rid of it in the trigger
> > function and enable this early during PM init, but I am not sure whats
> > a good place to do this 'early' enough.
> 
> What about the subsys_initcall() that's already in the prm*.c files?
> 
> IMO, the global one-time init doesn't belong in the trigger function
> because there's no need to do the extra PRM read/write when it should be
> a one-shot init.

This sounds good to me at least, I can change the patches to work like
this, Rajendra?

-Tero

