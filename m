From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] OMAP HSMMC: fix MMC3 dma
Date: Tue, 27 Jan 2009 12:36:13 +0200
Message-ID: <1233052573-6223-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f21.google.com ([209.85.219.21]:59675 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930AbZA0KgV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jan 2009 05:36:21 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: drzeus-mmc@drzeus.cx, ext-adrian.hunter@nokia.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>

Data transfers on third OMAP3 MMC controller don't work
because DMA line numbers are only defined for MMC1 and MMC2.
Fix that and store line numbers in mmc_omap_host structure
to reduce code size.
Tested on OMAP3 pandora board.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/mmc/host/omap_hsmmc.c |   31 +++++++++++++++++++++++--------
 1 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 70d8d78..a2c4aee 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -97,6 +97,7 @@
  */
 #define OMAP_MMC1_DEVID		0
 #define OMAP_MMC2_DEVID		1
+#define OMAP_MMC3_DEVID		2
 
 #define OMAP_MMC_DATADIR_NONE	0
 #define OMAP_MMC_DATADIR_READ	1
@@ -148,6 +149,7 @@ struct mmc_omap_host {
 	int			irq;
 	int			carddetect;
 	int			use_dma, dma_ch;
+	int			dma_line_tx, dma_line_rx;
 	int			initstr;
 	int			slot_id;
 	int			dbclk_enabled;
@@ -672,16 +674,10 @@ mmc_omap_start_dma_transfer(struct mmc_omap_host *host, struct mmc_request *req)
 
 	if (!(data->flags & MMC_DATA_WRITE)) {
 		host->dma_dir = DMA_FROM_DEVICE;
-		if (host->id == OMAP_MMC1_DEVID)
-			sync_dev = OMAP24XX_DMA_MMC1_RX;
-		else
-			sync_dev = OMAP24XX_DMA_MMC2_RX;
+		sync_dev = host->dma_line_rx;
 	} else {
 		host->dma_dir = DMA_TO_DEVICE;
-		if (host->id == OMAP_MMC1_DEVID)
-			sync_dev = OMAP24XX_DMA_MMC1_TX;
-		else
-			sync_dev = OMAP24XX_DMA_MMC2_TX;
+		sync_dev = host->dma_line_tx;
 	}
 
 	ret = omap_request_dma(sync_dev, "MMC/SD", mmc_omap_dma_cb,
@@ -1058,6 +1054,25 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 	OMAP_HSMMC_WRITE(host->base, HCTL,
 			OMAP_HSMMC_READ(host->base, HCTL) | SDBP);
 
+	/* Select DMA lines */
+	switch (host->id) {
+	case OMAP_MMC1_DEVID:
+		host->dma_line_tx = OMAP24XX_DMA_MMC1_TX;
+		host->dma_line_rx = OMAP24XX_DMA_MMC1_RX;
+		break;
+	case OMAP_MMC2_DEVID:
+		host->dma_line_tx = OMAP24XX_DMA_MMC2_TX;
+		host->dma_line_rx = OMAP24XX_DMA_MMC2_RX;
+		break;
+	case OMAP_MMC3_DEVID:
+		host->dma_line_tx = OMAP34XX_DMA_MMC3_TX;
+		host->dma_line_rx = OMAP34XX_DMA_MMC3_RX;
+		break;
+	default:
+		dev_err(mmc_dev(host->mmc), "Invalid MMC id\n");
+		goto err_irq;
+	}
+
 	/* Request IRQ for MMC operations */
 	ret = request_irq(host->irq, mmc_omap_irq, IRQF_DISABLED,
 			mmc_hostname(mmc), host);
-- 
1.5.4.3

