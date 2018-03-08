From: Pavel Machek <pavel@ucw.cz>
Subject: Nokia N900: insecure W+X mapping at 0xd0050000
Date: Thu, 8 Mar 2018 15:28:18 +0100
Message-ID: <20180308142818.GA9439@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
List-Id: linux-omap@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Insecure W+X mappings, who cares about those? I have 7 pages...

								Pavel

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.16.0-rc3-next-20180302 (pavel@duo) (gcc
version 4.7.2 (GC
C)) #70 Fri Mar 2 10:16:00 CET 2018
[    0.000000] CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7),
cr=3D10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT
nonaliasing instruction cac
=2E..
[    1.266693] ------------[ cut here ]------------
[    1.271606] WARNING: CPU: 0 PID: 1 at lib/refcount.c:187
refcount_sub_and_test+0x94/0xa8
[    1.280181] refcount_t: underflow; use-after-free.
[    1.285247] Modules linked in:
=2E..
[    4.557220] devtmpfs: mounted
[    4.569610] Freeing unused kernel memory: 1024K
[    4.581481] ------------[ cut here ]------------
[    4.592376] WARNING: CPU: 0 PID: 1 at arch/arm/mm/dump.c:253
note_page+0x2f8/0x328
[    4.606658] arm/mm: Found insecure W+X mapping at address
0xd0050000
[    4.619781] Modules linked in:
[    4.629272] CPU: 0 PID: 1 Comm: swapper Tainted: G        W
4.16.0-rc3-next-20180302 #70
[    4.645111] Hardware name: Nokia RX-51 board
[    4.655944] [<c010d6cc>] (unwind_backtrace) from [<c010b560>]
(show_stack+0x10/0x14)
[    4.670593] [<c010b560>] (show_stack) from [<c0127dec>]
(__warn+0xe8/0x110)
[    4.684295] [<c0127dec>] (__warn) from [<c0127edc>]
(warn_slowpath_fmt+0x38/0x48)
[    4.698455] [<c0127edc>] (warn_slowpath_fmt) from [<c0113aa8>]
(note_page+0x2f8/0x328)
[    4.713134] [<c0113aa8>] (note_page) from [<c0113b60>]
(walk_pgd+0x88/0x178)
[    4.726837] [<c0113b60>] (walk_pgd) from [<c0113d28>]
(ptdump_check_wx+0x64/0xb8)
[    4.741210] [<c0113d28>] (ptdump_check_wx) from [<c0716428>]
(kernel_init+0x24/0x108)
[    4.755859] [<c0716428>] (kernel_init) from [<c01010e8>]
(ret_from_fork+0x14/0x2c)
[    4.770294] Exception stack(0xce049fb0 to 0xce049ff8)
[    4.781921] 9fa0:                                     00000000
00000000 00000000 00000000
[    4.796966] 9fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    4.812011] 9fe0: 00000000 00000000 00000000 00000000 00000013
00000000
[    4.825378] ---[ end trace dcb3a72772bbfe7c ]---
[    4.837005] Checked W+X mappings: FAILED, 7 W+X pages found

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqhSIIACgkQMOfwapXb+vJu7gCgprgv0HDXcT/qcKRI8gLrhm7l
Gg4An2wgXSvSTYcH6d/tDSxfjCgpCta5
=w/jA
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
