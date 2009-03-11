From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCHv2] PM : cpuidle - Update statistics for correct state
Date: Wed, 11 Mar 2009 20:04:07 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301CC1F6C1F@dbde02.ent.ti.com>
References: <1236455149-17017-1-git-send-email-premi@ti.com>
	<87wsazj9f5.fsf@trdhcp146196.ntc.nokia.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301CC185222@dbde02.ent.ti.com>
	<87ocwbj82x.fsf@trdhcp146196.ntc.nokia.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301CC18526D@dbde02.ent.ti.com>
 <87zlfuy3sb.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35164 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbZCKOeX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 10:34:23 -0400
In-Reply-To: <87zlfuy3sb.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: =?iso-8859-1?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]=20
> Sent: Monday, March 09, 2009 11:31 PM
> To: Premi, Sanjeev
> Cc: H=F6gander Jouni; linux-omap@vger.kernel.org
> Subject: Re: [PATCHv2] PM : cpuidle - Update statistics for=20
> correct state
>=20
> "Premi, Sanjeev" <premi@ti.com> writes:
>=20
> > =20
> >
> >> -----Original Message-----
> >> From: H=F6gander Jouni [mailto:jouni.hogander@nokia.com]
> >> Sent: Monday, March 09, 2009 4:07 PM
> >> To: Premi, Sanjeev
> >> Cc: linux-omap@vger.kernel.org
> >> Subject: Re: [PATCHv2] PM : cpuidle - Update statistics=20
> for correct=20
> >> state
> >>=20
> >> "ext Premi, Sanjeev" <premi@ti.com> writes:
> >>=20
> >> >> -----Original Message-----
> >> >> From: H=F6gander Jouni [mailto:jouni.hogander@nokia.com]
> >> >> Sent: Monday, March 09, 2009 3:38 PM
> >> >> To: Premi, Sanjeev
> >> >> Cc: linux-omap@vger.kernel.org
> >> >> Subject: Re: [PATCHv2] PM : cpuidle - Update statistics
> >> for correct
> >> >> state
> >> >>=20
> >> >> ext Sanjeev Premi <premi@ti.com> writes:
> >> >>=20
> >> >> > When 'enable_off_mode' is 0, and (mpu_state <
> >> PWRDM_POWER_RET) the
> >> >> > local variables mpu_state and core_state are modified; but
> >> >> the usage
> >> >> > count for the original state selected by the governor
> >> are updated.
> >> >> >
> >> >> > This patch updates the 'last_state' in the cpuidle
> >> driver to ensure
> >> >> > that statistics for the correct state are updated.
> >> >> >
> >> >> > Signed-off-by: Sanjeev Premi <premi@ti.com>
> >> >> > ---
> >> >> >  arch/arm/mach-omap2/cpuidle34xx.c |   29=20
> >> >> +++++++++++++++++++----------
> >> >> >  1 files changed, 19 insertions(+), 10 deletions(-)
> >> >> >
> >> >> > diff --git a/arch/arm/mach-omap2/cpuidle34xx.c
> >> >> > b/arch/arm/mach-omap2/cpuidle34xx.c
> >> >> > index 62fbb2e..b138abd 100644
> >> >> > --- a/arch/arm/mach-omap2/cpuidle34xx.c
> >> >> > +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> >> >> > @@ -76,23 +76,32 @@ static int omap3_enter_idle(struct
> >> >> cpuidle_device
> >> >> > *dev,  {
> >> >> >  	struct omap3_processor_cx *cx =3D
> >> cpuidle_get_statedata(state);
> >> >> >  	struct timespec ts_preidle, ts_postidle, ts_idle;
> >> >> > -	u32 mpu_state =3D cx->mpu_state, core_state =3D=20
> >> cx->core_state;
> >> >> > -
> >> >> > -	current_cx_state =3D *cx;
> >> >> > +	u32 mpu_state, core_state;
> >> >> > =20
> >> >> >  	/* Used to keep track of the total time in idle */
> >> >> >  	getnstimeofday(&ts_preidle);
> >> >> > =20
> >> >> > -	local_irq_disable();
> >> >> > -	local_fiq_disable();
> >> >> > -
> >> >> > +	/*
> >> >> > +	 * Adjust the idle state (if required).
> >> >> > +	 * Also, ensure that usage statistics of correct state
> >> >> are updated.
> >> >> > +	 */
> >> >> >  	if (!enable_off_mode) {
> >> >> > -		if (mpu_state < PWRDM_POWER_RET)
> >> >> > -			mpu_state =3D PWRDM_POWER_RET;
> >> >> > -		if (core_state < PWRDM_POWER_RET)
> >> >> > -			core_state =3D PWRDM_POWER_RET;
> >> >> > +		if (cx->type > OMAP3_STATE_C4) {
> >> >> > +			state =3D
> >> &(dev->states[OMAP3_STATE_C4 - 1]);
> >> >> > +			dev->last_state =3D state ;
> >> >> > +
> >> >> > +			cx =3D cpuidle_get_statedata(state);
> >> >>=20
> >> >> There is still C3 where OFF is used for MPU. This needs to
> >> be taken
> >> >> into account.
> >> >
> >> > [sp] Thanks. Good catch!
> >> >      I wasn't happy doing the "OMAP3_STATEn - 1"; but could
> >> not find a better way.
> >> >      It should be C2 as defined now.
> >>=20
> >> This means C4 is not used if off mode is not enabled? I=20
> think this is=20
> >> not wanted. Would it be possible to remove "OFF" C states when=20
> >> enable_off_mode is written to 0 and add them back when 1 written?
> >
> > [sp] That should be possible. We could use the 'valid' field
> >      for the purpose.
>=20
> I would gladly take a patch which uses the 'valid' field for=20
> this and then the enter hook whould drop to the next lower=20
> valid state if the state requested is not valid.
>=20
> Kevin

[sp] I have not yet tested it (working offline for sometime).
     But, wanted to share the changes for an early review.

     Initially, I was trying see if the CPUIDLE framework could
     use ".valid" as an additional argument in cpuidle_state.
     But, may be that's for later...

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cp=
uidle34xx
index c25158c..9493553 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -88,16 +88,19 @@ static int omap3_enter_idle(struct cpuidle_device *=
dev,
                goto return_sleep_time;

        /*
+        * Check if the chosen idle state is valid.
+        * If no, drop down to a lower valid state. Expects the lowest
+        * state will always be active.
         */
+       if (!cx->valid) {
+               for (idx =3D (cx->type - 1); idx =3D=3D 1; idx--) {
+                       if (omap3_power_states[idx].valid)
+                               break;
                }
+               state =3D &(dev->states[idx]);
+               dev->last_state =3D state ;
+
+               cx =3D cpuidle_get_statedata(state);
        }

        current_cx_state =3D *cx;
@@ -150,6 +153,26 @@ static int omap3_enter_idle_bm(struct cpuidle_devi=
ce *dev,
        return omap3_enter_idle(dev, new_state);
 }

+/**
+ * omap3_toggle_off_states - Enable / Disable validity of idle states
+ * @flag: Enable/ Disable support for OFF mode
+ *
+ * Called as result of change to "enable_off_mode".
+ */
+void omap3_toggle_off_states(unsigned short flag)
+{
+       if (flag) {
+               omap3_power_states[OMAP3_STATE_C3].valid =3D 1;
+               omap3_power_states[OMAP3_STATE_C5].valid =3D 1;
+               omap3_power_states[OMAP3_STATE_C6].valid =3D 1;
+       }
+       else {
+               omap3_power_states[OMAP3_STATE_C3].valid =3D 0;
+               omap3_power_states[OMAP3_STATE_C5].valid =3D 0;
+               omap3_power_states[OMAP3_STATE_C6].valid =3D 0;
+       }
+}
+
 DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);

 /* omap3_init_power_states - Initialises the OMAP3 specific C states.
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 61c6dfb..6785850 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -47,6 +47,8 @@ atomic_t sleep_block =3D ATOMIC_INIT(0);
 static int vdd1_locked;
 static int vdd2_locked;

+extern void omap3_toggle_off_states(unsigned short);
+
 static ssize_t idle_show(struct kobject *, struct kobj_attribute *, ch=
ar *);
 static ssize_t idle_store(struct kobject *k, struct kobj_attribute *,
                          const char *buf, size_t n);
@@ -112,6 +114,8 @@ static ssize_t idle_store(struct kobject *kobj, str=
uct kobj_
        } else if (attr =3D=3D &enable_off_mode_attr) {
                enable_off_mode =3D value;
                omap3_pm_off_mode_enable(enable_off_mode);
+               if (cpu_is_omap34xx())
+                       omap3_toggle_off_states(value);
        } else if (attr =3D=3D &voltage_off_while_idle_attr) {
                voltage_off_while_idle =3D value;
                if (voltage_off_while_idle)

>=20
>=20
> >
> >> >
> >> >      On another note, would it make sense to swap the
> >> definitions for C3 and C4.
> >> >      C3 : MPU CSWR + CORE CSWR
> >> >      C4 : MPU OFF + CORE Actove
> >>=20
> >> No it doesn't. They are organized by latency.
> >
> > [sp] Okay. That was a loud thinking from my side :)
> >>=20
> >> One grounding for current implementation is that=20
> enable_off_mode is=20
> >> more or less testing interface. In final solution it might be even=
=20
> >> removed. Adjusting states directly still shows guite accurate=20
> >> information on used C-states.
> >>=20
> >> >
> >> >>=20
> >> >> > +		}
> >> >> >  	}
> >> >> > =20
> >> >> > +	current_cx_state =3D *cx;
> >> >> > +
> >> >> > +	mpu_state =3D cx->mpu_state;
> >> >> > +	core_state =3D cx->core_state;
> >> >> > +
> >> >> > +	local_irq_disable();
> >> >> > +	local_fiq_disable();
> >> >> > +
> >> >> >  	pwrdm_set_next_pwrst(mpu_pd, mpu_state);
> >> >> >  	pwrdm_set_next_pwrst(core_pd, core_state);
> >> >> > =20
> >> >> > --
> >> >> > 1.5.6
> >> >> >
> >> >> > --
> >> >> > To unsubscribe from this list: send the line "unsubscribe
> >> >> linux-omap"=20
> >> >> > in the body of a message to majordomo@vger.kernel.org More
> >> >> majordomo
> >> >> > info at  http://vger.kernel.org/majordomo-info.html
> >> >>=20
> >> >> --
> >> >> Jouni H=F6gander
> >> >>=20
> >> >>=20
> >>=20
> >> --
> >> Jouni H=F6gander
> >>=20
> >> --
> > To unsubscribe from this list: send the line "unsubscribe=20
> linux-omap"=20
> > in the body of a message to majordomo@vger.kernel.org More=20
> majordomo=20
> > info at  http://vger.kernel.org/majordomo-info.html
>=20
> --
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
