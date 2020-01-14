From: Jean Pihet <jean.pihet-OTs2U3NB0ngRmelmmXo44Q@public.gmane.org>
Subject: [PATCH 1/2] spi: spi-ti-qspi: support large flash devices
Date: Tue, 14 Jan 2020 13:41:24 +0100
Message-ID: <20200114124125.361429-2-jean.pihet@newoldbits.com>
References: <20200114124125.361429-1-jean.pihet@newoldbits.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200114124125.361429-1-jean.pihet-OTs2U3NB0ngRmelmmXo44Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ryan Barnett <ryan.barnett-lFk7bPDcGtkY5TsXZYaR1UEOCMrvLtNR@public.gmane.org>, Conrad Ratschan <conrad.ratschan-lFk7bPDcGtkY5TsXZYaR1UEOCMrvLtNR@public.gmane.org>, Arnout Vandecappelle <arnout.vandecappelle-buIOx9BAs4sybS5Ee8rs3A@public.gmane.org>, Jean Pihet <jean.pihet-OTs2U3NB0ngRmelmmXo44Q@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The TI QSPI IP has limitations:
- the MMIO region is 64MB in size
- in non-MMIO mode, the transfer can handle 4096 words max.

Add support for bigger devices.
Use MMIO and DMA transfers below the 64MB boundary, use
software generated transfers above.

Signed-off-by: Jean Pihet <jean.pihet-OTs2U3NB0ngRmelmmXo44Q@public.gmane.org>
Cc: Ryan Barnett <ryan.barnett-lFk7bPDcGtkY5TsXZYaR1UEOCMrvLtNR@public.gmane.org>
Cc: Conrad Ratschan <conrad.ratschan-lFk7bPDcGtkY5TsXZYaR1UEOCMrvLtNR@public.gmane.org>
Cc: Arnout Vandecappelle <arnout.vandecappelle-buIOx9BAs4sybS5Ee8rs3A@public.gmane.org>
---
 drivers/spi/spi-ti-qspi.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index ad2942b3d0a9..0334e2926998 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -525,6 +525,35 @@ static void ti_qspi_setup_mmap_read(struct spi_device *spi, u8 opcode,
 		      QSPI_SPI_SETUP_REG(spi->chip_select));
 }
 
+static int ti_qspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
+{
+	struct ti_qspi *qspi = spi_controller_get_devdata(mem->spi->master);
+	size_t max_len;
+
+	if (op->data.dir == SPI_MEM_DATA_IN) {
+		if (op->addr.val < qspi->mmap_size) {
+			/* Limit MMIO to the mmaped region */
+			if (op->addr.val + op->data.nbytes > qspi->mmap_size) {
+				max_len = qspi->mmap_size - op->addr.val;
+				op->data.nbytes = min((size_t) op->data.nbytes,
+						      max_len);
+			}
+		} else {
+			/*
+			 * Use fallback mode (SW generated transfers) above the
+			 * mmaped region.
+			 * Adjust size to comply with the QSPI max frame length.
+			 */
+			max_len = QSPI_FRAME;
+			max_len -= 1 + op->addr.nbytes + op->dummy.nbytes;
+			op->data.nbytes = min((size_t) op->data.nbytes,
+					      max_len);
+		}
+	}
+
+	return 0;
+}
+
 static int ti_qspi_exec_mem_op(struct spi_mem *mem,
 			       const struct spi_mem_op *op)
 {
@@ -575,6 +604,7 @@ static int ti_qspi_exec_mem_op(struct spi_mem *mem,
 
 static const struct spi_controller_mem_ops ti_qspi_mem_ops = {
 	.exec_op = ti_qspi_exec_mem_op,
+	.adjust_op_size = ti_qspi_adjust_op_size,
 };
 
 static int ti_qspi_start_transfer_one(struct spi_master *master,
-- 
2.24.1
