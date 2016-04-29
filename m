From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] spi: omap2-mcspi: Use dma_request_chan() for requesting DMA channel
Date: Fri, 29 Apr 2016 16:11:56 +0300
Message-ID: <1461935516-28812-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

With the new dma_request_chan() the client driver does not need to look for
the DMA resource and it does not need to pass filter_fn anymore.
By switching to the new API the driver can now support deferred probing
against DMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
CC: Mark Brown <broonie@kernel.org>
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
