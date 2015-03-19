From: Greg Knight <g.knight@symetrica.com>
Subject: Patch to parameterize DMA_MIN_BYTES for omap2-mcspi
Date: Thu, 19 Mar 2015 01:05:01 -0400
Message-ID: <1426741501.10003.6.camel@midgaarde>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-3100BQj99xIKfIdFECJw"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:33123 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbbCSFFD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2015 01:05:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-omap@vger.kernel.org


--=-3100BQj99xIKfIdFECJw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi, Mark,

I've attached a patch which adds a device-tree field "ti,dma-min-bytes"
which replaces the macro DMA_MIN_BYTES. Adjusting this field addresses
issues we've had where, in our particular use case, the usleep() in the
SPI worker thread eats a full 20% of our CPU (AM3359).

I opted to implement it as a device-tree parameter and keep the original
value (160) as the default, in order to avoid impacting anyone else.

The patch is attached. Patches 1-2 are an unrelated McASP change (see my
other message).

What is the process for getting this upstreamed?

Thanks,
Greg

--=-3100BQj99xIKfIdFECJw
Content-Disposition: attachment;
	filename*0=0003-spi-omap2-mcspi-DMA_MIN_BYTES-hashdef-ti-dma-min-byt.pat;
	filename*1=ch
Content-Type: text/x-patch;
	name="0003-spi-omap2-mcspi-DMA_MIN_BYTES-hashdef-ti-dma-min-byt.patch";
	charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 2b51699d1f7f05de45f0f0f065c37da81181f4eb Mon Sep 17 00:00:00 2001
From: Greg Knight <g.knight@symetrica.com>
Date: Mon, 2 Mar 2015 10:44:21 -0500
Subject: [PATCH 3/3] spi-omap2-mcspi: DMA_MIN_BYTES hashdef =>
 ti,dma-min-bytes device tree option

---
 drivers/spi/spi-omap2-mcspi.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 70cd418..4ac1f3e 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -117,8 +117,7 @@ struct omap2_mcspi_dma {
 /* use PIO for small transfers, avoiding DMA setup/teardown overhead and
  * cache operations; better heuristics consider wordsize and bitrate.
  */
-#define DMA_MIN_BYTES			160
-
+#define DMA_MIN_BYTES_DEFAULT			160
 
 /*
  * Used for context save and restore, structure members to be updated whenever
@@ -141,6 +140,9 @@ struct omap2_mcspi {
 	struct omap2_mcspi_regs ctx;
 	int			fifo_depth;
 	unsigned int		pin_dir:1;
+
+	/* SPI transfer threshold over which we prefer DMA to PIO */
+	unsigned dma_min_bytes;
 };
 
 struct omap2_mcspi_cs {
@@ -1115,7 +1117,7 @@ static void omap2_mcspi_work(struct omap2_mcspi *mcspi, struct spi_message *m)
 			unsigned	count;
 
 			if ((mcspi_dma->dma_rx && mcspi_dma->dma_tx) &&
-			    (m->is_dma_mapped || t->len >= DMA_MIN_BYTES))
+			    (m->is_dma_mapped || t->len >= mcspi->dma_min_bytes))
 				omap2_mcspi_set_fifo(spi, t, 1);
 
 			omap2_mcspi_set_enable(spi, 1);
@@ -1126,7 +1128,7 @@ static void omap2_mcspi_work(struct omap2_mcspi *mcspi, struct spi_message *m)
 						+ OMAP2_MCSPI_TX0);
 
 			if ((mcspi_dma->dma_rx && mcspi_dma->dma_tx) &&
-			    (m->is_dma_mapped || t->len >= DMA_MIN_BYTES))
+			    (m->is_dma_mapped || t->len >= mcspi->dma_min_bytes))
 				count = omap2_mcspi_txrx_dma(spi, t);
 			else
 				count = omap2_mcspi_txrx_pio(spi, t);
@@ -1216,7 +1218,7 @@ static int omap2_mcspi_transfer_one_message(struct spi_master *master,
 			return -EINVAL;
 		}
 
-		if (m->is_dma_mapped || len < DMA_MIN_BYTES)
+		if (m->is_dma_mapped || len < mcspi->dma_min_bytes)
 			continue;
 
 		if (mcspi_dma->dma_tx && tx_buf != NULL) {
@@ -1331,10 +1333,12 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 
 	mcspi = spi_master_get_devdata(master);
 	mcspi->master = master;
+	mcspi->dma_min_bytes = DMA_MIN_BYTES_DEFAULT;
 
 	match = of_match_device(omap_mcspi_of_match, &pdev->dev);
 	if (match) {
 		u32 num_cs = 1; /* default number of chipselect */
+		u32 dma_min_bytes;
 		pdata = match->data;
 
 		of_property_read_u32(node, "ti,spi-num-cs", &num_cs);
@@ -1342,6 +1346,8 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 		master->bus_num = bus_num++;
 		if (of_get_property(node, "ti,pindir-d0-out-d1-in", NULL))
 			mcspi->pin_dir = MCSPI_PINDIR_D0_OUT_D1_IN;
+		if (!of_property_read_u32(node, "ti,dma-min-bytes", &dma_min_bytes))
+			mcspi->dma_min_bytes = (unsigned) dma_min_bytes;
 	} else {
 		pdata = dev_get_platdata(&pdev->dev);
 		master->num_chipselect = pdata->num_cs;
-- 
1.9.1


--=-3100BQj99xIKfIdFECJw--

