From: "Rajendra Nayak" <rnayak@ti.com>
Subject: RE: [PATCH] OMAP3: CPUIDLE & PM: check_bm fix.
Date: Wed, 9 Jul 2008 12:45:51 +0530
Message-ID: <000c01c8e193$9f1f4d50$68bf18ac@ent.ti.com>
References: <1215519440-10234-1-git-send-email-jouni.hogander@nokia.com><1215584973-14982-1-git-send-email-jouni.hogander@nokia.com><000b01c8e18f$31708610$68bf18ac@ent.ti.com> <87tzezwnl1.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:51650 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751801AbYGIHQE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jul 2008 03:16:04 -0400
In-Reply-To: <87tzezwnl1.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?Q?'=22H=C3=B6gander=22_Jouni'?= <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

> -----Original Message-----
> From: "H=C3=B6gander" Jouni [mailto:jouni.hogander@nokia.com]=20
> Sent: Wednesday, July 09, 2008 12:29 PM
> To: ext Rajendra Nayak
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] OMAP3: CPUIDLE & PM: check_bm fix.
>=20
> "ext Rajendra Nayak" <rnayak@ti.com> writes:
>=20
> > =20
> >> -----Original Message-----
> >> From: Jouni Hogander [mailto:jouni.hogander@nokia.com]=20
> >> Sent: Wednesday, July 09, 2008 12:00 PM
> >> To: linux-omap@vger.kernel.org; rnayak@ti.com
> >> Subject: [PATCH] OMAP3: CPUIDLE & PM: check_bm fix.
> >>=20
> >> This patch fixes problems with uart usage. omap3_enter_idle_bm was
> >> select C5 and C6 states even if there was "bus activity.
> >
> > Am not very clear on what was the issue with the previous=20
> logic that it would=20
> > attempt a C5/C6 even with bus activity.
>=20
> If you try it you will notice the difference;) What is the meaning of
> this bm check if C5/C6 is used even when there is=20
> "acitivity".

No, What I meant to say was that the previous logic I thought was good =
enough to
*prevent* C5/C6 or any other state with CPUIDLE_FLAG_CHECK_BM flag set,=
 while there is=20
bus activity and then go ahead and select the highest possible state wi=
th=20
CPUIDLE_FLAG_CHECK_BM _not_ set.

 Anyway if
> you want to have bm check code in your cpuidle driver you need to
> rewrite the check code. I have seen that omap3_can_sleep partially as
> a workaround. Just to make sure PM doesn't break any driver as long a=
s
> they are not all configured properly what comes to interconnect. Just
> like what happened here as cpuidle was trying to enter C5/C6.
>=20
> >
> >>=20
> >> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
> >> ---
> >>  arch/arm/mach-omap2/cpuidle34xx.c |   23 +++++++----------------
> >>  arch/arm/mach-omap2/pm34xx.c      |    2 +-
> >>  2 files changed, 8 insertions(+), 17 deletions(-)
> >>=20
> >> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c=20
> >> b/arch/arm/mach-omap2/cpuidle34xx.c
> >> index c14152f..a636edb 100644
> >> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> >> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> >> @@ -473,31 +473,22 @@ static int omap3_enter_idle_bm(struct=20
> >> cpuidle_device *dev,
> >>  			       struct cpuidle_state *state)
> >>  {
> >>  	struct cpuidle_state *new_state =3D NULL;
> >> -	int i, j;
> >> -
> >> -	if ((state->flags & CPUIDLE_FLAG_CHECK_BM) &&=20
> >> omap3_idle_bm_check()) {
> >> -
> >> -		/* Find current state in list */
> >> -		for (i =3D 0; i < OMAP3_MAX_STATES; i++)
> >> -			if (state =3D=3D &dev->states[i])
> >> -				break;
> >> -		BUG_ON(i =3D=3D OMAP3_MAX_STATES);
> >> -
> >> -		/* Back up to non 'CHECK_BM' state */
> >> -		for (j =3D i - 1;  j > 0; j--) {
> >> -			struct cpuidle_state *s =3D &dev->states[j];
> >> +	int i;
> >> =20
> >> +	if (omap3_idle_bm_check()) {
> >> +		for (i =3D 0; i < OMAP3_MAX_STATES; i++) {
> >> +			struct cpuidle_state *s =3D &dev->states[i];
> >
> > So now a C0 is attempted every time there is bus activity?
>=20
> Yes you are right here. This code is not very effective. It should
> select deepest sleep state without CPUIDLE_FLAG_CHECK_BM.
>=20
> >
> >>  			if (!(s->flags & CPUIDLE_FLAG_CHECK_BM)) {
> >>  				new_state =3D s;
> >>  				break;
> >>  			}
> >>  		}
> >> -
> >> +		BUG_ON(i =3D=3D OMAP3_MAX_STATES);
> >>  		pr_debug("%s: Bus activity: Entering %s=20
> >> (instead of %s)\n",
> >> -			__FUNCTION__, new_state->name, state->name);
> >> +			 __FUNCTION__, new_state->name, state->name);
> >>  	}
> >> =20
> >> -	return omap3_enter_idle(dev, new_state ? : state);
> >> +	return omap3_enter_idle(dev, new_state ? new_state : state);
> >>  }
> >> =20
> >>  DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
> >> diff --git a/arch/arm/mach-omap2/pm34xx.c=20
> >> b/arch/arm/mach-omap2/pm34xx.c
> >> index 9f73e5c..ca0600a 100644
> >> --- a/arch/arm/mach-omap2/pm34xx.c
> >> +++ b/arch/arm/mach-omap2/pm34xx.c
> >> @@ -734,7 +734,7 @@ static int __init pwrdms_setup(struct=20
> >> powerdomain *pwrdm)
> >>  		pwrdm_enable_hdwr_sar(pwrdm);
> >> =20
> >>  	if (!strcmp(pwrst->pwrdm->name, "core_pwrdm") ||=20
> >> !strcmp(pwrst->pwrdm->name, "mpu_pwrdm") ||
> >> -	    !strcmp(pwrst->pwrdm->name, "mpu_pwrdm"))
> >> +	    !strcmp(pwrst->pwrdm->name, "neon_pwrdm"))
> >>  		return set_pwrdm_state(pwrst->pwrdm, PWRDM_POWER_ON);
> >>  	else
> >>  		return set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
> >> --=20
> >> 1.5.5
> >>=20
> >>=20
> >
> >
> >
>=20
> --=20
> Jouni H=C3=B6gander
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
