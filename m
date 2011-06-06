From: Felipe Balbi <balbi@ti.com>
Subject: Re: Oops on ehci_hcd when booting 3.0.0-rc2 on panda
Date: Mon, 6 Jun 2011 14:02:19 +0300
Message-ID: <20110606110218.GS18731@legolas.emea.dhcp.ti.com>
References: <1307356643.23002.413.camel@cumari>
 <20110606104417.GP18731@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KD3NH8oGZ7XN2Llp"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:57745 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753028Ab1FFLC0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jun 2011 07:02:26 -0400
Content-Disposition: inline
In-Reply-To: <20110606104417.GP18731@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Luciano Coelho <coelho@ti.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Keshava Munegowda <keshava_mgowda@ti.com>


--KD3NH8oGZ7XN2Llp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 06, 2011 at 01:44:18PM +0300, Felipe Balbi wrote:
> > [    3.821197] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driv=
er
> > [    3.841735] Unhandled fault: imprecise external abort (0x1406) at 0x=
00000000
> > [    3.863464] Internal error: : 1406 [#1] SMP
> > [    3.876342] Modules linked in:
> > [    3.885772] CPU: 0    Not tainted  (3.0.0-rc2 #184)
> > [    3.900787] PC is at omap_usbhs_enable+0x134/0x488
> > [    3.915557] LR is at trace_hardirqs_off+0x14/0x18
> > [    3.930053] pc : [<c02ec13c>]    lr : [<c00cd5c8>]    psr: 60000093
> > [    3.930084] sp : df871db8  ip : df871d70  fp : df871ddc
> > [    3.965484] r10: 80000013  r9 : fc064c00  r8 : dfa41464
> > [    3.981567] r7 : c06d5058  r6 : dfa48c00  r5 : dfa41420  r4 : df871e=
51
> > [    4.001708] r3 : 00000000  r2 : 00000000  r1 : df86f400  r0 : c070aa=
08
> > [    4.021820] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Se=
gment kernel
> > [    4.044647] Control: 10c53c7d  Table: 8000404a  DAC: 00000015
> > [    4.062347] Process swapper (pid: 1, stack limit =3D 0xdf8702f8)
> > [    4.080322] Stack: (0xdf871db8 to 0xdf872000)
> > [    4.093749] 1da0:                                                   =
    df871e51 df8ce26c
> > [    4.118957] 1dc0: dfa48c00 00000003 df8ce260 dfbf0000 df871e84 df871=
de0 c0368c20 c02ec014
> > [    4.144195] 1de0: 22222222 22222222 df871e38 dfbf4388 dfbf4308 df871=
e38 df871e24 df871e08
> > [    4.169403] 1e00: 00000000 dfbf4308 dfa48c08 dfbee160 0000006d 00000=
001 df871e64 df871e28
> > [    4.194641] 1e20: c01a0bdc c01a0284 df871e4c c00bf518 c00cf7e0 c00cf=
450 dfa43ec8 00000000
> > [    4.219848] 1e40: dfa48c08 00000000 dfa48c10 dfbee160 757368a0 00306=
273 df871e74 dfa48c08
> > [    4.245086] 1e60: dfa48c08 c06f3c0c dfbee160 c06ea6a0 00000000 00000=
000 df871e94 df871e88
> > [    4.270294] 1e80: c02dd8f0 c0368a80 df871ebc df871e98 c02dc254 c02dd=
8d4 dfa48c08 dfa48c3c
> > [    4.295532] 1ea0: c06f3c0c dfa48c08 dfa48c3c c06f3c0c df871edc df871=
ec0 c02dc3f4 c02dc104
> > [    4.320739] 1ec0: 00000000 c02dc37c c06f3c0c dfbee160 df871f04 df871=
ee0 c02db7f8 c02dc388
> > [    4.345977] 1ee0: df89b658 dfa413f0 c027f8a8 c0c5774c c0c57cf8 c06f3=
c0c df871f14 df871f08
> > [    4.371215] 1f00: c02dbf34 c02db7ac df871f44 df871f18 c02dafd4 c02db=
f18 c05ec331 df871f28
> > [    4.396423] 1f20: c0c5774c c0c57cf8 c06f3c0c 00000013 00000000 c0028=
2c0 df871f6c df871f48
> > [    4.421661] 1f40: c02dcad8 c02daf08 c0c5774c c0c57cf8 c006300c 00000=
013 00000000 00000000
> > [    4.446868] 1f60: df871f7c df871f70 c02ddde0 c02dca2c df871f9c df871=
f80 c0028368 c02ddd98
> > [    4.472106] 1f80: 000000a0 00000060 c00333ac c0008554 df871fdc df871=
fa0 c00565e8 c00282cc
> > [    4.497314] 1fa0: 00000000 0000019a c006300c c00e651c df871fdc c0033=
3ac c0008554 c006300c
> > [    4.522552] 1fc0: 00000013 00000000 00000000 00000000 df871ff4 df871=
fe0 c00085fc c0056550
> > [    4.547760] 1fe0: 00000000 c0008554 00000000 df871ff8 c006300c c0008=
560 c0080000 f3ac400e
> > [    4.572998] [<c02ec13c>] (omap_usbhs_enable+0x134/0x488) from [<c036=
8c20>] (ehci_hcd_omap_probe+0x1ac/0x584)
> > [    4.603332] [<c0368c20>] (ehci_hcd_omap_probe+0x1ac/0x584) from [<c0=
2dd8f0>] (platform_drv_probe+0x28/0x2c)
> > [    4.633392] [<c02dd8f0>] (platform_drv_probe+0x28/0x2c) from [<c02dc=
254>] (driver_probe_device+0x15c/0x284)
> > [    4.663452] [<c02dc254>] (driver_probe_device+0x15c/0x284) from [<c0=
2dc3f4>] (__driver_attach+0x78/0x9c)
> > [    4.692687] [<c02dc3f4>] (__driver_attach+0x78/0x9c) from [<c02db7f8=
>] (bus_for_each_dev+0x58/0x8c)
> > [    4.720611] [<c02db7f8>] (bus_for_each_dev+0x58/0x8c) from [<c02dbf3=
4>] (driver_attach+0x28/0x30)
> > [    4.747985] [<c02dbf34>] (driver_attach+0x28/0x30) from [<c02dafd4>]=
 (bus_add_driver+0xd8/0x268)
> > [    4.775085] [<c02dafd4>] (bus_add_driver+0xd8/0x268) from [<c02dcad8=
>] (driver_register+0xb8/0x140)
> > [    4.802978] [<c02dcad8>] (driver_register+0xb8/0x140) from [<c02ddde=
0>] (platform_driver_register+0x54/0x68)
> > [    4.833343] [<c02ddde0>] (platform_driver_register+0x54/0x68) from [=
<c0028368>] (ehci_hcd_init+0xa8/0xfc)
> > [    4.862854] [<c0028368>] (ehci_hcd_init+0xa8/0xfc) from [<c00565e8>]=
 (do_one_initcall+0xa4/0x178)
> > [    4.890228] [<c00565e8>] (do_one_initcall+0xa4/0x178) from [<c00085f=
c>] (kernel_init+0xa8/0x15c)
> > [    4.917327] [<c00085fc>] (kernel_init+0xa8/0x15c) from [<c006300c>] =
(kernel_thread_exit+0x0/0x8)
> > [    4.944427] Code: e59f032c e1a01007 e59f233c ebffb0b0 (e5953024)=20
>=20
> looks like this is resulting from the missing hwmod conversion in
> mainlnie. Check if reverting 7e6502d577106fb5b202bbaac64c5f1b065e6daa
> helps.

I verified off-list with Luca that reverting that commit does make it
work. Keshava, care to send a revert patch to Sam until we get all the
hwmod stuff in.

--=20
balbi

--KD3NH8oGZ7XN2Llp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN7LO6AAoJEAv8Txj19kN1sOIH/jajNu3O7H6pUo6ujXFkTAxv
AHq1gfingSWDVb1K6YU3BEkiDxbPjIcO2sTLfGmNjrZzwqL9qe5Pvo6m294nqVQ7
G83a+VZxthb46eY1H71PNQx5CZLvrfWcmw7cntvDfh4zLy5vUYgC83v5BjGcmItl
mrgbxckdGtqqlfURSDLmPPmM86NinK7aQxKX7qXkP9TgOsl0jqFwHJfqphSttZ+w
Vq6ujpzF418dg1tnnY4RcFOMcaMZPwkrzyuP8jZiK6PQKI6naNSRP4oPNLDU9BpM
tiIHj+UW0prenAwiHICq7w5mJdyRR8dqJPMKJj2HLObgwHCAO/VwLDRfJkq3byo=
=5hKE
-----END PGP SIGNATURE-----

--KD3NH8oGZ7XN2Llp--
