From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v4 2/5] spi: spi-ti-qspi: add mmap mode read support
Date: Mon, 30 Nov 2015 10:45:12 +0530
Message-ID: <1448860515-28336-3-git-send-email-vigneshr@ti.com>
References: <1448860515-28336-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448860515-28336-1-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Brian Norris <computersforpeace@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, hramrach@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

ti-qspi controller provides mmap port to read data from SPI flashes.
mmap port is enabled in QSPI_SPI_SWITCH_REG. ctrl module register may
also need to be accessed for some SoCs. The QSPI_SPI_SETUP_REGx needs to
be populated with flash specific information like read opcode, read
mode(quad, dual, normal), address width and dummy bytes. Once,
controller is in mmap mode, the whole flash memory is available as a
memory region at SoC specific address. This region can be accessed using
normal memcpy() (or mem-to-mem dma copy). The ti-qspi controller hardware
will internally communicate with SPI flash over SPI bus and get the
requested data.

Implement spi_flash_read() callback to support mmap read over SPI
flash devices. With this, the read throughput increases from ~100kB/s to
~2.5 MB/s.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---

 drivers/spi/spi-ti-qspi.c | 101 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 94 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 64318fcfacf2..cd4e63f45e65 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -56,6 +56,7 @@ struct ti_qspi {
 	u32 dc;
 
 	bool ctrl_mod;
+	bool mmap_enabled;
 };
 
 #define QSPI_PID			(0x0)
@@ -65,11 +66,8 @@ struct ti_qspi {
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
@@ -109,6 +107,16 @@ struct ti_qspi {
 
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
@@ -366,6 +374,78 @@ static int qspi_transfer_msg(struct ti_qspi *qspi, struct spi_transfer *t)
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
+		/* dummy readl to ensure bus sync */
+		readl(qspi->ctrl_base);
+	}
+	qspi->mmap_enabled = true;
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
+	qspi->mmap_enabled = false;
+}
+
+static void ti_qspi_setup_mmap_read(struct spi_device *spi,
+				    struct spi_flash_read_message *msg)
+{
+	struct ti_qspi  *qspi = spi_master_get_devdata(spi->master);
+	u32 memval = msg->read_opcode;
+
+	switch (msg->data_nbits) {
+	case SPI_NBITS_QUAD:
+		memval |= QSPI_SETUP_RD_QUAD;
+		break;
+	case SPI_NBITS_DUAL:
+		memval |= QSPI_SETUP_RD_DUAL;
+		break;
+	default:
+		memval |= QSPI_SETUP_RD_NORMAL;
+		break;
+	}
+	memval |= ((msg->addr_width - 1) << QSPI_SETUP_ADDR_SHIFT |
+		   msg->dummy_bytes << QSPI_SETUP_DUMMY_SHIFT);
+	ti_qspi_write(qspi, memval,
+		      QSPI_SPI_SETUP_REG(spi->chip_select));
+}
+
+static int ti_qspi_spi_flash_read(struct  spi_device *spi,
+				  struct spi_flash_read_message *msg)
+{
+	struct ti_qspi *qspi = spi_master_get_devdata(spi->master);
+	int ret = 0;
+
+	mutex_lock(&qspi->list_lock);
+
+	if (!qspi->mmap_enabled)
+		ti_qspi_enable_memory_map(spi);
+	ti_qspi_setup_mmap_read(spi, msg);
+	memcpy_fromio(msg->buf, qspi->mmap_base + msg->from, msg->len);
+	msg->retlen = msg->len;
+
+	mutex_unlock(&qspi->list_lock);
+
+	return ret;
+}
+
 static int ti_qspi_start_transfer_one(struct spi_master *master,
 		struct spi_message *m)
 {
@@ -398,6 +478,9 @@ static int ti_qspi_start_transfer_one(struct spi_master *master,
 
 	mutex_lock(&qspi->list_lock);
 
+	if (qspi->mmap_enabled)
+		ti_qspi_disable_memory_map(spi);
+
 	list_for_each_entry(t, &m->transfers, transfer_list) {
 		qspi->cmd |= QSPI_WLEN(t->bits_per_word);
 
@@ -521,12 +604,16 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	}
 
 	if (res_mmap) {
-		qspi->mmap_base = devm_ioremap_resource(&pdev->dev, res_mmap);
+		qspi->mmap_base = devm_ioremap_resource(&pdev->dev,
+							res_mmap);
+		master->spi_flash_read = ti_qspi_spi_flash_read;
 		if (IS_ERR(qspi->mmap_base)) {
-			ret = PTR_ERR(qspi->mmap_base);
-			goto free_master;
+			dev_err(&pdev->dev,
+				"falling back to PIO mode\n");
+			master->spi_flash_read = NULL;
 		}
 	}
+	qspi->mmap_enabled = false;
 
 	qspi->fclk = devm_clk_get(&pdev->dev, "fck");
 	if (IS_ERR(qspi->fclk)) {
-- 
2.6.3
