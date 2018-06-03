From: Pavel Machek <pavel@ucw.cz>
Subject: Common config for N900 and D4
Date: Sun, 3 Jun 2018 12:48:40 +0200
Message-ID: <20180603104839.GA21197@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
Cc: aaro.koskinen@iki.fi
List-Id: linux-omap@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Aaro, I know I have asked before, but if you have common config for
N900 and Droid4, please send me a copy. Yes, it should be somewhere in
my inbox already, but I can't find it and version for v4.17 would be
more useful.

While trying to came up with common config, I hit:

[    0.000000] L2C-310 erratum 727915 enabled
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
[    0.000000] Unhandled fault: imprecise external abort (0xc06) at
0x01f9d31c
[    0.000000] pgd =3D (ptrval)
[    0.000000] [01f9d31c] *pgd=3D00000000
[    0.000000] Internal error: : c06 [#1] ARM
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G        W
4.17.0-rc7-75534-g9416de8-\
dirty #692
[    0.000000] Hardware name: Generic DT based system
[    0.000000] PC is at l2c310_configure+0x38/0x160
[    0.000000] LR is at l2c310_configure+0x10/0x160
[    0.000000] pc : [<c0116168>]    lr : [<c0116140>]    psr: 60000093
[    0.000000] sp : c0d01ec0  ip : 00000001  fp : 00000000
[    0.000000] r10: c0c0674c  r9 : 00000000  r8 : 00000000
[    0.000000] r7 : 00000008  r6 : c0b4a030  r5 : c0d50f4c  r4 :
f0800000
[    0.000000] r3 : 00000000  r2 : 00000000  r1 : 00000008  r0 :
00000000
[    0.000000] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
Segment none
[    0.000000] Control: 10c5387d  Table: 80004059  DAC: 00000051
[    0.000000] Process swapper (pid: 0, stack limit =3D 0x(ptrval))
[    0.000000] Stack: (0xc0d01ec0 to 0xc0d02000)
[    0.000000] 1ec0: f0800000 c0d50f4c c0b4a030 c0115f54 c0d50f4c
f0800000 5e470001 00000004

Which sounds like kernel bug. I was running Droid 4 in !CONFIG_SMP
configuration by mistake, maybe that has something to do with it. I'll
try to investigate more.

Best regards
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsTx4cACgkQMOfwapXb+vL8fwCeI1JPpt1zDdYKsgtVQxH5rvUc
kF8Anjaf2FXbga1vDIDNCZP/G1xgTmIx
=Oqd6
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
