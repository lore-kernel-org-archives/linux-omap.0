From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH] SPI: Merge improved clock management from N800 tree into
 OMAP2 McSPI
Date: Tue, 3 Apr 2007 15:38:52 +0300
Message-ID: <20070403153852.8baf4a23.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Patch makes the OMAP2 McSPI module to use interface and functional clocks
only when needed and inserts timeout handling in function
omap2_mcspi_txrx_pio.

These are originally developed by Samuel Ortiz <samuel.ortiz@solidboot.com>
and Juha Yrjola <juha.yrjola@solidboot.com>.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 drivers/spi/omap2_mcspi.c |   85 +++++++++++++++++++++++++++++++++++---------
 1 files changed, 67 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index e558187..5f38556 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -37,6 +37,7 @@
 #include <asm/io.h>
 #include <asm/arch/dma.h>
 #include <asm/arch/mcspi.h>
+#include <asm/arch/clock.h>
 
 #define OMAP2_MCSPI_MAX_FREQ		48000000
 
@@ -248,7 +249,7 @@ static void omap2_mcspi_txrx_dma(struct spi_device *spi,
 		data_type = OMAP_DMA_DATA_TYPE_S32;
 		element_count = count >> 2;
 	} else
-		return;
+		goto out;
 
 	/* RX_ONLY mode needs dummy data in TX reg */
 	if (tx == NULL)
@@ -287,7 +288,7 @@ static void omap2_mcspi_txrx_dma(struct spi_device *spi,
 			if (tx != NULL)
 				dma_unmap_single(NULL, xfer->tx_dma,
 						 count, DMA_TO_DEVICE);
-			return;
+			goto out;
 		}
 
 		omap_set_dma_transfer_params(mcspi_dma->dma_rx_channel,
@@ -323,10 +324,22 @@ static void omap2_mcspi_txrx_dma(struct spi_device *spi,
 		wait_for_completion(&mcspi_dma->dma_rx_completion);
 		dma_unmap_single(NULL, xfer->rx_dma, count, DMA_FROM_DEVICE);
 	}
-
+out:
 	omap2_mcspi_set_enable(spi, 0);
 }
 
+static int mcspi_wait_for_reg_bit(unsigned long reg, unsigned long bit)
+{
+	unsigned long timeout;
+
+	timeout = jiffies + msecs_to_jiffies(1000);
+	while (!(__raw_readl(reg) & bit)) {
+		if (time_after(jiffies, timeout))
+			return -1;
+	}
+	return 0;
+}
+
 static void omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 {
 	struct omap2_mcspi * mcspi;
@@ -371,7 +384,10 @@ static void omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xf
 
 		while (c--) {
 			if (tx != NULL) {
-				while (!(__raw_readl(chstat_reg) & OMAP2_MCSPI_CHSTAT_TXS));
+				if (mcspi_wait_for_reg_bit(chstat_reg, OMAP2_MCSPI_CHSTAT_TXS) < 0) {
+					dev_err(&spi->dev, "TXS timed out\n");
+					goto out;
+				}
 #ifdef VERBOSE
 				dev_dbg(&spi->dev, "write-%d %02x\n",
 						word_len, *tx);
@@ -379,7 +395,10 @@ static void omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xf
 				__raw_writel(*tx, tx_reg);
 			}
 			if (rx != NULL) {
-				while (!(__raw_readl(chstat_reg) & OMAP2_MCSPI_CHSTAT_RXS));
+				if (mcspi_wait_for_reg_bit(chstat_reg, OMAP2_MCSPI_CHSTAT_RXS) < 0) {
+					dev_err(&spi->dev, "RXS timed out\n");
+					goto out;
+				}
 				if (c == 0 && tx == NULL)
 					omap2_mcspi_set_enable(spi, 0);
 				*rx++ = __raw_readl(rx_reg);
@@ -398,7 +417,10 @@ static void omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xf
 		c >>= 1;
 		while (c--) {
 			if (tx != NULL) {
-				while (!(__raw_readl(chstat_reg) & OMAP2_MCSPI_CHSTAT_TXS));
+				if (mcspi_wait_for_reg_bit(chstat_reg, OMAP2_MCSPI_CHSTAT_TXS) < 0) {
+					dev_err(&spi->dev, "TXS timed out\n");
+					goto out;
+				}
 #ifdef VERBOSE
 				dev_dbg(&spi->dev, "write-%d %04x\n",
 						word_len, *tx);
@@ -406,7 +428,10 @@ static void omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xf
 				__raw_writel(*tx++, tx_reg);
 			}
 			if (rx != NULL) {
-				while (!(__raw_readl(chstat_reg) & OMAP2_MCSPI_CHSTAT_RXS));
+				if (mcspi_wait_for_reg_bit(chstat_reg, OMAP2_MCSPI_CHSTAT_RXS) < 0) {
+					dev_err(&spi->dev, "RXS timed out\n");
+					goto out;
+				}
 				if (c == 0 && tx == NULL)
 					omap2_mcspi_set_enable(spi, 0);
 				*rx++ = __raw_readl(rx_reg);
@@ -425,7 +450,10 @@ static void omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xf
 		c >>= 2;
 		while (c--) {
 			if (tx != NULL) {
-				while (!(__raw_readl(chstat_reg) & OMAP2_MCSPI_CHSTAT_TXS));
+				if (mcspi_wait_for_reg_bit(chstat_reg, OMAP2_MCSPI_CHSTAT_TXS) < 0) {
+					dev_err(&spi->dev, "TXS timed out\n");
+					goto out;
+				}
 #ifdef VERBOSE
 				dev_dbg(&spi->dev, "write-%d %04x\n",
 						word_len, *tx);
@@ -433,7 +461,10 @@ static void omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xf
 				__raw_writel(*tx++, tx_reg);
 			}
 			if (rx != NULL) {
-				while (!(__raw_readl(chstat_reg) & OMAP2_MCSPI_CHSTAT_RXS));
+				if (mcspi_wait_for_reg_bit(chstat_reg, OMAP2_MCSPI_CHSTAT_RXS) < 0) {
+					dev_err(&spi->dev, "RXS timed out\n");
+					goto out;
+				}
 				if (c == 0 && tx == NULL)
 					omap2_mcspi_set_enable(spi, 0);
 				*rx++ = __raw_readl(rx_reg);
@@ -446,8 +477,13 @@ static void omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xf
 	}
 
 	if (xfer->tx_buf != NULL) {
-		while (!(__raw_readl(chstat_reg) & OMAP2_MCSPI_CHSTAT_TXS));
-		while (!(__raw_readl(chstat_reg) & OMAP2_MCSPI_CHSTAT_EOT));
+		if (mcspi_wait_for_reg_bit(chstat_reg, OMAP2_MCSPI_CHSTAT_TXS) < 0) {
+			dev_err(&spi->dev, "TXS timed out\n");
+			goto out;
+		}
+		if (mcspi_wait_for_reg_bit(chstat_reg, OMAP2_MCSPI_CHSTAT_EOT) < 0)
+			dev_err(&spi->dev, "EOT timed out\n");
+out:
 		omap2_mcspi_set_enable(spi, 0);
 	}
 }
@@ -457,9 +493,12 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 {
 	struct omap2_mcspi_cs *cs = spi->controller_state;
 	struct omap2_mcspi_device_config *conf;
+	struct omap2_mcspi * mcspi;
 	u32 l = 0, div = 0;
 	u8 word_len = spi->bits_per_word;
 
+	mcspi = class_get_devdata(&spi->master->cdev);
+
 	if (t != NULL && t->bits_per_word)
 		word_len = t->bits_per_word;
 	if (!word_len)
@@ -471,6 +510,9 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 
 	conf = (struct omap2_mcspi_device_config *) spi->controller_data;
 
+	clk_enable(mcspi->ick);
+	clk_enable(mcspi->fck);
+
 	if (conf->single_channel == 1)
 		omap2_mcspi_set_master_mode(spi, 1);
 	else
@@ -486,6 +528,8 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 	    word_len < 4 || word_len > 32 ||
 	    div > 15) {
 		dev_err(&spi->dev, "Invalid McSPI channel setting\n");
+		clk_disable(mcspi->fck);
+		clk_disable(mcspi->ick);
 		return -EINVAL;
 	}
 
@@ -516,6 +560,9 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 			(spi->mode & SPI_CPHA) ? "odd" : "even",
 			(spi->mode & SPI_CPOL) ? "" : "not");
 
+	clk_disable(mcspi->fck);
+	clk_disable(mcspi->ick);
+
 	return 0;
 }
 
@@ -668,7 +715,6 @@ static void omap2_mcspi_cleanup(struct spi_device *spi)
 	}
 }
 
-
 static void omap2_mcspi_work(struct work_struct *work)
 {
 	struct omap2_mcspi	*mcspi = container_of(work, struct omap2_mcspi, work);
@@ -709,6 +755,9 @@ static void omap2_mcspi_work(struct work_struct *work)
 					par_override = 0;
 			}
 
+			clk_enable(mcspi->ick);
+			clk_enable(mcspi->fck);
+
 			if (!cs_active) {
 				omap2_mcspi_force_cs(spi, 1);
 				cs_active = 1;
@@ -727,8 +776,12 @@ static void omap2_mcspi_work(struct work_struct *work)
 					omap2_mcspi_force_cs(spi, 0);
 				cs_active = 0;
 			}
+			clk_disable(mcspi->ick);
+			clk_disable(mcspi->fck);
 		}
 
+		clk_enable(mcspi->ick);
+		clk_enable(mcspi->fck);
 		/* Restore defaults they are overriden */
 		if (par_override) {
 			par_override = 0;
@@ -737,6 +790,8 @@ static void omap2_mcspi_work(struct work_struct *work)
 
 		if (cs_active)
 			omap2_mcspi_force_cs(spi, 0);
+		clk_disable(mcspi->ick);
+		clk_disable(mcspi->fck);
 
 		m->status = status;
 		m->complete(m->context);
@@ -831,14 +886,12 @@ static int __devinit omap2_mcspi_probe(struct platform_device *pdev)
 		status = PTR_ERR(mcspi->ick);
 		goto err1;
 	}
-	clk_enable(mcspi->ick);
 	mcspi->fck = clk_get(&pdev->dev, "mcspi_fck");
 	if (IS_ERR(mcspi->fck)) {
 		dev_err(&pdev->dev, "can't get mcspi_fck\n");
 		status = PTR_ERR(mcspi->fck);
 		goto err2;
 	}
-	clk_enable(mcspi->fck);
 
 	mcspi->dma_channels =
 		(struct omap2_mcspi_dma *)kzalloc(master->num_chipselect *
@@ -865,10 +918,8 @@ static int __devinit omap2_mcspi_probe(struct platform_device *pdev)
 err4:
 	kfree(mcspi->dma_channels);
 err3:
-	clk_disable(mcspi->fck);
 	clk_put(mcspi->fck);
 err2:
-	clk_disable(mcspi->ick);
 	clk_put(mcspi->ick);
 err1:
 	class_device_put(&master->cdev);
@@ -885,9 +936,7 @@ static int __devexit omap2_mcspi_remove(struct platform_device *pdev)
 
 	spi_unregister_master(master);
 	mcspi = class_get_devdata(&master->cdev);
-	clk_disable(mcspi->fck);
 	clk_put(mcspi->fck);
-	clk_disable(mcspi->ick);
 	clk_put(mcspi->ick);
 	class_device_put(&master->cdev);
 	kfree(mcspi->dma_channels);
-- 
1.4.4.4
