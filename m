From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: pandaboard boot crash with linux-next
Date: Mon, 17 Mar 2014 16:09:28 +0200
Message-ID: <53270218.9050109@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="jqbJbbT5xk5T8RRTK8Ptwmt5FnOmDMv7C"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50922 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932954AbaCQOJc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Mar 2014 10:09:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, "Kristo, Tero" <t-kristo@ti.com>

--jqbJbbT5xk5T8RRTK8Ptwmt5FnOmDMv7C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I noticed that my omap4 panda does not boot with today's linux-next
(8808b950581f71e3ee4cf8e6cae479f4c7106405). I didn't have much time to st=
udy
it, but I didn't find any posts about the issue with a quick look. Below =
is
the crash.

 Tomi

[    0.000000] ti_dt_clocks_register: failed to lookup clock node div_ts_=
ck
[    0.000000] ti_dt_clocks_register: failed to lookup clock node bandgap=
_ts_fclk
[    0.000000] Unable to handle kernel NULL pointer dereference at virtua=
l address 0000004c
[    0.000000] pgd =3D c0004000
[    0.000000] [0000004c] *pgd=3D00000000
[    0.000000] Internal error: Oops: 5 [#1] SMP ARM
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.14.0-rc6-next-=
20140317-09382-g8808b950581f #104
[    0.000000] task: c088ddf8 ti: c0882000 task.ti: c0882000
[    0.000000] PC is at kernfs_find_ns+0x14/0x13c
[    0.000000] LR is at kernfs_find_and_get_ns+0x38/0x54
[    0.000000] pc : [<c019607c>]    lr : [<c019628c>]    psr: 600001d3
[    0.000000] sp : c0883e00  ip : c0883e30  fp : c0883e2c
[    0.000000] r10: c0891114  r9 : ebfa11c0  r8 : ebfcd464
[    0.000000] r7 : 00000000  r6 : 00000000  r5 : c07c1814  r4 : c08e9ad8=

[    0.000000] r3 : c08f568c  r2 : 00000000  r1 : c07c1814  r0 : 00000000=

[    0.000000] Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Seg=
ment kernel
[    0.000000] Control: 10c5387d  Table: 8000404a  DAC: 00000015
[    0.000000] Process swapper/0 (pid: 0, stack limit =3D 0xc0882248)
[    0.000000] Stack: (0xc0883e00 to 0xc0884000)
[    0.000000] 3e00: 00000000 c08e9ad8 c07c1814 c08e9ad8 c07c1814 0000000=
0 00000000 ebfcd464
[    0.000000] 3e20: c0883e4c c0883e30 c019628c c0196074 c07c1814 0000000=
0 c07c1814 ebfcd490
[    0.000000] 3e40: c0883e6c c0883e50 c04c6180 c0196260 c0891140 c07c181=
4 ebfcd490 00000001
[    0.000000] 3e60: c0883e9c c0883e70 c04c7308 c04c6160 c008a208 c008a13=
0 c0883e9c 00000000
[    0.000000] 3e80: c07c1814 c0891140 ebfcd464 a00001d3 c0883ec4 c0883ea=
0 c04c7c9c c04c72cc
[    0.000000] 3ea0: c0882000 ebfcd464 c074dcc8 c086bf64 00000001 c074de2=
4 c0883ee4 c0883ec8
[    0.000000] 3ec0: c0824b70 c04c7c14 c0891114 c0938af8 00000000 c074dcc=
8 c0883f54 c0883ee8
[    0.000000] 3ee0: c0824c58 c0824b18 00000000 c0e8bf6c c0882000 fffffff=
f c0883f14 c0883f08
[    0.000000] 3f00: c05bc6b4 c05bc44c c0883f34 c0883f18 c04cca04 c05bc6b=
0 00000000 00000000
[    0.000000] 3f20: eb016b80 c0882000 c0883f4c c0883f38 c0938af8 c08910c=
0 c074dcc8 c074de24
[    0.000000] 3f40: c086ad60 c088a880 c0883f7c c0883f58 c0824f5c c0824c2=
0 00000001 c0883f68
[    0.000000] 3f60: 00000001 c09380c0 c0882000 ffffffff c0883f8c c0883f8=
0 c0825250 c0824f1c
[    0.000000] 3f80: c0883f9c c0883f90 c0825400 c0825238 c0883fac c0883fa=
0 c081d67c c08253fc
[    0.000000] 3fa0: c0883ff4 c0883fb0 c0819a30 c081d664 ffffffff fffffff=
f c08195d0 00000000
[    0.000000] 3fc0: 00000000 c086ad60 00000000 10c5387d c088a92c c086ad5=
c c088f684 8000406a
[    0.000000] 3fe0: 412fc09a 00000000 00000000 c0883ff8 80008074 c081984=
0 00000000 00000000
[    0.000000] Backtrace:=20
[    0.000000] [<c0196068>] (kernfs_find_ns) from [<c019628c>] (kernfs_fi=
nd_and_get_ns+0x38/0x54)
[    0.000000]  r8:ebfcd464 r7:00000000 r6:00000000 r5:c07c1814 r4:c08e9a=
d8
[    0.000000] [<c0196254>] (kernfs_find_and_get_ns) from [<c04c6180>] (s=
afe_name+0x2c/0x98)
[    0.000000]  r7:ebfcd490 r6:c07c1814 r5:00000000 r4:c07c1814
[    0.000000] [<c04c6154>] (safe_name) from [<c04c7308>] (__of_add_prope=
rty_sysfs+0x48/0xc4)
[    0.000000]  r7:00000001 r6:ebfcd490 r5:c07c1814 r4:c0891140
[    0.000000] [<c04c72c0>] (__of_add_property_sysfs) from [<c04c7c9c>] (=
of_add_property+0x94/0xa0)
[    0.000000]  r8:a00001d3 r7:ebfcd464 r6:c0891140 r5:c07c1814 r4:000000=
00
[    0.000000] [<c04c7c08>] (of_add_property) from [<c0824b70>] (omap_get=
_timer_dt+0x64/0x108)
[    0.000000]  r8:c074de24 r7:00000001 r6:c086bf64 r5:c074dcc8 r4:ebfcd4=
64 r3:c0882000
[    0.000000] [<c0824b0c>] (omap_get_timer_dt) from [<c0824c58>] (omap_d=
m_timer_init_one+0x44/0x2fc)
[    0.000000]  r6:c074dcc8 r5:00000000 r4:c0938af8 r3:c0891114
[    0.000000] [<c0824c14>] (omap_dm_timer_init_one) from [<c0824f5c>] (o=
map2_gp_clockevent_init+0x4c/0xd0)
[    0.000000]  r10:c088a880 r8:c086ad60 r7:c074de24 r6:c074dcc8 r5:c0891=
0c0 r4:c0938af8
[    0.000000] [<c0824f10>] (omap2_gp_clockevent_init) from [<c0825250>] =
(omap4_sync32k_timer_init+0x24/0x60)
[    0.000000]  r7:ffffffff r6:c0882000 r5:c09380c0 r4:00000001
[    0.000000] [<c082522c>] (omap4_sync32k_timer_init) from [<c0825400>] =
(omap4_local_timer_init+0x10/0x68)
[    0.000000] [<c08253f0>] (omap4_local_timer_init) from [<c081d67c>] (t=
ime_init+0x24/0x38)
[    0.000000] [<c081d658>] (time_init) from [<c0819a30>] (start_kernel+0=
x1fc/0x390)
[    0.000000] [<c0819834>] (start_kernel) from [<80008074>] (0x80008074)=

[    0.000000]  r10:00000000 r9:412fc09a r8:8000406a r7:c088f684 r6:c086a=
d5c r5:c088a92c
[    0.000000]  r4:10c5387d
[    0.000000] Code: e92dd9f0 e24cb004 e24dd00c e59f3104 (e1d084bc)=20
[    0.000000] ---[ end trace 3406ff24bd97382e ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle tas=
k!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the=
 idle task!


--jqbJbbT5xk5T8RRTK8Ptwmt5FnOmDMv7C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTJwIYAAoJEPo9qoy8lh71+fAP/jDTTp2a/sHkyg2XeaqMSJbP
JFW8Ua4y8jxd+FndIrCVH7e6Zy0qwh35DmD4p6l6kDya3rwcDe7zS3WJHDfYyOoK
f3zKM9g6x2DdVRUYPkQ6k4eeCm/l5bt6ifw6L1UR0RG7VMrzXc7Rdf5omzBBjkc0
R9fRJwcBO/dI27fO73VmIV+S5Pe5K7VM1Aw8ehXHQMIsbwwg0wyLLmR3w3aOps80
lmWGIQHqJMEolSCGr9ipxAAb1pRoKqKD3kxgCTks29xqiD9UeR7IZdq3IQPBDqSz
VZwHaKbtdt/HD7Yb8nxd6EmHRxW3hrLJqTUtwr1jDnt5gAISZZ3EFlW6bGnHg7kv
PPz+cQPwwHibYLIcLsSsoJodUNkW0v9E7Yj2UlkX/2fHFuQ4U0KoD/Ua2DBfant5
XsHmDIhRRQ0oXKEd7PXHnBUnL6o1glouoRupfyQ+E0OhWJaKA/tjcPM/M3oRjrxd
EX2R2sjHVDvrEAE/MPG9+PqvtQBWz46upIuyn3cYTyIHyTyUibEIzygswZ1oFg3d
NRzRbWeyjrRSX0Y1C9C8STee0HpfXGB5NlfpQpUuGSQO76iC8yxay9eepoAWFwNV
WLbf2F2vPc/ivRH5H4nigRJPYZCeC2wVaCbfvCAgdjYpYPYhAWiki4YL4P6fOLtk
u/9xesVpZa/mAdfhnfB9
=1dTJ
-----END PGP SIGNATURE-----

--jqbJbbT5xk5T8RRTK8Ptwmt5FnOmDMv7C--
