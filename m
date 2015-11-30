From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v4 1/5] spi: introduce accelerated read support for spi flash
 devices
Date: Mon, 30 Nov 2015 10:45:11 +0530
Message-ID: <1448860515-28336-2-git-send-email-vigneshr@ti.com>
References: <1448860515-28336-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1448860515-28336-1-git-send-email-vigneshr@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Brian Norris <computersforpeace@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, hramrach@gmail.com, Russell King <linux@arm.linux.org.uk>, Vignesh R <vigneshr@ti.com>, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

In addition to providing direct access to SPI bus, some spi controller
hardwares (like ti-qspi) provide special port (like memory mapped port)
that are optimized to improve SPI flash read performance.
This means the controller can automatically send the SPI signals
required to read data from the SPI flash device.
For this, SPI controller needs to know flash specific information like
read command to use, dummy bytes and address width.

Introduce spi_flash_read() interface to support accelerated read
over SPI flash devices. SPI master drivers can implement this callback to
support interfaces such as memory mapped read etc. m25p80 flash driver
and other flash drivers can call this make use of such interfaces. The
interface should only be used with SPI flashes and cannot be used with
other SPI devices.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/spi/spi.c       | 45 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e2415be209d5..cc2b54139352 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1134,6 +1134,7 @@ static void __spi_pump_messages(struct spi_master *master, bool in_kthread)
 		}
 	}
 
+	mutex_lock(&master->bus_lock_mutex);
 	trace_spi_message_start(master->cur_msg);
 
 	if (master->prepare_message) {
@@ -1143,6 +1144,7 @@ static void __spi_pump_messages(struct spi_master *master, bool in_kthread)
 				"failed to prepare message: %d\n", ret);
 			master->cur_msg->status = ret;
 			spi_finalize_current_message(master);
+			mutex_unlock(&master->bus_lock_mutex);
 			return;
 		}
 		master->cur_msg_prepared = true;
@@ -1152,6 +1154,7 @@ static void __spi_pump_messages(struct spi_master *master, bool in_kthread)
 	if (ret) {
 		master->cur_msg->status = ret;
 		spi_finalize_current_message(master);
+		mutex_unlock(&master->bus_lock_mutex);
 		return;
 	}
 
@@ -1159,8 +1162,10 @@ static void __spi_pump_messages(struct spi_master *master, bool in_kthread)
 	if (ret) {
 		dev_err(&master->dev,
 			"failed to transfer one message from queue\n");
+		mutex_unlock(&master->bus_lock_mutex);
 		return;
 	}
+	mutex_unlock(&master->bus_lock_mutex);
 }
 
 /**
@@ -2327,6 +2332,46 @@ int spi_async_locked(struct spi_device *spi, struct spi_message *message)
 EXPORT_SYMBOL_GPL(spi_async_locked);
 
 
+int spi_flash_read(struct spi_device *spi,
+		   struct spi_flash_read_message *msg)
+
+{
+	struct spi_master *master = spi->master;
+	int ret;
+
+	if ((msg->opcode_nbits == SPI_NBITS_DUAL ||
+	     msg->addr_nbits == SPI_NBITS_DUAL) &&
+	    !(spi->mode & (SPI_TX_DUAL | SPI_TX_QUAD)))
+		return -EINVAL;
+	if ((msg->opcode_nbits == SPI_NBITS_QUAD ||
+	     msg->addr_nbits == SPI_NBITS_QUAD) &&
+	    !(spi->mode & SPI_TX_QUAD))
+		return -EINVAL;
+	if (msg->data_nbits == SPI_NBITS_DUAL &&
+	    !(spi->mode & (SPI_RX_DUAL | SPI_RX_QUAD)))
+		return -EINVAL;
+	if (msg->data_nbits == SPI_NBITS_QUAD &&
+	    !(spi->mode &  SPI_RX_QUAD))
+		return -EINVAL;
+
+	if (master->auto_runtime_pm) {
+		ret = pm_runtime_get_sync(master->dev.parent);
+		if (ret < 0) {
+			dev_err(&master->dev, "Failed to power device: %d\n",
+				ret);
+			return ret;
+		}
+	}
+	mutex_lock(&master->bus_lock_mutex);
+	ret = master->spi_flash_read(spi, msg);
+	mutex_unlock(&master->bus_lock_mutex);
+	if (master->auto_runtime_pm)
+		pm_runtime_put(master->dev.parent);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(spi_flash_read);
+
 /*-------------------------------------------------------------------------*/
 
 /* Utility methods for SPI master protocol drivers, layered on
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index cce80e6dc7d1..246d7d519f3f 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -25,6 +25,7 @@
 struct dma_chan;
 struct spi_master;
 struct spi_transfer;
+struct spi_flash_read_message;
 
 /*
  * INTERFACES between SPI master-side drivers and SPI infrastructure.
@@ -361,6 +362,8 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  * @handle_err: the subsystem calls the driver to handle an error that occurs
  *		in the generic implementation of transfer_one_message().
  * @unprepare_message: undo any work done by prepare_message().
+ * @spi_flash_read: to support spi-controller hardwares that provide
+ *                  accelerated interface to read from flash devices.
  * @cs_gpios: Array of GPIOs to use as chip select lines; one per CS
  *	number. Any individual value may be -ENOENT for CS lines that
  *	are not GPIOs (driven by the SPI controller itself).
@@ -507,6 +510,8 @@ struct spi_master {
 			       struct spi_message *message);
 	int (*unprepare_message)(struct spi_master *master,
 				 struct spi_message *message);
+	int (*spi_flash_read)(struct  spi_device *spi,
+			      struct spi_flash_read_message *msg);
 
 	/*
 	 * These hooks are for drivers that use a generic implementation
@@ -999,6 +1004,42 @@ static inline ssize_t spi_w8r16be(struct spi_device *spi, u8 cmd)
 	return be16_to_cpu(result);
 }
 
+/**
+ * struct spi_flash_read_message - flash specific information for
+ * spi-masters that provide accelerated flash read interfaces
+ * @buf: buffer to read data
+ * @from: offset within the flash from where data is to be read
+ * @len: length of data to be read
+ * @retlen: actual length of data read
+ * @read_opcode: read_opcode to be used to communicate with flash
+ * @addr_width: number of address bytes
+ * @dummy_bytes: number of dummy bytes
+ * @opcode_nbits: number of lines to send opcode
+ * @addr_nbits: number of lines to send address
+ * @data_nbits: number of lines for data
+ */
+struct spi_flash_read_message {
+	void *buf;
+	loff_t from;
+	size_t len;
+	size_t retlen;
+	u8 read_opcode;
+	u8 addr_width;
+	u8 dummy_bytes;
+	u8 opcode_nbits;
+	u8 addr_nbits;
+	u8 data_nbits;
+};
+
+/* SPI core interface for flash read support */
+static inline bool spi_flash_read_supported(struct spi_device *spi)
+{
+	return spi->master->spi_flash_read ? true : false;
+}
+
+int spi_flash_read(struct spi_device *spi,
+		   struct spi_flash_read_message *msg);
+
 /*---------------------------------------------------------------------------*/
 
 /*
-- 
2.6.3
