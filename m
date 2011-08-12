From: Felipe Balbi <balbi@ti.com>
Subject: Re: musb crash on suspend
Date: Fri, 12 Aug 2011 12:51:16 +0300
Message-ID: <20110812095115.GS19467@legolas.emea.dhcp.ti.com>
References: <CAOd_LFxPcid8rL8v_n6Q0E9u0iV9aKLmbYiVLFXQYoJfkUhB5Q@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tqSMaTz1cCSspCQ4"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:37188 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752029Ab1HLJvU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Aug 2011 05:51:20 -0400
Received: by bke11 with SMTP id 11so1993226bke.5
        for <linux-omap@vger.kernel.org>; Fri, 12 Aug 2011 02:51:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOd_LFxPcid8rL8v_n6Q0E9u0iV9aKLmbYiVLFXQYoJfkUhB5Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cliff Brake <cliff.brake@gmail.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>


--tqSMaTz1cCSspCQ4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 28, 2011 at 05:05:13PM -0400, Cliff Brake wrote:
> Hello, I'm running 2.6.39 on omap3530 with a number of patches and am
> seeing the below crash on suspend.  Questions:
>=20
> 1) does anyone have musb suspending with 2.6.39?
> 2) are there any fixes or suggestions?
>=20
> Thanks,
> Cliff
>=20
> musb-hdrc musb-hdrc: suspend
> Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa0ab00c
> Internal error: : 1028 [#1] PREEMPT
> last sysfs file: /sys/power/state
> Modules linked in: mac80211 cfg80211
> CPU: 0    Tainted: G        W    (2.6.39+ #182)
> PC is at musb_save_context+0x14/0x150
> LR is at musb_suspend+0x2c/0x60
> pc : [<c02b18c8>]    lr : [<c02b1bd8>]    psr: 20000093
> sp : cc26de48  ip : fb020000  fp : c05c34d8
> r10: c06124d4  r9 : 00000000  r8 : 00000002
> r7 : 00000000  r6 : 00000000  r5 : cc8d3e08  r4 : a0000013
> r3 : 00000003  r2 : 00000001  r1 : fa0ab000  r0 : cc9380ec
> Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 10c5387d  Table: 8c014019  DAC: 00000015
> Process sh (pid: 1884, stack limit =3D 0xcc26c2e8)
> Stack: (0xcc26de48 to 0xcc26e000)
> de40:                   a0000013 cc8d3e08 00000000 00000000 00000002 0000=
0000
> de60: c06124d4 c02b1bd8 cc842640 c023d948 cc842640 c0240a94 cc8d3e08 cc84=
2640
> de80: 00000000 00000000 cc8d3e08 00000002 00000000 cc8d3e3c c06124d4 c024=
14cc
> dea0: cc8d3e08 00000002 cc8d3e08 00000000 cc8d3e68 00000002 c05e00d4 c024=
1918
> dec0: 0bead162 00000007 0bead162 00000007 00000000 00000000 00000003 0000=
0003
> dee0: 00000004 c0413714 00000004 c0506ab1 000a3008 c0090ad4 c0506ab1 0000=
0003
> df00: 00000000 c0090d50 cc10f000 00000003 00000003 c0090364 cc812908 ccb3=
f818
> df20: cc26df80 c042e650 ccb3f800 00000004 cc820b00 c01e00ec cc812908 c011=
8350
> df40: 00000004 cc33db40 4006c000 cc26df80 00000004 cc26c000 00000000 c00c=
4a2c
> df60: cc33db40 4006c000 cc33db40 4006c000 00000000 00000000 00000004 c00c=
4b60
> df80: 00000000 00000000 00000004 00000000 00000004 4006c000 403525d0 0000=
0004
> dfa0: c003cf68 c003cdc0 00000004 4006c000 00000001 4006c000 00000004 0000=
0000
> dfc0: 00000004 4006c000 403525d0 00000004 00000004 000a33f0 00000001 000a=
3008
> dfe0: 00000000 beff85c0 40290028 402e332c 60000010 00000001 80000801 1000=
0500
> [<c02b18c8>] (musb_save_context+0x14/0x150) from [<c02b1bd8>]
> (musb_suspend+0x2c/0x60)
> [<c02b1bd8>] (musb_suspend+0x2c/0x60) from [<c023d948>]
> (platform_pm_suspend+0x2c/0x54)
> [<c023d948>] (platform_pm_suspend+0x2c/0x54) from [<c0240a94>] (pm_op+0x4=
c/0xb4)
> [<c0240a94>] (pm_op+0x4c/0xb4) from [<c02414cc>] (__device_suspend+0x134/=
0x1f0)
> [<c02414cc>] (__device_suspend+0x134/0x1f0) from [<c0241918>]
> (dpm_suspend_start+0x34c/0x458)
> [<c0241918>] (dpm_suspend_start+0x34c/0x458) from [<c0090ad4>]
> (suspend_devices_and_enter+0x3c/0x1f8)
> [<c0090ad4>] (suspend_devices_and_enter+0x3c/0x1f8) from [<c0090d50>]
> (enter_state+0xc0/0x128)
> [<c0090d50>] (enter_state+0xc0/0x128) from [<c0090364>] (state_store+0xa0=
/0xb4)
> [<c0090364>] (state_store+0xa0/0xb4) from [<c01e00ec>]
> (kobj_attr_store+0x18/0x1c)
> [<c01e00ec>] (kobj_attr_store+0x18/0x1c) from [<c0118350>]
> (sysfs_write_file+0x108/0x13c)
> [<c0118350>] (sysfs_write_file+0x108/0x13c) from [<c00c4a2c>]
> (vfs_write+0xac/0x134)
> [<c00c4a2c>] (vfs_write+0xac/0x134) from [<c00c4b60>] (sys_write+0x3c/0x6=
8)
> [<c00c4b60>] (sys_write+0x3c/0x68) from [<c003cdc0>] (ret_fast_syscall+0x=
0/0x30)
> Code: e92d47f0 e3530002 e5901208 0a000005 (e1d130bc)
> ------------[ cut here ]------------
> WARNING: at arch/arm/mach-omap2/omap_l3_smx.c:162 omap3_l3_app_irq+0xf8/0=
x150()
> In-band Error Error seen by MPU  at address 0

quite interesting that you got In-band Error...
oh well, you say it's already fixed, but if you see again errors from
omap3_l3, let us know again ;-)

--=20
balbi

--tqSMaTz1cCSspCQ4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJORPeTAAoJEAv8Txj19kN1SogH/0IxLDYRIzNgF0lAc0wHOqq8
7bzY8gJRSJRGJplBDO8QmrvkKSQmdtle00jzT4W8/X/ujtUzra8qGhByJb0gsRIY
A/+ut1vBNZP6XqaB8zKduwE0NWoDFusr17Ju67P+Mh5uJs+Q2T4+SlfCCorFxZ/3
iJq+tIuxVPQx5duX9Us0pMbTKMK41NvjkiMfuSZ1zUrHuWB6a8kAyylmU8Q7vsR0
HeOKnD/UPMonIqeNKqAZ1si63xStJvHVtn30AsjU2zXfrt6caNQjqrRYu6pzGQWx
n2HDQzPVcq4QCCd2lT02AozTCDFZvV3IV9u6Rp1jMMDlYArUNQu3mm78juTCcbE=
=Ou5n
-----END PGP SIGNATURE-----

--tqSMaTz1cCSspCQ4--
