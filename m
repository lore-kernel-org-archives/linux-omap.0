From: Felipe Balbi <balbi@ti.com>
Subject: Re: Regression caused by 073db4a51ee43ccb827f54a4261c0583b028d5ab
Date: Thu, 22 Oct 2015 15:10:03 -0500
Message-ID: <87lhauekbo.fsf@saruman.tx.rr.com>
References: <87y4euenip.fsf@saruman.tx.rr.com>
 <20151022193853.GH13239@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1879618677280434163=="
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20151022193853.GH13239@google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============1879618677280434163==
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Brian Norris <computersforpeace@gmail.com> writes:
> Hi Felipe,
>
> First of all, this is only a quick response. I could easily be missing
> something obvious.
>
> On Thu, Oct 22, 2015 at 02:01:02PM -0500, Felipe Balbi wrote:
>>=20
>> Hi,
>>=20
>> I just noticed that commit 073db4a51ee4 (mtd: fix: avoid race condition
>> when accessing mtd->usecount) caused a regression at least when removing
>> m25p80. Wonder if you guys would know of a quick fix, other than
>> reverting $commit in HEAD (yes, that makes the problem go away, but
>> regresses on what $commit tried to fix, of course).
>>=20
>> More info about the regression follows, together with bisection log:
>
> Not all deadlocks alleged by lockdep are true deadlocks. Are you able to
> reproduce a real deadlock? (I know, it's not always easy to hit, so I'm
> not discounting this based on lack of evidence.)
>
> In particular, I think something like this warning was mentioned
> previously, and I looked into it a bit but didn't have the time to
> figure out for sure (and figure out how to squash the potential false
> positive). Hence, I'm responding now, even if I'm not 100% sure. More
> below.
>
>> # modprobe -r m25p80
>> [   53.419251]=20
>> [   53.420838] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [   53.427300] [ INFO: possible circular locking dependency detected ]
>> [   53.433865] 4.3.0-rc6 #96 Not tainted
>> [   53.437686] -------------------------------------------------------
>> [   53.444220] modprobe/372 is trying to acquire lock:
>> [   53.449320]  (&new->lock){+.+...}, at: [<c043fe4c>] del_mtd_blktrans_=
dev+0x80/0xdc
>> [   53.457271]=20
>> [   53.457271] but task is already holding lock:
>> [   53.463372]  (mtd_table_mutex){+.+.+.}, at: [<c0439994>] del_mtd_devi=
ce+0x18/0x100
>> [   53.471321]=20
>> [   53.471321] which lock already depends on the new lock.
>> [   53.471321]=20
>> [   53.479856]=20
>> [   53.479856] the existing dependency chain (in reverse order) is:
>> [   53.487660]=20
>> -> #1 (mtd_table_mutex){+.+.+.}:
>> [   53.492331]        [<c043fc5c>] blktrans_open+0x34/0x1a4
>> [   53.497879]        [<c01afce0>] __blkdev_get+0xc4/0x3b0
>> [   53.503364]        [<c01b0bb8>] blkdev_get+0x108/0x320
>> [   53.508743]        [<c01713c0>] do_dentry_open+0x218/0x314
>> [   53.514496]        [<c0180454>] path_openat+0x4c0/0xf9c
>> [   53.519959]        [<c0182044>] do_filp_open+0x5c/0xc0
>> [   53.525336]        [<c0172758>] do_sys_open+0xfc/0x1cc
>> [   53.530716]        [<c000f740>] ret_fast_syscall+0x0/0x1c
>> [   53.536375]=20
>> -> #0 (&new->lock){+.+...}:
>> [   53.540587]        [<c063f124>] mutex_lock_nested+0x38/0x3cc
>> [   53.546504]        [<c043fe4c>] del_mtd_blktrans_dev+0x80/0xdc
>> [   53.552606]        [<c043f164>] blktrans_notify_remove+0x7c/0x84
>> [   53.558891]        [<c04399f0>] del_mtd_device+0x74/0x100
>> [   53.564544]        [<c043c670>] del_mtd_partitions+0x80/0xc8
>> [   53.570451]        [<c0439aa0>] mtd_device_unregister+0x24/0x48
>> [   53.576637]        [<c046ce6c>] spi_drv_remove+0x1c/0x34
>> [   53.582207]        [<c03de0f0>] __device_release_driver+0x88/0x114
>> [   53.588663]        [<c03de19c>] device_release_driver+0x20/0x2c
>> [   53.594843]        [<c03dd9e8>] bus_remove_device+0xd8/0x108
>> [   53.600748]        [<c03dacc0>] device_del+0x10c/0x210
>> [   53.606127]        [<c03dadd0>] device_unregister+0xc/0x20
>> [   53.611849]        [<c046d878>] __unregister+0x10/0x20
>> [   53.617211]        [<c03da868>] device_for_each_child+0x50/0x7c
>> [   53.623387]        [<c046eae8>] spi_unregister_master+0x58/0x8c
>> [   53.629578]        [<c03e12f0>] release_nodes+0x15c/0x1c8
>> [   53.635223]        [<c03de0f8>] __device_release_driver+0x90/0x114
>> [   53.641689]        [<c03de900>] driver_detach+0xb4/0xb8
>> [   53.647147]        [<c03ddc78>] bus_remove_driver+0x4c/0xa0
>> [   53.652970]        [<c00cab50>] SyS_delete_module+0x11c/0x1e4
>> [   53.658976]        [<c000f740>] ret_fast_syscall+0x0/0x1c
>
> Actually, the more I look at this, the more I think the warning is
> probably correct. I might have been thinking of a different false
> positive.
>
> Tentatively: I think the right fix might be to reverse the ordering of
> acquire/release of the mtd_table_mutex and dev->lock throughout
> mtd_blkdevs.c. See below.
>
>> [   53.664621]=20
>> [   53.664621] other info that might help us debug this:
>> [   53.664621]=20
>> [   53.672979]  Possible unsafe locking scenario:
>> [   53.672979]=20
>> [   53.679169]        CPU0                    CPU1
>> [   53.683900]        ----                    ----
>> [   53.688633]   lock(mtd_table_mutex);
>> [   53.692383]                                lock(&new->lock);
>> [   53.698306]                                lock(mtd_table_mutex);
>> [   53.704658]   lock(&new->lock);
>> [   53.707946]=20
>> [   53.707946]  *** DEADLOCK ***
>> [   53.707946]=20
>> [   53.714123] 5 locks held by modprobe/372:
>> [   53.718305]  #0:  (&dev->mutex){......}, at: [<c03de890>] driver_deta=
ch+0x44/0xb8
>> [   53.726147]  #1:  (&dev->mutex){......}, at: [<c03de89c>] driver_deta=
ch+0x50/0xb8
>> [   53.733985]  #2:  (&dev->mutex){......}, at: [<c03de194>] device_rele=
ase_driver+0x18/0x2c
>> [   53.742541]  #3:  (mtd_partitions_mutex){+.+.+.}, at: [<c043c60c>] de=
l_mtd_partitions+0x1c/0xc8
>> [   53.751656]  #4:  (mtd_table_mutex){+.+.+.}, at: [<c0439994>] del_mtd=
_device+0x18/0x100
>> [   53.760048]=20
>> [   53.760048] stack backtrace:
>> [   53.764591] CPU: 0 PID: 372 Comm: modprobe Not tainted 4.3.0-rc6 #96
>> [   53.771217] Hardware name: Generic AM43 (Flattened Device Tree)
>> [   53.777419] [<c0017bcc>] (unwind_backtrace) from [<c0013f30>] (show_s=
tack+0x10/0x14)
>> [   53.785511] [<c0013f30>] (show_stack) from [<c0346be4>] (dump_stack+0=
x84/0x9c)
>> [   53.793063] [<c0346be4>] (dump_stack) from [<c0090000>] (print_circul=
ar_bug+0x1c8/0x30c)
>> [   53.801500] [<c0090000>] (print_circular_bug) from [<c0093828>] (__lo=
ck_acquire+0x1a48/0x1cd8)
>> [   53.810480] [<c0093828>] (__lock_acquire) from [<c00943bc>] (lock_acq=
uire+0xac/0x12c)
>> [   53.818649] [<c00943bc>] (lock_acquire) from [<c063f124>] (mutex_lock=
_nested+0x38/0x3cc)
>> [   53.827103] [<c063f124>] (mutex_lock_nested) from [<c043fe4c>] (del_m=
td_blktrans_dev+0x80/0xdc)
>> [   53.836199] [<c043fe4c>] (del_mtd_blktrans_dev) from [<c043f164>] (bl=
ktrans_notify_remove+0x7c/0x84)
>> [   53.845735] [<c043f164>] (blktrans_notify_remove) from [<c04399f0>] (=
del_mtd_device+0x74/0x100)
>> [   53.854833] [<c04399f0>] (del_mtd_device) from [<c043c670>] (del_mtd_=
partitions+0x80/0xc8)
>> [   53.863469] [<c043c670>] (del_mtd_partitions) from [<c0439aa0>] (mtd_=
device_unregister+0x24/0x48)
>> [   53.872733] [<c0439aa0>] (mtd_device_unregister) from [<c046ce6c>] (s=
pi_drv_remove+0x1c/0x34)
>> [   53.881633] [<c046ce6c>] (spi_drv_remove) from [<c03de0f0>] (__device=
_release_driver+0x88/0x114)
>> [   53.890788] [<c03de0f0>] (__device_release_driver) from [<c03de19c>] =
(device_release_driver+0x20/0x2c)
>> [   53.900483] [<c03de19c>] (device_release_driver) from [<c03dd9e8>] (b=
us_remove_device+0xd8/0x108)
>> [   53.909735] [<c03dd9e8>] (bus_remove_device) from [<c03dacc0>] (devic=
e_del+0x10c/0x210)
>> [   53.918088] [<c03dacc0>] (device_del) from [<c03dadd0>] (device_unreg=
ister+0xc/0x20)
>> [   53.926160] [<c03dadd0>] (device_unregister) from [<c046d878>] (__unr=
egister+0x10/0x20)
>> [   53.934526] [<c046d878>] (__unregister) from [<c03da868>] (device_for=
_each_child+0x50/0x7c)
>> [   53.943261] [<c03da868>] (device_for_each_child) from [<c046eae8>] (s=
pi_unregister_master+0x58/0x8c)
>> [   53.952805] [<c046eae8>] (spi_unregister_master) from [<c03e12f0>] (r=
elease_nodes+0x15c/0x1c8)
>> [   53.961809] [<c03e12f0>] (release_nodes) from [<c03de0f8>] (__device_=
release_driver+0x90/0x114)
>> [   53.970883] [<c03de0f8>] (__device_release_driver) from [<c03de900>] =
(driver_detach+0xb4/0xb8)
>> [   53.979864] [<c03de900>] (driver_detach) from [<c03ddc78>] (bus_remov=
e_driver+0x4c/0xa0)
>> [   53.988303] [<c03ddc78>] (bus_remove_driver) from [<c00cab50>] (SyS_d=
elete_module+0x11c/0x1e4)
>> [   53.997285] [<c00cab50>] (SyS_delete_module) from [<c000f740>] (ret_f=
ast_syscall+0x0/0x1c)
>
> [...]
>
> Maybe this works? Not tested (not even compile tested). If so, then
> shame on me; I really don't even know why I picked the lock ordering I
> did in commit 073db4a51ee4 :(
>
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>

yeah, this sorts it out :-) tks, patch should be backported to v4.2 btw.

Tested-by: Felipe Balbi <balbi@ti.com>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKUKcAAoJEIaOsuA1yqREN/AQALDd5Ln1gQIAZeHuRz93NsQj
1F0J+wLeYVLx0sA/5uhSMmPZjX9qgJ3g/YdpJyK3XrjDoOOjlGi6sRZa94Yh8kKw
STOZLUnaPpZbSfFPYx8PWOYEN1GRpFKnaMa9SiUr4GVhzvIuMWzC663k8++U96K1
Jx1bCkwMjoHwqh/4xw72aYScCADfPIEnQnIhsECsH5keLDYi7Wo26jcUtqveFX7E
7LHWEuPWpULdo0SQL/KcRfdcD2cZvzOpwkzzR/3qce42zPz6MAS8uMoBqRvCE5fY
rJXVOVUMY4jkm0HTrYUvWwe6ye0nh/JNi2RfsNdX2ijnaPXGQrzU9QXVvkwpCTnX
aNu+NzHHS0h4tdXRysQi2xw0J/eaq1EhNYuHYtIRSCv4NiwvtXYC1yMJpea8GYoK
nMWuK0HFnrKHhL9hxEZn2jcOMfmBpUg5I/peaXTK3Fo6ymIBDiJExfCBiTJoxA6B
RKCTj+z6j3scIvDWzYeHUcxlZ5DTWOLF6cC08qCFs9RJ8dQil9H0ULH2dj+QTUOa
RneiJ09gkbBxEISxMJWisYXGgDbvfAnk6A66edibg7ka56t/AdB49ewAwSGbPeWU
zodReG3wLf+F5Z2DyENht2JBkk+U//mXrEztVka6P7R5FomC/J2nnU/I1/WdvOZN
s48uojdK6cYGvmvaqU1v
=zLpI
-----END PGP SIGNATURE-----
--=-=-=--


--===============1879618677280434163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============1879618677280434163==--
