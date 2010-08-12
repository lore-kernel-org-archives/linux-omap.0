From: "Basak, Partha" <p-basak2@ti.com>
Subject: RE: [PATCH 12/13 v5] OMAP: GPIO: Use dev_pm_ops instead of
 sys_dev_class
Date: Thu, 12 Aug 2010 13:19:52 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E80ACFD0@dbde02.ent.ti.com>
References: <1281098065-24177-1-git-send-email-charu@ti.com>
	<1281098065-24177-2-git-send-email-charu@ti.com>
	<1281098065-24177-3-git-send-email-charu@ti.com>
	<1281098065-24177-4-git-send-email-charu@ti.com>
	<1281098065-24177-5-git-send-email-charu@ti.com>
	<1281098065-24177-6-git-send-email-charu@ti.com>
	<1281098065-24177-7-git-send-email-charu@ti.com>
	<1281098065-24177-8-git-send-email-charu@ti.com>
	<1281098065-24177-9-git-send-email-charu@ti.com>
	<1281098065-24177-10-git-send-email-charu@ti.com>
	<1281098065-24177-11-git-send-email-charu@ti.com>
	<1281098065-24177-12-git-send-email-charu@ti.com>
	<1281098065-24177-13-git-send-email-charu@ti.com>
	<871va79v28.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E80AC458@dbde02.ent.ti.com>
 <87fwym5og4.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39092 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753594Ab0HLHuC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Aug 2010 03:50:02 -0400
In-Reply-To: <87fwym5og4.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Tuesday, August 10, 2010 11:40 PM
> To: Basak, Partha
> Cc: Varadarajan, Charulatha; linux-omap@vger.kernel.org; paul@pwsan.com;
> Cousson, Benoit; Nayak, Rajendra
> Subject: Re: [PATCH 12/13 v5] OMAP: GPIO: Use dev_pm_ops instead of
> sys_dev_class
> 
> "Basak, Partha" <p-basak2@ti.com> writes:
> 
> [...]
> 
> >> > In the idle path (interrupt disabled context), PM runtime APIs cannot
> >> > be used as they are not mutex-free functions. Hence omap_device APIs
> >> > are used in the idle and resume after idle path.
> >>
> >> This needs much more fleshing out.
> >>
> >> Exactly what mutexes are causing the problems here.  As pointed out in
> >> previous discussions, the ones in the PM runtime core should not be a
> >> problem in this path.  Therefore, I'll assume the problems are coming
> >> from the mutexes when the device code (mach-omap2/gpio.c) calls into
> the
> >> hwmod layer.  More on this in comments on the next patch.
> >>
> >
> > Sorry, this has not been documented correctly. The issue has more to
> > do unconditional enabling of interrupts. We have received a patch from
> > you on using pm_runtime functions in Idle path. We will try on GPIO
> > and revert back.
> 
> OK
> 
> >
> >> > To summarize,
> >> > 1. pm_runtime_get_sync() for any gpio bank is called when one of the
> >> gpios
> >> >    is requested on the bank, in which, no other gpio is being used
> (when
> >> >    mod_usage becomes non-zero)
> >> > 2. omap_device_enable() is called during gpio resume after idle, only
> >> >    if the particular bank is being used (if mod_usage is non-zero)
> >>
> >> context is saved/restored in the idle path, but...
> >>
> >> > 3. pm_runtime_put_sync() is called when the last used gpio in that
> >> >    gpio bank is freed (when mod_usage becomes zero)
> >>
> >> in this path, the bank is now runtime suspended, but context has not
> >> been saved for it.  That should be fine, since this bank is no longer
> >> used, but now let's assume there was an off-mode transition and context
> >> is lost.  Then, gpio_request() is called which will trigger
> >> a pm_runtime_get_sync() and gpio_bank_runtime_resume() will be called.
> >>
> >> In this case, it's not terribly clear that runtime_resume is doing sane
> >> things if context has just been lost.  Seems like runtime_resume should
> >> be a nop in this case since any re-init will be be done in
> gpio_request().
> >
> > Runtime_suspend/resume for GPIO is not doing any save/restore
> > context. In that sense, they are NOP. Context save/restore is taken
> > care of only in the Idle path based on target power state and last
> > power state respectively.
> 
> OK, I didn't explain the problem I'm suspecting very well.  Imagine this
> sequence of events:
> 
> - mod_usage becomes zero
> - pm_runtime_put_sync()
> - gpio_bank_runtime_suspend()  [ no context is saved ]
>   [ off-mode transition, context is lost]
> - gpio_request()
> - pm_runtime_get_sync()
> - gpio_bank_runtime_resume()
> 
> In this path, no context is saved, and no context is restored, which is
> what I would expect, since there's no need to save context if nobody is
> using that gpio bank anymore.   However, gpio_bank_runtime_resume() is
> doing lots of reads/writes and read-modify-writes on GPIO bank registers
> that may have undefined contents after a context loss.
> 
> The point is that the GPIO register twiddling in
> gpio_bank_runtime_resume() does not seem to be needed if there are no
> users of that GPIO bank.
> 
> [...]
> 
> >> >  static void omap3_enable_io_chain(void)
> >> >  {
> >> >  	int timeout = 0;
> >> > @@ -395,15 +385,17 @@ void omap_sram_idle(void)
> >> >  	/* PER */
> >> >  	if (per_next_state < PWRDM_POWER_ON) {
> >> >  		omap_uart_prepare_idle(2);
> >> > -		omap2_gpio_prepare_for_idle(per_next_state);
> >> >  		if (per_next_state == PWRDM_POWER_OFF) {
> >> >  			if (core_next_state == PWRDM_POWER_ON) {
> >> >  				per_next_state = PWRDM_POWER_RET;
> >> >  				pwrdm_set_next_pwrst(per_pwrdm,
> per_next_state);
> >> >  				per_state_modified = 1;
> >> > -			} else
> >> > -				omap3_per_save_context();
> >> > +			}
> >> >  		}
> >> > +		if (per_next_state == PWRDM_POWER_OFF)
> >> > +			omap2_gpio_prepare_for_idle(true);
> >> > +		else
> >> > +			omap2_gpio_prepare_for_idle(false);
> >>
> >> Why is this better than passing the next power state?
> >
> > This would keep the GPIO function omap2_gpio_prepare_for_idle agnostic
> of Power state definition dependencies.
> >
> 
> And why is this better?
> 
> Personally, I think the GPIO code should be told about the powerdomain
> state so it can make it's own decision about whether or not to save
> context.
> 

I see your point. 

But, in the approach we have followed so far, we are trying to localize all Power domain related logic and information in pm_34xxx.c. If we refer to all 
other such functions like omap_uart_prepare_idle(),omap3_intc_prepare_idle(), musb_context_save_restore()(newly introduced by USB patches for HWMOD), they are all following the same paradigm. None of these functions receive the Power state information as a parameter. The idea is to segregate the Power domain related information into the power layer. 

In omap2_gpio_prepare_for_idle() implementation, we are just being consistent with this approach.

> Kevin
