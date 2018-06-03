From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Common config for N900 and D4
Date: Sun, 3 Jun 2018 18:53:36 +0200
Message-ID: <20180603165336.GA26995@amd>
References: <20180603104839.GA21197@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180603104839.GA21197@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
Cc: aaro.koskinen@iki.fi
List-Id: linux-omap@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
> Aaro, I know I have asked before, but if you have common config for
> N900 and Droid4, please send me a copy. Yes, it should be somewhere in
> my inbox already, but I can't find it and version for v4.17 would be
> more useful.
>=20
> While trying to came up with common config, I hit:
>=20
> [    0.000000] L2C-310 erratum 727915 enabled
> [    0.000000] L2C-310 enabling early BRESP for Cortex-A9
> [    0.000000] L2C-310 full line of zeros enabled for Cortex-A9

I tried disabling outer cache to get rid of this. That got me further
in boot, but not to working system:

[    0.000000] ti_clk_get_reg_addr: clk-provider not found for
auxclkreq0_ck!
[    0.000000] ti_clk_get_reg_addr: clk-provider not found for
auxclkreq1_ck!
[    0.000000] ti_clk_get_reg_addr: clk-provider not found for
auxclkreq2_ck!
[    0.000000] ti_clk_get_reg_addr: clk-provider not found for
auxclkreq3_ck!
[    0.000000] ti_clk_get_reg_addr: clk-provider not found for
auxclkreq4_ck!
[    0.000000] ti_clk_get_reg_addr: clk-provider not found for
auxclkreq5_ck!
[    0.000000] clocksource: 32k_counter: mask: 0xffffffff max_cycles:
0xfffffffs
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns,
wraps every 6s
[    3.105895] OMAP clocksource: 32k_counter at 32768 Hz
[    3.111541] Unable to handle kernel NULL pointer dereference at
virtual addr0
[    3.111541] pgd =3D (ptrval)
[    3.122650] [00000000] *pgd=3D00000000
[    3.122650] Internal error: Oops: 80000005 [#1] SMP ARM
[    3.131683] Modules linked in:
[    3.134826] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
4.17.0-rc7-75535-g2a545
[    3.143310] Hardware name: Generic DT based system
[    3.143310] PC is at   (null)
[    3.143310] LR is at __irq_svc+0x6c/0x90
[    3.143310] pc : [<00000000>]    lr : [<c0101a2c>]    psr: 20000193
[    3.155303] sp : c0d01f70  ip : 00000002  fp : 00000000
[    3.155303] r10: 00000001  r9 : c0d00000  r8 : ef7d2a00
[    3.172424] r7 : c0d01fa4  r6 : ffffffff  r5 : 20000013  r4 :
c0c00b78
[    3.172424] r3 : c01d2db8  r2 : c0d01fc0  r1 : c0d0f678  r0 :
c0d01f70
[    3.172424] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
Segment noe
[    3.193206] Control: 10c5387d  Table: 8000404a  DAC: 00000051
[    3.199096] Process swapper/0 (pid: 0, stack limit =3D 0x(ptrval))
[    3.205261] Stack: (0xc0d01f70 to 0xc0d02000)
[    3.205261] 1f60:                                     00000000
00000000 00000
[    3.205261] 1f80: 00000000 ffffffff c0d50040 c0c358d4 ef7d2a00
411fc093 00000

Best regards,
									Pavel



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsUHRAACgkQMOfwapXb+vIVcwCfbkccWxYFOZuP2LIWDCrs5LBl
bnQAn2Kki+L8AA+RZfgkzpsVfz/PGVlx
=0i73
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
