From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH] spi: spi-omap2-mcspi.c: fix coding style
Date: Thu, 24 Jan 2013 13:28:58 +0100
Message-ID: <1359030538-2866-1-git-send-email-matthias.bgg@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:41971 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754298Ab3AXM3k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jan 2013 07:29:40 -0500
Received: by mail-wg0-f45.google.com with SMTP id dq12so1417412wgb.24
        for <linux-omap@vger.kernel.org>; Thu, 24 Jan 2013 04:29:38 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca, tony@atomide.com, broonie@opensource.wolfsonmicro.com, jarkko.nikula@bitmer.com, zonque@gmail.com, gregkh@linuxfoundation.org, spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, trivial@kernel.org
Cc: Matthias Brugger <matthias.bgg@gmail.com>

This patch fixes some indentation errors.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/spi/spi-omap2-mcspi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index b610f52..31f6e84 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1020,7 +1020,7 @@ static void omap2_mcspi_work(struct omap2_mcspi *mcspi, struct spi_message *m)
 }
 
 static int omap2_mcspi_transfer_one_message(struct spi_master *master,
-						struct spi_message *m)
+		struct spi_message *m)
 {
 	struct omap2_mcspi	*mcspi;
 	struct spi_transfer	*t;
@@ -1041,7 +1041,7 @@ static int omap2_mcspi_transfer_one_message(struct spi_master *master,
 				|| (len && !(rx_buf || tx_buf))
 				|| (t->bits_per_word &&
 					(  t->bits_per_word < 4
-					|| t->bits_per_word > 32))) {
+					   || t->bits_per_word > 32))) {
 			dev_dbg(mcspi->dev, "transfer: %d Hz, %d %s%s, %d bpw\n",
 					t->speed_hz,
 					len,
@@ -1052,8 +1052,8 @@ static int omap2_mcspi_transfer_one_message(struct spi_master *master,
 		}
 		if (t->speed_hz && t->speed_hz < (OMAP2_MCSPI_MAX_FREQ >> 15)) {
 			dev_dbg(mcspi->dev, "speed_hz %d below minimum %d Hz\n",
-				t->speed_hz,
-				OMAP2_MCSPI_MAX_FREQ >> 15);
+					t->speed_hz,
+					OMAP2_MCSPI_MAX_FREQ >> 15);
 			return -EINVAL;
 		}
 
@@ -1099,7 +1099,7 @@ static int omap2_mcspi_master_setup(struct omap2_mcspi *mcspi)
 		return ret;
 
 	mcspi_write_reg(master, OMAP2_MCSPI_WAKEUPENABLE,
-				OMAP2_MCSPI_WAKEUPENABLE_WKEN);
+			OMAP2_MCSPI_WAKEUPENABLE_WKEN);
 	ctx->wakeupenable = OMAP2_MCSPI_WAKEUPENABLE_WKEN;
 
 	omap2_mcspi_set_master_mode(master);
@@ -1228,7 +1228,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 
 		sprintf(dma_ch_name, "rx%d", i);
 		dma_res = platform_get_resource_byname(pdev, IORESOURCE_DMA,
-							dma_ch_name);
+				dma_ch_name);
 		if (!dma_res) {
 			dev_dbg(&pdev->dev, "cannot get DMA RX channel\n");
 			status = -ENODEV;
@@ -1238,7 +1238,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 		mcspi->dma_channels[i].dma_rx_sync_dev = dma_res->start;
 		sprintf(dma_ch_name, "tx%d", i);
 		dma_res = platform_get_resource_byname(pdev, IORESOURCE_DMA,
-							dma_ch_name);
+				dma_ch_name);
 		if (!dma_res) {
 			dev_dbg(&pdev->dev, "cannot get DMA TX channel\n");
 			status = -ENODEV;
@@ -1254,7 +1254,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
 	if (IS_ERR(pinctrl))
 		dev_warn(&pdev->dev,
-			"pins are not configured from the driver\n");
+				"pins are not configured from the driver\n");
 
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
-- 
1.7.11.7

