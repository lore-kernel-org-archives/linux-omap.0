From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v3 1/5] spi: introduce mmap read support for spi flash devices
Date: Tue, 10 Nov 2015 10:59:55 +0530
Message-ID: <1447133399-25658-2-git-send-email-vigneshr@ti.com>
References: <1447133399-25658-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1447133399-25658-1-git-send-email-vigneshr@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Michal Suchanek <hramrach@gmail.com>, Russell King <linux@arm.linux.org.uk>, Vignesh R <vigneshr@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

In addition to providing direct access to SPI bus, some spi controller
hardwares (like ti-qspi) provide special memory mapped port
to accesses SPI flash devices in order to increase read performance.
This means the controller can automatically send the SPI signals
required to read data from the SPI flash device.
For this, spi controller needs to know flash specific information like
read command to use, dummy bytes and address width. Once these settings
are populated in hardware registers, any read accesses to flash's memory
map region(SoC specific) through memcpy (or mem-to mem DMA copy) will be
handled by controller hardware. The hardware will automatically generate
SPI signals required to read data from flash and present it to CPU/DMA.

Introduce spi_mtd_mmap_read() interface to support memory mapped read
over SPI flash devices. SPI master drivers can implement this callback to
support memory mapped read interfaces. m25p80 flash driver and other
flash drivers can call this to request memory mapped read. The interface
should only be used MTD flashes and cannot be used with other SPI devices.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
v3:
 * Remove use of mmap_lock_mutex, use bus_lock_mutex instead.

 drivers/spi/spi.c       | 34 ++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h | 20 ++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e2415be209d5..0448d29fefc8 100644
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
@@ -2327,6 +2332,35 @@ int spi_async_locked(struct spi_device *spi, struct spi_message *message)
 EXPORT_SYMBOL_GPL(spi_async_locked);
 
 
+int spi_mtd_mmap_read(struct spi_device *spi, loff_t from, size_t len,
+		      size_t *retlen, u_char *buf, u8 read_opcode,
+		      u8 addr_width, u8 dummy_bytes)
+
+{
+	struct spi_master *master = spi->master;
+	int ret;
+
+	if (master->auto_runtime_pm) {
+		ret = pm_runtime_get_sync(master->dev.parent);
+		if (ret < 0) {
+			dev_err(&master->dev, "Failed to power device: %d\n",
+				ret);
+			goto err;
+		}
+	}
+	mutex_lock(&master->bus_lock_mutex);
+	ret = master->spi_mtd_mmap_read(spi, from, len, retlen, buf,
+					read_opcode, addr_width,
+					dummy_bytes);
+	mutex_unlock(&master->bus_lock_mutex);
+	if (master->auto_runtime_pm)
+		pm_runtime_put(master->dev.parent);
+
+err:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(spi_mtd_mmap_read);
+
 /*-------------------------------------------------------------------------*/
 
 /* Utility methods for SPI master protocol drivers, layered on
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index cce80e6dc7d1..2f2c431b8917 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -361,6 +361,11 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  * @handle_err: the subsystem calls the driver to handle an error that occurs
  *		in the generic implementation of transfer_one_message().
  * @unprepare_message: undo any work done by prepare_message().
+ * @spi_mtd_mmap_read: some spi-controller hardwares provide memory.
+ *                     Flash drivers (like m25p80) can request memory
+ *                     mapped read via this method. This interface
+ *                     should only be used by mtd flashes and cannot be
+ *                     used by other spi devices.
  * @cs_gpios: Array of GPIOs to use as chip select lines; one per CS
  *	number. Any individual value may be -ENOENT for CS lines that
  *	are not GPIOs (driven by the SPI controller itself).
@@ -507,6 +512,11 @@ struct spi_master {
 			       struct spi_message *message);
 	int (*unprepare_message)(struct spi_master *master,
 				 struct spi_message *message);
+	int (*spi_mtd_mmap_read)(struct  spi_device *spi,
+				 loff_t from, size_t len,
+				 size_t *retlen, u_char *buf,
+				 u8 read_opcode, u8 addr_width,
+				 u8 dummy_bytes);
 
 	/*
 	 * These hooks are for drivers that use a generic implementation
@@ -999,6 +1009,16 @@ static inline ssize_t spi_w8r16be(struct spi_device *spi, u8 cmd)
 	return be16_to_cpu(result);
 }
 
+/* SPI core interface for memory mapped read support */
+static inline bool spi_mmap_read_supported(struct spi_device *spi)
+{
+	return spi->master->spi_mtd_mmap_read ? true : false;
+}
+
+int spi_mtd_mmap_read(struct spi_device *spi, loff_t from, size_t len,
+		      size_t *retlen, u_char *buf, u8 read_opcode,
+		      u8 addr_width, u8 dummy_bytes);
+
 /*---------------------------------------------------------------------------*/
 
 /*
-- 
2.6.3
