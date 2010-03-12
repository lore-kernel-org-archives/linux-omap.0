From: Scott Ellis <scott@jumpnowtek.com>
Subject: [PATCH 5/6] SPI omap2_mcspi.c: Use num chipselects from platform
 data
Date: Fri, 12 Mar 2010 10:22:09 -0500
Message-ID: <1268407329.14445.54.camel@quad>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pan.gwi.net ([207.5.128.165]:3753 "EHLO pan.gwi.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934020Ab0CLPWK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Mar 2010 10:22:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net
Cc: David Brownell <dbrownell@users.sourceforge.net>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Andrew Morton <akpm@linux-foundation.org>, Roman Tereshonkov <roman.tereshonkov@nokia.com>, linux-omap@vger.kernel.org, Aaro Koskinen <Aaro.Koskinen@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>

The platform data already has the number of chip select lines 
for each McSPI module. No need to figure it out again in 
probe().

Signed-off-by: Scott Ellis <scott@jumpnowtek.com>

 drivers/spi/omap2_mcspi.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index cce23c5..cd9fdc2 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -1058,33 +1058,28 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)
 	struct resource		*r;
 	int			status = 0, i;
 	const u8		*rxdma_id, *txdma_id;
-	unsigned		num_chipselect;
 	struct omap2_mcspi_platform_config *pdata;
 
 	switch (pdev->id) {
 	case 1:
 		rxdma_id = spi1_rxdma_id;
 		txdma_id = spi1_txdma_id;
-		num_chipselect = 4;
 		break;
 	case 2:
 		rxdma_id = spi2_rxdma_id;
 		txdma_id = spi2_txdma_id;
-		num_chipselect = 2;
 		break;
 #if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) \
 	|| defined(CONFIG_ARCH_OMAP4)
 	case 3:
 		rxdma_id = spi3_rxdma_id;
 		txdma_id = spi3_txdma_id;
-		num_chipselect = 2;
 		break;
 #endif
 #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 	case 4:
 		rxdma_id = spi4_rxdma_id;
 		txdma_id = spi4_txdma_id;
-		num_chipselect = 1;
 		break;
 #endif
 	default:
@@ -1106,7 +1101,6 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)
 	master->setup = omap2_mcspi_setup;
 	master->transfer = omap2_mcspi_transfer;
 	master->cleanup = omap2_mcspi_cleanup;
-	master->num_chipselect = num_chipselect;
 
 	dev_set_drvdata(&pdev->dev, master);
 
@@ -1114,6 +1108,7 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)
 	mcspi->master = master;
 	pdata = (struct omap2_mcspi_platform_config *)pdev->dev.platform_data;
 	mcspi->max_clk_div = pdata->max_clk_div;
+	master->num_chipselect = pdata->num_cs;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (r == NULL) {
@@ -1160,7 +1155,7 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)
 	if (mcspi->dma_channels == NULL)
 		goto err3;
 
-	for (i = 0; i < num_chipselect; i++) {
+	for (i = 0; i < master->num_chipselect; i++) {
 		mcspi->dma_channels[i].dma_rx_channel = -1;
 		mcspi->dma_channels[i].dma_rx_sync_dev = rxdma_id[i];
 		mcspi->dma_channels[i].dma_tx_channel = -1;





