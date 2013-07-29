From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [RFC/PATCH 2/2] driver: spi: Add quad spi read support
Date: Mon, 29 Jul 2013 12:52:30 +0530
Message-ID: <1375082550-30544-3-git-send-email-sourav.poddar@ti.com>
References: <1375082550-30544-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47530 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767Ab3G2HWy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Jul 2013 03:22:54 -0400
In-Reply-To: <1375082550-30544-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@kernel.org, spi-devel-general@lists.sourceforge.net, grant.likely@linaro.org
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, balbi@ti.com, Sourav Poddar <sourav.poddar@ti.com>

Since, qspi controller uses quad read.

Configuring the command register, if the transfer of data needs
dual or quad lines.

This patch has been done on top of the following patch[1], which is just the
basic idea of adding dual/quad support in spi framework.
$subject patch will undergo changes with the ongoing discussion in the
community.

This patch is posted to demonstrate how patch 1 of the series will support
quad read.

[1]: http://comments.gmane.org/gmane.linux.kernel.spi.devel/14047

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 drivers/spi/spi-ti-qspi.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 51fe95f..8a32b1c 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -86,6 +86,7 @@ struct ti_qspi {
 #define QSPI_3_PIN			(1 << 18)
 #define QSPI_RD_SNGL			(1 << 16)
 #define QSPI_WR_SNGL			(2 << 16)
+#define	QSPI_RD_DUAL			(3 << 16)
 #define QSPI_RD_QUAD			(7 << 16)
 #define QSPI_INVAL			(4 << 16)
 #define QSPI_WC_CMD_INT_EN			(1 << 14)
@@ -264,6 +265,7 @@ static void qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t)
 {
 	u8 *rxbuf;
 	int wlen, count;
+	unsigned cmd = qspi->cmd;
 
 	count = t->len;
 	rxbuf = t->rx_buf;
@@ -273,8 +275,18 @@ static void qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t)
 		dev_dbg(qspi->dev, "rx cmd %08x dc %08x\n",
 			qspi->cmd | QSPI_RD_SNGL, qspi->dc);
 		ti_qspi_write(qspi, qspi->dc, QSPI_SPI_DC_REG);
-		ti_qspi_write(qspi, qspi->cmd | QSPI_RD_SNGL,
-			QSPI_SPI_CMD_REG);
+		switch (t->bitwidth) {
+		case SPI_BITWIDTH_QUAD:
+			cmd |= QSPI_RD_QUAD;
+			break;
+		case SPI_BITWIDTH_DUAL:
+			cmd |= QSPI_RD_DUAL;
+			break;
+		case SPI_BITWIDTH_SINGLE:
+		default:
+			cmd |= QSPI_RD_SNGL;
+		}
+		ti_qspi_writel(qspi, cmd, QSPI_SPI_CMD_REG);
 		ti_qspi_write(qspi, QSPI_WC_INT_EN, QSPI_INTR_ENABLE_SET_REG);
 		wait_for_completion(&qspi->transfer_complete);
 		ti_qspi_read_data(qspi, QSPI_SPI_DATA_REG, wlen, &rxbuf);
-- 
1.7.1

