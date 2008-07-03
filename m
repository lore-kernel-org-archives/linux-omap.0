From: "Rajendra Nayak" <rnayak@ti.com>
Subject: RE: [PATCH 00/11] OMAP3 CPUidle patches
Date: Thu, 3 Jul 2008 15:50:19 +0530
Message-ID: <005101c8dcf6$658fd650$68bf18ac@ent.ti.com>
References: <003d01c8db84$fe61fde0$68bf18ac@ent.ti.com> <87hcb7qzkp.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37212 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755693AbYGCMAZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jul 2008 08:00:25 -0400
In-Reply-To: <87hcb7qzkp.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?Q?'=22H=C3=B6gander=22_Jouni'?= <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

=20

> -----Original Message-----
> From: "H=C3=B6gander" Jouni [mailto:jouni.hogander@nokia.com]=20
> Sent: Thursday, July 03, 2008 11:28 AM
> To: ext Rajendra Nayak
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 00/11] OMAP3 CPUidle patches
>=20
> "ext Rajendra Nayak" <rnayak@ti.com> writes:
>=20
> > Hi,
> >
> > The following patches define and enable all of the below=20
> mentioned C states for OMAP3.=20
> > These are tested with a minimal kernel config on=20
> OMAP3430sdp as most drivers today don't have context=20
> save/restore in place and
> > some even lack aggresive clock handling.=20
> > These apply on top of the workaround patch set submitted by Jouni.=20
> > ([PATCH 0/6] 34XX: PM: Workarounds to get omap3 to retention 4th.)
> >
> > The following is neccessay even with a minimal config to=20
> achieve OFF.
> >  $ echo 1 > /sys/power/sleep_while_idle
> >  $ echo 1 > /sys/power/clocks_off_while_idle
> >  =20
> > The following C states are defined
> > C0 - System executing code
> > C1 - MPU WFI + Core active
> > C2 - MPU CSWR + Core active
> > C3 - MPU OFF + Core active
> > C4 - MPU CSWR + Core CSWR
> > C5 - MPU OFF + Core CSWR
> > C6 - MPU OFF + Core OFF
> > =20
> > regards,
> > Rajendra
>=20
> One more general comment on these patches as I looked at the code
> after applying them.
>=20
> Most of the code in omap3_enter_idle in cpuidle34xx.c could be shared
> between suspend/pm_idle/cpuidle. I would do these changes to share
> this code between these three things:
>=20
> 1. read mpu_pd pwrst, neon_pd pwrst, core_pd pwrst values in
>    omap_sram_idle in pm34xx.c
>=20
> 2. Move all the logic from omap3_enter_idle to omap_sram_idle. Use
>    values read in previous step to decide wether ctx savings/restores
>    are needed, what should be written to neon_pd next_pwrst, wether
>    omap2_gpio_prepare_for/resume_after_retention is needed, wether to
>    disable/enable serial and gpio clocks.
>=20
> Basically what is left into omap3_enter_idle is writing next pwrsts
> and cpuidle related stuff, something like this:
>=20
> static int omap3_enter_idle(struct cpuidle_device *dev,
> 			struct cpuidle_state *state)
> {
> 	struct omap3_processor_cx *cx =3D cpuidle_get_statedata(state);
> 	struct timespec ts_preidle, ts_postidle, ts_idle;
> 	struct powerdomain *mpu_pd, *core_pd;
>=20
> 	current_cx_state =3D *cx;
>=20
> 	if (cx->type =3D=3D OMAP3_STATE_C0) {
> 		/* Do nothing for C0, not even a wfi */
> 		return 0;
> 	}
>=20
> 	local_irq_disable();
> 	local_fiq_disable();
>=20
> 	/* Used to keep track of the total time in idle */
> 	getnstimeofday(&ts_preidle);
>=20
> 	if (cx->type > OMAP3_STATE_C1)
> 		sched_clock_idle_sleep_event(); /* about to=20
> enter deep idle */
>=20
> 	mpu_pd =3D pwrdm_lookup("mpu_pwrdm");
> 	core_pd =3D pwrdm_lookup("core_pwrdm");
>=20
>         pwrdm_set_next_pwrst(mpu_pd, cx->mpu_state);
> 	pwrdm_set_next_pwrst(core_pd, cx->core_state);
>=20
> 	if (omap_irq_pending())
> 		goto return_sleep_time;
>=20
> 	/* Execute ARM wfi */
> 	omap_sram_idle();
>=20
> return_sleep_time:
> 	getnstimeofday(&ts_postidle);
> 	ts_idle =3D timespec_sub(ts_postidle, ts_preidle);
>=20
> 	if (cx->type > OMAP3_STATE_C1)
> 		sched_clock_idle_wakeup_event(timespec_to_ns(&ts_idle));
>=20
> 	local_irq_enable();
> 	local_fiq_disable();
>=20
> 	return (u32)timespec_to_ns(&ts_idle)/1000;
> }
>=20
> If this is not done, we need to copy paste code from omap3_enter_idle
> into suspend code anyway if we want to use offmode in it. It would be
> more nice to have one funcion with this logic shared between
> suspend/pm_idle/cpuidle rather than two or even three copies of it.

Yes, all this looks good to me.

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
