From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCHv2] PM : cpuidle - Update statistics for correct state
Date: Mon, 09 Mar 2009 12:08:14 +0200
Message-ID: <87wsazj9f5.fsf@trdhcp146196.ntc.nokia.com>
References: <1236455149-17017-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:25024 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbZCIKIe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Mar 2009 06:08:34 -0400
In-Reply-To: <1236455149-17017-1-git-send-email-premi@ti.com> (ext Sanjeev Premi's message of "Sat\, 7 Mar 2009 20\:45\:49 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Sanjeev Premi <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

ext Sanjeev Premi <premi@ti.com> writes:

> When 'enable_off_mode' is 0, and (mpu_state < PWRDM_POWER_RET)
> the local variables mpu_state and core_state are modified; but
> the usage count for the original state selected by the governor
> are updated.
>
> This patch updates the 'last_state' in the cpuidle driver to ensure
> that statistics for the correct state are updated.
>
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |   29 +++++++++++++++++++--------=
--
>  1 files changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/=
cpuidle34xx.c
> index 62fbb2e..b138abd 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -76,23 +76,32 @@ static int omap3_enter_idle(struct cpuidle_device=
 *dev,
>  {
>  	struct omap3_processor_cx *cx =3D cpuidle_get_statedata(state);
>  	struct timespec ts_preidle, ts_postidle, ts_idle;
> -	u32 mpu_state =3D cx->mpu_state, core_state =3D cx->core_state;
> -
> -	current_cx_state =3D *cx;
> +	u32 mpu_state, core_state;
> =20
>  	/* Used to keep track of the total time in idle */
>  	getnstimeofday(&ts_preidle);
> =20
> -	local_irq_disable();
> -	local_fiq_disable();
> -
> +	/*
> +	 * Adjust the idle state (if required).
> +	 * Also, ensure that usage statistics of correct state are updated.
> +	 */
>  	if (!enable_off_mode) {
> -		if (mpu_state < PWRDM_POWER_RET)
> -			mpu_state =3D PWRDM_POWER_RET;
> -		if (core_state < PWRDM_POWER_RET)
> -			core_state =3D PWRDM_POWER_RET;
> +		if (cx->type > OMAP3_STATE_C4) {
> +			state =3D &(dev->states[OMAP3_STATE_C4 - 1]);
> +			dev->last_state =3D state ;
> +
> +			cx =3D cpuidle_get_statedata(state);

There is still C3 where OFF is used for MPU. This needs to be taken
into account.

> +		}
>  	}
> =20
> +	current_cx_state =3D *cx;
> +
> +	mpu_state =3D cx->mpu_state;
> +	core_state =3D cx->core_state;
> +
> +	local_irq_disable();
> +	local_fiq_disable();
> +
>  	pwrdm_set_next_pwrst(mpu_pd, mpu_state);
>  	pwrdm_set_next_pwrst(core_pd, core_state);
> =20
> --=20
> 1.5.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Jouni H=C3=B6gander
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
