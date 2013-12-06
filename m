From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv2 04/10] spi/qspi: configure set up register for memory map.
Date: Fri, 6 Dec 2013 19:54:45 +0530
Message-ID: <1386339891-32717-5-git-send-email-sourav.poddar@ti.com>
References: <1386339891-32717-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60036 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759209Ab3LFOZs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Dec 2013 09:25:48 -0500
In-Reply-To: <1386339891-32717-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@kernel.org, linux-spi@vger.kernel.org, computersforpeace@gmail.com, marex@denx.de
Cc: dwmw2@infradead.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, balbi@ti.com, Sourav Poddar <sourav.poddar@ti.com>

These add api to configure set up registers which will be used
for memory mapped operations.

These was provided as a pointer in the earlier patch and can be
used by the slave devices to configure the master controller as an
when required according to the usecases.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 drivers/spi/spi-ti-qspi.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 48294d1..e4a8afc 100644
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
@@ -220,6 +224,30 @@ static int ti_qspi_setup(struct spi_device *spi)
 	return 0;
 }
 
+static void ti_qspi_configure_from_slave(struct spi_device *spi)
+{
+	struct ti_qspi  *qspi = spi_master_get_devdata(spi->master);
+	struct slave_info info = spi->info;
+	u32 memval, mode;
+
+	mode = spi->mode & (SPI_RX_DUAL | SPI_RX_QUAD);
+	memval =  (info.read_opcode << 0) | (info.program_opcode << 16) |
+		((info.addr_width - 1) << 8) | (info.dummy_cycles << 10);
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
@@ -488,6 +516,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	master->dev.of_node = pdev->dev.of_node;
 	master->bits_per_word_mask = BIT(32 - 1) | BIT(16 - 1) | BIT(8 - 1);
 	master->mmap = true;
+	master->configure_from_slave = ti_qspi_configure_from_slave;
 
 	if (!of_property_read_u32(np, "num-cs", &num_cs))
 		master->num_chipselect = num_cs;
-- 
1.7.1

