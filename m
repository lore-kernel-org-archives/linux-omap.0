From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v5] spi: spi-ti-qspi: Add DMA support for QSPI mmap read
Date: Tue, 9 Aug 2016 16:33:11 +0530
Message-ID: <20160809110311.13521-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Use mem-to-mem DMA to read from flash when reading in mmap mode. This
gives improved read performance and reduces CPU load.

With this patch the raw-read throughput is ~16MB/s on DRA74 EVM. And CPU
load is <20%. UBIFS read ~13 MB/s.

Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
---

v5: Move setting up DMA channel to before driver registration.
v4: use dma_request_chan_by_mask() and fix build warnings.
v3: Cleanup code based on review comments for v2.
v2: Handle kmap'd buffers of JFFS2 FS

 drivers/spi/spi-ti-qspi.c | 195 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 178 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index ac0b072815a3..d9c51ee848ec 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -33,6 +33,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
+#include <linux/highmem.h>
 
 #include <linux/spi/spi.h>
 
@@ -41,6 +42,8 @@ struct ti_qspi_regs {
 };
 
 struct ti_qspi {
+	struct completion	transfer_complete;
+
 	/* list synchronization */
 	struct mutex            list_lock;
 
@@ -54,6 +57,9 @@ struct ti_qspi {
 
 	struct ti_qspi_regs     ctx_reg;
 
+	dma_addr_t		mmap_phys_base;
+	struct dma_chan		*rx_chan;
+
 	u32 spi_max_frequency;
 	u32 cmd;
 	u32 dc;
@@ -379,6 +385,72 @@ static int qspi_transfer_msg(struct ti_qspi *qspi, struct spi_transfer *t,
 	return 0;
 }
 
+static void ti_qspi_dma_callback(void *param)
+{
+	struct ti_qspi *qspi = param;
+
+	complete(&qspi->transfer_complete);
+}
+
+static int ti_qspi_dma_xfer(struct ti_qspi *qspi, dma_addr_t dma_dst,
+			    dma_addr_t dma_src, size_t len)
+{
+	struct dma_chan *chan = qspi->rx_chan;
+	struct dma_device *dma_dev = chan->device;
+	dma_cookie_t cookie;
+	enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
+	struct dma_async_tx_descriptor *tx;
+	int ret;
+
+	tx = dma_dev->device_prep_dma_memcpy(chan, dma_dst, dma_src,
+					     len, flags);
+	if (!tx) {
+		dev_err(qspi->dev, "device_prep_dma_memcpy error\n");
+		return -EIO;
+	}
+
+	tx->callback = ti_qspi_dma_callback;
+	tx->callback_param = qspi;
+	cookie = tx->tx_submit(tx);
+
+	ret = dma_submit_error(cookie);
+	if (ret) {
+		dev_err(qspi->dev, "dma_submit_error %d\n", cookie);
+		return -EIO;
+	}
+
+	dma_async_issue_pending(chan);
+	ret = wait_for_completion_timeout(&qspi->transfer_complete,
+					  msecs_to_jiffies(len));
+	if (ret <= 0) {
+		dmaengine_terminate_sync(chan);
+		dev_err(qspi->dev, "DMA wait_for_completion_timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int ti_qspi_dma_xfer_sg(struct ti_qspi *qspi, struct sg_table rx_sg,
+			       loff_t from)
+{
+	struct scatterlist *sg;
+	dma_addr_t dma_src = qspi->mmap_phys_base + from;
+	dma_addr_t dma_dst;
+	int i, len, ret;
+
+	for_each_sg(rx_sg.sgl, sg, rx_sg.nents, i) {
+		dma_dst = sg_dma_address(sg);
+		len = sg_dma_len(sg);
+		ret = ti_qspi_dma_xfer(qspi, dma_dst, dma_src, len);
+		if (ret)
+			return ret;
+		dma_src += len;
+	}
+
+	return 0;
+}
+
 static void ti_qspi_enable_memory_map(struct spi_device *spi)
 {
 	struct ti_qspi  *qspi = spi_master_get_devdata(spi->master);
@@ -426,7 +498,40 @@ static void ti_qspi_setup_mmap_read(struct spi_device *spi,
 		      QSPI_SPI_SETUP_REG(spi->chip_select));
 }
 
-static int ti_qspi_spi_flash_read(struct  spi_device *spi,
+#ifdef CONFIG_HIGHMEM
+static int ti_qspi_map_buf(struct ti_qspi *qspi, void *buf,
+			   unsigned int len, struct sg_table *sgt)
+{
+	unsigned int max_seg_size =
+		dma_get_max_seg_size(qspi->rx_chan->device->dev);
+	unsigned int desc_len = min_t(int, max_seg_size, PAGE_SIZE);
+	int sgs = DIV_ROUND_UP(len + offset_in_page(buf), desc_len);
+	struct page *vm_page;
+	size_t min;
+	int i, ret;
+
+	ret = sg_alloc_table(sgt, sgs, GFP_KERNEL);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < sgs; i++) {
+		min = min_t(size_t, len, desc_len -
+			    offset_in_page(buf));
+		vm_page = kmap_to_page(buf);
+		if (!vm_page) {
+			sg_free_table(sgt);
+			return -ENOMEM;
+		}
+		sg_set_page(&sgt->sgl[i], vm_page, min,
+			    offset_in_page(buf));
+		buf += min;
+		len -= min;
+	}
+	return 0;
+}
+#endif
+
+static int ti_qspi_spi_flash_read(struct spi_device *spi,
 				  struct spi_flash_read_message *msg)
 {
 	struct ti_qspi *qspi = spi_master_get_devdata(spi->master);
@@ -437,9 +542,45 @@ static int ti_qspi_spi_flash_read(struct  spi_device *spi,
 	if (!qspi->mmap_enabled)
 		ti_qspi_enable_memory_map(spi);
 	ti_qspi_setup_mmap_read(spi, msg);
-	memcpy_fromio(msg->buf, qspi->mmap_base + msg->from, msg->len);
+
+	if (qspi->rx_chan) {
+		if (msg->cur_msg_mapped) {
+			ret = ti_qspi_dma_xfer_sg(qspi, msg->rx_sg, msg->from);
+			if (ret)
+				goto err_unlock;
+#ifdef CONFIG_HIGHMEM
+		} else if ((unsigned long)msg->buf >= PKMAP_BASE &&
+				(unsigned long)msg->buf < (PKMAP_BASE +
+					(LAST_PKMAP * PAGE_SIZE))) {
+			struct device *dev = qspi->rx_chan->device->dev;
+			struct sg_table sgt;
+
+			/* Generate sg_table for kmap buffers */
+			ret = ti_qspi_map_buf(qspi, msg->buf, msg->len, &sgt);
+			if (ret)
+				goto err_unlock;
+			ret = dma_map_sg(dev, sgt.sgl, sgt.nents,
+					 DMA_FROM_DEVICE);
+			if (!ret) {
+				ret = -ENOMEM;
+				goto err_unlock;
+			}
+			ret = ti_qspi_dma_xfer_sg(qspi, sgt, msg->from);
+			dma_unmap_sg(dev, sgt.sgl, sgt.orig_nents,
+				     DMA_FROM_DEVICE);
+			sg_free_table(&sgt);
+#endif
+		} else {
+			dev_err(qspi->dev, "Invalid address for DMA\n");
+			ret = -EIO;
+			goto err_unlock;
+		}
+	} else {
+		memcpy_fromio(msg->buf, qspi->mmap_base + msg->from, msg->len);
+	}
 	msg->retlen = msg->len;
 
+err_unlock:
 	mutex_unlock(&qspi->list_lock);
 
 	return ret;
@@ -536,6 +677,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	u32 max_freq;
 	int ret = 0, num_cs, irq;
+	dma_cap_mask_t mask;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*qspi));
 	if (!master)
@@ -550,6 +692,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	master->dev.of_node = pdev->dev.of_node;
 	master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(16) |
 				     SPI_BPW_MASK(8);
+	master->spi_flash_read = ti_qspi_spi_flash_read;
 
 	if (!of_property_read_u32(np, "num-cs", &num_cs))
 		master->num_chipselect = num_cs;
@@ -592,17 +735,6 @@ static int ti_qspi_probe(struct platform_device *pdev)
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
@@ -633,11 +765,37 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	if (!of_property_read_u32(np, "spi-max-frequency", &max_freq))
 		qspi->spi_max_frequency = max_freq;
 
-	ret = devm_spi_register_master(&pdev->dev, master);
-	if (ret)
-		goto free_master;
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_MEMCPY, mask);
 
-	return 0;
+	qspi->rx_chan = dma_request_chan_by_mask(&mask);
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
+
+	ret = devm_spi_register_master(&pdev->dev, master);
+	if (!ret)
+		return 0;
 
 free_master:
 	spi_master_put(master);
@@ -656,6 +814,9 @@ static int ti_qspi_remove(struct platform_device *pdev)
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
+	if (qspi->rx_chan)
+		dma_release_channel(qspi->rx_chan);
+
 	return 0;
 }
 
-- 
2.9.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
