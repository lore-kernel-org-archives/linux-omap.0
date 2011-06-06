From: Felipe Balbi <balbi@ti.com>
Subject: Re: Oops on ehci_hcd when booting 3.0.0-rc2 on panda
Date: Mon, 6 Jun 2011 13:44:18 +0300
Message-ID: <20110606104417.GP18731@legolas.emea.dhcp.ti.com>
References: <1307356643.23002.413.camel@cumari>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IYV9cRr2u6rjcP4B"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:52939 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754175Ab1FFKo0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jun 2011 06:44:26 -0400
Content-Disposition: inline
In-Reply-To: <1307356643.23002.413.camel@cumari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luciano Coelho <coelho@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com


--IYV9cRr2u6rjcP4B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi,

On Mon, Jun 06, 2011 at 01:37:23PM +0300, Luciano Coelho wrote:
> I'm getting this kernel oops when trying to boot 3.0.0-rc2 on my
> pandaboard.  Does anyone know what could be causing it?
>=20
> The full kernel log and my .config are attached.
>=20
> [    3.821197] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    3.841735] Unhandled fault: imprecise external abort (0x1406) at 0x00=
000000
> [    3.863464] Internal error: : 1406 [#1] SMP
> [    3.876342] Modules linked in:
> [    3.885772] CPU: 0    Not tainted  (3.0.0-rc2 #184)
> [    3.900787] PC is at omap_usbhs_enable+0x134/0x488
> [    3.915557] LR is at trace_hardirqs_off+0x14/0x18
> [    3.930053] pc : [<c02ec13c>]    lr : [<c00cd5c8>]    psr: 60000093
> [    3.930084] sp : df871db8  ip : df871d70  fp : df871ddc
> [    3.965484] r10: 80000013  r9 : fc064c00  r8 : dfa41464
> [    3.981567] r7 : c06d5058  r6 : dfa48c00  r5 : dfa41420  r4 : df871e51
> [    4.001708] r3 : 00000000  r2 : 00000000  r1 : df86f400  r0 : c070aa08
> [    4.021820] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segm=
ent kernel
> [    4.044647] Control: 10c53c7d  Table: 8000404a  DAC: 00000015
> [    4.062347] Process swapper (pid: 1, stack limit =3D 0xdf8702f8)
> [    4.080322] Stack: (0xdf871db8 to 0xdf872000)
> [    4.093749] 1da0:                                                     =
  df871e51 df8ce26c
> [    4.118957] 1dc0: dfa48c00 00000003 df8ce260 dfbf0000 df871e84 df871de=
0 c0368c20 c02ec014
> [    4.144195] 1de0: 22222222 22222222 df871e38 dfbf4388 dfbf4308 df871e3=
8 df871e24 df871e08
> [    4.169403] 1e00: 00000000 dfbf4308 dfa48c08 dfbee160 0000006d 0000000=
1 df871e64 df871e28
> [    4.194641] 1e20: c01a0bdc c01a0284 df871e4c c00bf518 c00cf7e0 c00cf45=
0 dfa43ec8 00000000
> [    4.219848] 1e40: dfa48c08 00000000 dfa48c10 dfbee160 757368a0 0030627=
3 df871e74 dfa48c08
> [    4.245086] 1e60: dfa48c08 c06f3c0c dfbee160 c06ea6a0 00000000 0000000=
0 df871e94 df871e88
> [    4.270294] 1e80: c02dd8f0 c0368a80 df871ebc df871e98 c02dc254 c02dd8d=
4 dfa48c08 dfa48c3c
> [    4.295532] 1ea0: c06f3c0c dfa48c08 dfa48c3c c06f3c0c df871edc df871ec=
0 c02dc3f4 c02dc104
> [    4.320739] 1ec0: 00000000 c02dc37c c06f3c0c dfbee160 df871f04 df871ee=
0 c02db7f8 c02dc388
> [    4.345977] 1ee0: df89b658 dfa413f0 c027f8a8 c0c5774c c0c57cf8 c06f3c0=
c df871f14 df871f08
> [    4.371215] 1f00: c02dbf34 c02db7ac df871f44 df871f18 c02dafd4 c02dbf1=
8 c05ec331 df871f28
> [    4.396423] 1f20: c0c5774c c0c57cf8 c06f3c0c 00000013 00000000 c00282c=
0 df871f6c df871f48
> [    4.421661] 1f40: c02dcad8 c02daf08 c0c5774c c0c57cf8 c006300c 0000001=
3 00000000 00000000
> [    4.446868] 1f60: df871f7c df871f70 c02ddde0 c02dca2c df871f9c df871f8=
0 c0028368 c02ddd98
> [    4.472106] 1f80: 000000a0 00000060 c00333ac c0008554 df871fdc df871fa=
0 c00565e8 c00282cc
> [    4.497314] 1fa0: 00000000 0000019a c006300c c00e651c df871fdc c00333a=
c c0008554 c006300c
> [    4.522552] 1fc0: 00000013 00000000 00000000 00000000 df871ff4 df871fe=
0 c00085fc c0056550
> [    4.547760] 1fe0: 00000000 c0008554 00000000 df871ff8 c006300c c000856=
0 c0080000 f3ac400e
> [    4.572998] [<c02ec13c>] (omap_usbhs_enable+0x134/0x488) from [<c0368c=
20>] (ehci_hcd_omap_probe+0x1ac/0x584)
> [    4.603332] [<c0368c20>] (ehci_hcd_omap_probe+0x1ac/0x584) from [<c02d=
d8f0>] (platform_drv_probe+0x28/0x2c)
> [    4.633392] [<c02dd8f0>] (platform_drv_probe+0x28/0x2c) from [<c02dc25=
4>] (driver_probe_device+0x15c/0x284)
> [    4.663452] [<c02dc254>] (driver_probe_device+0x15c/0x284) from [<c02d=
c3f4>] (__driver_attach+0x78/0x9c)
> [    4.692687] [<c02dc3f4>] (__driver_attach+0x78/0x9c) from [<c02db7f8>]=
 (bus_for_each_dev+0x58/0x8c)
> [    4.720611] [<c02db7f8>] (bus_for_each_dev+0x58/0x8c) from [<c02dbf34>=
] (driver_attach+0x28/0x30)
> [    4.747985] [<c02dbf34>] (driver_attach+0x28/0x30) from [<c02dafd4>] (=
bus_add_driver+0xd8/0x268)
> [    4.775085] [<c02dafd4>] (bus_add_driver+0xd8/0x268) from [<c02dcad8>]=
 (driver_register+0xb8/0x140)
> [    4.802978] [<c02dcad8>] (driver_register+0xb8/0x140) from [<c02ddde0>=
] (platform_driver_register+0x54/0x68)
> [    4.833343] [<c02ddde0>] (platform_driver_register+0x54/0x68) from [<c=
0028368>] (ehci_hcd_init+0xa8/0xfc)
> [    4.862854] [<c0028368>] (ehci_hcd_init+0xa8/0xfc) from [<c00565e8>] (=
do_one_initcall+0xa4/0x178)
> [    4.890228] [<c00565e8>] (do_one_initcall+0xa4/0x178) from [<c00085fc>=
] (kernel_init+0xa8/0x15c)
> [    4.917327] [<c00085fc>] (kernel_init+0xa8/0x15c) from [<c006300c>] (k=
ernel_thread_exit+0x0/0x8)
> [    4.944427] Code: e59f032c e1a01007 e59f233c ebffb0b0 (e5953024)=20

looks like this is resulting from the missing hwmod conversion in
mainlnie. Check if reverting 7e6502d577106fb5b202bbaac64c5f1b065e6daa
helps.

--=20
balbi

--IYV9cRr2u6rjcP4B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN7K+AAAoJEAv8Txj19kN1t38H/25WBpaf2haL0nlc185KXThQ
k2Ur597+Nz5AMynAMLlt/QvX/stooYnuC9VANmtpdt5928F3XOwTvtR4DJb2DlqR
JrUBaZ+cvQHcZgXEM5/ravlN98PcelCO9CILzscnnjdlTenEgAZGc1gWpjYYuq/I
XZ0mvRxJ7Rxs019lUcUl4JqQ/hbvgZyDHtCqHQkNoLWTGKcSJGcy2IT/0abcdqE+
F5yS+ES9ijN3SfiphQ9zz4kZTWswPy9obu8O8Iwklq0dC11i3twdVyByv13WxAKL
znBVQvK6Bqq30ksR3gRXUIKaKDd4/ryPq3vFDCtLPI6FhJfX2ON8//aAtYZ1ACU=
=3Fll
-----END PGP SIGNATURE-----

--IYV9cRr2u6rjcP4B--
