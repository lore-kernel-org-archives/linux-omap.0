From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: linux-next problems
Date: Thu, 12 Jan 2012 17:38:09 +0200
Message-ID: <1326382689.1896.12.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-2xVm1Za8S1tQ3MU6DTIk"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:60817 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753965Ab2ALPiO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Jan 2012 10:38:14 -0500
Received: by mail-lpp01m010-f46.google.com with SMTP id o2so955089lag.19
        for <linux-omap@vger.kernel.org>; Thu, 12 Jan 2012 07:38:12 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Tero Kristo <t-kristo@ti.com>, linux-omap mailing list <linux-omap@vger.kernel.org>


--=-2xVm1Za8S1tQ3MU6DTIk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I was trying to compile linux-next for OMAP, but it doesn't compile with
the default configs.

drivers/remoteproc/remoteproc_rpmsg.c: In function 'rp_find_vq':
drivers/remoteproc/remoteproc_rpmsg.c:100:6: warning: passing argument 7 of=
 'vring_new_virtqueue' from incompatible pointer type
include/linux/virtio_ring.h:168:19: note: expected 'void (*)(struct virtque=
ue *)' but argument is of type 'const char *'
drivers/remoteproc/remoteproc_rpmsg.c:100:6: error: too few arguments to fu=
nction 'vring_new_virtqueue'
include/linux/virtio_ring.h:168:19: note: declared here
make[2]: *** [drivers/remoteproc/remoteproc_rpmsg.o] Error 1

and

arch/arm/mach-omap2/prm_common.c:27:25: fatal error: mach/system.h: No such=
 file or directory
compilation terminated.

Fixing those, I was able to boot Blaze, but I saw this:

[    2.296905] mmc0: new high speed MMC card at address 0001
[    2.304199] mmcblk0: mmc0:0001 SEM08G 7.39 GiB=20
[    2.309326] mmcblk0boot0: mmc0:0001 SEM08G partition 1 1.00 MiB
[    2.315826] mmcblk0boot1: mmc0:0001 SEM08G partition 2 1.00 MiB
[    2.329925]  mmcblk0: unknown partition table
[    2.338195]  mmcblk0boot1: unknown partition table
[    2.343811] BUG: key de7aeef4 not in .data!
[    2.343811] ------------[ cut here ]------------
[    2.353057] WARNING: at kernel/lockdep.c:2986 sysfs_add_file_mode+0x84/0=
xe8()
[    2.360534] Modules linked in:
[    2.363800] [<c001b634>] (unwind_backtrace+0x0/0xf0) from [<c00424ec>] (=
warn_slowpath_common+0x4c
/0x64)
[    2.373657] [<c00424ec>] (warn_slowpath_common+0x4c/0x64) from [<c004252=
0>] (warn_slowpath_null+0
x1c/0x24)
[    2.383789] [<c0042520>] (warn_slowpath_null+0x1c/0x24) from [<c0167128>=
] (sysfs_add_file_mode+0x
84/0xe8)
[    2.393829] [<c0167128>] (sysfs_add_file_mode+0x84/0xe8) from [<c0391234=
>] (mmc_add_disk+0xb4/0x1
00)
[    2.403442] [<c0391234>] (mmc_add_disk+0xb4/0x100) from [<c03918b0>] (mm=
c_blk_probe+0x27c/0x2c8)
[    2.412658] [<c03918b0>] (mmc_blk_probe+0x27c/0x2c8) from [<c03855d4>] (=
mmc_bus_probe+0x18/0x1c)
[    2.421874] [<c03855d4>] (mmc_bus_probe+0x18/0x1c) from [<c02af6d8>] (dr=
iver_probe_device+0x98/0x
1a0)
[    2.431579] [<c02af6d8>] (driver_probe_device+0x98/0x1a0) from [<c02adfd=
0>] (bus_for_each_drv+0x5
c/0x88)
[    2.441528] [<c02adfd0>] (bus_for_each_drv+0x5c/0x88) from [<c02af570>] =
(device_attach+0x98/0xbc)
[    2.450836] [<c02af570>] (device_attach+0x98/0xbc) from [<c02aedac>] (bu=
s_probe_device+0x88/0xac)
[    2.450836] [<c02aedac>] (bus_probe_device+0x88/0xac) from [<c02ad0cc>] =
(device_add+0x538/0x60c)
[    2.469360] [<c02ad0cc>] (device_add+0x538/0x60c) from [<c038591c>] (mmc=
_add_card+0xb8/0x1bc)
[    2.469360] [<c038591c>] (mmc_add_card+0xb8/0x1bc) from [<c0387ff0>] (mm=
c_attach_mmc+0xdc/0x1d0)
[    2.487518] [<c0387ff0>] (mmc_attach_mmc+0xdc/0x1d0) from [<c0385118>] (=
mmc_rescan+0x230/0x45c)
[    2.496612] [<c0385118>] (mmc_rescan+0x230/0x45c) from [<c005b444>] (pro=
cess_one_work+0x18c/0x4e4
)
[    2.506042] [<c005b444>] (process_one_work+0x18c/0x4e4) from [<c005df9c>=
] (worker_thread+0x174/0x
378)
[    2.513153] [<c005df9c>] (worker_thread+0x174/0x378) from [<c0062ac8>] (=
kthread+0x90/0x9c)
[    2.520935] [<c0062ac8>] (kthread+0x90/0x9c) from [<c0014e04>] (kernel_t=
hread_exit+0x0/0x8)
[    2.533172] ---[ end trace 27dad9159f211429 ]---

On OMAP3 Overo, I didn't get any errors, but the console (usb one) was
very unresponsive, impossible to use. Ssh terminal to the device worked
fine, though.

 Tomi


--=-2xVm1Za8S1tQ3MU6DTIk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPDv5cAAoJEPo9qoy8lh71OBoP/3e9yhDL8sa6VYtEAJYA7Gon
SR+08jOdWPuHBZXIP+rJ/eVsqw7qgaPBJF3mCphTCG+s11WH86b7upYKTfiRmHrx
Kgfwp6TebgYJz82lJlGxf+rE2Qx+k+6CXlLJjXsGeK2Op2eQwxZJqPgp+/5elD+G
lhWpozDfcJ4+YuFCwzsxNm4oVEmXbqmo8ebNZd6oXD3nqTDAKlYqfRA0tSoPNYP/
TFSGN8LvN338oqSI0fQNaJo0troiUjDBlYkG/Fx2NSdyf/anOJ/Z9/KqqdxjnpPF
DvUAJ7JR1sx7B7dFgV6y2UpsjoT7Z5CITXQ/s4R34LpFXBbkdiATeX91sYOVpUSp
M2cnNG2DRtsLzfEyBeEqVDtIk0DBztV/HorRRl+SPRoH0ZNY5DTMTLoQBYrXUBDc
5qCu6G95uGOwTqT9k8Nfm8SOqM0bQrwRlPWubjUO8JiGRELujtrxxalYyrlMEgnJ
kjPisfOrkXiANB0fxAmNtacVbMZzmnbiMKkxQRYJKCDmma9Ioq1qdxRr2fB4IpUW
MWr3lJFfX78zGZUeGddVYy9txVzatc2gW/aPJsfYjGTfaexNrlVl88Zdw+0CeCBj
K4SczMKNKULQx+ND6/97Qph1rYl63V+2xnSHDZBpywF6lvVtNYeQAhjoScmxrnab
pfdAGI4FJb9SDDl+RE80
=dgoD
-----END PGP SIGNATURE-----

--=-2xVm1Za8S1tQ3MU6DTIk--

