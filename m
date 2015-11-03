From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v2 2/5] spi: spi-ti-qspi: add mmap mode read support
Date: Tue, 3 Nov 2015 15:36:11 +0530
Message-ID: <1446545174-14193-3-git-send-email-vigneshr@ti.com>
References: <1446545174-14193-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446545174-14193-1-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Michal Suchanek <hramrach@gmail.com>, Russell King <linux@arm.linux.org.uk>, Vignesh R <vigneshr@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
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

Implement spi_mtd_mmap_read() callback to support mmap read over SPI
flash devices. With this, the read throughput increases from ~100kB/s to
~2.5 MB/s.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/spi/spi-ti-qspi.c | 92 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 88 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 69c1a95b0615..2f58fb7eb410 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -65,11 +65,8 @@ struct ti_qspi {
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
@@ -109,6 +106,16 @@ struct ti_qspi {
 
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
@@ -366,6 +373,82 @@ static int qspi_transfer_msg(struct ti_qspi *qspi, struct spi_transfer *t)
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
+	mutex_lock(&qspi->list_lock);
+
+	ti_qspi_enable_memory_map(spi);
+	ti_qspi_setup_mmap_read(spi, read_opcode, addr_width,
+				dummy_bytes);
+	memcpy_fromio(buf, qspi->mmap_base + from, len);
+	*retlen = len;
+	ti_qspi_disable_memory_map(spi);
+
+	mutex_unlock(&qspi->list_lock);
+
+	return ret;
+}
+
 static int ti_qspi_start_transfer_one(struct spi_master *master,
 		struct spi_message *m)
 {
@@ -526,6 +609,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 			ret = PTR_ERR(qspi->mmap_base);
 			goto free_master;
 		}
+		master->spi_mtd_mmap_read = ti_qspi_spi_mtd_mmap_read;
 	}
 
 	qspi->fclk = devm_clk_get(&pdev->dev, "fck");
-- 
2.6.2
