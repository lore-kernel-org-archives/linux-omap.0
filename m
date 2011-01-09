From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 26/30] mmc: update workqueue usages
Date: Sun, 9 Jan 2011 02:30:59 +0000
Message-ID: <20110109023058.GA17232@void.printf.net>
References: <1292086307-19211-27-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36909 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750849Ab1AICbJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 8 Jan 2011 21:31:09 -0500
Content-Disposition: inline
In-Reply-To: <1292086307-19211-27-git-send-email-tj@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: linux-omap@vger.kernel.org

Hi linux-omap folks,

I'd like to merge this patch via the MMC tree; please review/ACK.

Thanks,

- Chris.

From: Tejun Heo <tj@kernel.org>

Workqueue creation API has been updated and flush_scheduled_work() is
deprecated and scheduled to be removed.

* core/core.c: Use alloc_ordered_workqueue() instead of
  create_singlethread_workqueue().  This removes an unnecessary
  rescuer.

* host/omap.c: Create, use and flush mmc_omap_wq instead of the
  system_wq.

* Flush host->mmc_carddetect_work directly on removal instead of using
  flush_scheduled_work().

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org
---
This is part of a series to remove flush_scheduled_work() usage to
prepare for deprecation of flush_scheduled_work().  Patches in this
series are self contained and mostly straight-forward.

Please feel free to take it into the appropriate tree, or just ack it.
In the latter case, I'll merge the patch through the workqueue tree
during the next merge window.

If you're seeing this patch for the second time, it's because the
commit hasn't showed up in mainline yet.  Please let me know what
should be done.

Thank you.

 drivers/mmc/core/core.c       |    2 +-
 drivers/mmc/host/omap.c       |   24 ++++++++++++++++++------
 drivers/mmc/host/omap_hsmmc.c |    2 +-
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 31ae07a..c76f492 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1789,7 +1789,7 @@ static int __init mmc_init(void)
 {
 	int ret;
 
-	workqueue = create_singlethread_workqueue("kmmcd");
+	workqueue = alloc_ordered_workqueue("kmmcd", 0);
 	if (!workqueue)
 		return -ENOMEM;
 
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 0c7e37f..379d2ff 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -173,6 +173,8 @@ struct mmc_omap_host {
 	struct omap_mmc_platform_data *pdata;
 };
 
+static struct workqueue_struct *mmc_omap_wq;
+
 static void mmc_omap_fclk_offdelay(struct mmc_omap_slot *slot)
 {
 	unsigned long tick_ns;
@@ -289,7 +291,7 @@ static void mmc_omap_release_slot(struct mmc_omap_slot *slot, int clk_enabled)
 		host->next_slot = new_slot;
 		host->mmc = new_slot->mmc;
 		spin_unlock_irqrestore(&host->slot_lock, flags);
-		schedule_work(&host->slot_release_work);
+		queue_work(mmc_omap_wq, &host->slot_release_work);
 		return;
 	}
 
@@ -457,7 +459,7 @@ mmc_omap_xfer_done(struct mmc_omap_host *host, struct mmc_data *data)
 	}
 
 	host->stop_data = data;
-	schedule_work(&host->send_stop_work);
+	queue_work(mmc_omap_wq, &host->send_stop_work);
 }
 
 static void
@@ -637,7 +639,7 @@ mmc_omap_cmd_timer(unsigned long data)
 		OMAP_MMC_WRITE(host, IE, 0);
 		disable_irq(host->irq);
 		host->abort = 1;
-		schedule_work(&host->cmd_abort_work);
+		queue_work(mmc_omap_wq, &host->cmd_abort_work);
 	}
 	spin_unlock_irqrestore(&host->slot_lock, flags);
 }
@@ -826,7 +828,7 @@ static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
 		host->abort = 1;
 		OMAP_MMC_WRITE(host, IE, 0);
 		disable_irq_nosync(host->irq);
-		schedule_work(&host->cmd_abort_work);
+		queue_work(mmc_omap_wq, &host->cmd_abort_work);
 		return IRQ_HANDLED;
 	}
 
@@ -1387,7 +1389,7 @@ static void mmc_omap_remove_slot(struct mmc_omap_slot *slot)
 
 	tasklet_kill(&slot->cover_tasklet);
 	del_timer_sync(&slot->cover_timer);
-	flush_scheduled_work();
+	flush_workqueue(mmc_omap_wq);
 
 	mmc_remove_host(mmc);
 	mmc_free_host(mmc);
@@ -1608,12 +1610,22 @@ static struct platform_driver mmc_omap_driver = {
 
 static int __init mmc_omap_init(void)
 {
-	return platform_driver_probe(&mmc_omap_driver, mmc_omap_probe);
+	int ret;
+
+	mmc_omap_wq = alloc_workqueue("mmc_omap", 0, 0);
+	if (!mmc_omap_wq)
+		return -ENOMEM;
+
+	ret = platform_driver_probe(&mmc_omap_driver, mmc_omap_probe);
+	if (ret)
+		destroy_workqueue(mmc_omap_wq);
+	return ret;
 }
 
 static void __exit mmc_omap_exit(void)
 {
 	platform_driver_unregister(&mmc_omap_driver);
+	destroy_workqueue(mmc_omap_wq);
 }
 
 module_init(mmc_omap_init);
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 5d46021..078fdf1 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2290,7 +2290,7 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 		free_irq(host->irq, host);
 		if (mmc_slot(host).card_detect_irq)
 			free_irq(mmc_slot(host).card_detect_irq, host);
-		flush_scheduled_work();
+		flush_work_sync(&host->mmc_carddetect_work);
 
 		mmc_host_disable(host->mmc);
 		clk_disable(host->iclk);
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
