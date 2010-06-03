From: felipe.balbi@nokia.com
Subject: [PATCH] spi: omap2_mcspi: make use of dev_vdbg()
Date: Thu,  3 Jun 2010 14:09:01 +0300
Message-ID: <1275563341-31078-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Roman Tereshonkov <roman.tereshonkov@nokia.com>, Andrew Morton <akpm@linux-foundation.org>, David Brownell <david-b@pacbell.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <felipe.balbi@nokia.com>
List-Id: linux-omap@vger.kernel.org

From: Felipe Balbi <felipe.balbi@nokia.com>

dev_vdbg() is only compiled when VERBOSE is defined, so
there's no need to wrap dev_dbg() on #ifdef VERBOSE .. #endif
as we can use dev_vdbg() directly.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/spi/omap2_mcspi.c |   36 +++++++++---------------------------
 1 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index b3a94ca..d703927 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -489,10 +489,8 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 					dev_err(&spi->dev, "TXS timed out\n");
 					goto out;
 				}
-#ifdef VERBOSE
-				dev_dbg(&spi->dev, "write-%d %02x\n",
+				dev_vdbg(&spi->dev, "write-%d %02x\n",
 						word_len, *tx);
-#endif
 				__raw_writel(*tx++, tx_reg);
 			}
 			if (rx != NULL) {
@@ -506,10 +504,8 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 				    (l & OMAP2_MCSPI_CHCONF_TURBO)) {
 					omap2_mcspi_set_enable(spi, 0);
 					*rx++ = __raw_readl(rx_reg);
-#ifdef VERBOSE
-					dev_dbg(&spi->dev, "read-%d %02x\n",
+					dev_vdbg(&spi->dev, "read-%d %02x\n",
 						    word_len, *(rx - 1));
-#endif
 					if (mcspi_wait_for_reg_bit(chstat_reg,
 						OMAP2_MCSPI_CHSTAT_RXS) < 0) {
 						dev_err(&spi->dev,
@@ -522,10 +518,8 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 				}
 
 				*rx++ = __raw_readl(rx_reg);
-#ifdef VERBOSE
-				dev_dbg(&spi->dev, "read-%d %02x\n",
+				dev_vdbg(&spi->dev, "read-%d %02x\n",
 						word_len, *(rx - 1));
-#endif
 			}
 		} while (c);
 	} else if (word_len <= 16) {
@@ -542,10 +536,8 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 					dev_err(&spi->dev, "TXS timed out\n");
 					goto out;
 				}
-#ifdef VERBOSE
-				dev_dbg(&spi->dev, "write-%d %04x\n",
+				dev_vdbg(&spi->dev, "write-%d %04x\n",
 						word_len, *tx);
-#endif
 				__raw_writel(*tx++, tx_reg);
 			}
 			if (rx != NULL) {
@@ -559,10 +551,8 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 				    (l & OMAP2_MCSPI_CHCONF_TURBO)) {
 					omap2_mcspi_set_enable(spi, 0);
 					*rx++ = __raw_readl(rx_reg);
-#ifdef VERBOSE
-					dev_dbg(&spi->dev, "read-%d %04x\n",
+					dev_vdbg(&spi->dev, "read-%d %04x\n",
 						    word_len, *(rx - 1));
-#endif
 					if (mcspi_wait_for_reg_bit(chstat_reg,
 						OMAP2_MCSPI_CHSTAT_RXS) < 0) {
 						dev_err(&spi->dev,
@@ -575,10 +565,8 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 				}
 
 				*rx++ = __raw_readl(rx_reg);
-#ifdef VERBOSE
-				dev_dbg(&spi->dev, "read-%d %04x\n",
+				dev_vdbg(&spi->dev, "read-%d %04x\n",
 						word_len, *(rx - 1));
-#endif
 			}
 		} while (c);
 	} else if (word_len <= 32) {
@@ -595,10 +583,8 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 					dev_err(&spi->dev, "TXS timed out\n");
 					goto out;
 				}
-#ifdef VERBOSE
-				dev_dbg(&spi->dev, "write-%d %08x\n",
+				dev_vdbg(&spi->dev, "write-%d %08x\n",
 						word_len, *tx);
-#endif
 				__raw_writel(*tx++, tx_reg);
 			}
 			if (rx != NULL) {
@@ -612,10 +598,8 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 				    (l & OMAP2_MCSPI_CHCONF_TURBO)) {
 					omap2_mcspi_set_enable(spi, 0);
 					*rx++ = __raw_readl(rx_reg);
-#ifdef VERBOSE
-					dev_dbg(&spi->dev, "read-%d %08x\n",
+					dev_vdbg(&spi->dev, "read-%d %08x\n",
 						    word_len, *(rx - 1));
-#endif
 					if (mcspi_wait_for_reg_bit(chstat_reg,
 						OMAP2_MCSPI_CHSTAT_RXS) < 0) {
 						dev_err(&spi->dev,
@@ -628,10 +612,8 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 				}
 
 				*rx++ = __raw_readl(rx_reg);
-#ifdef VERBOSE
-				dev_dbg(&spi->dev, "read-%d %08x\n",
+				dev_vdbg(&spi->dev, "read-%d %08x\n",
 						word_len, *(rx - 1));
-#endif
 			}
 		} while (c);
 	}
-- 
1.7.1
