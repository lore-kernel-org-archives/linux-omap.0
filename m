From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 2/2] spi: spi-ti-qspi: Add DMA support for QSPI mmap read
Date: Tue, 5 Apr 2016 09:19:52 +0530
Message-ID: <1459828192-5531-3-git-send-email-vigneshr@ti.com>
References: <1459828192-5531-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459828192-5531-1-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

Use mem-to-mem DMA to read from flash when reading in mmap mode. This
gives improved read performance and reduces CPU load.

With this patch the raw-read throughput is ~16MB/s on DRA74 EVM. And CPU
load is <20%. UBIFS read ~13 MB/s.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/spi/spi-ti-qspi.c | 132 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 120 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index eac3c960b2de..1f6a11a45891 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -41,6 +41,8 @@ struct ti_qspi_regs {
 };
 
 struct ti_qspi {
+	struct completion	transfer_complete;
+
 	/* list synchronization */
 	struct mutex            list_lock;
 
@@ -54,6 +56,9 @@ struct ti_qspi {
 
 	struct ti_qspi_regs     ctx_reg;
 
+	dma_addr_t		mmap_phys_base;
+	struct dma_chan		*rx_chan;
+
 	u32 spi_max_frequency;
 	u32 cmd;
 	u32 dc;
@@ -377,6 +382,78 @@ static int qspi_transfer_msg(struct ti_qspi *qspi, struct spi_transfer *t)
 	return 0;
 }
 
+static void qspi_dma_callback(void *param)
+{
+	struct ti_qspi *qspi = param;
+
+	complete(&qspi->transfer_complete);
+}
+
+static int qspi_dma_transfer(struct ti_qspi *qspi, dma_addr_t dma_dst,
+			     dma_addr_t dma_src, size_t len)
+{
+	struct dma_chan *chan = qspi->rx_chan;
+	struct dma_device *dma_dev = chan->device;
+	dma_cookie_t cookie;
+	enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
+	struct dma_async_tx_descriptor *tx = NULL;
+	int ret;
+
+	tx = dma_dev->device_prep_dma_memcpy(chan, dma_dst, dma_src,
+					     len, flags);
+	if (!tx) {
+		dev_err(qspi->dev, "device_prep_dma_memcpy error\n");
+		ret = -EIO;
+		goto err;
+	}
+
+	tx->callback = qspi_dma_callback;
+	tx->callback_param = qspi;
+	cookie = tx->tx_submit(tx);
+
+	ret = dma_submit_error(cookie);
+	if (ret) {
+		dev_err(qspi->dev, "dma_submit_error %d\n", cookie);
+		goto err;
+	}
+
+	dma_async_issue_pending(chan);
+	ret = wait_for_completion_timeout(&qspi->transfer_complete,
+					  msecs_to_jiffies(len));
+	if (ret <= 0) {
+		dmaengine_terminate_all(chan);
+		dev_err(qspi->dev, "DMA wait_for_completion_timeout\n");
+		if (!ret)
+			ret = -ETIMEDOUT;
+		goto err;
+	}
+
+	ret = 0;
+
+err:
+	return ret;
+}
+
+static int qspi_dma_sg(struct ti_qspi *qspi,
+		       struct spi_flash_read_message *msg)
+{
+	struct scatterlist *sg;
+	dma_addr_t dma_src = qspi->mmap_phys_base + msg->from;
+	dma_addr_t dma_dst;
+	int i, len, ret = 0;
+
+	for_each_sg(msg->rx_sg.sgl, sg, msg->rx_sg.nents, i) {
+		dma_dst = sg_dma_address(sg);
+		len = sg_dma_len(sg);
+		ret = qspi_dma_transfer(qspi, dma_dst, dma_src, len);
+		if (ret != 0)
+			return ret;
+		dma_src += len;
+	}
+
+	return ret;
+}
+
 static void ti_qspi_enable_memory_map(struct spi_device *spi)
 {
 	struct ti_qspi  *qspi = spi_master_get_devdata(spi->master);
@@ -435,9 +512,17 @@ static int ti_qspi_spi_flash_read(struct  spi_device *spi,
 	if (!qspi->mmap_enabled)
 		ti_qspi_enable_memory_map(spi);
 	ti_qspi_setup_mmap_read(spi, msg);
-	memcpy_fromio(msg->buf, qspi->mmap_base + msg->from, msg->len);
+
+	if (qspi->rx_chan) {
+		ret = qspi_dma_sg(qspi, msg);
+		if (ret != 0)
+			goto err;
+	} else {
+		memcpy_fromio(msg->buf, qspi->mmap_base + msg->from, msg->len);
+	}
 	msg->retlen = msg->len;
 
+err:
 	mutex_unlock(&qspi->list_lock);
 
 	return ret;
@@ -525,6 +610,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	u32 max_freq;
 	int ret = 0, num_cs, irq;
+	dma_cap_mask_t mask;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*qspi));
 	if (!master)
@@ -539,6 +625,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	master->dev.of_node = pdev->dev.of_node;
 	master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(16) |
 				     SPI_BPW_MASK(8);
+	master->spi_flash_read = ti_qspi_spi_flash_read;
 
 	if (!of_property_read_u32(np, "num-cs", &num_cs))
 		master->num_chipselect = num_cs;
@@ -581,17 +668,6 @@ static int ti_qspi_probe(struct platform_device *pdev)
 		goto free_master;
 	}
 
-	if (res_mmap) {
-		qspi->mmap_base = devm_ioremap_resource(&pdev->dev,
-							res_mmap);
-		master->spi_flash_read = ti_qspi_spi_flash_read;
-		if (IS_ERR(qspi->mmap_base)) {
-			dev_err(&pdev->dev,
-				"falling back to PIO mode\n");
-			master->spi_flash_read = NULL;
-		}
-	}
-	qspi->mmap_enabled = false;
 
 	if (of_property_read_bool(np, "syscon-chipselects")) {
 		qspi->ctrl_base =
@@ -626,6 +702,33 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_master;
 
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_MEMCPY, mask);
+
+	qspi->rx_chan = dma_request_channel(mask, NULL, NULL);
+	if (!qspi->rx_chan) {
+		dev_err(qspi->dev,
+			"No Rx DMA available, trying mmap mode\n");
+		ret = 0;
+		goto no_dma;
+	}
+	master->dma_rx = qspi->rx_chan;
+	init_completion(&qspi->transfer_complete);
+	if (res_mmap)
+		qspi->mmap_phys_base = (dma_addr_t)res_mmap->start;
+
+no_dma:
+	if (!qspi->rx_chan && res_mmap) {
+		qspi->mmap_base = devm_ioremap_resource(&pdev->dev, res_mmap);
+		if (IS_ERR(qspi->mmap_base)) {
+			dev_info(&pdev->dev,
+				 "mmap failed with error %ld using PIO mode\n",
+				 PTR_ERR(qspi->mmap_base));
+			qspi->mmap_base = NULL;
+			master->spi_flash_read = NULL;
+		}
+	}
+	qspi->mmap_enabled = false;
 	return 0;
 
 free_master:
@@ -635,9 +738,14 @@ free_master:
 
 static int ti_qspi_remove(struct platform_device *pdev)
 {
+	struct ti_qspi *qspi = platform_get_drvdata(pdev);
+
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
+	if (qspi->rx_chan)
+		dma_release_channel(qspi->rx_chan);
+
 	return 0;
 }
 
-- 
2.8.0
