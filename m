From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv2 01/10] spi/spi.h: Add get_buf/put_buf support in spi master.
Date: Fri, 6 Dec 2013 19:54:42 +0530
Message-ID: <1386339891-32717-2-git-send-email-sourav.poddar@ti.com>
References: <1386339891-32717-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60022 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740Ab3LFOZf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Dec 2013 09:25:35 -0500
In-Reply-To: <1386339891-32717-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@kernel.org, linux-spi@vger.kernel.org, computersforpeace@gmail.com, marex@denx.de
Cc: dwmw2@infradead.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, balbi@ti.com, Sourav Poddar <sourav.poddar@ti.com>

Add get_buf, put_buf api support in spi master.
This can be used in a scenario where spi controller
supports memory mapped operations(typically with flash devices).
So, the memcpy needs top be done in slave devices which need the
required memory mapped address. These api can be used to get that
master address.

These can also be used to turm the master controller clock, as usually
the clocks get turned in spi core. But, in memory mapped case, we will
bypass the spi core and hence needa way out to turn on the controller clock.

Add configure from slave api, which can be used to configure the master
controller with slave specific information.

Add slave info struct, that can be filled with slave  properties required by
master controller for its register configuration.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
v1->v2:
- Added a slave info structure.
- Merge all other header related patches into this.
 include/linux/spi/spi.h |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 8c62ba7..c91d883 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -31,6 +31,14 @@
  */
 extern struct bus_type spi_bus_type;
 
+/* For SPI flash */
+struct slave_info {
+	u8 read_opcode;
+	u8 program_opcode;
+	u8 addr_width;
+	u8 dummy_cycles;
+};
+
 /**
  * struct spi_device - Master side proxy for an SPI slave device
  * @dev: Driver model representation of the device.
@@ -73,6 +81,7 @@ extern struct bus_type spi_bus_type;
 struct spi_device {
 	struct device		dev;
 	struct spi_master	*master;
+	struct slave_info	info;		/* flash devices */
 	u32			max_speed_hz;
 	u8			chip_select;
 	u16			mode;
@@ -291,6 +300,14 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  *	number. Any individual value may be -ENOENT for CS lines that
  *	are not GPIOs (driven by the SPI controller itself).
  *
+ * @get_buf: used for memory mapped cases, when the slave device wants to
+ *       know the address to be used for memcopy.
+ * @put_buf: Used for memory mapped cases after get_buf, after the memcpy
+ *       has finished.
+ * @configure_from_slave: Used when SPI controller has registers which need
+ *      to be configured from slave specifics information(typical use case for
+ *      SPI flash device).
+ * @mmap: Used to show that controller supports memory mapped operation.
  * Each SPI master controller can communicate with one or more @spi_device
  * children.  These make a small bus, sharing MOSI, MISO and SCK signals
  * but not chip select signals.  Each device may be configured to use a
@@ -421,8 +438,13 @@ struct spi_master {
 	int (*transfer_one)(struct spi_master *master, struct spi_device *spi,
 			    struct spi_transfer *transfer);
 
+	int	__iomem *(*get_buf)(struct spi_master *master);
+	void	(*put_buf)(struct spi_master *master);
+	void	(*configure_from_slave)(struct spi_device *spi);
+
 	/* gpio chip select */
 	int			*cs_gpios;
+	bool	mmap;
 };
 
 static inline void *spi_master_get_devdata(struct spi_master *master)
-- 
1.7.1

