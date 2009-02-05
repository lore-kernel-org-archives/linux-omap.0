From: Aaro Koskinen <Aaro.Koskinen@nokia.com>
Subject: [PATCH PM 1/2] OMAP McSPI: Fix context save/restore
Date: Thu,  5 Feb 2009 13:07:08 +0200
Message-ID: <1233832029-21614-1-git-send-email-Aaro.Koskinen@nokia.com>
References: <498AC802.8040302@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53407 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849AbZBELHR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Feb 2009 06:07:17 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n15B6bOp022354
	for <linux-omap@vger.kernel.org>; Thu, 5 Feb 2009 05:07:14 -0600
Received: from localhost.localdomain (esdhcp042201.research.nokia.com [172.21.42.201])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n15B790G027831
	for <linux-omap@vger.kernel.org>; Thu, 5 Feb 2009 13:07:09 +0200
In-Reply-To: <498AC802.8040302@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Fix context save/restore to work with chip select. Also update the shadow
CHCONF0 register on every write and eliminate register reads.

Signed-off-by: Aaro Koskinen <Aaro.Koskinen@nokia.com>
---
 drivers/spi/omap2_mcspi.c |   51 +++++++++++++++++++++++++-------------------
 1 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index a7ee3b7..4d09777 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -134,6 +134,7 @@ struct omap2_mcspi_cs {
 	void __iomem		*base;
 	unsigned long		phys;
 	int			word_len;
+	u32			chconf0;
 };
 
 /* used for context save and restore, structure members to be updated whenever
@@ -142,7 +143,6 @@ struct omap2_mcspi_cs {
 struct omap2_mcspi_regs {
 	u32 sysconfig;
 	u32 modulctrl;
-	u32 chconf0;
 	u32 wakeupenable;
 };
 
@@ -187,12 +187,27 @@ static inline u32 mcspi_read_cs_reg(const struct spi_device *spi, int idx)
 	return __raw_readl(cs->base + idx);
 }
 
+static inline u32 mcspi_cached_chconf0(const struct spi_device *spi)
+{
+	struct omap2_mcspi_cs *cs = spi->controller_state;
+
+	return cs->chconf0;
+}
+
+static inline void mcspi_write_chconf0(const struct spi_device *spi, u32 val)
+{
+	struct omap2_mcspi_cs *cs = spi->controller_state;
+
+	cs->chconf0 = val;
+	mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, val);
+}
+
 static void omap2_mcspi_set_dma_req(const struct spi_device *spi,
 		int is_read, int enable)
 {
 	u32 l, rw;
 
-	l = mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCONF0);
+	l = mcspi_cached_chconf0(spi);
 
 	if (is_read) /* 1 is read, 0 write */
 		rw = OMAP2_MCSPI_CHCONF_DMAR;
@@ -200,7 +215,7 @@ static void omap2_mcspi_set_dma_req(const struct spi_device *spi,
 		rw = OMAP2_MCSPI_CHCONF_DMAW;
 
 	MOD_REG_BIT(l, rw, enable);
-	mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, l);
+	mcspi_write_chconf0(spi, l);
 }
 
 static void omap2_mcspi_set_enable(const struct spi_device *spi, int enable)
@@ -215,9 +230,9 @@ static void omap2_mcspi_force_cs(struct spi_device *spi, int cs_active)
 {
 	u32 l;
 
-	l = mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCONF0);
+	l = mcspi_cached_chconf0(spi);
 	MOD_REG_BIT(l, OMAP2_MCSPI_CHCONF_FORCE, cs_active);
-	mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, l);
+	mcspi_write_chconf0(spi, l);
 }
 
 static void omap2_mcspi_set_master_mode(struct spi_master *master)
@@ -248,10 +263,6 @@ static void omap2_mcspi_restore_ctx(struct omap2_mcspi *mcspi)
 	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_SYSCONFIG,
 			omap2_mcspi_ctx[spi_cntrl->bus_num - 1].sysconfig);
 
-	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_CHCONF0,
-			omap2_mcspi_ctx[spi_cntrl->bus_num - 1].chconf0);
-
-
 	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_WAKEUPENABLE,
 			omap2_mcspi_ctx[spi_cntrl->bus_num - 1].wakeupenable);
 }
@@ -392,7 +403,7 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 	c = count;
 	word_len = cs->word_len;
 
-	l = mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCONF0);
+	l = mcspi_cached_chconf0(spi);
 	l &= ~OMAP2_MCSPI_CHCONF_TRM_MASK;
 
 	/* We store the pre-calculated register addresses on stack to speed
@@ -432,8 +443,7 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 				 * more word i/o: switch to rx+tx
 				 */
 				if (c == 0 && tx == NULL)
-					mcspi_write_cs_reg(spi,
-							OMAP2_MCSPI_CHCONF0, l);
+					mcspi_write_chconf0(spi, l);
 				*rx++ = __raw_readl(rx_reg);
 #ifdef VERBOSE
 				dev_dbg(&spi->dev, "read-%d %02x\n",
@@ -471,8 +481,7 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 				 * more word i/o: switch to rx+tx
 				 */
 				if (c == 0 && tx == NULL)
-					mcspi_write_cs_reg(spi,
-							OMAP2_MCSPI_CHCONF0, l);
+					mcspi_write_chconf0(spi, l);
 				*rx++ = __raw_readl(rx_reg);
 #ifdef VERBOSE
 				dev_dbg(&spi->dev, "read-%d %04x\n",
@@ -510,8 +519,7 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 				 * more word i/o: switch to rx+tx
 				 */
 				if (c == 0 && tx == NULL)
-					mcspi_write_cs_reg(spi,
-							OMAP2_MCSPI_CHCONF0, l);
+					mcspi_write_chconf0(spi, l);
 				*rx++ = __raw_readl(rx_reg);
 #ifdef VERBOSE
 				dev_dbg(&spi->dev, "read-%d %04x\n",
@@ -559,7 +567,7 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 	} else
 		div = 15;
 
-	l = mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCONF0);
+	l = mcspi_cached_chconf0(spi);
 
 	/* standard 4-wire master mode:  SCK, MOSI/out, MISO/in, nCS
 	 * REVISIT: this controller could support SPI_3WIRE mode.
@@ -591,9 +599,7 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 	else
 		l &= ~OMAP2_MCSPI_CHCONF_PHA;
 
-	mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, l);
-
-	omap2_mcspi_ctx[spi_cntrl->bus_num - 1].chconf0 = l;
+	mcspi_write_chconf0(spi, l);
 
 	dev_dbg(&spi->dev, "setup: speed %d, sample %s edge, clk %s\n",
 			OMAP2_MCSPI_MAX_FREQ / (1 << div),
@@ -697,6 +703,7 @@ static int omap2_mcspi_setup(struct spi_device *spi)
 			return -ENOMEM;
 		cs->base = mcspi->base + spi->chip_select * 0x14;
 		cs->phys = mcspi->phys + spi->chip_select * 0x14;
+		cs->chconf0 = 0;
 		spi->controller_state = cs;
 	}
 
@@ -791,13 +798,13 @@ static void omap2_mcspi_work(struct work_struct *work)
 				cs_active = 1;
 			}
 
-			chconf = mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCONF0);
+			chconf = mcspi_cached_chconf0(spi);
 			chconf &= ~OMAP2_MCSPI_CHCONF_TRM_MASK;
 			if (t->tx_buf == NULL)
 				chconf |= OMAP2_MCSPI_CHCONF_TRM_RX_ONLY;
 			else if (t->rx_buf == NULL)
 				chconf |= OMAP2_MCSPI_CHCONF_TRM_TX_ONLY;
-			mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, chconf);
+			mcspi_write_chconf0(spi, chconf);
 
 			if (t->len) {
 				unsigned	count;
-- 
1.5.4.3

