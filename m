From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv2] PM : cpuidle - Update statistics for correct state
Date: Wed, 11 Mar 2009 17:00:30 -0700
Message-ID: <87r613k3tt.fsf@deeprootsystems.com>
References: <1236455149-17017-1-git-send-email-premi@ti.com>
	<87wsazj9f5.fsf@trdhcp146196.ntc.nokia.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301CC185222@dbde02.ent.ti.com>
	<87ocwbj82x.fsf@trdhcp146196.ntc.nokia.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301CC18526D@dbde02.ent.ti.com>
	<87zlfuy3sb.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301CC1F6C1F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:13848 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbZCLAAf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 20:00:35 -0400
Received: by wf-out-1314.google.com with SMTP id 28so295660wfa.4
        for <linux-omap@vger.kernel.org>; Wed, 11 Mar 2009 17:00:33 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301CC1F6C1F@dbde02.ent.ti.com> (Sanjeev Premi's message of "Wed\, 11 Mar 2009 20\:04\:07 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: =?iso-8859-1?Q?H=F6gander?= Jouni <jouni.hogander@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Premi, Sanjeev" <premi@ti.com> writes:

>> 
>> I would gladly take a patch which uses the 'valid' field for 
>> this and then the enter hook whould drop to the next lower 
>> valid state if the state requested is not valid.
>> 
>> Kevin
>
> [sp] I have not yet tested it (working offline for sometime).
>      But, wanted to share the changes for an early review.

Thanks, some comments below.

>      Initially, I was trying see if the CPUIDLE framework could
>      use ".valid" as an additional argument in cpuidle_state.
>      But, may be that's for later...

Yeah, I looked at that too, but it currently doesn't have a concept
of valid states, so for now I recommend we implement that in the
OMAP-specific code as you have done.

> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx
> index c25158c..9493553 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -88,16 +88,19 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
>                 goto return_sleep_time;
>
>         /*
> +        * Check if the chosen idle state is valid.
> +        * If no, drop down to a lower valid state. Expects the lowest
> +        * state will always be active.
>          */
> +       if (!cx->valid) {
> +               for (idx = (cx->type - 1); idx == 1; idx--) {
                                             ^^^^^^^^

I think you mean idx >= 1 here.

Also, while you're working on this, could you fix this up so the
omap3_power_states[] array is zero based insted of 1-based, it would
make this code and the other code walking this array easier to follow.

That means defining OMAP_STATE_C1 = 0 and so on.

> +                       if (omap3_power_states[idx].valid)
> +                               break;
>                 }
> +               state = &(dev->states[idx]);
> +               dev->last_state = state ;
> +
> +               cx = cpuidle_get_statedata(state);
>         }
>
>         current_cx_state = *cx;
> @@ -150,6 +153,26 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
>         return omap3_enter_idle(dev, new_state);
>  }
>
> +/**
> + * omap3_toggle_off_states - Enable / Disable validity of idle states
> + * @flag: Enable/ Disable support for OFF mode
> + *
> + * Called as result of change to "enable_off_mode".
> + */
> +void omap3_toggle_off_states(unsigned short flag)
> +{

How about calling this omap3_cpuidle_update_states() and taking
no arguments.  Rather than the 'flag' argument, internally it
just checks the global 'enable_off_mode.'

This allows for potential further expansion down the road of other
reasons to update CPUidle valid states.  For example, we've talked
about updating the CPUidle state latencies on the fly depending on
various other chip settings.

> +       if (flag) {
> +               omap3_power_states[OMAP3_STATE_C3].valid = 1;
> +               omap3_power_states[OMAP3_STATE_C5].valid = 1;
> +               omap3_power_states[OMAP3_STATE_C6].valid = 1;
> +       }
> +       else {
> +               omap3_power_states[OMAP3_STATE_C3].valid = 0;
> +               omap3_power_states[OMAP3_STATE_C5].valid = 0;
> +               omap3_power_states[OMAP3_STATE_C6].valid = 0;
> +       }
> +}
> +

Rather than set set specific OMAP3_STATE_Cx values, it would be better
to just walk the array, and check for [mpu|core]_state = PWRDM_POWER_OFF.
If the state has either set, then update the valid flag.

>  DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
>
>  /* omap3_init_power_states - Initialises the OMAP3 specific C states.
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 61c6dfb..6785850 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -47,6 +47,8 @@ atomic_t sleep_block = ATOMIC_INIT(0);
>  static int vdd1_locked;
>  static int vdd2_locked;
>
> +extern void omap3_toggle_off_states(unsigned short);
> +

Move the definition into pm.h as omap3_cpuidle_update_states(void) as
described above.

>  static ssize_t idle_show(struct kobject *, struct kobj_attribute *, char *);
>  static ssize_t idle_store(struct kobject *k, struct kobj_attribute *,
>                           const char *buf, size_t n);
> @@ -112,6 +114,8 @@ static ssize_t idle_store(struct kobject *kobj, struct kobj_
>         } else if (attr == &enable_off_mode_attr) {
>                 enable_off_mode = value;
>                 omap3_pm_off_mode_enable(enable_off_mode);
> +               if (cpu_is_omap34xx())
> +                       omap3_toggle_off_states(value);

Then, don't modify pm.c, rather just call omap3_cpuidle_update_states() from
omap3_pm_off_mode_enable().

Kevin
