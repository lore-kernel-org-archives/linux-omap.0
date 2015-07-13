From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Mon, 13 Jul 2015 13:10:31 +0200
Message-ID: <20150713111031.GC30452@pali>
References: <201507111405.06048@pali>
 <20150713064425.GB26485@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150713064425.GB26485@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sunday 12 July 2015 23:44:25 Tony Lindgren wrote:
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [150711 05:07]:
> > Hello,
> >=20
> > now I tested 4.2-rc1 release on Nokia N900 and couple of drivers ar=
e
> > broken and cause kernel oops...
> >=20
> > Basically wifi, touchscreen and rtc drivers not working...
> >=20
> > Here are some relevant snippets form dmesg:
> >=20
> > [   13.933959] Unhandled fault: external abort on non-linefetch (0x=
1028) at 0xfa09802c
> > [   13.940490] pgd =3D cfb38000
> > [   13.946594] [fa09802c] *pgd=3D48011452(bad)
> > [   13.952758] Internal error: : 1028 [#1] PREEMPT ARM
> > [   13.958862] Modules linked in: tsc2005(+) omap_sham twl4030_wdt =
omap_wdt
> > [   13.965332] CPU: 0 PID: 183 Comm: modprobe Not tainted 4.2.0-rc1=
+ #363
> > [   13.971801] Hardware name: Nokia RX-51 board
> > [   13.978302] task: cf572300 ti: cb1f2000 task.ti: cb1f2000
> > [   13.984924] PC is at omap2_mcspi_set_cs+0x44/0x4c
> > [   13.991485] LR is at spi_set_cs+0x5c/0x60
> > [   13.997985] pc : [<c02bd3ac>]    lr : [<c02baecc>]    psr: 20000=
013
> > [   13.997985] sp : cb1f3dd0  ip : 00000001  fp : 00000004
> > [   14.011260] r10: cfce5be8  r9 : 00000fff  r8 : c0654f98
> > [   14.017913] r7 : 00000000  r6 : 00000000  r5 : 00000000  r4 : 00=
000000
> > [   14.024505] r3 : 200103dc  r2 : fa098000  r1 : 00000001  r0 : cf=
09bc00
> > [   14.031036] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM =
 Segment user
> > [   14.037689] Control: 10c5387d  Table: 8fb38019  DAC: 00000015
> > [   14.044403] Process modprobe (pid: 183, stack limit =3D 0xcb1f22=
10)
> > [   14.051300] Stack: (0xcb1f3dd0 to 0xcb1f4000)
> > [   14.058105] 3dc0:                                     cf09bc00 c=
02bafa4 cf09bc00 cf09bc00
> > [   14.065277] 3de0: bf013444 bf01254c cf0e2230 cf0e2230 00000001 c=
0654f98 00000fff 00000fff
> > [   14.072570] 3e00: 00000008 00000002 00000118 00001f40 00000031 c=
f09bc00 ffffffed bf013444
> > [   14.080078] 3e20: 00000031 c0654f98 cb1f2000 00000000 00000000 c=
02bb5c0 cf09bc00 00000000
> > [   14.087738] 3e40: bf013454 c027a2f4 00000000 cf09bc00 bf013454 b=
f013454 00000000 c027a594
> > [   14.095367] 3e60: 00000000 cf09bc00 cf09bc34 c027a60c bf013454 c=
b1f3e80 c027a5ac c0278ec8
> > [   14.102935] 3e80: cf972c4c cf09d630 bf013454 bf013454 cbb55300 c=
06848d8 00000000 c0279c84
> > [   14.110473] 3ea0: bf01327c bf01327d 00000000 bf013454 cb889180 0=
0000000 c0654f98 c027b0c8
> > [   14.117980] 3ec0: 00000000 bf015000 cb889180 c00095b0 0040003e c=
fe6a080 0040003f 00000000
> > [   14.125457] 3ee0: 00080000 cfcf9000 cb1f2000 60000013 0040003e c=
bf1bbc0 00000000 00000001
> > [   14.132843] 3f00: bf0134cc cb1f2000 bf0134c0 cb1f3f58 00000000 c=
04352d0 cf801f00 000000d0
> > [   14.140136] 3f20: bf0134c0 bf0134c0 0000416c cb889040 00000080 c=
000ebe4 cb1f2000 c0089f68
> > [   14.147308] 3f40: bf0134c0 cbf1bc00 001a9193 0000416c 001f8d20 c=
008ab30 d0b10000 0000416c
> > [   14.154571] 3f60: d0b1267c d0b1252b d0b13514 000016c0 00001ad0 0=
0000000 00000000 00000000
> > [   14.161865] 3f80: 0000001f 00000020 00000017 00000014 00000012 0=
0000000 00201208 00000000
> > [   14.169097] 3fa0: 00000000 c000ea60 00201208 00000000 001f8d20 0=
000416c 001a9193 00000000
> > [   14.176177] 3fc0: 00201208 00000000 00000000 00000080 00208c20 0=
01a9193 bee09e98 00000000
> > [   14.183197] 3fe0: b6f742b4 bee09ae4 000153f0 000093e4 60000010 0=
01f8d20 72757463 69665f65
> > [   14.190277] [<c02bd3ac>] (omap2_mcspi_set_cs) from [<c02baecc>] =
(spi_set_cs+0x5c/0x60)
> > [   14.197479] [<c02baecc>] (spi_set_cs) from [<c02bafa4>] (spi_set=
up+0xd4/0x10c)
> > [   14.204833] [<c02bafa4>] (spi_setup) from [<bf01254c>] (tsc2005_=
probe+0x104/0x484 [tsc2005])
> > [   14.212249] [<bf01254c>] (tsc2005_probe [tsc2005]) from [<c02bb5=
c0>] (spi_drv_probe+0x50/0x6c)
> > [   14.219818] [<c02bb5c0>] (spi_drv_probe) from [<c027a2f4>] (real=
ly_probe+0xd4/0x230)
> > [   14.227478] [<c027a2f4>] (really_probe) from [<c027a594>] (drive=
r_probe_device+0x30/0x48)
> > [   14.235290] [<c027a594>] (driver_probe_device) from [<c027a60c>]=
 (__driver_attach+0x60/0x84)
> > [   14.243286] [<c027a60c>] (__driver_attach) from [<c0278ec8>] (bu=
s_for_each_dev+0x50/0x84)
> > [   14.251281] [<c0278ec8>] (bus_for_each_dev) from [<c0279c84>] (b=
us_add_driver+0xcc/0x1e0)
> > [   14.259246] [<c0279c84>] (bus_add_driver) from [<c027b0c8>] (dri=
ver_register+0x9c/0xe0)
> > [   14.267272] [<c027b0c8>] (driver_register) from [<c00095b0>] (do=
_one_initcall+0x100/0x1b0)
> > [   14.275421] [<c00095b0>] (do_one_initcall) from [<c0089f68>] (do=
_init_module+0x58/0x1bc)
> > [   14.283477] [<c0089f68>] (do_init_module) from [<c008ab30>] (SyS=
_init_module+0x54/0x64)
> > [   14.291412] [<c008ab30>] (SyS_init_module) from [<c000ea60>] (re=
t_fast_syscall+0x0/0x3c)
> > [   14.299407] Code: e5823018 e5902188 e5922000 e582302c (e592302c)=
=20
> > [   14.307403] ---[ end trace d21553dcaefcb5ac ]---
>=20
> That seems to be a regression with the SPI driver. Care to git bisect=
 it?
> It's probably one of the following commits:
>=20
> $ git log --pretty=3Doneline v4.1..v4.2-rc2 drivers/spi/spi-omap2-mcs=
pi.c
>=20
> Looks like just modprobe tsc2005 is enough to reproduce it.
>=20
> Regards,
>=20
> Tony

Ok, and any idea what is with rtc?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
