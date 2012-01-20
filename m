From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: OMAP4 hwmod problem when unloading omapdss
Date: Fri, 20 Jan 2012 12:09:53 +0200
Message-ID: <1327054193.1921.37.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-r1EtqoqShXbEGhy5VZ7Q"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:36407 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752447Ab2ATKJ6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jan 2012 05:09:58 -0500
Received: by mail-lpp01m010-f45.google.com with SMTP id j13so245998lah.4
        for <linux-omap@vger.kernel.org>; Fri, 20 Jan 2012 02:09:56 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap mailing list <linux-omap@vger.kernel.org>


--=-r1EtqoqShXbEGhy5VZ7Q
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Benoit,

I see the below WARNING on v3.3-rc1, running on OMAP4460 Panda, when I
unload the DSS modules. This didn't happen on v3.2, or linux-next from a
few weeks ago.

 Tomi


[   29.667572] ------------[ cut here ]------------
[   29.667572] WARNING: at arch/arm/mach-omap2/omap_hwmod.c:1604 _idle+0x16=
4/0x17c()
[   29.674774] omap_hwmod: dss_hdmi: idle state can only be entered from en=
abled state
[   29.688293] Modules linked in: cfbimgblt cfbfillrect cfbcopyarea omapdss=
(-) [last unloaded: panel
_dvi]
[   29.693084] [<c001b614>] (unwind_backtrace+0x0/0xf0) from [<c0041d70>] (=
warn_slowpath_common+0x4c
/0x64)
[   29.703918] [<c0041d70>] (warn_slowpath_common+0x4c/0x64) from [<c0041e1=
c>] (warn_slowpath_fmt+0x
30/0x40)
[   29.717987] [<c0041e1c>] (warn_slowpath_fmt+0x30/0x40) from [<c0027fdc>]=
 (_idle+0x164/0x17c)
[   29.724670] [<c0027fdc>] (_idle+0x164/0x17c) from [<c0028850>] (omap_hwm=
od_idle+0x24/0x40)
[   29.729461] [<c0028850>] (omap_hwmod_idle+0x24/0x40) from [<c003b670>] (=
omap_device_idle_hwmods+0
x24/0x3c)
[   29.745086] [<c003b670>] (omap_device_idle_hwmods+0x24/0x3c) from [<c003=
b860>] (_omap_device_deac
tivate+0x9c/0x138)
[   29.745086] [<c003b860>] (_omap_device_deactivate+0x9c/0x138) from [<c00=
3c270>] (omap_device_idle
+0x28/0x54)
[   29.745086] [<c003c270>] (omap_device_idle+0x28/0x54) from [<c003c2b8>] =
(_od_runtime_suspend+0x1c
/0x24)
[   29.776672] [<c003c2b8>] (_od_runtime_suspend+0x1c/0x24) from [<c02b5a68=
>] (__rpm_callback+0x70/0
x98)
[   29.786346] [<c02b5a68>] (__rpm_callback+0x70/0x98) from [<c02b5f08>] (r=
pm_suspend+0x240/0x6c0)
[   29.786346] [<c02b5f08>] (rpm_suspend+0x240/0x6c0) from [<c02b734c>] (__=
pm_runtime_suspend+0x5c/0
x74)
[   29.799774] [<c02b734c>] (__pm_runtime_suspend+0x5c/0x74) from [<c02b2ec=
4>] (pm_generic_runtime_i
dle+0x44/0x4c)
[   29.807586] [<c02b2ec4>] (pm_generic_runtime_idle+0x44/0x4c) from [<c02b=
5a68>] (__rpm_callback+0x
70/0x98)
[   29.807586] [<c02b5a68>] (__rpm_callback+0x70/0x98) from [<c02b64fc>] (r=
pm_idle+0x100/0x228)
[   29.831085] [<c02b64fc>] (rpm_idle+0x100/0x228) from [<c02b66f4>] (__pm_=
runtime_idle+0x5c/0x74)
[   29.843658] [<c02b66f4>] (__pm_runtime_idle+0x5c/0x74) from [<c02ae6a4>]=
 (__device_release_driver
+0x50/0xc0)
[   29.846649] [<c02ae6a4>] (__device_release_driver+0x50/0xc0) from [<c02a=
ed0c>] (driver_detach+0xb
4/0xb8)
[   29.863891] [<c02aed0c>] (driver_detach+0xb4/0xb8) from [<c02ae580>] (bu=
s_remove_driver+0x7c/0xc0
)
[   29.870086] [<c02ae580>] (bus_remove_driver+0x7c/0xc0) from [<bf0000f0>]=
 (omap_dss_remove+0x14/0x
6c [omapdss])
[   29.877929] [<bf0000f0>] (omap_dss_remove+0x14/0x6c [omapdss]) from [<c0=
2afe60>] (platform_drv_re
move+0x18/0x1c)
[   29.893463] [<c02afe60>] (platform_drv_remove+0x18/0x1c) from [<c02ae6c4=
>] (__device_release_driv
er+0x70/0xc0)
[   29.901489] [<c02ae6c4>] (__device_release_driver+0x70/0xc0) from [<c02a=
ed0c>] (driver_detach+0xb
4/0xb8)
[   29.901489] [<c02aed0c>] (driver_detach+0xb4/0xb8) from [<c02ae580>] (bu=
s_remove_driver+0x7c/0xc0
)
[   29.924499] [<c02ae580>] (bus_remove_driver+0x7c/0xc0) from [<bf020e98>]=
 (omap_dss_exit+0x48/0x58
 [omapdss])
[   29.932586] [<bf020e98>] (omap_dss_exit+0x48/0x58 [omapdss]) from [<c009=
8f54>] (sys_delete_module
+0x164/0x254)
[   29.940399] [<c0098f54>] (sys_delete_module+0x164/0x254) from [<c0013c80=
>] (ret_fast_syscall+0x0/
0x3c)
[   29.955139] ---[ end trace 52be023ca95d7e20 ]---


--=-r1EtqoqShXbEGhy5VZ7Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPGT1xAAoJEPo9qoy8lh71AOgQAJdqX5bSMQoqyI1jZ5brI5Mb
L+NkBfXA6Xrkk1cYqG9/YzrGL0wTf5boBaerui94oL+poJn8u12mZlcQJz+RToGA
tLSjAv73cxph59dQ0tFKHtLlEAGK8vnzyZ31HFVLi1V8F15lsnsq3O3SJVyox0nc
4WDG7SJHOZo8yUutR8cmfewHc7vUok4ppqWYn5VB1pwrbs9Msvoxu38iLWPefg/+
fkXsZfm8m7UXL1CnMat7WVnwQJLHVgRdjXKVHpL9sIDB3iDEvVmBjSFOTKDNDiNV
QMGJ2JaIysXLaMTwEPDIoFpp1FKBBUmv+i6f6BPVa3tzVxrmJ5QbB2gOqwm83xKV
NXSW+W94wcgL1XkG6kvZb1co1WlWjgVcKa38yv0OicU1/3eB+oZ1ch2OInCB3NUr
Ib6YmiuF0qS/YqMoXfKRKfb9pBSPCmzH2cXlYMWtlCzExOnN1zKAEdqdjFYR+L84
o2Nz95dVIkLfhk08c4F/CYDX0MtdvRkFTvs3BeuyZg18L93bQ8ah9LVq6NnGbyfG
6ol4vD+H4cG4YJC+70SpytlKN7ZRx9XJ8wj/+n/sxpcjD+30FZVGIN7lel1heFdO
NOPHVkxtbTCzzRp2Kmf5sHpkSbLcACUYOsM/Cm/1gud14sk3V1rlZFlgLOlmsG+u
zI8shv5maOVPbaXnRvkY
=Iwp+
-----END PGP SIGNATURE-----

--=-r1EtqoqShXbEGhy5VZ7Q--

