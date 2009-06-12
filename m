From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH] OMAP: McSPI: Fix RX DMA transfer path
Date: Fri, 12 Jun 2009 15:31:50 +0300
Message-ID: <1244809910-4014-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:24738 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753743AbZFLMcB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jun 2009 08:32:01 -0400
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dbrownell@users.sourceforge.net, spi-devel-general@lists.sourceforge.net
Cc: linux-omap@vger.kernel.org, Eero Nurkkala <ext-eero.nurkkala@nokia.com>

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

When data is read through DMA, the last element must be read separately
through the RX register. It cannot be transferred by the DMA. For further
details see e.g. OMAP3430 TRM.

Without the fix the driver causes extra clocks to be clocked to the
bus after DMA RX operations. This can cause interesting behaviour with
some devices.

Reported-by: Juuso Oikarinen <juuso.oikarinen@nokia.com>
Signed-off-by: Juuso Oikarinen <juuso.oikarinen@nokia.com>
Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
[aaro.koskinen@nokia.com: Simplified the patch while keeping the idea.]
Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 drivers/spi/omap2_mcspi.c |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index d6d0c5d..0f640b0 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -269,7 +269,7 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 
 	if (rx != NULL) {
 		omap_set_dma_transfer_params(mcspi_dma->dma_rx_channel,
-				data_type, element_count, 1,
+				data_type, element_count - 1, 1,
 				OMAP_DMA_SYNC_ELEMENT,
 				mcspi_dma->dma_rx_sync_dev, 1);
 
@@ -300,6 +300,25 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	if (rx != NULL) {
 		wait_for_completion(&mcspi_dma->dma_rx_completion);
 		dma_unmap_single(NULL, xfer->rx_dma, count, DMA_FROM_DEVICE);
+		omap2_mcspi_set_enable(spi, 0);
+		if (likely(mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHSTAT0) &
+			OMAP2_MCSPI_CHSTAT_RXS)) {
+			u32 w;
+
+			w = mcspi_read_cs_reg(spi, OMAP2_MCSPI_RX0);
+			if (word_len <= 8)
+				((u8 *)xfer->rx_buf)[element_count - 1] = w;
+			else if (word_len <= 16)
+				((u16 *)xfer->rx_buf)[element_count - 1] = w;
+			else /* word_len <= 32 */
+				((u32 *)xfer->rx_buf)[element_count - 1] = w;
+		} else {
+			dev_err(&spi->dev, "DMA RX last word empty");
+			count -= (word_len <= 8)  ? 1 :
+				 (word_len <= 16) ? 2 :
+			       /* word_len <= 32 */ 4;
+		}
+		omap2_mcspi_set_enable(spi, 1);
 	}
 	return count;
 }
-- 
1.5.4.3

