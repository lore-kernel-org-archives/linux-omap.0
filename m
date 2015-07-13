From: Sebastian Reichel <sre@kernel.org>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Mon, 13 Jul 2015 10:09:21 +0200
Message-ID: <20150713080920.GA25585@earth>
References: <201507111405.06048@pali>
 <20150713064425.GB26485@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150713064425.GB26485@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Welling <mwelling@ieee.org>
List-Id: linux-omap@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[+cc Michael Welling <mwelling@ieee.org>, author of all omap-spi patches be=
tween 4.1 and 4.2-rc1]

Hi,

On Sun, Jul 12, 2015 at 11:44:25PM -0700, Tony Lindgren wrote:
> * Pali Roh=E1r <pali.rohar@gmail.com> [150711 05:07]:
> > Hello,
> >=20
> > now I tested 4.2-rc1 release on Nokia N900 and couple of drivers are
> > broken and cause kernel oops...
> >=20
> > Basically wifi, touchscreen and rtc drivers not working...
> >=20
> > Here are some relevant snippets form dmesg:
> >=20
> > [   13.933959] Unhandled fault: external abort on non-linefetch (0x1028=
) at 0xfa09802c
> > [   13.940490] pgd =3D cfb38000
> > [   13.946594] [fa09802c] *pgd=3D48011452(bad)
> > [   13.952758] Internal error: : 1028 [#1] PREEMPT ARM
> > [   13.958862] Modules linked in: tsc2005(+) omap_sham twl4030_wdt omap=
_wdt
> > [   13.965332] CPU: 0 PID: 183 Comm: modprobe Not tainted 4.2.0-rc1+ #3=
63
> > [   13.971801] Hardware name: Nokia RX-51 board
> > [   13.978302] task: cf572300 ti: cb1f2000 task.ti: cb1f2000
> > [   13.984924] PC is at omap2_mcspi_set_cs+0x44/0x4c
> > [   13.991485] LR is at spi_set_cs+0x5c/0x60
> > [   13.997985] pc : [<c02bd3ac>]    lr : [<c02baecc>]    psr: 20000013
> > [   13.997985] sp : cb1f3dd0  ip : 00000001  fp : 00000004
> > [   14.011260] r10: cfce5be8  r9 : 00000fff  r8 : c0654f98
> > [   14.017913] r7 : 00000000  r6 : 00000000  r5 : 00000000  r4 : 000000=
00
> > [   14.024505] r3 : 200103dc  r2 : fa098000  r1 : 00000001  r0 : cf09bc=
00
> > [   14.031036] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Seg=
ment user
> > [   14.037689] Control: 10c5387d  Table: 8fb38019  DAC: 00000015
> > [   14.044403] Process modprobe (pid: 183, stack limit =3D 0xcb1f2210)
> > [   14.051300] Stack: (0xcb1f3dd0 to 0xcb1f4000)
> > [   14.058105] 3dc0:                                     cf09bc00 c02ba=
fa4 cf09bc00 cf09bc00
> > [   14.065277] 3de0: bf013444 bf01254c cf0e2230 cf0e2230 00000001 c0654=
f98 00000fff 00000fff
> > [   14.072570] 3e00: 00000008 00000002 00000118 00001f40 00000031 cf09b=
c00 ffffffed bf013444
> > [   14.080078] 3e20: 00000031 c0654f98 cb1f2000 00000000 00000000 c02bb=
5c0 cf09bc00 00000000
> > [   14.087738] 3e40: bf013454 c027a2f4 00000000 cf09bc00 bf013454 bf013=
454 00000000 c027a594
> > [   14.095367] 3e60: 00000000 cf09bc00 cf09bc34 c027a60c bf013454 cb1f3=
e80 c027a5ac c0278ec8
> > [   14.102935] 3e80: cf972c4c cf09d630 bf013454 bf013454 cbb55300 c0684=
8d8 00000000 c0279c84
> > [   14.110473] 3ea0: bf01327c bf01327d 00000000 bf013454 cb889180 00000=
000 c0654f98 c027b0c8
> > [   14.117980] 3ec0: 00000000 bf015000 cb889180 c00095b0 0040003e cfe6a=
080 0040003f 00000000
> > [   14.125457] 3ee0: 00080000 cfcf9000 cb1f2000 60000013 0040003e cbf1b=
bc0 00000000 00000001
> > [   14.132843] 3f00: bf0134cc cb1f2000 bf0134c0 cb1f3f58 00000000 c0435=
2d0 cf801f00 000000d0
> > [   14.140136] 3f20: bf0134c0 bf0134c0 0000416c cb889040 00000080 c000e=
be4 cb1f2000 c0089f68
> > [   14.147308] 3f40: bf0134c0 cbf1bc00 001a9193 0000416c 001f8d20 c008a=
b30 d0b10000 0000416c
> > [   14.154571] 3f60: d0b1267c d0b1252b d0b13514 000016c0 00001ad0 00000=
000 00000000 00000000
> > [   14.161865] 3f80: 0000001f 00000020 00000017 00000014 00000012 00000=
000 00201208 00000000
> > [   14.169097] 3fa0: 00000000 c000ea60 00201208 00000000 001f8d20 00004=
16c 001a9193 00000000
> > [   14.176177] 3fc0: 00201208 00000000 00000000 00000080 00208c20 001a9=
193 bee09e98 00000000
> > [   14.183197] 3fe0: b6f742b4 bee09ae4 000153f0 000093e4 60000010 001f8=
d20 72757463 69665f65
> > [   14.190277] [<c02bd3ac>] (omap2_mcspi_set_cs) from [<c02baecc>] (spi=
_set_cs+0x5c/0x60)
> > [   14.197479] [<c02baecc>] (spi_set_cs) from [<c02bafa4>] (spi_setup+0=
xd4/0x10c)
> > [   14.204833] [<c02bafa4>] (spi_setup) from [<bf01254c>] (tsc2005_prob=
e+0x104/0x484 [tsc2005])
> > [   14.212249] [<bf01254c>] (tsc2005_probe [tsc2005]) from [<c02bb5c0>]=
 (spi_drv_probe+0x50/0x6c)
> > [   14.219818] [<c02bb5c0>] (spi_drv_probe) from [<c027a2f4>] (really_p=
robe+0xd4/0x230)
> > [   14.227478] [<c027a2f4>] (really_probe) from [<c027a594>] (driver_pr=
obe_device+0x30/0x48)
> > [   14.235290] [<c027a594>] (driver_probe_device) from [<c027a60c>] (__=
driver_attach+0x60/0x84)
> > [   14.243286] [<c027a60c>] (__driver_attach) from [<c0278ec8>] (bus_fo=
r_each_dev+0x50/0x84)
> > [   14.251281] [<c0278ec8>] (bus_for_each_dev) from [<c0279c84>] (bus_a=
dd_driver+0xcc/0x1e0)
> > [   14.259246] [<c0279c84>] (bus_add_driver) from [<c027b0c8>] (driver_=
register+0x9c/0xe0)
> > [   14.267272] [<c027b0c8>] (driver_register) from [<c00095b0>] (do_one=
_initcall+0x100/0x1b0)
> > [   14.275421] [<c00095b0>] (do_one_initcall) from [<c0089f68>] (do_ini=
t_module+0x58/0x1bc)
> > [   14.283477] [<c0089f68>] (do_init_module) from [<c008ab30>] (SyS_ini=
t_module+0x54/0x64)
> > [   14.291412] [<c008ab30>] (SyS_init_module) from [<c000ea60>] (ret_fa=
st_syscall+0x0/0x3c)
> > [   14.299407] Code: e5823018 e5902188 e5922000 e582302c (e592302c)=20
> > [   14.307403] ---[ end trace d21553dcaefcb5ac ]---
>=20
> That seems to be a regression with the SPI driver. Care to git bisect it?
> It's probably one of the following commits:
>=20
> $ git log --pretty=3Doneline v4.1..v4.2-rc2 drivers/spi/spi-omap2-mcspi.c
>
> Looks like just modprobe tsc2005 is enough to reproduce it.

mh omap2_mcspi_set_cs has been introduced in this range
(ddcad7e9068) and from the commit message it seems to be
a fix for the first commit (b28cb9414d) in this range.

Just looking at the commit log, I sugest starting with testing if
ddcad7e9068 is affected and if b28cb9414d~1 is not affected.

-- Sebastian

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVo3IoAAoJENju1/PIO/qalkcQAJzrLVK0J+CbkdjKJDpP1Ecq
KtJ9Rm9Wv1SrMETvHvWg48qrQLmMJF3v9/ExRIDWg9sW+qWHEJS0kYbZvoiiA6cq
jsLxhGiF24hazu3nC0Ay5z+rICmbNwSFZeKzLIeh6wGGPotW1r/dTYxL8P3aqB4I
ARnkhbXXcjNUijxrCVV6lxnO91uCCLcyVaaNSekX0sXjKrz8BHb6CjKKugvq7nJU
inULmqUbtd6IHahltVWMTZ8TCbYR/uOefCbY5JQyq0sUIXWMFmrSWbDzkB03qoAk
gNXCB4/1PhlJMuYwbt4Z3A4kFpNRSqQVI1egtEmEicJBboJV/AB9f3ukG89Yuuat
FwAR/QgAPp/c/GNFH//zKxlhqKnCcu8Y7LV3XzaG9TwJvOf5G3d86QguQm8rTbwq
ahBEla801F9mvjaOvOVAkCxZX+qsu/4cr8+uwrE9o6Y//nLaebgmBdHuvIvY1SRQ
ED5fOP6fjEJdRSEdKMN8e6K1KpkiE5de+ulz6b13Rhdag3QshTDEHK1BuzboBDqJ
VXuL3uU9n1/gYtLpKEUWFbeHxQ+4unRKpccDOMHMHoipT3P2lw4fuv39jKZvYd+V
uCF9vSYuL/rsK29hVy8WqwRiFr7bXRISi3LeABuS/A/46fEuEq8iAtHwKohC7NLn
cS6M2ODV3bplge5JCYY7
=jPTa
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
