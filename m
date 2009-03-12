From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCHv2] PM : cpuidle - Update statistics for correct state
Date: Thu, 12 Mar 2009 12:13:25 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301CC1F707D@dbde02.ent.ti.com>
References: <1236455149-17017-1-git-send-email-premi@ti.com>
	<87wsazj9f5.fsf@trdhcp146196.ntc.nokia.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301CC185222@dbde02.ent.ti.com>
	<87ocwbj82x.fsf@trdhcp146196.ntc.nokia.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301CC18526D@dbde02.ent.ti.com>
	<87zlfuy3sb.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301CC1F6C1F@dbde02.ent.ti.com>
 <87r613k3tt.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45399 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752203AbZCLGnk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 02:43:40 -0400
In-Reply-To: <87r613k3tt.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: =?iso-8859-1?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

=20

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]=20
> Sent: Thursday, March 12, 2009 5:31 AM
> To: Premi, Sanjeev
> Cc: H=F6gander Jouni; linux-omap@vger.kernel.org
> Subject: Re: [PATCHv2] PM : cpuidle - Update statistics for=20
> correct state
>=20
> "Premi, Sanjeev" <premi@ti.com> writes:
>=20
> >>=20
> >> I would gladly take a patch which uses the 'valid' field=20
> for this and=20
> >> then the enter hook whould drop to the next lower valid=20
> state if the=20
> >> state requested is not valid.
> >>=20
> >> Kevin
> >
> > [sp] I have not yet tested it (working offline for sometime).
> >      But, wanted to share the changes for an early review.
>=20
> Thanks, some comments below.
>=20
> >      Initially, I was trying see if the CPUIDLE framework could
> >      use ".valid" as an additional argument in cpuidle_state.
> >      But, may be that's for later...
>=20
> Yeah, I looked at that too, but it currently doesn't have a=20
> concept of valid states, so for now I recommend we implement=20
> that in the OMAP-specific code as you have done.
>=20
> > diff --git a/arch/arm/mach-omap2/cpuidle34xx.c=20
> > b/arch/arm/mach-omap2/cpuidle34xx index c25158c..9493553 100644
> > --- a/arch/arm/mach-omap2/cpuidle34xx.c
> > +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> > @@ -88,16 +88,19 @@ static int omap3_enter_idle(struct=20
> cpuidle_device *dev,
> >                 goto return_sleep_time;
> >
> >         /*
> > +        * Check if the chosen idle state is valid.
> > +        * If no, drop down to a lower valid state. Expects=20
> the lowest
> > +        * state will always be active.
> >          */
> > +       if (!cx->valid) {
> > +               for (idx =3D (cx->type - 1); idx =3D=3D 1; idx--) {
>                                              ^^^^^^^^
>=20
> I think you mean idx >=3D 1 here.

[sp] Yes. A typo. Still haven't tried this patch myself.

>=20
> Also, while you're working on this, could you fix this up so=20
> the omap3_power_states[] array is zero based insted of=20
> 1-based, it would make this code and the other code walking=20
> this array easier to follow.
>=20
> That means defining OMAP_STATE_C1 =3D 0 and so on.

[sp] Definitely.

>=20
> > +                       if (omap3_power_states[idx].valid)
> > +                               break;
> >                 }
> > +               state =3D &(dev->states[idx]);
> > +               dev->last_state =3D state ;
> > +
> > +               cx =3D cpuidle_get_statedata(state);
> >         }
> >
> >         current_cx_state =3D *cx;
> > @@ -150,6 +153,26 @@ static int omap3_enter_idle_bm(struct=20
> cpuidle_device *dev,
> >         return omap3_enter_idle(dev, new_state);  }
> >
> > +/**
> > + * omap3_toggle_off_states - Enable / Disable validity of=20
> idle states
> > + * @flag: Enable/ Disable support for OFF mode
> > + *
> > + * Called as result of change to "enable_off_mode".
> > + */
> > +void omap3_toggle_off_states(unsigned short flag) {
>=20
> How about calling this omap3_cpuidle_update_states() and=20
> taking no arguments.  Rather than the 'flag' argument,=20
> internally it just checks the global 'enable_off_mode.'
>=20
> This allows for potential further expansion down the road of=20
> other reasons to update CPUidle valid states.  For example,=20
> we've talked about updating the CPUidle state latencies on=20
> the fly depending on various other chip settings.
>=20
> > +       if (flag) {
> > +               omap3_power_states[OMAP3_STATE_C3].valid =3D 1;
> > +               omap3_power_states[OMAP3_STATE_C5].valid =3D 1;
> > +               omap3_power_states[OMAP3_STATE_C6].valid =3D 1;
> > +       }
> > +       else {
> > +               omap3_power_states[OMAP3_STATE_C3].valid =3D 0;
> > +               omap3_power_states[OMAP3_STATE_C5].valid =3D 0;
> > +               omap3_power_states[OMAP3_STATE_C6].valid =3D 0;
> > +       }
> > +}
> > +
>=20
> Rather than set set specific OMAP3_STATE_Cx values, it would=20
> be better to just walk the array, and check for=20
> [mpu|core]_state =3D PWRDM_POWER_OFF.
> If the state has either set, then update the valid flag.
>=20
> >  DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
> >
> >  /* omap3_init_power_states - Initialises the OMAP3=20
> specific C states.
> > diff --git a/arch/arm/mach-omap2/pm.c=20
> b/arch/arm/mach-omap2/pm.c index=20
> > 61c6dfb..6785850 100644
> > --- a/arch/arm/mach-omap2/pm.c
> > +++ b/arch/arm/mach-omap2/pm.c
> > @@ -47,6 +47,8 @@ atomic_t sleep_block =3D ATOMIC_INIT(0); =20
> static int=20
> > vdd1_locked;  static int vdd2_locked;
> >
> > +extern void omap3_toggle_off_states(unsigned short);
> > +
>=20
> Move the definition into pm.h as=20
> omap3_cpuidle_update_states(void) as described above.
>=20
> >  static ssize_t idle_show(struct kobject *, struct=20
> kobj_attribute *,=20
> > char *);  static ssize_t idle_store(struct kobject *k,=20
> struct kobj_attribute *,
> >                           const char *buf, size_t n); @@=20
> -112,6 +114,8=20
> > @@ static ssize_t idle_store(struct kobject *kobj, struct kobj_
> >         } else if (attr =3D=3D &enable_off_mode_attr) {
> >                 enable_off_mode =3D value;
> >                 omap3_pm_off_mode_enable(enable_off_mode);
> > +               if (cpu_is_omap34xx())
> > +                       omap3_toggle_off_states(value);
>=20
> Then, don't modify pm.c, rather just call=20
> omap3_cpuidle_update_states() from omap3_pm_off_mode_enable().
>=20
> Kevin
>=20
> --
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
