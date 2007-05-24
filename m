From: David Brownell <david-b@pacbell.net>
Subject: [patch linux-omap-git 1/2] omap2_mcspi fixes + cleanups
Date: Wed, 23 May 2007 20:46:09 -0700
Message-ID: <200705232046.09518.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Initial updates for McSPI driver:

 - bug fixes:
    * handle byte-wide tx pio correctly for multiple bytes
    * cleanup workqueue on module exit
    * allow modular build (and rmmod)
    * request_mem_region
    * remove wrongly exported driver symbol

 - cleanup:
    * remove needless debug strings from object file
    * remove needless init and exit sections from object file
    * remove superfluous get/put of spi_master
    * fix whitespace and indentation bugs
    * fix line-too-long bugs
    * use spi_master_*() calls not class_*() calls
    * use dev_*() messaging not printk
    
Combined with the next patch, this gives around a 10% shrink to the driver
footprint, improves correctness, and helps it get ready to merge upstream.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/spi/Kconfig       |    2 
 drivers/spi/omap2_mcspi.c |  254 ++++++++++++++++++++++++----------------------
 2 files changed, 134 insertions(+), 122 deletions(-)

--- h4.orig/drivers/spi/Kconfig	2007-05-20 15:39:41.000000000 -0700
+++ h4/drivers/spi/Kconfig	2007-05-21 18:15:29.000000000 -0700
@@ -134,7 +134,7 @@ config SPI_OMAP_UWIRE
 	  This hooks up to the MicroWire controller on OMAP1 chips.
 
 config SPI_OMAP24XX
-	bool "McSPI driver for OMAP24xx"
+	tristate "McSPI driver for OMAP24xx"
 	depends on SPI_MASTER && ARCH_OMAP24XX
 	help
 	  SPI master controller for OMAP24xx McSPI modules.
--- h4.orig/drivers/spi/omap2_mcspi.c	2007-05-21 18:10:02.000000000 -0700
+++ h4/drivers/spi/omap2_mcspi.c	2007-05-23 20:06:40.000000000 -0700
@@ -126,39 +126,39 @@ static struct workqueue_struct * omap2_m
 } while(0)
 
 static inline void mcspi_write_reg(struct spi_master *master,
-				   int idx, u32 val)
+		int idx, u32 val)
 {
-	struct omap2_mcspi * mcspi = class_get_devdata(&master->cdev);
+	struct omap2_mcspi *mcspi = spi_master_get_devdata(master);
 
 	__raw_writel(val, mcspi->base + idx);
 }
 
 static inline u32 mcspi_read_reg(struct spi_master *master,
-				 int idx)
+		int idx)
 {
-	struct omap2_mcspi * mcspi = class_get_devdata(&master->cdev);
+	struct omap2_mcspi *mcspi = spi_master_get_devdata(master);
 
 	return __raw_readl(mcspi->base + idx);
 }
 
 static inline void mcspi_write_cs_reg(const struct spi_device *spi,
-				      int idx, u32 val)
+		int idx, u32 val)
 {
-	struct omap2_mcspi * mcspi = class_get_devdata(&spi->master->cdev);
+	struct omap2_mcspi *mcspi = spi_master_get_devdata(spi->master);
 
 	__raw_writel(val, mcspi->base + spi->chip_select * 0x14 + idx);
 }
 
 static inline u32 mcspi_read_cs_reg(const struct spi_device *spi,
-				    int idx)
+		int idx)
 {
-	struct omap2_mcspi * mcspi = class_get_devdata(&spi->master->cdev);
+	struct omap2_mcspi *mcspi = spi_master_get_devdata(spi->master);
 
 	return __raw_readl(mcspi->base + spi->chip_select * 0x14 + idx);
 }
 
 static void omap2_mcspi_set_dma_req(const struct spi_device *spi,
-				    int is_read, int enable)
+		int is_read, int enable)
 {
 	u32 l, rw;
 
@@ -216,7 +216,7 @@ static void omap2_mcspi_txrx_dma(struct 
 	const u8		* tx;
 	u32			l;
 
-	mcspi = class_get_devdata(&spi->master->cdev);
+	mcspi = spi_master_get_devdata(spi->master);
 	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
 
 	count = xfer->len;
@@ -253,56 +253,55 @@ static void omap2_mcspi_txrx_dma(struct 
 
 	/* RX_ONLY mode needs dummy data in TX reg */
 	if (tx == NULL)
-		__raw_writel(0, mcspi->base +
-			     spi->chip_select * 0x14 + OMAP2_MCSPI_TX0);
+		__raw_writel(0, mcspi->base
+					+ spi->chip_select * 0x14
+					+ OMAP2_MCSPI_TX0);
 
 	if (tx != NULL) {
 		xfer->tx_dma = dma_map_single(&spi->dev, (void *) tx, count,
-					      DMA_TO_DEVICE);
+				DMA_TO_DEVICE);
 		if (dma_mapping_error(xfer->tx_dma)) {
-			printk(KERN_ERR "%s(): Couldn't DMA map a %d bytes TX buffer\n",
-			       __FUNCTION__, count);
+			dev_err(&spi->dev, "dma TX %d bytes error\n", count);
 			return;
 		}
 
 		omap_set_dma_transfer_params(mcspi_dma->dma_tx_channel,
-					     data_type, element_count, 1,
-					     OMAP_DMA_SYNC_ELEMENT,
-					     mcspi_dma->dma_tx_sync_dev, 0);
+				data_type, element_count, 1,
+				OMAP_DMA_SYNC_ELEMENT,
+				mcspi_dma->dma_tx_sync_dev, 0);
 
 		omap_set_dma_dest_params(mcspi_dma->dma_tx_channel, 0,
-					 OMAP_DMA_AMODE_CONSTANT,
-					 tx_reg, 0, 0);
+				OMAP_DMA_AMODE_CONSTANT,
+				tx_reg, 0, 0);
 
 		omap_set_dma_src_params(mcspi_dma->dma_tx_channel, 0,
-					OMAP_DMA_AMODE_POST_INC,
-					xfer->tx_dma, 0, 0);
+				OMAP_DMA_AMODE_POST_INC,
+				xfer->tx_dma, 0, 0);
 	}
 
 	if (rx != NULL) {
 		xfer->rx_dma = dma_map_single(&spi->dev, rx, count,
-					      DMA_FROM_DEVICE);
+				DMA_FROM_DEVICE);
 		if (dma_mapping_error(xfer->rx_dma)) {
-			printk(KERN_ERR "%s(): Couldn't DMA map a %d bytes RX buffer\n",
-			       __FUNCTION__, count);
+			dev_err(&spi->dev, "dma RX %d bytes error\n", count);
 			if (tx != NULL)
 				dma_unmap_single(NULL, xfer->tx_dma,
-						 count, DMA_TO_DEVICE);
+						count, DMA_TO_DEVICE);
 			goto out;
 		}
 
 		omap_set_dma_transfer_params(mcspi_dma->dma_rx_channel,
-					     data_type, element_count, 1,
-					     OMAP_DMA_SYNC_ELEMENT,
-					     mcspi_dma->dma_rx_sync_dev, 1);
+				data_type, element_count, 1,
+				OMAP_DMA_SYNC_ELEMENT,
+				mcspi_dma->dma_rx_sync_dev, 1);
 
 		omap_set_dma_src_params(mcspi_dma->dma_rx_channel, 0,
-					OMAP_DMA_AMODE_CONSTANT,
-					rx_reg, 0, 0);
+				OMAP_DMA_AMODE_CONSTANT,
+				rx_reg, 0, 0);
 
 		omap_set_dma_dest_params(mcspi_dma->dma_rx_channel, 0,
-					 OMAP_DMA_AMODE_POST_INC,
-					 xfer->rx_dma, 0, 0);
+				OMAP_DMA_AMODE_POST_INC,
+				xfer->rx_dma, 0, 0);
 	}
 
 	if (tx != NULL) {
@@ -340,16 +339,17 @@ static int mcspi_wait_for_reg_bit(unsign
 	return 0;
 }
 
-static void omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
+static void omap2_mcspi_txrx_pio(struct spi_device *spi,
+		struct spi_transfer *xfer)
 {
-	struct omap2_mcspi * mcspi;
-	struct omap2_mcspi_cs *cs = spi->controller_state;
+	struct omap2_mcspi	*mcspi;
+	struct omap2_mcspi_cs	*cs = spi->controller_state;
 	unsigned int		count, c;
 	u32                     l;
 	unsigned long		base, tx_reg, rx_reg, chstat_reg;
 	int			word_len;
 
-	mcspi = class_get_devdata(&spi->master->cdev);
+	mcspi = spi_master_get_devdata(spi->master);
 	count = xfer->len;
 	c = count;
 	word_len = cs->word_len;
@@ -384,7 +384,8 @@ static void omap2_mcspi_txrx_pio(struct 
 
 		while (c--) {
 			if (tx != NULL) {
-				if (mcspi_wait_for_reg_bit(chstat_reg, OMAP2_MCSPI_CHSTAT_TXS) < 0) {
+				if (mcspi_wait_for_reg_bit(chstat_reg,
+						OMAP2_MCSPI_CHSTAT_TXS) < 0) {
 					dev_err(&spi->dev, "TXS timed out\n");
 					goto out;
 				}
@@ -392,10 +393,11 @@ static void omap2_mcspi_txrx_pio(struct 
 				dev_dbg(&spi->dev, "write-%d %02x\n",
 						word_len, *tx);
 #endif
-				__raw_writel(*tx, tx_reg);
+				__raw_writel(*tx++, tx_reg);
 			}
 			if (rx != NULL) {
-				if (mcspi_wait_for_reg_bit(chstat_reg, OMAP2_MCSPI_CHSTAT_RXS) < 0) {
+				if (mcspi_wait_for_reg_bit(chstat_reg,
+						OMAP2_MCSPI_CHSTAT_RXS) < 0) {
 					dev_err(&spi->dev, "RXS timed out\n");
 					goto out;
 				}
@@ -417,7 +419,8 @@ static void omap2_mcspi_txrx_pio(struct 
 		c >>= 1;
 		while (c--) {
 			if (tx != NULL) {
-				if (mcspi_wait_for_reg_bit(chstat_reg, OMAP2_MCSPI_CHSTAT_TXS) < 0) {
+				if (mcspi_wait_for_reg_bit(chstat_reg,
+						OMAP2_MCSPI_CHSTAT_TXS) < 0) {
 					dev_err(&spi->dev, "TXS timed out\n");
 					goto out;
 				}
@@ -428,7 +431,8 @@ static void omap2_mcspi_txrx_pio(struct 
 				__raw_writel(*tx++, tx_reg);
 			}
 			if (rx != NULL) {
-				if (mcspi_wait_for_reg_bit(chstat_reg, OMAP2_MCSPI_CHSTAT_RXS) < 0) {
+				if (mcspi_wait_for_reg_bit(chstat_reg,
+						OMAP2_MCSPI_CHSTAT_RXS) < 0) {
 					dev_err(&spi->dev, "RXS timed out\n");
 					goto out;
 				}
@@ -450,7 +454,8 @@ static void omap2_mcspi_txrx_pio(struct 
 		c >>= 2;
 		while (c--) {
 			if (tx != NULL) {
-				if (mcspi_wait_for_reg_bit(chstat_reg, OMAP2_MCSPI_CHSTAT_TXS) < 0) {
+				if (mcspi_wait_for_reg_bit(chstat_reg,
+						OMAP2_MCSPI_CHSTAT_TXS) < 0) {
 					dev_err(&spi->dev, "TXS timed out\n");
 					goto out;
 				}
@@ -461,7 +466,8 @@ static void omap2_mcspi_txrx_pio(struct 
 				__raw_writel(*tx++, tx_reg);
 			}
 			if (rx != NULL) {
-				if (mcspi_wait_for_reg_bit(chstat_reg, OMAP2_MCSPI_CHSTAT_RXS) < 0) {
+				if (mcspi_wait_for_reg_bit(chstat_reg,
+						OMAP2_MCSPI_CHSTAT_RXS) < 0) {
 					dev_err(&spi->dev, "RXS timed out\n");
 					goto out;
 				}
@@ -477,11 +483,13 @@ static void omap2_mcspi_txrx_pio(struct 
 	}
 
 	if (xfer->tx_buf != NULL) {
-		if (mcspi_wait_for_reg_bit(chstat_reg, OMAP2_MCSPI_CHSTAT_TXS) < 0) {
+		if (mcspi_wait_for_reg_bit(chstat_reg,
+				OMAP2_MCSPI_CHSTAT_TXS) < 0) {
 			dev_err(&spi->dev, "TXS timed out\n");
 			goto out;
 		}
-		if (mcspi_wait_for_reg_bit(chstat_reg, OMAP2_MCSPI_CHSTAT_EOT) < 0)
+		if (mcspi_wait_for_reg_bit(chstat_reg,
+				OMAP2_MCSPI_CHSTAT_EOT) < 0)
 			dev_err(&spi->dev, "EOT timed out\n");
 out:
 		omap2_mcspi_set_enable(spi, 0);
@@ -489,15 +497,15 @@ out:
 }
 
 static int omap2_mcspi_setup_transfer(struct spi_device *spi,
-				      struct spi_transfer *t)
+		struct spi_transfer *t)
 {
 	struct omap2_mcspi_cs *cs = spi->controller_state;
 	struct omap2_mcspi_device_config *conf;
-	struct omap2_mcspi * mcspi;
+	struct omap2_mcspi *mcspi;
 	u32 l = 0, div = 0;
 	u8 word_len = spi->bits_per_word;
 
-	mcspi = class_get_devdata(&spi->master->cdev);
+	mcspi = spi_master_get_devdata(spi->master);
 
 	if (t != NULL && t->bits_per_word)
 		word_len = t->bits_per_word;
@@ -519,14 +527,13 @@ static int omap2_mcspi_setup_transfer(st
 		omap2_mcspi_set_master_mode(spi, 0);
 
 	if (spi->max_speed_hz) {
-		while (div <= 15 && (OMAP2_MCSPI_MAX_FREQ / (1 << div)) > spi->max_speed_hz)
+		while (div <= 15 && (OMAP2_MCSPI_MAX_FREQ / (1 << div))
+					> spi->max_speed_hz)
 			div++;
 	} else
 		div = 15;
 
-	if (spi->chip_select > 3 ||
-	    word_len < 4 || word_len > 32 ||
-	    div > 15) {
+	if (spi->chip_select > 3 || word_len < 4 || word_len > 32 || div > 15) {
 		dev_err(&spi->dev, "Invalid McSPI channel setting\n");
 		clk_disable(mcspi->fck);
 		clk_disable(mcspi->ick);
@@ -557,7 +564,7 @@ static int omap2_mcspi_setup_transfer(st
 
 	dev_dbg(&spi->dev, "setup: speed %d, sample %s edge, clk %s inverted\n",
 			OMAP2_MCSPI_MAX_FREQ / (1 << div),
-			(spi->mode & SPI_CPHA) ? "odd" : "even",
+			(spi->mode & SPI_CPHA) ? "trailing" : "leading",
 			(spi->mode & SPI_CPOL) ? "" : "not");
 
 	clk_disable(mcspi->fck);
@@ -568,11 +575,11 @@ static int omap2_mcspi_setup_transfer(st
 
 static void omap2_mcspi_dma_rx_callback(int lch, u16 ch_status, void *data)
 {
-	struct spi_device * spi = (struct spi_device *)data;
-	struct omap2_mcspi * mcspi;
-	struct omap2_mcspi_dma * mcspi_dma;
+	struct spi_device	*spi = data;
+	struct omap2_mcspi	*mcspi;
+	struct omap2_mcspi_dma	*mcspi_dma;
 
-	mcspi = class_get_devdata(&spi->master->cdev);
+	mcspi = spi_master_get_devdata(spi->master);
 	mcspi_dma = &(mcspi->dma_channels[spi->chip_select]);
 
 	complete(&mcspi_dma->dma_rx_completion);
@@ -583,11 +590,11 @@ static void omap2_mcspi_dma_rx_callback(
 
 static void omap2_mcspi_dma_tx_callback(int lch, u16 ch_status, void *data)
 {
-	struct spi_device * spi = (struct spi_device *)data;
-	struct omap2_mcspi * mcspi;
-	struct omap2_mcspi_dma * mcspi_dma;
+	struct spi_device	*spi = data;
+	struct omap2_mcspi	*mcspi;
+	struct omap2_mcspi_dma	*mcspi_dma;
 
-	mcspi = class_get_devdata(&spi->master->cdev);
+	mcspi = spi_master_get_devdata(spi->master);
 	mcspi_dma = &(mcspi->dma_channels[spi->chip_select]);
 
 	complete(&mcspi_dma->dma_tx_completion);
@@ -599,11 +606,11 @@ static void omap2_mcspi_dma_tx_callback(
 static int omap2_mcspi_request_dma(struct spi_device *spi)
 {
 	int rx_dev_id, tx_dev_id;
-	struct spi_master *master = spi->master;
-	struct omap2_mcspi * mcspi;
-	struct omap2_mcspi_dma * mcspi_dma;
+	struct spi_master	*master = spi->master;
+	struct omap2_mcspi	*mcspi;
+	struct omap2_mcspi_dma	*mcspi_dma;
 
-	mcspi = class_get_devdata(&master->cdev);
+	mcspi = spi_master_get_devdata(master);
 	mcspi_dma = &(mcspi->dma_channels[spi->chip_select]);
 
 	if (master->bus_num == 1) {
@@ -646,18 +653,18 @@ static int omap2_mcspi_request_dma(struc
 
 
 	if (omap_request_dma(rx_dev_id, "McSPI RX",
-			     omap2_mcspi_dma_rx_callback, spi,
-			     &mcspi_dma->dma_rx_channel)) {
-		printk(KERN_ERR "Unable to request DMA channel for McSPI RX\n");
+			omap2_mcspi_dma_rx_callback, spi,
+			&mcspi_dma->dma_rx_channel)) {
+		dev_err(&spi->dev, "no RX DMA channel for McSPI\n");
 		return -EAGAIN;
 	}
 
 	if (omap_request_dma(tx_dev_id, "McSPI TX",
-			     omap2_mcspi_dma_tx_callback, spi,
-			     &mcspi_dma->dma_tx_channel)) {
+			omap2_mcspi_dma_tx_callback, spi,
+			&mcspi_dma->dma_tx_channel)) {
 		omap_free_dma(mcspi_dma->dma_rx_channel);
 		mcspi_dma->dma_rx_channel = -1;
-		printk(KERN_ERR "Unable to request DMA channel for McSPI TX\n");
+		dev_err(&spi->dev, "no TX DMA channel for McSPI\n");
 		return -EAGAIN;
 	}
 
@@ -672,12 +679,12 @@ static int omap2_mcspi_request_dma(struc
 
 static int omap2_mcspi_setup(struct spi_device *spi)
 {
-	int ret;
-	struct omap2_mcspi * mcspi;
-	struct omap2_mcspi_dma * mcspi_dma;
-	struct omap2_mcspi_cs *cs = spi->controller_state;
+	int			ret;
+	struct omap2_mcspi	*mcspi;
+	struct omap2_mcspi_dma	*mcspi_dma;
+	struct omap2_mcspi_cs	*cs = spi->controller_state;
 
-	mcspi = class_get_devdata(&spi->master->cdev);
+	mcspi = spi_master_get_devdata(spi->master);
 	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
 
 	if (!cs) {
@@ -687,8 +694,8 @@ static int omap2_mcspi_setup(struct spi_
 		spi->controller_state = cs;
 	}
 
-	if (mcspi_dma->dma_rx_channel == -1 ||
-	    mcspi_dma->dma_tx_channel == -1) {
+	if (mcspi_dma->dma_rx_channel == -1
+			|| mcspi_dma->dma_tx_channel == -1) {
 		ret = omap2_mcspi_request_dma(spi);
 		if (ret < 0)
 			return ret;
@@ -699,17 +706,17 @@ static int omap2_mcspi_setup(struct spi_
 
 static void omap2_mcspi_cleanup(struct spi_device *spi)
 {
-	struct omap2_mcspi * mcspi;
-	struct omap2_mcspi_dma * mcspi_dma;
+	struct omap2_mcspi	*mcspi;
+	struct omap2_mcspi_dma	*mcspi_dma;
 
-	mcspi = class_get_devdata(&spi->master->cdev);
+	mcspi = spi_master_get_devdata(spi->master);
 	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
 
 	if (spi->controller_state != NULL)
 		kfree(spi->controller_state);
 
-	if (mcspi_dma->dma_rx_channel != -1 &&
-	    mcspi_dma->dma_tx_channel != -1) {
+	if (mcspi_dma->dma_rx_channel != -1
+			&& mcspi_dma->dma_tx_channel != -1) {
 		omap_free_dma(mcspi_dma->dma_tx_channel);
 		omap_free_dma(mcspi_dma->dma_rx_channel);
 	}
@@ -717,9 +724,10 @@ static void omap2_mcspi_cleanup(struct s
 
 static void omap2_mcspi_work(struct work_struct *work)
 {
-	struct omap2_mcspi	*mcspi = container_of(work, struct omap2_mcspi, work);
+	struct omap2_mcspi	*mcspi;
 	unsigned long		flags;
 
+	mcspi = container_of(work, struct omap2_mcspi, work);
 	spin_lock_irqsave(&mcspi->lock, flags);
 	while (!list_empty(&mcspi->msg_queue)) {
 		struct spi_message		*m;
@@ -763,8 +771,8 @@ static void omap2_mcspi_work(struct work
 				cs_active = 1;
 			}
 
-			if (m->is_dma_mapped &&
-			    (t->tx_dma != 0 || t->rx_dma != 0))
+			if (m->is_dma_mapped
+					&& (t->tx_dma != 0 || t->rx_dma != 0))
 				omap2_mcspi_txrx_dma(spi, t);
 			else
 				omap2_mcspi_txrx_pio(spi, t);
@@ -809,7 +817,7 @@ static int omap2_mcspi_transfer(struct s
 	m->actual_length = 0;
 	m->status = 0;
 
-	mcspi = class_get_devdata(&spi->master->cdev);
+	mcspi = spi_master_get_devdata(spi->master);
 
 	spin_lock_irqsave(&mcspi->lock, flags);
 	list_add_tail(&m->queue, &mcspi->msg_queue);
@@ -820,7 +828,7 @@ static int omap2_mcspi_transfer(struct s
 	return 0;
 }
 
-static int __devinit omap2_mcspi_reset(struct spi_master *master)
+static int __init omap2_mcspi_reset(struct spi_master *master)
 {
 #if 0
 	mcspi_write_reg(master, OMAP2_MCSPI_SYSCONFIG,
@@ -831,7 +839,7 @@ static int __devinit omap2_mcspi_reset(s
 #endif
 }
 
-static int __devinit omap2_mcspi_probe(struct platform_device *pdev)
+static int __init omap2_mcspi_probe(struct platform_device *pdev)
 {
 	struct spi_master		*master;
 	struct omap2_mcspi_platform_config *pdata = pdev->dev.platform_data;
@@ -844,7 +852,7 @@ static int __devinit omap2_mcspi_probe(s
 
 	master = spi_alloc_master(&pdev->dev, sizeof *mcspi);
 	if (master == NULL) {
-		dev_err(&pdev->dev, "master allocation failed\n");
+		dev_dbg(&pdev->dev, "master allocation failed\n");
 		return -ENOMEM;
 	}
 
@@ -856,15 +864,9 @@ static int __devinit omap2_mcspi_probe(s
 	master->cleanup = omap2_mcspi_cleanup;
 	master->num_chipselect = pdata->num_cs;
 
-	if (class_device_get(&master->cdev) == NULL) {
-		dev_err(&pdev->dev, "no master->cdev");
-		status = -ENOMEM;
-		goto err0;
-	}
-
 	dev_set_drvdata(&pdev->dev, master);
 
-	mcspi = class_get_devdata(&master->cdev);
+	mcspi = spi_master_get_devdata(master);
 	mcspi->master = master;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -872,6 +874,11 @@ static int __devinit omap2_mcspi_probe(s
 		status = -ENODEV;
 		goto err1;
 	}
+	if (!request_mem_region(r->start, (r->end - r->start) + 1,
+			pdev->dev.bus_id)) {
+		status = -EBUSY;
+		goto err1;
+	}
 
 	mcspi->base = io_p2v(r->start);
 
@@ -882,21 +889,20 @@ static int __devinit omap2_mcspi_probe(s
 
 	mcspi->ick = clk_get(&pdev->dev, "mcspi_ick");
 	if (IS_ERR(mcspi->ick)) {
-		dev_err(&pdev->dev, "can't get mcspi_ick\n");
+		dev_dbg(&pdev->dev, "can't get mcspi_ick\n");
 		status = PTR_ERR(mcspi->ick);
-		goto err1;
+		goto err1a;
 	}
 	mcspi->fck = clk_get(&pdev->dev, "mcspi_fck");
 	if (IS_ERR(mcspi->fck)) {
-		dev_err(&pdev->dev, "can't get mcspi_fck\n");
+		dev_dbg(&pdev->dev, "can't get mcspi_fck\n");
 		status = PTR_ERR(mcspi->fck);
 		goto err2;
 	}
 
-	mcspi->dma_channels =
-		(struct omap2_mcspi_dma *)kzalloc(master->num_chipselect *
-						  sizeof(struct omap2_mcspi_dma),
-						  GFP_KERNEL);
+	mcspi->dma_channels = kcalloc(master->num_chipselect,
+			sizeof(struct omap2_mcspi_dma),
+			GFP_KERNEL);
 
 	if (mcspi->dma_channels == NULL)
 		goto err3;
@@ -921,53 +927,59 @@ err3:
 	clk_put(mcspi->fck);
 err2:
 	clk_put(mcspi->ick);
+err1a:
+	release_mem_region(r->start, (r->end - r->start) + 1);
 err1:
-	class_device_put(&master->cdev);
-err0:
+	spi_master_put(master);
 	return status;
 }
 
-static int __devexit omap2_mcspi_remove(struct platform_device *pdev)
+static int __exit omap2_mcspi_remove(struct platform_device *pdev)
 {
-	struct spi_master		*master;
-	struct omap2_mcspi		*mcspi;
+	struct spi_master	*master;
+	struct omap2_mcspi	*mcspi;
+	struct omap2_mcspi_dma	*dma_channels;
+	struct resource		*r;
 
 	master = dev_get_drvdata(&pdev->dev);
+	mcspi = spi_master_get_devdata(master);
+	dma_channels = mcspi->dma_channels;
 
-	spi_unregister_master(master);
-	mcspi = class_get_devdata(&master->cdev);
 	clk_put(mcspi->fck);
 	clk_put(mcspi->ick);
-	class_device_put(&master->cdev);
-	kfree(mcspi->dma_channels);
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(r->start, (r->end - r->start) + 1);
+
+	spi_unregister_master(master);
+	kfree(dma_channels);
 
 	return 0;
 }
 
-struct platform_driver omap2_mcspi_driver = {
+static struct platform_driver omap2_mcspi_driver = {
 	.driver = {
 		.name =		"omap2_mcspi",
 		.owner =	THIS_MODULE,
 	},
-	.probe =	omap2_mcspi_probe,
-	.remove =	__devexit_p(omap2_mcspi_remove),
+	.remove =	__exit_p(omap2_mcspi_remove),
 };
-EXPORT_SYMBOL_GPL(omap2_mcspi_driver);
 
 
 static int __init omap2_mcspi_init(void)
 {
-	printk(KERN_INFO "OMAP24xx McSPI driver initializing\n");
-	omap2_mcspi_wq = create_workqueue("OMAP McSPI");
+	omap2_mcspi_wq = create_workqueue(omap2_mcspi_driver.driver.name);
 	if (omap2_mcspi_wq == NULL)
 		return -1;
-	return platform_driver_register(&omap2_mcspi_driver);
+	return platform_driver_probe(&omap2_mcspi_driver, omap2_mcspi_probe);
 }
 subsys_initcall(omap2_mcspi_init);
 
 static void __exit omap2_mcspi_exit(void)
 {
 	platform_driver_unregister(&omap2_mcspi_driver);
+
+	destroy_workqueue(omap2_mcspi_wq);
 }
 module_exit(omap2_mcspi_exit);
 
