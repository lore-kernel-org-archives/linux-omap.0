From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: [RFC/PATCH 2/2] driver: spi: Add quad spi read support
Date: Fri, 26 Jul 2013 22:45:22 +0530
Message-ID: <1374858922-14637-3-git-send-email-sourav.poddar@ti.com>
References: <1374858922-14637-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1374858922-14637-1-git-send-email-sourav.poddar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, Sourav, Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Since, qspi controller uses quad read.

Configuring the command register, if the transfer of data needs
dual or quad lines.

This patch has been done on top of the following patch[1], which is the
basic idea of adding dual/quad support in spi framework.
$subject patch will undergo changes with the ongoing discussion in the
community.

This patch is posted to demonstrate how patch 1 of the series will support
quad read. 

[1]: http://comments.gmane.org/gmane.linux.kernel.spi.devel/14047

Signed-off-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/spi-ti-qspi.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 7c848c8..679c813 100644
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
@@ -290,6 +291,7 @@ static void qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t)
 {
 	u8 *rxbuf;
 	int wlen, count;
+	unsigned cmd = qspi->cmd;
 
 	count = t->len;
 	rxbuf = t->rx_buf;
@@ -299,8 +301,18 @@ static void qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t)
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


------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
