From: Felipe Balbi <balbi@ti.com>
Subject: Division by zero caused by CCF
Date: Tue, 16 Jul 2013 15:37:09 +0300
Message-ID: <20130716123709.GA15036@arwen.pp.htv.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36293 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754627Ab3GPMiC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Jul 2013 08:38:02 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>, mturquette@linaro.or, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

trying to get USB host verified on OMAP5 uEVM with v3.11-rc1. The
clk_set_rate() call ends up in a division by zero, which is quite
interesting provided the driver will only call clk_set_rate() if the
clock is valid and clk_rate is !=3D 0.


[   22.009238] Division by zero in kernel.
[   22.009250] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W    3.11.0-=
rc1-00081-g3310d44-dirty #118
[   22.009275] [<c001c83c>] (unwind_backtrace+0x0/0xf0) from [<c0018a1c>] (=
show_stack+0x10/0x14)
[   22.009289] [<c0018a1c>] (show_stack+0x10/0x14) from [<c057403c>] (dump_=
stack+0x70/0x8c)
[   22.009304] [<c057403c>] (dump_stack+0x70/0x8c) from [<c02e4154>] (Ldiv0=
+0x8/0x10)
[   22.009319] [<c02e4154>] (Ldiv0+0x8/0x10) from [<c048d460>] (clk_divider=
_set_rate+0x10/0xdc)
[   22.009331] [<c048d460>] (clk_divider_set_rate+0x10/0xdc) from [<c048c12=
4>] (clk_change_rate+0x38/0xb0)
[   22.009341] [<c048c124>] (clk_change_rate+0x38/0xb0) from [<c048c20c>] (=
clk_set_rate+0x70/0xa8)
[   22.009354] [<c048c20c>] (clk_set_rate+0x70/0xa8) from [<c042b244>] (nop=
_usb_xceiv_probe+0x1fc/0x2f8)
[   22.009369] [<c042b244>] (nop_usb_xceiv_probe+0x1fc/0x2f8) from [<c036b4=
7c>] (platform_drv_probe+0x18/0x1c)
[   22.009380] [<c036b47c>] (platform_drv_probe+0x18/0x1c) from [<c0369f44>=
] (really_probe+0x70/0x1f4)
[   22.009390] [<c0369f44>] (really_probe+0x70/0x1f4) from [<c036a1dc>] (dr=
iver_probe_device+0x30/0x48)
[   22.009401] [<c036a1dc>] (driver_probe_device+0x30/0x48) from [<c036a288=
>] (__driver_attach+0x94/0x98)
[   22.009411] [<c036a288>] (__driver_attach+0x94/0x98) from [<c0368748>] (=
bus_for_each_dev+0x54/0x88)
[   22.009420] [<c0368748>] (bus_for_each_dev+0x54/0x88) from [<c036972c>] =
(bus_add_driver+0xdc/0x29c)
[   22.009430] [<c036972c>] (bus_add_driver+0xdc/0x29c) from [<c036a760>] (=
driver_register+0x78/0x190)
[   22.009440] [<c036a760>] (driver_register+0x78/0x190) from [<c00087b0>] =
(do_one_initcall+0x34/0x164)
[   22.009453] [<c00087b0>] (do_one_initcall+0x34/0x164) from [<c07b18f4>] =
(do_basic_setup+0x90/0xc4)
[   22.009466] [<c07b18f4>] (do_basic_setup+0x90/0xc4) from [<c07b199c>] (k=
ernel_init_freeable+0x74/0x110)
[   22.009478] [<c07b199c>] (kernel_init_freeable+0x74/0x110) from [<c05676=
c4>] (kernel_init+0x8/0xe4)
[   22.009491] [<c05676c4>] (kernel_init+0x8/0xe4) from [<c0014648>] (ret_f=
rom_fork+0x14/0x2c)

I believe the problem is the actual division reaching
clk_divider_set_rate().

drivers/clk/clk-divider.c::clk_divider_set_rate()

| static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
|                                 unsigned long parent_rate)
| {
|         struct clk_divider *divider =3D to_clk_divider(hw);
|         unsigned int div, value;
|         unsigned long flags =3D 0;
|         u32 val;
|=20
|         div =3D parent_rate / rate;

right here, but how come rate would zero provided driver checks for it
as below.

drivers/usb/phy/phy-nop.c::nop_usb_xceiv_probe()

|         if (!IS_ERR(nop->clk) && clk_rate) {
|                 err =3D clk_set_rate(nop->clk, clk_rate);
|                 if (err) {
|                         dev_err(&pdev->dev, "Error setting clock rate\n");
|                         return err;
|                 }
|         }

I've added a few prints around CCF to try and track what's going on:

[   21.592690] =3D=3D=3D=3D> nop_usb_xceiv_probe rate 19200000
[   21.592700] =3D=3D=3D=3D> clk_set_rate rate 19200000
[   21.592707] =3D=3D=3D=3D> clk_calc_new_rates rate 19200000
[   21.592713] =3D=3D=3D=3D> clk_divider_round_rate rate 19200000
[   21.592719] =3D=3D=3D=3D> clk_divider_bestdiv rate 19200000
[   21.592726] =3D=3D=3D=3D> clk_change_rate best_parent_rate 0
[   21.592732] =3D=3D=3D=3D> clk_divider_set_rate rate 0
[   21.592737] Division by zero in kernel.
[   21.592747] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W    3.11.0-=
rc1-00081-g3310d44-dirty #121
[   21.592773] [<c001c83c>] (unwind_backtrace+0x0/0xf0) from [<c0018a1c>] (=
show_stack+0x10/0x14)
[   21.592787] [<c0018a1c>] (show_stack+0x10/0x14) from [<c057400c>] (dump_=
stack+0x70/0x8c)
[   21.592803] [<c057400c>] (dump_stack+0x70/0x8c) from [<c02e4154>] (Ldiv0=
+0x8/0x10)
[   21.592819] [<c02e4154>] (Ldiv0+0x8/0x10) from [<c048d3e0>] (clk_divider=
_set_rate+0x2c/0x100)
[   21.592831] [<c048d3e0>] (clk_divider_set_rate+0x2c/0x100) from [<c048c0=
50>] (clk_change_rate+0x48/0xe0)
[   21.592841] [<c048c050>] (clk_change_rate+0x48/0xe0) from [<c048c174>] (=
clk_set_rate+0x8c/0xc0)
[   21.592855] [<c048c174>] (clk_set_rate+0x8c/0xc0) from [<c042b254>] (nop=
_usb_xceiv_probe+0x20c/0x304)
[   21.592869] [<c042b254>] (nop_usb_xceiv_probe+0x20c/0x304) from [<c036b4=
7c>] (platform_drv_probe+0x18/0x1c)
[   21.592880] [<c036b47c>] (platform_drv_probe+0x18/0x1c) from [<c0369f44>=
] (really_probe+0x70/0x1f4)
[   21.592891] [<c0369f44>] (really_probe+0x70/0x1f4) from [<c036a1dc>] (dr=
iver_probe_device+0x30/0x48)
[   21.592901] [<c036a1dc>] (driver_probe_device+0x30/0x48) from [<c036a288=
>] (__driver_attach+0x94/0x98)
[   21.592911] [<c036a288>] (__driver_attach+0x94/0x98) from [<c0368748>] (=
bus_for_each_dev+0x54/0x88)
[   21.592921] [<c0368748>] (bus_for_each_dev+0x54/0x88) from [<c036972c>] =
(bus_add_driver+0xdc/0x29c)
[   21.592930] [<c036972c>] (bus_add_driver+0xdc/0x29c) from [<c036a760>] (=
driver_register+0x78/0x190)
[   21.592941] [<c036a760>] (driver_register+0x78/0x190) from [<c00087b0>] =
(do_one_initcall+0x34/0x164)
[   21.592954] [<c00087b0>] (do_one_initcall+0x34/0x164) from [<c07b18f4>] =
(do_basic_setup+0x90/0xc4)
[   21.592966] [<c07b18f4>] (do_basic_setup+0x90/0xc4) from [<c07b199c>] (k=
ernel_init_freeable+0x74/0x110)
[   21.592980] [<c07b199c>] (kernel_init_freeable+0x74/0x110) from [<c05676=
94>] (kernel_init+0x8/0xe4)
[   21.592992] [<c0567694>] (kernel_init+0x8/0xe4) from [<c0014648>] (ret_f=
rom_fork+0x14/0x2c)

even though driver passed 19.2MHz, best_parent_rate ends up being zero
which triggers the division by zero above.

cheers

--=20
balbi

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR5T51AAoJEIaOsuA1yqREMk8P/2WxK8Rhyny7/QfTsTp6esXx
COXD4t0xjvEOYn9zv3+dAIXQhZ1BhnJ7qPtRABfQT6YhmpyLyx2CzwyToTkWMHp9
p0+hDy/RM6ny0qH5gQRFEOMn6KT7R/9BHvhpd9/8KnH/i8frRZAv37RDNs3xf+dV
LIm+sDdbqtDayr0ozcRUgIi50+XdLshgPMWoAkAcR7NAD3gJx3CCSv/KYulLcu/s
Gqm3Z3w0jacZde+N1EQXaiGp1cbVR6MLDc/1qOB7KU11mMPcQuuSbphKQsR6s95R
lpMNPIkr2ZUSSr4/uobfbsTOjqCXK4ayeBLGWrjeJ7t+9Ph00iUW3Nb2eSU+dxC4
wHvT6iwEIWRVKopBKw27VACtiU9oyl4Wy95oskGRsY/nIqDRlSiKA1/yaSWMK7NT
kUPKjEBL14stQ6y2Vp6vf1pozkQGVvKg6QBXC27ZPXg4oXviO0aMY+QqnHs3oO61
YLvXd+B6Luf4MrGnNZl/An9KBjrhJTQVQy11K3XJK2D4l/alqzAk40avSEMUymnH
ePZoZRPuFBgvQMvFh0Y0YbEd/baN9OSvqVqSzTiuoTEIBOK/RXgPNo4Qn6Of60X9
xfdM0mWlIaxeeI1cyCh9PsUkXMlZLMYq3iCXi4tBgUy4W9xyYLOdZf5SqMUabiMR
3vWeeubP/C0fYLGGSfc2
=jvRQ
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
