From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [RFC/PATCH 2/2] driver: spi: Add quad spi read support
Date: Wed, 31 Jul 2013 11:17:53 +0530
Message-ID: <1375249673-2585-3-git-send-email-sourav.poddar@ti.com>
References: <1375249673-2585-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33354 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754374Ab3GaFsO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Jul 2013 01:48:14 -0400
In-Reply-To: <1375249673-2585-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@kernel.org, spi-devel-general@lists.sourceforge.net, grant.likely@linaro.org
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, balbi@ti.com, Sourav Poddar <sourav.poddar@ti.com>

Since, qspi controller uses quad read.

Configuring the command register, if the transfer of data needs
dual or quad lines.

This patch has been done on top of the following patch[1], which is just the
basic idea of adding dual/quad support in spi framework.
$subject patch will undergo changes once the ongoing discussion in the
community is freezed.

This patch is posted to demonstrate how patch 1 of the series will support
quad read.

[1]: http://comments.gmane.org/gmane.linux.kernel.spi.devel/14047

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 drivers/spi/spi-ti-qspi.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 02b67e9..a8c9587 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -273,6 +273,7 @@ static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t)
 {
 	u8 *rxbuf;
 	int wlen, count, ret;
+	unsigned cmd = qspi->cmd;
 
 	count = t->len;
 	rxbuf = t->rx_buf;
@@ -282,8 +283,18 @@ static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t)
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
+		ti_qspi_write(qspi, cmd, QSPI_SPI_CMD_REG);
 		ret = wait_for_completion_timeout(&qspi->transfer_complete,
 					QSPI_COMPLETION_TIMEOUT);
 		if (ret == 0) {
-- 
1.7.1

