From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: am335x: hwmod WARN() when CONFIG_PM_RUNTIME=N
Date: Mon, 29 Sep 2014 12:09:11 -0300
Message-ID: <54297617.3010709@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="hVHdXEkGp3NrDbN1bi6KThDbDLnlmKEDF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:34099 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbaI2PKe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2014 11:10:34 -0400
Received: by mail-we0-f177.google.com with SMTP id t60so13244605wes.36
        for <linux-omap@vger.kernel.org>; Mon, 29 Sep 2014 08:10:33 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: =?UTF-8?B?R3VpZG8gTWFydMOtbmV6?= <guido@vanguardiasur.com.ar>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hVHdXEkGp3NrDbN1bi6KThDbDLnlmKEDF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Booting linux-next for 20140926 with CONFIG_PM_RUNTIME=3DN on a AM335X Be=
aglebone,
I'm getting these sort of warnings for several devices (timer, uart, gpmc=
).

config: http://sprunge.us/WGLM
dmesg, CONFIG_PM_RUNTIME=3Dy: http://sprunge.us/REhi
dmesg, CONFIG_PM_RUNTIME=3DN: http://sprunge.us/YHFZ

Any ideas?

Here's an example of the warning:

[    0.217795] WARNING: CPU: 0 PID: 1 at /home/zeta/fast/linux/next/arch/=
arm/mach-omap2/omap_hwmod.c:2166 _enable+0x270/0x2ac()
[    0.217805] omap_hwmod: mpu: enabled state can only be entered from in=
itialized, idle, or disabled state
[    0.217821] CPU: 0 PID: 1 Comm: swapper Tainted: G        W      3.17.=
0-rc6-next-20140926-00001-g41b7528 #512
[    0.217831] Backtrace:=20
[    0.217862] [<c0011b58>] (dump_backtrace) from [<c0011dc0>] (show_stac=
k+0x18/0x1c)
[    0.217871]  r6:c0024e64 r5:00000009 r4:df03fbf0 r3:00000000
[    0.217898] [<c0011da8>] (show_stack) from [<c03ce568>] (dump_stack+0x=
20/0x28)
[    0.217917] [<c03ce548>] (dump_stack) from [<c00340cc>] (warn_slowpath=
_common+0x6c/0x8c)
[    0.217930] [<c0034060>] (warn_slowpath_common) from [<c0034158>] (war=
n_slowpath_fmt+0x38/0x40)
[    0.217937]  r8:dfbd69d4 r7:00000001 r6:a0000113 r5:00000001 r4:c04fea=
44
[    0.217965] [<c0034124>] (warn_slowpath_fmt) from [<c0024e64>] (_enabl=
e+0x270/0x2ac)
[    0.217972]  r3:c047833c r2:c0478ecc
[    0.217990] [<c0024bf4>] (_enable) from [<c00256e8>] (omap_hwmod_enabl=
e+0x2c/0x4c)
[    0.217997]  r7:00000001 r6:a0000113 r5:c04feaa4 r4:c04fea44
[    0.218023] [<c00256bc>] (omap_hwmod_enable) from [<c0026a38>] (omap_d=
evice_enable+0x40/0x80)
[    0.218030]  r6:df0ae780 r5:df0ae740 r4:00000000 r3:df0ae700
[    0.218053] [<c00269f8>] (omap_device_enable) from [<c0026c5c>] (_omap=
_device_notifier_call+0x1e4/0x200)
[    0.218060]  r5:df0b4c10 r4:df0ae740
[    0.218088] [<c0026a78>] (_omap_device_notifier_call) from [<c004cc34>=
] (notifier_call_chain+0x4c/0x8c)
[    0.218095]  r10:00000000 r9:00000000 r8:00000001 r7:df0b4c10 r6:00000=
000 r5:00000000
[    0.218118]  r4:ffffffff
[    0.218133] [<c004cbe8>] (notifier_call_chain) from [<c004d098>] (__bl=
ocking_notifier_call_chain+0x50/0x68)
[    0.218140]  r8:00000000 r7:00000001 r6:df0b4c10 r5:ffffffff r4:df0039=
08 r3:ffffffff
[    0.218168] [<c004d048>] (__blocking_notifier_call_chain) from [<c004d=
0d0>] (blocking_notifier_call_chain+0x20/0x28)
[    0.218175]  r7:df0b4e10 r6:00000000 r5:df0b4c10 r4:df0b4c18
[    0.218204] [<c004d0b0>] (blocking_notifier_call_chain) from [<c023eb0=
4>] (device_add+0x3fc/0x50c)
[    0.218224] [<c023e708>] (device_add) from [<c0297f10>] (of_device_add=
+0x38/0x40)
[    0.218231]  r9:dfbd69d4 r8:df0b4c00 r7:00000001 r6:c04e709c r5:000000=
00 r4:df0b4e10
[    0.218259] [<c0297ed8>] (of_device_add) from [<c0298748>] (of_platfor=
m_device_create_pdata+0xe0/0x124)
[    0.218273] [<c0298668>] (of_platform_device_create_pdata) from [<c029=
8874>] (of_platform_bus_create+0xe8/0x194)
[    0.218280]  r10:00000000 r9:df0b4e10 r8:c04eb0e4 r7:00000001 r6:c04e7=
09c r5:dfbd69d4
[    0.218303]  r4:00000000
[    0.218317] [<c029878c>] (of_platform_bus_create) from [<c02988d0>] (o=
f_platform_bus_create+0x144/0x194)
[    0.218324]  r10:00000000 r9:df0b4e10 r8:c04eb0e4 r7:00000001 r6:c04e7=
09c r5:dfbd68f0
[    0.218347]  r4:dfbd69d4
[    0.218361] [<c029878c>] (of_platform_bus_create) from [<c0298a74>] (o=
f_platform_populate+0x64/0xa8)
[    0.218369]  r10:c0520bc0 r9:00000001 r8:00000000 r7:c04e709c r6:c04eb=
0e4 r5:dfbd5ae0
[    0.218391]  r4:dfbd68f0
[    0.218409] [<c0298a10>] (of_platform_populate) from [<c04caee8>] (pda=
ta_quirks_init+0x3c/0x4c)
[    0.218416]  r9:00000000 r8:c04c1aac r7:c04bf5e8 r6:df0aeb80 r5:c04eb0=
e4 r4:c04e7094
[    0.218444] [<c04caeac>] (pdata_quirks_init) from [<c04cae90>] (omap_g=
eneric_init+0x18/0x24)
[    0.218451]  r5:c04e59ec r4:c04e59ec
[    0.218472] [<c04cae78>] (omap_generic_init) from [<c04c1ad0>] (custom=
ize_machine+0x24/0x48)
[    0.218487] [<c04c1aac>] (customize_machine) from [<c04bfde4>] (do_one=
_initcall+0x108/0x1d0)
[    0.218500] [<c04bfcdc>] (do_one_initcall) from [<c04bffa8>] (kernel_i=
nit_freeable+0xfc/0x1c0)
[    0.218508]  r10:c0520bc0 r9:c04e6220 r8:00000066 r7:c04bf5e8 r6:c0520=
bc0 r5:c04e6208
[    0.218530]  r4:00000003
[    0.218553] [<c04bfeac>] (kernel_init_freeable) from [<c03caa64>] (ker=
nel_init+0x10/0xf4)
[    0.218561]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000=
000 r5:c03caa54
[    0.218583]  r4:00000000
[    0.218598] [<c03caa54>] (kernel_init) from [<c000e668>] (ret_from_for=
k+0x14/0x2c)
[    0.218605]  r4:00000000 r3:00000000
[    0.218618] ---[ end trace cb88537fdc8fa202 ]---


--=20
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar


--hVHdXEkGp3NrDbN1bi6KThDbDLnlmKEDF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUKXYXAAoJEIOKbhOEIHKiw5cP/2mf1Z3BkUBBOIjk2b+/lVIx
iUsKn+Prpwr09MqIx9ca0fg1BfvSF9lSd4sl0NjShZWeVDXTXShVw2gNhqGEiong
TLY1jLTWbVD4My/byfDqRhCEIgR3KU0mvR/30d4KoTrx3uh75GRPwrSL1uWUnCWa
9HZFOeABSKkfVNPdFCHL+LoLFaWotl4sAGAeFWwYQZHmh6FjL7nviLI3MeyHU67W
Ot2CDahPw479M/SZy0ZLezAeKrbjgli8crDPvEq+BIFcbS9YVg4n/OAeOlQlUc1W
hL6jhTFO8/ryJ61j9o5z78oIfrRH8txPDsDESVrHYy+BqMEuSQsqc5gkTyH4rNbr
ODHWegOXg+6jxQHGpBd2XwI4JLc8kXsaGR35G5YaiUmkSmdqSZM8842nl2B+2HqR
ly1sgzKv1s6eE4h6HHNWvSTPT+vLmBbSjbghCMgQzcBWnhvNk5/UfGMRLhJL0Dfu
iAiNiQrP7LY/FwWUXwPxTopmsJxBPzgs6FyZt8MiPG8er6diFs+c1wmXC/zsLzcG
EbzetBwj5rj/y8TPpxr0iu8HwSAgMt4weSwgJMl1aGabr2s+D8IZb27AkLeCME1R
y8t+xKwOcAdtiAn+0n6Xmkk4YNZK/8RpltP2NwwU1c0z2ZE62DzKzOPvbF9yh/6E
TWCtcqDwIKpz4yrW56P6
=4BRQ
-----END PGP SIGNATURE-----

--hVHdXEkGp3NrDbN1bi6KThDbDLnlmKEDF--
