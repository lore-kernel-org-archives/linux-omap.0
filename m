From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spi-omap2-mcspi: Support probe deferral for DMA channels" to the spi tree
Date: Thu,  6 Feb 2020 15:54:50 +0000 (GMT)
Message-ID: <applied-20200204124816.16735-3-vigneshr@ti.com>
References: <20200204124816.16735-3-vigneshr@ti.com>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200204124816.16735-3-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The patch

   spi: spi-omap2-mcspi: Support probe deferral for DMA channels

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.6

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 32f2fc5dc3992b4b60cc6b1a6a31be605cc9c3a2 Mon Sep 17 00:00:00 2001
From: Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>
Date: Tue, 4 Feb 2020 18:18:16 +0530
Subject: [PATCH] spi: spi-omap2-mcspi: Support probe deferral for DMA channels

dma_request_channel() can return -EPROBE_DEFER, if DMA driver is not
ready. Currently driver just falls back to PIO mode on probe deferral.
Fix this by requesting all required channels during probe and
propagating EPROBE_DEFER error code.

Signed-off-by: Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>
Link: https://lore.kernel.org/r/20200204124816.16735-3-vigneshr-l0cyMroinI0@public.gmane.org
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c | 77 +++++++++++++++++------------------
 1 file changed, 38 insertions(+), 39 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index e9bc9cf984d6..e9e256718ef4 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -975,20 +975,12 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
  * Note that we currently allow DMA only if we get a channel
  * for both rx and tx. Otherwise we'll do PIO for both rx and tx.
  */
-static int omap2_mcspi_request_dma(struct spi_device *spi)
+static int omap2_mcspi_request_dma(struct omap2_mcspi *mcspi,
+				   struct omap2_mcspi_dma *mcspi_dma)
 {
-	struct spi_master	*master = spi->master;
-	struct omap2_mcspi	*mcspi;
-	struct omap2_mcspi_dma	*mcspi_dma;
 	int ret = 0;
 
-	mcspi = spi_master_get_devdata(master);
-	mcspi_dma = mcspi->dma_channels + spi->chip_select;
-
-	init_completion(&mcspi_dma->dma_rx_completion);
-	init_completion(&mcspi_dma->dma_tx_completion);
-
-	mcspi_dma->dma_rx = dma_request_chan(&master->dev,
+	mcspi_dma->dma_rx = dma_request_chan(mcspi->dev,
 					     mcspi_dma->dma_rx_ch_name);
 	if (IS_ERR(mcspi_dma->dma_rx)) {
 		ret = PTR_ERR(mcspi_dma->dma_rx);
@@ -996,7 +988,7 @@ static int omap2_mcspi_request_dma(struct spi_device *spi)
 		goto no_dma;
 	}
 
-	mcspi_dma->dma_tx = dma_request_chan(&master->dev,
+	mcspi_dma->dma_tx = dma_request_chan(mcspi->dev,
 					     mcspi_dma->dma_tx_ch_name);
 	if (IS_ERR(mcspi_dma->dma_tx)) {
 		ret = PTR_ERR(mcspi_dma->dma_tx);
@@ -1005,20 +997,40 @@ static int omap2_mcspi_request_dma(struct spi_device *spi)
 		mcspi_dma->dma_rx = NULL;
 	}
 
+	init_completion(&mcspi_dma->dma_rx_completion);
+	init_completion(&mcspi_dma->dma_tx_completion);
+
 no_dma:
 	return ret;
 }
 
+static void omap2_mcspi_release_dma(struct spi_master *master)
+{
+	struct omap2_mcspi *mcspi = spi_master_get_devdata(master);
+	struct omap2_mcspi_dma	*mcspi_dma;
+	int i;
+
+	for (i = 0; i < master->num_chipselect; i++) {
+		mcspi_dma = &mcspi->dma_channels[i];
+
+		if (mcspi_dma->dma_rx) {
+			dma_release_channel(mcspi_dma->dma_rx);
+			mcspi_dma->dma_rx = NULL;
+		}
+		if (mcspi_dma->dma_tx) {
+			dma_release_channel(mcspi_dma->dma_tx);
+			mcspi_dma->dma_tx = NULL;
+		}
+	}
+}
+
 static int omap2_mcspi_setup(struct spi_device *spi)
 {
 	int			ret;
 	struct omap2_mcspi	*mcspi = spi_master_get_devdata(spi->master);
 	struct omap2_mcspi_regs	*ctx = &mcspi->ctx;
-	struct omap2_mcspi_dma	*mcspi_dma;
 	struct omap2_mcspi_cs	*cs = spi->controller_state;
 
-	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
-
 	if (!cs) {
 		cs = kzalloc(sizeof *cs, GFP_KERNEL);
 		if (!cs)
@@ -1043,13 +1055,6 @@ static int omap2_mcspi_setup(struct spi_device *spi)
 		}
 	}
 
-	if (!mcspi_dma->dma_rx || !mcspi_dma->dma_tx) {
-		ret = omap2_mcspi_request_dma(spi);
-		if (ret)
-			dev_warn(&spi->dev, "not using DMA for McSPI (%d)\n",
-				 ret);
-	}
-
 	ret = pm_runtime_get_sync(mcspi->dev);
 	if (ret < 0) {
 		pm_runtime_put_noidle(mcspi->dev);
@@ -1066,12 +1071,8 @@ static int omap2_mcspi_setup(struct spi_device *spi)
 
 static void omap2_mcspi_cleanup(struct spi_device *spi)
 {
-	struct omap2_mcspi	*mcspi;
-	struct omap2_mcspi_dma	*mcspi_dma;
 	struct omap2_mcspi_cs	*cs;
 
-	mcspi = spi_master_get_devdata(spi->master);
-
 	if (spi->controller_state) {
 		/* Unlink controller state from context save list */
 		cs = spi->controller_state;
@@ -1080,19 +1081,6 @@ static void omap2_mcspi_cleanup(struct spi_device *spi)
 		kfree(cs);
 	}
 
-	if (spi->chip_select < spi->master->num_chipselect) {
-		mcspi_dma = &mcspi->dma_channels[spi->chip_select];
-
-		if (mcspi_dma->dma_rx) {
-			dma_release_channel(mcspi_dma->dma_rx);
-			mcspi_dma->dma_rx = NULL;
-		}
-		if (mcspi_dma->dma_tx) {
-			dma_release_channel(mcspi_dma->dma_tx);
-			mcspi_dma->dma_tx = NULL;
-		}
-	}
-
 	if (gpio_is_valid(spi->cs_gpio))
 		gpio_free(spi->cs_gpio);
 }
@@ -1303,6 +1291,9 @@ static bool omap2_mcspi_can_dma(struct spi_master *master,
 	if (spi_controller_is_slave(master))
 		return true;
 
+	master->dma_rx = mcspi_dma->dma_rx;
+	master->dma_tx = mcspi_dma->dma_tx;
+
 	return (xfer->len >= DMA_MIN_BYTES);
 }
 
@@ -1490,6 +1481,11 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	for (i = 0; i < master->num_chipselect; i++) {
 		sprintf(mcspi->dma_channels[i].dma_rx_ch_name, "rx%d", i);
 		sprintf(mcspi->dma_channels[i].dma_tx_ch_name, "tx%d", i);
+
+		status = omap2_mcspi_request_dma(mcspi,
+						 &mcspi->dma_channels[i]);
+		if (status == -EPROBE_DEFER)
+			goto free_master;
 	}
 
 	status = platform_get_irq(pdev, 0);
@@ -1527,6 +1523,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 free_master:
+	omap2_mcspi_release_dma(master);
 	spi_master_put(master);
 	return status;
 }
@@ -1536,6 +1533,8 @@ static int omap2_mcspi_remove(struct platform_device *pdev)
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct omap2_mcspi *mcspi = spi_master_get_devdata(master);
 
+	omap2_mcspi_release_dma(master);
+
 	pm_runtime_dont_use_autosuspend(mcspi->dev);
 	pm_runtime_put_sync(mcspi->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.20.1
