From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: v3.19: Nokia N900 - boot errors
Date: Sat, 31 Jan 2015 10:28:46 +0100
Message-ID: <201501311028.46357@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4437655.B7auk3ZT6n";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:54412 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbbAaJ2t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 Jan 2015 04:28:49 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

--nextPart4437655.B7auk3ZT6n
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

when I boot 3.19 kernel on real n900 device it show these errors in dmesg:

[    0.256103] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.257659] In-band Error seen by MPU  at address 0
[    0.257720] ------------[ cut here ]------------
[    0.257781] WARNING: CPU: 0 PID: 1 at drivers/bus/omap_l3_smx.c:166 omap=
3_l3_app_irq+0xd4/0x118()
[    0.257843] Modules linked in:
[    0.257873] CPU: 0 PID: 1 Comm: swapper Not tainted 3.19.0-rc5+ #291
[    0.257934] Hardware name: Nokia RX-51 board
[    0.257995] [<c0012678>] (unwind_backtrace) from [<c0010d44>] (show_stac=
k+0x10/0x14)
[    0.258087] [<c0010d44>] (show_stack) from [<c0032194>] (warn_slowpath_c=
ommon+0x84/0xac)
[    0.258148] [<c0032194>] (warn_slowpath_common) from [<c00321d4>] (warn_=
slowpath_null+0x18/0x1c)
[    0.258209] [<c00321d4>] (warn_slowpath_null) from [<c01f30e0>] (omap3_l=
3_app_irq+0xd4/0x118)
[    0.258300] [<c01f30e0>] (omap3_l3_app_irq) from [<c0061fd0>] (handle_ir=
q_event_percpu+0xcc/0x294)
[    0.258361] [<c0061fd0>] (handle_irq_event_percpu) from [<c00621fc>] (ha=
ndle_irq_event+0x64/0x8c)
[    0.258422] [<c00621fc>] (handle_irq_event) from [<c0064b9c>] (handle_le=
vel_irq+0xcc/0x130)
[    0.258483] [<c0064b9c>] (handle_level_irq) from [<c0061850>] (generic_h=
andle_irq+0x20/0x30)
[    0.258544] [<c0061850>] (generic_handle_irq) from [<c0061a38>] (__handl=
e_domain_irq+0x80/0xa4)
[    0.258636] [<c0061a38>] (__handle_domain_irq) from [<c0008520>] (omap_i=
ntc_handle_irq+0x78/0xa4)
[    0.258697] [<c0008520>] (omap_intc_handle_irq) from [<c0409380>] (__irq=
_svc+0x40/0x74)
[    0.258728] Exception stack(0xcf893db0 to 0xcf893df8)
[    0.258789] 3da0:                                     cf982000 c064568c =
00000000 00000000
[    0.258850] 3dc0: c064568c cf982000 00000000 0000001c 60000113 cf982034 =
00000000 00000001
[    0.258880] 3de0: 00000064 cf893df8 c00633f8 c0063430 60000113 ffffffff
[    0.258941] [<c0409380>] (__irq_svc) from [<c0063430>] (__setup_irq+0x3b=
c/0x518)
[    0.259002] [<c0063430>] (__setup_irq) from [<c006376c>] (setup_irq+0x58=
/0x80)
[    0.259063] [<c006376c>] (setup_irq) from [<c002d2c0>] (omap_system_dma_=
probe+0x22c/0x2c0)
[    0.259124] [<c002d2c0>] (omap_system_dma_probe) from [<c0267618>] (plat=
form_drv_probe+0x48/0x90)
[    0.259185] [<c0267618>] (platform_drv_probe) from [<c0265d8c>] (really_=
probe+0xac/0x1e0)
[    0.259277] [<c0265d8c>] (really_probe) from [<c0265fb8>] (driver_probe_=
device+0x30/0x48)
[    0.259338] [<c0265fb8>] (driver_probe_device) from [<c0266030>] (__driv=
er_attach+0x60/0x84)
[    0.259399] [<c0266030>] (__driver_attach) from [<c0264910>] (bus_for_ea=
ch_dev+0x50/0x84)
[    0.259460] [<c0264910>] (bus_for_each_dev) from [<c02656c0>] (bus_add_d=
river+0xac/0x1bc)
[    0.259521] [<c02656c0>] (bus_add_driver) from [<c0266968>] (driver_regi=
ster+0x9c/0xe0)
[    0.259582] [<c0266968>] (driver_register) from [<c0008798>] (do_one_ini=
tcall+0x100/0x1b0)
[    0.259643] [<c0008798>] (do_one_initcall) from [<c05ddcfc>] (do_basic_s=
etup+0x88/0xc0)
[    0.259735] [<c05ddcfc>] (do_basic_setup) from [<c05ddd94>] (kernel_init=
_freeable+0x60/0xfc)
[    0.259796] [<c05ddd94>] (kernel_init_freeable) from [<c03f94dc>] (kerne=
l_init+0x8/0xe4)
[    0.259857] [<c03f94dc>] (kernel_init) from [<c000dc78>] (ret_from_fork+=
0x14/0x3c)
[    0.259948] ---[ end trace a24f42a84395254d ]---

Note that this device has flashed special Nokia X-Loader which enable L3 fi=
rewall for AES support. But=20
omap aes crypto module is not compiled and enabled.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart4437655.B7auk3ZT6n
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTMoE4ACgkQi/DJPQPkQ1IgowCgqo4RZiUQ8C5s1PXZZGtv+L17
RwoAoM0kqMg5hEt2hN/i+zRyAFC3xZ+6
=cy1U
-----END PGP SIGNATURE-----

--nextPart4437655.B7auk3ZT6n--
