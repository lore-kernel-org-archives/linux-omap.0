From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v2 1/5] spi: introduce mmap read support for spi flash devices
Date: Tue, 3 Nov 2015 15:36:10 +0530
Message-ID: <1446545174-14193-2-git-send-email-vigneshr@ti.com>
References: <1446545174-14193-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1446545174-14193-1-git-send-email-vigneshr@ti.com>
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
Cc: devicetree@vger.kernel.org, Michal Suchanek <hramrach@gmail.com>, Russell King <linux@arm.linux.org.uk>, Vignesh R <vigneshr@ti.com>, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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
 drivers/spi/spi.c       | 35 +++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h | 23 +++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a5f53de813d3..5a5c7a7d47f2 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1059,6 +1059,7 @@ static void __spi_pump_messages(struct spi_master *master, bool in_kthread)
 		}
 	}
 
+	mutex_lock(&master->mmap_lock_mutex);
 	trace_spi_message_start(master->cur_msg);
 
 	if (master->prepare_message) {
@@ -1068,6 +1069,7 @@ static void __spi_pump_messages(struct spi_master *master, bool in_kthread)
 				"failed to prepare message: %d\n", ret);
 			master->cur_msg->status = ret;
 			spi_finalize_current_message(master);
+			mutex_unlock(&master->mmap_lock_mutex);
 			return;
 		}
 		master->cur_msg_prepared = true;
@@ -1077,6 +1079,7 @@ static void __spi_pump_messages(struct spi_master *master, bool in_kthread)
 	if (ret) {
 		master->cur_msg->status = ret;
 		spi_finalize_current_message(master);
+		mutex_unlock(&master->mmap_lock_mutex);
 		return;
 	}
 
@@ -1084,8 +1087,10 @@ static void __spi_pump_messages(struct spi_master *master, bool in_kthread)
 	if (ret) {
 		dev_err(&master->dev,
 			"failed to transfer one message from queue\n");
+		mutex_unlock(&master->mmap_lock_mutex);
 		return;
 	}
+	mutex_unlock(&master->mmap_lock_mutex);
 }
 
 /**
@@ -1732,6 +1737,7 @@ int spi_register_master(struct spi_master *master)
 	spin_lock_init(&master->queue_lock);
 	spin_lock_init(&master->bus_lock_spinlock);
 	mutex_init(&master->bus_lock_mutex);
+	mutex_init(&master->mmap_lock_mutex);
 	master->bus_lock_flag = 0;
 	init_completion(&master->xfer_completion);
 	if (!master->max_dma_len)
@@ -2237,6 +2243,35 @@ int spi_async_locked(struct spi_device *spi, struct spi_message *message)
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
+	mutex_lock(&master->mmap_lock_mutex);
+	ret = master->spi_mtd_mmap_read(spi, from, len, retlen, buf,
+					read_opcode, addr_width,
+					dummy_bytes);
+	mutex_unlock(&master->mmap_lock_mutex);
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
index 6b00f18f5e6b..0a6d8ad57357 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -297,6 +297,7 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  * @flags: other constraints relevant to this driver
  * @bus_lock_spinlock: spinlock for SPI bus locking
  * @bus_lock_mutex: mutex for SPI bus locking
+ * @mmap_lock_mutex: mutex for locking SPI bus when mmap transfer is on.
  * @bus_lock_flag: indicates that the SPI bus is locked for exclusive use
  * @setup: updates the device mode and clocking records used by a
  *	device's SPI controller; protocol code may call this.  This
@@ -353,6 +354,11 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
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
@@ -420,6 +426,8 @@ struct spi_master {
 	/* lock and mutex for SPI bus locking */
 	spinlock_t		bus_lock_spinlock;
 	struct mutex		bus_lock_mutex;
+	/*  mutex for SPI bus locking when mmap transfer is on */
+	struct mutex		mmap_lock_mutex;
 
 	/* flag indicating that the SPI bus is locked for exclusive use */
 	bool			bus_lock_flag;
@@ -499,6 +507,11 @@ struct spi_master {
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
@@ -985,6 +998,16 @@ static inline ssize_t spi_w8r16be(struct spi_device *spi, u8 cmd)
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
2.6.2
