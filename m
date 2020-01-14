From: Jean Pihet <jean.pihet-OTs2U3NB0ngRmelmmXo44Q@public.gmane.org>
Subject: [PATCH 2/2] spi: spi-ti-qspi: optimize byte-transfers
Date: Tue, 14 Jan 2020 13:41:25 +0100
Message-ID: <20200114124125.361429-3-jean.pihet@newoldbits.com>
References: <20200114124125.361429-1-jean.pihet@newoldbits.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200114124125.361429-1-jean.pihet-OTs2U3NB0ngRmelmmXo44Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ryan Barnett <ryan.barnett-lFk7bPDcGtkY5TsXZYaR1UEOCMrvLtNR@public.gmane.org>, Conrad Ratschan <conrad.ratschan-lFk7bPDcGtkY5TsXZYaR1UEOCMrvLtNR@public.gmane.org>, Arnout Vandecappelle <arnout.vandecappelle-buIOx9BAs4sybS5Ee8rs3A@public.gmane.org>, Jean Pihet <jean.pihet-OTs2U3NB0ngRmelmmXo44Q@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Optimize the 8-bit based transfers, as used by the SPI flash
devices, by reading the data registers by 32 and 128 bits when
possible and copy the contents to the receive buffer.

The speed improvement is 4.9x using quad read.

Signed-off-by: Jean Pihet <jean.pihet-OTs2U3NB0ngRmelmmXo44Q@public.gmane.org>
Cc: Ryan Barnett <ryan.barnett-lFk7bPDcGtkY5TsXZYaR1UEOCMrvLtNR@public.gmane.org>
Cc: Conrad Ratschan <conrad.ratschan-lFk7bPDcGtkY5TsXZYaR1UEOCMrvLtNR@public.gmane.org>
Cc: Arnout Vandecappelle <arnout.vandecappelle-buIOx9BAs4sybS5Ee8rs3A@public.gmane.org>
---
 drivers/spi/spi-ti-qspi.c | 54 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 0334e2926998..858fda8ac73e 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -314,6 +314,8 @@ static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t,
 {
 	int wlen;
 	unsigned int cmd;
+	u32 rx;
+	u8 rxlen, rx_wlen;
 	u8 *rxbuf;
 
 	rxbuf = t->rx_buf;
@@ -336,14 +338,60 @@ static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t,
 		if (qspi_is_busy(qspi))
 			return -EBUSY;
 
+		switch (wlen) {
+		case 1:
+			/*
+			 * Optimize the 8-bit words transfers, as used by
+			 * the SPI flash devices.
+			 */
+			if (count >= QSPI_WLEN_MAX_BYTES) {
+				rxlen = QSPI_WLEN_MAX_BYTES;
+			} else {
+				rxlen = min(count, 4);
+			}
+			rx_wlen = rxlen << 3;
+			cmd &= ~QSPI_WLEN_MASK;
+			cmd |= QSPI_WLEN(rx_wlen);
+			break;
+		default:
+			rxlen = wlen;
+			break;
+		}
+
 		ti_qspi_write(qspi, cmd, QSPI_SPI_CMD_REG);
 		if (ti_qspi_poll_wc(qspi)) {
 			dev_err(qspi->dev, "read timed out\n");
 			return -ETIMEDOUT;
 		}
+
 		switch (wlen) {
 		case 1:
-			*rxbuf = readb(qspi->base + QSPI_SPI_DATA_REG);
+			/*
+			 * Optimize the 8-bit words transfers, as used by
+			 * the SPI flash devices.
+			 */
+			if (count >= QSPI_WLEN_MAX_BYTES) {
+				u32 *rxp = (u32 *) rxbuf;
+				rx = readl(qspi->base + QSPI_SPI_DATA_REG_3);
+				*rxp++ = be32_to_cpu(rx);
+				rx = readl(qspi->base + QSPI_SPI_DATA_REG_2);
+				*rxp++ = be32_to_cpu(rx);
+				rx = readl(qspi->base + QSPI_SPI_DATA_REG_1);
+				*rxp++ = be32_to_cpu(rx);
+				rx = readl(qspi->base + QSPI_SPI_DATA_REG);
+				*rxp++ = be32_to_cpu(rx);
+			} else {
+				u8 *rxp = rxbuf;
+				rx = readl(qspi->base + QSPI_SPI_DATA_REG);
+				if (rx_wlen >= 8)
+					*rxp++ = rx >> (rx_wlen - 8);
+				if (rx_wlen >= 16)
+					*rxp++ = rx >> (rx_wlen - 16);
+				if (rx_wlen >= 24)
+					*rxp++ = rx >> (rx_wlen - 24);
+				if (rx_wlen >= 32)
+					*rxp++ = rx;
+			}
 			break;
 		case 2:
 			*((u16 *)rxbuf) = readw(qspi->base + QSPI_SPI_DATA_REG);
@@ -352,8 +400,8 @@ static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t,
 			*((u32 *)rxbuf) = readl(qspi->base + QSPI_SPI_DATA_REG);
 			break;
 		}
-		rxbuf += wlen;
-		count -= wlen;
+		rxbuf += rxlen;
+		count -= rxlen;
 	}
 
 	return 0;
-- 
2.24.1
