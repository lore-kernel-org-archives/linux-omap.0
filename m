From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: Oops on ehci_hcd when booting 3.0.0-rc2 on panda
Date: Tue, 9 Aug 2011 17:47:40 +0300
Message-ID: <20110809144739.GZ32212@legolas.emea.dhcp.ti.com>
References: <1307356643.23002.413.camel@cumari>
 <20110606104417.GP18731@legolas.emea.dhcp.ti.com>
 <20110606110218.GS18731@legolas.emea.dhcp.ti.com>
 <1307358348.23002.419.camel@cumari>
 <1312889168.2407.148.camel@cumari>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jxJZfy9MYHgKPwT/"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1312889168.2407.148.camel@cumari>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luciano Coelho <coelho-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--jxJZfy9MYHgKPwT/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Keshava this one is for you (sorry for the top-post)

On Tue, Aug 09, 2011 at 02:26:08PM +0300, Luciano Coelho wrote:
> Hi,
>=20
> On Mon, 2011-06-06 at 14:05 +0300, Luciano Coelho wrote:=20
> > On Mon, 2011-06-06 at 14:02 +0300, Felipe Balbi wrote:=20
> > > On Mon, Jun 06, 2011 at 01:44:18PM +0300, Felipe Balbi wrote:
> > > > looks like this is resulting from the missing hwmod conversion in
> > > > mainlnie. Check if reverting 7e6502d577106fb5b202bbaac64c5f1b065e6d=
aa
> > > > helps.
> > >=20
> > > I verified off-list with Luca that reverting that commit does make it
> > > work. Keshava, care to send a revert patch to Sam until we get all the
> > > hwmod stuff in.
> >=20
> > Yes, I confirm that I'm not getting the oops anymore, after reverting
> > this patch.
> >=20
> > Thanks a lot for the quick answer, dude! :)
>=20
> I'm again getting a very similar oops with 3.1-rc1 on my pandaboard:
>=20
> [    2.054351] usbcore: registered new interface driver cdc_ncm
> [    2.061431] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    2.068664] Unhandled fault: imprecise external abort (0x1406) at 0x00=
000000
> [    2.076110] Internal error: : 1406 [#1] SMP
> [    2.080505] Modules linked in:
> [    2.083709] CPU: 0    Not tainted  (3.1.0-rc1-wl+ #283)
> [    2.089233] PC is at omap_usbhs_enable+0x148/0x590
> [    2.094299] LR is at trace_hardirqs_off+0x14/0x18
> [    2.099243] pc : [<c02a8640>]    lr : [<c007fea0>]    psr: 60000093
> [    2.099243] sp : df871dc8  ip : df871d80  fp : df871dec
> [    2.111328] r10: 80000013  r9 : df9ef9e0  r8 : df9ef9ec
> [    2.116821] r7 : dfa32800  r6 : dfa316f8  r5 : c06f5da8  r4 : dfa316a0
> [    2.123687] r3 : 00000000  r2 : 00000000  r1 : 00000001  r0 : 00000000
> [    2.130584] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segm=
ent kernel
> [    2.138366] Control: 10c53c7d  Table: 8000404a  DAC: 00000015
> [    2.144409] Process swapper (pid: 1, stack limit =3D 0xdf8702f8)
> [    2.150543] Stack: (0xdf871dc8 to 0xdf872000)
> [    2.155120] 1dc0:                   df105400 dfa32808 df105400 dfa3280=
0 df9ef9ec 00000003
> [    2.163726] 1de0: df871e8c df871df0 c0321d60 c02a8504 df871e2c df10a58=
8 df1075a0 df10a588
> [    2.172363] 1e00: df871e2c df871e10 df10a588 00000000 df10a608 dfa28e8=
8 0000006d fc064c00
> [    2.180969] 1e20: df871e6c df871e30 c015654c c0155c08 c0082098 c0071f7=
4 00000001 dfa32898
> [    2.189575] 1e40: dfa28e88 00000000 dfa32808 dfa32810 00000000 0000000=
0 73757368 00003062
> [    2.198181] 1e60: df871e7c dfa32808 c0716da8 c0716da8 00000000 0000000=
0 00000000 00000000
> [    2.206787] 1e80: df871e9c df871e90 c0298cfc c0321bb8 df871ec4 df871ea=
0 c0297650 c0298ce4
> [    2.215423] 1ea0: df871ec4 dfa32808 dfa3283c dfa32808 dfa3283c c0716da=
8 df871ee4 df871ec8
> [    2.224029] 1ec0: c02977ec c0297504 00000000 c0716da8 c0297774 0000000=
0 df871f0c df871ee8
> [    2.232635] 1ee0: c0296c00 c0297780 df891658 dfa31670 c023ac60 c0716da=
8 df1075a0 c070d6f8
> [    2.241241] 1f00: df871f1c df871f10 c0297334 c0296bb0 df871f4c df871f2=
0 c02963ec c0297318
> [    2.249847] 1f20: c05b84a8 df871f30 c0716da8 c0c7e4c0 c0014ba0 0000000=
0 00000000 00000000
> [    2.258483] 1f40: df871f74 df871f50 c0297f00 c0296320 c0298d44 c0c7df1=
4 c0c7e4c0 c0014ba0
> [    2.267089] 1f60: 00000000 00000000 df871f84 df871f78 c02991e0 c0297e5=
4 df871fa4 df871f88
> [    2.275695] 1f80: c069904c c0299198 000000a0 00000060 c06c4e40 c0698fa=
4 df871fdc df871fa8
> [    2.284301] 1fa0: c0008854 c0698fb0 c0014ba0 c009960c df871fdc df871fc=
0 c06c4e40 c06c49dc
> [    2.292907] 1fc0: c0014ba0 00000013 00000000 00000000 df871ff4 df871fe=
0 c06792d4 c00087b8
> [    2.301513] 1fe0: 00000000 c067924c 00000000 df871ff8 c0014ba0 c067925=
8 882bf20f 3184000e
> [    2.310150] [<c02a8640>] (omap_usbhs_enable+0x148/0x590) from [<c0321d=
60>] (ehci_hcd_omap_probe+0x1b4/0x568)
> [    2.320526] [<c0321d60>] (ehci_hcd_omap_probe+0x1b4/0x568) from [<c029=
8cfc>] (platform_drv_probe+0x24/0x28)
> [    2.330780] [<c0298cfc>] (platform_drv_probe+0x24/0x28) from [<c029765=
0>] (driver_probe_device+0x158/0x27c)
> [    2.341033] [<c0297650>] (driver_probe_device+0x158/0x27c) from [<c029=
77ec>] (__driver_attach+0x78/0x9c)
> [    2.351043] [<c02977ec>] (__driver_attach+0x78/0x9c) from [<c0296c00>]=
 (bus_for_each_dev+0x5c/0x8c)
> [    2.360565] [<c0296c00>] (bus_for_each_dev+0x5c/0x8c) from [<c0297334>=
] (driver_attach+0x28/0x30)
> [    2.369903] [<c0297334>] (driver_attach+0x28/0x30) from [<c02963ec>] (=
bus_add_driver+0xd8/0x260)
> [    2.379180] [<c02963ec>] (bus_add_driver+0xd8/0x260) from [<c0297f00>]=
 (driver_register+0xb8/0x144)
> [    2.388702] [<c0297f00>] (driver_register+0xb8/0x144) from [<c02991e0>=
] (platform_driver_register+0x54/0x68)
> [    2.399047] [<c02991e0>] (platform_driver_register+0x54/0x68) from [<c=
069904c>] (ehci_hcd_init+0xa8/0xfc)
> [    2.409149] [<c069904c>] (ehci_hcd_init+0xa8/0xfc) from [<c0008854>] (=
do_one_initcall+0xa8/0x17c)
> [    2.418487] [<c0008854>] (do_one_initcall+0xa8/0x17c) from [<c06792d4>=
] (kernel_init+0x88/0x134)
> [    2.427764] [<c06792d4>] (kernel_init+0x88/0x134) from [<c0014ba0>] (k=
ernel_thread_exit+0x0/0x8)
> [    2.437011] Code: e59f0414 e1a01005 e59f2424 ebffac8d (e594303c)=20
>=20
> This seems to be very similar (if not identical) to the oops I was
> getting before (with 3.0-rc2).  I checked the git log and the revert
> that fixed my problem with 3.0-rc2 is now included in 3.1-rc1, so it
> seems that something else is broken now.
>=20
> I tried to revert the revert, with the idea that maybe the hwmod changes
> were also included in 3.1-rc1, but it didn't help and I'm still getting
> a similar oops.
>=20
> Any clues?
>=20
> --=20
> Cheers,
> Luca.
>=20

--=20
balbi

--jxJZfy9MYHgKPwT/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOQUiLAAoJEAv8Txj19kN1NcEH/iCaA5//IZzlcWa2QU1DDAAx
nJMxFtj1yJkz6+m0ZR/ZjCcP3/YW2cTf+SRFHT6ttbF+/PFmIejh7Z9iv304mgOK
s9fyDcSIKISscWqrTSEMFkX8P2slA1I0K2W4myuYbR+VUM27f5YzPqvd02i+xpJG
LbUzb87vQb50NlpKYoyFr1eBX8bNLUKVS9TOgtRTtJ+u33zhEUjmCQV1zvU6klku
T95T8C09whfsIhwZWEFU2/v4aJmlzdO2mkr99PgX4J9HTCkGGwQLcS4NRyffS+Ou
vbShJa6XzXTNPf9cJIoEbmzYmWpgCw9VRSfD6Qc+Ee7sCVOd6MBMejSuumaPdi8=
=xfcq
-----END PGP SIGNATURE-----

--jxJZfy9MYHgKPwT/--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
