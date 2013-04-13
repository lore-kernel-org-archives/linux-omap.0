From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] spi: omap2-mcspi: Fix transfers if DMADEVICES is not set
Date: Fri, 12 Apr 2013 17:25:07 -0700
Message-ID: <20130413002506.GG10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64004 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754664Ab3DMAZL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Apr 2013 20:25:11 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, Jon Hunter <jon-hunter@ti.com>

Selecting CONFIG_DMADEVICES is optional, and we must
be able to continue even without DMA. Otherwise things
like omap4430sdp nfsroot will fail if DMA is not
selected.

Note that the driver already supports PIO mode, but
we fail to fall back to PIO if requesting DMA channels
fails.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Does this look OK to get in for v3.10? There should not
be any urgent need for this for v3.9-rc.

--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -809,6 +809,10 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 	return 0;
 }
 
+/*
+ * Note that we currently allow DMA only if we get a channel
+ * for both rx and tx. Otherwise we'll do PIO for both rx and tx.
+ */
 static int omap2_mcspi_request_dma(struct spi_device *spi)
 {
 	struct spi_master	*master = spi->master;
@@ -827,21 +831,22 @@ static int omap2_mcspi_request_dma(struct spi_device *spi)
 	dma_cap_set(DMA_SLAVE, mask);
 	sig = mcspi_dma->dma_rx_sync_dev;
 	mcspi_dma->dma_rx = dma_request_channel(mask, omap_dma_filter_fn, &sig);
-	if (!mcspi_dma->dma_rx) {
-		dev_err(&spi->dev, "no RX DMA engine channel for McSPI\n");
-		return -EAGAIN;
-	}
+	if (!mcspi_dma->dma_rx)
+		goto no_dma;
 
 	sig = mcspi_dma->dma_tx_sync_dev;
 	mcspi_dma->dma_tx = dma_request_channel(mask, omap_dma_filter_fn, &sig);
 	if (!mcspi_dma->dma_tx) {
-		dev_err(&spi->dev, "no TX DMA engine channel for McSPI\n");
 		dma_release_channel(mcspi_dma->dma_rx);
 		mcspi_dma->dma_rx = NULL;
-		return -EAGAIN;
+		goto no_dma;
 	}
 
 	return 0;
+
+no_dma:
+	dev_warn(&spi->dev, "not using DMA for McSPI\n");
+	return -EAGAIN;
 }
 
 static int omap2_mcspi_setup(struct spi_device *spi)
@@ -874,7 +879,7 @@ static int omap2_mcspi_setup(struct spi_device *spi)
 
 	if (!mcspi_dma->dma_rx || !mcspi_dma->dma_tx) {
 		ret = omap2_mcspi_request_dma(spi);
-		if (ret < 0)
+		if (ret < 0 && ret != -EAGAIN)
 			return ret;
 	}
 
@@ -932,6 +937,7 @@ static void omap2_mcspi_work(struct omap2_mcspi *mcspi, struct spi_message *m)
 	struct spi_device		*spi;
 	struct spi_transfer		*t = NULL;
 	struct spi_master		*master;
+	struct omap2_mcspi_dma		*mcspi_dma;
 	int				cs_active = 0;
 	struct omap2_mcspi_cs		*cs;
 	struct omap2_mcspi_device_config *cd;
@@ -941,6 +947,7 @@ static void omap2_mcspi_work(struct omap2_mcspi *mcspi, struct spi_message *m)
 
 	spi = m->spi;
 	master = spi->master;
+	mcspi_dma = mcspi->dma_channels + spi->chip_select;
 	cs = spi->controller_state;
 	cd = spi->controller_data;
 
@@ -997,7 +1004,8 @@ static void omap2_mcspi_work(struct omap2_mcspi *mcspi, struct spi_message *m)
 				__raw_writel(0, cs->base
 						+ OMAP2_MCSPI_TX0);
 
-			if (m->is_dma_mapped || t->len >= DMA_MIN_BYTES)
+			if ((mcspi_dma->dma_rx && mcspi_dma->dma_tx) &&
+			    (m->is_dma_mapped || t->len >= DMA_MIN_BYTES))
 				count = omap2_mcspi_txrx_dma(spi, t);
 			else
 				count = omap2_mcspi_txrx_pio(spi, t);
@@ -1044,10 +1052,14 @@ static void omap2_mcspi_work(struct omap2_mcspi *mcspi, struct spi_message *m)
 static int omap2_mcspi_transfer_one_message(struct spi_master *master,
 		struct spi_message *m)
 {
+	struct spi_device	*spi;
 	struct omap2_mcspi	*mcspi;
+	struct omap2_mcspi_dma	*mcspi_dma;
 	struct spi_transfer	*t;
 
+	spi = m->spi;
 	mcspi = spi_master_get_devdata(master);
+	mcspi_dma = mcspi->dma_channels + spi->chip_select;
 	m->actual_length = 0;
 	m->status = 0;
 
@@ -1082,7 +1094,7 @@ static int omap2_mcspi_transfer_one_message(struct spi_master *master,
 		if (m->is_dma_mapped || len < DMA_MIN_BYTES)
 			continue;
 
-		if (tx_buf != NULL) {
+		if (mcspi_dma->dma_tx && tx_buf != NULL) {
 			t->tx_dma = dma_map_single(mcspi->dev, (void *) tx_buf,
 					len, DMA_TO_DEVICE);
 			if (dma_mapping_error(mcspi->dev, t->tx_dma)) {
@@ -1091,7 +1103,7 @@ static int omap2_mcspi_transfer_one_message(struct spi_master *master,
 				return -EINVAL;
 			}
 		}
-		if (rx_buf != NULL) {
+		if (mcspi_dma->dma_rx && rx_buf != NULL) {
 			t->rx_dma = dma_map_single(mcspi->dev, rx_buf, t->len,
 					DMA_FROM_DEVICE);
 			if (dma_mapping_error(mcspi->dev, t->rx_dma)) {
