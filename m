From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 3/3] spi: omap2-mcspi: Add slave mode support
Date: Mon, 15 Oct 2018 12:08:29 +0530
Message-ID: <20181015063829.26978-4-vigneshr@ti.com>
References: <20181015063829.26978-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181015063829.26978-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Vignesh R <vigneshr@ti.com>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

Add support to use McSPI controller as SPI slave. In slave mode, DMA TX
completion does not mean entire data has been shifted out as data might
still be stuck in FIFO waiting for master to clock the bus. Therefore,
add an IRQ handler for slave mode to know when entire data in FIFO has
been shifted out.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/spi/spi-omap2-mcspi.c | 138 ++++++++++++++++++++++++++++++----
 1 file changed, 122 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 88469bb22235..f024c3fc3679 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -127,6 +127,7 @@ struct omap2_mcspi_regs {
 };
 
 struct omap2_mcspi {
+	struct completion	txdone;
 	struct spi_master	*master;
 	/* Virtual base address of the controller */
 	void __iomem		*base;
@@ -136,6 +137,7 @@ struct omap2_mcspi {
 	struct device		*dev;
 	struct omap2_mcspi_regs ctx;
 	int			fifo_depth;
+	bool			slave_aborted;
 	unsigned int		pin_dir:1;
 };
 
@@ -275,19 +277,23 @@ static void omap2_mcspi_set_cs(struct spi_device *spi, bool enable)
 	}
 }
 
-static void omap2_mcspi_set_master_mode(struct spi_master *master)
+static void omap2_mcspi_set_mode(struct spi_master *master)
 {
 	struct omap2_mcspi	*mcspi = spi_master_get_devdata(master);
 	struct omap2_mcspi_regs	*ctx = &mcspi->ctx;
 	u32 l;
 
 	/*
-	 * Setup when switching from (reset default) slave mode
-	 * to single-channel master mode
+	 * Choose master or slave mode
 	 */
 	l = mcspi_read_reg(master, OMAP2_MCSPI_MODULCTRL);
-	l &= ~(OMAP2_MCSPI_MODULCTRL_STEST | OMAP2_MCSPI_MODULCTRL_MS);
-	l |= OMAP2_MCSPI_MODULCTRL_SINGLE;
+	l &= ~(OMAP2_MCSPI_MODULCTRL_STEST);
+	if (spi_controller_is_slave(master)) {
+		l |= (OMAP2_MCSPI_MODULCTRL_MS);
+	} else {
+		l &= ~(OMAP2_MCSPI_MODULCTRL_MS);
+		l |= OMAP2_MCSPI_MODULCTRL_SINGLE;
+	}
 	mcspi_write_reg(master, OMAP2_MCSPI_MODULCTRL, l);
 
 	ctx->modulctrl = l;
@@ -356,6 +362,20 @@ static int mcspi_wait_for_reg_bit(void __iomem *reg, unsigned long bit)
 	return readl_poll_timeout(reg, val, val & bit, 1, MSEC_PER_SEC);
 }
 
+static int mcspi_wait_for_completion(struct  omap2_mcspi *mcspi,
+				     struct completion *x)
+{
+	if (spi_controller_is_slave(mcspi->master)) {
+		if (wait_for_completion_interruptible(x) ||
+		    mcspi->slave_aborted)
+			return -EINTR;
+	} else {
+		wait_for_completion(x);
+	}
+
+	return 0;
+}
+
 static void omap2_mcspi_rx_callback(void *data)
 {
 	struct spi_device *spi = data;
@@ -505,7 +525,12 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 	dma_async_issue_pending(mcspi_dma->dma_rx);
 	omap2_mcspi_set_dma_req(spi, 1, 1);
 
-	wait_for_completion(&mcspi_dma->dma_rx_completion);
+	ret = mcspi_wait_for_completion(mcspi, &mcspi_dma->dma_rx_completion);
+	if (ret || mcspi->slave_aborted) {
+		dmaengine_terminate_sync(mcspi_dma->dma_rx);
+		omap2_mcspi_set_dma_req(spi, 1, 0);
+		return 0;
+	}
 
 	for (x = 0; x < nb_sizes; x++)
 		kfree(sg_out[x]);
@@ -604,14 +629,37 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	rx = xfer->rx_buf;
 	tx = xfer->tx_buf;
 
-	if (tx != NULL)
+	mcspi->slave_aborted = false;
+	reinit_completion(&mcspi_dma->dma_tx_completion);
+	reinit_completion(&mcspi_dma->dma_rx_completion);
+	reinit_completion(&mcspi->txdone);
+	if (tx) {
+		/* Enable EOW IRQ to know end of tx in slave mode */
+		if (spi_controller_is_slave(spi->master))
+			mcspi_write_reg(spi->master,
+					OMAP2_MCSPI_IRQENABLE,
+					OMAP2_MCSPI_IRQSTATUS_EOW);
 		omap2_mcspi_tx_dma(spi, xfer, cfg);
+	}
 
 	if (rx != NULL)
 		count = omap2_mcspi_rx_dma(spi, xfer, cfg, es);
 
 	if (tx != NULL) {
-		wait_for_completion(&mcspi_dma->dma_tx_completion);
+		int ret;
+
+		ret = mcspi_wait_for_completion(mcspi, &mcspi_dma->dma_tx_completion);
+		if (ret || mcspi->slave_aborted) {
+			dmaengine_terminate_sync(mcspi_dma->dma_tx);
+			omap2_mcspi_set_dma_req(spi, 0, 0);
+			return 0;
+		}
+
+		if (spi_controller_is_slave(mcspi->master)) {
+			ret = mcspi_wait_for_completion(mcspi, &mcspi->txdone);
+			if (ret || mcspi->slave_aborted)
+				return 0;
+		}
 
 		if (mcspi->fifo_depth > 0) {
 			irqstat_reg = mcspi->base + OMAP2_MCSPI_IRQSTATUS;
@@ -1068,6 +1116,36 @@ static void omap2_mcspi_cleanup(struct spi_device *spi)
 		gpio_free(spi->cs_gpio);
 }
 
+static irqreturn_t omap2_mcspi_irq_handler(int irq, void *data)
+{
+	struct omap2_mcspi *mcspi = data;
+	u32 irqstat;
+
+	irqstat	= mcspi_read_reg(mcspi->master, OMAP2_MCSPI_IRQSTATUS);
+	if (!irqstat)
+		return IRQ_NONE;
+
+	/* Disable IRQ and wakeup slave xfer task */
+	mcspi_write_reg(mcspi->master, OMAP2_MCSPI_IRQENABLE, 0);
+	if (irqstat & OMAP2_MCSPI_IRQSTATUS_EOW)
+		complete(&mcspi->txdone);
+
+	return IRQ_HANDLED;
+}
+
+static int omap2_mcspi_slave_abort(struct spi_master *master)
+{
+	struct omap2_mcspi *mcspi = spi_master_get_devdata(master);
+	struct omap2_mcspi_dma *mcspi_dma = mcspi->dma_channels;
+
+	mcspi->slave_aborted = true;
+	complete(&mcspi_dma->dma_rx_completion);
+	complete(&mcspi_dma->dma_tx_completion);
+	complete(&mcspi->txdone);
+
+	return 0;
+}
+
 static int omap2_mcspi_transfer_one(struct spi_master *master,
 				    struct spi_device *spi,
 				    struct spi_transfer *t)
@@ -1234,10 +1312,20 @@ static bool omap2_mcspi_can_dma(struct spi_master *master,
 				struct spi_device *spi,
 				struct spi_transfer *xfer)
 {
+	struct omap2_mcspi *mcspi = spi_master_get_devdata(spi->master);
+	struct omap2_mcspi_dma *mcspi_dma =
+		&mcspi->dma_channels[spi->chip_select];
+
+	if (!mcspi_dma->dma_rx || !mcspi_dma->dma_tx)
+		return false;
+
+	if (spi_controller_is_slave(master))
+		return true;
+
 	return (xfer->len >= DMA_MIN_BYTES);
 }
 
-static int omap2_mcspi_master_setup(struct omap2_mcspi *mcspi)
+static int omap2_mcspi_controller_setup(struct omap2_mcspi *mcspi)
 {
 	struct spi_master	*master = mcspi->master;
 	struct omap2_mcspi_regs	*ctx = &mcspi->ctx;
@@ -1254,7 +1342,7 @@ static int omap2_mcspi_master_setup(struct omap2_mcspi *mcspi)
 			OMAP2_MCSPI_WAKEUPENABLE_WKEN);
 	ctx->wakeupenable = OMAP2_MCSPI_WAKEUPENABLE_WKEN;
 
-	omap2_mcspi_set_master_mode(master);
+	omap2_mcspi_set_mode(master);
 	pm_runtime_mark_last_busy(mcspi->dev);
 	pm_runtime_put_autosuspend(mcspi->dev);
 	return 0;
@@ -1329,11 +1417,12 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	struct device_node	*node = pdev->dev.of_node;
 	const struct of_device_id *match;
 
-	master = spi_alloc_master(&pdev->dev, sizeof *mcspi);
-	if (master == NULL) {
-		dev_dbg(&pdev->dev, "master allocation failed\n");
+	if (of_property_read_bool(node, "spi-slave"))
+		master = spi_alloc_slave(&pdev->dev, sizeof(*mcspi));
+	else
+		master = spi_alloc_master(&pdev->dev, sizeof(*mcspi));
+	if (!master)
 		return -ENOMEM;
-	}
 
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
@@ -1345,6 +1434,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	master->transfer_one = omap2_mcspi_transfer_one;
 	master->set_cs = omap2_mcspi_set_cs;
 	master->cleanup = omap2_mcspi_cleanup;
+	master->slave_abort = omap2_mcspi_slave_abort;
 	master->dev.of_node = node;
 	master->max_speed_hz = OMAP2_MCSPI_MAX_FREQ;
 	master->min_speed_hz = OMAP2_MCSPI_MAX_FREQ >> 15;
@@ -1396,15 +1486,31 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 		sprintf(mcspi->dma_channels[i].dma_tx_ch_name, "tx%d", i);
 	}
 
+	status = platform_get_irq(pdev, 0);
+	if (status == -EPROBE_DEFER)
+		goto free_master;
+	if (status < 0) {
+		dev_err(&pdev->dev, "no irq resource found\n");
+		goto free_master;
+	}
+	init_completion(&mcspi->txdone);
+	status = devm_request_irq(&pdev->dev, status,
+				  omap2_mcspi_irq_handler, 0, pdev->name,
+				  mcspi);
+	if (status) {
+		dev_err(&pdev->dev, "Cannot request IRQ");
+		goto free_master;
+	}
+
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_enable(&pdev->dev);
 
-	status = omap2_mcspi_master_setup(mcspi);
+	status = omap2_mcspi_controller_setup(mcspi);
 	if (status < 0)
 		goto disable_pm;
 
-	status = devm_spi_register_master(&pdev->dev, master);
+	status = devm_spi_register_controller(&pdev->dev, master);
 	if (status < 0)
 		goto disable_pm;
 
-- 
2.19.1
