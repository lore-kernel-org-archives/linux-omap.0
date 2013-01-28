From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP baseline test results for v3.8-rc5
Date: Mon, 28 Jan 2013 14:16:35 +0200
Message-ID: <20130128121635.GI28698@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1301260838300.19277@utopia.booyaka.com>
 <20130126084604.GB8754@arwen.pp.htv.fi>
 <C8443D0743D26F4388EA172BF4E2A7A93EA9456A@DBDE01.ent.ti.com>
 <20130128113818.GD28698@arwen.pp.htv.fi>
 <C8443D0743D26F4388EA172BF4E2A7A93EA946E4@DBDE01.ent.ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rmm1Stw9KgbdL9/H"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55103 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895Ab3A1MQ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Jan 2013 07:16:57 -0500
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93EA946E4@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

--Rmm1Stw9KgbdL9/H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 28, 2013 at 12:46:21PM +0100, Mohammed, Afzal wrote:
> Hi Felipe,
>=20
> On Mon, Jan 28, 2013 at 17:08:19, Balbi, Felipe wrote:
>=20
> > seems to be a bug with __unflatten_device_tree()...
>=20
> > U-Boot# bootm 0x80200000 - 0x80f80000
>=20
> Try loading dtb at a different address, I do,
>=20
> bootm 81000000 - 82000000

didn't help :-s

U-Boot# bootm 0x81000000 - 0x82000000
## Booting kernel from Legacy Image at 81000000 ...
   Image Name:   Linux-3.8.0-rc5-02311-g1308c2b-d
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    4265296 Bytes =3D 4.1 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 82000000
   Booting using the fdt blob at 0x82000000
   Loading Kernel Image ... OK
OK
   Loading Device Tree to 9fe3e000, end 9fe42f1e ... OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.8.0-rc5-02311-g1308c2b-dirty (balbi@arwen) (=
gcc version 4.6.3 (Sourcery CodeBench Lite 2012.03-57) ) #37 SMP Mon
 Jan 28 13:32:47 EET 2013
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=3D10c=
53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instr=
uction cache
[    0.000000] Machine: Generic AM33XX (Flattened Device Tree), model: TI A=
M335x BeagleBone
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] On node 0 totalpages: 65280
[    0.000000] free_area_init_node: node 0, pgdat c08331c0, node_mem_map c0=
d91000
[    0.000000]   Normal zone: 512 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 64768 pages, LIFO batch:15
[    0.000000] Unable to handle kernel paging request at virtual address df=
e3e000
[    0.000000] pgd =3D c0004000
[    0.000000] [dfe3e000] *pgd=3D00000000
[    0.000000] Internal error: Oops: 5 [#1] SMP ARM
[    0.000000] Modules linked in:
[    0.000000] CPU: 0    Not tainted  (3.8.0-rc5-02311-g1308c2b-dirty #37)
[    0.000000] PC is at __unflatten_device_tree+0x1c/0x12c
[    0.000000] LR is at unflatten_device_tree+0x1c/0x34
[    0.000000] pc : [<c0457d2c>]    lr : [<c077a370>]    psr: a0000193
[    0.000000] sp : c07a5f80  ip : 00000000  fp : 00000000
[    0.000000] r10: 00000000  r9 : 413fc082  r8 : 80004059
[    0.000000] r7 : c0755dd0  r6 : c0783ac0  r5 : dfe3e000  r4 : c0755dd0
[    0.000000] r3 : d00dfeed  r2 : c0755dd0  r1 : c0d8a8d4  r0 : dfe3e000
[    0.000000] Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segmen=
t kernel
[    0.000000] Control: 10c5387d  Table: 80004019  DAC: 00000017
[    0.000000] Process swapper (pid: 0, stack limit =3D 0xc07a4240)
[    0.000000] Stack: (0xc07a5f80 to 0xc07a6000)
[    0.000000] 5f80: c07b13d0 c00503b4 8fefffff c0d8a8d4 c0755dd0 c083607c =
c0783ac0 c07a5fe4
[    0.000000] 5fa0: 80004059 c077a370 c0781dd8 c0755028 00000000 c07a5fc4 =
c0783abc 00000001
[    0.000000] 5fc0: 00000000 c0783abc c07b11c4 c0751618 00000000 00000000 =
00000000 00000000
[    0.000000] 5fe0: 00000000 c0783ac0 00000000 10c53c7d c07ac98c 80008078 =
00000000 00000000
[    0.000000] [<c0457d2c>] (__unflatten_device_tree+0x1c/0x12c) from [<c07=
7a370>] (unflatten_device_tree+0x1c/0x34)
[    0.000000] [<c077a370>] (unflatten_device_tree+0x1c/0x34) from [<c07550=
28>] (setup_arch+0xf8/0x190)
[    0.000000] [<c0755028>] (setup_arch+0xf8/0x190) from [<c0751618>] (star=
t_kernel+0x80/0x2a8)
[    0.000000] [<c0751618>] (start_kernel+0x80/0x2a8) from [<80008078>] (0x=
80008078)
[    0.000000] Code: e1a07002 e58d100c 0a000033 e59f30f4 (e5951000)=20
[    0.000000] ---[ end trace 1b75b31a2719ed1c ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!

--=20
balbi

--Rmm1Stw9KgbdL9/H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRBmwjAAoJEIaOsuA1yqREqk4QAKvwkidCumHBgC45PSLXVOMU
zLO1KmFaDfzsu/AXrwHafuEV/p5I9u82YZhV7X8y/quA7LIDSefaITsc2+ERW6qx
hkZLKFOtNi72vRj4vt0RDFbB7usOiPfeyTp+nq9UY2nU93XCWjwskXC4Tv15gl5z
9EciSeplWYS59Hx6FDmq0cTm24QtjAege2stEZj9PV4x21+9RQb5UG2ZG5AqigNj
urzW3dzzgP3xxs/QYuHNKJnJkSiQB/+kISFSshSUisfpddHZ/PFBsuKaePHowLlx
l1fjFTstYIwePPlzS42UkMz0RTMwMkf2NSg9BfhZ7S0ebf2IxNSXjypJh7O1pCHJ
Hj9Xa5rlbm3LrCYRr/WATQBqAyQEjdp9I14rpJ4/F34TyHYkx4NywesKLUMYSEiF
jGTnDeNSP/d7vvyQRM4fYSnVkZE+DnjqcfWWcsSWkrXLucs627SdB30FliE4Fiy6
ucvjyFFCnne0A4aFQL4sr6euiF6o13f5//F49qCeEAElu7ObzmtYnN9N0trBqvsu
CjIZL7z27O3WO+lbR7psELgTu8ngdL5zTU7AiCuMpsA5tyu8LiTDiCStdDaSeuCl
tyYg6pG0eBK3YGwZ7xQZgN+fyPPjMmxp/6VNARuFBxZLe7gZ4obCZ3pUV8M/PfrW
3AdMInykOCOgSl03s6XH
=TTxa
-----END PGP SIGNATURE-----

--Rmm1Stw9KgbdL9/H--
