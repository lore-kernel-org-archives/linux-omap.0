From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/3] pwm: core: Rearrange pwm lock.
Date: Thu, 23 Jan 2014 14:54:50 +0100
Message-ID: <20140123135449.GA6503@ulmo.nvidia.com>
References: <1387366615-23182-1-git-send-email-sourav.poddar@ti.com>
 <1387366615-23182-2-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1387366615-23182-2-git-send-email-sourav.poddar@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2013 at 05:06:53PM +0530, Sourav Poddar wrote:
> When tiecap is used as a module, then while doing a rmmod I
> get the following dump.
>=20
> root@am437x-evm:/# rmmod pwm_tiecap
> [  219.539245]
> [  219.540771] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  219.546936] [ INFO: possible circular locking dependency detected ]
> [  219.553192] 3.12.4-01557-g9921cde-dirty #134 Not tainted
> [  219.558471] -------------------------------------------------------
> [  219.564727] rmmod/1517 is trying to acquire lock:
> [  219.569427]  (s_active#35){++++.+}, at: [<c017ab00>] sysfs_hash_and_re=
move+0x4c/0x8c
> [  219.577239]
> [  219.577239] but task is already holding lock:
> [  219.583068]  (pwm_lock){+.+.+.}, at: [<c0303598>] pwmchip_remove+0x14/=
0xf8
> [  219.589996]
> [  219.589996] which lock already depends on the new lock.
> [  219.589996]
> [  219.598144]
> [  219.598144] the existing dependency chain (in reverse order) is:
> [  219.605590]
> -> #1 (pwm_lock){+.+.+.}:
> [  219.609497]        [<c00a2d1c>] lock_acquire+0x9c/0x128
> [  219.614746]        [<c0639bc0>] mutex_lock_nested+0x50/0x3dc
> [  219.620391]        [<c0303974>] pwm_request_from_chip+0x38/0x6c
> [  219.626312]        [<c0303fe0>] pwm_export_store+0x50/0x140
> [  219.631896]        [<c039aba8>] dev_attr_store+0x18/0x24
> [  219.637207]        [<c017aff0>] sysfs_write_file+0x16c/0x1a0
> [  219.642883]        [<c0119084>] vfs_write+0xb0/0x188
> [  219.647857]        [<c0119478>] SyS_write+0x3c/0x70
> [  219.652770]        [<c0014100>] ret_fast_syscall+0x0/0x48
> [  219.658172]
> -> #0 (s_active#35){++++.+}:
> [  219.662353]        [<c00a2778>] __lock_acquire+0x1b28/0x1b70
> [  219.667999]        [<c00a2d1c>] lock_acquire+0x9c/0x128
> [  219.673248]        [<c017c780>] sysfs_addrm_finish+0xe8/0x158
> [  219.678985]        [<c017ab00>] sysfs_hash_and_remove+0x4c/0x8c
> [  219.684906]        [<c017e224>] remove_files+0x38/0x74
> [  219.690063]        [<c017e2a4>] sysfs_remove_group+0x44/0x108
> [  219.695800]        [<c017e38c>] sysfs_remove_groups+0x24/0x34
> [  219.701538]        [<c039bc2c>] device_del+0xec/0x178
> [  219.706604]        [<c039bcc4>] device_unregister+0xc/0x18
> [  219.712097]        [<c0303658>] pwmchip_remove+0xd4/0xf8
> [  219.717407]        [<c039fdc4>] platform_drv_remove+0x18/0x1c
> [  219.723175]        [<c039e6c4>] __device_release_driver+0x70/0xc8
> [  219.729248]        [<c039eec8>] driver_detach+0xb4/0xb8
> [  219.734497]        [<c039e4ec>] bus_remove_driver+0x8c/0xd0
> [  219.740081]        [<c00abd2c>] SyS_delete_module+0x118/0x22c
> [  219.745819]        [<c0014100>] ret_fast_syscall+0x0/0x48
> [  219.751220]
> [  219.751220] other info that might help us debug this:
> [  219.751220]
> [  219.759216]  Possible unsafe locking scenario:
> [  219.759216]
> [  219.765106]        CPU0                    CPU1
> [  219.769622]        ----                    ----
> [  219.774139]   lock(pwm_lock);
> [  219.777130]                                lock(s_active#35);
> [  219.782897]                                lock(pwm_lock);
> [  219.788391]   lock(s_active#35);
> [  219.791656]
> [  219.791656]  *** DEADLOCK ***
> [  219.791656]
> [  219.797546] 3 locks held by rmmod/1517:
> [  219.801391]  #0:  (&__lockdep_no_validate__){......}, at: [<c039ee58>]=
 driver_detach+0x44/0xb8
> [  219.810028]  #1:  (&__lockdep_no_validate__){......}, at: [<c039ee64>]=
 driver_detach+0x50/0xb8
> [  219.818695]  #2:  (pwm_lock){+.+.+.}, at: [<c0303598>] pwmchip_remove+=
0x14/0xf8
> [  219.826049]
> [  219.826049] stack backtrace:
> [  219.830413] CPU: 0 PID: 1517 Comm: rmmod Not tainted 3.12.4-01557-g992=
1cde-dirty #134
> [  219.838256] [<c001cc98>] (unwind_backtrace+0x0/0xf0) from [<c0018124>]=
 (show_stack+0x10/0x14)
> [  219.846771] [<c0018124>] (show_stack+0x10/0x14) from [<c0636728>] (dum=
p_stack+0x74/0xb4)
> [  219.854858] [<c0636728>] (dump_stack+0x74/0xb4) from [<c06344e4>] (pri=
nt_circular_bug+0x284/0x2d8)
> [  219.863830] [<c06344e4>] (print_circular_bug+0x284/0x2d8) from [<c00a2=
778>] (__lock_acquire+0x1b28/0x1b70)
> [  219.873443] [<c00a2778>] (__lock_acquire+0x1b28/0x1b70) from [<c00a2d1=
c>] (lock_acquire+0x9c/0x128)
> [  219.882476] [<c00a2d1c>] (lock_acquire+0x9c/0x128) from [<c017c780>] (=
sysfs_addrm_finish+0xe8/0x158)
> [  219.891601] [<c017c780>] (sysfs_addrm_finish+0xe8/0x158) from [<c017ab=
00>] (sysfs_hash_and_remove+0x4c/0x8c)
> [  219.901397] [<c017ab00>] (sysfs_hash_and_remove+0x4c/0x8c) from [<c017=
e224>] (remove_files+0x38/0x74)
> [  219.910614] [<c017e224>] (remove_files+0x38/0x74) from [<c017e2a4>] (s=
ysfs_remove_group+0x44/0x108)
> [  219.919647] [<c017e2a4>] (sysfs_remove_group+0x44/0x108) from [<c017e3=
8c>] (sysfs_remove_groups+0x24/0x34)
> [  219.929260] [<c017e38c>] (sysfs_remove_groups+0x24/0x34) from [<c039bc=
2c>] (device_del+0xec/0x178)
> [  219.938201] [<c039bc2c>] (device_del+0xec/0x178) from [<c039bcc4>] (de=
vice_unregister+0xc/0x18)
> [  219.946899] [<c039bcc4>] (device_unregister+0xc/0x18) from [<c0303658>=
] (pwmchip_remove+0xd4/0xf8)
> [  219.955841] [<c0303658>] (pwmchip_remove+0xd4/0xf8) from [<c039fdc4>] =
(platform_drv_remove+0x18/0x1c)
> [  219.965057] [<c039fdc4>] (platform_drv_remove+0x18/0x1c) from [<c039e6=
c4>] (__device_release_driver+0x70/0xc8)
> [  219.975006] [<c039e6c4>] (__device_release_driver+0x70/0xc8) from [<c0=
39eec8>] (driver_detach+0xb4/0xb8)
> [  219.984466] [<c039eec8>] (driver_detach+0xb4/0xb8) from [<c039e4ec>] (=
bus_remove_driver+0x8c/0xd0)
> [  219.993438] [<c039e4ec>] (bus_remove_driver+0x8c/0xd0) from [<c00abd2c=
>] (SyS_delete_module+0x118/0x22c)
> [  220.002899] [<c00abd2c>] (SyS_delete_module+0x118/0x22c) from [<c00141=
00>] (ret_fast_syscall+0x0/0x48)
>=20
> Looks like s_active lock cannot be held while pwm lock is held.
> The patch fixes the above issue by unlocking the pwm lock before acquirin=
g the
> sysfs lock.

I've been trying to reproduce this, but I can't. I've enabled LOCKDEP
and PROVE_LOCKING in Kconfig, booted a Tegra-based board and did a
couple of modprobe pwm-tegra && modprobe -r pwm-tegra. But I never saw
LOCKDEP complain.

Can you reproduce the issue on latest linux-next? Or is there something
else I should be doing to trigger this?

Thierry

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4R8pAAoJEN0jrNd/PrOh2wsQAI2Oc1FGy9VevNL+1lozllRJ
PfjoxAzcBHxdiM42K9fOCTTzXLtNW0z8bVJdDbvZCaNMErkItQI2ZAO82PDdHRRu
fixZm+jB1gA2C/0pSqF7O0dmCudFw1Tss/loJQRROEE/j/BNaM80SfV/oADPRQq5
/EcDkpFrJWH4hTOkDDpgbtySZpKnOtE8FjxnMKVS7MoyM19hXC5dv/gax96lvv6L
Mxznsg2hI9iZdSbPrgDNpbHvFUvIl/lYKTSBaoz71YzkJ5g+u6muLQ9+lKmf2Iqi
bdqiO0ZDc+qO+eDwdgf2TunfGcOv2Uap/SLBIu6i0t9ig5X5Esp5u3PlfuuEenhr
Dv9vo8tNmpZRhbKj2OVLTVps5mlEVAxTxEM8A5I4C771sYNH4WtHJfR6ks308kQi
UAbT/spXAiKyL+DI0zY+BKs86XUcRG2CSygkvjpUWg+BQKNrWGVJ3Djghn1LyeQX
MUqa/Rp50kxZXsJJAsjnYAdiIE0JJ7f9PC/o1bFlJP6vT2Lk/K8lDZsa1edqJh8/
rWg85jJKszsmxUFswxf0TVbfL0Mjmkcx+wK6p1xd8+qcKjFJVJlZmCTQffx4hnMB
V09xYDoBpj4GfdwiUuK5Ja7lUTO1/PLMcXQCvC8WKf4BJKH84oXkhGfFL4GSBwsM
MJC4ErzAVoeOtRyESi2F
=JYK7
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
