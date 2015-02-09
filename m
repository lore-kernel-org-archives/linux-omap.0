From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: v3.19: Nokia N900 (qemu) - omap_aes error
Date: Mon, 9 Feb 2015 12:25:00 +0100
Message-ID: <201502091225.00497@pali>
References: <201501311629.36431@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2378097.JtB1e8RGtQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:45149 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682AbbBILZE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Feb 2015 06:25:04 -0500
In-Reply-To: <201501311629.36431@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Felipe Balbi <balbi@ti.com>, Nishanth Menon <nm@ti.com>

--nextPart2378097.JtB1e8RGtQ
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 31 January 2015 16:29:36 Pali Roh=C3=A1r wrote:
> Hello,
>=20
> when I enable problematic omap_aes.ko driver (also in DT) for
> Nokia N900 machine in qemu (it emulates OMAP GP device, not
> HS) I get this error message in dmesg at modprobe time:
>=20
> [   37.660339] ------------[ cut here ]------------
> [   37.663940] WARNING: CPU: 0 PID: 173 at arch/arm/mach-
> omap2/omap_hwmod.c:2182 _idle+0x28/0x64()
> [   37.668762] omap_hwmod: aes: idle state can only be entered
> from enabled state
> [   37.672271] Modules linked in: omap_aes(+)
> [   37.675933] CPU: 0 PID: 173 Comm: modprobe Not tainted
> 3.19.0- rc5+ #299
> [   37.679534] Hardware name: Nokia RX-51 board
> [   37.683227] [<c0012678>] (unwind_backtrace) from
> [<c0010d44>] (show_stack+0x10/0x14)
> [   37.686920] [<c0010d44>] (show_stack) from [<c0032194>]
> (warn_slowpath_common+0x84/0xac)
> [   37.690765] [<c0032194>] (warn_slowpath_common) from
> [<c003223c>] (warn_slowpath_fmt+0x2c/0x3c)
> [   37.694366] [<c003223c>] (warn_slowpath_fmt) from
> [<c0020cb0>] (_idle+0x28/0x64)
> [   37.698791] [<c0020cb0>] (_idle) from [<c0021078>]
> (omap_hwmod_idle+0x30/0x78)
> [   37.702636] [<c0021078>] (omap_hwmod_idle) from
> [<c00222c4>] (omap_device_idle+0x48/0x6c)
> [   37.707153] [<c00222c4>] (omap_device_idle) from
> [<c0022304>] (_od_runtime_suspend+0x1c/0x24)
> [   37.710723] [<c0022304>] (_od_runtime_suspend) from
> [<c0269680>] (__rpm_callback+0x8c/0xdc)
> [   37.714385] [<c0269680>] (__rpm_callback) from [<c0269740>]
> (rpm_callback+0x70/0x88)
> [   37.717987] [<c0269740>] (rpm_callback) from [<c0269f74>]
> (rpm_suspend+0x2e8/0x5a4)
> [   37.721710] [<c0269f74>] (rpm_suspend) from [<c026a6ec>]
> (__pm_runtime_idle+0x58/0x9c)
> [   37.725402] [<c026a6ec>] (__pm_runtime_idle) from
> [<bf00129c>] (omap_aes_probe+0x15c/0x448 [omap_aes])
> [   37.733489] [<bf00129c>] (omap_aes_probe [omap_aes]) from
> [<c0263d78>] (platform_drv_probe+0x48/0x90)
> [   37.740936] [<c0263d78>] (platform_drv_probe) from
> [<c02624ec>] (really_probe+0xac/0x1e0)
> [   37.745025] [<c02624ec>] (really_probe) from [<c0262718>]
> (driver_probe_device+0x30/0x48)
> [   37.749847] [<c0262718>] (driver_probe_device) from
> [<c0262790>] (__driver_attach+0x60/0x84)
> [   37.753601] [<c0262790>] (__driver_attach) from
> [<c0261070>] (bus_for_each_dev+0x50/0x84)
> [   37.758422] [<c0261070>] (bus_for_each_dev) from
> [<c0261e20>] (bus_add_driver+0xac/0x1bc)
> [   37.762207] [<c0261e20>] (bus_add_driver) from [<c02630c8>]
> (driver_register+0x9c/0xe0)
> [   37.765899] [<c02630c8>] (driver_register) from
> [<c0008798>] (do_one_initcall+0x100/0x1b0)
> [   37.769653] [<c0008798>] (do_one_initcall) from
> [<c0085ca4>] (do_init_module+0x34/0x158)
> [   37.773590] [<c0085ca4>] (do_init_module) from [<c00868d8>]
> (SyS_init_module+0x54/0x64)
> [   37.777252] [<c00868d8>] (SyS_init_module) from
> [<c000dbe0>] (ret_fast_syscall+0x0/0x30)
> [   37.780975] ---[ end trace 86c3e025b92e700d ]---
> [   37.784667] omap-aes 480c5000.aes: OMAP AES hw accel rev:
> 0.0 [   37.789794] of_dma_request_slave_channel: dma-names
> property of node '/ocp/aes@480c5000' missing or empty
> [   37.797668] omap-aes 480c5000.aes: Unable to request in DMA
> channel
> [   37.801391]    omap_aes_dma_init: error: -12
>=20
> Error is not fatal, kernel does not crash and qemu emulation
> working fine. But error is there.
>=20
> I'm sure that qemu does not support omap aes hw emulation and
> so I except error message about missing hw part (or something
> else). But not above unwind_backtrace error message.
>=20
> Any idea why it happens? It is probably not related to AES but
> to DMA. It is for OMAP GP device (but emulated), so can TI
> comment this problem (as this is not HS under NDA)?

Hello,

what does that error line means?

[   37.668762] omap_hwmod: aes: idle state can only be entered=20
from enabled state

Is not it bug in omap_hwmod.c code?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2378097.JtB1e8RGtQ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTYmQwACgkQi/DJPQPkQ1I7NACeJR5bxdeCmlopYg6CA0GYiQ6C
o2EAoMyWbP5fzuqisy93O+W5DQnjYzt2
=Ef/A
-----END PGP SIGNATURE-----

--nextPart2378097.JtB1e8RGtQ--
