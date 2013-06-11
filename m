From: Illia Smyrnov <illia.smyrnov-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 2/2] spi: omap2-mcspi: Add FIFO buffer support
Date: Tue, 11 Jun 2013 20:09:15 +0300
Message-ID: <1370970556-11713-3-git-send-email-illia.smyrnov@ti.com>
References: <1370970556-11713-1-git-send-email-illia.smyrnov@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1370970556-11713-1-git-send-email-illia.smyrnov-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Illia Smyrnov <illia.smyrnov-l0cyMroinI0@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The MCSPI controller has a built-in FIFO buffer to unload the DMA or interrupt
handler and improve data throughput. This patch adds FIFO buffer support for SPI
transfers in DMA mode.

The FIFO could be enabled for SPI module by setting up the "ti,spi-fifo-enabled"
configuration parameter in DT.
If FIFO enabled, the largest possible FIFO buffer size will be calculated and
setup for each SPI transfer. Even if the FIFO is enabled in DT, it won't be used
for the SPI transfers when: calculated FIFO buffer size is less then 2 bytes or
the FIFO buffer size isn't multiple of the SPI word length.

Signed-off-by: Illia Smyrnov <illia.smyrnov-l0cyMroinI0@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/omap-spi.txt |    8 +
 drivers/spi/spi-omap2-mcspi.c                      |  154 +++++++++++++++++--
 2 files changed, 145 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/omap-spi.txt b/Documentation/devicetree/bindings/spi/omap-spi.txt
index 938809c..636c1dc 100644
--- a/Documentation/devicetree/bindings/spi/omap-spi.txt
+++ b/Documentation/devicetree/bindings/spi/omap-spi.txt
@@ -9,6 +9,14 @@ Required properties:
 - ti,pindir-d0-out-d1-in: Select the D0 pin as output and D1 as
 			  input. The default is D0 as input and
 			  D1 as output.
+- ti,spi-fifo-enabled: Enable use of the FIFO buffer. If enabled,
+		       the largest possible FIFO buffer size will
+		       be calculated and setup for each SPI transfer.
+		       Even if the FIFO is enabled, it won't be used
+		       for the SPI transfers when: calculated FIFO
+		       buffer size is less then 2 bytes or the FIFO
+		       buffer size isn't multiple of the SPI word
+		       length. The FIFO buffer is disabled by default.
 
 Example:
 
diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 707f1db..220152a 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -39,12 +39,15 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/gcd.h>
 
 #include <linux/spi/spi.h>
 
 #include <linux/platform_data/spi-omap2-mcspi.h>
 
 #define OMAP2_MCSPI_MAX_FREQ		48000000
+#define OMAP2_MCSPI_MAX_FIFODEPTH	64
+#define OMAP2_MCSPI_MAX_FIFOWCNT	0xFFFF
 #define SPI_AUTOSUSPEND_TIMEOUT		2000
 
 #define OMAP2_MCSPI_REVISION		0x00
@@ -54,6 +57,7 @@
 #define OMAP2_MCSPI_WAKEUPENABLE	0x20
 #define OMAP2_MCSPI_SYST		0x24
 #define OMAP2_MCSPI_MODULCTRL		0x28
+#define OMAP2_MCSPI_XFERLEVEL		0x7c
 
 /* per-channel banks, 0x14 bytes each, first is: */
 #define OMAP2_MCSPI_CHCONF0		0x2c
@@ -63,6 +67,7 @@
 #define OMAP2_MCSPI_RX0			0x3c
 
 /* per-register bitmasks: */
+#define OMAP2_MCSPI_IRQSTATUS_EOW	BIT(17)
 
 #define OMAP2_MCSPI_MODULCTRL_SINGLE	BIT(0)
 #define OMAP2_MCSPI_MODULCTRL_MS	BIT(2)
@@ -83,10 +88,13 @@
 #define OMAP2_MCSPI_CHCONF_IS		BIT(18)
 #define OMAP2_MCSPI_CHCONF_TURBO	BIT(19)
 #define OMAP2_MCSPI_CHCONF_FORCE	BIT(20)
+#define OMAP2_MCSPI_CHCONF_FFET		BIT(27)
+#define OMAP2_MCSPI_CHCONF_FFER		BIT(28)
 
 #define OMAP2_MCSPI_CHSTAT_RXS		BIT(0)
 #define OMAP2_MCSPI_CHSTAT_TXS		BIT(1)
 #define OMAP2_MCSPI_CHSTAT_EOT		BIT(2)
+#define OMAP2_MCSPI_CHSTAT_TXFFE	BIT(3)
 
 #define OMAP2_MCSPI_CHCTRL_EN		BIT(0)
 
@@ -129,6 +137,8 @@ struct omap2_mcspi {
 	struct omap2_mcspi_dma	*dma_channels;
 	struct device		*dev;
 	struct omap2_mcspi_regs ctx;
+	int			fifo_depth;
+	unsigned int		fifo_enabled:1;
 	unsigned int		pin_dir:1;
 };
 
@@ -258,6 +268,60 @@ static void omap2_mcspi_set_master_mode(struct spi_master *master)
 	ctx->modulctrl = l;
 }
 
+static void omap2_mcspi_set_fifo(const struct spi_device *spi,
+				struct spi_transfer *t, int enable)
+{
+	struct spi_master *master = spi->master;
+	struct omap2_mcspi_cs *cs = spi->controller_state;
+	struct omap2_mcspi *mcspi;
+	unsigned int wcnt;
+	int fifo_depth, bytes_per_word;
+	u32 chconf, xferlevel;
+
+	mcspi = spi_master_get_devdata(master);
+	if (!mcspi->fifo_enabled)
+		return;
+
+	chconf = mcspi_cached_chconf0(spi);
+	if (enable) {
+		bytes_per_word = mcspi_bytes_per_word(cs->word_len);
+		if (t->len % bytes_per_word != 0)
+			goto disable_fifo;
+
+		fifo_depth = gcd(t->len, OMAP2_MCSPI_MAX_FIFODEPTH);
+		if (fifo_depth < 2 || fifo_depth % bytes_per_word != 0)
+			goto disable_fifo;
+
+		wcnt = t->len / bytes_per_word;
+		if (wcnt > OMAP2_MCSPI_MAX_FIFOWCNT)
+			goto disable_fifo;
+
+		xferlevel = wcnt << 16;
+		if (t->rx_buf != NULL) {
+			chconf |= OMAP2_MCSPI_CHCONF_FFER;
+			xferlevel |= (fifo_depth - 1) << 8;
+		} else {
+			chconf |= OMAP2_MCSPI_CHCONF_FFET;
+			xferlevel |= fifo_depth - 1;
+		}
+
+		mcspi_write_reg(master, OMAP2_MCSPI_XFERLEVEL, xferlevel);
+		mcspi_write_chconf0(spi, chconf);
+		mcspi->fifo_depth = fifo_depth;
+
+		return;
+	}
+
+disable_fifo:
+	if (t->rx_buf != NULL)
+		chconf &= ~OMAP2_MCSPI_CHCONF_FFER;
+	else
+		chconf &= ~OMAP2_MCSPI_CHCONF_FFET;
+
+	mcspi_write_chconf0(spi, chconf);
+	mcspi->fifo_depth = 0;
+}
+
 static void omap2_mcspi_restore_ctx(struct omap2_mcspi *mcspi)
 {
 	struct spi_master	*spi_cntrl = mcspi->master;
@@ -374,7 +438,7 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 {
 	struct omap2_mcspi	*mcspi;
 	struct omap2_mcspi_dma  *mcspi_dma;
-	unsigned int		count;
+	unsigned int		count, dma_count;
 	u32			l;
 	int			elements = 0;
 	int			word_len, element_count;
@@ -382,6 +446,11 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 	mcspi = spi_master_get_devdata(spi->master);
 	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
 	count = xfer->len;
+	dma_count = xfer->len;
+
+	if (mcspi->fifo_depth == 0)
+		dma_count -= es;
+
 	word_len = cs->word_len;
 	l = mcspi_cached_chconf0(spi);
 
@@ -395,16 +464,15 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 	if (mcspi_dma->dma_rx) {
 		struct dma_async_tx_descriptor *tx;
 		struct scatterlist sg;
-		size_t len = xfer->len - es;
 
 		dmaengine_slave_config(mcspi_dma->dma_rx, &cfg);
 
-		if (l & OMAP2_MCSPI_CHCONF_TURBO)
-			len -= es;
+		if ((l & OMAP2_MCSPI_CHCONF_TURBO) && mcspi->fifo_depth == 0)
+			dma_count -= es;
 
 		sg_init_table(&sg, 1);
 		sg_dma_address(&sg) = xfer->rx_dma;
-		sg_dma_len(&sg) = len;
+		sg_dma_len(&sg) = dma_count;
 
 		tx = dmaengine_prep_slave_sg(mcspi_dma->dma_rx, &sg, 1,
 				DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT |
@@ -424,6 +492,10 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 	wait_for_completion(&mcspi_dma->dma_rx_completion);
 	dma_unmap_single(mcspi->dev, xfer->rx_dma, count,
 			 DMA_FROM_DEVICE);
+
+	if (mcspi->fifo_depth > 0)
+		return count;
+
 	omap2_mcspi_set_enable(spi, 0);
 
 	elements = element_count - 1;
@@ -482,7 +554,10 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	struct dma_slave_config	cfg;
 	enum dma_slave_buswidth width;
 	unsigned es;
+	u32			burst;
 	void __iomem		*chstat_reg;
+	void __iomem            *irqstat_reg;
+	int			wait_res;
 
 	mcspi = spi_master_get_devdata(spi->master);
 	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
@@ -500,19 +575,27 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 		es = 4;
 	}
 
+	count = xfer->len;
+	burst = 1;
+
+	if (mcspi->fifo_depth > 0) {
+		if (count > mcspi->fifo_depth)
+			burst = mcspi->fifo_depth / es;
+		else
+			burst = count / es;
+	}
+
 	memset(&cfg, 0, sizeof(cfg));
 	cfg.src_addr = cs->phys + OMAP2_MCSPI_RX0;
 	cfg.dst_addr = cs->phys + OMAP2_MCSPI_TX0;
 	cfg.src_addr_width = width;
 	cfg.dst_addr_width = width;
-	cfg.src_maxburst = 1;
-	cfg.dst_maxburst = 1;
+	cfg.src_maxburst = burst;
+	cfg.dst_maxburst = burst;
 
 	rx = xfer->rx_buf;
 	tx = xfer->tx_buf;
 
-	count = xfer->len;
-
 	if (tx != NULL)
 		omap2_mcspi_tx_dma(spi, xfer, cfg);
 
@@ -520,18 +603,38 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 		count = omap2_mcspi_rx_dma(spi, xfer, cfg, es);
 
 	if (tx != NULL) {
-		chstat_reg = cs->base + OMAP2_MCSPI_CHSTAT0;
 		wait_for_completion(&mcspi_dma->dma_tx_completion);
 		dma_unmap_single(mcspi->dev, xfer->tx_dma, xfer->len,
 				 DMA_TO_DEVICE);
 
+		if (mcspi->fifo_depth > 0) {
+			irqstat_reg = mcspi->base + OMAP2_MCSPI_IRQSTATUS;
+
+			if (mcspi_wait_for_reg_bit(irqstat_reg,
+						OMAP2_MCSPI_IRQSTATUS_EOW) < 0)
+				dev_err(&spi->dev, "EOW timed out\n");
+
+			mcspi_write_reg(mcspi->master, OMAP2_MCSPI_IRQSTATUS,
+					OMAP2_MCSPI_IRQSTATUS_EOW);
+		}
+
 		/* for TX_ONLY mode, be sure all words have shifted out */
 		if (rx == NULL) {
-			if (mcspi_wait_for_reg_bit(chstat_reg,
-						OMAP2_MCSPI_CHSTAT_TXS) < 0)
-				dev_err(&spi->dev, "TXS timed out\n");
-			else if (mcspi_wait_for_reg_bit(chstat_reg,
-						OMAP2_MCSPI_CHSTAT_EOT) < 0)
+			chstat_reg = cs->base + OMAP2_MCSPI_CHSTAT0;
+			if (mcspi->fifo_depth > 0) {
+				wait_res = mcspi_wait_for_reg_bit(chstat_reg,
+						OMAP2_MCSPI_CHSTAT_TXFFE);
+				if (wait_res < 0)
+					dev_err(&spi->dev, "TXFFE timed out\n");
+			} else {
+				wait_res = mcspi_wait_for_reg_bit(chstat_reg,
+						OMAP2_MCSPI_CHSTAT_TXS);
+				if (wait_res < 0)
+					dev_err(&spi->dev, "TXS timed out\n");
+			}
+			if (wait_res >= 0 &&
+				(mcspi_wait_for_reg_bit(chstat_reg,
+					OMAP2_MCSPI_CHSTAT_EOT) < 0))
 				dev_err(&spi->dev, "EOT timed out\n");
 		}
 	}
@@ -958,7 +1061,7 @@ static void omap2_mcspi_work(struct omap2_mcspi *mcspi, struct spi_message *m)
 	cs = spi->controller_state;
 	cd = spi->controller_data;
 
-	omap2_mcspi_set_enable(spi, 1);
+	omap2_mcspi_set_enable(spi, 0);
 	list_for_each_entry(t, &m->transfers, transfer_list) {
 		if (t->tx_buf == NULL && t->rx_buf == NULL && t->len) {
 			status = -EINVAL;
@@ -1006,6 +1109,13 @@ static void omap2_mcspi_work(struct omap2_mcspi *mcspi, struct spi_message *m)
 		if (t->len) {
 			unsigned	count;
 
+			if (mcspi->fifo_enabled &&
+			    (mcspi_dma->dma_rx && mcspi_dma->dma_tx) &&
+			    (m->is_dma_mapped || t->len >= DMA_MIN_BYTES))
+				omap2_mcspi_set_fifo(spi, t, 1);
+
+			omap2_mcspi_set_enable(spi, 1);
+
 			/* RX_ONLY mode needs dummy data in TX reg */
 			if (t->tx_buf == NULL)
 				__raw_writel(0, cs->base
@@ -1032,6 +1142,11 @@ static void omap2_mcspi_work(struct omap2_mcspi *mcspi, struct spi_message *m)
 			omap2_mcspi_force_cs(spi, 0);
 			cs_active = 0;
 		}
+
+		omap2_mcspi_set_enable(spi, 0);
+
+		if (mcspi->fifo_depth > 0)
+			omap2_mcspi_set_fifo(spi, t, 0);
 	}
 	/* Restore defaults if they were overriden */
 	if (par_override) {
@@ -1052,8 +1167,10 @@ static void omap2_mcspi_work(struct omap2_mcspi *mcspi, struct spi_message *m)
 
 	omap2_mcspi_set_enable(spi, 0);
 
-	m->status = status;
+	if (mcspi->fifo_depth > 0 && t)
+		omap2_mcspi_set_fifo(spi, t, 0);
 
+	m->status = status;
 }
 
 static int omap2_mcspi_transfer_one_message(struct spi_master *master,
@@ -1226,6 +1343,9 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 		master->bus_num = bus_num++;
 		if (of_get_property(node, "ti,pindir-d0-out-d1-in", NULL))
 			mcspi->pin_dir = MCSPI_PINDIR_D0_OUT_D1_IN;
+
+		if (of_find_property(node, "ti,spi-fifo-enabled", NULL))
+			mcspi->fifo_enabled = 1;
 	} else {
 		pdata = pdev->dev.platform_data;
 		master->num_chipselect = pdata->num_cs;
-- 
1.7.0.4


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
