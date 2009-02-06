From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH PM] OMAP3 McSPI:  Adds context save/restore
Date: Fri, 6 Feb 2009 15:50:01 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02F54B9C80@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59875 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753685AbZBFKUR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Feb 2009 05:20:17 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "jouni.hogander@nokia.com" <jouni.hogander@nokia.com>, "V, Hemanth" <hemanthv@ti.com>

From: Hemanth V <hemanthv@ti.com>

This patch adds context save/restore feature to McSPI driver.
This includes fixes by Aaro Koskinen

Signed-off-by: Hemanth V <hemanthv@ti.com>

---
 drivers/spi/omap2_mcspi.c |  136 ++++++++++++++++++++++++++++++++++------------
 1 files changed, 101 insertions(+), 35 deletions(-)

Index: linux-omap-2.6/drivers/spi/omap2_mcspi.c
===================================================================
--- linux-omap-2.6.orig/drivers/spi/omap2_mcspi.c	2009-02-06 12:30:44.000000000 +0530
+++ linux-omap-2.6/drivers/spi/omap2_mcspi.c	2009-02-06 13:59:43.000000000 +0530
@@ -41,6 +41,9 @@
 
 #define OMAP2_MCSPI_MAX_FREQ		48000000
 
+/* OMAP2 has 3 SPI controllers, while OMAP3 has 4 */
+#define OMAP2_MCSPI_MAX_CTRL 		4
+
 #define OMAP2_MCSPI_REVISION		0x00
 #define OMAP2_MCSPI_SYSCONFIG		0x10
 #define OMAP2_MCSPI_SYSSTATUS		0x14
@@ -131,8 +134,21 @@
 	void __iomem		*base;
 	unsigned long		phys;
 	int			word_len;
+	/* Context save and restore shadow register */
+	u32			chconf0;
+};
+
+/* used for context save and restore, structure members to be updated whenever
+ * corresponding registers are modified.
+ */
+struct omap2_mcspi_regs {
+	u32 sysconfig;
+	u32 modulctrl;
+	u32 wakeupenable;
 };
 
+static struct omap2_mcspi_regs omap2_mcspi_ctx[OMAP2_MCSPI_MAX_CTRL];
+
 static struct workqueue_struct *omap2_mcspi_wq;
 
 #define MOD_REG_BIT(val, mask, set) do { \
@@ -172,12 +188,27 @@
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
@@ -185,7 +216,7 @@
 		rw = OMAP2_MCSPI_CHCONF_DMAW;
 
 	MOD_REG_BIT(l, rw, enable);
-	mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, l);
+	mcspi_write_chconf0(spi, l);
 }
 
 static void omap2_mcspi_set_enable(const struct spi_device *spi, int enable)
@@ -200,9 +231,9 @@
 {
 	u32 l;
 
-	l = mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCONF0);
+	l = mcspi_cached_chconf0(spi);
 	MOD_REG_BIT(l, OMAP2_MCSPI_CHCONF_FORCE, cs_active);
-	mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, l);
+	mcspi_write_chconf0(spi, l);
 }
 
 static void omap2_mcspi_set_master_mode(struct spi_master *master)
@@ -217,6 +248,41 @@
 	MOD_REG_BIT(l, OMAP2_MCSPI_MODULCTRL_MS, 0);
 	MOD_REG_BIT(l, OMAP2_MCSPI_MODULCTRL_SINGLE, 1);
 	mcspi_write_reg(master, OMAP2_MCSPI_MODULCTRL, l);
+
+	omap2_mcspi_ctx[master->bus_num - 1].modulctrl = l;
+}
+
+static void omap2_mcspi_restore_ctx(struct omap2_mcspi *mcspi)
+{
+	struct spi_master *spi_cntrl;
+	spi_cntrl = mcspi->master;
+
+	/* McSPI: context restore */
+	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_MODULCTRL,
+			omap2_mcspi_ctx[spi_cntrl->bus_num - 1].modulctrl);
+
+	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_SYSCONFIG,
+			omap2_mcspi_ctx[spi_cntrl->bus_num - 1].sysconfig);
+
+	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_WAKEUPENABLE,
+			omap2_mcspi_ctx[spi_cntrl->bus_num - 1].wakeupenable);
+}
+static void omap2_mcspi_disable_clocks(struct omap2_mcspi *mcspi)
+{
+	clk_disable(mcspi->ick);
+	clk_disable(mcspi->fck);
+}
+
+static int omap2_mcspi_enable_clocks(struct omap2_mcspi *mcspi)
+{
+	if (clk_enable(mcspi->ick))
+		return -ENODEV;
+	if (clk_enable(mcspi->fck))
+		return -ENODEV;
+
+	omap2_mcspi_restore_ctx(mcspi);
+
+	return 0;
 }
 
 static unsigned
@@ -338,7 +404,7 @@
 	c = count;
 	word_len = cs->word_len;
 
-	l = mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCONF0);
+	l = mcspi_cached_chconf0(spi);
 	l &= ~OMAP2_MCSPI_CHCONF_TRM_MASK;
 
 	/* We store the pre-calculated register addresses on stack to speed
@@ -378,8 +444,7 @@
 				 * more word i/o: switch to rx+tx
 				 */
 				if (c == 0 && tx == NULL)
-					mcspi_write_cs_reg(spi,
-							OMAP2_MCSPI_CHCONF0, l);
+					mcspi_write_chconf0(spi, l);
 				*rx++ = __raw_readl(rx_reg);
 #ifdef VERBOSE
 				dev_dbg(&spi->dev, "read-%d %02x\n",
@@ -417,8 +482,7 @@
 				 * more word i/o: switch to rx+tx
 				 */
 				if (c == 0 && tx == NULL)
-					mcspi_write_cs_reg(spi,
-							OMAP2_MCSPI_CHCONF0, l);
+					mcspi_write_chconf0(spi, l);
 				*rx++ = __raw_readl(rx_reg);
 #ifdef VERBOSE
 				dev_dbg(&spi->dev, "read-%d %04x\n",
@@ -456,8 +520,7 @@
 				 * more word i/o: switch to rx+tx
 				 */
 				if (c == 0 && tx == NULL)
-					mcspi_write_cs_reg(spi,
-							OMAP2_MCSPI_CHCONF0, l);
+					mcspi_write_chconf0(spi, l);
 				*rx++ = __raw_readl(rx_reg);
 #ifdef VERBOSE
 				dev_dbg(&spi->dev, "read-%d %04x\n",
@@ -486,10 +549,12 @@
 {
 	struct omap2_mcspi_cs *cs = spi->controller_state;
 	struct omap2_mcspi *mcspi;
+	struct spi_master *spi_cntrl;
 	u32 l = 0, div = 0;
 	u8 word_len = spi->bits_per_word;
 
 	mcspi = spi_master_get_devdata(spi->master);
+	spi_cntrl = mcspi->master;
 
 	if (t != NULL && t->bits_per_word)
 		word_len = t->bits_per_word;
@@ -503,7 +568,7 @@
 	} else
 		div = 15;
 
-	l = mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCONF0);
+	l = mcspi_cached_chconf0(spi);
 
 	/* standard 4-wire master mode:  SCK, MOSI/out, MISO/in, nCS
 	 * REVISIT: this controller could support SPI_3WIRE mode.
@@ -535,7 +600,7 @@
 	else
 		l &= ~OMAP2_MCSPI_CHCONF_PHA;
 
-	mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, l);
+	mcspi_write_chconf0(spi, l);
 
 	dev_dbg(&spi->dev, "setup: speed %d, sample %s edge, clk %s\n",
 			OMAP2_MCSPI_MAX_FREQ / (1 << div),
@@ -639,6 +704,7 @@
 			return -ENOMEM;
 		cs->base = mcspi->base + spi->chip_select * 0x14;
 		cs->phys = mcspi->phys + spi->chip_select * 0x14;
+		cs->chconf0 = 0;
 		spi->controller_state = cs;
 	}
 
@@ -649,11 +715,11 @@
 			return ret;
 	}
 
-	clk_enable(mcspi->ick);
-	clk_enable(mcspi->fck);
+	if (omap2_mcspi_enable_clocks(mcspi))
+		return -ENODEV;
+
 	ret = omap2_mcspi_setup_transfer(spi, NULL);
-	clk_disable(mcspi->fck);
-	clk_disable(mcspi->ick);
+	omap2_mcspi_disable_clocks(mcspi);
 
 	return ret;
 }
@@ -685,8 +751,8 @@
 	mcspi = container_of(work, struct omap2_mcspi, work);
 	spin_lock_irq(&mcspi->lock);
 
-	clk_enable(mcspi->ick);
-	clk_enable(mcspi->fck);
+	if (omap2_mcspi_enable_clocks(mcspi))
+		goto out;
 
 	/* We only enable one channel at a time -- the one whose message is
 	 * at the head of the queue -- although this controller would gladly
@@ -733,13 +799,13 @@
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
@@ -788,9 +854,9 @@
 		spin_lock_irq(&mcspi->lock);
 	}
 
-	clk_disable(mcspi->fck);
-	clk_disable(mcspi->ick);
+	omap2_mcspi_disable_clocks(mcspi);
 
+out:
 	spin_unlock_irq(&mcspi->lock);
 }
 
@@ -877,8 +943,8 @@
 	struct spi_master	*master = mcspi->master;
 	u32			tmp;
 
-	clk_enable(mcspi->ick);
-	clk_enable(mcspi->fck);
+	if (omap2_mcspi_enable_clocks(mcspi))
+		return -1;
 
 	mcspi_write_reg(master, OMAP2_MCSPI_SYSCONFIG,
 			OMAP2_MCSPI_SYSCONFIG_SOFTRESET);
@@ -886,18 +952,18 @@
 		tmp = mcspi_read_reg(master, OMAP2_MCSPI_SYSSTATUS);
 	} while (!(tmp & OMAP2_MCSPI_SYSSTATUS_RESETDONE));
 
-	mcspi_write_reg(master, OMAP2_MCSPI_SYSCONFIG,
-			OMAP2_MCSPI_SYSCONFIG_AUTOIDLE |
-			OMAP2_MCSPI_SYSCONFIG_ENAWAKEUP |
-			OMAP2_MCSPI_SYSCONFIG_SMARTIDLE);
-
-	mcspi_write_reg(master, OMAP2_MCSPI_WAKEUPENABLE,
-			OMAP2_MCSPI_WAKEUPENABLE_WKEN);
+	tmp = OMAP2_MCSPI_SYSCONFIG_AUTOIDLE |
+		OMAP2_MCSPI_SYSCONFIG_ENAWAKEUP |
+		OMAP2_MCSPI_SYSCONFIG_SMARTIDLE;
+	mcspi_write_reg(master, OMAP2_MCSPI_SYSCONFIG, tmp);
+	omap2_mcspi_ctx[master->bus_num - 1].sysconfig = tmp;
+
+	tmp = OMAP2_MCSPI_WAKEUPENABLE_WKEN;
+	mcspi_write_reg(master, OMAP2_MCSPI_WAKEUPENABLE, tmp);
+	omap2_mcspi_ctx[master->bus_num - 1].wakeupenable = tmp;
 
 	omap2_mcspi_set_master_mode(master);
-
-	clk_disable(mcspi->fck);
-	clk_disable(mcspi->ick);
+	omap2_mcspi_disable_clocks(mcspi);
 	return 0;
 }
 