From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v5 2/5] spi: spi-ti-qspi: add mmap mode read support
Date: Fri, 11 Dec 2015 09:39:57 +0530
Message-ID: <1449807000-6457-3-git-send-email-vigneshr@ti.com>
References: <1449807000-6457-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449807000-6457-1-git-send-email-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
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

Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
---

v5:
 * use syscon to access ctrl_mod register.

 drivers/spi/spi-ti-qspi.c | 139 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 110 insertions(+), 29 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 64318fcfacf2..eac3c960b2de 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -31,6 +31,8 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 #include <linux/spi/spi.h>
 
@@ -44,8 +46,9 @@ struct ti_qspi {
 
 	struct spi_master	*master;
 	void __iomem            *base;
-	void __iomem            *ctrl_base;
 	void __iomem            *mmap_base;
+	struct regmap		*ctrl_base;
+	unsigned int		ctrl_reg;
 	struct clk		*fclk;
 	struct device           *dev;
 
@@ -55,7 +58,7 @@ struct ti_qspi {
 	u32 cmd;
 	u32 dc;
 
-	bool ctrl_mod;
+	bool mmap_enabled;
 };
 
 #define QSPI_PID			(0x0)
@@ -65,11 +68,8 @@ struct ti_qspi {
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
@@ -109,6 +109,17 @@ struct ti_qspi {
 
 #define QSPI_AUTOSUSPEND_TIMEOUT         2000
 
+#define MEM_CS_EN(n)			((n + 1) << 8)
+#define MEM_CS_MASK			(7 << 8)
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
@@ -366,6 +377,72 @@ static int qspi_transfer_msg(struct ti_qspi *qspi, struct spi_transfer *t)
 	return 0;
 }
 
+static void ti_qspi_enable_memory_map(struct spi_device *spi)
+{
+	struct ti_qspi  *qspi = spi_master_get_devdata(spi->master);
+
+	ti_qspi_write(qspi, MM_SWITCH, QSPI_SPI_SWITCH_REG);
+	if (qspi->ctrl_base) {
+		regmap_update_bits(qspi->ctrl_base, qspi->ctrl_reg,
+				   MEM_CS_EN(spi->chip_select),
+				   MEM_CS_MASK);
+	}
+	qspi->mmap_enabled = true;
+}
+
+static void ti_qspi_disable_memory_map(struct spi_device *spi)
+{
+	struct ti_qspi  *qspi = spi_master_get_devdata(spi->master);
+
+	ti_qspi_write(qspi, 0, QSPI_SPI_SWITCH_REG);
+	if (qspi->ctrl_base)
+		regmap_update_bits(qspi->ctrl_base, qspi->ctrl_reg,
+				   0, MEM_CS_MASK);
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
@@ -398,6 +475,9 @@ static int ti_qspi_start_transfer_one(struct spi_master *master,
 
 	mutex_lock(&qspi->list_lock);
 
+	if (qspi->mmap_enabled)
+		ti_qspi_disable_memory_map(spi);
+
 	list_for_each_entry(t, &m->transfers, transfer_list) {
 		qspi->cmd |= QSPI_WLEN(t->bits_per_word);
 
@@ -441,7 +521,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 {
 	struct  ti_qspi *qspi;
 	struct spi_master *master;
-	struct resource         *r, *res_ctrl, *res_mmap;
+	struct resource         *r, *res_mmap;
 	struct device_node *np = pdev->dev.of_node;
 	u32 max_freq;
 	int ret = 0, num_cs, irq;
@@ -487,16 +567,6 @@ static int ti_qspi_probe(struct platform_device *pdev)
 		}
 	}
 
-	res_ctrl = platform_get_resource_byname(pdev,
-			IORESOURCE_MEM, "qspi_ctrlmod");
-	if (res_ctrl == NULL) {
-		res_ctrl = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-		if (res_ctrl == NULL) {
-			dev_dbg(&pdev->dev,
-				"control module resources not required\n");
-		}
-	}
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "no irq resource?\n");
@@ -511,20 +581,31 @@ static int ti_qspi_probe(struct platform_device *pdev)
 		goto free_master;
 	}
 
-	if (res_ctrl) {
-		qspi->ctrl_mod = true;
-		qspi->ctrl_base = devm_ioremap_resource(&pdev->dev, res_ctrl);
-		if (IS_ERR(qspi->ctrl_base)) {
-			ret = PTR_ERR(qspi->ctrl_base);
-			goto free_master;
-		}
-	}
-
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
+		}
+	}
+	qspi->mmap_enabled = false;
+
+	if (of_property_read_bool(np, "syscon-chipselects")) {
+		qspi->ctrl_base =
+		syscon_regmap_lookup_by_phandle(np,
+						"syscon-chipselects");
+		if (IS_ERR(qspi->ctrl_base))
+			return PTR_ERR(qspi->ctrl_base);
+		ret = of_property_read_u32_index(np,
+						 "syscon-chipselects",
+						 1, &qspi->ctrl_reg);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"couldn't get ctrl_mod reg index\n");
+			return ret;
 		}
 	}
 
-- 
2.6.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
