From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH] PM: Fixed clockdomain state control for OMAP3
Date: Fri, 19 Sep 2008 17:08:36 +0300
Message-ID: <87vdws1b4r.fsf@trdhcp146196.ntc.nokia.com>
References: <1221582816-21372-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:16408 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753925AbYISOHb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Sep 2008 10:07:31 -0400
In-Reply-To: <1221582816-21372-1-git-send-email-tero.kristo@nokia.com> (ext
	Tero Kristo's message of "Tue, 16 Sep 2008 19:33:36 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org, ext Rajendra Nayak <rnayak@ti.com>

"ext Tero Kristo" <tero.kristo@nokia.com> writes:

> Hardware supervised control for clockdomain power state transitions n=
ow
> enabled in omap3_pm_init(). Also fixed set_pwrdm_state() to allow sta=
te
> changes between sleep states (i.e. RET<->OFF.)

Yes you are right here. Denying idle doesn't make sure that related
pwrdm is woken up.

Rajendra, after this patch is applied, it is probably enough if you set
just next state for core and mpu domains in cpuidle. No need to call
set_pwrdm_state from pm34xx.c.

Acked-by: Jouni H=C3=B6gander <jouni.hogander@nokia.com>

>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |   38 +++++++++++++++++++-------------=
------
>  1 files changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34x=
x.c
> index 01b637a..2bccdab 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -227,28 +227,13 @@ static int omap3_can_sleep(void)
>  	return 1;
>  }
> =20
> -/* _clkdm_deny_idle - private callback function used by set_pwrdm_st=
ate() */
> -static int _clkdm_deny_idle(struct powerdomain *pwrdm,
> -			    struct clockdomain *clkdm)
> -{
> -	omap2_clkdm_deny_idle(clkdm);
> -	return 0;
> -}
> -
> -/* _clkdm_allow_idle - private callback function used by set_pwrdm_s=
tate() */
> -static int _clkdm_allow_idle(struct powerdomain *pwrdm,
> -			     struct clockdomain *clkdm)
> -{
> -	omap2_clkdm_allow_idle(clkdm);
> -	return 0;
> -}
> -
>  /* This sets pwrdm state (other than mpu & core. Currently only ON &
>   * RET are supported. Function is assuming that clkdm doesn't have
>   * hw_sup mode enabled. */
>  static int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
>  {
>  	u32 cur_state;
> +	int sleep_switch =3D 0;
>  	int ret =3D 0;
> =20
>  	if (pwrdm =3D=3D NULL || IS_ERR(pwrdm))
> @@ -259,8 +244,12 @@ static int set_pwrdm_state(struct powerdomain *p=
wrdm, u32 state)
>  	if (cur_state =3D=3D state)
>  		return ret;
> =20
> -	pwrdm_for_each_clkdm(pwrdm, _clkdm_deny_idle);
> -
> +	if (pwrdm_read_pwrst(pwrdm) < PWRDM_POWER_ON) {
> +		omap2_clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
> +		sleep_switch =3D 1;
> +		pwrdm_wait_transition(pwrdm);
> +	}
> +
>  	ret =3D pwrdm_set_next_pwrst(pwrdm, state);
>  	if (ret) {
>  		printk(KERN_ERR "Unable to set state of powerdomain: %s\n",
> @@ -268,7 +257,10 @@ static int set_pwrdm_state(struct powerdomain *p=
wrdm, u32 state)
>  		goto err;
>  	}
> =20
> -	pwrdm_for_each_clkdm(pwrdm, _clkdm_allow_idle);
> +	if (sleep_switch) {
> +		omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
> +		pwrdm_wait_transition(pwrdm);
> +	}
> =20
>  err:
>  	return ret;
> @@ -540,6 +532,12 @@ static int __init pwrdms_setup(struct powerdomai=
n *pwrdm)
>  	return set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
>  }
> =20
> +static int __init clkdms_setup(struct clockdomain *clkdm)
> +{
> +	omap2_clkdm_allow_idle(clkdm);
> +	return 0;
> +}
> +
>  int __init omap3_pm_init(void)
>  {
>  	struct power_state *pwrst;
> @@ -566,6 +564,8 @@ int __init omap3_pm_init(void)
>  		goto err2;
>  	}
> =20
> +	(void) clkdm_for_each(clkdms_setup);
> +
>  	mpu_pwrdm =3D pwrdm_lookup("mpu_pwrdm");
>  	if (mpu_pwrdm =3D=3D NULL) {
>  		printk(KERN_ERR "Failed to get mpu_pwrdm\n");


--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
