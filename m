From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: omap2-mcspi: Use the SPI framework to handle DMA mapping" to the spi tree
Date: Fri, 08 Jul 2016 10:49:10 +0200
Message-ID: <E1bLRTC-0004kr-HO@finisterre>
References: <1467911871-4508-4-git-send-email-fcooper@ti.com>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1467911871-4508-4-git-send-email-fcooper-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.orgbroonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.orglinux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The patch

   spi: omap2-mcspi: Use the SPI framework to handle DMA mapping

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 0ba1870f886501beca0e2c19ec367a85ae201ea8 Mon Sep 17 00:00:00 2001
From: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Date: Thu, 7 Jul 2016 12:17:50 -0500
Subject: [PATCH] spi: omap2-mcspi: Use the SPI framework to handle DMA mapping

Currently, the driver handles mapping buffers to be used by the DMA.
However, there are times that the current mapping implementation will
fail for certain buffers. Fortunately, the SPI framework can detect
and map buffers so its usable by the DMA.

Update the driver to utilize the SPI framework for buffer
mapping instead. Also incorporate hooks that the framework uses to
determine if the DMA can or can not be used.

This will result in the original omap2_mcspi_transfer_one function being
deleted and omap2_mcspi_work_one being renamed to
omap2_mcspi_transfer_one. Previously transfer_one was only responsible
for mapping and work_one handled the transfer. But now only transferring
needs to be handled by the driver.

Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c | 132 ++++++++++++++++++------------------------
 1 file changed, 56 insertions(+), 76 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index c47f95879833..d5157b2222ce 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -419,16 +419,13 @@ static void omap2_mcspi_tx_dma(struct spi_device *spi,
 
 	if (mcspi_dma->dma_tx) {
 		struct dma_async_tx_descriptor *tx;
-		struct scatterlist sg;
 
 		dmaengine_slave_config(mcspi_dma->dma_tx, &cfg);
 
-		sg_init_table(&sg, 1);
-		sg_dma_address(&sg) = xfer->tx_dma;
-		sg_dma_len(&sg) = xfer->len;
-
-		tx = dmaengine_prep_slave_sg(mcspi_dma->dma_tx, &sg, 1,
-		DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+		tx = dmaengine_prep_slave_sg(mcspi_dma->dma_tx, xfer->tx_sg.sgl,
+					     xfer->tx_sg.nents,
+					     DMA_MEM_TO_DEV,
+					     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (tx) {
 			tx->callback = omap2_mcspi_tx_callback;
 			tx->callback_param = spi;
@@ -449,7 +446,10 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 {
 	struct omap2_mcspi	*mcspi;
 	struct omap2_mcspi_dma  *mcspi_dma;
-	unsigned int		count, dma_count;
+	unsigned int		count, transfer_reduction = 0;
+	struct scatterlist	*sg_out[2];
+	int			nb_sizes = 0, out_mapped_nents[2], ret, x;
+	size_t			sizes[2];
 	u32			l;
 	int			elements = 0;
 	int			word_len, element_count;
@@ -457,7 +457,6 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 	mcspi = spi_master_get_devdata(spi->master);
 	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
 	count = xfer->len;
-	dma_count = xfer->len;
 
 	/*
 	 *  In the "End-of-Transfer Procedure" section for DMA RX in OMAP35x TRM
@@ -465,7 +464,7 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 	 *  normal mode.
 	 */
 	if (mcspi->fifo_depth == 0)
-		dma_count -= es;
+		transfer_reduction = es;
 
 	word_len = cs->word_len;
 	l = mcspi_cached_chconf0(spi);
@@ -479,7 +478,6 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 
 	if (mcspi_dma->dma_rx) {
 		struct dma_async_tx_descriptor *tx;
-		struct scatterlist sg;
 
 		dmaengine_slave_config(mcspi_dma->dma_rx, &cfg);
 
@@ -488,15 +486,38 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 		 *  configured in turbo mode.
 		 */
 		if ((l & OMAP2_MCSPI_CHCONF_TURBO) && mcspi->fifo_depth == 0)
-			dma_count -= es;
+			transfer_reduction += es;
 
-		sg_init_table(&sg, 1);
-		sg_dma_address(&sg) = xfer->rx_dma;
-		sg_dma_len(&sg) = dma_count;
+		if (transfer_reduction) {
+			/* Split sgl into two. The second sgl won't be used. */
+			sizes[0] = count - transfer_reduction;
+			sizes[1] = transfer_reduction;
+			nb_sizes = 2;
+		} else {
+			/*
+			 * Don't bother splitting the sgl. This essentially
+			 * clones the original sgl.
+			 */
+			sizes[0] = count;
+			nb_sizes = 1;
+		}
+
+		ret = sg_split(xfer->rx_sg.sgl, xfer->rx_sg.nents,
+			       0, nb_sizes,
+			       sizes,
+			       sg_out, out_mapped_nents,
+			       GFP_KERNEL);
 
-		tx = dmaengine_prep_slave_sg(mcspi_dma->dma_rx, &sg, 1,
-				DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT |
-				DMA_CTRL_ACK);
+		if (ret < 0) {
+			dev_err(&spi->dev, "sg_split failed\n");
+			return 0;
+		}
+
+		tx = dmaengine_prep_slave_sg(mcspi_dma->dma_rx,
+					     sg_out[0],
+					     out_mapped_nents[0],
+					     DMA_DEV_TO_MEM,
+					     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (tx) {
 			tx->callback = omap2_mcspi_rx_callback;
 			tx->callback_param = spi;
@@ -510,8 +531,9 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 	omap2_mcspi_set_dma_req(spi, 1, 1);
 
 	wait_for_completion(&mcspi_dma->dma_rx_completion);
-	dma_unmap_single(mcspi->dev, xfer->rx_dma, count,
-			 DMA_FROM_DEVICE);
+
+	for (x = 0; x < nb_sizes; x++)
+		kfree(sg_out[x]);
 
 	if (mcspi->fifo_depth > 0)
 		return count;
@@ -628,8 +650,6 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 
 	if (tx != NULL) {
 		wait_for_completion(&mcspi_dma->dma_tx_completion);
-		dma_unmap_single(mcspi->dev, xfer->tx_dma, xfer->len,
-				 DMA_TO_DEVICE);
 
 		if (mcspi->fifo_depth > 0) {
 			irqstat_reg = mcspi->base + OMAP2_MCSPI_IRQSTATUS;
@@ -1087,8 +1107,9 @@ static void omap2_mcspi_cleanup(struct spi_device *spi)
 		gpio_free(spi->cs_gpio);
 }
 
-static int omap2_mcspi_work_one(struct omap2_mcspi *mcspi,
-		struct spi_device *spi, struct spi_transfer *t)
+static int omap2_mcspi_transfer_one(struct spi_master *master,
+				    struct spi_device *spi,
+				    struct spi_transfer *t)
 {
 
 	/* We only enable one channel at a time -- the one whose message is
@@ -1098,7 +1119,7 @@ static int omap2_mcspi_work_one(struct omap2_mcspi *mcspi,
 	 * chipselect with the FORCE bit ... CS != channel enable.
 	 */
 
-	struct spi_master		*master;
+	struct omap2_mcspi		*mcspi;
 	struct omap2_mcspi_dma		*mcspi_dma;
 	struct omap2_mcspi_cs		*cs;
 	struct omap2_mcspi_device_config *cd;
@@ -1106,7 +1127,7 @@ static int omap2_mcspi_work_one(struct omap2_mcspi *mcspi,
 	int				status = 0;
 	u32				chconf;
 
-	master = spi->master;
+	mcspi = spi_master_get_devdata(master);
 	mcspi_dma = mcspi->dma_channels + spi->chip_select;
 	cs = spi->controller_state;
 	cd = spi->controller_data;
@@ -1166,7 +1187,8 @@ static int omap2_mcspi_work_one(struct omap2_mcspi *mcspi,
 		unsigned	count;
 
 		if ((mcspi_dma->dma_rx && mcspi_dma->dma_tx) &&
-		    (t->len >= DMA_MIN_BYTES))
+		    master->cur_msg_mapped &&
+		    master->can_dma(master, spi, t))
 			omap2_mcspi_set_fifo(spi, t, 1);
 
 		omap2_mcspi_set_enable(spi, 1);
@@ -1177,7 +1199,8 @@ static int omap2_mcspi_work_one(struct omap2_mcspi *mcspi,
 					+ OMAP2_MCSPI_TX0);
 
 		if ((mcspi_dma->dma_rx && mcspi_dma->dma_tx) &&
-		    (t->len >= DMA_MIN_BYTES))
+		    master->cur_msg_mapped &&
+		    master->can_dma(master, spi, t))
 			count = omap2_mcspi_txrx_dma(spi, t);
 		else
 			count = omap2_mcspi_txrx_pio(spi, t);
@@ -1246,55 +1269,11 @@ static int omap2_mcspi_prepare_message(struct spi_master *master,
 	return 0;
 }
 
-static int omap2_mcspi_transfer_one(struct spi_master *master,
-		struct spi_device *spi, struct spi_transfer *t)
+static bool omap2_mcspi_can_dma(struct spi_master *master,
+				struct spi_device *spi,
+				struct spi_transfer *xfer)
 {
-	struct omap2_mcspi	*mcspi;
-	struct omap2_mcspi_dma	*mcspi_dma;
-	const void	*tx_buf = t->tx_buf;
-	void		*rx_buf = t->rx_buf;
-	unsigned	len = t->len;
-
-	mcspi = spi_master_get_devdata(master);
-	mcspi_dma = mcspi->dma_channels + spi->chip_select;
-
-	if ((len && !(rx_buf || tx_buf))) {
-		dev_dbg(mcspi->dev, "transfer: %d Hz, %d %s%s, %d bpw\n",
-				t->speed_hz,
-				len,
-				tx_buf ? "tx" : "",
-				rx_buf ? "rx" : "",
-				t->bits_per_word);
-		return -EINVAL;
-	}
-
-	if (len < DMA_MIN_BYTES)
-		goto skip_dma_map;
-
-	if (mcspi_dma->dma_tx && tx_buf != NULL) {
-		t->tx_dma = dma_map_single(mcspi->dev, (void *) tx_buf,
-				len, DMA_TO_DEVICE);
-		if (dma_mapping_error(mcspi->dev, t->tx_dma)) {
-			dev_dbg(mcspi->dev, "dma %cX %d bytes error\n",
-					'T', len);
-			return -EINVAL;
-		}
-	}
-	if (mcspi_dma->dma_rx && rx_buf != NULL) {
-		t->rx_dma = dma_map_single(mcspi->dev, rx_buf, t->len,
-				DMA_FROM_DEVICE);
-		if (dma_mapping_error(mcspi->dev, t->rx_dma)) {
-			dev_dbg(mcspi->dev, "dma %cX %d bytes error\n",
-					'R', len);
-			if (tx_buf != NULL)
-				dma_unmap_single(mcspi->dev, t->tx_dma,
-						len, DMA_TO_DEVICE);
-			return -EINVAL;
-		}
-	}
-
-skip_dma_map:
-	return omap2_mcspi_work_one(mcspi, spi, t);
+	return (xfer->len >= DMA_MIN_BYTES);
 }
 
 static int omap2_mcspi_master_setup(struct omap2_mcspi *mcspi)
@@ -1374,6 +1353,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	master->setup = omap2_mcspi_setup;
 	master->auto_runtime_pm = true;
 	master->prepare_message = omap2_mcspi_prepare_message;
+	master->can_dma = omap2_mcspi_can_dma;
 	master->transfer_one = omap2_mcspi_transfer_one;
 	master->set_cs = omap2_mcspi_set_cs;
 	master->cleanup = omap2_mcspi_cleanup;
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
