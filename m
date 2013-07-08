From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: [RFC/PATCH 3/3] driver: spi: Add quad spi read support
Date: Mon, 8 Jul 2013 19:13:00 +0530
Message-ID: <1373290980-17883-4-git-send-email-sourav.poddar@ti.com>
References: <1373290980-17883-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1373290980-17883-1-git-send-email-sourav.poddar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Since, qspi controller uses quad read.

Configuring the command register, if the transfer of data needs
quad lines.

This patch has been done on top of the following patch[1], which is still
under review/comments.
This patch will also go changes, as the parent patch[1] does.

[1]: http://comments.gmane.org/gmane.linux.kernel.spi.devel/14047

Signed-off-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/spi-ti-qspi.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 430de9c..307cbed 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -258,8 +258,12 @@ static int qspi_read_msg(struct dra7xxx_qspi *qspi, struct spi_transfer *t)
 			qspi->cmd | QSPI_RD_SNGL, qspi->dc);
 		dra7xxx_writel(qspi, QSPI_WC_INT_EN, QSPI_INTR_ENABLE_SET_REG);
 		dra7xxx_writel(qspi, qspi->dc, QSPI_SPI_DC_REG);
-		dra7xxx_writel(qspi, qspi->cmd | QSPI_RD_SNGL,
-			QSPI_SPI_CMD_REG);
+		if (t->bitwidth == SPI_BITWIDTH_QUAD)
+			dra7xxx_writel(qspi, qspi->cmd | QSPI_RD_QUAD,
+				QSPI_SPI_CMD_REG);
+		else
+			dra7xxx_writel(qspi, qspi->cmd | QSPI_RD_SNGL,
+				QSPI_SPI_CMD_REG);
 		wait_for_completion(&qspi->word_complete);
 		*rxbuf++ = dra7xxx_readl_data(qspi, QSPI_SPI_DATA_REG, wlen);
 		dev_dbg(qspi->dev, "rx done, read %02x\n", *(rxbuf-1));
-- 
1.7.1


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
