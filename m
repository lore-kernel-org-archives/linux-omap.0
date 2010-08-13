From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 2/2 v3] OMAP-McSPI :Adds support for FIFO and auto chip
     select mode
Date: Fri, 13 Aug 2010 19:29:05 +0530 (IST)
Message-ID: <32933.192.168.10.88.1281707945.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34063 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934386Ab0HMN7S (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Aug 2010 09:59:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org
Cc: Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, dbrownell@users.sourceforge.net, Hemanth V <hemanthv@ti.com>


From: Hemanth V <hemanthv@ti.com>

DMA and FIFO could be enabled together for better throughput.
Platform config parameters have been added to enable these
features on any particular McSPI controller.

FIFO can be enabled by defining fifo_depth parameter. fifo_depth needs
to be a multiple of buffer size that is used for read/write.

Auto chip select mode can be enabled by setting force_cs_mode
to zero

Cc: Tony Lindgren <tony@atomide.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Hemanth V <hemanthv@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 drivers/spi/omap2_mcspi.c |  336 ++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 300 insertions(+), 36 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index b3a94ca..dc0420f 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -41,6 +41,7 @@
 #include <plat/mcspi.h>

 #define OMAP2_MCSPI_MAX_FREQ		48000000
+#define OMAP2_MCSPI_MAX_FIFODEPTH       64

 /* OMAP2 has 3 SPI controllers, while OMAP3 has 4 */
 #define OMAP2_MCSPI_MAX_CTRL 		4
@@ -53,6 +54,7 @@
 #define OMAP2_MCSPI_WAKEUPENABLE	0x20
 #define OMAP2_MCSPI_SYST		0x24
 #define OMAP2_MCSPI_MODULCTRL		0x28
+#define OMAP2_MCSPI_XFERLEVEL		0x7c

 /* per-channel banks, 0x14 bytes each, first is: */
 #define OMAP2_MCSPI_CHCONF0		0x2c
@@ -89,11 +91,15 @@
 #define OMAP2_MCSPI_CHCONF_IS		BIT(18)
 #define OMAP2_MCSPI_CHCONF_TURBO	BIT(19)
 #define OMAP2_MCSPI_CHCONF_FORCE	BIT(20)
+#define OMAP2_MCSPI_CHCONF_FFET 	BIT(27)
+#define OMAP2_MCSPI_CHCONF_FFER 	BIT(28)

 #define OMAP2_MCSPI_CHSTAT_RXS		BIT(0)
 #define OMAP2_MCSPI_CHSTAT_TXS		BIT(1)
 #define OMAP2_MCSPI_CHSTAT_EOT		BIT(2)

+#define OMAP2_MCSPI_IRQ_EOW		BIT(17)
+
 #define OMAP2_MCSPI_CHCTRL_EN		BIT(0)

 #define OMAP2_MCSPI_WAKEUPENABLE_WKEN	BIT(0)
@@ -115,7 +121,6 @@ struct omap2_mcspi_dma {
  */
 #define DMA_MIN_BYTES			160

-
 struct omap2_mcspi {
 	struct work_struct	work;
 	/* lock protects queue and registers */
@@ -129,6 +134,10 @@ struct omap2_mcspi {
 	unsigned long		phys;
 	/* SPI1 has 4 channels, while SPI2 has 2 */
 	struct omap2_mcspi_dma	*dma_channels;
+	u8			mcspi_mode;
+	u8			dma_mode;
+	u8			force_cs_mode;
+	u16			fifo_depth;
 };

 struct omap2_mcspi_cs {
@@ -152,6 +161,37 @@ struct omap2_mcspi_regs {

 static struct omap2_mcspi_regs omap2_mcspi_ctx[OMAP2_MCSPI_MAX_CTRL];

+#ifdef CONFIG_SPI_DEBUG
+struct reg_type {
+	char name[40];
+	int offset;
+};
+
+static struct reg_type reg_map[] = {
+	{"MCSPI_REV", 0x0},
+	{"MCSPI_SYSCONFIG", 0x10},
+	{"MCSPI_SYSSTATUS", 0x14},
+	{"MCSPI_IRQSTATUS", 0x18},
+	{"MCSPI_IRQENABLE", 0x1C},
+	{"MCSPI_WAKEUPENABLE", 0x20},
+	{"MCSPI_SYST", 0x24},
+	{"MCSPI_MODULCTRL", 0x28},
+	{"MCSPI_XFERLEVEL", 0x7c},
+	{"CH0", 0x2C},
+	{"CH1", 0x40},
+	{"CH2", 0x54},
+	{"CH3", 0x68}
+};
+
+static struct reg_type ch_reg_type[] = {
+	{"CONF", 0x00},
+	{"STAT", 0x04},
+	{"CTRL", 0x08},
+	{"TX", 0x0C},
+	{"RX", 0x10},
+};
+#endif
+
 static struct workqueue_struct *omap2_mcspi_wq;

 #define MOD_REG_BIT(val, mask, set) do { \
@@ -223,6 +263,39 @@ static void omap2_mcspi_set_dma_req(const struct spi_device *spi,
 	mcspi_write_chconf0(spi, l);
 }

+#ifdef CONFIG_SPI_DEBUG
+static int
+omap2_mcspi_dump_regs(struct spi_master *master)
+{
+	u32 spi_base;
+	u32 reg;
+	u32 channel;
+	struct omap2_mcspi *mcspi = spi_master_get_devdata(master);
+
+	spi_base = (u32)mcspi->base;
+
+	for (reg = 0; (reg < ARRAY_SIZE(reg_map)); reg++) {
+		struct reg_type *reg_d = &reg_map[reg];
+		u32 base1 = spi_base + reg_d->offset;
+		if (reg_d->name[0] == 'C') {
+			for (channel = 0; (channel < (ARRAY_SIZE(ch_reg_type)));
+			    channel++) {
+				struct reg_type *reg_c = &ch_reg_type[channel];
+				u32 base2 = base1 + reg_c->offset;
+				pr_debug("MCSPI_%s%s [0x%08X] = 0x%08X\n",
+				       reg_d->name, reg_c->name, base2,
+				       __raw_readl(base2));
+			}
+		} else {
+			pr_debug("%s : [0x%08X] = 0x%08X\n",
+				reg_d->name, base1, __raw_readl(base1));
+		}
+
+	}
+	return 0;
+}
+#endif
+
 static void omap2_mcspi_set_enable(const struct spi_device *spi, int enable)
 {
 	u32 l;
@@ -242,22 +315,135 @@ static void omap2_mcspi_force_cs(struct spi_device *spi, int cs_active)
 	mcspi_write_chconf0(spi, l);
 }

+static int omap2_mcspi_set_txfifo(const struct spi_device *spi, int buf_size,
+					int enable)
+{
+	u32 l, rw, s;
+	unsigned short revert = 0;
+	struct spi_master *master = spi->master;
+	struct omap2_mcspi *mcspi = spi_master_get_devdata(master);
+
+	l = mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCONF0);
+	s = mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCTRL0);
+
+	if (enable == 1) {
+
+		/* FIFO cannot be enabled for both TX and RX
+		 * simultaneously
+		 */
+		if (l & OMAP2_MCSPI_CHCONF_FFER)
+			return -EPERM;
+
+		/* Channel needs to be disabled and enabled
+		 * for FIFO setting to take affect
+		 */
+		if (s & OMAP2_MCSPI_CHCTRL_EN) {
+			omap2_mcspi_set_enable(spi, 0);
+			revert = 1;
+		}
+
+		if (buf_size < mcspi->fifo_depth)
+			mcspi_write_reg(master, OMAP2_MCSPI_XFERLEVEL,
+						((buf_size << 16) |
+						(buf_size - 1) << 0));
+		else
+			mcspi_write_reg(master, OMAP2_MCSPI_XFERLEVEL,
+						((buf_size << 16) |
+						(mcspi->fifo_depth - 1) << 0));
+	}
+
+	rw = OMAP2_MCSPI_CHCONF_FFET;
+	MOD_REG_BIT(l, rw, enable);
+	mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, l);
+
+	if (revert)
+		omap2_mcspi_set_enable(spi, 1);
+
+	return 0;
+
+}
+
+static int omap2_mcspi_set_rxfifo(const struct spi_device *spi, int buf_size,
+					int enable)
+{
+	u32 l, rw, s;
+	unsigned short revert = 0;
+	struct spi_master *master = spi->master;
+	struct omap2_mcspi *mcspi = spi_master_get_devdata(master);
+
+	l = mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCONF0);
+	s = mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCTRL0);
+
+	if (enable == 1) {
+
+		/* FIFO cannot be enabled for both TX and RX
+		 * simultaneously
+		 */
+		if (l & OMAP2_MCSPI_CHCONF_FFET)
+			return -EPERM;
+
+		/* Channel needs to be disabled and enabled
+		 * for FIFO setting to take affect
+		 */
+		if (s & OMAP2_MCSPI_CHCTRL_EN) {
+			omap2_mcspi_set_enable(spi, 0);
+			revert = 1;
+		}
+
+		if (buf_size < mcspi->fifo_depth)
+			mcspi_write_reg(master, OMAP2_MCSPI_XFERLEVEL,
+						((buf_size << 16) |
+						(buf_size - 1) << 8));
+		else
+			mcspi_write_reg(master, OMAP2_MCSPI_XFERLEVEL,
+						((buf_size << 16) |
+						(mcspi->fifo_depth - 1) << 8));
+	}
+
+	rw = OMAP2_MCSPI_CHCONF_FFER;
+	MOD_REG_BIT(l, rw, enable);
+	mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, l);
+
+	if (revert)
+		omap2_mcspi_set_enable(spi, 1);
+
+	return 0;
+
+}
+
 static void omap2_mcspi_set_master_mode(struct spi_master *master)
 {
 	u32 l;
+	struct omap2_mcspi *mcspi = spi_master_get_devdata(master);

 	/* setup when switching from (reset default) slave mode
-	 * to single-channel master mode
+	 * to single-channel master mode based on config value
 	 */
 	l = mcspi_read_reg(master, OMAP2_MCSPI_MODULCTRL);
 	MOD_REG_BIT(l, OMAP2_MCSPI_MODULCTRL_STEST, 0);
 	MOD_REG_BIT(l, OMAP2_MCSPI_MODULCTRL_MS, 0);
-	MOD_REG_BIT(l, OMAP2_MCSPI_MODULCTRL_SINGLE, 1);
+
+	if (mcspi->force_cs_mode)
+		MOD_REG_BIT(l, OMAP2_MCSPI_MODULCTRL_SINGLE, 1);
+
 	mcspi_write_reg(master, OMAP2_MCSPI_MODULCTRL, l);

 	omap2_mcspi_ctx[master->bus_num - 1].modulctrl = l;
 }

+static int mcspi_wait_for_reg_bit(void __iomem *reg, unsigned long bit)
+{
+	unsigned long timeout;
+
+	timeout = jiffies + msecs_to_jiffies(1000);
+	while (!(__raw_readl(reg) & bit)) {
+		if (time_after(jiffies, timeout))
+			return -1;
+		cpu_relax();
+	}
+	return 0;
+}
+
 static void omap2_mcspi_restore_ctx(struct omap2_mcspi *mcspi)
 {
 	struct spi_master *spi_cntrl;
@@ -302,16 +488,18 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	struct omap2_mcspi	*mcspi;
 	struct omap2_mcspi_cs	*cs = spi->controller_state;
 	struct omap2_mcspi_dma  *mcspi_dma;
-	unsigned int		count, c;
+	unsigned int		count, c, bytes_per_transfer;
 	unsigned long		base, tx_reg, rx_reg;
 	int			word_len, data_type, element_count;
-	int			elements;
+	int			elements, frame_count, sync_type;
 	u32			l;
 	u8			* rx;
 	const u8		* tx;
+	void __iomem            *irqstat_reg;

 	mcspi = spi_master_get_devdata(spi->master);
 	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
+	irqstat_reg = mcspi->base + OMAP2_MCSPI_IRQSTATUS;
 	l = mcspi_cached_chconf0(spi);

 	count = xfer->len;
@@ -327,19 +515,34 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	if (word_len <= 8) {
 		data_type = OMAP_DMA_DATA_TYPE_S8;
 		element_count = count;
+		bytes_per_transfer = 1;
 	} else if (word_len <= 16) {
 		data_type = OMAP_DMA_DATA_TYPE_S16;
 		element_count = count >> 1;
+		bytes_per_transfer = 2;
 	} else /* word_len <= 32 */ {
 		data_type = OMAP_DMA_DATA_TYPE_S32;
 		element_count = count >> 2;
+		bytes_per_transfer = 4;
+	}
+
+	if ((mcspi->fifo_depth != 0) && (count > mcspi->fifo_depth)) {
+		sync_type = OMAP_DMA_SYNC_FRAME;
+		element_count = mcspi->fifo_depth/bytes_per_transfer;
+		frame_count = count/mcspi->fifo_depth;
+	} else if ((mcspi->fifo_depth != 0) && (count <=  mcspi->fifo_depth)) {
+		sync_type = OMAP_DMA_SYNC_FRAME;
+		frame_count = 1;
+	} else {
+		sync_type = OMAP_DMA_SYNC_ELEMENT;
+		frame_count = 1;
 	}

 	if (tx != NULL) {
+
 		omap_set_dma_transfer_params(mcspi_dma->dma_tx_channel,
-				data_type, element_count, 1,
-				OMAP_DMA_SYNC_ELEMENT,
-				mcspi_dma->dma_tx_sync_dev, 0);
+				data_type, element_count, frame_count,
+				sync_type, mcspi_dma->dma_tx_sync_dev, 0);

 		omap_set_dma_dest_params(mcspi_dma->dma_tx_channel, 0,
 				OMAP_DMA_AMODE_CONSTANT,
@@ -348,6 +551,9 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 		omap_set_dma_src_params(mcspi_dma->dma_tx_channel, 0,
 				OMAP_DMA_AMODE_POST_INC,
 				xfer->tx_dma, 0, 0);
+
+		if (mcspi->fifo_depth != 0)
+			omap2_mcspi_set_txfifo(spi, count, 1);
 	}

 	if (rx != NULL) {
@@ -367,6 +573,14 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 		omap_set_dma_dest_params(mcspi_dma->dma_rx_channel, 0,
 				OMAP_DMA_AMODE_POST_INC,
 				xfer->rx_dma, 0, 0);
+
+		if (mcspi->fifo_depth != 0) {
+			omap2_mcspi_set_rxfifo(spi, count, 1);
+
+			/* Dummy write required for RX only mode */
+			if (tx == NULL)
+				mcspi_write_cs_reg(spi, OMAP2_MCSPI_TX0, 0);
+		}
 	}

 	if (tx != NULL) {
@@ -381,11 +595,32 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)

 	if (tx != NULL) {
 		wait_for_completion(&mcspi_dma->dma_tx_completion);
+
+		if (mcspi->fifo_depth != 0) {
+			if (mcspi_wait_for_reg_bit(irqstat_reg,
+				OMAP2_MCSPI_IRQ_EOW) < 0)
+					dev_err(&spi->dev, "TXS timed out\n");
+
+		mcspi_write_reg(mcspi->master, OMAP2_MCSPI_IRQSTATUS,
+				OMAP2_MCSPI_IRQ_EOW);
+
+		omap2_mcspi_set_txfifo(spi, count, 0);
+		}
+
 		dma_unmap_single(NULL, xfer->tx_dma, count, DMA_TO_DEVICE);
 	}

 	if (rx != NULL) {
 		wait_for_completion(&mcspi_dma->dma_rx_completion);
+
+		if (mcspi->fifo_depth != 0) {
+			omap2_mcspi_set_rxfifo(spi, count, 0);
+
+		mcspi_write_reg(mcspi->master, OMAP2_MCSPI_IRQSTATUS,
+				OMAP2_MCSPI_IRQ_EOW);
+
+		}
+
 		dma_unmap_single(NULL, xfer->rx_dma, count, DMA_FROM_DEVICE);
 		omap2_mcspi_set_enable(spi, 0);

@@ -435,19 +670,6 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	return count;
 }

-static int mcspi_wait_for_reg_bit(void __iomem *reg, unsigned long bit)
-{
-	unsigned long timeout;
-
-	timeout = jiffies + msecs_to_jiffies(1000);
-	while (!(__raw_readl(reg) & bit)) {
-		if (time_after(jiffies, timeout))
-			return -1;
-		cpu_relax();
-	}
-	return 0;
-}
-
 static unsigned
 omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 {
@@ -684,8 +906,13 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 	/* standard 4-wire master mode:  SCK, MOSI/out, MISO/in, nCS
 	 * REVISIT: this controller could support SPI_3WIRE mode.
 	 */
-	l &= ~(OMAP2_MCSPI_CHCONF_IS|OMAP2_MCSPI_CHCONF_DPE1);
-	l |= OMAP2_MCSPI_CHCONF_DPE0;
+	if (mcspi->mcspi_mode == OMAP2_MCSPI_MASTER) {
+		l &= ~(OMAP2_MCSPI_CHCONF_IS|OMAP2_MCSPI_CHCONF_DPE1);
+		l |= OMAP2_MCSPI_CHCONF_DPE0;
+	} else {
+		return -EINVAL;
+	}
+

 	/* wordlength */
 	l &= ~OMAP2_MCSPI_CHCONF_WL_MASK;
@@ -697,9 +924,11 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 	else
 		l &= ~OMAP2_MCSPI_CHCONF_EPOL;

-	/* set clock divisor */
-	l &= ~OMAP2_MCSPI_CHCONF_CLKD_MASK;
-	l |= div << 2;
+	if (mcspi->mcspi_mode == OMAP2_MCSPI_MASTER) {
+		/* set clock divisor */
+		l &= ~OMAP2_MCSPI_CHCONF_CLKD_MASK;
+		l |= div << 2;
+	}

 	/* set SPI mode 0..3 */
 	if (spi->mode & SPI_CPOL)
@@ -909,7 +1138,10 @@ static void omap2_mcspi_work(struct work_struct *work)
 					par_override = 0;
 			}

-			if (!cs_active) {
+			if ((!cs_active) && (mcspi->force_cs_mode) &&
+				(mcspi->mcspi_mode ==
+				OMAP2_MCSPI_MASTER)) {
+
 				omap2_mcspi_force_cs(spi, 1);
 				cs_active = 1;
 			}
@@ -939,10 +1171,14 @@ static void omap2_mcspi_work(struct work_struct *work)
 					__raw_writel(0, cs->base
 							+ OMAP2_MCSPI_TX0);

-				if (m->is_dma_mapped || t->len >= DMA_MIN_BYTES)
+				if (m->is_dma_mapped ||
+					t->len >= DMA_MIN_BYTES ||
+					mcspi->dma_mode)
+
 					count = omap2_mcspi_txrx_dma(spi, t);
 				else
 					count = omap2_mcspi_txrx_pio(spi, t);
+
 				m->actual_length += count;

 				if (count != t->len) {
@@ -955,7 +1191,10 @@ static void omap2_mcspi_work(struct work_struct *work)
 				udelay(t->delay_usecs);

 			/* ignore the "leave it on after last xfer" hint */
-			if (t->cs_change) {
+			if ((t->cs_change) && (mcspi->force_cs_mode) &&
+				(mcspi->mcspi_mode ==
+				OMAP2_MCSPI_MASTER)) {
+
 				omap2_mcspi_force_cs(spi, 0);
 				cs_active = 0;
 			}
@@ -967,8 +1206,9 @@ static void omap2_mcspi_work(struct work_struct *work)
 			status = omap2_mcspi_setup_transfer(spi, NULL);
 		}

-		if (cs_active)
-			omap2_mcspi_force_cs(spi, 0);
+		if ((cs_active) && (mcspi->force_cs_mode) &&
+			(mcspi->mcspi_mode == OMAP2_MCSPI_MASTER))
+				omap2_mcspi_force_cs(spi, 0);

 		omap2_mcspi_set_enable(spi, 0);

@@ -993,6 +1233,8 @@ static int omap2_mcspi_transfer(struct spi_device *spi, struct spi_message *m)
 	m->actual_length = 0;
 	m->status = 0;

+	mcspi = spi_master_get_devdata(spi->master);
+
 	/* reject invalid messages and transfers */
 	if (list_empty(&m->transfers) || !m->complete)
 		return -EINVAL;
@@ -1021,7 +1263,14 @@ static int omap2_mcspi_transfer(struct spi_device *spi, struct spi_message *m)
 			return -EINVAL;
 		}

-		if (m->is_dma_mapped || len < DMA_MIN_BYTES)
+		if (mcspi->fifo_depth != 0) {
+			if ((len % mcspi->fifo_depth) != 0)
+				return -EINVAL;
+		}
+
+		/* Ignore DMA_MIN_BYTES check if dma only mode is set */
+		if (m->is_dma_mapped || ((len < DMA_MIN_BYTES) &&
+						(!mcspi->dma_mode)))
 			continue;

 		/* Do DMA mapping "early" for better error reporting and
@@ -1052,8 +1301,6 @@ static int omap2_mcspi_transfer(struct spi_device *spi, struct spi_message *m)
 		}
 	}

-	mcspi = spi_master_get_devdata(spi->master);
-
 	spin_lock_irqsave(&mcspi->lock, flags);
 	list_add_tail(&m->queue, &mcspi->msg_queue);
 	queue_work(omap2_mcspi_wq, &mcspi->work);
@@ -1066,6 +1313,7 @@ static int __init omap2_mcspi_reset(struct omap2_mcspi *mcspi)
 {
 	struct spi_master	*master = mcspi->master;
 	u32			tmp;
+	u32			error = 0;

 	if (omap2_mcspi_enable_clocks(mcspi))
 		return -1;
@@ -1086,9 +1334,13 @@ static int __init omap2_mcspi_reset(struct omap2_mcspi *mcspi)
 	mcspi_write_reg(master, OMAP2_MCSPI_WAKEUPENABLE, tmp);
 	omap2_mcspi_ctx[master->bus_num - 1].wakeupenable = tmp;

-	omap2_mcspi_set_master_mode(master);
+	if (mcspi->mcspi_mode == OMAP2_MCSPI_MASTER)
+		omap2_mcspi_set_master_mode(master);
+	else
+		error = -EINVAL;
+
 	omap2_mcspi_disable_clocks(mcspi);
-	return 0;
+	return error;
 }

 static u8 __initdata spi1_rxdma_id [] = {
@@ -1141,6 +1393,8 @@ static u8 __initdata spi4_txdma_id[] = {
 static int __init omap2_mcspi_probe(struct platform_device *pdev)
 {
 	struct spi_master	*master;
+	struct omap2_mcspi_platform_config *pdata =
+		(struct omap2_mcspi_platform_config *)pdev->dev.platform_data;
 	struct omap2_mcspi	*mcspi;
 	struct resource		*r;
 	int			status = 0, i;
@@ -1198,6 +1452,16 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)

 	mcspi = spi_master_get_devdata(master);
 	mcspi->master = master;
+	mcspi->mcspi_mode = OMAP2_MCSPI_MASTER;
+	mcspi->dma_mode = pdata->dma_mode;
+	mcspi->force_cs_mode = pdata->force_cs_mode;
+
+	if (pdata->fifo_depth <= OMAP2_MCSPI_MAX_FIFODEPTH)
+		mcspi->fifo_depth = pdata->fifo_depth;
+	else {
+		mcspi->fifo_depth = 0;
+		dev_dbg(&pdev->dev, "Invalid fifo depth specified\n");
+	}

 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (r == NULL) {
-- 
1.6.3.3




