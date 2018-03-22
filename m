From: Pavel Machek <pavel@ucw.cz>
Subject: v4.16-rc5 on droid4: external abort in l2c310_configure+0x38/0x160
Date: Thu, 22 Mar 2018 13:04:00 +0100
Message-ID: <20180322120359.GA12518@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net
List-Id: linux-omap@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm trying to get something to work on Droid 4.

So far, v4.14 from leste project works, with the right config. I tried
v4.16-rc5 next, and am stopped in early boot by:

If someone knows what this is let me know, but I guess it is
config-dependend and I'll just try different one...

Best regards,
							Pavel

r=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDL2=
C-310 erratum 727915 enabled
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
[    0.000000] Unhandled fault: imprecise external abort (0xc06) at
0x0209931c
[    0.000000] pgd =3D (ptrval)
[    0.000000] [0209931c] *pgd=3D00000000
[    0.000000] Internal error: : c06 [#1] ARM
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G        W
4.16.0-rc4
[    0.000000] Hardware name: Generic DT based system
[    0.000000] PC is at l2c310_configure+0x38/0x160
[    0.000000] LR is at l2c310_configure+0x10/0x160
[    0.000000] pc : [<c0116128>]    lr : [<c0116100>]    psr: 60000093
[    0.000000] sp : c0c01ec0  ip : 00000001  fp : 00000000
[    0.000000] r10: c0b0666c  r9 : 00000000  r8 : 00000000
[    0.000000] r7 : 00000008  r6 : c0a24030  r5 : c0c4cf48  r4 :
f0800000
[    0.000000] r3 : 00000000  r2 : 00000000  r1 : 00000008  r0 :
00000000
[    0.000000] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
Segment noe
[    0.000000] Control: 10c5387d  Table: 80004059  DAC: 00000051
[    0.000000] Process swapper (pid: 0, stack limit =3D 0x(ptrval))
[    0.000000] Stack: (0xc0c01ec0 to 0xc0c02000)
[    0.000000] 1ec0: f0800000 c0c4cf48 c0a24030 c0115f14 c0c4cf48
f0800000 5e474
[    0.000000] 1ee0: 00000000 c0b06ac0 c0b3cf38 c015cbb0 efdca020
00000008 00008
[    0.000000] 1f00: 5e470000 00000010 410000c4 c0b075c0 ef7d4dd8
c0c4cf48 ef7d8
[    0.000000] 1f20: c0116020 c0116068 c011687c c0116280 c01160b0
c0116d2c 00000
[    0.000000] 1f40: c0b3cf38 410000c4 ffffffff c0b3cf38 00000000
00000000 411f1
[    0.000000] 1f60: 00000000 c0b07908 00000000 c0c01f7c ffffffff
00000000 00002
[    0.000000] 1f80: 48242000 48242fff ef7d4e30 00000200 00000000
00000000 00000
[    0.000000] 1fa0: c0b338c4 ffffffff c0c4ccc0 c0b338d4 ef7d3ec0
c0b02180 0000c
[    0.000000] 1fc0: ffffffff ffffffff 00000000 c0b0068c c0b338d4
4e80ae6d 00000
[    0.000000] 1fe0: 00000051 10c0387d ffffffff 81909000 10c5387d
00000000 00000
[    0.000000] [<c0116128>] (l2c310_configure) from [<c0115f14>]
(l2c_enable+0x)
[    0.000000] [<c0115f14>] (l2c_enable) from [<c0b06ac0>]
(l2c310_enable+0x134)
[    0.000000] [<c0b06ac0>] (l2c310_enable) from [<c0b075c0>]
(__l2c_init.part.)
[    0.000000] [<c0b075c0>] (__l2c_init.part.5) from [<c0b07908>]
(l2x0_of_init)
[    0.000000] [<c0b07908>] (l2x0_of_init) from [<c0b02180>]
(init_IRQ+0x60/0x8)
[    0.000000] [<c0b02180>] (init_IRQ) from [<c0b00b1c>]
(start_kernel+0x23c/0x)
[    0.000000] [<c0b00b1c>] (start_kernel) from [<00000000>] (
(null))
[    0.000000] Code: e3530000 0a000040 e3a01f42 e12fff33 (e595000c)
[    0.000000] ---[ end trace e2e09be4641cfc91 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle
task!


+
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqzm68ACgkQMOfwapXb+vLgGgCgggi6pfIlAnsBCNfsMZF7n7AF
4YsAnjEmhs4DA4oqySFLgiLpQPsBPX/t
=Ql3/
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
