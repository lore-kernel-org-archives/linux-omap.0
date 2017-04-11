From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v2 2/2] spi: spi-ti-qspi: Use bounce buffer if read buffer is not DMA'ble
Date: Tue, 11 Apr 2017 17:22:25 +0530
Message-ID: <20170411115225.31709-3-vigneshr@ti.com>
References: <20170411115225.31709-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170411115225.31709-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

Flash filesystems like JFFS2, UBIFS and MTD block layer can provide
vmalloc'd or kmap'd buffers that cannot be mapped using dma_map_sg() and
can potentially be in memory region above 32bit addressable region(ie
buffers belonging to memory region backed by LPAE) of DMA, implement
spi_flash_can_dma() interface to inform SPI core not to map such
buffers.
When buffers are not mapped for DMA, then use a pre allocated bounce
buffer(64K = typical flash erase sector size) to read from flash and
then do a copy to actual destination buffer. This is approach is much
faster than using memcpy using CPU and also reduces CPU load.

With this patch, UBIFS read speed is ~18MB/s and CPU utilization <20% on
DRA74 Rev H EVM. Performance degradation is negligible when compared
with non bounce buffer case while using UBIFS.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---

v2: Fix compiler warnings and sparse warnings reported by Kbuild bot.

 drivers/spi/spi-ti-qspi.c | 66 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 7b39bc204a30..c24d9b45a27c 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -33,6 +33,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
+#include <linux/sizes.h>
 
 #include <linux/spi/spi.h>
 
@@ -57,6 +58,8 @@ struct ti_qspi {
 	struct ti_qspi_regs     ctx_reg;
 
 	dma_addr_t		mmap_phys_base;
+	dma_addr_t		rx_bb_dma_addr;
+	void			*rx_bb_addr;
 	struct dma_chan		*rx_chan;
 
 	u32 spi_max_frequency;
@@ -126,6 +129,8 @@ struct ti_qspi {
 #define QSPI_SETUP_ADDR_SHIFT		8
 #define QSPI_SETUP_DUMMY_SHIFT		10
 
+#define QSPI_DMA_BUFFER_SIZE            SZ_64K
+
 static inline unsigned long ti_qspi_read(struct ti_qspi *qspi,
 		unsigned long reg)
 {
@@ -429,6 +434,35 @@ static int ti_qspi_dma_xfer(struct ti_qspi *qspi, dma_addr_t dma_dst,
 	return 0;
 }
 
+static int ti_qspi_dma_bounce_buffer(struct ti_qspi *qspi,
+				     struct spi_flash_read_message *msg)
+{
+	size_t readsize = msg->len;
+	void *to = msg->buf;
+	dma_addr_t dma_src = qspi->mmap_phys_base + msg->from;
+	int ret = 0;
+
+	/*
+	 * Use bounce buffer as FS like jffs2, ubifs may pass
+	 * buffers that does not belong to kernel lowmem region.
+	 */
+	while (readsize != 0) {
+		size_t xfer_len = min_t(size_t, QSPI_DMA_BUFFER_SIZE,
+					readsize);
+
+		ret = ti_qspi_dma_xfer(qspi, qspi->rx_bb_dma_addr,
+				       dma_src, xfer_len);
+		if (ret != 0)
+			return ret;
+		memcpy(to, qspi->rx_bb_addr, xfer_len);
+		readsize -= xfer_len;
+		dma_src += xfer_len;
+		to += xfer_len;
+	}
+
+	return ret;
+}
+
 static int ti_qspi_dma_xfer_sg(struct ti_qspi *qspi, struct sg_table rx_sg,
 			       loff_t from)
 {
@@ -496,6 +530,12 @@ static void ti_qspi_setup_mmap_read(struct spi_device *spi,
 		      QSPI_SPI_SETUP_REG(spi->chip_select));
 }
 
+static bool ti_qspi_spi_flash_can_dma(struct spi_device *spi,
+				      struct spi_flash_read_message *msg)
+{
+	return virt_addr_valid(msg->buf);
+}
+
 static int ti_qspi_spi_flash_read(struct spi_device *spi,
 				  struct spi_flash_read_message *msg)
 {
@@ -509,15 +549,12 @@ static int ti_qspi_spi_flash_read(struct spi_device *spi,
 	ti_qspi_setup_mmap_read(spi, msg);
 
 	if (qspi->rx_chan) {
-		if (msg->cur_msg_mapped) {
+		if (msg->cur_msg_mapped)
 			ret = ti_qspi_dma_xfer_sg(qspi, msg->rx_sg, msg->from);
-			if (ret)
-				goto err_unlock;
-		} else {
-			dev_err(qspi->dev, "Invalid address for DMA\n");
-			ret = -EIO;
+		else
+			ret = ti_qspi_dma_bounce_buffer(qspi, msg);
+		if (ret)
 			goto err_unlock;
-		}
 	} else {
 		memcpy_fromio(msg->buf, qspi->mmap_base + msg->from, msg->len);
 	}
@@ -723,6 +760,17 @@ static int ti_qspi_probe(struct platform_device *pdev)
 		ret = 0;
 		goto no_dma;
 	}
+	qspi->rx_bb_addr = dma_alloc_coherent(qspi->dev,
+					      QSPI_DMA_BUFFER_SIZE,
+					      &qspi->rx_bb_dma_addr,
+					      GFP_KERNEL | GFP_DMA);
+	if (!qspi->rx_bb_addr) {
+		dev_err(qspi->dev,
+			"dma_alloc_coherent failed, using PIO mode\n");
+		dma_release_channel(qspi->rx_chan);
+		goto no_dma;
+	}
+	master->spi_flash_can_dma = ti_qspi_spi_flash_can_dma;
 	master->dma_rx = qspi->rx_chan;
 	init_completion(&qspi->transfer_complete);
 	if (res_mmap)
@@ -763,6 +811,10 @@ static int ti_qspi_remove(struct platform_device *pdev)
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
+	if (qspi->rx_bb_addr)
+		dma_free_coherent(qspi->dev, QSPI_DMA_BUFFER_SIZE,
+				  qspi->rx_bb_addr,
+				  qspi->rx_bb_dma_addr);
 	if (qspi->rx_chan)
 		dma_release_channel(qspi->rx_chan);
 
-- 
2.11.0
