From: Felipe Balbi <balbi@ti.com>
Subject: Re: Crash in omap2430_musb_init()
Date: Wed, 18 Apr 2012 15:31:09 +0300
Message-ID: <20120418123108.GO13842@arwen.pp.htv.fi>
References: <1334751449.2027.18.camel@deskari>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Tb77rFjxeKqknTuc"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:56474 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751917Ab2DRMcN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Apr 2012 08:32:13 -0400
Received: by lbgc1 with SMTP id c1so1578685lbg.17
        for <linux-omap@vger.kernel.org>; Wed, 18 Apr 2012 05:32:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1334751449.2027.18.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org


--Tb77rFjxeKqknTuc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 18, 2012 at 03:17:29PM +0300, Tomi Valkeinen wrote:
> Hi,
>=20
> I was updating my tree to latest rc from Linus, and noticed that there's
> a crash related to USB on omap4 blaze board. It happens on both Linus's
> master branch and v3.4-rc3.
>=20
> [    1.755615] musb-hdrc: version 6.0, ?dma?, otg (peripheral+host)
> [    1.762512] Unhandled fault: imprecise external abort (0x1406) at 0xfa=
f376f4
> [    1.770111] Internal error: : 1406 [#1] SMP ARM
> [    1.774841] Modules linked in:
> [    1.778045] CPU: 0    Not tainted  (3.4.0-rc3-00036-g592fe89 #213)
> [    1.784545] PC is at __dabt_invalid+0x0/0x10
> [    1.789001] LR is at omap2430_musb_init+0xac/0x104
> [    1.794036] pc : [<c047f6d0>]    lr : [<c03548a4>]    psr: 60000093
> [    1.794036] sp : dd831dc8  ip : fc0ab000  fp : ddb9b1dc
> [    1.806060] r10: ddb9a128  r9 : dd127ac0  r8 : fc0ab000
> [    1.811523] r7 : dd117c08  r6 : c06e3390  r5 : dd117c08  r4 : ddb9a128
> [    1.818359] r3 : 00000000  r2 : c03549e0  r1 : ddb9a394  r0 : c071ac0c
> [    1.825195] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segm=
ent kernel
> [    1.832946] Control: 10c53c7d  Table: 8000404a  DAC: 00000017
> [    1.838989] Process swapper/0 (pid: 1, stack limit =3D 0xdd8302f8)
> [    1.845275] Stack: (0xdd831dc8 to 0xdd832000)
> [    1.849822] 1dc0:                   0000007c dd117c00 00000010 c04742c=
0 dd116950 00000000
> [    1.858398] 1de0: c0c64d58 dd117c08 c0c64d58 c0c64d68 00000000 c070e40=
4 00000000 c063b184
> [    1.866973] 1e00: 00000000 c02aa1cc c02aa1b4 c02a8e1c c02aa454 dd117c0=
8 c02a9034 00000000
> [    1.875549] 1e20: 00000000 c0c64d14 c063b184 c02a7544 dd8402d8 dd11249=
4 dd117c08 dd117c3c
> [    1.884124] 1e40: c0701fc8 c02a8d40 dd117c08 dd117c08 c0701fc8 c02a832=
0 dd117c08 dd117c10
> [    1.892669] 1e60: dd96f408 c02a6ba8 c06eaf40 00000000 dd112378 dd96f40=
8 dd112340 c0683bd8
> [    1.901245] 1e80: 00000000 dd117c00 dd117c08 00000003 dd96f408 dd11234=
0 c0683bd8 c063b184
> [    1.909820] 1ea0: 00000000 c02aa7e4 dd117c00 00000000 dd127b00 dd96f40=
8 dd970c00 c0474c44
> [    1.918395] 1ec0: dd96f408 c0c64d58 c0c64d68 00000000 c070e4c4 c02aa1c=
c c02aa1b4 c02a8e1c
> [    1.926971] 1ee0: 22222222 dd96f408 c070e4c4 dd96f43c 00000000 0000009=
d c063b184 c02a9030
> [    1.935516] 1f00: c070e4c4 c02a8f9c 00000000 c02a75c0 dd8402a8 dd96869=
0 c070e4c4 c0701fc8
> [    1.944091] 1f20: dd1123c0 c02a84d0 c058dbcc 00000000 dd8489c0 c070e4c=
4 c071aa00 dd830000
> [    1.952667] 1f40: 00000000 0000009d c0683bd8 c063b184 00000000 c02a956=
4 00000000 c066c10c
> [    1.961242] 1f60: c071aa00 dd830000 00000000 0000009d c063b184 c000871=
8 0000009c c06143d0
> [    1.969818] 1f80: c10731d5 c0661100 00000001 00000000 00000000 c058210=
c 00000006 00000006
> [    1.978363] 1fa0: 60000013 c066c10c 00000006 c066c0ec c071aa00 0000009=
d c0683bd8 c063b184
> [    1.986938] 1fc0: 00000000 c063b8f4 00000006 00000006 c063b184 0000000=
0 00000000 c063b804
> [    1.995513] 1fe0: c0014de4 00000013 00000000 00000000 00000000 c0014de=
4 40000080 effbdffb
> [    2.004089] [<c047f6d0>] (__dabt_invalid+0x0/0x10) from [<c03548a4>] (=
omap2430_musb_init+0xac/0x104)
> [    2.013671] [<c03548a4>] (omap2430_musb_init+0xac/0x104) from [<c04742=
c0>] (musb_probe+0x1bc/0x568)
> [    2.023162] [<c04742c0>] (musb_probe+0x1bc/0x568) from [<c02aa1cc>] (p=
latform_drv_probe+0x18/0x1c)
> [    2.032562] [<c02aa1cc>] (platform_drv_probe+0x18/0x1c) from [<c02a8e1=
c>] (driver_probe_device+0x9c/0x21c)
>=20
>=20
> Attached is the full log and my config. Also, this doesn't happen every
> time. Sometimes I see this, after which the boot continues:
>=20
> [    1.778167] musb-hdrc: version 6.0, ?dma?, otg (peripheral+host)
> [    1.785064] ------------[ cut here ]------------
> [    1.785278] musb-hdrc musb-hdrc: musb_init_controller failed with stat=
us -22
> [    1.785339] musb-hdrc: probe of musb-hdrc failed with error -22
> [    1.803680] WARNING: at arch/arm/mach-omap2/omap_l3_noc.c:113 l3_inter=
rupt_handler+0x184/0x1c4()
> [    1.812866] L3 custom error: MASTER:MPU TARGET:L4CFG
> [    1.818084] Modules linked in:
> [    1.821319] [<c001b4ec>] (unwind_backtrace+0x0/0xf0) from [<c003f6f0>]=
 (warn_slowpath_common+0x4c
> /0x64)
> [    1.831176] [<c003f6f0>] (warn_slowpath_common+0x4c/0x64) from [<c003f=
79c>] (warn_slowpath_fmt+0x
> 30/0x40)
> [    1.841217] [<c003f79c>] (warn_slowpath_fmt+0x30/0x40) from [<c0033c08=
>] (l3_interrupt_handler+0x
> 184/0x1c4)
> [    1.851440] [<c0033c08>] (l3_interrupt_handler+0x184/0x1c4) from [<c00=
9cf44>] (handle_irq_event_p
> ercpu+0x5c/0x248)
> [    1.862274] [<c009cf44>] (handle_irq_event_percpu+0x5c/0x248) from [<c=
009d16c>] (handle_irq_event
> +0x3c/0x5c)
> [    1.872589] [<c009d16c>] (handle_irq_event+0x3c/0x5c) from [<c009fb90>=
] (handle_fasteoi_irq+0xbc/
> 0x194)
> [    1.882446] [<c009fb90>] (handle_fasteoi_irq+0xbc/0x194) from [<c009c7=
58>] (generic_handle_irq+0x
> 30/0x48)
> [    1.892517] [<c009c758>] (generic_handle_irq+0x30/0x48) from [<c0014b7=
8>] (handle_IRQ+0x4c/0xac)
> [    1.901733] [<c0014b78>] (handle_IRQ+0x4c/0xac) from [<c000848c>] (gic=
_handle_irq+0x28/0x5c)
> [    1.910583] [<c000848c>] (gic_handle_irq+0x28/0x5c) from [<c047f924>] =
(__irq_svc+0x44/0x60)
> [    1.919342] Exception stack(0xc0689f58 to 0xc0689fa0)
> [    1.924621] 9f40:                                                     =
  000050a2 00000001
> [    1.933197] 9f60: 00000000 c06aa590 c0688000 c071aac8 c048a2ec c06abd2=
8 00000000 411fc092
> [    1.941772] 9f80: c06abf50 00000000 00000001 c0689fa0 000050a3 c0014e5=
c 20000013 ffffffff
> [    1.950347] [<c047f924>] (__irq_svc+0x44/0x60) from [<c0014e5c>] (defa=
ult_idle+0x38/0x44)
> [    1.958923] [<c0014e5c>] (default_idle+0x38/0x44) from [<c0015088>] (c=
pu_idle+0x9c/0x114)
> [    1.967529] [<c0015088>] (cpu_idle+0x9c/0x114) from [<c063b7b0>] (star=
t_kernel+0x2bc/0x310)
> [    1.976287] [<c063b7b0>] (start_kernel+0x2bc/0x310) from [<80008044>] =
(0x80008044)
> [    1.984283] ---[ end trace 16eab3b745e70cec ]---

please merge my fixes branch from my k.org tree
git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git and see if
you still have the same problem.

There are a few fixes to musb which might solve this problem.

--=20
balbi

--Tb77rFjxeKqknTuc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPjrQMAAoJEIaOsuA1yqREFYoP/R3x8YxJkluv6p9yTSy895Iz
0natbZQc6y99nVgZh2+CFqS9Yq6AM4FbFo9es691nQJAtVY3Anq9QYmvTRsSmmcp
po6DxhtjlC21++EH/1QxlwQwB5yEh6oi15r6CCBbZC5JFJPjBOaXbCXxVkp/fc0k
LkxSFn6ZVvtaY7oQwOoHLs3EM2wxPw8HLcjOsEfyU8ZMHVKlrbowN+OMj+QFYm4j
F0BcKsqJn5ZcDRlqB2zO9RSTHKd9pIPd3zYScsWoYgDBFVvqcfCVeHGkX2PPK+c+
R3cl1QdjKfF/eRxMkPAYRQ94pZXtiL7Zn5/SFiRnLB/haKfu+7CkRwHwcpCAtXTP
2ZeyxH3rYx7HphYS/yLUtqKPWdikWfxGpaxKVO+4pC1dpMzSRnCySk/9Ont7ZW5j
jov35rliMNf2fatyUxjIo6RcLfW5Xe8Vo6O4iKSFU3Yssb4qg6JzrUkx31pMzA0N
RS0QWBbHGuqLfZFibr5eksdN/3YuScca/jUr7Qv0pF1B/d7ZRe+WlYtMlYWVXLPx
3m98NvTCyez9Z6E2N/o4/EdokRubdmNspmzc89RDetH85R7ldqA0cSurG7W1ExKj
UqJwgGDwuUwOjc5dcfVyO4HWyFTa0YKRIkpTkCmAyU0LgtfTGDc8RXkf1JWJ2mLs
mNu/3mQKjTlY4j2LvyvA
=FW6r
-----END PGP SIGNATURE-----

--Tb77rFjxeKqknTuc--
