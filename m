From: Kevin Hilman <khilman@ti.com>
Subject: Re: PM related performance degradation on OMAP3
Date: Mon, 07 May 2012 10:31:18 -0700
Message-ID: <878vh36gpl.fsf@ti.com>
References: <CANOLnOP5gq4Vtt00SgRNW-3GZDWk0sukBgJx4V6rkMLL+b6G-w@mail.gmail.com>
	<877gxobudk.fsf@ti.com>
	<CANOLnOPbHBshCdbmSOjYdubWqUivrVpR-+eaayu=v4Yy6yKdsQ@mail.gmail.com>
	<87ehrtn6na.fsf@ti.com>
	<CANOLnOM_-yhr-j=UO3ynJ6HyJxzd_2FshPMXMLpcBcOB0mL7Qw@mail.gmail.com>
	<87y5puwhus.fsf@ti.com>
	<CAORVsuWP72dHFSBhX=Kux7GEk33qQgR74a74FFwzA8uniSabAQ@mail.gmail.com>
	<877gx5dwz2.fsf@ti.com>
	<CAORVsuXX9c+8-uJ1e1U920_jy0MK53jmCu+hXhHaXapHArMeLg@mail.gmail.com>
	<87txzzhkvh.fsf@ti.com>
	<CAORVsuV811jk7MsjyA4xKSbo+baU2z+eNjKqkA1ZH+3r+aiONg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:54205 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756105Ab2EGRbI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 May 2012 13:31:08 -0400
Received: by pbbrq2 with SMTP id rq2so5766352pbb.6
        for <linux-omap@vger.kernel.org>; Mon, 07 May 2012 10:31:04 -0700 (PDT)
In-Reply-To: <CAORVsuV811jk7MsjyA4xKSbo+baU2z+eNjKqkA1ZH+3r+aiONg@mail.gmail.com>
	(Jean Pihet's message of "Wed, 2 May 2012 21:46:40 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

Jean Pihet <jean.pihet@newoldbits.com> writes:

> On Tue, May 1, 2012 at 7:27 PM, Kevin Hilman <khilman@ti.com> wrote:
>> Jean Pihet <jean.pihet@newoldbits.com> writes:
>>
>>> HI Kevin, Grazvydas,
>>>
>>> On Tue, Apr 24, 2012 at 4:29 PM, Kevin Hilman <khilman@ti.com> wrot=
e:
>>>> Jean Pihet <jean.pihet@newoldbits.com> writes:
>>>>
>>>>> Hi Grazvydas, Kevin,
>>>>>
>>>>> I did some gather some performance measurements and statistics us=
ing
>>>>> custom tracepoints in __omap3_enter_idle.
>>> I posted the patches for the power domains registers cache, cf.
>>> http://marc.info/?l=3Dlinux-omap&m=3D133587781712039&w=3D2.
>>>
>>>>> All the details are at
>>>>> http://www.omappedia.org/wiki/Power_Management_Device_Latencies_M=
easurement#C1_performance_problem:_analysis
>>> I updated the page with the measurements results with Kevin's patch=
es
>>> and the registers cache patches.
>>>
>>> The results are showing that:
>>> - the registers cache optimizes the low power mode transitions, but=
 is
>>> not sufficient to obtain a big gain. A few unused domains are
>>> transitioning, which causes a big penalty in the idle path.
>>
>> PER is the one that seems to be causing the most latency.
>>
>> Can you try do your measurements using hack below which makes sure t=
hat
>> PER isn't any deeper than CORE?
>
> Indeed your patch brings significant improvements, cf. wiki page at
> http://www.omappedia.org/wiki/Power_Management_Device_Latencies_Measu=
rement#C1_performance_problem:_analysis
> for detailed information.
> Here below is the reworked patch, more suited for inclusion in mainli=
ne [1]
>
> I have another optimisation -in proof of concept state- that brings
> another significant improvement. It is about allowing/disabling idle
> for only 1 clkdm in a pwrdm and not iterate through all the clkdms.
> This still needs some rework though. Cf. patch [2]

That should work since disabling idle for any clkdm will have the same
effect.  Can you send this as a separate patch with a descriptive
changelog.

Kevin


> Patches [1] and [2] on top of the registers cache and the
> optimisations in pre/post_transition bring the performance close to
> the performance for the non cpuidle case (3.0MB/s compared to 3.1MB/s
> on Beagleboard).
>
> What do you think?
>
> Regards,
> Jean
>
> ---
> [1]
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c
> b/arch/arm/mach-omap2/cpuidle34xx.c
> index e406d7b..572b605 100644
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -279,32 +279,36 @@ static int omap3_enter_idle_bm(struct cpuidle_d=
evice *dev,
> 	int ret;
>
> 	/*
> -	 * Prevent idle completely if CAM is active.
> +	 * Use only C1 if CAM is active.
> 	 * CAM does not have wakeup capability in OMAP3.
> 	 */
> -	if (pwrdm_read_func_pwrst(cam_pd) =3D=3D PWRDM_FUNC_PWRST_ON) {
> +	if (pwrdm_read_func_pwrst(cam_pd) =3D=3D PWRDM_FUNC_PWRST_ON)
> 		new_state_idx =3D drv->safe_state_index;
> -		goto select_state;
> -	}
> -
> -	new_state_idx =3D next_valid_state(dev, drv, index);
> +	else
> +		new_state_idx =3D next_valid_state(dev, drv, index);
>
> -	/*
> -	 * Prevent PER off if CORE is not in retention or off as this
> -	 * would disable PER wakeups completely.
> -	 */
> +	/* Program PER state */
> 	cx =3D cpuidle_get_statedata(&dev->states_usage[new_state_idx]);
> 	core_next_state =3D cx->core_state;
> -	per_next_state =3D per_saved_state =3D pwrdm_read_next_func_pwrst(p=
er_pd);
> -	if ((per_next_state =3D=3D PWRDM_FUNC_PWRST_OFF) &&
> -	    (core_next_state > PWRDM_FUNC_PWRST_CSWR))
> -		per_next_state =3D PWRDM_FUNC_PWRST_CSWR;
> +	if (new_state_idx =3D=3D 0) {
> +		/* In C1 do not allow PER state lower than CORE state */
> +		per_next_state =3D core_next_state;
> +	} else {
> +		/*
> +		 * Prevent PER off if CORE is not in RETention or OFF as this
> +		 * would disable PER wakeups completely.
> +		 */
> +		per_next_state =3D per_saved_state =3D
> +				pwrdm_read_next_func_pwrst(per_pd);
> +		if ((per_next_state =3D=3D PWRDM_FUNC_PWRST_OFF) &&
> +		    (core_next_state > PWRDM_FUNC_PWRST_CSWR))
> +			per_next_state =3D PWRDM_FUNC_PWRST_CSWR;
> +	}
>
> 	/* Are we changing PER target state? */
> 	if (per_next_state !=3D per_saved_state)
> 		omap_set_pwrdm_state(per_pd, per_next_state);
>
> -select_state:
> 	ret =3D omap3_enter_idle(dev, drv, new_state_idx);
>
> 	/* Restore original PER state if it was modified */
> @@ -390,7 +394,6 @@ int __init omap3_idle_init(void)
>
> 	/* C1 . MPU WFI + Core active */
> 	_fill_cstate(drv, 0, "MPU ON + CORE ON");
> -	(&drv->states[0])->enter =3D omap3_enter_idle;
> 	drv->safe_state_index =3D 0;
> 	cx =3D _fill_cstate_usage(dev, 0);
> 	cx->valid =3D 1;	/* C1 is always valid */
>
> [2]
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c
> b/arch/arm/mach-omap2/cpuidle34xx.c
> index e406d7b..6aa3c75 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -118,8 +118,10 @@ static int __omap3_enter_idle(struct cpuidle_dev=
ice *dev,
>
>  	/* Deny idle for C1 */
>  	if (index =3D=3D 0) {
> -		pwrdm_for_each_clkdm(mpu_pd, _cpuidle_deny_idle);
> -		pwrdm_for_each_clkdm(core_pd, _cpuidle_deny_idle);
> +		//pwrdm_for_each_clkdm(mpu_pd, _cpuidle_deny_idle);
> +		clkdm_deny_idle(mpu_pd->pwrdm_clkdms[0]);
> +		//pwrdm_for_each_clkdm(core_pd, _cpuidle_deny_idle);
> +		clkdm_deny_idle(core_pd->pwrdm_clkdms[0]);
>  	}
>
>  	/*
> @@ -141,8 +143,10 @@ static int __omap3_enter_idle(struct cpuidle_dev=
ice *dev,
>
>  	/* Re-allow idle for C1 */
>  	if (index =3D=3D 0) {
> -		pwrdm_for_each_clkdm(mpu_pd, _cpuidle_allow_idle);
> -		pwrdm_for_each_clkdm(core_pd, _cpuidle_allow_idle);
> +		//pwrdm_for_each_clkdm(mpu_pd, _cpuidle_allow_idle);
> +		clkdm_allow_idle(mpu_pd->pwrdm_clkdms[0]);
> +		//pwrdm_for_each_clkdm(core_pd, _cpuidle_allow_idle);
> +		clkdm_allow_idle(core_pd->pwrdm_clkdms[0]);
>  	}
>
>  return_sleep_time:
>
>>
>> Kevin
>>
>> From bb2f67ed93dc83c645080e293d315d383c23c0c6 Mon Sep 17 00:00:00 20=
01
>> From: Kevin Hilman <khilman@ti.com>
>> Date: Mon, 16 Apr 2012 17:53:14 -0700
>> Subject: [PATCH] cpuidle34xx: per follows core, C1 use _bm
>>
>> ---
>> =C2=A0arch/arm/mach-omap2/cpuidle34xx.c | =C2=A0 =C2=A09 +++++----
>> =C2=A01 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2=
/cpuidle34xx.c
>> index 374708d..00400ad 100644
>> --- a/arch/arm/mach-omap2/cpuidle34xx.c
>> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
>> @@ -278,9 +278,11 @@ static int omap3_enter_idle_bm(struct cpuidle_d=
evice *dev,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0cx =3D cpuidle_get_statedata(&dev->states=
_usage[index]);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0core_next_state =3D cx->core_state;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0per_next_state =3D per_saved_state =3D pw=
rdm_read_next_pwrst(per_pd);
>> - =C2=A0 =C2=A0 =C2=A0 if ((per_next_state =3D=3D PWRDM_POWER_OFF) &=
&
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (core_next_state > PWRDM_POWER_=
RET))
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 per_next_state =3D=
 PWRDM_POWER_RET;
>> + =C2=A0 =C2=A0 =C2=A0 /* if ((per_next_state =3D=3D PWRDM_POWER_OFF=
) && */
>> + =C2=A0 =C2=A0 =C2=A0 /* =C2=A0 =C2=A0 (core_next_state > PWRDM_POW=
ER_RET)) */
>> + =C2=A0 =C2=A0 =C2=A0 /* =C2=A0 =C2=A0 =C2=A0per_next_state =3D PWR=
DM_POWER_RET; */
>> + =C2=A0 =C2=A0 =C2=A0 if (per_next_state < core_next_state)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 per_next_state =3D=
 core_next_state;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Are we changing PER target state? */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (per_next_state !=3D per_saved_state)
>> @@ -374,7 +376,6 @@ int __init omap3_idle_init(void)
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* C1 . MPU WFI + Core active */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0_fill_cstate(drv, 0, "MPU ON + CORE ON");
>> - =C2=A0 =C2=A0 =C2=A0 (&drv->states[0])->enter =3D omap3_enter_idle=
;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0drv->safe_state_index =3D 0;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0cx =3D _fill_cstate_usage(dev, 0);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0cx->valid =3D 1; =C2=A0/* C1 is always va=
lid */
>> --
>> 1.7.9.2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
