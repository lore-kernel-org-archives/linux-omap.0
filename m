From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP4: clockdomain: Follow recommended enable sequence
Date: Tue, 8 Mar 2011 20:50:13 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103081937100.15132@utopia.booyaka.com>
References: <1299245123-23444-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37610 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932181Ab1CIDuO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 22:50:14 -0500
In-Reply-To: <1299245123-23444-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, khilman@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org

Hi Rajendra,

A few questions...

On Fri, 4 Mar 2011, Rajendra Nayak wrote:

> On OMAP4, the PRCM recommended sequence for enabling
> a module after power-on-reset is
> -1- Force clkdm to SW_WKUP
> -2- Configure desired module mode to "enable" or "auto"
> -3- Wait for the desired module idle status to be FUNC
> -4- Program clkdm in HW_AUTO(if supported)
> 
> This sequence applies to all older OMAPs' as well,
> however since they use autodeps, it makes sure that
> no clkdm is in IDLE, and hence not requiring a force
> SW_WKUP when a module is being enabled.
> 
> OMAP4 does not need to support autodeps, because
> of the dyanamic dependency feature, wherein
> the HW takes care of waking up a clockdomain from
> idle and hence the module, whenever an interconnect
> access happens to the given module.
> Autodeps were mainly needed on older OMAPs' as
> this was not the case back then, and a module
> access with the module/clkdm in idle would cause
> an abort.

Hmmm.  For OMAP3, I was under the impression that the PRCM would request 
that a target module exit idle via SIdleReq when the module's main 
functional clock was enabled.  (Assuming that the interface clock was 
enabled and in auto-idle.)  We would see this happen in the clock code by 
waiting for the CM_IDLEST* bits to change -- apparently these represented 
SIdleReq signals.

The PRCM would wake up the module's functional and interface clockdomains 
if they were in hardware-supervised mode and INACTIVE.  Then the module 
would exit idle and signal the PRCM via SIdleAck.

Then the processor could read and write module registers, etc.

Later, when the processor was finished, it would disable the module's main 
functional clock.  The PRCM would request the module to go idle via 
SIdleReq.  If the module's internal state allowed it to go idle, it would 
do so and use its SIdleAck signal to notify the PRCM.  The PRCM could then 
allow the clockdomains to go INACTIVE if the clocks were not needed.

Is this theory of operation correct?  If so, then it would seem that as 
long as a module's interface clock and main functional clock are enabled, 
module accesses should succeed, with no abort.

On the other hand, reading the 34xx TRM Rev. ZH section 4.12.2.4.6 
"CM_CLKSTCTRL_ <domain name> (Clock State Control Register)", it appears 
that some clockdomains don't take target module idle states into account.  
For example, DSS and USBHOST both contain target modules, but the 
paragraphs on DSS and USBHOST don't mention target module idle states at 
all.  (This section also does not mention SGX or CAM for some reason.)  
Do these clockdomains disregard target idle states when determining 
whether to go INACTIVE?  If so, that would certainly create a need 
to add a sleep dependency whenever a processor wished to access a module.

Or is some other phenomenon happening?

> Fix the clkdm_clk_enable api to handle
> this sequence on OMAP4.

In terms of triage, does this patch fix something that currently doesn't 
work (meaning that we should try to merge it for 2.6.39)?  Or can we plan 
to merge this during the 2.6.40 time frame?  It would be ideal, of course, 
if we could wait until 2.6.40, given how close we are to the merge window 
opening.

> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
> The patch is based on 'integration-2.6.39' branch
> of git://git.pwsan.com/linux-integration because
> of dependencies with other patches in the branch.
> 
>  arch/arm/mach-omap2/clock.c           |    4 ++++
>  arch/arm/mach-omap2/clockdomain.c     |    7 ++++++-
>  arch/arm/mach-omap2/clockdomain44xx.c |    9 ++-------
>  3 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
> index 46d03cc..1cf6786 100644
> --- a/arch/arm/mach-omap2/clock.c
> +++ b/arch/arm/mach-omap2/clock.c
> @@ -322,6 +322,10 @@ int omap2_clk_enable(struct clk *clk)
>  		}
>  	}
>  
> +	/* If clockdomain supports hardware control, enable it */
> +	if (clk->clkdm)
> +		clkdm_allow_idle(clk->clkdm);
> +
>  	return 0;
>  
>  oce_err3:
> diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
> index a0341de..9e1164f 100644
> --- a/arch/arm/mach-omap2/clockdomain.c
> +++ b/arch/arm/mach-omap2/clockdomain.c
> @@ -825,7 +825,12 @@ int clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
>  	if (!arch_clkdm || !arch_clkdm->clkdm_clk_enable)
>  		return -EINVAL;
>  
> -	if (atomic_inc_return(&clkdm->usecount) > 1)
> +	/*
> +	 * For arch's with no autodeps, clkcm_clk_enable
> +	 * should be called for every clock instance that is
> +	 * enabled, so the clkdm can be force woken up.
> +	 */
> +	if ((atomic_inc_return(&clkdm->usecount) > 1) && autodeps)
>  		return 0;
>  
>  	/* Clockdomain now has one enabled downstream clock */
> diff --git a/arch/arm/mach-omap2/clockdomain44xx.c b/arch/arm/mach-omap2/clockdomain44xx.c
> index a1a4ecd..6f38d47 100644
> --- a/arch/arm/mach-omap2/clockdomain44xx.c
> +++ b/arch/arm/mach-omap2/clockdomain44xx.c
> @@ -95,13 +95,8 @@ static void omap4_clkdm_deny_idle(struct clockdomain *clkdm)
>  
>  static int omap4_clkdm_clk_enable(struct clockdomain *clkdm)
>  {
> -	bool hwsup = false;
> -
> -	hwsup = omap4_cminst_is_clkdm_in_hwsup(clkdm->prcm_partition,
> -					clkdm->cm_inst, clkdm->clkdm_offs);
> -
> -	if (!hwsup)
> -		clkdm_wakeup(clkdm);
> +	/* For every clock enable, force wakeup the clkdm */
> +	clkdm_wakeup(clkdm);
>  
>  	return 0;
>  }
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
