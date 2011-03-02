From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCH 1/3] OMAP3 PM: Deny clock gating only for safe state
Date: Wed, 2 Mar 2011 22:44:46 +0530
Message-ID: <e295d93b87df63e95a46e625d7422433@mail.gmail.com>
References: <1297846874-18286-1-git-send-email-vishwanath.bs@ti.com><1297846874-18286-2-git-send-email-vishwanath.bs@ti.com>
 <87mxleimh6.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:52040 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755280Ab1CBRPC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 12:15:02 -0500
Received: by mail-vx0-f176.google.com with SMTP id 40so190101vxi.35
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 09:15:01 -0800 (PST)
In-Reply-To: <87mxleimh6.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org

Kevin,

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Wednesday, March 02, 2011 2:32 AM
> To: Vishwanath BS
> Cc: linux-omap@vger.kernel.org; patches@linaro.org
> Subject: Re: [PATCH 1/3] OMAP3 PM: Deny clock gating only for safe
> state
>
> Vishwanath BS <vishwanath.bs@ti.com> writes:
>
> > Currently clock gating for MPU and core are denied whenever C1 state
> is
> > selected.
>
> Yes, that is the definition of C1.
>
> > It should be denied only when safe state is selected.
>
> Why?
Clock gating in C1 will reduce overall power consumption and it should not
impact any functionality as well.
>
> This changes the definition and behavior of C1 depending on how it is
> entered.  Not a good idea IMO.
I thought of adding a new C state, keeping C1 definition unchanged. Then
we will not get the real power benefit since in case of C1, clock gating
will be prevented. Let me know if you have some suggestion.

Vishwa

>
> Kevin
>
>
> > Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> > ---
> >  arch/arm/mach-omap2/cpuidle34xx.c |   20 ++++++++++----------
> >  1 files changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-
> omap2/cpuidle34xx.c
> > index f8e35b3..1e4ec7f 100644
> > --- a/arch/arm/mach-omap2/cpuidle34xx.c
> > +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> > @@ -139,19 +139,9 @@ static int omap3_enter_idle(struct
> cpuidle_device *dev,
> >  	if (omap_irq_pending() || need_resched())
> >  		goto return_sleep_time;
> >
> > -	if (cx->type == OMAP3_STATE_C1) {
> > -		pwrdm_for_each_clkdm(mpu_pd, _cpuidle_deny_idle);
> > -		pwrdm_for_each_clkdm(core_pd, _cpuidle_deny_idle);
> > -	}
> > -
> >  	/* Execute ARM wfi */
> >  	omap_sram_idle();
> >
> > -	if (cx->type == OMAP3_STATE_C1) {
> > -		pwrdm_for_each_clkdm(mpu_pd, _cpuidle_allow_idle);
> > -		pwrdm_for_each_clkdm(core_pd, _cpuidle_allow_idle);
> > -	}
> > -
> >  return_sleep_time:
> >  	getnstimeofday(&ts_postidle);
> >  	ts_idle = timespec_sub(ts_postidle, ts_preidle);
> > @@ -315,8 +305,18 @@ static int omap3_enter_idle_bm(struct
> cpuidle_device *dev,
> >
> >  select_state:
> >  	dev->last_state = new_state;
> > +
> > +	if (new_state == dev->safe_state) {
> > +		pwrdm_for_each_clkdm(mpu_pd, _cpuidle_deny_idle);
> > +		pwrdm_for_each_clkdm(core_pd, _cpuidle_deny_idle);
> > +	}
> >  	ret = omap3_enter_idle(dev, new_state);
> >
> > +	if (new_state == dev->safe_state) {
> > +		pwrdm_for_each_clkdm(mpu_pd, _cpuidle_allow_idle);
> > +		pwrdm_for_each_clkdm(core_pd, _cpuidle_allow_idle);
> > +	}
> > +
> >  	/* Restore original PER state if it was modified */
> >  	if (per_next_state != per_saved_state)
> >  		pwrdm_set_next_pwrst(per_pd, per_saved_state);
