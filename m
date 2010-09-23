From: "Basak, Partha" <p-basak2@ti.com>
Subject: RE: [PATCH 2/2] OMAP2+: GPIO: move late PM out of
 interrupts-disabled idle path
Date: Thu, 23 Sep 2010 18:24:06 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301F6FE85CD@dbde02.ent.ti.com>
References: <1284418958-5887-1-git-send-email-khilman@deeprootsystems.com>
	<1284418958-5887-3-git-send-email-khilman@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F6DF51AF@dbde02.ent.ti.com>
 <87d3sgs1nw.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51731 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753646Ab0IWMyQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 08:54:16 -0400
In-Reply-To: <87d3sgs1nw.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>, Tero Kristo <tero.kristo@nokia.com>

 

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Tuesday, September 14, 2010 10:28 PM
> To: Basak, Partha
> Cc: linux-omap@vger.kernel.org; Varadarajan, Charulatha; Tero Kristo
> Subject: Re: [PATCH 2/2] OMAP2+: GPIO: move late PM out of 
> interrupts-disabled idle path
> 
> "Basak, Partha" <p-basak2@ti.com> writes:
> 
> >> From: Kevin Hilman <khilman@ti.com>
> >> 
> >> Currently, we wait until late in the idle path where interrupts are
> >> disabled to do runtime-PM-like management for certain special-case
> >> devices like GPIO.
> >> 
> >> As a prerequiste to moving GPIO to the new runtime PM 
> framework, move
> >> this runtime-PM-like code out of the late idle path into new device
> >> idle and resume functions that can be called before interrupts are
> >> disabled by CPUidle and/or suspend.
> >> 
> >> In addition, move all the GPIO-specific logic into the GPIO core
> >> instead of keeping GPIO-specific knowledge of power-states, context
> >> saving etc. in the PM core.
> >> 
> >> Also, call the new device-idle and -resume methods from CPUidle and
> >> static suspend path.
> >> 
> >> Signed-off-by: Kevin Hilman <khilman@ti.com>
> >> ---
> >>  arch/arm/mach-omap2/cpuidle34xx.c      |    4 ++
> >>  arch/arm/mach-omap2/pm.h               |    2 +
> >>  arch/arm/mach-omap2/pm24xx.c           |    2 +-
> >>  arch/arm/mach-omap2/pm34xx.c           |   38 
> +++++++++------------
> >>  arch/arm/plat-omap/gpio.c              |   57 
> >> ++++++++++++++++++++++++--------
> >>  arch/arm/plat-omap/include/plat/gpio.h |    4 +--
> >>  6 files changed, 67 insertions(+), 40 deletions(-)
> >> 
> >> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c 
> >> b/arch/arm/mach-omap2/cpuidle34xx.c
> >> index 0923b82..681d823 100644
> >> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> >> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> >> @@ -274,9 +274,13 @@ static int omap3_enter_idle_bm(struct 
> >> cpuidle_device *dev,
> >>  		pwrdm_set_next_pwrst(per_pd, per_next_state);
> >>  
> >>  select_state:
> >> +	omap3_device_idle();
> >> +
> >>  	dev->last_state = new_state;
> >>  	ret = omap3_enter_idle(dev, new_state);
> >>  
> >> +	omap3_device_resume();
> >> +
> > In the generic cpu_idle() in process.c, interrupts are 
> already disabled
> > before control comes to cpuidle_idle_call() via pm_idle()
> > 			local_irq_disable();
> > 			if (hlt_counter) {
> > 				local_irq_enable();
> > 				cpu_relax();
> > 			} else {
> > 				stop_critical_timings();
> > 				pm_idle();
> > 				start_critical_timings();
> > 				/*
> > 				 * This will eventually be 
> removed - pm_idle
> > 				 * functions should always 
> return with IRQs
> > 				 * enabled.
> > 				 */
> > 				WARN_ON(irqs_disabled());
> > 				local_irq_enable();
> > 			}
> >
> > omap3_enter_idle_bm() will be called from inside 
> cpuidle_idle_call() 
> > via target_state->enter(dev, target_state).
> > So, interrupts are already disabled here.
> >
> > Am I missing something?
> 
> You're right.  
> 
> I knew this was the case for !CPUIDLE setup, but had thought (without
> testing) that the CPUidle core had re-enabled interrupts during the
> governor selection process etc.
> 
> While I investigate ways to manage this in CPUidle, the 
> following should
> be fine for now to include with $SUBJECT patch.
> 
> Kevin
> 
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c 
> b/arch/arm/mach-omap2/cpuidle34xx.c
> index 681d823..c5cb9d0 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -245,6 +245,14 @@ static int omap3_enter_idle_bm(struct 
> cpuidle_device *dev,
>  		goto select_state;
>  	}
>  
> +	/*
> +	 * Enable IRQs during the device activity checking and 
> idle management.
> +	 * IRQs are later (re)disabled when entering the actual 
> idle function.
> +	 * Device idle management that is using runtime PM needs to have
> +	 * interrupts enabled when calling into the runtime PM core.
> +	 */
> +	local_irq_enable();

After put_sync() retuns, there will be a time window where interrupts
are enabled but clocks are disabled before the interrupts are disabled again.
Accessing any register to service a device interrupt coming during this window
will lead to a crash for cases where iclk and fclks are same and we have the
iclk defined as the main_clk as well.

Same argument holds while returning from Idle. We are facing this issue for OMAP3 
GPIO while trying to define the main_clk = interface clock based on your other commment.


> +
>  	cx = cpuidle_get_statedata(state);
>  	core_next_state = cx->core_state;
>  
> k
> 