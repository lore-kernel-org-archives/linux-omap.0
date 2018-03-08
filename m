From: Pavel Machek <pavel@ucw.cz>
Subject: Nokia N900: refcount_t underflow, use after free
Date: Thu, 8 Mar 2018 15:30:53 +0100
Message-ID: <20180308143053.GA17267@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
List-Id: linux-omap@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm getting this warning... Has anyone seen/debugged that before?
Unfortunately the backtrace does not seem to be too useful :-(.

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
[    1.244140] omap3isp 480bc000.isp: 480bc000.isp supply vdd-csiphy2
not found, using d
ummy regulator
[    1.254089] omap3isp 480bc000.isp: Revision 2.0 found
[    1.260009] omap-iommu 480bd400.mmu: 480bd400.mmu: version 1.1
[    1.266693] ------------[ cut here ]------------
[    1.271606] WARNING: CPU: 0 PID: 1 at lib/refcount.c:187
refcount_sub_and_test+0x94/0xa8
[    1.280181] refcount_t: underflow; use-after-free.
[    1.285247] Modules linked in:
[    1.288482] CPU: 0 PID: 1 Comm: swapper Not tainted
4.16.0-rc3-next-20180302 #70
[    1.296295] Hardware name: Nokia RX-51 board
[    1.300811] [<c010d6cc>] (unwind_backtrace) from [<c010b560>]
(show_stack+0x10/0x14)
[    1.309020] [<c010b560>] (show_stack) from [<c0127dec>]
(__warn+0xe8/0x110)
[    1.316375] [<c0127dec>] (__warn) from [<c0127edc>]
(warn_slowpath_fmt+0x38/0x48)
[    1.324310] [<c0127edc>] (warn_slowpath_fmt) from [<c034e630>]
(refcount_sub_and_test+0x94/0xa8)
[    1.333557] [<c034e630>] (refcount_sub_and_test) from [<c01109a8>]
(arm_iommu_release_mapping+0x18/0x2c)
[    1.343597] [<c01109a8>] (arm_iommu_release_mapping) from
[<c041752c>] (driver_probe_device+0x24c/0x314)
[    1.353637] [<c041752c>] (driver_probe_device) from [<c04176a0>]
(__driver_attach+0xac/0xb0)
[    1.362548] [<c04176a0>] (__driver_attach) from [<c0415b94>]
(bus_for_each_dev+0x58/0x7c)
[    1.371185] [<c0415b94>] (bus_for_each_dev) from [<c0416a14>]
(bus_add_driver+0xe0/0x1f0)
[    1.379852] [<c0416a14>] (bus_add_driver) from [<c0417f10>]
(driver_register+0x78/0xf4)
[    1.388305] [<c0417f10>] (driver_register) from [<c010257c>]
(do_one_initcall+0x3c/0x16c)
[    1.396972] [<c010257c>] (do_one_initcall) from [<c0b00d5c>]
(kernel_init_freeable+0xf8/0x1c4)
[    1.406066] [<c0b00d5c>] (kernel_init_freeable) from [<c071640c>]
(kernel_init+0x8/0x108)
[    1.414703] [<c071640c>] (kernel_init) from [<c01010e8>]
(ret_from_fork+0x14/0x2c)
[    1.422698] Exception stack(0xce049fb0 to 0xce049ff8)
[    1.428039] 9fa0:                                     00000000
00000000 00000000 00000000
[    1.436676] 9fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    1.445312] 9fe0: 00000000 00000000 00000000 00000000 00000013
00000000
[    1.452270] ---[ end trace dcb3a72772bbfe7a ]---
[    1.459045] ti-soc-thermal 48002524.bandgap: This OMAP thermal
sensor is unreliable. You've been warned
[    1.469055] ti-soc-thermal 48002524.bandgap: Non-trimmed BGAP, Temp
not accurate
[    1.476898] ti-soc-thermal 48002524.bandgap: thermal zone device is
NULL
[    1.485198] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout
60 sec
[    1.495208] omap_hsmmc 4809c000.mmc: GPIO lookup for consumer cd

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqhSR0ACgkQMOfwapXb+vKw1QCgudJXYYHe8FgbyDX7F5Ud23sF
rccAoK14yJHqhHHLBpOe/dYi6o5JkeMU
=3bM8
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
