From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: Regression caused by 073db4a51ee43ccb827f54a4261c0583b028d5ab
Date: Thu, 22 Oct 2015 12:38:53 -0700
Message-ID: <20151022193853.GH13239@google.com>
References: <87y4euenip.fsf@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
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
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

First of all, this is only a quick response. I could easily be missing
something obvious.

On Thu, Oct 22, 2015 at 02:01:02PM -0500, Felipe Balbi wrote:
> 
> Hi,
> 
> I just noticed that commit 073db4a51ee4 (mtd: fix: avoid race condition
> when accessing mtd->usecount) caused a regression at least when removing
> m25p80. Wonder if you guys would know of a quick fix, other than
> reverting $commit in HEAD (yes, that makes the problem go away, but
> regresses on what $commit tried to fix, of course).
> 
> More info about the regression follows, together with bisection log:

Not all deadlocks alleged by lockdep are true deadlocks. Are you able to
reproduce a real deadlock? (I know, it's not always easy to hit, so I'm
not discounting this based on lack of evidence.)

In particular, I think something like this warning was mentioned
previously, and I looked into it a bit but didn't have the time to
figure out for sure (and figure out how to squash the potential false
positive). Hence, I'm responding now, even if I'm not 100% sure. More
below.

> # modprobe -r m25p80
> [   53.419251] 
> [   53.420838] ======================================================
> [   53.427300] [ INFO: possible circular locking dependency detected ]
> [   53.433865] 4.3.0-rc6 #96 Not tainted
> [   53.437686] -------------------------------------------------------
> [   53.444220] modprobe/372 is trying to acquire lock:
> [   53.449320]  (&new->lock){+.+...}, at: [<c043fe4c>] del_mtd_blktrans_dev+0x80/0xdc
> [   53.457271] 
> [   53.457271] but task is already holding lock:
> [   53.463372]  (mtd_table_mutex){+.+.+.}, at: [<c0439994>] del_mtd_device+0x18/0x100
> [   53.471321] 
> [   53.471321] which lock already depends on the new lock.
> [   53.471321] 
> [   53.479856] 
> [   53.479856] the existing dependency chain (in reverse order) is:
> [   53.487660] 
> -> #1 (mtd_table_mutex){+.+.+.}:
> [   53.492331]        [<c043fc5c>] blktrans_open+0x34/0x1a4
> [   53.497879]        [<c01afce0>] __blkdev_get+0xc4/0x3b0
> [   53.503364]        [<c01b0bb8>] blkdev_get+0x108/0x320
> [   53.508743]        [<c01713c0>] do_dentry_open+0x218/0x314
> [   53.514496]        [<c0180454>] path_openat+0x4c0/0xf9c
> [   53.519959]        [<c0182044>] do_filp_open+0x5c/0xc0
> [   53.525336]        [<c0172758>] do_sys_open+0xfc/0x1cc
> [   53.530716]        [<c000f740>] ret_fast_syscall+0x0/0x1c
> [   53.536375] 
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

Actually, the more I look at this, the more I think the warning is
probably correct. I might have been thinking of a different false
positive.

Tentatively: I think the right fix might be to reverse the ordering of
acquire/release of the mtd_table_mutex and dev->lock throughout
mtd_blkdevs.c. See below.

> [   53.664621] 
> [   53.664621] other info that might help us debug this:
> [   53.664621] 
> [   53.672979]  Possible unsafe locking scenario:
> [   53.672979] 
> [   53.679169]        CPU0                    CPU1
> [   53.683900]        ----                    ----
> [   53.688633]   lock(mtd_table_mutex);
> [   53.692383]                                lock(&new->lock);
> [   53.698306]                                lock(mtd_table_mutex);
> [   53.704658]   lock(&new->lock);
> [   53.707946] 
> [   53.707946]  *** DEADLOCK ***
> [   53.707946] 
> [   53.714123] 5 locks held by modprobe/372:
> [   53.718305]  #0:  (&dev->mutex){......}, at: [<c03de890>] driver_detach+0x44/0xb8
> [   53.726147]  #1:  (&dev->mutex){......}, at: [<c03de89c>] driver_detach+0x50/0xb8
> [   53.733985]  #2:  (&dev->mutex){......}, at: [<c03de194>] device_release_driver+0x18/0x2c
> [   53.742541]  #3:  (mtd_partitions_mutex){+.+.+.}, at: [<c043c60c>] del_mtd_partitions+0x1c/0xc8
> [   53.751656]  #4:  (mtd_table_mutex){+.+.+.}, at: [<c0439994>] del_mtd_device+0x18/0x100
> [   53.760048] 
> [   53.760048] stack backtrace:
> [   53.764591] CPU: 0 PID: 372 Comm: modprobe Not tainted 4.3.0-rc6 #96
> [   53.771217] Hardware name: Generic AM43 (Flattened Device Tree)
> [   53.777419] [<c0017bcc>] (unwind_backtrace) from [<c0013f30>] (show_stack+0x10/0x14)
> [   53.785511] [<c0013f30>] (show_stack) from [<c0346be4>] (dump_stack+0x84/0x9c)
> [   53.793063] [<c0346be4>] (dump_stack) from [<c0090000>] (print_circular_bug+0x1c8/0x30c)
> [   53.801500] [<c0090000>] (print_circular_bug) from [<c0093828>] (__lock_acquire+0x1a48/0x1cd8)
> [   53.810480] [<c0093828>] (__lock_acquire) from [<c00943bc>] (lock_acquire+0xac/0x12c)
> [   53.818649] [<c00943bc>] (lock_acquire) from [<c063f124>] (mutex_lock_nested+0x38/0x3cc)
> [   53.827103] [<c063f124>] (mutex_lock_nested) from [<c043fe4c>] (del_mtd_blktrans_dev+0x80/0xdc)
> [   53.836199] [<c043fe4c>] (del_mtd_blktrans_dev) from [<c043f164>] (blktrans_notify_remove+0x7c/0x84)
> [   53.845735] [<c043f164>] (blktrans_notify_remove) from [<c04399f0>] (del_mtd_device+0x74/0x100)
> [   53.854833] [<c04399f0>] (del_mtd_device) from [<c043c670>] (del_mtd_partitions+0x80/0xc8)
> [   53.863469] [<c043c670>] (del_mtd_partitions) from [<c0439aa0>] (mtd_device_unregister+0x24/0x48)
> [   53.872733] [<c0439aa0>] (mtd_device_unregister) from [<c046ce6c>] (spi_drv_remove+0x1c/0x34)
> [   53.881633] [<c046ce6c>] (spi_drv_remove) from [<c03de0f0>] (__device_release_driver+0x88/0x114)
> [   53.890788] [<c03de0f0>] (__device_release_driver) from [<c03de19c>] (device_release_driver+0x20/0x2c)
> [   53.900483] [<c03de19c>] (device_release_driver) from [<c03dd9e8>] (bus_remove_device+0xd8/0x108)
> [   53.909735] [<c03dd9e8>] (bus_remove_device) from [<c03dacc0>] (device_del+0x10c/0x210)
> [   53.918088] [<c03dacc0>] (device_del) from [<c03dadd0>] (device_unregister+0xc/0x20)
> [   53.926160] [<c03dadd0>] (device_unregister) from [<c046d878>] (__unregister+0x10/0x20)
> [   53.934526] [<c046d878>] (__unregister) from [<c03da868>] (device_for_each_child+0x50/0x7c)
> [   53.943261] [<c03da868>] (device_for_each_child) from [<c046eae8>] (spi_unregister_master+0x58/0x8c)
> [   53.952805] [<c046eae8>] (spi_unregister_master) from [<c03e12f0>] (release_nodes+0x15c/0x1c8)
> [   53.961809] [<c03e12f0>] (release_nodes) from [<c03de0f8>] (__device_release_driver+0x90/0x114)
> [   53.970883] [<c03de0f8>] (__device_release_driver) from [<c03de900>] (driver_detach+0xb4/0xb8)
> [   53.979864] [<c03de900>] (driver_detach) from [<c03ddc78>] (bus_remove_driver+0x4c/0xa0)
> [   53.988303] [<c03ddc78>] (bus_remove_driver) from [<c00cab50>] (SyS_delete_module+0x11c/0x1e4)
> [   53.997285] [<c00cab50>] (SyS_delete_module) from [<c000f740>] (ret_fast_syscall+0x0/0x1c)

[...]

Maybe this works? Not tested (not even compile tested). If so, then
shame on me; I really don't even know why I picked the lock ordering I
did in commit 073db4a51ee4 :(

Signed-off-by: Brian Norris <computersforpeace@gmail.com>

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 44dc965a2f7c..e7a02ed9fba8 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -192,8 +192,8 @@ static int blktrans_open(struct block_device *bdev, fmode_t mode)
 	if (!dev)
 		return -ERESTARTSYS; /* FIXME: busy loop! -arnd*/
 
-	mutex_lock(&dev->lock);
 	mutex_lock(&mtd_table_mutex);
+	mutex_lock(&dev->lock);
 
 	if (dev->open)
 		goto unlock;
@@ -217,8 +217,8 @@ static int blktrans_open(struct block_device *bdev, fmode_t mode)
 
 unlock:
 	dev->open++;
-	mutex_unlock(&mtd_table_mutex);
 	mutex_unlock(&dev->lock);
+	mutex_unlock(&mtd_table_mutex);
 	blktrans_dev_put(dev);
 	return ret;
 
@@ -228,8 +228,8 @@ error_release:
 error_put:
 	module_put(dev->tr->owner);
 	kref_put(&dev->ref, blktrans_dev_release);
-	mutex_unlock(&mtd_table_mutex);
 	mutex_unlock(&dev->lock);
+	mutex_unlock(&mtd_table_mutex);
 	blktrans_dev_put(dev);
 	return ret;
 }
@@ -241,8 +241,8 @@ static void blktrans_release(struct gendisk *disk, fmode_t mode)
 	if (!dev)
 		return;
 
-	mutex_lock(&dev->lock);
 	mutex_lock(&mtd_table_mutex);
+	mutex_lock(&dev->lock);
 
 	if (--dev->open)
 		goto unlock;
@@ -256,8 +256,8 @@ static void blktrans_release(struct gendisk *disk, fmode_t mode)
 		__put_mtd_device(dev->mtd);
 	}
 unlock:
-	mutex_unlock(&mtd_table_mutex);
 	mutex_unlock(&dev->lock);
+	mutex_unlock(&mtd_table_mutex);
 	blktrans_dev_put(dev);
 }
 

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
