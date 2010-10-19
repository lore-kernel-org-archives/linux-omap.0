From: Ilkka Koskinen <ilkka.koskinen@nokia.com>
Subject: [PATCH] spi/omap2_mcspi: Verify TX reg is empty after TX only xfer with DMA
Date: Tue, 19 Oct 2010 17:07:31 +0300
Message-ID: <1287497251-25058-1-git-send-email-ilkka.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:33555 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985Ab0JSOE0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Oct 2010 10:04:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dbrownell@users.sourceforge.net, grant.likely@secretlab.ca
Cc: tony@atomide.com, spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org

In case of TX only with DMA, the driver assumes that the data
has been transferred once DMA callback in invoked. However,
SPI's shift register may still contain data. Thus, the driver
is supposed to verify that the register is empty and the end of
the SPI transfer has been reached.

Signed-off-by: Ilkka Koskinen <ilkka.koskinen@nokia.com>
Tested-by: Tuomas Katila <ext-tuomas.2.katila@nokia.com>
---
 drivers/spi/omap2_mcspi.c |   39 ++++++++++++++++++++++++++-------------
 1 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index b3a94ca..a2e053c 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -296,6 +296,19 @@ static int omap2_mcspi_enable_clocks(struct omap2_mcspi *mcspi)
 	return 0;
 }
 
+static int mcspi_wait_for_reg_bit(void __iomem *reg, unsigned long bit)
+{
+	unsigned long timeout;
+
+	timeout = jiffies + msecs_to_jiffies(1000);
+	while (!(__raw_readl(reg) & bit)) {
+		if (time_after(jiffies, timeout))
+			return -1;
+		cpu_relax();
+	}
+	return 0;
+}
+
 static unsigned
 omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 {
@@ -309,11 +322,14 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	u32			l;
 	u8			* rx;
 	const u8		* tx;
+	void __iomem		*chstat_reg;
 
 	mcspi = spi_master_get_devdata(spi->master);
 	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
 	l = mcspi_cached_chconf0(spi);
 
+	chstat_reg = cs->base + OMAP2_MCSPI_CHSTAT0;
+
 	count = xfer->len;
 	c = count;
 	word_len = cs->word_len;
@@ -382,6 +398,16 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	if (tx != NULL) {
 		wait_for_completion(&mcspi_dma->dma_tx_completion);
 		dma_unmap_single(NULL, xfer->tx_dma, count, DMA_TO_DEVICE);
+
+		/* for TX_ONLY mode, be sure all words have shifted out */
+		if (rx == NULL) {
+			if (mcspi_wait_for_reg_bit(chstat_reg,
+						OMAP2_MCSPI_CHSTAT_TXS) < 0)
+				dev_err(&spi->dev, "TXS timed out\n");
+			else if (mcspi_wait_for_reg_bit(chstat_reg,
+						OMAP2_MCSPI_CHSTAT_EOT) < 0)
+				dev_err(&spi->dev, "EOT timed out\n");
+		}
 	}
 
 	if (rx != NULL) {
@@ -435,19 +461,6 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	return count;
 }
 
-static int mcspi_wait_for_reg_bit(void __iomem *reg, unsigned long bit)
-{
-	unsigned long timeout;
-
-	timeout = jiffies + msecs_to_jiffies(1000);
-	while (!(__raw_readl(reg) & bit)) {
-		if (time_after(jiffies, timeout))
-			return -1;
-		cpu_relax();
-	}
-	return 0;
-}
-
 static unsigned
 omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 {
-- 
1.6.0.4

