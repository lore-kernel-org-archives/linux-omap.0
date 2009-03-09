From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv2] PM : cpuidle - Update statistics for correct state
Date: Mon, 09 Mar 2009 11:00:52 -0700
Message-ID: <87zlfuy3sb.fsf@deeprootsystems.com>
References: <1236455149-17017-1-git-send-email-premi@ti.com>
	<87wsazj9f5.fsf@trdhcp146196.ntc.nokia.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301CC185222@dbde02.ent.ti.com>
	<87ocwbj82x.fsf@trdhcp146196.ntc.nokia.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301CC18526D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:32798 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbZCISBF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Mar 2009 14:01:05 -0400
Received: by rv-out-0506.google.com with SMTP id g37so1763906rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 09 Mar 2009 11:01:03 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301CC18526D@dbde02.ent.ti.com> (Sanjeev Premi's message of "Mon\, 9 Mar 2009 16\:16\:06 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: =?iso-8859-1?Q?H=F6gander?= Jouni <jouni.hogander@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Premi, Sanjeev" <premi@ti.com> writes:

> =20
>
>> -----Original Message-----
>> From: H=F6gander Jouni [mailto:jouni.hogander@nokia.com]=20
>> Sent: Monday, March 09, 2009 4:07 PM
>> To: Premi, Sanjeev
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: [PATCHv2] PM : cpuidle - Update statistics for=20
>> correct state
>>=20
>> "ext Premi, Sanjeev" <premi@ti.com> writes:
>>=20
>> >> -----Original Message-----
>> >> From: H=F6gander Jouni [mailto:jouni.hogander@nokia.com]
>> >> Sent: Monday, March 09, 2009 3:38 PM
>> >> To: Premi, Sanjeev
>> >> Cc: linux-omap@vger.kernel.org
>> >> Subject: Re: [PATCHv2] PM : cpuidle - Update statistics=20
>> for correct=20
>> >> state
>> >>=20
>> >> ext Sanjeev Premi <premi@ti.com> writes:
>> >>=20
>> >> > When 'enable_off_mode' is 0, and (mpu_state <=20
>> PWRDM_POWER_RET) the=20
>> >> > local variables mpu_state and core_state are modified; but
>> >> the usage
>> >> > count for the original state selected by the governor=20
>> are updated.
>> >> >
>> >> > This patch updates the 'last_state' in the cpuidle=20
>> driver to ensure=20
>> >> > that statistics for the correct state are updated.
>> >> >
>> >> > Signed-off-by: Sanjeev Premi <premi@ti.com>
>> >> > ---
>> >> >  arch/arm/mach-omap2/cpuidle34xx.c |   29=20
>> >> +++++++++++++++++++----------
>> >> >  1 files changed, 19 insertions(+), 10 deletions(-)
>> >> >
>> >> > diff --git a/arch/arm/mach-omap2/cpuidle34xx.c
>> >> > b/arch/arm/mach-omap2/cpuidle34xx.c
>> >> > index 62fbb2e..b138abd 100644
>> >> > --- a/arch/arm/mach-omap2/cpuidle34xx.c
>> >> > +++ b/arch/arm/mach-omap2/cpuidle34xx.c
>> >> > @@ -76,23 +76,32 @@ static int omap3_enter_idle(struct
>> >> cpuidle_device
>> >> > *dev,  {
>> >> >  	struct omap3_processor_cx *cx =3D=20
>> cpuidle_get_statedata(state);
>> >> >  	struct timespec ts_preidle, ts_postidle, ts_idle;
>> >> > -	u32 mpu_state =3D cx->mpu_state, core_state =3D=20
>> cx->core_state;
>> >> > -
>> >> > -	current_cx_state =3D *cx;
>> >> > +	u32 mpu_state, core_state;
>> >> > =20
>> >> >  	/* Used to keep track of the total time in idle */
>> >> >  	getnstimeofday(&ts_preidle);
>> >> > =20
>> >> > -	local_irq_disable();
>> >> > -	local_fiq_disable();
>> >> > -
>> >> > +	/*
>> >> > +	 * Adjust the idle state (if required).
>> >> > +	 * Also, ensure that usage statistics of correct state
>> >> are updated.
>> >> > +	 */
>> >> >  	if (!enable_off_mode) {
>> >> > -		if (mpu_state < PWRDM_POWER_RET)
>> >> > -			mpu_state =3D PWRDM_POWER_RET;
>> >> > -		if (core_state < PWRDM_POWER_RET)
>> >> > -			core_state =3D PWRDM_POWER_RET;
>> >> > +		if (cx->type > OMAP3_STATE_C4) {
>> >> > +			state =3D=20
>> &(dev->states[OMAP3_STATE_C4 - 1]);
>> >> > +			dev->last_state =3D state ;
>> >> > +
>> >> > +			cx =3D cpuidle_get_statedata(state);
>> >>=20
>> >> There is still C3 where OFF is used for MPU. This needs to=20
>> be taken=20
>> >> into account.
>> >
>> > [sp] Thanks. Good catch!
>> >      I wasn't happy doing the "OMAP3_STATEn - 1"; but could=20
>> not find a better way.
>> >      It should be C2 as defined now.
>>=20
>> This means C4 is not used if off mode is not enabled? I think=20
>> this is not wanted. Would it be possible to remove "OFF" C=20
>> states when enable_off_mode is written to 0 and add them back=20
>> when 1 written?
>
> [sp] That should be possible. We could use the 'valid' field
>      for the purpose.

I would gladly take a patch which uses the 'valid' field for this
and then the enter hook whould drop to the next lower valid state
if the state requested is not valid.

Kevin


>
>> >
>> >      On another note, would it make sense to swap the=20
>> definitions for C3 and C4.
>> >      C3 : MPU CSWR + CORE CSWR
>> >      C4 : MPU OFF + CORE Actove
>>=20
>> No it doesn't. They are organized by latency.
>
> [sp] Okay. That was a loud thinking from my side :)
>>=20
>> One grounding for current implementation is that=20
>> enable_off_mode is more or less testing interface. In final=20
>> solution it might be even removed. Adjusting states directly=20
>> still shows guite accurate information on used C-states.
>>=20
>> >
>> >>=20
>> >> > +		}
>> >> >  	}
>> >> > =20
>> >> > +	current_cx_state =3D *cx;
>> >> > +
>> >> > +	mpu_state =3D cx->mpu_state;
>> >> > +	core_state =3D cx->core_state;
>> >> > +
>> >> > +	local_irq_disable();
>> >> > +	local_fiq_disable();
>> >> > +
>> >> >  	pwrdm_set_next_pwrst(mpu_pd, mpu_state);
>> >> >  	pwrdm_set_next_pwrst(core_pd, core_state);
>> >> > =20
>> >> > --
>> >> > 1.5.6
>> >> >
>> >> > --
>> >> > To unsubscribe from this list: send the line "unsubscribe
>> >> linux-omap"=20
>> >> > in the body of a message to majordomo@vger.kernel.org More
>> >> majordomo
>> >> > info at  http://vger.kernel.org/majordomo-info.html
>> >>=20
>> >> --
>> >> Jouni H=F6gander
>> >>=20
>> >>=20
>>=20
>> --
>> Jouni H=F6gander
>>=20
>> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
