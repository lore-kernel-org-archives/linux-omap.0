From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 1/2] spi: Add can_dma like interface for spi_flash_read
Date: Tue, 11 Apr 2017 17:22:24 +0530
Message-ID: <20170411115225.31709-2-vigneshr@ti.com>
References: <20170411115225.31709-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170411115225.31709-1-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add an interface analogous to ->can_dma() for spi_flash_read()
interface. This will enable SPI controller drivers to inform SPI core
when not to do DMA mappings.

Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
---

v2: No changes.

 drivers/spi/spi.c       | 2 +-
 include/linux/spi/spi.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index f699ea530b88..57b64d2128e5 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2854,7 +2854,7 @@ int spi_flash_read(struct spi_device *spi,
 
 	mutex_lock(&master->bus_lock_mutex);
 	mutex_lock(&master->io_mutex);
-	if (master->dma_rx) {
+	if (master->dma_rx && master->spi_flash_can_dma(spi, msg)) {
 		rx_dev = master->dma_rx->device->dev;
 		ret = spi_map_buf(master, rx_dev, &msg->rx_sg,
 				  msg->buf, msg->len,
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 805878d61a8f..935bd2854ff1 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -376,6 +376,8 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  * @unprepare_message: undo any work done by prepare_message().
  * @spi_flash_read: to support spi-controller hardwares that provide
  *                  accelerated interface to read from flash devices.
+ * @spi_flash_can_dma: analogous to can_dma() interface, but for
+ *		       controllers implementing spi_flash_read.
  * @flash_read_supported: spi device supports flash read
  * @cs_gpios: Array of GPIOs to use as chip select lines; one per CS
  *	number. Any individual value may be -ENOENT for CS lines that
@@ -539,6 +541,8 @@ struct spi_master {
 				 struct spi_message *message);
 	int (*spi_flash_read)(struct  spi_device *spi,
 			      struct spi_flash_read_message *msg);
+	bool (*spi_flash_can_dma)(struct spi_device *spi,
+				  struct spi_flash_read_message *msg);
 	bool (*flash_read_supported)(struct spi_device *spi);
 
 	/*
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
