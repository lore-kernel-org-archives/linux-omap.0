From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 00/26] ARM: OMAP2+: PRCM cleanups for 3.18 merge window
Date: Fri, 3 Oct 2014 09:49:25 -0500
Message-ID: <20141003144925.GA22626@saruman>
References: <20140918171650.GK14505@atomide.com>
 <20140918191615.GN14505@atomide.com>
 <alpine.DEB.2.02.1409191633180.22526@utopia.booyaka.com>
 <alpine.DEB.2.02.1409191726050.22526@utopia.booyaka.com>
 <5422893B.60501@ti.com>
 <20141002163202.GJ3122@atomide.com>
 <20141002195238.GA10014@atomide.com>
 <20141002201753.GM7933@saruman>
 <20141002211908.GB10014@atomide.com>
 <20141002215930.GA628@saruman>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43552 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751773AbaJCOtt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Oct 2014 10:49:49 -0400
Content-Disposition: inline
In-Reply-To: <20141002215930.GA628@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 02, 2014 at 04:59:30PM -0500, Felipe Balbi wrote:
> Hi,
>=20
> On Thu, Oct 02, 2014 at 02:19:08PM -0700, Tony Lindgren wrote:
> > * Felipe Balbi <balbi@ti.com> [141002 13:18]:
> > > On Thu, Oct 02, 2014 at 12:52:38PM -0700, Tony Lindgren wrote:
> > > > * Tony Lindgren <tony@atomide.com> [141002 09:36]:
> > > > > * Tero Kristo <t-kristo@ti.com> [140924 02:04]:
> > > > > > On 09/19/2014 08:27 PM, Paul Walmsley wrote:
> > > > > > >On Fri, 19 Sep 2014, Paul Walmsley wrote:
> > > > > > >
> > > > > > >>However, I saw the following crash at boot on 37xxevm during =
one of
> > > > > > >>the boot test.  Ran thirty more boot tests afterwards on that=
 board
> > > > > > >>and it did not recur.  It seems unlikely that the problem is =
related
> > > > > > >>to this series, but looks like we may have some intermittent =
boot
> > > > > > >>failure or race on 37xx :-(
> > > > > > >
> > > > > > >...
> > > > > > >
> > > > > > >>[    4.892211] Unhandled fault: external abort on non-linefet=
ch (0x1028) at 0xfa318034
> > > > > > >>[    4.900299] Internal error: : 1028 [#1] SMP ARM
> > > > > > >>[    4.905090] Modules linked in:
> > > > > > >>[    4.908325] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.17=
=2E0-rc5-12866-g0164b2d #1
> > > > > > >>[    4.916320] task: c0835db0 ti: c082a000 task.ti: c082a000
> > > > > > >>[    4.922027] PC is at omap2_gp_timer_set_next_event+0x24/0x=
78
> > > > > > >>[    4.928009] LR is at clockevents_program_event+0xc0/0x148
> > > > > > >>[    4.933715] pc : [<c002622c>]    lr : [<c00a2800>]    psr:=
 00000193
> > > > > > >>[    4.933715] sp : c082bed8  ip : 00000000  fp : 00000000
> > > > > > >>[    4.945800] r10: 00000000  r9 : 24101100  r8 : c0839080
> > > > > > >>[    4.951324] r7 : 00000001  r6 : 237bc339  r5 : 0000009f  r=
4 : 3d9759e7
> > > > > > >>[    4.958190] r3 : fa318034  r2 : c08cb920  r1 : 00000003  r=
0 : fffffec1
> > > > > > >>[    4.965087] Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  I=
SA ARM  Segment kernel
> > > > > > >>[    4.972900] Control: 10c5387d  Table: 80004019  DAC: 00000=
015
> > > > > > >>[    4.978942] Process swapper/0 (pid: 0, stack limit =3D 0xc=
082a248)
> > > > > > >>[    4.985290] Stack: (0xc082bed8 to 0xc082c000)
> > > > > > >>[    4.989868] bec0:                                         =
              237bc339 00000001
> > > > > > >>[    4.998504] bee0: 00000001 24101100 00000001 cfc7d6c8 0000=
0001 cfc7da50 cfc7d720 c00a4780
> > > > > > >>[    5.007141] bf00: 00000000 c00962b0 cfc7d720 c0096180 0000=
0001 00000000 00000001 c08256c8
> > > > > > >>[    5.015777] bf20: c082a000 c08256c8 00000000 c00962b0 237b=
4c04 00000001 00000002 a0000193
> > > > > > >>[    5.024414] bf40: 00989680 00000000 00000000 24101100 0000=
0001 cfc7da50 00000000 c108cc78
> > > > > > >>[    5.033020] bf60: 00000000 c00962b0 00000000 00000002 0000=
0001 00000000 c108cc78 c00a56f0
> > > > > > >>[    5.041656] bf80: 00000000 00000002 237b4c04 00000001 c08c=
8ce8 c082a000 00000000 c08c8ce8
> > > > > > >>[    5.050292] bfa0: c08329dc c0832978 cfc7f0f8 c0072808 c055=
9928 c08270f0 c08caf40 c080fdc0
> > > > > > >>[    5.058929] bfc0: 00000000 c07c3b74 ffffffff ffffffff c07c=
35f0 00000000 00000000 c080fdc0
> > > > > > >>[    5.067535] bfe0: c08cb154 c0832968 c080fdbc c083763c 8000=
4059 80008074 00000000 00000000
> > > > > > >>[    5.076171] [<c002622c>] (omap2_gp_timer_set_next_event) f=
rom [<c00a2800>] (clockevents_program_event+0xc0/0x148)
> > > > > > >>[    5.087005] [<c00a2800>] (clockevents_program_event) from =
[<c00a4780>] (tick_program_event+0x44/0x54)
> > > > > > >>[    5.096771] [<c00a4780>] (tick_program_event) from [<c0096=
180>] (__hrtimer_start_range_ns+0x3c0/0x4a0)
> > > > > > >>[    5.106597] [<c0096180>] (__hrtimer_start_range_ns) from [=
<c00962b0>] (hrtimer_start_range_ns+0x24/0x2c)
> > > > > > >>[    5.116577] [<c00962b0>] (hrtimer_start_range_ns) from [<c=
00a56f0>] (tick_nohz_idle_exit+0x140/0x1ec)
> > > > > > >>[    5.126342] [<c00a56f0>] (tick_nohz_idle_exit) from [<c007=
2808>] (cpu_startup_entry+0xf4/0x2d0)
> > > > > > >>[    5.135528] [<c0072808>] (cpu_startup_entry) from [<c07c3b=
74>] (start_kernel+0x340/0x3a8)
> > > > > > >>[    5.144165] [<c07c3b74>] (start_kernel) from [<80008074>] =
(0x80008074)
> > > > > > >>[    5.151031] Code: 13a0c000 0a000004 ee07cfba e592301c (e59=
31000)
> > > > > > >>[    5.157470] ---[ end trace f92de024d996d904 ]---
> > > > > > >>[    5.162353] Kernel panic - not syncing: Attempted to kill =
the idle task!
> > > > > > >>[    5.169433] ---[ end Kernel panic - not syncing: Attempted=
 to kill the idle task!
> > > > > > >
> > > > > > >Actually it just occurred to me that if something broke
> > > > > > >*wait_target_ready(), we'd expect to see intermittent failures=
 like this,
> > > > > > >and this series touches *wait_target_ready().  So it might be =
worth taking
> > > > > > >a look at that with a magnifying glass to make sure that it's =
working.
> > > > > >=20
> > > > > > I think this is probably something else, and most likely more h=
ideous. The
> > > > > > clock source timers are only enabled once during a boot, and th=
ey are never
> > > > > > idled after that. This error happens almost 5 seconds after the=
 initial
> > > > > > module enable...?
> > > > >=20
> > > > > I have not seen this and I've had this branch merged in for testi=
ng
> > > > > here for about a week now. I've also merged it into linux-omap ma=
ster
> > > > > branch for merging now, let's keep it there and plan on merging i=
t early
> > > > > for v3.19 merge window unless some issues are found.
> > > >=20
> > > > Hmm here seems to be a link to similar issues from 2011:
> > > >=20
> > > > http://e2e.ti.com/support/arm/sitara_arm/f/791/p/113593/628790.aspx
> > > >=20
> > > > Looks like the issue can be potentially reproduced with:
> > > >=20
> > > > # cyclictest -l100000000 -m -a0 -t1 -n -p99 -i200 -h200 -q
> > >=20
> > > running here on am335x and am437x. On that same post, on person
> > > mentions he reproduced on beagle bone.
> >=20
> > OK I'll run it here too on my am37xx evm. Looks like Stanley was
> > running both cyclictest and hackbench the same time.
>=20
> yeah I did that.
>=20
> BTW, just got the following on BBB, AM437x SK is still running.
>=20
> [ 3952.432262] Kernel panic - not syncing: Attempted to kill the idle tas=
k!752763
> [ 3952.442403] CPU: 0 PID: 0 Comm: hackbench Not tainted 3.17.0-rc6-00456=
-gd8da063 #222
> [ 3952.450517] [<c0017338>] (unwind_backtrace) from [<c0012fdc>] (show_st=
ack+0x20/0x24)
> [ 3952.458620] [<c0012fdc>] (show_stack) from [<c0647f0c>] (dump_stack+0x=
8c/0xa4)
> [ 3952.466168] [<c0647f0c>] (dump_stack) from [<c0644da4>] (panic+0xa4/0x=
224)
> [ 3952.473358] [<c0644da4>] (panic) from [<c004b510>] (do_exit+0x924/0x9d=
8)
> [ 3952.480358] [<c004b510>] (do_exit) from [<c004c4d8>] (do_group_exit+0x=
50/0xc0)
> [ 3952.487903] [<c004c4d8>] (do_group_exit) from [<c004c568>] (__wake_up_=
parent+0x0/0x30)
> [ 3952.496179] [<c004c568>] (__wake_up_parent) from [<c000ed40>] (ret_fas=
t_syscall+0x0/0x48)
> [ 3952.504875] drm_kms_helper: panic occurred, switching back to text con=
sole
> [ 3952.517844] ---[ end Kernel panic - not syncing: Attempted to kill the=
 idle task!
>=20
>=20
> > And I'll also queue the following patch during the -rc cycle to
> > avoid apps segfaulting occasionally at random on omap3.
> >
> > 8<-------------------
> > From: Tony Lindgren <tony@atomide.com>
> > Date: Thu, 2 Oct 2014 13:51:18 -0700
> > Subject: [PATCH] ARM: omap2plus_defconfig: Enable ARM erratum 430973 fo=
r omap3
> >=20
> > Somehow we don't have this set in omap2plus_defconfig. Without this
> > apps can segfault randomly on omap3. I can reproduce this easily
> > on am37xx-evm by doing apt-get update over NFSroot.
> >=20
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> >=20
> > diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/om=
ap2plus_defconfig
> > index 02a9fbd..13189fe 100644
> > --- a/arch/arm/configs/omap2plus_defconfig
> > +++ b/arch/arm/configs/omap2plus_defconfig
> > @@ -52,6 +52,7 @@ CONFIG_SOC_AM43XX=3Dy
> >  CONFIG_SOC_DRA7XX=3Dy
> >  CONFIG_ARM_THUMBEE=3Dy
> >  CONFIG_ARM_ERRATA_411920=3Dy
> > +CONFIG_ARM_ERRATA_430973=3Dy
>=20
> and maybe this will fix BBB :-) I'll add that locally. If I survive
> until tomorrow, I'll add a Tested-by.

BBB died again with the same behavior as above, but I think it's
unrelated to this errata. Therefore:

Tested-by: Felipe Balbi <balbi@ti.com>

cheers

--=20
balbi

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJULrd1AAoJEIaOsuA1yqREnJQP/3rACibZZfwoWJCGH5zpZHfP
yA2kq3eJ5fT/SnOoXWGOC/IDDhRwQjBBdSyA17hecZsctfInNkix8Qzdt8Q1hQS9
AzpZ36f8pvznYdgUZU4S0N6i5bhuxzNNQ4unWKxtdCl+/w+8pj+Te3+j7c0/3sm7
EcaGclLD3nsuDvKMBdqv+kyeW4yMXAoAkw0zYPngL5XMiSTOnxcSu+aP+wvkIYun
1mWfu+mwVpPflQ4U3aKrGkafAbkeBtZMh6Znt06Pf4U65WoNULOCVAvFfVnDArbj
YKMtbdQO/7ryK0s72ABrxgRzKK43xlpNf6d96XMfN2sfEpMaeNYhl/co6T/KjSLs
tQFACXc1COmzmzGabk7Hl63I2Vb06TWlTHy5yzHpAPZQnOgWisyr6NHO4tTaMIUa
Gdvjo9k9/bftpn2/IDS9UvWFDJUBKum0b938YiPHpc/9bubzrSWKuGyHOuOye1FN
MtNFeSErOaWWUNpmTp3U1HpXnY7PNmhHvwbCpJuJqXz/jUvuDGCGg2nDDsWgT0Bg
LZMFj2LuRkg2sV558VKIQmV9ZJJsR1eM8N4V5plfpshFPOblFCCYIyPXAOFmXbok
pO0RX3cnNIdW+uAVZRejmqBhMMHjfjbkiwDIcj4W3AcbJwC7nyYOOquszHGoAnEw
bjOyRJ55T5QgU3jgFPQo
=PxS2
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
