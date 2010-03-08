From: Scott Ellis <scott@jumpnowtek.com>
Subject: [PATCH] omap2_mcspi.c: Checks in omap2_mcspi_cleanup
Date: Mon, 08 Mar 2010 06:55:19 -0500
Message-ID: <1268049319.2558.74.camel@quad>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pan.gwi.net ([207.5.128.165]:2164 "EHLO pan.gwi.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752463Ab0CHNOI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Mar 2010 08:14:08 -0500
Received: from [192.168.10.4] (66-63-88-74.static.suscom-maine.net [66.63.88.74])
	by pan.gwi.net (8.13.1/8.13.1) with ESMTP id o28BtJ3x098541
	for <linux-omap@vger.kernel.org>; Mon, 8 Mar 2010 06:55:19 -0500 (EST)
	(envelope-from scott@jumpnowtek.com)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Check spi->controller_state before dereferencing.
Check spi->chip_select for range before using.

Neither are guaranteed to be valid when spi_dev_put() is called.
Submitted previously to the linux-kernel list but without the 
chip_select check.

Signed-off-by: Scott Ellis <scott@jumpnowtek.com>


 drivers/spi/omap2_mcspi.c |   30 +++++++++++++++++-------------
 1 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index 715c518..fe1b56d 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -748,22 +748,26 @@ static void omap2_mcspi_cleanup(struct spi_device *spi)
        struct omap2_mcspi_dma  *mcspi_dma;
        struct omap2_mcspi_cs   *cs;
 
-       mcspi = spi_master_get_devdata(spi->master);
-       mcspi_dma = &mcspi->dma_channels[spi->chip_select];
+       if (spi->controller_state) {
+               /* Unlink controller state from context save list */
+               cs = spi->controller_state;
+               list_del(&cs->node);
 
-       /* Unlink controller state from context save list */
-       cs = spi->controller_state;
-       list_del(&cs->node);
+               kfree(spi->controller_state);
+       }
 
-       kfree(spi->controller_state);
+       if (spi->chip_select < spi->master->num_chipselect) {
+               mcspi = spi_master_get_devdata(spi->master);
+               mcspi_dma = &mcspi->dma_channels[spi->chip_select];
 
-       if (mcspi_dma->dma_rx_channel != -1) {
-               omap_free_dma(mcspi_dma->dma_rx_channel);
-               mcspi_dma->dma_rx_channel = -1;
-       }
-       if (mcspi_dma->dma_tx_channel != -1) {
-               omap_free_dma(mcspi_dma->dma_tx_channel);
-               mcspi_dma->dma_tx_channel = -1;
+               if (mcspi_dma->dma_rx_channel != -1) {
+                       omap_free_dma(mcspi_dma->dma_rx_channel);
+                       mcspi_dma->dma_rx_channel = -1;
+               }
+               if (mcspi_dma->dma_tx_channel != -1) {
+                       omap_free_dma(mcspi_dma->dma_tx_channel);
+                       mcspi_dma->dma_tx_channel = -1;
+               }
        }
 }



