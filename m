From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: new PM branch available
Date: Tue, 27 Jan 2009 14:48:40 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02F535EEC9@dbde02.ent.ti.com>
References: <871vut7w27.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37724 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751124AbZA0JSz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jan 2009 04:18:55 -0500
In-Reply-To: <871vut7w27.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: =?iso-8859-1?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]=20
> Sent: Friday, January 23, 2009 11:19 PM
> To: Nayak, Rajendra
> Cc: H=F6gander Jouni; linux-omap@vger.kernel.org
> Subject: Re: new PM branch available
>=20
> "Nayak, Rajendra" <rnayak@ti.com> writes:
>=20
> > =20
> >
> >> -----Original Message-----
> >> From: H=F6gander Jouni [mailto:jouni.hogander@nokia.com]=20
> >> Sent: Friday, January 23, 2009 4:52 PM
> >> To: Nayak, Rajendra
> >> Cc: Kevin Hilman; linux-omap@vger.kernel.org
> >> Subject: Re: new PM branch available
> >>=20
> >> "ext Nayak, Rajendra" <rnayak@ti.com> writes:
> >>=20
> >> >> I did some testing today on my 3.0GP 3430SDP. This is with=20
> >> the omap_3430sdp_min_defconfig.
> >> >>
> >> >> 1) Idle.
> >> >> echo -n 1 > /sys/power/clocks_off_while_idle
> >> >> echo -n 1 > /sys/power/enable_off
> >> >> Could not hit RET. something seems to be still active. Not=20
> >> sure if it could be something
> >> >> to do with this error that's thrown while bootup
> >> >>
> >> >> <6>Disabling unused clock "dpll5_ck"
> >> >> Disabling unused clock "dpll5_ck"
> >> >> <3>clock: dpll5_ck failed transition to 'locked'
> >> >> clock: dpll5_ck failed transition to 'locked'
> >> >>=20
> >> >> This is the same results I see on my SDP.
> >> >>=20
> >> >> Looking at the registers, I am pretty sure it is the D2D=20
> >> clockdomain
> >> >> that still has activity, but due to very poor Stacked-mode=20
> >> docs and no
> >> >> responses to the D2D questions asked to TI I have not=20
> been able to
> >> >> figure this one out.
> >> >>=20
> >> >> Help debugging this would be greatly appreciated.
> >> >
> >> > I looked some more into this today and saw that the hang is=20
> >> indeed caused
> >> > due to some kind of debug console going dead. The system=20
> >> was still looping in the
> >> > idle thread. I could even do a telnet remotely to my=20
> board and take
> >> > some debug dumps..
> >>=20
> >> This might help you:
> >
> > Yup, this does help. There's no hang now either in idle or=20
> in suspend.
>=20
> Rajendra,
>=20
> Is CORE hitting retention for you?  while UART wakeups are=20
> now working,
> CORE is still not hitting retention.
>=20
> Kevin

Yes, like I said IVA seemed to have been keeping the system active
after bootup.
Looks like the errata implementation done as part of the omap3_iva_idle
is needed only on silicon rev's 1.0 and 2.0. On my ES3.0 *not* doing th=
at is
helping me hit RET/OFF in idle and suspend.
Not sure if this is an expected behaviour or some changes are needed in=
 the
errata fix sequence. I'll try finding out more on that.
But for now, not doing the errata fix helps me hit CORE RET/OFF on my
ES3.0SDP.

>=20
> > Not sure why this was affecting only the SDP while the pm=20
> branch seems
> > to function without this for beagle and other omap3 platforms?
> >
> >>=20
> >> diff --git a/arch/arm/mach-omap2/pm34xx.c=20
> >> b/arch/arm/mach-omap2/pm34xx.c
> >> index b2db0ba..266e4f5 100644
> >> --- a/arch/arm/mach-omap2/pm34xx.c
> >> +++ b/arch/arm/mach-omap2/pm34xx.c
> >> @@ -401,6 +401,8 @@ void omap_sram_idle(void)
> >>                         omap3_prcm_restore_context();
> >>                         omap3_sram_restore_context();
> >>                 }
> >> +               omap_uart_resume_idle(0);
> >> +               omap_uart_resume_idle(1);
> >>                 if (core_next_state =3D=3D PWRDM_POWER_OFF)
> >>                         prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF,
> >>                                                OMAP3430_GR_MOD,
> >>=20
> >> --=20
> >> Jouni H=F6gander
> >>=20
> >>=20
> >>=20
>=20
> --
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
