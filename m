From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: Add can_dma like interface for spi_flash_read" to the spi tree
Date: Fri, 21 Apr 2017 18:29:01 +0100
Message-ID: <E1d1cMf-0002AE-TU@debutante>
References: <20170331114950.21489-2-vigneshr@ti.com>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170331114950.21489-2-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.orglinux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The patch

   spi: Add can_dma like interface for spi_flash_read

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

>From 2bca34455b257d75080d87e800ae14afe49001bf Mon Sep 17 00:00:00 2001
From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Date: Tue, 11 Apr 2017 17:22:24 +0530
Subject: [PATCH] spi: Add can_dma like interface for spi_flash_read

Add an interface analogous to ->can_dma() for spi_flash_read()
interface. This will enable SPI controller drivers to inform SPI core
when not to do DMA mappings.

Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c       | 2 +-
 include/linux/spi/spi.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 656dd3e3220c..5e1bb43b8a8f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2811,7 +2811,7 @@ int spi_flash_read(struct spi_device *spi,
 
 	mutex_lock(&master->bus_lock_mutex);
 	mutex_lock(&master->io_mutex);
-	if (master->dma_rx) {
+	if (master->dma_rx && master->spi_flash_can_dma(spi, msg)) {
 		rx_dev = master->dma_rx->device->dev;
 		ret = spi_map_buf(master, rx_dev, &msg->rx_sg,
 				  msg->buf, msg->len,
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 75c6bd0ac605..cd8ae65568e3 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -375,6 +375,8 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  * @unprepare_message: undo any work done by prepare_message().
  * @spi_flash_read: to support spi-controller hardwares that provide
  *                  accelerated interface to read from flash devices.
+ * @spi_flash_can_dma: analogous to can_dma() interface, but for
+ *		       controllers implementing spi_flash_read.
  * @flash_read_supported: spi device supports flash read
  * @cs_gpios: Array of GPIOs to use as chip select lines; one per CS
  *	number. Any individual value may be -ENOENT for CS lines that
@@ -538,6 +540,8 @@ struct spi_master {
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
