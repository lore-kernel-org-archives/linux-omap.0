From: Felipe Balbi <balbi@ti.com>
Subject: Re: Regression caused by 073db4a51ee43ccb827f54a4261c0583b028d5ab
Date: Thu, 22 Oct 2015 14:32:14 -0500
Message-ID: <87pp06em2p.fsf@saruman.tx.rr.com>
References: <87y4euenip.fsf@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0994320534169080271=="
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <87y4euenip.fsf@saruman.tx.rr.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============0994320534169080271==
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


(fixing Tony's address)

Felipe Balbi <balbi@ti.com> writes:
> Hi,
>
> I just noticed that commit 073db4a51ee4 (mtd: fix: avoid race condition
> when accessing mtd->usecount) caused a regression at least when removing
> m25p80. Wonder if you guys would know of a quick fix, other than
> reverting $commit in HEAD (yes, that makes the problem go away, but
> regresses on what $commit tried to fix, of course).
>
> More info about the regression follows, together with bisection log:
>
> # modprobe -r m25p80
> [   53.419251]=20
> [   53.420838] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   53.427300] [ INFO: possible circular locking dependency detected ]
> [   53.433865] 4.3.0-rc6 #96 Not tainted
> [   53.437686] -------------------------------------------------------
> [   53.444220] modprobe/372 is trying to acquire lock:
> [   53.449320]  (&new->lock){+.+...}, at: [<c043fe4c>] del_mtd_blktrans_d=
ev+0x80/0xdc
> [   53.457271]=20
> [   53.457271] but task is already holding lock:
> [   53.463372]  (mtd_table_mutex){+.+.+.}, at: [<c0439994>] del_mtd_devic=
e+0x18/0x100
> [   53.471321]=20
> [   53.471321] which lock already depends on the new lock.
> [   53.471321]=20
> [   53.479856]=20
> [   53.479856] the existing dependency chain (in reverse order) is:
> [   53.487660]=20
> -> #1 (mtd_table_mutex){+.+.+.}:
> [   53.492331]        [<c043fc5c>] blktrans_open+0x34/0x1a4
> [   53.497879]        [<c01afce0>] __blkdev_get+0xc4/0x3b0
> [   53.503364]        [<c01b0bb8>] blkdev_get+0x108/0x320
> [   53.508743]        [<c01713c0>] do_dentry_open+0x218/0x314
> [   53.514496]        [<c0180454>] path_openat+0x4c0/0xf9c
> [   53.519959]        [<c0182044>] do_filp_open+0x5c/0xc0
> [   53.525336]        [<c0172758>] do_sys_open+0xfc/0x1cc
> [   53.530716]        [<c000f740>] ret_fast_syscall+0x0/0x1c
> [   53.536375]=20
> -> #0 (&new->lock){+.+...}:
> [   53.540587]        [<c063f124>] mutex_lock_nested+0x38/0x3cc
> [   53.546504]        [<c043fe4c>] del_mtd_blktrans_dev+0x80/0xdc
> [   53.552606]        [<c043f164>] blktrans_notify_remove+0x7c/0x84
> [   53.558891]        [<c04399f0>] del_mtd_device+0x74/0x100
> [   53.564544]        [<c043c670>] del_mtd_partitions+0x80/0xc8
> [   53.570451]        [<c0439aa0>] mtd_device_unregister+0x24/0x48
> [   53.576637]        [<c046ce6c>] spi_drv_remove+0x1c/0x34
> [   53.582207]        [<c03de0f0>] __device_release_driver+0x88/0x114
> [   53.588663]        [<c03de19c>] device_release_driver+0x20/0x2c
> [   53.594843]        [<c03dd9e8>] bus_remove_device+0xd8/0x108
> [   53.600748]        [<c03dacc0>] device_del+0x10c/0x210
> [   53.606127]        [<c03dadd0>] device_unregister+0xc/0x20
> [   53.611849]        [<c046d878>] __unregister+0x10/0x20
> [   53.617211]        [<c03da868>] device_for_each_child+0x50/0x7c
> [   53.623387]        [<c046eae8>] spi_unregister_master+0x58/0x8c
> [   53.629578]        [<c03e12f0>] release_nodes+0x15c/0x1c8
> [   53.635223]        [<c03de0f8>] __device_release_driver+0x90/0x114
> [   53.641689]        [<c03de900>] driver_detach+0xb4/0xb8
> [   53.647147]        [<c03ddc78>] bus_remove_driver+0x4c/0xa0
> [   53.652970]        [<c00cab50>] SyS_delete_module+0x11c/0x1e4
> [   53.658976]        [<c000f740>] ret_fast_syscall+0x0/0x1c
> [   53.664621]=20
> [   53.664621] other info that might help us debug this:
> [   53.664621]=20
> [   53.672979]  Possible unsafe locking scenario:
> [   53.672979]=20
> [   53.679169]        CPU0                    CPU1
> [   53.683900]        ----                    ----
> [   53.688633]   lock(mtd_table_mutex);
> [   53.692383]                                lock(&new->lock);
> [   53.698306]                                lock(mtd_table_mutex);
> [   53.704658]   lock(&new->lock);
> [   53.707946]=20
> [   53.707946]  *** DEADLOCK ***
> [   53.707946]=20
> [   53.714123] 5 locks held by modprobe/372:
> [   53.718305]  #0:  (&dev->mutex){......}, at: [<c03de890>] driver_detac=
h+0x44/0xb8
> [   53.726147]  #1:  (&dev->mutex){......}, at: [<c03de89c>] driver_detac=
h+0x50/0xb8
> [   53.733985]  #2:  (&dev->mutex){......}, at: [<c03de194>] device_relea=
se_driver+0x18/0x2c
> [   53.742541]  #3:  (mtd_partitions_mutex){+.+.+.}, at: [<c043c60c>] del=
_mtd_partitions+0x1c/0xc8
> [   53.751656]  #4:  (mtd_table_mutex){+.+.+.}, at: [<c0439994>] del_mtd_=
device+0x18/0x100
> [   53.760048]=20
> [   53.760048] stack backtrace:
> [   53.764591] CPU: 0 PID: 372 Comm: modprobe Not tainted 4.3.0-rc6 #96
> [   53.771217] Hardware name: Generic AM43 (Flattened Device Tree)
> [   53.777419] [<c0017bcc>] (unwind_backtrace) from [<c0013f30>] (show_st=
ack+0x10/0x14)
> [   53.785511] [<c0013f30>] (show_stack) from [<c0346be4>] (dump_stack+0x=
84/0x9c)
> [   53.793063] [<c0346be4>] (dump_stack) from [<c0090000>] (print_circula=
r_bug+0x1c8/0x30c)
> [   53.801500] [<c0090000>] (print_circular_bug) from [<c0093828>] (__loc=
k_acquire+0x1a48/0x1cd8)
> [   53.810480] [<c0093828>] (__lock_acquire) from [<c00943bc>] (lock_acqu=
ire+0xac/0x12c)
> [   53.818649] [<c00943bc>] (lock_acquire) from [<c063f124>] (mutex_lock_=
nested+0x38/0x3cc)
> [   53.827103] [<c063f124>] (mutex_lock_nested) from [<c043fe4c>] (del_mt=
d_blktrans_dev+0x80/0xdc)
> [   53.836199] [<c043fe4c>] (del_mtd_blktrans_dev) from [<c043f164>] (blk=
trans_notify_remove+0x7c/0x84)
> [   53.845735] [<c043f164>] (blktrans_notify_remove) from [<c04399f0>] (d=
el_mtd_device+0x74/0x100)
> [   53.854833] [<c04399f0>] (del_mtd_device) from [<c043c670>] (del_mtd_p=
artitions+0x80/0xc8)
> [   53.863469] [<c043c670>] (del_mtd_partitions) from [<c0439aa0>] (mtd_d=
evice_unregister+0x24/0x48)
> [   53.872733] [<c0439aa0>] (mtd_device_unregister) from [<c046ce6c>] (sp=
i_drv_remove+0x1c/0x34)
> [   53.881633] [<c046ce6c>] (spi_drv_remove) from [<c03de0f0>] (__device_=
release_driver+0x88/0x114)
> [   53.890788] [<c03de0f0>] (__device_release_driver) from [<c03de19c>] (=
device_release_driver+0x20/0x2c)
> [   53.900483] [<c03de19c>] (device_release_driver) from [<c03dd9e8>] (bu=
s_remove_device+0xd8/0x108)
> [   53.909735] [<c03dd9e8>] (bus_remove_device) from [<c03dacc0>] (device=
_del+0x10c/0x210)
> [   53.918088] [<c03dacc0>] (device_del) from [<c03dadd0>] (device_unregi=
ster+0xc/0x20)
> [   53.926160] [<c03dadd0>] (device_unregister) from [<c046d878>] (__unre=
gister+0x10/0x20)
> [   53.934526] [<c046d878>] (__unregister) from [<c03da868>] (device_for_=
each_child+0x50/0x7c)
> [   53.943261] [<c03da868>] (device_for_each_child) from [<c046eae8>] (sp=
i_unregister_master+0x58/0x8c)
> [   53.952805] [<c046eae8>] (spi_unregister_master) from [<c03e12f0>] (re=
lease_nodes+0x15c/0x1c8)
> [   53.961809] [<c03e12f0>] (release_nodes) from [<c03de0f8>] (__device_r=
elease_driver+0x90/0x114)
> [   53.970883] [<c03de0f8>] (__device_release_driver) from [<c03de900>] (=
driver_detach+0xb4/0xb8)
> [   53.979864] [<c03de900>] (driver_detach) from [<c03ddc78>] (bus_remove=
_driver+0x4c/0xa0)
> [   53.988303] [<c03ddc78>] (bus_remove_driver) from [<c00cab50>] (SyS_de=
lete_module+0x11c/0x1e4)
> [   53.997285] [<c00cab50>] (SyS_delete_module) from [<c000f740>] (ret_fa=
st_syscall+0x0/0x1c)
>
>
> Bisection log:
>
> git bisect start
> # good: [b953c0d234bc72e8489d3bf51a276c5c4ec85345] Linux 4.1
> git bisect good b953c0d234bc72e8489d3bf51a276c5c4ec85345
> # bad: [d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754] Linux 4.2-rc1
> git bisect bad d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754
> # bad: [4570a37169d4b44d316f40b2ccc681dc93fedc7b] Merge tag 'sound-4.2-rc=
1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
> git bisect bad 4570a37169d4b44d316f40b2ccc681dc93fedc7b
> # bad: [4e241557fc1cb560bd9e77ca1b4a9352732a5427] Merge tag 'for-linus' o=
f git://git.kernel.org/pub/scm/virt/kvm/kvm
> git bisect bad 4e241557fc1cb560bd9e77ca1b4a9352732a5427
> # good: [44d21c3f3a2ef2f58b18bda64c52c99e723f3f4a] Merge git://git.kernel=
.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
> git bisect good 44d21c3f3a2ef2f58b18bda64c52c99e723f3f4a
> # good: [acd53127c4adbd34570b221e7ea1f7fc94aea923] Merge tag 'scsi-misc' =
of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
> git bisect good acd53127c4adbd34570b221e7ea1f7fc94aea923
> # bad: [54245ed870c8cf9ff87fdf78955ffbc93b261e9f] Merge tag 'for-linus-20=
150623' of git://git.infradead.org/linux-mtd
> git bisect bad 54245ed870c8cf9ff87fdf78955ffbc93b261e9f
> # good: [5a602e157a9d91d5ce98d07c404097edba8ec9f3] Merge tag 'spi-v4.2' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi
> git bisect good 5a602e157a9d91d5ce98d07c404097edba8ec9f3
> # good: [1abf25a25b86dcfe28d243a5af71bd1c9d6de1ef] mfd: lpc_ich: Assign s=
ubdevice ids automatically
> git bisect good 1abf25a25b86dcfe28d243a5af71bd1c9d6de1ef
> # bad: [45c2ebd702a468d5037cf16aa4f8ea8d67776f6a] mtd: docg3: Don't leak =
docg3->bbt in error path
> git bisect bad 45c2ebd702a468d5037cf16aa4f8ea8d67776f6a
> # bad: [f628ece6636c2f0354a52566cafdea6d2f963b3d] mtd: brcmnand: add BCM6=
3138 support
> git bisect bad f628ece6636c2f0354a52566cafdea6d2f963b3d
> # good: [b94665322b786a806a0169752ff2f35f3f467b99] mtd: samsung: Constify=
 platform_device_id
> git bisect good b94665322b786a806a0169752ff2f35f3f467b99
> # bad: [073db4a51ee43ccb827f54a4261c0583b028d5ab] mtd: fix: avoid race co=
ndition when accessing mtd->usecount
> git bisect bad 073db4a51ee43ccb827f54a4261c0583b028d5ab
> # good: [b79c332fb283c101abb5d8570dea2d29f3871802] mtd: spi-nor: add supp=
ort for the ISSI SI25CD512 SPI flash
> git bisect good b79c332fb283c101abb5d8570dea2d29f3871802
> # good: [7aaea7605c0e19fa7b38d7ac5dcd818942fd17a7] jffs2: fix unbalanced =
locking
> git bisect good 7aaea7605c0e19fa7b38d7ac5dcd818942fd17a7
> # good: [5844feeaa4154d1c46d3462c7a4653d22356d8b4] mtd: nand: add common =
DT init code
> git bisect good 5844feeaa4154d1c46d3462c7a4653d22356d8b4
> # first bad commit: [073db4a51ee43ccb827f54a4261c0583b028d5ab] mtd: fix: =
avoid race condition when accessing mtd->usecount
> commit 073db4a51ee43ccb827f54a4261c0583b028d5ab
> Author: Brian Norris <computersforpeace@gmail.com>
> Date:   Thu May 7 17:55:16 2015 -0700
>
>     mtd: fix: avoid race condition when accessing mtd->usecount
>=20=20=20=20=20
>     On A MIPS 32-cores machine a BUG_ON was triggered because some acesse=
s to
>     mtd->usecount were done without taking mtd_table_mutex.
>     kernel: Call Trace:
>     kernel: [<ffffffff80401818>] __put_mtd_device+0x20/0x50
>     kernel: [<ffffffff804086f4>] blktrans_release+0x8c/0xd8
>     kernel: [<ffffffff802577e0>] __blkdev_put+0x1a8/0x200
>     kernel: [<ffffffff802579a4>] blkdev_close+0x1c/0x30
>     kernel: [<ffffffff8022006c>] __fput+0xac/0x250
>     kernel: [<ffffffff80171208>] task_work_run+0xd8/0x120
>     kernel: [<ffffffff8012c23c>] work_notifysig+0x10/0x18
>     kernel:
>     kernel:
>             Code: 2442ffff  ac8202d8  000217fe <00020336> dc820128  10400=
003
>                    00000000  0040f809  00000000
>     kernel: ---[ end trace 080fbb4579b47a73 ]---
>=20=20=20=20=20
>     Fixed by taking the mutex in blktrans_open and blktrans_release.
>=20=20=20=20=20
>     Note that this locking is already suggested in
>     include/linux/mtd/blktrans.h:
>=20=20=20=20=20
>     struct mtd_blktrans_ops {
>     ...
>     	/* Called with mtd_table_mutex held; no race with add/remove */
>     	int (*open)(struct mtd_blktrans_dev *dev);
>     	void (*release)(struct mtd_blktrans_dev *dev);
>     ...
>     };
>=20=20=20=20=20
>     But we weren't following it.
>=20=20=20=20=20
>     Originally reported by (and patched by) Zhang and Giuseppe,
>     independently. Improved and rewritten.
>=20=20=20=20=20
>     Cc: stable@vger.kernel.org
>     Reported-by: Zhang Xingcai <zhangxingcai@huawei.com>
>     Reported-by: Giuseppe Cantavenera <giuseppe.cantavenera.ext@nokia.com>
>     Tested-by: Giuseppe Cantavenera <giuseppe.cantavenera.ext@nokia.com>
>     Acked-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
>     Signed-off-by: Brian Norris <computersforpeace@gmail.com>
>
> diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
> index 2b0c52870999..df7c6c70757a 100644
> --- a/drivers/mtd/mtd_blkdevs.c
> +++ b/drivers/mtd/mtd_blkdevs.c
> @@ -197,6 +197,7 @@ static int blktrans_open(struct block_device *bdev, f=
mode_t mode)
>  		return -ERESTARTSYS; /* FIXME: busy loop! -arnd*/
>=20=20
>  	mutex_lock(&dev->lock);
> +	mutex_lock(&mtd_table_mutex);
>=20=20
>  	if (dev->open)
>  		goto unlock;
> @@ -220,6 +221,7 @@ static int blktrans_open(struct block_device *bdev, f=
mode_t mode)
>=20=20
>  unlock:
>  	dev->open++;
> +	mutex_unlock(&mtd_table_mutex);
>  	mutex_unlock(&dev->lock);
>  	blktrans_dev_put(dev);
>  	return ret;
> @@ -230,6 +232,7 @@ error_release:
>  error_put:
>  	module_put(dev->tr->owner);
>  	kref_put(&dev->ref, blktrans_dev_release);
> +	mutex_unlock(&mtd_table_mutex);
>  	mutex_unlock(&dev->lock);
>  	blktrans_dev_put(dev);
>  	return ret;
> @@ -243,6 +246,7 @@ static void blktrans_release(struct gendisk *disk, fm=
ode_t mode)
>  		return;
>=20=20
>  	mutex_lock(&dev->lock);
> +	mutex_lock(&mtd_table_mutex);
>=20=20
>  	if (--dev->open)
>  		goto unlock;
> @@ -256,6 +260,7 @@ static void blktrans_release(struct gendisk *disk, fm=
ode_t mode)
>  		__put_mtd_device(dev->mtd);
>  	}
>  unlock:
> +	mutex_unlock(&mtd_table_mutex);
>  	mutex_unlock(&dev->lock);
>  	blktrans_dev_put(dev);
>  }
>
> --=20
> balbi

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKTm/AAoJEIaOsuA1yqRENLcQALaRk7oLBalQrdT6FM0NrAwv
pLkW+cvODyejyTsurqANQPco/2udKkaEHswR7ZWS+dSdHUa2Y7LxHFPXpPt5LdMa
EJMLhtzEecJY+8QFwphXpNNHUDnDVeUqMVJ6HdmQMEIbgFMorSc+lgORvEHDPSgB
CnaeJgxWtSwwS8tON1Skh/IQWX5+TsGG6Xy3XyC9iPrveNJnaFPSlXgG3m76QxY1
J0YhWZ91z84Gkhp3k980M6fZ3RHAeKu2aTYmHlRAy24pGgARFtNk3w2RVb31mP0U
DkwIgCPQK+gMysSM1g+OG87jwjx/7rFvItb5Pn+Dw9HtkMIoXH/wBIUe+H8ED7W3
WGpmxSI7tjmAYgbtPnpgRuOzjlnB5jgem/8TNt2ZoxEdMgijpB2GPurCPoEbhE/m
2rsW+7gBYV5qdw9/FZw/z7oPsJWzLpnii2otzL1i6TNvCDPlH/oURASapQ0rbeGx
7GHKqA4XDcLBMdmp3nXKbBsjoFNUgcQHgoCPs+ARxyxfB5ccolXdX1s2ANA2Kunk
d4PlFLCp+9uLI4gyQkwuG6XiwbnKECf6YFnxDMRnG0KA52GGDteobeD9ZqNkfEiz
jb/J9cjQNkhYWTrjSHdHLBVFlDvGp5sGn214ycfYEX5GofY2DWo6J4zJkS7aAOFY
flnOtt6/YduHkzmu52rM
=alC4
-----END PGP SIGNATURE-----
--=-=-=--


--===============0994320534169080271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============0994320534169080271==--
