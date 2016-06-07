From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v3 1/2] spi: Add DMA support for spi_flash_read()
Date: Tue, 7 Jun 2016 13:48:09 +0530
Message-ID: <20160607081810.6640-2-vigneshr@ti.com>
References: <20160607081810.6640-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160607081810.6640-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

Few SPI devices provide accelerated read interfaces to read from
SPI-NOR flash devices. These hardwares also support DMA to transfer data
from flash to memory either via mem-to-mem DMA or dedicated slave DMA
channels. Hence, add support for DMA in order to improve throughput and
reduce CPU load.
Use spi_map_buf() to get sg table for the buffer and pass it to SPI
driver.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---

v3: No changes.
v2: use cur_msg_mapped flag to indicate success/failure of spi_map_buf()


 drivers/spi/spi.c       | 14 ++++++++++++++
 include/linux/spi/spi.h |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 77e6e45951f4..da2cbe205654 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2725,6 +2725,7 @@ int spi_flash_read(struct spi_device *spi,
 
 {
 	struct spi_master *master = spi->master;
+	struct device *rx_dev = NULL;
 	int ret;
 
 	if ((msg->opcode_nbits == SPI_NBITS_DUAL ||
@@ -2750,9 +2751,22 @@ int spi_flash_read(struct spi_device *spi,
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
2.8.3
