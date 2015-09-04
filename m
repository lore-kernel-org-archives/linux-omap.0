From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 2/5] spi: spi-ti-qspi: add mmap mode read support
Date: Fri, 4 Sep 2015 13:59:59 +0530
Message-ID: <1441355402-6837-3-git-send-email-vigneshr@ti.com>
References: <1441355402-6837-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1441355402-6837-1-git-send-email-vigneshr@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Mark Brown <broonie@kernel.org>, hramrach@gmail.com
Cc: devicetree@vger.kernel.org, Vignesh R <vigneshr@ti.com>, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

ti-qspi controller provides mmap port to read data from SPI flashes.
mmap port is enabled in QSPI_SPI_SWITCH_REG (ctrl module bits may
also need to be updated for some SoCs). The QSPI_SPI_SETUP_REGx needs to
be populated with flash specific information like read opcode, read
mode(quad, dual, normal), address width and dummy bytes. Once,
controller is in mmap mode, the whole flash memory is available as a
memory region at SoC specific address. This region can be accessed using
normal memcpy() or mem-to-mem dma copy. The ti-qspi controller hardware
will internally communicate with SPI flash over SPI bus and get the
requested data.

Implement spi_mtd_mmap_read() method to support mmap read over SPI
flash devices. With this, the read throughput increases from ~100kB/s to
~2.5 MB/s.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/spi/spi-ti-qspi.c | 106 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 102 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index aa6d284131e0..a07610b84bc9 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -71,11 +71,8 @@ struct ti_qspi {
 #define QSPI_SPI_CMD_REG		(0x48)
 #define QSPI_SPI_STATUS_REG		(0x4c)
 #define QSPI_SPI_DATA_REG		(0x50)
-#define QSPI_SPI_SETUP0_REG		(0x54)
+#define QSPI_SPI_SETUP_REG(n)		((0x54 + 4 * n))
 #define QSPI_SPI_SWITCH_REG		(0x64)
-#define QSPI_SPI_SETUP1_REG		(0x58)
-#define QSPI_SPI_SETUP2_REG		(0x5c)
-#define QSPI_SPI_SETUP3_REG		(0x60)
 #define QSPI_SPI_DATA_REG_1		(0x68)
 #define QSPI_SPI_DATA_REG_2		(0x6c)
 #define QSPI_SPI_DATA_REG_3		(0x70)
@@ -120,6 +117,16 @@ struct ti_qspi {
 
 #define QSPI_AUTOSUSPEND_TIMEOUT         2000
 
+#define MEM_CS_EN(n)			((n + 1) << 8)
+
+#define MM_SWITCH			0x1
+
+#define QSPI_SETUP_RD_NORMAL		(0x0 << 12)
+#define QSPI_SETUP_RD_DUAL		(0x1 << 12)
+#define QSPI_SETUP_RD_QUAD		(0x3 << 12)
+#define QSPI_SETUP_ADDR_SHIFT		8
+#define QSPI_SETUP_DUMMY_SHIFT		10
+
 static inline unsigned long ti_qspi_read(struct ti_qspi *qspi,
 		unsigned long reg)
 {
@@ -361,6 +368,96 @@ static int qspi_transfer_msg(struct ti_qspi *qspi, struct spi_transfer *t)
 	return 0;
 }
 
+static void ti_qspi_enable_memory_map(struct spi_device *spi)
+{
+	struct ti_qspi  *qspi = spi_master_get_devdata(spi->master);
+	u32 val;
+
+	ti_qspi_write(qspi, MM_SWITCH, QSPI_SPI_SWITCH_REG);
+	if (qspi->ctrl_mod) {
+		val = readl(qspi->ctrl_base);
+		val |= MEM_CS_EN(spi->chip_select);
+		writel(val, qspi->ctrl_base);
+	}
+}
+
+static void ti_qspi_disable_memory_map(struct spi_device *spi)
+{
+	struct ti_qspi  *qspi = spi_master_get_devdata(spi->master);
+	u32 val;
+
+	ti_qspi_write(qspi, 0, QSPI_SPI_SWITCH_REG);
+	if (qspi->ctrl_mod) {
+		val = readl(qspi->ctrl_base);
+		val &= ~MEM_CS_EN(spi->chip_select);
+		writel(val, qspi->ctrl_base);
+	}
+}
+
+static void ti_qspi_setup_mmap_read(struct spi_device *spi,
+				    u8 read_opcode, u8 addr_width,
+				    u8 dummy_bytes)
+{
+	struct ti_qspi  *qspi = spi_master_get_devdata(spi->master);
+	u32 mode = spi->mode & (SPI_RX_DUAL | SPI_RX_QUAD);
+	u32 memval = read_opcode;
+
+	switch (mode) {
+	case SPI_RX_QUAD:
+		memval |= QSPI_SETUP_RD_QUAD;
+		break;
+	case SPI_RX_DUAL:
+		memval |= QSPI_SETUP_RD_DUAL;
+		break;
+	default:
+		memval |= QSPI_SETUP_RD_NORMAL;
+		break;
+	}
+	memval |= ((addr_width - 1) << QSPI_SETUP_ADDR_SHIFT |
+		   dummy_bytes << QSPI_SETUP_DUMMY_SHIFT);
+	ti_qspi_write(qspi, memval,
+		      QSPI_SPI_SETUP_REG(spi->chip_select));
+}
+
+static int ti_qspi_spi_mtd_mmap_read(struct  spi_device *spi,
+				     loff_t from, size_t len,
+				     size_t *retlen, u_char *buf,
+				     u8 read_opcode, u8 addr_width,
+				     u8 dummy_bytes)
+{
+	struct ti_qspi *qspi = spi_master_get_devdata(spi->master);
+	int ret = 0;
+
+	spi_bus_lock(qspi->master);
+	mutex_lock(&qspi->list_lock);
+	ret = pm_runtime_get_sync(qspi->dev);
+	if (ret < 0) {
+		dev_err(qspi->dev, "pm_runtime_get_sync() failed\n");
+		return ret;
+	}
+
+	/* disable WC interrupt during memcpy */
+	ti_qspi_write(qspi, QSPI_WC_INT_DISABLE, QSPI_INTR_ENABLE_CLEAR_REG);
+	ti_qspi_enable_memory_map(spi);
+	ti_qspi_setup_mmap_read(spi, read_opcode, addr_width,
+				dummy_bytes);
+
+	if (qspi_is_busy(qspi)) {
+		ret = -EBUSY;
+		goto err;
+	}
+
+	memcpy(buf, (__force void *)(qspi->mmap_base + from), len);
+	*retlen = len;
+
+err:
+	ti_qspi_disable_memory_map(spi);
+	pm_runtime_put(qspi->dev);
+	mutex_unlock(&qspi->list_lock);
+	spi_bus_unlock(qspi->master);
+	return ret;
+}
+
 static int ti_qspi_start_transfer_one(struct spi_master *master,
 		struct spi_message *m)
 {
@@ -479,6 +576,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	master->setup = ti_qspi_setup;
 	master->auto_runtime_pm = true;
 	master->transfer_one_message = ti_qspi_start_transfer_one;
+	master->spi_mtd_mmap_read = ti_qspi_spi_mtd_mmap_read;
 	master->dev.of_node = pdev->dev.of_node;
 	master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(16) |
 				     SPI_BPW_MASK(8);
-- 
2.5.1
