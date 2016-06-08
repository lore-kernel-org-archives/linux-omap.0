From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Add DMA support for spi_flash_read()" to the spi tree
Date: Wed, 08 Jun 2016 11:00:32 +0100
Message-ID: <E1bAaHo-0007l5-CR@debutante>
References: <20160608064832.18496-2-vigneshr@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160608064832.18496-2-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The patch

   spi: Add DMA support for spi_flash_read()

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

>From f4502dd1da9b060a49d539eb754ff86cb97b89f0 Mon Sep 17 00:00:00 2001
From: Vignesh R <vigneshr@ti.com>
Date: Wed, 8 Jun 2016 12:18:31 +0530
Subject: [PATCH] spi: Add DMA support for spi_flash_read()

Few SPI devices provide accelerated read interfaces to read from
SPI-NOR flash devices. These hardwares also support DMA to transfer data
from flash to memory either via mem-to-mem DMA or dedicated slave DMA
channels. Hence, add support for DMA in order to improve throughput and
reduce CPU load.
Use spi_map_buf() to get sg table for the buffer and pass it to SPI
driver.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c       | 28 ++++++++++++++++++++++++++++
 include/linux/spi/spi.h |  4 ++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 77e6e45951f4..c9a8d544e467 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -849,6 +849,20 @@ static int __spi_unmap_msg(struct spi_master *master, struct spi_message *msg)
 	return 0;
 }
 #else /* !CONFIG_HAS_DMA */
+static inline int spi_map_buf(struct spi_master *master,
+			      struct device *dev, struct sg_table *sgt,
+			      void *buf, size_t len,
+			      enum dma_data_direction dir)
+{
+	return -EINVAL;
+}
+
+static inline void spi_unmap_buf(struct spi_master *master,
+				 struct device *dev, struct sg_table *sgt,
+				 enum dma_data_direction dir)
+{
+}
+
 static inline int __spi_map_msg(struct spi_master *master,
 				struct spi_message *msg)
 {
@@ -2725,6 +2739,7 @@ int spi_flash_read(struct spi_device *spi,
 
 {
 	struct spi_master *master = spi->master;
+	struct device *rx_dev = NULL;
 	int ret;
 
 	if ((msg->opcode_nbits == SPI_NBITS_DUAL ||
@@ -2750,9 +2765,22 @@ int spi_flash_read(struct spi_device *spi,
 			return ret;
 		}
 	}
+
 	mutex_lock(&master->bus_lock_mutex);
+	if (master->dma_rx) {
+		rx_dev = master->dma_rx->device->dev;
+		ret = spi_map_buf(master, rx_dev, &msg->rx_sg,
+				  msg->buf, msg->len,
+				  DMA_FROM_DEVICE);
+		if (!ret)
+			msg->cur_msg_mapped = true;
+	}
 	ret = master->spi_flash_read(spi, msg);
+	if (msg->cur_msg_mapped)
+		spi_unmap_buf(master, rx_dev, &msg->rx_sg,
+			      DMA_FROM_DEVICE);
 	mutex_unlock(&master->bus_lock_mutex);
+
 	if (master->auto_runtime_pm)
 		pm_runtime_put(master->dev.parent);
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 1f03483f61e5..7b53af4ba5f8 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1143,6 +1143,8 @@ static inline ssize_t spi_w8r16be(struct spi_device *spi, u8 cmd)
  * @opcode_nbits: number of lines to send opcode
  * @addr_nbits: number of lines to send address
  * @data_nbits: number of lines for data
+ * @rx_sg: Scatterlist for receive data read from flash
+ * @cur_msg_mapped: message has been mapped for DMA
  */
 struct spi_flash_read_message {
 	void *buf;
@@ -1155,6 +1157,8 @@ struct spi_flash_read_message {
 	u8 opcode_nbits;
 	u8 addr_nbits;
 	u8 data_nbits;
+	struct sg_table rx_sg;
+	bool cur_msg_mapped;
 };
 
 /* SPI core interface for flash read support */
-- 
2.8.1
