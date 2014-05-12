From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap4-panda-es boot issues with v3.15-rc4
Date: Mon, 12 May 2014 15:07:41 -0700
Message-ID: <20140512220741.GG5668@atomide.com>
References: <536B7E44.2040303@ti.com>
 <7hppjos2w2.fsf@paris.lan>
 <CAGa+x84VB3CXDm71JWxHx1-Qk1xVNeXdwUjZnb42_wg+piOzzA@mail.gmail.com>
 <20140508165558.GB2198@atomide.com>
 <20140508184055.GC2198@atomide.com>
 <7hha4zsyro.fsf@paris.lan>
 <536C9084.50209@ti.com>
 <7heh02ms82.fsf@paris.lan>
 <20140511155542.GD28266@atomide.com>
 <53713FCF.3000006@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:48568 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750866AbaELWHu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 18:07:50 -0400
Content-Disposition: inline
In-Reply-To: <53713FCF.3000006@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>, Roger Quadros <rogerq@ti.com>, "Menon, Nishanth" <nm@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Paul Walmsley <paul@pwsan.com>, Taras Kondratiuk <taras.kondratiuk@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, "Kristo, Tero" <t-kristo@ti.com>, Paul Burton <paul.burton@imgtec.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

* Santosh Shilimkar <santosh.shilimkar@ti.com> [140512 14:41]:
> On Sunday 11 May 2014 11:55 AM, Tony Lindgren wrote:
> > * Kevin Hilman <khilman@linaro.org> [140509 16:46]:
> >> Roger Quadros <rogerq@ti.com> writes:
> >>
> >>> Kevin,
> >>>
> >>> On 05/09/2014 01:15 AM, Kevin Hilman wrote:
> >>>> Tony Lindgren <tony@atomide.com> writes:
> >>>>
> >>>> [...]
> >>>>
> >>>>> ..but I think I found the cause for recent hangs on panda, just a wild
> >>>>> guess based on looking at the recent cpuidle patches after v3.14.
> >>>>>
> >>>>> Looks like reverting 0b89e9aa2856 (cpuidle: delay enabling interrupts
> >>>>> until all coupled CPUs leave idle) makes booting work reliably again
> >>>>> on panda.
> >>>>>
> >>>>> Can you guys confirm, so far no issues here after few boot tests,
> >>>>> but it might be too early to tell.
> >>>>
> >>>> Reverting that makes things a bit more stable, but it still eventually
> >>>> fails in the same way.  For me it took 8 boots for it to eventually
> >>>> fail.
> >>>>
> >>>> However, if I build with CONFIG_CPU_IDLE=n, it becomes much more stable
> >>>> (20+ boots in a row and still going.)
> >>>>
> >>>
> >>> Can you please test with CPU_IDLE enabled but C3 disabled as in below patch?
> >>> It worked for me 10/10 boots.
> >>
> >> Yup, it worked for me too for 10/10 boots in a row.
> > 
> > But what has caused this regression, does it work reliably with let's
> > say v3.13 or v3.12?
> > 
> IIRC things were stable till some CPUIDLE code consolidation happened.
> I don't recall exactly but some one did discuss about it a while back.

OK that's good to hear.
 
> Can you re-run your test-cases with patch at end of the email. This
> is just a hunch so don't blame me if I waste your time testing the
> patch.

Seems to work after adding "#include <linux/clockchips.h>". I did about 10
reboots and they all succeeded for me. Without your revert, I'm getting
a hang (with sysrq not working) about 1/3 of the boots.

Kevin, Roger, does the revert from Santosh work for you too?

BTW, I think the the RCU stall was/is a separate issue. That's different
where the system actually recovers after about a minute, or after sysrq
ctrl-a f h or l. Sorry, I no longer know if the RCU stall is only with the
older kernels around v3.10 time, or if it's still also happening.

Regards,

Tony
 
> From bdd30d68f8fa659aa0e3ce436f94029a7719036b Mon Sep 17 00:00:00 2001
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Date: Mon, 12 May 2014 17:37:59 -0400
> Subject: [PATCH] Revert "cpuidle / omap4 : use CPUIDLE_FLAG_TIMER_STOP flag"
> 
> This reverts commit cb7094e848f7bcaa0a4cda3db4b232f08dbf5b78.
> 
> Conflicts:
> 
> 	arch/arm/mach-omap2/cpuidle44xx.c
> ---
>  arch/arm/mach-omap2/cpuidle44xx.c |   11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
> index 01fc710..aae3606 100644
> --- a/arch/arm/mach-omap2/cpuidle44xx.c
> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
> @@ -83,6 +83,7 @@ static int omap_enter_idle_coupled(struct cpuidle_device *dev,
>  {
>  	struct idle_statedata *cx = state_ptr + index;
>  	u32 mpuss_can_lose_context = 0;
> +	int cpu_id = smp_processor_id();
>  
>  	/*
>  	 * CPU0 has to wait and stay ON until CPU1 is OFF state.
> @@ -110,6 +111,8 @@ static int omap_enter_idle_coupled(struct cpuidle_device *dev,
>  	mpuss_can_lose_context = (cx->mpu_state == PWRDM_POWER_RET) &&
>  				 (cx->mpu_logic_state == PWRDM_POWER_OFF);
>  
> +	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu_id);
> +
>  	/*
>  	 * Call idle CPU PM enter notifier chain so that
>  	 * VFP and per CPU interrupt context is saved.
> @@ -165,6 +168,8 @@ static int omap_enter_idle_coupled(struct cpuidle_device *dev,
>  	if (dev->cpu == 0 && mpuss_can_lose_context)
>  		cpu_cluster_pm_exit();
>  
> +	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu_id);
> +
>  fail:
>  	cpuidle_coupled_parallel_barrier(dev, &abort_barrier);
>  	cpu_done[dev->cpu] = false;
> @@ -189,8 +194,7 @@ static struct cpuidle_driver omap4_idle_driver = {
>  			/* C2 - CPU0 OFF + CPU1 OFF + MPU CSWR */
>  			.exit_latency = 328 + 440,
>  			.target_residency = 960,
> -			.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED |
> -			         CPUIDLE_FLAG_TIMER_STOP,
> +			.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED,
>  			.enter = omap_enter_idle_coupled,
>  			.name = "C2",
>  			.desc = "CPUx OFF, MPUSS CSWR",
> @@ -199,8 +203,7 @@ static struct cpuidle_driver omap4_idle_driver = {
>  			/* C3 - CPU0 OFF + CPU1 OFF + MPU OSWR */
>  			.exit_latency = 460 + 518,
>  			.target_residency = 1100,
> -			.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED |
> -			         CPUIDLE_FLAG_TIMER_STOP,
> +			.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED,
>  			.enter = omap_enter_idle_coupled,
>  			.name = "C3",
>  			.desc = "CPUx OFF, MPUSS OSWR",
> -- 
> 1.7.9.5
> 
> 
