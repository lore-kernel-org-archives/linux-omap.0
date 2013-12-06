From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv2 03/10] spi/qspi: Add support to switc to memory mapped operation.
Date: Fri, 6 Dec 2013 19:54:44 +0530
Message-ID: <1386339891-32717-4-git-send-email-sourav.poddar@ti.com>
References: <1386339891-32717-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60035 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752987Ab3LFOZs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Dec 2013 09:25:48 -0500
In-Reply-To: <1386339891-32717-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@kernel.org, linux-spi@vger.kernel.org, computersforpeace@gmail.com, marex@denx.de
Cc: dwmw2@infradead.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, balbi@ti.com, Sourav Poddar <sourav.poddar@ti.com>

These add apis that can be used to switch to memory mapped operatons
by configuring control module and qspi registers.
It also add "master->mmap" property to show that qspi
supports memory mapped operation.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
v1->v2:
 Squash a patch to add mater->mmap here itself.
 drivers/spi/spi-ti-qspi.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index a0cee08..48294d1 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -113,6 +113,10 @@ struct ti_qspi {
 #define QSPI_CSPOL(n)			(1 << (1 + n * 8))
 #define QSPI_CKPOL(n)			(1 << (n * 8))
 
+#define MM_SWITCH	(1 << 0)
+#define MEM_CS		(1 << 8)
+#define MEM_CS_DIS	(0 << 8)
+
 #define	QSPI_FRAME			4096
 
 #define QSPI_AUTOSUSPEND_TIMEOUT         2000
@@ -129,6 +133,30 @@ static inline void ti_qspi_write(struct ti_qspi *qspi,
 	writel(val, qspi->base + reg);
 }
 
+static void enable_qspi_memory_mapped(struct ti_qspi *qspi)
+{
+	u32 val;
+
+	ti_qspi_write(qspi, MM_SWITCH, QSPI_SPI_SWITCH_REG);
+	if (qspi->ctrl_mod) {
+		val = readl(qspi->ctrl_base);
+		val |= MEM_CS;
+		writel(val, qspi->ctrl_base);
+	}
+}
+
+static void disable_qspi_memory_mapped(struct ti_qspi *qspi)
+{
+	u32 val;
+
+	ti_qspi_write(qspi, ~MM_SWITCH, QSPI_SPI_SWITCH_REG);
+	if (qspi->ctrl_mod) {
+		val = readl(qspi->ctrl_base);
+		val &= MEM_CS_DIS;
+		writel(val, qspi->ctrl_base);
+	}
+}
+
 static int ti_qspi_setup(struct spi_device *spi)
 {
 	struct ti_qspi	*qspi = spi_master_get_devdata(spi->master);
@@ -459,6 +487,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	master->transfer_one_message = ti_qspi_start_transfer_one;
 	master->dev.of_node = pdev->dev.of_node;
 	master->bits_per_word_mask = BIT(32 - 1) | BIT(16 - 1) | BIT(8 - 1);
+	master->mmap = true;
 
 	if (!of_property_read_u32(np, "num-cs", &num_cs))
 		master->num_chipselect = num_cs;
-- 
1.7.1

