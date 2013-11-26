From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH 07/17] spi/qspi: configure set up register for memory map..
Date: Tue, 26 Nov 2013 13:05:03 +0530
Message-ID: <1385451313-1875-8-git-send-email-sourav.poddar@ti.com>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59124 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754618Ab3KZHgM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Nov 2013 02:36:12 -0500
In-Reply-To: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: computersforpeace@gmail.com, broonie@kernel.org, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Cc: balbi@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, Sourav Poddar <sourav.poddar@ti.com>

These add api to configure set up registers which will be used
for memory mapped operations.

These was provided as a pointer in the earlier patch and can be
used by the slave devices to configure the master controller as an
when required according to the usecases.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 drivers/spi/spi-ti-qspi.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 40f1c35..2323572 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -117,6 +117,10 @@ struct ti_qspi {
 #define MEM_CS		(1 << 8)
 #define MEM_CS_DIS	(0 << 8)
 
+#define QSPI_SETUP0_RD_NORMAL   (0x0 << 12)
+#define QSPI_SETUP0_RD_DUAL     (0x1 << 12)
+#define QSPI_SETUP0_RD_QUAD     (0x3 << 12)
+
 #define	QSPI_FRAME			4096
 
 #define QSPI_AUTOSUSPEND_TIMEOUT         2000
@@ -220,6 +224,29 @@ static int ti_qspi_setup(struct spi_device *spi)
 	return 0;
 }
 
+static void ti_qspi_configure_from_slave(struct spi_device *spi, u8 *val)
+{
+	struct ti_qspi  *qspi = spi_master_get_devdata(spi->master);
+	u32 memval, mode;
+
+	mode = spi->mode & (SPI_RX_DUAL | SPI_RX_QUAD);
+	memval =  (val[0] << 0) | (val[1] << 16) |
+			((val[2] - 1) << 8) | (val[3] << 10);
+
+	switch (mode) {
+	case SPI_RX_DUAL:
+		memval |= QSPI_SETUP0_RD_DUAL;
+		break;
+	case SPI_RX_QUAD:
+		memval |= QSPI_SETUP0_RD_QUAD;
+		break;
+	default:
+		memval |= QSPI_SETUP0_RD_NORMAL;
+		break;
+	}
+	ti_qspi_write(qspi, memval, QSPI_SPI_SETUP0_REG);
+}
+
 static void ti_qspi_restore_ctx(struct ti_qspi *qspi)
 {
 	struct ti_qspi_regs *ctx_reg = &qspi->ctx_reg;
@@ -487,6 +514,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	master->transfer_one_message = ti_qspi_start_transfer_one;
 	master->dev.of_node = pdev->dev.of_node;
 	master->bits_per_word_mask = BIT(32 - 1) | BIT(16 - 1) | BIT(8 - 1);
+	master->configure_from_slave = ti_qspi_configure_from_slave;
 
 	if (!of_property_read_u32(np, "num-cs", &num_cs))
 		master->num_chipselect = num_cs;
-- 
1.7.1

