From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/2] spi: Add DMA support for spi_flash_read()
Date: Tue, 5 Apr 2016 09:19:51 +0530
Message-ID: <1459828192-5531-2-git-send-email-vigneshr@ti.com>
References: <1459828192-5531-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459828192-5531-1-git-send-email-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Few SPI devices provide accelerated read interfaces to read from
SPI-NOR flash devices. These hardwares also support DMA to transfer data
from flash to memory either via mem-to-mem DMA or dedicated slave DMA
channels. Hence, add support for DMA in order to improve throughput and
reduce CPU load.
Use spi_map_buf() to get sg table for the buffer and pass it to SPI
driver.

Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/spi.c       | 15 +++++++++++++++
 include/linux/spi/spi.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index de2f2f90d799..2fb97f5b79ab 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2722,6 +2722,7 @@ int spi_flash_read(struct spi_device *spi,
 
 {
 	struct spi_master *master = spi->master;
+	struct device *rx_dev = NULL;
 	int ret;
 
 	if ((msg->opcode_nbits == SPI_NBITS_DUAL ||
@@ -2747,8 +2748,22 @@ int spi_flash_read(struct spi_device *spi,
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
+		if (ret != 0)
+			goto  err;
+	}
 	ret = master->spi_flash_read(spi, msg);
+	if (master->dma_rx)
+		spi_unmap_buf(master, rx_dev, &msg->rx_sg,
+			      DMA_FROM_DEVICE);
+
+err:
 	mutex_unlock(&master->bus_lock_mutex);
 	if (master->auto_runtime_pm)
 		pm_runtime_put(master->dev.parent);
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 857a9a1d82b5..5b9c745eda92 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1141,6 +1141,7 @@ static inline ssize_t spi_w8r16be(struct spi_device *spi, u8 cmd)
  * @opcode_nbits: number of lines to send opcode
  * @addr_nbits: number of lines to send address
  * @data_nbits: number of lines for data
+ * @rx_sg: Scatterlist for receive data
  */
 struct spi_flash_read_message {
 	void *buf;
@@ -1153,6 +1154,7 @@ struct spi_flash_read_message {
 	u8 opcode_nbits;
 	u8 addr_nbits;
 	u8 data_nbits;
+	struct sg_table rx_sg;
 };
 
 /* SPI core interface for flash read support */
-- 
2.8.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
