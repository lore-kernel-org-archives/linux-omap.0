From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH] usb: musb: Prevent musb_am335x from being removed
Date: Mon, 30 Jun 2014 13:44:26 -0500
Message-ID: <20140630184426.GU31442@saruman.home>
References: <1399570060-28939-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ceuyUbi+oA5bUa/n"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43134 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753840AbaF3Sou (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jun 2014 14:44:50 -0400
Content-Disposition: inline
In-Reply-To: <1399570060-28939-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Guido =?iso-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, george.cherian@ti.com, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, yegorslists@googlemail.com

--ceuyUbi+oA5bUa/n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 08, 2014 at 02:27:40PM -0300, Ezequiel Garcia wrote:
> At probe time, the musb_am335x driver registers its childs by
> calling of_platform_populate(), which registers all childs in
> the devicetree hierarchy recursively.
>=20
> On the other side, the driver's remove() function uses of_device_unregist=
er()
> to remove each child in the musb_am335x driver device struct.
>=20
> However, when musb_dsps is loaded, its devices are attached to the musb_a=
m335x
> driver device struct as musb_am335x childs. Hence, musb_am335x remove()
> will attempt to unregister the devices registered by musb_dsps, which pro=
duces
> a kernel panic.
>=20
> In other words, the childs in the "struct device" hierarchy are not the s=
ame
> as the childs in the "devicetree" hierarchy.
>=20
> Ideally, we should be enforcing the removal of the devices registered by
> musb_am335x *only*, instead of all the child devices. However, because of=
 the
> recursive nature of of_platform_populate, this doesn't seem possible.
>=20
> Therefore, as the only solution at hand, this commit disables musb_am335x=
 driver
> removal capability, preventing it from being ever removed.
>=20
> Just for reference, here's the panic upon module removal:
>=20
> musb-hdrc musb-hdrc.0.auto: remove, state 4
> usb usb1: USB disconnect, device number 1
> musb-hdrc musb-hdrc.0.auto: USB bus 1 deregistered
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
08c
> pgd =3D de11c000
> [0000008c] *pgd=3D9e174831, *pte=3D00000000, *ppte=3D00000000
> Internal error: Oops: 17 [#1] ARM
> Modules linked in: musb_am335x(-) musb_dsps musb_hdrc usbcore usb_common
> CPU: 0 PID: 623 Comm: modprobe Not tainted 3.15.0-rc4-00001-g24efd13 #69
> task: de1b7500 ti: de122000 task.ti: de122000
> PC is at am335x_shutdown+0x10/0x28
> LR is at am335x_shutdown+0xc/0x28
> pc : [<c0327798>]    lr : [<c0327794>]    psr: a0000013
> sp : de123df8  ip : 00000004  fp : 00028f00
> r10: 00000000  r9 : de122000  r8 : c000e6c4
> r7 : de0e3c10  r6 : de0e3800  r5 : de624010  r4 : de1ec750
> r3 : de0e3810  r2 : 00000000  r1 : 00000001  r0 : 00000000
> Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 10c5387d  Table: 9e11c019  DAC: 00000015
> Process modprobe (pid: 623, stack limit =3D 0xde122240)
> Stack: (0xde123df8 to 0xde124000)
> 3de0:                                                       de0e3810 bf05=
4488
> 3e00: bf05444c de624010 60000013 bf043650 000012fc de624010 de0e3810 bf04=
3a20
> 3e20: de0e3810 bf04b240 c0635b88 c02ca37c c02ca364 c02c8db0 de1b7500 de0e=
3844
> 3e40: de0e3810 c02c8e28 c0635b88 de02824c de0e3810 c02c884c de0e3800 de0e=
3810
> 3e60: de0e3818 c02c5b20 bf05417c de0e3800 de0e3800 c0635b88 de0f2410 c02c=
a838
> 3e80: bf05417c de0e3800 bf055438 c02ca8cc de0e3c10 bf054194 de0e3c10 c02c=
a37c
> 3ea0: c02ca364 c02c8db0 de1b7500 de0e3c44 de0e3c10 c02c8e28 c0635b88 de02=
824c
> 3ec0: de0e3c10 c02c884c de0e3c10 de0e3c10 de0e3c18 c02c5b20 de0e3c10 de0e=
3c10
> 3ee0: 00000000 bf059000 a0000013 c02c5bc0 00000000 bf05900c de0e3c10 c02c=
5c48
> 3f00: de0dd0c0 de1ec970 de0f2410 bf05929c de0f2444 bf05902c de0f2410 c02c=
a37c
> 3f20: c02ca364 c02c8db0 bf05929c de0f2410 bf05929c c02c94c8 bf05929c 0000=
0000
> 3f40: 00000800 c02c8ab4 bf0592e0 c007fc40 c00dd820 6273756d 336d615f 0078=
3533
> 3f60: c064a0ac de1b7500 de122000 de1b7500 c000e590 00000001 c000e6c4 c006=
0160
> 3f80: 00028e70 00028e70 00028ea4 00000081 60000010 00028e70 00028e70 0002=
8ea4
> 3fa0: 00000081 c000e500 00028e70 00028e70 00028ea4 00000800 becb59f8 0002=
7608
> 3fc0: 00028e70 00028e70 00028ea4 00000081 00000001 00000001 00000000 0002=
8f00
> 3fe0: b6e6b6f0 becb59d4 000160e8 b6e6b6fc 60000010 00028ea4 00000000 0000=
0000
> [<c0327798>] (am335x_shutdown) from [<bf054488>] (dsps_musb_exit+0x3c/0x4=
c [musb_dsps])
> [<bf054488>] (dsps_musb_exit [musb_dsps]) from [<bf043650>] (musb_shutdow=
n+0x80/0x90 [musb_hdrc])
> [<bf043650>] (musb_shutdown [musb_hdrc]) from [<bf043a20>] (musb_remove+0=
x24/0x68 [musb_hdrc])
> [<bf043a20>] (musb_remove [musb_hdrc]) from [<c02ca37c>] (platform_drv_re=
move+0x18/0x1c)
> [<c02ca37c>] (platform_drv_remove) from [<c02c8db0>] (__device_release_dr=
iver+0x70/0xc8)
> [<c02c8db0>] (__device_release_driver) from [<c02c8e28>] (device_release_=
driver+0x20/0x2c)
> [<c02c8e28>] (device_release_driver) from [<c02c884c>] (bus_remove_device=
+0xdc/0x10c)
> [<c02c884c>] (bus_remove_device) from [<c02c5b20>] (device_del+0x104/0x19=
8)
> [<c02c5b20>] (device_del) from [<c02ca838>] (platform_device_del+0x14/0x9=
c)
> [<c02ca838>] (platform_device_del) from [<c02ca8cc>] (platform_device_unr=
egister+0xc/0x20)
> [<c02ca8cc>] (platform_device_unregister) from [<bf054194>] (dsps_remove+=
0x18/0x38 [musb_dsps])
> [<bf054194>] (dsps_remove [musb_dsps]) from [<c02ca37c>] (platform_drv_re=
move+0x18/0x1c)
> [<c02ca37c>] (platform_drv_remove) from [<c02c8db0>] (__device_release_dr=
iver+0x70/0xc8)
> [<c02c8db0>] (__device_release_driver) from [<c02c8e28>] (device_release_=
driver+0x20/0x2c)
> [<c02c8e28>] (device_release_driver) from [<c02c884c>] (bus_remove_device=
+0xdc/0x10c)
> [<c02c884c>] (bus_remove_device) from [<c02c5b20>] (device_del+0x104/0x19=
8)
> [<c02c5b20>] (device_del) from [<c02c5bc0>] (device_unregister+0xc/0x20)
> [<c02c5bc0>] (device_unregister) from [<bf05900c>] (of_remove_populated_c=
hild+0xc/0x14 [musb_am335x])
> [<bf05900c>] (of_remove_populated_child [musb_am335x]) from [<c02c5c48>] =
(device_for_each_child+0x44/0x70)
> [<c02c5c48>] (device_for_each_child) from [<bf05902c>] (am335x_child_remo=
ve+0x18/0x30 [musb_am335x])
> [<bf05902c>] (am335x_child_remove [musb_am335x]) from [<c02ca37c>] (platf=
orm_drv_remove+0x18/0x1c)
> [<c02ca37c>] (platform_drv_remove) from [<c02c8db0>] (__device_release_dr=
iver+0x70/0xc8)
> [<c02c8db0>] (__device_release_driver) from [<c02c94c8>] (driver_detach+0=
xb4/0xb8)
> [<c02c94c8>] (driver_detach) from [<c02c8ab4>] (bus_remove_driver+0x4c/0x=
a0)
> [<c02c8ab4>] (bus_remove_driver) from [<c007fc40>] (SyS_delete_module+0x1=
28/0x1cc)
> [<c007fc40>] (SyS_delete_module) from [<c000e500>] (ret_fast_syscall+0x0/=
0x48)
>=20
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

can you send without RFC so it can be applied ?

thank you

--=20
balbi

--ceuyUbi+oA5bUa/n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTsbAKAAoJEIaOsuA1yqREKbsP/jSamZmIepKkfRjGJxuD/jlR
EHl7DLyxhwYILlX6Cr4k2gstyhbda/s9HPegjv8PP7HtVj+Ey2xpk4WV5bu9pmaz
S4vEFixgsX8Wo4VBYGGMzwWEQ5WBUl0Z65PIP/sRUmLBsgppNicyxBZRQZtsqE2o
Qxutqnz/KYKR8VdOzFmKf8wv86ImEGhxyNEfNIGV/iT5RBJnqoL+wz8j4A1U2rJp
917WInp6UyuxQpPBPnkxPSSRKZYyV6iEeCprW8cUUQsefwLxza4d1wSGJavSPvr0
05TroAm77zCYszFFzZaLsQTT+4Xd/gZR2pXFpmGdnAOXc2pb8C2djj46qn5R54qm
B/I+q6GDcPI1D8Ih5KtqYsHSfZaBjaP6jukejydegqPU5eEkSi7s4yPD+SfdVHcR
nACi1oURBJ9ahy5IbSY1j/N3cZFIjmaWUteATfT6ow2nSWViUkXBs4LJe+sg7rgb
YBJJ2RY6x/GG9DxQqhbgwAOJ96vrnAmOob5giYQDYr40pbUhnQAQAKBkUc/XVJNl
h3zzEz7ljX+NSRM5gWOJUCp3qZkoMbCfSwRtEgzjEWe40xGtWq5ErzLgOMZmRh+U
DiyqoZv4d27TAnrAlZxgYHvaVoBzyd4fQcKUvcDBh5oHxNdho0JSkBC/Qs6GrAWu
7K5sL7gW7T1UCYa0Gerz
=k6e6
-----END PGP SIGNATURE-----

--ceuyUbi+oA5bUa/n--
