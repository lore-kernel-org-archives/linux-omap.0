From: "Hemanth V" <hemanthv@ti.com>
Subject: [RESEND] [PATCH V2 2/3]: Adds support for FIFO
Date: Thu, 18 Feb 2010 16:15:27 +0530 (IST)
Message-ID: <49574.10.24.255.18.1266489927.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20100218161527_37486"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58687 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756515Ab0BRKpi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Feb 2010 05:45:38 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca
Cc: linux-omap@vger.kernel.org, spi-devel-general@lists.sourceforge.net

------=_20100218161527_37486
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Pl also find the patch attached, incase corrupted by mailer

Thanks
Hemanth

>From 00ae9791a5461fece3c3a89527cf3e8648352c32 Mon Sep 17 00:00:00 2001
From: Hemanth V <hemanthv@ti.com>
Date: Wed, 2 Dec 2009 18:13:13 +0530
Subject: [PATCH 2/3] Adds support for FIFO and auto chip select mode

DMA and FIFO could be enabled together for better throughput.
Platform config parameters have been added to enable these
features on any particular McSPI controller.

FIFO can be enabled by defining fifo_depth parameter. fifo_depth needs
to be a multiple of buffer size that is used for read/write.

Auto chip select mode can be enabled by setting force_cs_mode
to zero

Signed-off-by: Hemanth V <hemanthv@ti.com>
---
 drivers/spi/omap2_mcspi.c |  338 ++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 302 insertions(+), 36 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index 715c518..75a3f04 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -37,10 +37,11 @@

 #include <plat/dma.h>
 #include <plat/clock.h>
+#include <plat/mcspi.h>


 #define OMAP2_MCSPI_MAX_FREQ		48000000
-
+#define OMAP2_MCSPI_MAX_FIFODEPTH       64
 /* OMAP2 has 3 SPI controllers, while OMAP3 has 4 */
 #define OMAP2_MCSPI_MAX_CTRL 		4

@@ -52,6 +53,7 @@
 #define OMAP2_MCSPI_WAKEUPENABLE	0x20
 #define OMAP2_MCSPI_SYST		0x24
 #define OMAP2_MCSPI_MODULCTRL		0x28
+#define OMAP2_MCSPI_XFERLEVEL		0x7c

 /* per-channel banks, 0x14 bytes each, first is: */
 #define OMAP2_MCSPI_CHCONF0		0x2c
@@ -88,11 +90,15 @@
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
@@ -128,6 +134,10 @@ struct omap2_mcspi {
 	unsigned long		phys;
 	/* SPI1 has 4 channels, while SPI2 has 2 */
 	struct omap2_mcspi_dma	*dma_channels;
+	u8			mcspi_mode;
+	u8			dma_mode;
+	u8			force_cs_mode;
+	u16			fifo_depth;
 };

 struct omap2_mcspi_cs {
@@ -151,6 +161,37 @@ struct omap2_mcspi_regs {

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
@@ -221,6 +262,39 @@ static void omap2_mcspi_set_dma_req(const struct
spi_device *spi,
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
@@ -238,22 +312,135 @@ static void omap2_mcspi_force_cs(struct spi_device *spi,
int cs_active)
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
@@ -298,14 +485,17 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct
spi_transfer *xfer)
 	struct omap2_mcspi	*mcspi;
 	struct omap2_mcspi_cs	*cs = spi->controller_state;
 	struct omap2_mcspi_dma  *mcspi_dma;
-	unsigned int		count, c;
+	unsigned int		count, c, bytes_per_transfer;
 	unsigned long		base, tx_reg, rx_reg;
-	int			word_len, data_type, element_count;
+	int			word_len, data_type, element_count, frame_count,
+				sync_type;
 	u8			* rx;
 	const u8		* tx;
+	void __iomem            *irqstat_reg;

 	mcspi = spi_master_get_devdata(spi->master);
 	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
+	irqstat_reg = mcspi->base + OMAP2_MCSPI_IRQSTATUS;

 	count = xfer->len;
 	c = count;
@@ -320,19 +510,34 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct
spi_transfer *xfer)
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
@@ -341,6 +546,9 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct
spi_transfer *xfer)
 		omap_set_dma_src_params(mcspi_dma->dma_tx_channel, 0,
 				OMAP_DMA_AMODE_POST_INC,
 				xfer->tx_dma, 0, 0);
+
+		if (mcspi->fifo_depth != 0)
+			omap2_mcspi_set_txfifo(spi, count, 1);
 	}

 	if (rx != NULL) {
@@ -356,6 +564,14 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct
spi_transfer *xfer)
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
@@ -370,11 +586,32 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct
spi_transfer *xfer)

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
 		if (likely(mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHSTAT0)
@@ -399,19 +636,6 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct
spi_transfer *xfer)
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
@@ -599,8 +823,13 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
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
@@ -612,9 +841,11 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
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
@@ -817,7 +1048,10 @@ static void omap2_mcspi_work(struct work_struct *work)
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
@@ -838,10 +1072,14 @@ static void omap2_mcspi_work(struct work_struct *work)
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
@@ -854,7 +1092,10 @@ static void omap2_mcspi_work(struct work_struct *work)
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
@@ -866,8 +1107,9 @@ static void omap2_mcspi_work(struct work_struct *work)
 			status = omap2_mcspi_setup_transfer(spi, NULL);
 		}

-		if (cs_active)
-			omap2_mcspi_force_cs(spi, 0);
+		if ((cs_active) && (mcspi->force_cs_mode) &&
+			(mcspi->mcspi_mode == OMAP2_MCSPI_MASTER))
+				omap2_mcspi_force_cs(spi, 0);

 		omap2_mcspi_set_enable(spi, 0);

@@ -892,6 +1134,8 @@ static int omap2_mcspi_transfer(struct spi_device *spi,
struct spi_message *m)
 	m->actual_length = 0;
 	m->status = 0;

+	mcspi = spi_master_get_devdata(spi->master);
+
 	/* reject invalid messages and transfers */
 	if (list_empty(&m->transfers) || !m->complete)
 		return -EINVAL;
@@ -920,7 +1164,14 @@ static int omap2_mcspi_transfer(struct spi_device *spi,
struct spi_message *m)
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
@@ -951,8 +1202,6 @@ static int omap2_mcspi_transfer(struct spi_device *spi,
struct spi_message *m)
 		}
 	}

-	mcspi = spi_master_get_devdata(spi->master);
-
 	spin_lock_irqsave(&mcspi->lock, flags);
 	list_add_tail(&m->queue, &mcspi->msg_queue);
 	queue_work(omap2_mcspi_wq, &mcspi->work);
@@ -965,6 +1214,7 @@ static int __init omap2_mcspi_reset(struct omap2_mcspi
*mcspi)
 {
 	struct spi_master	*master = mcspi->master;
 	u32			tmp;
+	u32			error = 0;

 	if (omap2_mcspi_enable_clocks(mcspi))
 		return -1;
@@ -985,9 +1235,13 @@ static int __init omap2_mcspi_reset(struct omap2_mcspi
*mcspi)
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
@@ -1040,6 +1294,8 @@ static u8 __initdata spi4_txdma_id[] = {
 static int __init omap2_mcspi_probe(struct platform_device *pdev)
 {
 	struct spi_master	*master;
+	struct omap2_mcspi_platform_config *pdata =
+		(struct omap2_mcspi_platform_config *)pdev->dev.platform_data;
 	struct omap2_mcspi	*mcspi;
 	struct resource		*r;
 	int			status = 0, i;
@@ -1097,6 +1353,16 @@ static int __init omap2_mcspi_probe(struct
platform_device *pdev)

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
------=_20100218161527_37486
Content-Type: application/octet-stream;
      name="0002-Adds-support-for-FIFO-and-auto-chip-select-mode.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
      filename=
     "0002-Adds-support-for-FIFO-and-auto-chip-select-mode.patch"

RnJvbSAwMGFlOTc5MWE1NDYxZmVjZTNjM2E4OTUyN2NmM2U4NjQ4MzUyYzMyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIZW1hbnRoIFYgPGhlbWFudGh2QHRpLmNvbT4KRGF0ZTogV2Vk
LCAyIERlYyAyMDA5IDE4OjEzOjEzICswNTMwClN1YmplY3Q6IFtQQVRDSCAyLzNdIEFkZHMgc3Vw
cG9ydCBmb3IgRklGTyBhbmQgYXV0byBjaGlwIHNlbGVjdCBtb2RlCgpETUEgYW5kIEZJRk8gY291
bGQgYmUgZW5hYmxlZCB0b2dldGhlciBmb3IgYmV0dGVyIHRocm91Z2hwdXQuClBsYXRmb3JtIGNv
bmZpZyBwYXJhbWV0ZXJzIGhhdmUgYmVlbiBhZGRlZCB0byBlbmFibGUgdGhlc2UKZmVhdHVyZXMg
b24gYW55IHBhcnRpY3VsYXIgTWNTUEkgY29udHJvbGxlci4KCkZJRk8gY2FuIGJlIGVuYWJsZWQg
YnkgZGVmaW5pbmcgZmlmb19kZXB0aCBwYXJhbWV0ZXIuIGZpZm9fZGVwdGggbmVlZHMKdG8gYmUg
YSBtdWx0aXBsZSBvZiBidWZmZXIgc2l6ZSB0aGF0IGlzIHVzZWQgZm9yIHJlYWQvd3JpdGUuCgpB
dXRvIGNoaXAgc2VsZWN0IG1vZGUgY2FuIGJlIGVuYWJsZWQgYnkgc2V0dGluZyBmb3JjZV9jc19t
b2RlCnRvIHplcm8KClNpZ25lZC1vZmYtYnk6IEhlbWFudGggViA8aGVtYW50aHZAdGkuY29tPgot
LS0KIGRyaXZlcnMvc3BpL29tYXAyX21jc3BpLmMgfCAgMzM4ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKystLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCAzMDIgaW5zZXJ0aW9u
cygrKSwgMzYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvb21hcDJfbWNz
cGkuYyBiL2RyaXZlcnMvc3BpL29tYXAyX21jc3BpLmMKaW5kZXggNzE1YzUxOC4uNzVhM2YwNCAx
MDA2NDQKLS0tIGEvZHJpdmVycy9zcGkvb21hcDJfbWNzcGkuYworKysgYi9kcml2ZXJzL3NwaS9v
bWFwMl9tY3NwaS5jCkBAIC0zNywxMCArMzcsMTEgQEAKIAogI2luY2x1ZGUgPHBsYXQvZG1hLmg+
CiAjaW5jbHVkZSA8cGxhdC9jbG9jay5oPgorI2luY2x1ZGUgPHBsYXQvbWNzcGkuaD4KIAogCiAj
ZGVmaW5lIE9NQVAyX01DU1BJX01BWF9GUkVRCQk0ODAwMDAwMAotCisjZGVmaW5lIE9NQVAyX01D
U1BJX01BWF9GSUZPREVQVEggICAgICAgNjQKIC8qIE9NQVAyIGhhcyAzIFNQSSBjb250cm9sbGVy
cywgd2hpbGUgT01BUDMgaGFzIDQgKi8KICNkZWZpbmUgT01BUDJfTUNTUElfTUFYX0NUUkwgCQk0
CiAKQEAgLTUyLDYgKzUzLDcgQEAKICNkZWZpbmUgT01BUDJfTUNTUElfV0FLRVVQRU5BQkxFCTB4
MjAKICNkZWZpbmUgT01BUDJfTUNTUElfU1lTVAkJMHgyNAogI2RlZmluZSBPTUFQMl9NQ1NQSV9N
T0RVTENUUkwJCTB4MjgKKyNkZWZpbmUgT01BUDJfTUNTUElfWEZFUkxFVkVMCQkweDdjCiAKIC8q
IHBlci1jaGFubmVsIGJhbmtzLCAweDE0IGJ5dGVzIGVhY2gsIGZpcnN0IGlzOiAqLwogI2RlZmlu
ZSBPTUFQMl9NQ1NQSV9DSENPTkYwCQkweDJjCkBAIC04OCwxMSArOTAsMTUgQEAKICNkZWZpbmUg
T01BUDJfTUNTUElfQ0hDT05GX0lTCQlCSVQoMTgpCiAjZGVmaW5lIE9NQVAyX01DU1BJX0NIQ09O
Rl9UVVJCTwlCSVQoMTkpCiAjZGVmaW5lIE9NQVAyX01DU1BJX0NIQ09ORl9GT1JDRQlCSVQoMjAp
CisjZGVmaW5lIE9NQVAyX01DU1BJX0NIQ09ORl9GRkVUIAlCSVQoMjcpCisjZGVmaW5lIE9NQVAy
X01DU1BJX0NIQ09ORl9GRkVSIAlCSVQoMjgpCiAKICNkZWZpbmUgT01BUDJfTUNTUElfQ0hTVEFU
X1JYUwkJQklUKDApCiAjZGVmaW5lIE9NQVAyX01DU1BJX0NIU1RBVF9UWFMJCUJJVCgxKQogI2Rl
ZmluZSBPTUFQMl9NQ1NQSV9DSFNUQVRfRU9UCQlCSVQoMikKIAorI2RlZmluZSBPTUFQMl9NQ1NQ
SV9JUlFfRU9XCQlCSVQoMTcpCisKICNkZWZpbmUgT01BUDJfTUNTUElfQ0hDVFJMX0VOCQlCSVQo
MCkKIAogI2RlZmluZSBPTUFQMl9NQ1NQSV9XQUtFVVBFTkFCTEVfV0tFTglCSVQoMCkKQEAgLTEy
OCw2ICsxMzQsMTAgQEAgc3RydWN0IG9tYXAyX21jc3BpIHsKIAl1bnNpZ25lZCBsb25nCQlwaHlz
OwogCS8qIFNQSTEgaGFzIDQgY2hhbm5lbHMsIHdoaWxlIFNQSTIgaGFzIDIgKi8KIAlzdHJ1Y3Qg
b21hcDJfbWNzcGlfZG1hCSpkbWFfY2hhbm5lbHM7CisJdTgJCQltY3NwaV9tb2RlOworCXU4CQkJ
ZG1hX21vZGU7CisJdTgJCQlmb3JjZV9jc19tb2RlOworCXUxNgkJCWZpZm9fZGVwdGg7CiB9Owog
CiBzdHJ1Y3Qgb21hcDJfbWNzcGlfY3MgewpAQCAtMTUxLDYgKzE2MSwzNyBAQCBzdHJ1Y3Qgb21h
cDJfbWNzcGlfcmVncyB7CiAKIHN0YXRpYyBzdHJ1Y3Qgb21hcDJfbWNzcGlfcmVncyBvbWFwMl9t
Y3NwaV9jdHhbT01BUDJfTUNTUElfTUFYX0NUUkxdOwogCisjaWZkZWYgQ09ORklHX1NQSV9ERUJV
Rworc3RydWN0IHJlZ190eXBlIHsKKwljaGFyIG5hbWVbNDBdOworCWludCBvZmZzZXQ7Cit9Owor
CitzdGF0aWMgc3RydWN0IHJlZ190eXBlIHJlZ19tYXBbXSA9IHsKKwl7Ik1DU1BJX1JFViIsIDB4
MH0sCisJeyJNQ1NQSV9TWVNDT05GSUciLCAweDEwfSwKKwl7Ik1DU1BJX1NZU1NUQVRVUyIsIDB4
MTR9LAorCXsiTUNTUElfSVJRU1RBVFVTIiwgMHgxOH0sCisJeyJNQ1NQSV9JUlFFTkFCTEUiLCAw
eDFDfSwKKwl7Ik1DU1BJX1dBS0VVUEVOQUJMRSIsIDB4MjB9LAorCXsiTUNTUElfU1lTVCIsIDB4
MjR9LAorCXsiTUNTUElfTU9EVUxDVFJMIiwgMHgyOH0sCisJeyJNQ1NQSV9YRkVSTEVWRUwiLCAw
eDdjfSwKKwl7IkNIMCIsIDB4MkN9LAorCXsiQ0gxIiwgMHg0MH0sCisJeyJDSDIiLCAweDU0fSwK
Kwl7IkNIMyIsIDB4Njh9Cit9OworCitzdGF0aWMgc3RydWN0IHJlZ190eXBlIGNoX3JlZ190eXBl
W10gPSB7CisJeyJDT05GIiwgMHgwMH0sCisJeyJTVEFUIiwgMHgwNH0sCisJeyJDVFJMIiwgMHgw
OH0sCisJeyJUWCIsIDB4MEN9LAorCXsiUlgiLCAweDEwfSwKK307CisjZW5kaWYKKwogc3RhdGlj
IHN0cnVjdCB3b3JrcXVldWVfc3RydWN0ICpvbWFwMl9tY3NwaV93cTsKIAogI2RlZmluZSBNT0Rf
UkVHX0JJVCh2YWwsIG1hc2ssIHNldCkgZG8geyBcCkBAIC0yMjEsNiArMjYyLDM5IEBAIHN0YXRp
YyB2b2lkIG9tYXAyX21jc3BpX3NldF9kbWFfcmVxKGNvbnN0IHN0cnVjdCBzcGlfZGV2aWNlICpz
cGksCiAJbWNzcGlfd3JpdGVfY2hjb25mMChzcGksIGwpOwogfQogCisjaWZkZWYgQ09ORklHX1NQ
SV9ERUJVRworc3RhdGljIGludAorb21hcDJfbWNzcGlfZHVtcF9yZWdzKHN0cnVjdCBzcGlfbWFz
dGVyICptYXN0ZXIpCit7CisJdTMyIHNwaV9iYXNlOworCXUzMiByZWc7CisJdTMyIGNoYW5uZWw7
CisJc3RydWN0IG9tYXAyX21jc3BpICptY3NwaSA9IHNwaV9tYXN0ZXJfZ2V0X2RldmRhdGEobWFz
dGVyKTsKKworCXNwaV9iYXNlID0gKHUzMiltY3NwaS0+YmFzZTsKKworCWZvciAocmVnID0gMDsg
KHJlZyA8IEFSUkFZX1NJWkUocmVnX21hcCkpOyByZWcrKykgeworCQlzdHJ1Y3QgcmVnX3R5cGUg
KnJlZ19kID0gJnJlZ19tYXBbcmVnXTsKKwkJdTMyIGJhc2UxID0gc3BpX2Jhc2UgKyByZWdfZC0+
b2Zmc2V0OworCQlpZiAocmVnX2QtPm5hbWVbMF0gPT0gJ0MnKSB7CisJCQlmb3IgKGNoYW5uZWwg
PSAwOyAoY2hhbm5lbCA8IChBUlJBWV9TSVpFKGNoX3JlZ190eXBlKSkpOworCQkJICAgIGNoYW5u
ZWwrKykgeworCQkJCXN0cnVjdCByZWdfdHlwZSAqcmVnX2MgPSAmY2hfcmVnX3R5cGVbY2hhbm5l
bF07CisJCQkJdTMyIGJhc2UyID0gYmFzZTEgKyByZWdfYy0+b2Zmc2V0OworCQkJCXByX2RlYnVn
KCJNQ1NQSV8lcyVzIFsweCUwOFhdID0gMHglMDhYXG4iLAorCQkJCSAgICAgICByZWdfZC0+bmFt
ZSwgcmVnX2MtPm5hbWUsIGJhc2UyLAorCQkJCSAgICAgICBfX3Jhd19yZWFkbChiYXNlMikpOwor
CQkJfQorCQl9IGVsc2UgeworCQkJcHJfZGVidWcoIiVzIDogWzB4JTA4WF0gPSAweCUwOFhcbiIs
CisJCQkJcmVnX2QtPm5hbWUsIGJhc2UxLCBfX3Jhd19yZWFkbChiYXNlMSkpOworCQl9CisKKwl9
CisJcmV0dXJuIDA7Cit9CisjZW5kaWYKKwogc3RhdGljIHZvaWQgb21hcDJfbWNzcGlfc2V0X2Vu
YWJsZShjb25zdCBzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpLCBpbnQgZW5hYmxlKQogewogCXUzMiBs
OwpAQCAtMjM4LDIyICszMTIsMTM1IEBAIHN0YXRpYyB2b2lkIG9tYXAyX21jc3BpX2ZvcmNlX2Nz
KHN0cnVjdCBzcGlfZGV2aWNlICpzcGksIGludCBjc19hY3RpdmUpCiAJbWNzcGlfd3JpdGVfY2hj
b25mMChzcGksIGwpOwogfQogCitzdGF0aWMgaW50IG9tYXAyX21jc3BpX3NldF90eGZpZm8oY29u
c3Qgc3RydWN0IHNwaV9kZXZpY2UgKnNwaSwgaW50IGJ1Zl9zaXplLAorCQkJCQlpbnQgZW5hYmxl
KQoreworCXUzMiBsLCBydywgczsKKwl1bnNpZ25lZCBzaG9ydCByZXZlcnQgPSAwOworCXN0cnVj
dCBzcGlfbWFzdGVyICptYXN0ZXIgPSBzcGktPm1hc3RlcjsKKwlzdHJ1Y3Qgb21hcDJfbWNzcGkg
Km1jc3BpID0gc3BpX21hc3Rlcl9nZXRfZGV2ZGF0YShtYXN0ZXIpOworCisJbCA9IG1jc3BpX3Jl
YWRfY3NfcmVnKHNwaSwgT01BUDJfTUNTUElfQ0hDT05GMCk7CisJcyA9IG1jc3BpX3JlYWRfY3Nf
cmVnKHNwaSwgT01BUDJfTUNTUElfQ0hDVFJMMCk7CisKKwlpZiAoZW5hYmxlID09IDEpIHsKKwor
CQkvKiBGSUZPIGNhbm5vdCBiZSBlbmFibGVkIGZvciBib3RoIFRYIGFuZCBSWAorCQkgKiBzaW11
bHRhbmVvdXNseQorCQkgKi8KKwkJaWYgKGwgJiBPTUFQMl9NQ1NQSV9DSENPTkZfRkZFUikKKwkJ
CXJldHVybiAtRVBFUk07CisKKwkJLyogQ2hhbm5lbCBuZWVkcyB0byBiZSBkaXNhYmxlZCBhbmQg
ZW5hYmxlZAorCQkgKiBmb3IgRklGTyBzZXR0aW5nIHRvIHRha2UgYWZmZWN0CisJCSAqLworCQlp
ZiAocyAmIE9NQVAyX01DU1BJX0NIQ1RSTF9FTikgeworCQkJb21hcDJfbWNzcGlfc2V0X2VuYWJs
ZShzcGksIDApOworCQkJcmV2ZXJ0ID0gMTsKKwkJfQorCisJCWlmIChidWZfc2l6ZSA8IG1jc3Bp
LT5maWZvX2RlcHRoKQorCQkJbWNzcGlfd3JpdGVfcmVnKG1hc3RlciwgT01BUDJfTUNTUElfWEZF
UkxFVkVMLAorCQkJCQkJKChidWZfc2l6ZSA8PCAxNikgfAorCQkJCQkJKGJ1Zl9zaXplIC0gMSkg
PDwgMCkpOworCQllbHNlCisJCQltY3NwaV93cml0ZV9yZWcobWFzdGVyLCBPTUFQMl9NQ1NQSV9Y
RkVSTEVWRUwsCisJCQkJCQkoKGJ1Zl9zaXplIDw8IDE2KSB8CisJCQkJCQkobWNzcGktPmZpZm9f
ZGVwdGggLSAxKSA8PCAwKSk7CisJfQorCisJcncgPSBPTUFQMl9NQ1NQSV9DSENPTkZfRkZFVDsK
KwlNT0RfUkVHX0JJVChsLCBydywgZW5hYmxlKTsKKwltY3NwaV93cml0ZV9jc19yZWcoc3BpLCBP
TUFQMl9NQ1NQSV9DSENPTkYwLCBsKTsKKworCWlmIChyZXZlcnQpCisJCW9tYXAyX21jc3BpX3Nl
dF9lbmFibGUoc3BpLCAxKTsKKworCXJldHVybiAwOworCit9CisKK3N0YXRpYyBpbnQgb21hcDJf
bWNzcGlfc2V0X3J4Zmlmbyhjb25zdCBzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpLCBpbnQgYnVmX3Np
emUsCisJCQkJCWludCBlbmFibGUpCit7CisJdTMyIGwsIHJ3LCBzOworCXVuc2lnbmVkIHNob3J0
IHJldmVydCA9IDA7CisJc3RydWN0IHNwaV9tYXN0ZXIgKm1hc3RlciA9IHNwaS0+bWFzdGVyOwor
CXN0cnVjdCBvbWFwMl9tY3NwaSAqbWNzcGkgPSBzcGlfbWFzdGVyX2dldF9kZXZkYXRhKG1hc3Rl
cik7CisKKwlsID0gbWNzcGlfcmVhZF9jc19yZWcoc3BpLCBPTUFQMl9NQ1NQSV9DSENPTkYwKTsK
KwlzID0gbWNzcGlfcmVhZF9jc19yZWcoc3BpLCBPTUFQMl9NQ1NQSV9DSENUUkwwKTsKKworCWlm
IChlbmFibGUgPT0gMSkgeworCisJCS8qIEZJRk8gY2Fubm90IGJlIGVuYWJsZWQgZm9yIGJvdGgg
VFggYW5kIFJYCisJCSAqIHNpbXVsdGFuZW91c2x5CisJCSAqLworCQlpZiAobCAmIE9NQVAyX01D
U1BJX0NIQ09ORl9GRkVUKQorCQkJcmV0dXJuIC1FUEVSTTsKKworCQkvKiBDaGFubmVsIG5lZWRz
IHRvIGJlIGRpc2FibGVkIGFuZCBlbmFibGVkCisJCSAqIGZvciBGSUZPIHNldHRpbmcgdG8gdGFr
ZSBhZmZlY3QKKwkJICovCisJCWlmIChzICYgT01BUDJfTUNTUElfQ0hDVFJMX0VOKSB7CisJCQlv
bWFwMl9tY3NwaV9zZXRfZW5hYmxlKHNwaSwgMCk7CisJCQlyZXZlcnQgPSAxOworCQl9CisKKwkJ
aWYgKGJ1Zl9zaXplIDwgbWNzcGktPmZpZm9fZGVwdGgpCisJCQltY3NwaV93cml0ZV9yZWcobWFz
dGVyLCBPTUFQMl9NQ1NQSV9YRkVSTEVWRUwsCisJCQkJCQkoKGJ1Zl9zaXplIDw8IDE2KSB8CisJ
CQkJCQkoYnVmX3NpemUgLSAxKSA8PCA4KSk7CisJCWVsc2UKKwkJCW1jc3BpX3dyaXRlX3JlZyht
YXN0ZXIsIE9NQVAyX01DU1BJX1hGRVJMRVZFTCwKKwkJCQkJCSgoYnVmX3NpemUgPDwgMTYpIHwK
KwkJCQkJCShtY3NwaS0+Zmlmb19kZXB0aCAtIDEpIDw8IDgpKTsKKwl9CisKKwlydyA9IE9NQVAy
X01DU1BJX0NIQ09ORl9GRkVSOworCU1PRF9SRUdfQklUKGwsIHJ3LCBlbmFibGUpOworCW1jc3Bp
X3dyaXRlX2NzX3JlZyhzcGksIE9NQVAyX01DU1BJX0NIQ09ORjAsIGwpOworCisJaWYgKHJldmVy
dCkKKwkJb21hcDJfbWNzcGlfc2V0X2VuYWJsZShzcGksIDEpOworCisJcmV0dXJuIDA7CisKK30K
Kwogc3RhdGljIHZvaWQgb21hcDJfbWNzcGlfc2V0X21hc3Rlcl9tb2RlKHN0cnVjdCBzcGlfbWFz
dGVyICptYXN0ZXIpCiB7CiAJdTMyIGw7CisJc3RydWN0IG9tYXAyX21jc3BpICptY3NwaSA9IHNw
aV9tYXN0ZXJfZ2V0X2RldmRhdGEobWFzdGVyKTsKIAogCS8qIHNldHVwIHdoZW4gc3dpdGNoaW5n
IGZyb20gKHJlc2V0IGRlZmF1bHQpIHNsYXZlIG1vZGUKLQkgKiB0byBzaW5nbGUtY2hhbm5lbCBt
YXN0ZXIgbW9kZQorCSAqIHRvIHNpbmdsZS1jaGFubmVsIG1hc3RlciBtb2RlIGJhc2VkIG9uIGNv
bmZpZyB2YWx1ZQogCSAqLwogCWwgPSBtY3NwaV9yZWFkX3JlZyhtYXN0ZXIsIE9NQVAyX01DU1BJ
X01PRFVMQ1RSTCk7CiAJTU9EX1JFR19CSVQobCwgT01BUDJfTUNTUElfTU9EVUxDVFJMX1NURVNU
LCAwKTsKIAlNT0RfUkVHX0JJVChsLCBPTUFQMl9NQ1NQSV9NT0RVTENUUkxfTVMsIDApOwotCU1P
RF9SRUdfQklUKGwsIE9NQVAyX01DU1BJX01PRFVMQ1RSTF9TSU5HTEUsIDEpOworCisJaWYgKG1j
c3BpLT5mb3JjZV9jc19tb2RlKQorCQlNT0RfUkVHX0JJVChsLCBPTUFQMl9NQ1NQSV9NT0RVTENU
UkxfU0lOR0xFLCAxKTsKKwogCW1jc3BpX3dyaXRlX3JlZyhtYXN0ZXIsIE9NQVAyX01DU1BJX01P
RFVMQ1RSTCwgbCk7CiAKIAlvbWFwMl9tY3NwaV9jdHhbbWFzdGVyLT5idXNfbnVtIC0gMV0ubW9k
dWxjdHJsID0gbDsKIH0KIAorc3RhdGljIGludCBtY3NwaV93YWl0X2Zvcl9yZWdfYml0KHZvaWQg
X19pb21lbSAqcmVnLCB1bnNpZ25lZCBsb25nIGJpdCkKK3sKKwl1bnNpZ25lZCBsb25nIHRpbWVv
dXQ7CisKKwl0aW1lb3V0ID0gamlmZmllcyArIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCk7CisJd2hp
bGUgKCEoX19yYXdfcmVhZGwocmVnKSAmIGJpdCkpIHsKKwkJaWYgKHRpbWVfYWZ0ZXIoamlmZmll
cywgdGltZW91dCkpCisJCQlyZXR1cm4gLTE7CisJCWNwdV9yZWxheCgpOworCX0KKwlyZXR1cm4g
MDsKK30KKwogc3RhdGljIHZvaWQgb21hcDJfbWNzcGlfcmVzdG9yZV9jdHgoc3RydWN0IG9tYXAy
X21jc3BpICptY3NwaSkKIHsKIAlzdHJ1Y3Qgc3BpX21hc3RlciAqc3BpX2NudHJsOwpAQCAtMjk4
LDE0ICs0ODUsMTcgQEAgb21hcDJfbWNzcGlfdHhyeF9kbWEoc3RydWN0IHNwaV9kZXZpY2UgKnNw
aSwgc3RydWN0IHNwaV90cmFuc2ZlciAqeGZlcikKIAlzdHJ1Y3Qgb21hcDJfbWNzcGkJKm1jc3Bp
OwogCXN0cnVjdCBvbWFwMl9tY3NwaV9jcwkqY3MgPSBzcGktPmNvbnRyb2xsZXJfc3RhdGU7CiAJ
c3RydWN0IG9tYXAyX21jc3BpX2RtYSAgKm1jc3BpX2RtYTsKLQl1bnNpZ25lZCBpbnQJCWNvdW50
LCBjOworCXVuc2lnbmVkIGludAkJY291bnQsIGMsIGJ5dGVzX3Blcl90cmFuc2ZlcjsKIAl1bnNp
Z25lZCBsb25nCQliYXNlLCB0eF9yZWcsIHJ4X3JlZzsKLQlpbnQJCQl3b3JkX2xlbiwgZGF0YV90
eXBlLCBlbGVtZW50X2NvdW50OworCWludAkJCXdvcmRfbGVuLCBkYXRhX3R5cGUsIGVsZW1lbnRf
Y291bnQsIGZyYW1lX2NvdW50LAorCQkJCXN5bmNfdHlwZTsKIAl1OAkJCSogcng7CiAJY29uc3Qg
dTgJCSogdHg7CisJdm9pZCBfX2lvbWVtICAgICAgICAgICAgKmlycXN0YXRfcmVnOwogCiAJbWNz
cGkgPSBzcGlfbWFzdGVyX2dldF9kZXZkYXRhKHNwaS0+bWFzdGVyKTsKIAltY3NwaV9kbWEgPSAm
bWNzcGktPmRtYV9jaGFubmVsc1tzcGktPmNoaXBfc2VsZWN0XTsKKwlpcnFzdGF0X3JlZyA9IG1j
c3BpLT5iYXNlICsgT01BUDJfTUNTUElfSVJRU1RBVFVTOwogCiAJY291bnQgPSB4ZmVyLT5sZW47
CiAJYyA9IGNvdW50OwpAQCAtMzIwLDE5ICs1MTAsMzQgQEAgb21hcDJfbWNzcGlfdHhyeF9kbWEo
c3RydWN0IHNwaV9kZXZpY2UgKnNwaSwgc3RydWN0IHNwaV90cmFuc2ZlciAqeGZlcikKIAlpZiAo
d29yZF9sZW4gPD0gOCkgewogCQlkYXRhX3R5cGUgPSBPTUFQX0RNQV9EQVRBX1RZUEVfUzg7CiAJ
CWVsZW1lbnRfY291bnQgPSBjb3VudDsKKwkJYnl0ZXNfcGVyX3RyYW5zZmVyID0gMTsKIAl9IGVs
c2UgaWYgKHdvcmRfbGVuIDw9IDE2KSB7CiAJCWRhdGFfdHlwZSA9IE9NQVBfRE1BX0RBVEFfVFlQ
RV9TMTY7CiAJCWVsZW1lbnRfY291bnQgPSBjb3VudCA+PiAxOworCQlieXRlc19wZXJfdHJhbnNm
ZXIgPSAyOwogCX0gZWxzZSAvKiB3b3JkX2xlbiA8PSAzMiAqLyB7CiAJCWRhdGFfdHlwZSA9IE9N
QVBfRE1BX0RBVEFfVFlQRV9TMzI7CiAJCWVsZW1lbnRfY291bnQgPSBjb3VudCA+PiAyOworCQli
eXRlc19wZXJfdHJhbnNmZXIgPSA0OworCX0KKworCWlmICgobWNzcGktPmZpZm9fZGVwdGggIT0g
MCkgJiYgKGNvdW50ID4gbWNzcGktPmZpZm9fZGVwdGgpKSB7CisJCXN5bmNfdHlwZSA9IE9NQVBf
RE1BX1NZTkNfRlJBTUU7CisJCWVsZW1lbnRfY291bnQgPSBtY3NwaS0+Zmlmb19kZXB0aC9ieXRl
c19wZXJfdHJhbnNmZXI7CisJCWZyYW1lX2NvdW50ID0gY291bnQvbWNzcGktPmZpZm9fZGVwdGg7
CisJfSBlbHNlIGlmICgobWNzcGktPmZpZm9fZGVwdGggIT0gMCkgJiYgKGNvdW50IDw9ICBtY3Nw
aS0+Zmlmb19kZXB0aCkpIHsKKwkJc3luY190eXBlID0gT01BUF9ETUFfU1lOQ19GUkFNRTsKKwkJ
ZnJhbWVfY291bnQgPSAxOworCX0gZWxzZSB7CisJCXN5bmNfdHlwZSA9IE9NQVBfRE1BX1NZTkNf
RUxFTUVOVDsKKwkJZnJhbWVfY291bnQgPSAxOwogCX0KIAogCWlmICh0eCAhPSBOVUxMKSB7CisK
IAkJb21hcF9zZXRfZG1hX3RyYW5zZmVyX3BhcmFtcyhtY3NwaV9kbWEtPmRtYV90eF9jaGFubmVs
LAotCQkJCWRhdGFfdHlwZSwgZWxlbWVudF9jb3VudCwgMSwKLQkJCQlPTUFQX0RNQV9TWU5DX0VM
RU1FTlQsCi0JCQkJbWNzcGlfZG1hLT5kbWFfdHhfc3luY19kZXYsIDApOworCQkJCWRhdGFfdHlw
ZSwgZWxlbWVudF9jb3VudCwgZnJhbWVfY291bnQsCisJCQkJc3luY190eXBlLCBtY3NwaV9kbWEt
PmRtYV90eF9zeW5jX2RldiwgMCk7CiAKIAkJb21hcF9zZXRfZG1hX2Rlc3RfcGFyYW1zKG1jc3Bp
X2RtYS0+ZG1hX3R4X2NoYW5uZWwsIDAsCiAJCQkJT01BUF9ETUFfQU1PREVfQ09OU1RBTlQsCkBA
IC0zNDEsNiArNTQ2LDkgQEAgb21hcDJfbWNzcGlfdHhyeF9kbWEoc3RydWN0IHNwaV9kZXZpY2Ug
KnNwaSwgc3RydWN0IHNwaV90cmFuc2ZlciAqeGZlcikKIAkJb21hcF9zZXRfZG1hX3NyY19wYXJh
bXMobWNzcGlfZG1hLT5kbWFfdHhfY2hhbm5lbCwgMCwKIAkJCQlPTUFQX0RNQV9BTU9ERV9QT1NU
X0lOQywKIAkJCQl4ZmVyLT50eF9kbWEsIDAsIDApOworCisJCWlmIChtY3NwaS0+Zmlmb19kZXB0
aCAhPSAwKQorCQkJb21hcDJfbWNzcGlfc2V0X3R4ZmlmbyhzcGksIGNvdW50LCAxKTsKIAl9CiAK
IAlpZiAocnggIT0gTlVMTCkgewpAQCAtMzU2LDYgKzU2NCwxNCBAQCBvbWFwMl9tY3NwaV90eHJ4
X2RtYShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpLCBzdHJ1Y3Qgc3BpX3RyYW5zZmVyICp4ZmVyKQog
CQlvbWFwX3NldF9kbWFfZGVzdF9wYXJhbXMobWNzcGlfZG1hLT5kbWFfcnhfY2hhbm5lbCwgMCwK
IAkJCQlPTUFQX0RNQV9BTU9ERV9QT1NUX0lOQywKIAkJCQl4ZmVyLT5yeF9kbWEsIDAsIDApOwor
CisJCWlmIChtY3NwaS0+Zmlmb19kZXB0aCAhPSAwKSB7CisJCQlvbWFwMl9tY3NwaV9zZXRfcnhm
aWZvKHNwaSwgY291bnQsIDEpOworCisJCQkvKiBEdW1teSB3cml0ZSByZXF1aXJlZCBmb3IgUlgg
b25seSBtb2RlICovCisJCQlpZiAodHggPT0gTlVMTCkKKwkJCQltY3NwaV93cml0ZV9jc19yZWco
c3BpLCBPTUFQMl9NQ1NQSV9UWDAsIDApOworCQl9CiAJfQogCiAJaWYgKHR4ICE9IE5VTEwpIHsK
QEAgLTM3MCwxMSArNTg2LDMyIEBAIG9tYXAyX21jc3BpX3R4cnhfZG1hKHN0cnVjdCBzcGlfZGV2
aWNlICpzcGksIHN0cnVjdCBzcGlfdHJhbnNmZXIgKnhmZXIpCiAKIAlpZiAodHggIT0gTlVMTCkg
ewogCQl3YWl0X2Zvcl9jb21wbGV0aW9uKCZtY3NwaV9kbWEtPmRtYV90eF9jb21wbGV0aW9uKTsK
KworCQlpZiAobWNzcGktPmZpZm9fZGVwdGggIT0gMCkgeworCQkJaWYgKG1jc3BpX3dhaXRfZm9y
X3JlZ19iaXQoaXJxc3RhdF9yZWcsCisJCQkJT01BUDJfTUNTUElfSVJRX0VPVykgPCAwKQorCQkJ
CQlkZXZfZXJyKCZzcGktPmRldiwgIlRYUyB0aW1lZCBvdXRcbiIpOworCisJCW1jc3BpX3dyaXRl
X3JlZyhtY3NwaS0+bWFzdGVyLCBPTUFQMl9NQ1NQSV9JUlFTVEFUVVMsCisJCQkJT01BUDJfTUNT
UElfSVJRX0VPVyk7CisKKwkJb21hcDJfbWNzcGlfc2V0X3R4ZmlmbyhzcGksIGNvdW50LCAwKTsK
KwkJfQorCiAJCWRtYV91bm1hcF9zaW5nbGUoTlVMTCwgeGZlci0+dHhfZG1hLCBjb3VudCwgRE1B
X1RPX0RFVklDRSk7CiAJfQogCiAJaWYgKHJ4ICE9IE5VTEwpIHsKIAkJd2FpdF9mb3JfY29tcGxl
dGlvbigmbWNzcGlfZG1hLT5kbWFfcnhfY29tcGxldGlvbik7CisKKwkJaWYgKG1jc3BpLT5maWZv
X2RlcHRoICE9IDApIHsKKwkJCW9tYXAyX21jc3BpX3NldF9yeGZpZm8oc3BpLCBjb3VudCwgMCk7
CisKKwkJbWNzcGlfd3JpdGVfcmVnKG1jc3BpLT5tYXN0ZXIsIE9NQVAyX01DU1BJX0lSUVNUQVRV
UywKKwkJCQlPTUFQMl9NQ1NQSV9JUlFfRU9XKTsKKworCQl9CisKIAkJZG1hX3VubWFwX3Npbmds
ZShOVUxMLCB4ZmVyLT5yeF9kbWEsIGNvdW50LCBETUFfRlJPTV9ERVZJQ0UpOwogCQlvbWFwMl9t
Y3NwaV9zZXRfZW5hYmxlKHNwaSwgMCk7CiAJCWlmIChsaWtlbHkobWNzcGlfcmVhZF9jc19yZWco
c3BpLCBPTUFQMl9NQ1NQSV9DSFNUQVQwKQpAQCAtMzk5LDE5ICs2MzYsNiBAQCBvbWFwMl9tY3Nw
aV90eHJ4X2RtYShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpLCBzdHJ1Y3Qgc3BpX3RyYW5zZmVyICp4
ZmVyKQogCXJldHVybiBjb3VudDsKIH0KIAotc3RhdGljIGludCBtY3NwaV93YWl0X2Zvcl9yZWdf
Yml0KHZvaWQgX19pb21lbSAqcmVnLCB1bnNpZ25lZCBsb25nIGJpdCkKLXsKLQl1bnNpZ25lZCBs
b25nIHRpbWVvdXQ7Ci0KLQl0aW1lb3V0ID0gamlmZmllcyArIG1zZWNzX3RvX2ppZmZpZXMoMTAw
MCk7Ci0Jd2hpbGUgKCEoX19yYXdfcmVhZGwocmVnKSAmIGJpdCkpIHsKLQkJaWYgKHRpbWVfYWZ0
ZXIoamlmZmllcywgdGltZW91dCkpCi0JCQlyZXR1cm4gLTE7Ci0JCWNwdV9yZWxheCgpOwotCX0K
LQlyZXR1cm4gMDsKLX0KLQogc3RhdGljIHVuc2lnbmVkCiBvbWFwMl9tY3NwaV90eHJ4X3Bpbyhz
dHJ1Y3Qgc3BpX2RldmljZSAqc3BpLCBzdHJ1Y3Qgc3BpX3RyYW5zZmVyICp4ZmVyKQogewpAQCAt
NTk5LDggKzgyMywxMyBAQCBzdGF0aWMgaW50IG9tYXAyX21jc3BpX3NldHVwX3RyYW5zZmVyKHN0
cnVjdCBzcGlfZGV2aWNlICpzcGksCiAJLyogc3RhbmRhcmQgNC13aXJlIG1hc3RlciBtb2RlOiAg
U0NLLCBNT1NJL291dCwgTUlTTy9pbiwgbkNTCiAJICogUkVWSVNJVDogdGhpcyBjb250cm9sbGVy
IGNvdWxkIHN1cHBvcnQgU1BJXzNXSVJFIG1vZGUuCiAJICovCi0JbCAmPSB+KE9NQVAyX01DU1BJ
X0NIQ09ORl9JU3xPTUFQMl9NQ1NQSV9DSENPTkZfRFBFMSk7Ci0JbCB8PSBPTUFQMl9NQ1NQSV9D
SENPTkZfRFBFMDsKKwlpZiAobWNzcGktPm1jc3BpX21vZGUgPT0gT01BUDJfTUNTUElfTUFTVEVS
KSB7CisJCWwgJj0gfihPTUFQMl9NQ1NQSV9DSENPTkZfSVN8T01BUDJfTUNTUElfQ0hDT05GX0RQ
RTEpOworCQlsIHw9IE9NQVAyX01DU1BJX0NIQ09ORl9EUEUwOworCX0gZWxzZSB7CisJCXJldHVy
biAtRUlOVkFMOworCX0KKwogCiAJLyogd29yZGxlbmd0aCAqLwogCWwgJj0gfk9NQVAyX01DU1BJ
X0NIQ09ORl9XTF9NQVNLOwpAQCAtNjEyLDkgKzg0MSwxMSBAQCBzdGF0aWMgaW50IG9tYXAyX21j
c3BpX3NldHVwX3RyYW5zZmVyKHN0cnVjdCBzcGlfZGV2aWNlICpzcGksCiAJZWxzZQogCQlsICY9
IH5PTUFQMl9NQ1NQSV9DSENPTkZfRVBPTDsKIAotCS8qIHNldCBjbG9jayBkaXZpc29yICovCi0J
bCAmPSB+T01BUDJfTUNTUElfQ0hDT05GX0NMS0RfTUFTSzsKLQlsIHw9IGRpdiA8PCAyOworCWlm
IChtY3NwaS0+bWNzcGlfbW9kZSA9PSBPTUFQMl9NQ1NQSV9NQVNURVIpIHsKKwkJLyogc2V0IGNs
b2NrIGRpdmlzb3IgKi8KKwkJbCAmPSB+T01BUDJfTUNTUElfQ0hDT05GX0NMS0RfTUFTSzsKKwkJ
bCB8PSBkaXYgPDwgMjsKKwl9CiAKIAkvKiBzZXQgU1BJIG1vZGUgMC4uMyAqLwogCWlmIChzcGkt
Pm1vZGUgJiBTUElfQ1BPTCkKQEAgLTgxNyw3ICsxMDQ4LDEwIEBAIHN0YXRpYyB2b2lkIG9tYXAy
X21jc3BpX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQogCQkJCQlwYXJfb3ZlcnJpZGUg
PSAwOwogCQkJfQogCi0JCQlpZiAoIWNzX2FjdGl2ZSkgeworCQkJaWYgKCghY3NfYWN0aXZlKSAm
JiAobWNzcGktPmZvcmNlX2NzX21vZGUpICYmCisJCQkJKG1jc3BpLT5tY3NwaV9tb2RlID09CisJ
CQkJT01BUDJfTUNTUElfTUFTVEVSKSkgeworCiAJCQkJb21hcDJfbWNzcGlfZm9yY2VfY3Moc3Bp
LCAxKTsKIAkJCQljc19hY3RpdmUgPSAxOwogCQkJfQpAQCAtODM4LDEwICsxMDcyLDE0IEBAIHN0
YXRpYyB2b2lkIG9tYXAyX21jc3BpX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQogCQkJ
CQlfX3Jhd193cml0ZWwoMCwgY3MtPmJhc2UKIAkJCQkJCQkrIE9NQVAyX01DU1BJX1RYMCk7CiAK
LQkJCQlpZiAobS0+aXNfZG1hX21hcHBlZCB8fCB0LT5sZW4gPj0gRE1BX01JTl9CWVRFUykKKwkJ
CQlpZiAobS0+aXNfZG1hX21hcHBlZCB8fAorCQkJCQl0LT5sZW4gPj0gRE1BX01JTl9CWVRFUyB8
fAorCQkJCQltY3NwaS0+ZG1hX21vZGUpCisKIAkJCQkJY291bnQgPSBvbWFwMl9tY3NwaV90eHJ4
X2RtYShzcGksIHQpOwogCQkJCWVsc2UKIAkJCQkJY291bnQgPSBvbWFwMl9tY3NwaV90eHJ4X3Bp
byhzcGksIHQpOworCiAJCQkJbS0+YWN0dWFsX2xlbmd0aCArPSBjb3VudDsKIAogCQkJCWlmIChj
b3VudCAhPSB0LT5sZW4pIHsKQEAgLTg1NCw3ICsxMDkyLDEwIEBAIHN0YXRpYyB2b2lkIG9tYXAy
X21jc3BpX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQogCQkJCXVkZWxheSh0LT5kZWxh
eV91c2Vjcyk7CiAKIAkJCS8qIGlnbm9yZSB0aGUgImxlYXZlIGl0IG9uIGFmdGVyIGxhc3QgeGZl
ciIgaGludCAqLwotCQkJaWYgKHQtPmNzX2NoYW5nZSkgeworCQkJaWYgKCh0LT5jc19jaGFuZ2Up
ICYmIChtY3NwaS0+Zm9yY2VfY3NfbW9kZSkgJiYKKwkJCQkobWNzcGktPm1jc3BpX21vZGUgPT0K
KwkJCQlPTUFQMl9NQ1NQSV9NQVNURVIpKSB7CisKIAkJCQlvbWFwMl9tY3NwaV9mb3JjZV9jcyhz
cGksIDApOwogCQkJCWNzX2FjdGl2ZSA9IDA7CiAJCQl9CkBAIC04NjYsOCArMTEwNyw5IEBAIHN0
YXRpYyB2b2lkIG9tYXAyX21jc3BpX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQogCQkJ
c3RhdHVzID0gb21hcDJfbWNzcGlfc2V0dXBfdHJhbnNmZXIoc3BpLCBOVUxMKTsKIAkJfQogCi0J
CWlmIChjc19hY3RpdmUpCi0JCQlvbWFwMl9tY3NwaV9mb3JjZV9jcyhzcGksIDApOworCQlpZiAo
KGNzX2FjdGl2ZSkgJiYgKG1jc3BpLT5mb3JjZV9jc19tb2RlKSAmJgorCQkJKG1jc3BpLT5tY3Nw
aV9tb2RlID09IE9NQVAyX01DU1BJX01BU1RFUikpCisJCQkJb21hcDJfbWNzcGlfZm9yY2VfY3Mo
c3BpLCAwKTsKIAogCQlvbWFwMl9tY3NwaV9zZXRfZW5hYmxlKHNwaSwgMCk7CiAKQEAgLTg5Miw2
ICsxMTM0LDggQEAgc3RhdGljIGludCBvbWFwMl9tY3NwaV90cmFuc2ZlcihzdHJ1Y3Qgc3BpX2Rl
dmljZSAqc3BpLCBzdHJ1Y3Qgc3BpX21lc3NhZ2UgKm0pCiAJbS0+YWN0dWFsX2xlbmd0aCA9IDA7
CiAJbS0+c3RhdHVzID0gMDsKIAorCW1jc3BpID0gc3BpX21hc3Rlcl9nZXRfZGV2ZGF0YShzcGkt
Pm1hc3Rlcik7CisKIAkvKiByZWplY3QgaW52YWxpZCBtZXNzYWdlcyBhbmQgdHJhbnNmZXJzICov
CiAJaWYgKGxpc3RfZW1wdHkoJm0tPnRyYW5zZmVycykgfHwgIW0tPmNvbXBsZXRlKQogCQlyZXR1
cm4gLUVJTlZBTDsKQEAgLTkyMCw3ICsxMTY0LDE0IEBAIHN0YXRpYyBpbnQgb21hcDJfbWNzcGlf
dHJhbnNmZXIoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSwgc3RydWN0IHNwaV9tZXNzYWdlICptKQog
CQkJcmV0dXJuIC1FSU5WQUw7CiAJCX0KIAotCQlpZiAobS0+aXNfZG1hX21hcHBlZCB8fCBsZW4g
PCBETUFfTUlOX0JZVEVTKQorCQlpZiAobWNzcGktPmZpZm9fZGVwdGggIT0gMCkgeworCQkJaWYg
KChsZW4gJSBtY3NwaS0+Zmlmb19kZXB0aCkgIT0gMCkKKwkJCQlyZXR1cm4gLUVJTlZBTDsKKwkJ
fQorCisJCS8qIElnbm9yZSBETUFfTUlOX0JZVEVTIGNoZWNrIGlmIGRtYSBvbmx5IG1vZGUgaXMg
c2V0ICovCisJCWlmIChtLT5pc19kbWFfbWFwcGVkIHx8ICgobGVuIDwgRE1BX01JTl9CWVRFUykg
JiYKKwkJCQkJCSghbWNzcGktPmRtYV9tb2RlKSkpCiAJCQljb250aW51ZTsKIAogCQkvKiBEbyBE
TUEgbWFwcGluZyAiZWFybHkiIGZvciBiZXR0ZXIgZXJyb3IgcmVwb3J0aW5nIGFuZApAQCAtOTUx
LDggKzEyMDIsNiBAQCBzdGF0aWMgaW50IG9tYXAyX21jc3BpX3RyYW5zZmVyKHN0cnVjdCBzcGlf
ZGV2aWNlICpzcGksIHN0cnVjdCBzcGlfbWVzc2FnZSAqbSkKIAkJfQogCX0KIAotCW1jc3BpID0g
c3BpX21hc3Rlcl9nZXRfZGV2ZGF0YShzcGktPm1hc3Rlcik7Ci0KIAlzcGluX2xvY2tfaXJxc2F2
ZSgmbWNzcGktPmxvY2ssIGZsYWdzKTsKIAlsaXN0X2FkZF90YWlsKCZtLT5xdWV1ZSwgJm1jc3Bp
LT5tc2dfcXVldWUpOwogCXF1ZXVlX3dvcmsob21hcDJfbWNzcGlfd3EsICZtY3NwaS0+d29yayk7
CkBAIC05NjUsNiArMTIxNCw3IEBAIHN0YXRpYyBpbnQgX19pbml0IG9tYXAyX21jc3BpX3Jlc2V0
KHN0cnVjdCBvbWFwMl9tY3NwaSAqbWNzcGkpCiB7CiAJc3RydWN0IHNwaV9tYXN0ZXIJKm1hc3Rl
ciA9IG1jc3BpLT5tYXN0ZXI7CiAJdTMyCQkJdG1wOworCXUzMgkJCWVycm9yID0gMDsKIAogCWlm
IChvbWFwMl9tY3NwaV9lbmFibGVfY2xvY2tzKG1jc3BpKSkKIAkJcmV0dXJuIC0xOwpAQCAtOTg1
LDkgKzEyMzUsMTMgQEAgc3RhdGljIGludCBfX2luaXQgb21hcDJfbWNzcGlfcmVzZXQoc3RydWN0
IG9tYXAyX21jc3BpICptY3NwaSkKIAltY3NwaV93cml0ZV9yZWcobWFzdGVyLCBPTUFQMl9NQ1NQ
SV9XQUtFVVBFTkFCTEUsIHRtcCk7CiAJb21hcDJfbWNzcGlfY3R4W21hc3Rlci0+YnVzX251bSAt
IDFdLndha2V1cGVuYWJsZSA9IHRtcDsKIAotCW9tYXAyX21jc3BpX3NldF9tYXN0ZXJfbW9kZSht
YXN0ZXIpOworCWlmIChtY3NwaS0+bWNzcGlfbW9kZSA9PSBPTUFQMl9NQ1NQSV9NQVNURVIpCisJ
CW9tYXAyX21jc3BpX3NldF9tYXN0ZXJfbW9kZShtYXN0ZXIpOworCWVsc2UKKwkJZXJyb3IgPSAt
RUlOVkFMOworCiAJb21hcDJfbWNzcGlfZGlzYWJsZV9jbG9ja3MobWNzcGkpOwotCXJldHVybiAw
OworCXJldHVybiBlcnJvcjsKIH0KIAogc3RhdGljIHU4IF9faW5pdGRhdGEgc3BpMV9yeGRtYV9p
ZCBbXSA9IHsKQEAgLTEwNDAsNiArMTI5NCw4IEBAIHN0YXRpYyB1OCBfX2luaXRkYXRhIHNwaTRf
dHhkbWFfaWRbXSA9IHsKIHN0YXRpYyBpbnQgX19pbml0IG9tYXAyX21jc3BpX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiB7CiAJc3RydWN0IHNwaV9tYXN0ZXIJKm1hc3RlcjsK
KwlzdHJ1Y3Qgb21hcDJfbWNzcGlfcGxhdGZvcm1fY29uZmlnICpwZGF0YSA9CisJCShzdHJ1Y3Qg
b21hcDJfbWNzcGlfcGxhdGZvcm1fY29uZmlnICopcGRldi0+ZGV2LnBsYXRmb3JtX2RhdGE7CiAJ
c3RydWN0IG9tYXAyX21jc3BpCSptY3NwaTsKIAlzdHJ1Y3QgcmVzb3VyY2UJCSpyOwogCWludAkJ
CXN0YXR1cyA9IDAsIGk7CkBAIC0xMDk3LDYgKzEzNTMsMTYgQEAgc3RhdGljIGludCBfX2luaXQg
b21hcDJfbWNzcGlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAogCW1jc3Bp
ID0gc3BpX21hc3Rlcl9nZXRfZGV2ZGF0YShtYXN0ZXIpOwogCW1jc3BpLT5tYXN0ZXIgPSBtYXN0
ZXI7CisJbWNzcGktPm1jc3BpX21vZGUgPSBPTUFQMl9NQ1NQSV9NQVNURVI7CisJbWNzcGktPmRt
YV9tb2RlID0gcGRhdGEtPmRtYV9tb2RlOworCW1jc3BpLT5mb3JjZV9jc19tb2RlID0gcGRhdGEt
PmZvcmNlX2NzX21vZGU7CisKKwlpZiAocGRhdGEtPmZpZm9fZGVwdGggPD0gT01BUDJfTUNTUElf
TUFYX0ZJRk9ERVBUSCkKKwkJbWNzcGktPmZpZm9fZGVwdGggPSBwZGF0YS0+Zmlmb19kZXB0aDsK
KwllbHNlIHsKKwkJbWNzcGktPmZpZm9fZGVwdGggPSAwOworCQlkZXZfZGJnKCZwZGV2LT5kZXYs
ICJJbnZhbGlkIGZpZm8gZGVwdGggc3BlY2lmaWVkXG4iKTsKKwl9CiAKIAlyID0gcGxhdGZvcm1f
Z2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsKIAlpZiAociA9PSBOVUxMKSB7
Ci0tIAoxLjYuMy4zCgo=
------=_20100218161527_37486--


