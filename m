From: David Brownell <david-b@pacbell.net>
Subject: [patch linux-omap-git 2/2] omap2_mcspi fixes + cleanups
Date: Wed, 23 May 2007 20:46:12 -0700
Message-ID: <200705232046.12406.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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

McSPI functional updates:

 - Implement the spi_transfer.delay_usecs mechanism (previously omitted).

 - Remove strange per-device <asm/arch/mcspi.h> hookery ... it's not even
   correct as a per-device config.  We *always* want "single channel" mod=
e
   (in "keep chipselect active" mode); and if we used "turbo", it would
   be a per-transfer option (as an rx-only double buffering tweak).

 - When enabling/disabling a channel, old value is irrelevant; don't read.

 - Sanity check spi->mode bits, and reject ones we don't support.

 - Streamline DMA channel selection:  do it once during probe(), using st=
atic
   tables; smaller, faster.  OMAP 2430 still needs changes here, minimall=
y for
   the third SPI controller.  (Board init should change too, to not assum=
e
   all SPI controllers are used on every board...)

 - Remove #ifdefs around doing reset on driver startup ... enable clocks
   so we can do that (!), and turn on auto-idle.

 - Waste less time enabling/disabling the clocks while working the queue.

 - Flag DMA channels as freed when we do so ... so they can't get reused
   later (when another driver may own them).

 - Minor PIO fix: don't need to verify TX side completed except for TX_ON=
LY
   mode, since RX completed implies TX completed.

 - Remove bogus code which always dropped chipselect after the last RX_ON=
LY
   word (rather than leaving it enabled).

 - Move error checks out of work loop into setup() and transfer(), so tha=
t
   they're reported ASAP rather than as mysterious transfer errors).

Plus a handful of cleanups:  whitespace fixes, comments.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

---
 drivers/spi/omap2_mcspi.c |  348 +++++++++++++++++++++++++++------------=
-------
 1 file changed, 205 insertions(+), 143 deletions(-)

--- h4.orig/drivers/spi/omap2_mcspi.c	2007-05-23 20:13:15.000000000 -0700
+++ h4/drivers/spi/omap2_mcspi.c	2007-05-23 20:13:17.000000000 -0700
@@ -2,8 +2,8 @@
  * OMAP2 McSPI controller driver
  *
  * Copyright (C) 2005, 2006 Nokia Corporation
- * Author: Samuel Ortiz <samuel.ortiz@nokia.com> and
- *         Juha Yrj=F6l=E4 <juha.yrjola@nokia.com>
+ * Author:	Samuel Ortiz <samuel.ortiz@nokia.com> and
+ *		Juha Yrj=F6l=E4 <juha.yrjola@nokia.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -36,7 +36,6 @@
=20
 #include <asm/io.h>
 #include <asm/arch/dma.h>
-#include <asm/arch/mcspi.h>
 #include <asm/arch/clock.h>
=20
 #define OMAP2_MCSPI_MAX_FREQ		48000000
@@ -49,12 +48,17 @@
 #define OMAP2_MCSPI_WAKEUPENABLE	0x20
 #define OMAP2_MCSPI_SYST		0x24
 #define OMAP2_MCSPI_MODULCTRL		0x28
+
+/* per-channel banks, 0x14 bytes each, first is: */
 #define OMAP2_MCSPI_CHCONF0		0x2c
 #define OMAP2_MCSPI_CHSTAT0		0x30
 #define OMAP2_MCSPI_CHCTRL0		0x34
 #define OMAP2_MCSPI_TX0			0x38
 #define OMAP2_MCSPI_RX0			0x3c
=20
+/* per-register bitmasks: */
+
+#define OMAP2_MCSPI_SYSCONFIG_AUTOIDLE	(1 << 0)
 #define OMAP2_MCSPI_SYSCONFIG_SOFTRESET	(1 << 1)
=20
 #define OMAP2_MCSPI_SYSSTATUS_RESETDONE	(1 << 0)
@@ -79,13 +83,13 @@
 #define OMAP2_MCSPI_CHCONF_TURBO	(1 << 19)
 #define OMAP2_MCSPI_CHCONF_FORCE	(1 << 20)
=20
-
 #define OMAP2_MCSPI_CHSTAT_RXS		(1 << 0)
 #define OMAP2_MCSPI_CHSTAT_TXS		(1 << 1)
 #define OMAP2_MCSPI_CHSTAT_EOT		(1 << 2)
=20
 #define OMAP2_MCSPI_CHCTRL_EN		(1 << 0)
=20
+
 /* We have 2 DMA channels per CS, one for RX and one for TX */
 struct omap2_mcspi_dma {
 	int dma_tx_channel;
@@ -177,8 +181,7 @@ static void omap2_mcspi_set_enable(const
 {
 	u32 l;
=20
-	l =3D mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCTRL0);
-	MOD_REG_BIT(l, OMAP2_MCSPI_CHCTRL_EN, enable);
+	l =3D enable ? OMAP2_MCSPI_CHCTRL_EN : 0;
 	mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCTRL0, l);
 }
=20
@@ -191,24 +194,26 @@ static void omap2_mcspi_force_cs(struct=20
 	mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, l);
 }
=20
-static void omap2_mcspi_set_master_mode(struct spi_device *spi, int sing=
le_channel)
+static void omap2_mcspi_set_master_mode(struct spi_master *master)
 {
 	u32 l;
=20
-	/* Need reset when switching from slave mode */
-	l =3D mcspi_read_reg(spi->master, OMAP2_MCSPI_MODULCTRL);
+	/* setup when switching from (reset default) slave mode
+	 * to single-channel master mode
+	 */
+	l =3D mcspi_read_reg(master, OMAP2_MCSPI_MODULCTRL);
 	MOD_REG_BIT(l, OMAP2_MCSPI_MODULCTRL_STEST, 0);
 	MOD_REG_BIT(l, OMAP2_MCSPI_MODULCTRL_MS, 0);
-	MOD_REG_BIT(l, OMAP2_MCSPI_MODULCTRL_SINGLE, single_channel);
-	mcspi_write_reg(spi->master, OMAP2_MCSPI_MODULCTRL, l);
+	MOD_REG_BIT(l, OMAP2_MCSPI_MODULCTRL_SINGLE, 1);
+	mcspi_write_reg(master, OMAP2_MCSPI_MODULCTRL, l);
 }
=20
-static void omap2_mcspi_txrx_dma(struct spi_device *spi,
-				 struct spi_transfer *xfer)
+static void
+omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 {
-	struct omap2_mcspi      * mcspi;
-	struct omap2_mcspi_cs   * cs =3D spi->controller_state;
-	struct omap2_mcspi_dma  * mcspi_dma;
+	struct omap2_mcspi	*mcspi;
+	struct omap2_mcspi_cs	*cs =3D spi->controller_state;
+	struct omap2_mcspi_dma  *mcspi_dma;
 	unsigned int		count, c;
 	unsigned long		base, tx_reg, rx_reg;
 	int			word_len, data_type, element_count;
@@ -339,13 +344,13 @@ static int mcspi_wait_for_reg_bit(unsign
 	return 0;
 }
=20
-static void omap2_mcspi_txrx_pio(struct spi_device *spi,
-		struct spi_transfer *xfer)
+static void
+omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 {
 	struct omap2_mcspi	*mcspi;
 	struct omap2_mcspi_cs	*cs =3D spi->controller_state;
 	unsigned int		count, c;
-	u32                     l;
+	u32			l;
 	unsigned long		base, tx_reg, rx_reg, chstat_reg;
 	int			word_len;
=20
@@ -371,7 +376,11 @@ static void omap2_mcspi_txrx_pio(struct=20
 	rx_reg		=3D base + OMAP2_MCSPI_RX0;
 	chstat_reg	=3D base + OMAP2_MCSPI_CHSTAT0;
=20
-	/* RX_ONLY mode needs dummy data in TX reg */
+	/* RX_ONLY mode needs dummy data in TX reg.   If we were using
+	 * TURBO mode (double buffered) we'd need to disable the channel
+	 * before reading the penultimate word ... so TURBO wouldn't be an
+	 * option except for the last transfer, else if cs_change is set.
+	 */
 	if (xfer->tx_buf =3D=3D NULL)
 		__raw_writel(0, tx_reg);
=20
@@ -401,8 +410,6 @@ static void omap2_mcspi_txrx_pio(struct=20
 					dev_err(&spi->dev, "RXS timed out\n");
 					goto out;
 				}
-				if (c =3D=3D 0 && tx =3D=3D NULL)
-					omap2_mcspi_set_enable(spi, 0);
 				*rx++ =3D __raw_readl(rx_reg);
 #ifdef VERBOSE
 				dev_dbg(&spi->dev, "read-%d %02x\n",
@@ -436,8 +443,6 @@ static void omap2_mcspi_txrx_pio(struct=20
 					dev_err(&spi->dev, "RXS timed out\n");
 					goto out;
 				}
-				if (c =3D=3D 0 && tx =3D=3D NULL)
-					omap2_mcspi_set_enable(spi, 0);
 				*rx++ =3D __raw_readl(rx_reg);
 #ifdef VERBOSE
 				dev_dbg(&spi->dev, "read-%d %04x\n",
@@ -471,8 +476,6 @@ static void omap2_mcspi_txrx_pio(struct=20
 					dev_err(&spi->dev, "RXS timed out\n");
 					goto out;
 				}
-				if (c =3D=3D 0 && tx =3D=3D NULL)
-					omap2_mcspi_set_enable(spi, 0);
 				*rx++ =3D __raw_readl(rx_reg);
 #ifdef VERBOSE
 				dev_dbg(&spi->dev, "read-%d %04x\n",
@@ -482,7 +485,8 @@ static void omap2_mcspi_txrx_pio(struct=20
 		}
 	}
=20
-	if (xfer->tx_buf !=3D NULL) {
+	/* for TX_ONLY mode, be sure all words have shifted out */
+	if (xfer->rx_buf =3D=3D NULL) {
 		if (mcspi_wait_for_reg_bit(chstat_reg,
 				OMAP2_MCSPI_CHSTAT_TXS) < 0) {
 			dev_err(&spi->dev, "TXS timed out\n");
@@ -496,11 +500,11 @@ out:
 	}
 }
=20
+/* called only when no transfer is active to this device */
 static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 		struct spi_transfer *t)
 {
 	struct omap2_mcspi_cs *cs =3D spi->controller_state;
-	struct omap2_mcspi_device_config *conf;
 	struct omap2_mcspi *mcspi;
 	u32 l =3D 0, div =3D 0;
 	u8 word_len =3D spi->bits_per_word;
@@ -509,23 +513,9 @@ static int omap2_mcspi_setup_transfer(st
=20
 	if (t !=3D NULL && t->bits_per_word)
 		word_len =3D t->bits_per_word;
-	if (!word_len)
-		word_len =3D 8;
=20
-	if (spi->bits_per_word > 32)
-		return -EINVAL;
 	cs->word_len =3D word_len;
=20
-	conf =3D (struct omap2_mcspi_device_config *) spi->controller_data;
-
-	clk_enable(mcspi->ick);
-	clk_enable(mcspi->fck);
-
-	if (conf->single_channel =3D=3D 1)
-		omap2_mcspi_set_master_mode(spi, 1);
-	else
-		omap2_mcspi_set_master_mode(spi, 0);
-
 	if (spi->max_speed_hz) {
 		while (div <=3D 15 && (OMAP2_MCSPI_MAX_FREQ / (1 << div))
 					> spi->max_speed_hz)
@@ -533,25 +523,29 @@ static int omap2_mcspi_setup_transfer(st
 	} else
 		div =3D 15;
=20
-	if (spi->chip_select > 3 || word_len < 4 || word_len > 32 || div > 15) =
{
-		dev_err(&spi->dev, "Invalid McSPI channel setting\n");
-		clk_disable(mcspi->fck);
-		clk_disable(mcspi->ick);
-		return -EINVAL;
-	}
-
 	l =3D mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCONF0);
-	l &=3D ~OMAP2_MCSPI_CHCONF_IS;
-	l &=3D ~OMAP2_MCSPI_CHCONF_DPE1;
+
+	/* standard 4-wire master mode:  SCK, MOSI/out, MISO/in, nCS
+	 * REVISIT: this controller could support SPI_3WIRE mode.
+	 */
+	l &=3D ~(OMAP2_MCSPI_CHCONF_IS|OMAP2_MCSPI_CHCONF_DPE1);
 	l |=3D OMAP2_MCSPI_CHCONF_DPE0;
+
+	/* wordlength */
 	l &=3D ~OMAP2_MCSPI_CHCONF_WL_MASK;
 	l |=3D (word_len - 1) << 7;
+
+	/* set chipselect polarity; manage with FORCE */
 	if (!(spi->mode & SPI_CS_HIGH))
-		l |=3D OMAP2_MCSPI_CHCONF_EPOL;
+		l |=3D OMAP2_MCSPI_CHCONF_EPOL;	/* active-low; normal */
 	else
 		l &=3D ~OMAP2_MCSPI_CHCONF_EPOL;
+
+	/* set clock divisor */
 	l &=3D ~OMAP2_MCSPI_CHCONF_CLKD_MASK;
 	l |=3D div << 2;
+
+	/* set SPI mode 0..3 */
 	if (spi->mode & SPI_CPOL)
 		l |=3D OMAP2_MCSPI_CHCONF_POL;
 	else
@@ -560,15 +554,13 @@ static int omap2_mcspi_setup_transfer(st
 		l |=3D OMAP2_MCSPI_CHCONF_PHA;
 	else
 		l &=3D ~OMAP2_MCSPI_CHCONF_PHA;
+
 	mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, l);
=20
-	dev_dbg(&spi->dev, "setup: speed %d, sample %s edge, clk %s inverted\n"=
,
+	dev_dbg(&spi->dev, "setup: speed %d, sample %s edge, clk %s\n",
 			OMAP2_MCSPI_MAX_FREQ / (1 << div),
 			(spi->mode & SPI_CPHA) ? "trailing" : "leading",
-			(spi->mode & SPI_CPOL) ? "" : "not");
-
-	clk_disable(mcspi->fck);
-	clk_disable(mcspi->ick);
+			(spi->mode & SPI_CPOL) ? "inverted" : "normal");
=20
 	return 0;
 }
@@ -605,61 +597,21 @@ static void omap2_mcspi_dma_tx_callback(
=20
 static int omap2_mcspi_request_dma(struct spi_device *spi)
 {
-	int rx_dev_id, tx_dev_id;
 	struct spi_master	*master =3D spi->master;
 	struct omap2_mcspi	*mcspi;
 	struct omap2_mcspi_dma	*mcspi_dma;
=20
 	mcspi =3D spi_master_get_devdata(master);
-	mcspi_dma =3D &(mcspi->dma_channels[spi->chip_select]);
-
-	if (master->bus_num =3D=3D 1) {
-		switch (spi->chip_select) {
-		case 0:
-			rx_dev_id =3D OMAP24XX_DMA_SPI1_RX0;
-			tx_dev_id =3D OMAP24XX_DMA_SPI1_TX0;
-			break;
-		case 1:
-			rx_dev_id =3D OMAP24XX_DMA_SPI1_RX1;
-			tx_dev_id =3D OMAP24XX_DMA_SPI1_TX1;
-			break;
-		case 2:
-			rx_dev_id =3D OMAP24XX_DMA_SPI1_RX2;
-			tx_dev_id =3D OMAP24XX_DMA_SPI1_TX2;
-			break;
-		case 3:
-			rx_dev_id =3D OMAP24XX_DMA_SPI1_RX3;
-			tx_dev_id =3D OMAP24XX_DMA_SPI1_TX3;
-			break;
-		default:
-			return -EINVAL;
-		}
-	} else if (master->bus_num =3D=3D 2) {
-		/* McSPI 2 has 1 chipselect */
-		switch (spi->chip_select) {
-		case 0:
-			rx_dev_id =3D OMAP24XX_DMA_SPI2_RX0;
-			tx_dev_id =3D OMAP24XX_DMA_SPI2_TX0;
-			break;
-		case 1:
-			rx_dev_id =3D OMAP24XX_DMA_SPI2_RX1;
-			tx_dev_id =3D OMAP24XX_DMA_SPI2_TX1;
-			break;
-		default:
-			return -EINVAL;
-		}
-	} else
-		return -EINVAL;
-
+	mcspi_dma =3D mcspi->dma_channels + spi->chip_select;
=20
-	if (omap_request_dma(rx_dev_id, "McSPI RX",
+	if (omap_request_dma(mcspi_dma->dma_rx_sync_dev, "McSPI RX",
 			omap2_mcspi_dma_rx_callback, spi,
 			&mcspi_dma->dma_rx_channel)) {
 		dev_err(&spi->dev, "no RX DMA channel for McSPI\n");
 		return -EAGAIN;
 	}
=20
-	if (omap_request_dma(tx_dev_id, "McSPI TX",
+	if (omap_request_dma(mcspi_dma->dma_tx_sync_dev, "McSPI TX",
 			omap2_mcspi_dma_tx_callback, spi,
 			&mcspi_dma->dma_tx_channel)) {
 		omap_free_dma(mcspi_dma->dma_rx_channel);
@@ -668,15 +620,15 @@ static int omap2_mcspi_request_dma(struc
 		return -EAGAIN;
 	}
=20
-	mcspi_dma->dma_rx_sync_dev =3D rx_dev_id;
-	mcspi_dma->dma_tx_sync_dev =3D tx_dev_id;
-
 	init_completion(&mcspi_dma->dma_rx_completion);
 	init_completion(&mcspi_dma->dma_tx_completion);
=20
 	return 0;
 }
=20
+/* the spi->mode bits understood by this driver: */
+#define MODEBITS (SPI_CPOL | SPI_CPHA | SPI_CS_HIGH)
+
 static int omap2_mcspi_setup(struct spi_device *spi)
 {
 	int			ret;
@@ -684,6 +636,20 @@ static int omap2_mcspi_setup(struct spi_
 	struct omap2_mcspi_dma	*mcspi_dma;
 	struct omap2_mcspi_cs	*cs =3D spi->controller_state;
=20
+	if (spi->mode & ~MODEBITS) {
+		dev_dbg(&spi->dev, "setup: unsupported mode bits %x\n",
+			spi->mode & ~MODEBITS);
+		return -EINVAL;
+	}
+
+	if (spi->bits_per_word =3D=3D 0)
+		spi->bits_per_word =3D 8;
+	else if (spi->bits_per_word < 4 || spi->bits_per_word > 32) {
+		dev_dbg(&spi->dev, "setup: unsupported %d bit words\n",
+			spi->bits_per_word);
+		return -EINVAL;
+	}
+
 	mcspi =3D spi_master_get_devdata(spi->master);
 	mcspi_dma =3D &mcspi->dma_channels[spi->chip_select];
=20
@@ -701,7 +667,13 @@ static int omap2_mcspi_setup(struct spi_
 			return ret;
 	}
=20
-	return omap2_mcspi_setup_transfer(spi, NULL);
+	clk_enable(mcspi->ick);
+	clk_enable(mcspi->fck);
+	ret =3D  omap2_mcspi_setup_transfer(spi, NULL);
+	clk_disable(mcspi->fck);
+	clk_disable(mcspi->ick);
+
+	return ret;
 }
=20
 static void omap2_mcspi_cleanup(struct spi_device *spi)
@@ -715,20 +687,32 @@ static void omap2_mcspi_cleanup(struct s
 	if (spi->controller_state !=3D NULL)
 		kfree(spi->controller_state);
=20
-	if (mcspi_dma->dma_rx_channel !=3D -1
-			&& mcspi_dma->dma_tx_channel !=3D -1) {
-		omap_free_dma(mcspi_dma->dma_tx_channel);
+	if (mcspi_dma->dma_rx_channel !=3D -1) {
 		omap_free_dma(mcspi_dma->dma_rx_channel);
+		mcspi_dma->dma_rx_channel =3D -1;
+	}
+	if (mcspi_dma->dma_tx_channel !=3D -1) {
+		omap_free_dma(mcspi_dma->dma_tx_channel);
+		mcspi_dma->dma_tx_channel =3D -1;
 	}
 }
=20
 static void omap2_mcspi_work(struct work_struct *work)
 {
 	struct omap2_mcspi	*mcspi;
-	unsigned long		flags;
=20
 	mcspi =3D container_of(work, struct omap2_mcspi, work);
-	spin_lock_irqsave(&mcspi->lock, flags);
+	spin_lock_irq(&mcspi->lock);
+
+	clk_enable(mcspi->ick);
+	clk_enable(mcspi->fck);
+
+	/* We only enable one channel at a time -- the one whose message is
+	 * at the head of the queue -- although this controller would gladly
+	 * arbitrate among multiple channels.  This corresponds to "single
+	 * channel" master mode.  As a side effect, we need to manage the
+	 * chipselect with the FORCE bit ... CS !=3D channel enable.
+	 */
 	while (!list_empty(&mcspi->msg_queue)) {
 		struct spi_message		*m;
 		struct spi_device		*spi;
@@ -743,11 +727,11 @@ static void omap2_mcspi_work(struct work
 				 queue);
=20
 		list_del_init(&m->queue);
-		spin_unlock_irqrestore(&mcspi->lock, flags);
+		spin_unlock_irq(&mcspi->lock);
=20
 		spi =3D m->spi;
-		conf =3D (struct omap2_mcspi_device_config *) spi->controller_data;
-		cs =3D (struct omap2_mcspi_cs *) spi->controller_state;
+		conf =3D spi->controller_data;
+		cs =3D spi->controller_state;
=20
 		list_for_each_entry(t, &m->transfers, transfer_list) {
 			if (t->tx_buf =3D=3D NULL && t->rx_buf =3D=3D NULL && t->len) {
@@ -763,9 +747,6 @@ static void omap2_mcspi_work(struct work
 					par_override =3D 0;
 			}
=20
-			clk_enable(mcspi->ick);
-			clk_enable(mcspi->fck);
-
 			if (!cs_active) {
 				omap2_mcspi_force_cs(spi, 1);
 				cs_active =3D 1;
@@ -777,20 +758,17 @@ static void omap2_mcspi_work(struct work
 			else
 				omap2_mcspi_txrx_pio(spi, t);
=20
+			if (t->delay_usecs)
+				udelay(t->delay_usecs);
+
+			/* this ignores the "leave it on after last xfer" hint */
 			if (t->cs_change) {
-				/* In the last transfer entry the flag means
-				 * _leave_ CS on */
-				if (t->transfer_list.next !=3D &m->transfers)
-					omap2_mcspi_force_cs(spi, 0);
+				omap2_mcspi_force_cs(spi, 0);
 				cs_active =3D 0;
 			}
-			clk_disable(mcspi->ick);
-			clk_disable(mcspi->fck);
 		}
=20
-		clk_enable(mcspi->ick);
-		clk_enable(mcspi->fck);
-		/* Restore defaults they are overriden */
+		/* Restore defaults if they were overriden */
 		if (par_override) {
 			par_override =3D 0;
 			status =3D omap2_mcspi_setup_transfer(spi, NULL);
@@ -798,25 +776,55 @@ static void omap2_mcspi_work(struct work
=20
 		if (cs_active)
 			omap2_mcspi_force_cs(spi, 0);
-		clk_disable(mcspi->ick);
-		clk_disable(mcspi->fck);
=20
 		m->status =3D status;
 		m->complete(m->context);
=20
-		spin_lock_irqsave(&mcspi->lock, flags);
+		spin_lock_irq(&mcspi->lock);
 	}
-	spin_unlock_irqrestore(&mcspi->lock, flags);
+
+	clk_disable(mcspi->fck);
+	clk_disable(mcspi->ick);
+
+	spin_unlock_irq(&mcspi->lock);
 }
=20
 static int omap2_mcspi_transfer(struct spi_device *spi, struct spi_messa=
ge *m)
 {
 	struct omap2_mcspi	*mcspi;
 	unsigned long		flags;
+	struct spi_transfer	*t;
=20
 	m->actual_length =3D 0;
 	m->status =3D 0;
=20
+	/* reject invalid messages and transfers */
+	if (list_empty(&m->transfers) || !m->complete)
+		return -EINVAL;
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+		if (t->speed_hz > OMAP2_MCSPI_MAX_FREQ
+				|| (t->len && !(t->rx_buf || t->tx_buf))
+				|| (t->bits_per_word &&
+					(  t->bits_per_word < 4
+					|| t->bits_per_word > 32))) {
+			dev_dbg(&spi->dev, "transfer: %d Hz, %d %s%s, %d bpw\n",
+					t->speed_hz,
+					t->len,
+					t->rx_buf ? "rx" : "",
+					t->tx_buf ? "tx" : "",
+					t->bits_per_word);
+			return -EINVAL;
+		}
+		if (t->speed_hz && t->speed_hz < OMAP2_MCSPI_MAX_FREQ/(1<<16)) {
+			dev_dbg(&spi->dev, "%d Hz max exceeds %d\n",
+					t->speed_hz,
+					t->speed_hz < OMAP2_MCSPI_MAX_FREQ/(1<<16));
+			return -EINVAL;
+		}
+
+		/* REVISIT move dma mapping to here */
+	}
+
 	mcspi =3D spi_master_get_devdata(spi->master);
=20
 	spin_lock_irqsave(&mcspi->lock, flags);
@@ -828,27 +836,79 @@ static int omap2_mcspi_transfer(struct s
 	return 0;
 }
=20
-static int __init omap2_mcspi_reset(struct spi_master *master)
+static int __init omap2_mcspi_reset(struct omap2_mcspi *mcspi)
 {
-#if 0
+	struct spi_master	*master =3D mcspi->master;
+	u32			tmp;
+
+	clk_enable(mcspi->ick);
+	clk_enable(mcspi->fck);
+
 	mcspi_write_reg(master, OMAP2_MCSPI_SYSCONFIG,
 			OMAP2_MCSPI_SYSCONFIG_SOFTRESET);
-	while (!(mcspi_read_reg(master, OMAP2_MCSPI_SYSSTATUS) & OMAP2_MCSPI_SY=
SSTATUS_RESETDONE));
-#else
+	do {
+		tmp =3D mcspi_read_reg(master, OMAP2_MCSPI_SYSSTATUS);
+	} while (!(tmp & OMAP2_MCSPI_SYSSTATUS_RESETDONE));
+
+	mcspi_write_reg(master, OMAP2_MCSPI_SYSCONFIG,
+			// (3 << 8) | (2 << 3) |
+			OMAP2_MCSPI_SYSCONFIG_AUTOIDLE);
+
+	omap2_mcspi_set_master_mode(master);
+
+	clk_disable(mcspi->fck);
+	clk_disable(mcspi->ick);
 	return 0;
-#endif
 }
=20
+static u8 __initdata spi1_rxdma_id [] =3D {
+	OMAP24XX_DMA_SPI1_RX0,
+	OMAP24XX_DMA_SPI1_RX1,
+	OMAP24XX_DMA_SPI1_RX2,
+	OMAP24XX_DMA_SPI1_RX3,
+};
+
+static u8 __initdata spi1_txdma_id [] =3D {
+	OMAP24XX_DMA_SPI1_TX0,
+	OMAP24XX_DMA_SPI1_TX1,
+	OMAP24XX_DMA_SPI1_TX2,
+	OMAP24XX_DMA_SPI1_TX3,
+};
+
+static u8 __initdata spi2_rxdma_id[] =3D {
+	OMAP24XX_DMA_SPI2_RX0,
+	OMAP24XX_DMA_SPI2_RX1,
+};
+
+static u8 __initdata spi2_txdma_id[] =3D {
+	OMAP24XX_DMA_SPI2_TX0,
+	OMAP24XX_DMA_SPI2_TX1,
+};
+
 static int __init omap2_mcspi_probe(struct platform_device *pdev)
 {
-	struct spi_master		*master;
-	struct omap2_mcspi_platform_config *pdata =3D pdev->dev.platform_data;
-	struct omap2_mcspi		*mcspi;
-	struct resource                 *r;
-	int				status =3D 0, i;
+	struct spi_master	*master;
+	struct omap2_mcspi	*mcspi;
+	struct resource		*r;
+	int			status =3D 0, i;
+	const u8		*rxdma_id, *txdma_id;
+	unsigned		num_chipselect;
=20
-	if (!pdata)
+	switch (pdev->id) {
+	case 1:
+		rxdma_id =3D spi1_rxdma_id;
+		txdma_id =3D spi1_txdma_id;
+		num_chipselect =3D 4;
+		break;
+	case 2:
+		rxdma_id =3D spi2_rxdma_id;
+		txdma_id =3D spi2_txdma_id;
+		num_chipselect =3D 2;
+		break;
+	/* REVISIT omap2430 has a third McSPI ... */
+	default:
 		return -EINVAL;
+	}
=20
 	master =3D spi_alloc_master(&pdev->dev, sizeof *mcspi);
 	if (master =3D=3D NULL) {
@@ -862,7 +922,7 @@ static int __init omap2_mcspi_probe(stru
 	master->setup =3D omap2_mcspi_setup;
 	master->transfer =3D omap2_mcspi_transfer;
 	master->cleanup =3D omap2_mcspi_cleanup;
-	master->num_chipselect =3D pdata->num_cs;
+	master->num_chipselect =3D num_chipselect;
=20
 	dev_set_drvdata(&pdev->dev, master);
=20
@@ -907,13 +967,15 @@ static int __init omap2_mcspi_probe(stru
 	if (mcspi->dma_channels =3D=3D NULL)
 		goto err3;
=20
-	for (i =3D 0; i < master->num_chipselect; i++) {
+	for (i =3D 0; i < num_chipselect; i++) {
 		mcspi->dma_channels[i].dma_rx_channel =3D -1;
+		mcspi->dma_channels[i].dma_rx_sync_dev =3D rxdma_id[i];
 		mcspi->dma_channels[i].dma_tx_channel =3D -1;
+		mcspi->dma_channels[i].dma_tx_sync_dev =3D txdma_id[i];
 	}
=20
-	if (omap2_mcspi_reset(master) < 0)
-                goto err4;
+	if (omap2_mcspi_reset(mcspi) < 0)
+		goto err4;
=20
 	status =3D spi_register_master(master);
 	if (status < 0)
