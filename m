From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH v3 1/3] [SPI] [OMAP] Add OMAP spi100k driver
Date: Sat, 12 Dec 2009 17:34:46 -0800
Message-ID: <1260668088-27555-2-git-send-email-darkstar6262@gmail.com>
References: <1260668088-27555-1-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:49729 "HELO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933485AbZLMBfZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Dec 2009 20:35:25 -0500
Received: by pzk1 with SMTP id 1so1530960pzk.33
        for <linux-omap@vger.kernel.org>; Sat, 12 Dec 2009 17:35:24 -0800 (PST)
In-Reply-To: <1260668088-27555-1-git-send-email-darkstar6262@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org
Cc: Cory Maccarrone <darkstar6262@gmail.com>

This change adds the OMAP SPI 100k driver created by
=46abrice Crohas <fcrohas@gmail.com>.  This SPI bus is found on
OMAP7xx-series smartphones, and for many, the touchscreen is
attached to this bus.

The lion's share of the work was done by Fabrice on this driver --
I am merely porting it from the Linwizard project on his behalf.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
---
 drivers/spi/Kconfig         |    6 +
 drivers/spi/Makefile        |    1 +
 drivers/spi/omap_spi_100k.c |  635 +++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 642 insertions(+), 0 deletions(-)
 create mode 100644 drivers/spi/omap_spi_100k.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 4b6f7cb..7ef9b12 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -164,6 +164,12 @@ config SPI_OMAP24XX
 	  SPI master controller for OMAP24xx/OMAP34xx Multichannel SPI
 	  (McSPI) modules.
=20
+config SPI_OMAP_100K
+	tristate "OMAP SPI 100K"
+	depends on SPI_MASTER && (ARCH_OMAP850 || ARCH_OMAP730)
+	help
+	  OMAP SPI 100K master controller for omap7xx boards.
+
 config SPI_ORION
 	tristate "Orion SPI master (EXPERIMENTAL)"
 	depends on PLAT_ORION && EXPERIMENTAL
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 21a1182..55f670d 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_SPI_LM70_LLP)		+=3D spi_lm70llp.o
 obj-$(CONFIG_SPI_PXA2XX)		+=3D pxa2xx_spi.o
 obj-$(CONFIG_SPI_OMAP_UWIRE)		+=3D omap_uwire.o
 obj-$(CONFIG_SPI_OMAP24XX)		+=3D omap2_mcspi.o
+obj-$(CONFIG_SPI_OMAP_100K)		+=3D omap_spi_100k.o
 obj-$(CONFIG_SPI_ORION)			+=3D orion_spi.o
 obj-$(CONFIG_SPI_PL022)			+=3D amba-pl022.o
 obj-$(CONFIG_SPI_MPC52xx_PSC)		+=3D mpc52xx_psc_spi.o
diff --git a/drivers/spi/omap_spi_100k.c b/drivers/spi/omap_spi_100k.c
new file mode 100644
index 0000000..5355d90
--- /dev/null
+++ b/drivers/spi/omap_spi_100k.c
@@ -0,0 +1,635 @@
+/*
+ * OMAP7xx SPI 100k controller driver
+ * Author: Fabrice Crohas <fcrohas@gmail.com>
+ * from original omap1_mcspi driver
+ *
+ * Copyright (C) 2005, 2006 Nokia Corporation
+ * Author:      Samuel Ortiz <samuel.ortiz@nokia.com> and
+ *              Juha Yrj=EF=BF=BDl=EF=BF=BD <juha.yrjola@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License as published b=
y
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307=
 USA
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+
+#include <linux/spi/spi.h>
+
+#include <plat/clock.h>
+
+#define OMAP1_SPI100K_MAX_FREQ          48000000
+
+#define ICR_SPITAS      (OMAP7XX_ICR_BASE + 0x12)
+
+#define SPI_SETUP1      0x00
+#define SPI_SETUP2      0x02
+#define SPI_CTRL        0x04
+#define SPI_STATUS      0x06
+#define SPI_TX_LSB      0x08
+#define SPI_TX_MSB      0x0a
+#define SPI_RX_LSB      0x0c
+#define SPI_RX_MSB      0x0e
+
+#define SPI_SETUP1_INT_READ_ENABLE      (1UL << 5)
+#define SPI_SETUP1_INT_WRITE_ENABLE     (1UL << 4)
+#define SPI_SETUP1_CLOCK_DIVISOR(x)     ((x) << 1)
+#define SPI_SETUP1_CLOCK_ENABLE         (1UL << 0)
+
+#define SPI_SETUP2_ACTIVE_EDGE_FALLING  (0UL << 0)
+#define SPI_SETUP2_ACTIVE_EDGE_RISING   (1UL << 0)
+#define SPI_SETUP2_NEGATIVE_LEVEL       (0UL << 5)
+#define SPI_SETUP2_POSITIVE_LEVEL       (1UL << 5)
+#define SPI_SETUP2_LEVEL_TRIGGER        (0UL << 10)
+#define SPI_SETUP2_EDGE_TRIGGER         (1UL << 10)
+
+#define SPI_CTRL_SEN(x)                 ((x) << 7)
+#define SPI_CTRL_WORD_SIZE(x)           (((x) - 1) << 2)
+#define SPI_CTRL_WR                     (1UL << 1)
+#define SPI_CTRL_RD                     (1UL << 0)
+
+#define SPI_STATUS_WE                   (1UL << 1)
+#define SPI_STATUS_RD                   (1UL << 0)
+
+#define WRITE 0
+#define READ  1
+
+
+/* use PIO for small transfers, avoiding DMA setup/teardown overhead a=
nd
+ * cache operations; better heuristics consider wordsize and bitrate.
+ */
+#define DMA_MIN_BYTES                   8
+
+#define SPI_RUNNING	0
+#define SPI_SHUTDOWN	1
+
+struct omap1_spi100k {
+	struct work_struct      work;
+
+	/* lock protects queue and registers */
+	spinlock_t              lock;
+	struct list_head        msg_queue;
+	struct spi_master       *master;
+	struct clk              *ick;
+	struct clk              *fck;
+
+	/* Virtual base address of the controller */
+	void __iomem            *base;
+
+	/* State of the SPI */
+	unsigned int		state;
+};
+
+struct omap1_spi100k_cs {
+	void __iomem            *base;
+	int                     word_len;
+};
+
+static struct workqueue_struct *omap1_spi100k_wq;
+
+#define MOD_REG_BIT(val, mask, set) do { \
+	if (set) \
+		val |=3D mask; \
+	else \
+		val &=3D ~mask; \
+} while (0)
+
+static void spi100k_enable_clock(struct spi_master *master)
+{
+	unsigned int val;
+	struct omap1_spi100k *spi100k =3D spi_master_get_devdata(master);
+
+	/* enable SPI */
+	val =3D readw(spi100k->base + SPI_SETUP1);
+	val |=3D SPI_SETUP1_CLOCK_ENABLE;
+	writew(val, spi100k->base + SPI_SETUP1);
+}
+
+static void spi100k_disable_clock(struct spi_master *master)
+{
+	unsigned int val;
+	struct omap1_spi100k *spi100k =3D spi_master_get_devdata(master);
+
+	/* disable SPI */
+	val =3D readw(spi100k->base + SPI_SETUP1);
+	val &=3D ~SPI_SETUP1_CLOCK_ENABLE;
+	writew(val, spi100k->base + SPI_SETUP1);
+}
+
+static void spi100k_write_data(struct spi_master *master, int len, int=
 data)
+{
+	struct omap1_spi100k *spi100k =3D spi_master_get_devdata(master);
+
+	/* write 16-bit word */
+	spi100k_enable_clock(master);
+	writew( data , spi100k->base + SPI_TX_MSB);
+
+	writew(SPI_CTRL_SEN(0) |
+	       SPI_CTRL_WORD_SIZE(len) |
+	       SPI_CTRL_WR,
+	       spi100k->base + SPI_CTRL);
+
+	/* Wait for bit ack send change */
+	while((readw(spi100k->base + SPI_STATUS) & SPI_STATUS_WE) !=3D SPI_ST=
ATUS_WE);
+	udelay(1000);
+
+	spi100k_disable_clock(master);
+}
+
+static int spi100k_read_data(struct spi_master *master, int len)
+{
+	int dataH,dataL;
+	struct omap1_spi100k *spi100k =3D spi_master_get_devdata(master);
+
+	spi100k_enable_clock(master);
+	writew(SPI_CTRL_SEN(0) |
+	       SPI_CTRL_WORD_SIZE(len) |
+	       SPI_CTRL_RD,
+	       spi100k->base + SPI_CTRL);
+
+	while((readw(spi100k->base + SPI_STATUS) & SPI_STATUS_RD) !=3D SPI_ST=
ATUS_RD);
+	udelay(1000);
+
+	dataL =3D readw(spi100k->base + SPI_RX_LSB);
+	dataH =3D readw(spi100k->base + SPI_RX_MSB);
+	spi100k_disable_clock(master);
+
+	return dataL;
+}
+
+static void spi100k_open(struct spi_master *master)
+{
+	/* get control of SPI */
+	struct omap1_spi100k *spi100k =3D spi_master_get_devdata(master);
+
+	writew(SPI_SETUP1_INT_READ_ENABLE |
+	       SPI_SETUP1_INT_WRITE_ENABLE |
+	       SPI_SETUP1_CLOCK_DIVISOR(0), spi100k->base + SPI_SETUP1);
+
+	/* configure clock and interrupts */
+	writew(SPI_SETUP2_ACTIVE_EDGE_FALLING |
+	       SPI_SETUP2_NEGATIVE_LEVEL |
+	       SPI_SETUP2_LEVEL_TRIGGER, spi100k->base + SPI_SETUP2);
+}
+
+static void omap1_spi100k_force_cs(struct omap1_spi100k *spi100k, int =
enable)
+{
+	if (enable)
+		writew(0x05fc, spi100k->base + SPI_CTRL);
+	else
+		writew(0x05fd, spi100k->base + SPI_CTRL);
+}
+
+static unsigned
+omap1_spi100k_txrx_pio(struct spi_device *spi, struct spi_transfer *xf=
er)
+{
+	struct omap1_spi100k    *spi100k;
+	struct omap1_spi100k_cs *cs =3D spi->controller_state;
+	unsigned int            count, c;
+	int                     word_len;
+
+	spi100k =3D spi_master_get_devdata(spi->master);
+	count =3D xfer->len;
+	c =3D count;
+	word_len =3D cs->word_len;
+
+	/* RX_ONLY mode needs dummy data in TX reg */
+	if (xfer->tx_buf =3D=3D NULL)
+		spi100k_write_data(spi->master,word_len, 0);
+
+	if (word_len <=3D 8) {
+		u8              *rx;
+		const u8        *tx;
+
+		rx =3D xfer->rx_buf;
+		tx =3D xfer->tx_buf;
+		do {
+			c-=3D1;
+			if (xfer->tx_buf !=3D NULL)
+				spi100k_write_data(spi->master,word_len, *tx);
+			if (xfer->rx_buf !=3D NULL)
+				*rx =3D spi100k_read_data(spi->master,word_len);
+		} while(c);
+	} else if (word_len <=3D 16) {
+		u16             *rx;
+		const u16       *tx;
+
+		rx =3D xfer->rx_buf;
+		tx =3D xfer->tx_buf;
+		do {
+			c-=3D2;
+			if (xfer->tx_buf !=3D NULL)
+				spi100k_write_data(spi->master,word_len, *tx++);
+			if (xfer->rx_buf !=3D NULL)
+				*rx++ =3D spi100k_read_data(spi->master,word_len);
+		} while(c);
+	} else if (word_len <=3D 32) {
+		u32             *rx;
+		const u32       *tx;
+
+		rx =3D xfer->rx_buf;
+		tx =3D xfer->tx_buf;
+		do {
+			c-=3D4;
+			if (xfer->tx_buf !=3D NULL)
+				spi100k_write_data(spi->master,word_len, *tx);
+			if (xfer->rx_buf !=3D NULL)
+				*rx =3D spi100k_read_data(spi->master,word_len);
+		} while(c);
+	}
+	return count - c;
+}
+
+/* called only when no transfer is active to this device */
+static int omap1_spi100k_setup_transfer(struct spi_device *spi,
+		struct spi_transfer *t)
+{
+	struct omap1_spi100k *spi100k =3D spi_master_get_devdata(spi->master)=
;
+	struct omap1_spi100k_cs *cs =3D spi->controller_state;
+	u8 word_len =3D spi->bits_per_word;
+
+	if (t !=3D NULL && t->bits_per_word)
+		word_len =3D t->bits_per_word;
+	if (!word_len)
+		word_len =3D 8;
+
+	if (spi->bits_per_word > 32)
+		return -EINVAL;
+	cs->word_len =3D word_len;
+
+	/* SPI init before transfer */
+	writew(0x3e , spi100k->base + SPI_SETUP1);
+	writew(0x00 , spi100k->base + SPI_STATUS);
+	writew(0x3e , spi100k->base + SPI_CTRL);
+
+	return 0;
+}
+
+/* the spi->mode bits understood by this driver: */
+#define MODEBITS (SPI_CPOL | SPI_CPHA | SPI_CS_HIGH)
+
+static int omap1_spi100k_setup(struct spi_device *spi)
+{
+	int                     ret;
+	struct omap1_spi100k    *spi100k;
+	struct omap1_spi100k_cs *cs =3D spi->controller_state;
+
+	if (spi->bits_per_word < 4 || spi->bits_per_word > 32) {
+		 dev_dbg(&spi->dev, "setup: unsupported %d bit words\n",
+			spi->bits_per_word);
+		 return -EINVAL;
+	}
+
+	spi100k =3D spi_master_get_devdata(spi->master);
+
+	if (!cs) {
+		cs =3D kzalloc(sizeof *cs, GFP_KERNEL);
+		if (!cs)
+			return -ENOMEM;
+		cs->base =3D spi100k->base + spi->chip_select * 0x14;
+		spi->controller_state =3D cs;
+	}
+
+	spi100k_open(spi->master);
+
+	clk_enable(spi100k->ick);
+	clk_enable(spi100k->fck);
+
+	ret =3D omap1_spi100k_setup_transfer(spi, NULL);
+
+	clk_disable(spi100k->ick);
+	clk_disable(spi100k->fck);
+
+	return ret;
+}
+
+static void omap1_spi100k_work(struct work_struct *work)
+{
+	struct omap1_spi100k    *spi100k;
+	int status =3D 0;
+
+	spi100k =3D container_of(work, struct omap1_spi100k, work);
+	spin_lock_irq(&spi100k->lock);
+
+	clk_enable(spi100k->ick);
+	clk_enable(spi100k->fck);
+
+	/* We only enable one channel at a time -- the one whose message is
+	 * at the head of the queue -- although this controller would gladly
+	 * arbitrate among multiple channels.  This corresponds to "single
+	 * channel" master mode.  As a side effect, we need to manage the
+	 * chipselect with the FORCE bit ... CS !=3D channel enable.
+	 */
+	 while (!list_empty(&spi100k->msg_queue)) {
+		struct spi_message              *m;
+		struct spi_device               *spi;
+		struct spi_transfer             *t =3D NULL;
+		int                             cs_active =3D 0;
+		struct omap1_spi100k_cs         *cs;
+		int                             par_override =3D 0;
+
+		m =3D container_of(spi100k->msg_queue.next, struct spi_message,
+				 queue);
+
+		list_del_init(&m->queue);
+		spin_unlock_irq(&spi100k->lock);
+
+		spi =3D m->spi;
+		cs =3D spi->controller_state;
+
+		list_for_each_entry(t, &m->transfers, transfer_list) {
+			if (t->tx_buf =3D=3D NULL && t->rx_buf =3D=3D NULL && t->len) {
+				status =3D -EINVAL;
+				break;
+			}
+			if (par_override || t->speed_hz || t->bits_per_word) {
+				par_override =3D 1;
+				status =3D omap1_spi100k_setup_transfer(spi, t);
+				if (status < 0)
+					break;
+				if (!t->speed_hz && !t->bits_per_word)
+					par_override =3D 0;
+			}
+
+			if (!cs_active) {
+				omap1_spi100k_force_cs(spi100k, 1);
+				cs_active =3D 1;
+			}
+
+			if (t->len) {
+				unsigned count;
+
+				/* RX_ONLY mode needs dummy data in TX reg */
+				if (t->tx_buf =3D=3D NULL)
+					spi100k_write_data(spi->master, 8, 0);
+
+				count =3D omap1_spi100k_txrx_pio(spi, t);
+				m->actual_length +=3D count;
+
+				if (count !=3D t->len) {
+					status =3D -EIO;
+					break;
+				}
+			}
+
+			if (t->delay_usecs)
+				udelay(t->delay_usecs);
+
+			/* ignore the "leave it on after last xfer" hint */
+
+			if (t->cs_change) {
+				omap1_spi100k_force_cs(spi100k, 0);
+				cs_active =3D 0;
+			}
+		}
+
+		/* Restore defaults if they were overriden */
+		if (par_override) {
+			par_override =3D 0;
+			status =3D omap1_spi100k_setup_transfer(spi, NULL);
+		}
+
+		if (cs_active)
+			omap1_spi100k_force_cs(spi100k, 0);
+
+		m->status =3D status;
+		m->complete(m->context);
+
+		spin_lock_irq(&spi100k->lock);
+	}
+
+	clk_disable(spi100k->ick);
+	clk_disable(spi100k->fck);
+	spin_unlock_irq(&spi100k->lock);
+
+	if (status < 0)
+		printk(KERN_WARNING "spi transfer failed with %d\n", status);
+}
+
+static int omap1_spi100k_transfer(struct spi_device *spi, struct spi_m=
essage *m)
+{
+	struct omap1_spi100k    *spi100k;
+	unsigned long           flags;
+	struct spi_transfer     *t;
+
+	m->actual_length =3D 0;
+	m->status =3D -EINPROGRESS;
+
+	spi100k =3D spi_master_get_devdata(spi->master);
+
+	/* Don't accept new work if we're shutting down */
+	if (spi100k->state =3D=3D SPI_SHUTDOWN)
+		return -ESHUTDOWN;
+
+	/* reject invalid messages and transfers */
+	if (list_empty(&m->transfers) || !m->complete)
+		return -EINVAL;
+
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+		const void      *tx_buf =3D t->tx_buf;
+		void            *rx_buf =3D t->rx_buf;
+		unsigned        len =3D t->len;
+
+		if (t->speed_hz > OMAP1_SPI100K_MAX_FREQ
+				|| (len && !(rx_buf || tx_buf))
+				|| (t->bits_per_word &&
+					(  t->bits_per_word < 4
+					|| t->bits_per_word > 32))) {
+			dev_dbg(&spi->dev, "transfer: %d Hz, %d %s%s, %d bpw\n",
+					t->speed_hz,
+					len,
+					tx_buf ? "tx" : "",
+					rx_buf ? "rx" : "",
+					t->bits_per_word);
+			return -EINVAL;
+		}
+
+		if (t->speed_hz && t->speed_hz < OMAP1_SPI100K_MAX_FREQ/(1<<16)) {
+			dev_dbg(&spi->dev, "%d Hz max exceeds %d\n",
+					t->speed_hz,
+					OMAP1_SPI100K_MAX_FREQ/(1<<16));
+			return -EINVAL;
+		}
+
+	}
+
+	spin_lock_irqsave(&spi100k->lock, flags);
+	list_add_tail(&m->queue, &spi100k->msg_queue);
+	queue_work(omap1_spi100k_wq, &spi100k->work);
+	spin_unlock_irqrestore(&spi100k->lock, flags);
+
+	return 0;
+}
+
+static int __init omap1_spi100k_reset(struct omap1_spi100k *spi100k)
+{
+	return 0;
+}
+
+static int __devinit omap1_spi100k_probe(struct platform_device *pdev)
+{
+	struct spi_master       *master;
+	struct omap1_spi100k    *spi100k;
+	int                     status =3D 0;
+
+	if (!pdev->id)
+		return -EINVAL;
+
+	master =3D spi_alloc_master(&pdev->dev, sizeof *spi100k);
+	if (master =3D=3D NULL) {
+		dev_dbg(&pdev->dev, "master allocation failed\n");
+		return -ENOMEM;
+	}
+
+	if (pdev->id !=3D -1)
+	       master->bus_num =3D pdev->id;
+
+	master->setup =3D omap1_spi100k_setup;
+	master->transfer =3D omap1_spi100k_transfer;
+	master->cleanup =3D NULL;
+	master->num_chipselect =3D 2;
+	master->mode_bits =3D MODEBITS;
+
+	dev_set_drvdata(&pdev->dev, master);
+
+	spi100k =3D spi_master_get_devdata(master);
+	spi100k->master =3D master;
+
+	/*
+	 * The memory region base address is taken as the platform_data.
+	 * You should allocate this with ioremap() before initializing
+	 * the SPI.
+	 */
+	spi100k->base =3D (void __iomem *) pdev->dev.platform_data;
+
+	INIT_WORK(&spi100k->work, omap1_spi100k_work);
+
+	spin_lock_init(&spi100k->lock);
+	INIT_LIST_HEAD(&spi100k->msg_queue);
+	spi100k->ick =3D clk_get(&pdev->dev, "ick");
+	if (IS_ERR(spi100k->ick)) {
+		dev_dbg(&pdev->dev, "can't get spi100k_ick\n");
+		status =3D PTR_ERR(spi100k->ick);
+		goto err1;
+	}
+
+	spi100k->fck =3D clk_get(&pdev->dev, "fck");
+	if (IS_ERR(spi100k->fck)) {
+		dev_dbg(&pdev->dev, "can't get spi100k_fck\n");
+		status =3D PTR_ERR(spi100k->fck);
+		goto err2;
+	}
+
+	if (omap1_spi100k_reset(spi100k) < 0)
+		goto err3;
+
+	status =3D spi_register_master(master);
+	if (status < 0)
+		goto err3;
+
+	spi100k->state =3D SPI_RUNNING;
+
+	return status;
+
+err3:
+	clk_put(spi100k->fck);
+err2:
+	clk_put(spi100k->ick);
+err1:
+	spi_master_put(master);
+	return status;
+}
+
+static int __exit omap1_spi100k_remove(struct platform_device *pdev)
+{
+	struct spi_master       *master;
+	struct omap1_spi100k    *spi100k;
+	struct resource         *r;
+	unsigned		limit =3D 500;
+	unsigned long		flags;
+	int			status =3D 0;
+
+	master =3D dev_get_drvdata(&pdev->dev);
+	spi100k =3D spi_master_get_devdata(master);
+
+	spin_lock_irqsave(&spi100k->lock, flags);
+
+	spi100k->state =3D SPI_SHUTDOWN;
+	while (!list_empty(&spi100k->msg_queue) && limit--) {
+		spin_unlock_irqrestore(&spi100k->lock, flags);
+		msleep(10);
+		spin_lock_irqsave(&spi100k->lock, flags);
+	}
+
+	if (!list_empty(&spi100k->msg_queue))
+		status =3D -EBUSY;
+
+	spin_unlock_irqrestore(&spi100k->lock, flags);
+
+	if (status !=3D 0)
+		return status;
+
+	clk_put(spi100k->fck);
+	clk_put(spi100k->ick);
+
+	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	spi_unregister_master(master);
+
+	return 0;
+}
+
+static struct platform_driver omap1_spi100k_driver =3D {
+	.driver =3D {
+		.name		=3D "omap1_spi100k",
+		.owner		=3D THIS_MODULE,
+	},
+	.remove		=3D __exit_p(omap1_spi100k_remove),
+};
+
+
+static int __init omap1_spi100k_init(void)
+{
+	omap1_spi100k_wq =3D create_singlethread_workqueue(
+			omap1_spi100k_driver.driver.name);
+
+	if (omap1_spi100k_wq =3D=3D NULL)
+		return -1;
+
+	return platform_driver_probe(&omap1_spi100k_driver, omap1_spi100k_pro=
be);
+}
+
+static void __exit omap1_spi100k_exit(void)
+{
+	platform_driver_unregister(&omap1_spi100k_driver);
+
+	destroy_workqueue(omap1_spi100k_wq);
+}
+
+module_init(omap1_spi100k_init);
+module_exit(omap1_spi100k_exit);
+
+MODULE_DESCRIPTION("OMAP7xx SPI 100k controller driver");
+MODULE_AUTHOR("Fabrice Crohas <fcrohas@gmail.com>");
+MODULE_LICENSE("GPL");
+
--=20
1.6.3.3

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
