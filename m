From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 01/11] spi: Provide core support for runtime PM during transfers
Date: Sun, 28 Jul 2013 15:43:16 +0100
Message-ID: <1375022606-7576-1-git-send-email-broonie@kernel.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: linux-omap@vger.kernel.org

From: Mark Brown <broonie@linaro.org>

Most SPI drivers that implement runtime PM support use identical code to
do so: they acquire a runtime PM lock in prepare_transfer_hardware() and
then they release it in unprepare_transfer_hardware(). The variations in
this are mostly missing error checking and the choice to use autosuspend.

Since these runtime PM calls are normally the only thing in the prepare
and unprepare callbacks and the autosuspend API transparently does the
right thing on devices with autosuspend disabled factor all of this out
into the core with a flag to enable the behaviour.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/spi/spi.c       | 16 ++++++++++++++++
 include/linux/spi/spi.h |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 46c3f56..61f71b9 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -553,6 +553,10 @@ static void spi_pump_messages(struct kthread_work *work)
 		    master->unprepare_transfer_hardware(master))
 			dev_err(&master->dev,
 				"failed to unprepare transfer hardware\n");
+		if (master->auto_runtime_pm) {
+			pm_runtime_mark_last_busy(master->dev.parent);
+			pm_runtime_put_autosuspend(master->dev.parent);
+		}
 		return;
 	}
 
@@ -572,11 +576,23 @@ static void spi_pump_messages(struct kthread_work *work)
 		master->busy = true;
 	spin_unlock_irqrestore(&master->queue_lock, flags);
 
+	if (!was_busy && master->auto_runtime_pm) {
+		ret = pm_runtime_get_sync(master->dev.parent);
+		if (ret < 0) {
+			dev_err(&master->dev, "Failed to power device: %d\n",
+				ret);
+			return;
+		}
+	}
+
 	if (!was_busy && master->prepare_transfer_hardware) {
 		ret = master->prepare_transfer_hardware(master);
 		if (ret) {
 			dev_err(&master->dev,
 				"failed to prepare transfer hardware\n");
+
+			if (master->auto_runtime_pm)
+				pm_runtime_put(master->dev.parent);
 			return;
 		}
 	}
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index be40c97..d73059a 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -256,6 +256,8 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  * @busy: message pump is busy
  * @running: message pump is running
  * @rt: whether this queue is set to run as a realtime task
+ * @auto_runtime_pm: the core should ensure a runtime PM reference is held
+ *                   while the hardware is prepared
  * @prepare_transfer_hardware: a message will soon arrive from the queue
  *	so the subsystem requests the driver to prepare the transfer hardware
  *	by issuing this call
@@ -380,11 +382,13 @@ struct spi_master {
 	bool				busy;
 	bool				running;
 	bool				rt;
+	bool				auto_runtime_pm;
 
 	int (*prepare_transfer_hardware)(struct spi_master *master);
 	int (*transfer_one_message)(struct spi_master *master,
 				    struct spi_message *mesg);
 	int (*unprepare_transfer_hardware)(struct spi_master *master);
+
 	/* gpio chip select */
 	int			*cs_gpios;
 };
-- 
1.8.3.2
