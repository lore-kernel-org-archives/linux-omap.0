From: Scott Ellis <scott@jumpnowtek.com>
Subject: [PATCH 1/6 Revised] SPI omap2_mcspi.c: Check params before
 dereference or use
Date: Fri, 12 Mar 2010 10:11:53 -0500
Message-ID: <1268406713.14445.50.camel@quad>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pan.gwi.net ([207.5.128.165]:1090 "EHLO pan.gwi.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934030Ab0CLPL4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Mar 2010 10:11:56 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net
Cc: David Brownell <dbrownell@users.sourceforge.net>, Grant Likely <grant.likely@secretlab.ca>, Andrew Morton <akpm@linux-foundation.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Aaro Koskinen <Aaro.Koskinen@nokia.com>, Roman Tereshonkov <roman.tereshonkov@nokia.com>, linux-omap@vger.kernel.org

This was previously submitted directly to the linux-kernel list.
It was incomplete the first time because it failed to also check
the chip_select value.

Check spi->controller_state before dereference.
Check spi->chip_select for range before use.

Neither are necessarily valid after spi_alloc_device() and 
then spi_add_device() fails. Calling spi_put_device() will 
trigger the error.

Signed-off-by: Scott Ellis <scott@jumpnowtek.com>

 drivers/spi/omap2_mcspi.c |   30 +++++++++++++++++-------------
 1 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index 715c518..fe1b56d 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -748,22 +748,26 @@ static void omap2_mcspi_cleanup(struct spi_device *spi)
 	struct omap2_mcspi_dma	*mcspi_dma;
 	struct omap2_mcspi_cs	*cs;
 
-	mcspi = spi_master_get_devdata(spi->master);
-	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
+	if (spi->controller_state) {
+		/* Unlink controller state from context save list */
+		cs = spi->controller_state;
+		list_del(&cs->node);
 
-	/* Unlink controller state from context save list */
-	cs = spi->controller_state;
-	list_del(&cs->node);
+		kfree(spi->controller_state);
+	}
 
-	kfree(spi->controller_state);
+	if (spi->chip_select < spi->master->num_chipselect) {
+		mcspi = spi_master_get_devdata(spi->master);
+		mcspi_dma = &mcspi->dma_channels[spi->chip_select];
 
-	if (mcspi_dma->dma_rx_channel != -1) {
-		omap_free_dma(mcspi_dma->dma_rx_channel);
-		mcspi_dma->dma_rx_channel = -1;
-	}
-	if (mcspi_dma->dma_tx_channel != -1) {
-		omap_free_dma(mcspi_dma->dma_tx_channel);
-		mcspi_dma->dma_tx_channel = -1;
+		if (mcspi_dma->dma_rx_channel != -1) {
+			omap_free_dma(mcspi_dma->dma_rx_channel);
+			mcspi_dma->dma_rx_channel = -1;
+		}
+		if (mcspi_dma->dma_tx_channel != -1) {
+			omap_free_dma(mcspi_dma->dma_tx_channel);
+			mcspi_dma->dma_tx_channel = -1;
+		}
 	}
 }









