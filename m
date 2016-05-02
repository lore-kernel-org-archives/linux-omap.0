From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: omap2-mcspi: Use dma_request_chan() for requesting DMA channel" to the spi tree
Date: Mon, 02 May 2016 12:04:01 +0100
Message-ID: <E1axBdx-0001lH-6Z@debutante>
References: <1461935516-28812-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461935516-28812-1-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The patch

   spi: omap2-mcspi: Use dma_request_chan() for requesting DMA channel

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From b085c6129a8cabdad9c625fae56d9d3f2977808e Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Date: Fri, 29 Apr 2016 16:11:56 +0300
Subject: [PATCH] spi: omap2-mcspi: Use dma_request_chan() for requesting DMA
 channel

With the new dma_request_chan() the client driver does not need to look for
the DMA resource and it does not need to pass filter_fn anymore.
By switching to the new API the driver can now support deferred probing
against DMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c | 83 ++++++++++---------------------------------
 1 file changed, 18 insertions(+), 65 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 0caa3c8bef46..1d237e93a289 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -23,7 +23,6 @@
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
-#include <linux/omap-dma.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/err.h>
@@ -103,9 +102,6 @@ struct omap2_mcspi_dma {
 	struct dma_chan *dma_tx;
 	struct dma_chan *dma_rx;
 
-	int dma_tx_sync_dev;
-	int dma_rx_sync_dev;
-
 	struct completion dma_tx_completion;
 	struct completion dma_rx_completion;
 
@@ -964,8 +960,7 @@ static int omap2_mcspi_request_dma(struct spi_device *spi)
 	struct spi_master	*master = spi->master;
 	struct omap2_mcspi	*mcspi;
 	struct omap2_mcspi_dma	*mcspi_dma;
-	dma_cap_mask_t mask;
-	unsigned sig;
+	int ret = 0;
 
 	mcspi = spi_master_get_devdata(master);
 	mcspi_dma = mcspi->dma_channels + spi->chip_select;
@@ -973,34 +968,25 @@ static int omap2_mcspi_request_dma(struct spi_device *spi)
 	init_completion(&mcspi_dma->dma_rx_completion);
 	init_completion(&mcspi_dma->dma_tx_completion);
 
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-	sig = mcspi_dma->dma_rx_sync_dev;
-
-	mcspi_dma->dma_rx =
-		dma_request_slave_channel_compat(mask, omap_dma_filter_fn,
-						 &sig, &master->dev,
-						 mcspi_dma->dma_rx_ch_name);
-	if (!mcspi_dma->dma_rx)
+	mcspi_dma->dma_rx = dma_request_chan(&master->dev,
+					     mcspi_dma->dma_rx_ch_name);
+	if (IS_ERR(mcspi_dma->dma_rx)) {
+		ret = PTR_ERR(mcspi_dma->dma_rx);
+		mcspi_dma->dma_rx = NULL;
 		goto no_dma;
+	}
 
-	sig = mcspi_dma->dma_tx_sync_dev;
-	mcspi_dma->dma_tx =
-		dma_request_slave_channel_compat(mask, omap_dma_filter_fn,
-						 &sig, &master->dev,
-						 mcspi_dma->dma_tx_ch_name);
-
-	if (!mcspi_dma->dma_tx) {
+	mcspi_dma->dma_tx = dma_request_chan(&master->dev,
+					     mcspi_dma->dma_tx_ch_name);
+	if (IS_ERR(mcspi_dma->dma_tx)) {
+		ret = PTR_ERR(mcspi_dma->dma_tx);
+		mcspi_dma->dma_tx = NULL;
 		dma_release_channel(mcspi_dma->dma_rx);
 		mcspi_dma->dma_rx = NULL;
-		goto no_dma;
 	}
 
-	return 0;
-
 no_dma:
-	dev_warn(&spi->dev, "not using DMA for McSPI\n");
-	return -EAGAIN;
+	return ret;
 }
 
 static int omap2_mcspi_setup(struct spi_device *spi)
@@ -1039,8 +1025,9 @@ static int omap2_mcspi_setup(struct spi_device *spi)
 
 	if (!mcspi_dma->dma_rx || !mcspi_dma->dma_tx) {
 		ret = omap2_mcspi_request_dma(spi);
-		if (ret < 0 && ret != -EAGAIN)
-			return ret;
+		if (ret)
+			dev_warn(&spi->dev, "not using DMA for McSPI (%d)\n",
+				 ret);
 	}
 
 	ret = pm_runtime_get_sync(mcspi->dev);
@@ -1434,42 +1421,8 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	}
 
 	for (i = 0; i < master->num_chipselect; i++) {
-		char *dma_rx_ch_name = mcspi->dma_channels[i].dma_rx_ch_name;
-		char *dma_tx_ch_name = mcspi->dma_channels[i].dma_tx_ch_name;
-		struct resource *dma_res;
-
-		sprintf(dma_rx_ch_name, "rx%d", i);
-		if (!pdev->dev.of_node) {
-			dma_res =
-				platform_get_resource_byname(pdev,
-							     IORESOURCE_DMA,
-							     dma_rx_ch_name);
-			if (!dma_res) {
-				dev_dbg(&pdev->dev,
-					"cannot get DMA RX channel\n");
-				status = -ENODEV;
-				break;
-			}
-
-			mcspi->dma_channels[i].dma_rx_sync_dev =
-				dma_res->start;
-		}
-		sprintf(dma_tx_ch_name, "tx%d", i);
-		if (!pdev->dev.of_node) {
-			dma_res =
-				platform_get_resource_byname(pdev,
-							     IORESOURCE_DMA,
-							     dma_tx_ch_name);
-			if (!dma_res) {
-				dev_dbg(&pdev->dev,
-					"cannot get DMA TX channel\n");
-				status = -ENODEV;
-				break;
-			}
-
-			mcspi->dma_channels[i].dma_tx_sync_dev =
-				dma_res->start;
-		}
+		sprintf(mcspi->dma_channels[i].dma_rx_ch_name, "rx%d", i);
+		sprintf(mcspi->dma_channels[i].dma_tx_ch_name, "tx%d", i);
 	}
 
 	if (status < 0)
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
