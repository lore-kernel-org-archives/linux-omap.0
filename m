From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: [PATCH] OMAP3 McSPI:  Adds context save/restore
Date: Fri, 23 Jan 2009 12:26:25 +0530 (IST)
Message-ID: <10293.10.24.255.17.1232693785.squirrel@dbdmail.itg.ti.com>
References: <64283.10.24.255.17.1232533474.squirrel@dbdmail.itg.ti.com>
    <87eiywr34b.fsf@deeprootsystems.com>
    <001201c97c55$0f4b7e80$LocalHost@wipultra793>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59685 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751935AbZAWG4c (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Jan 2009 01:56:32 -0500
In-Reply-To: <001201c97c55$0f4b7e80$LocalHost@wipultra793>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

From: Hemanth V <hemanthv@ti.com>

This patch adds context save/restore feature to McSPI driver. This has been
tested by instrumenting the driver code i.e by adding a McSPI softreset
in omap2_mcspi_disable_clocks function.

This patch includes review comment fixes

Signed-off-by: Hemanth V <hemanthv@ti.com>

---
 drivers/spi/omap2_mcspi.c |   94 ++++++++++++++++++++++++++++++++++++----------
 1 files changed, 74 insertions(+), 20 deletions(-)

Index: linux-omap-2.6/drivers/spi/omap2_mcspi.c
===================================================================
--- linux-omap-2.6.orig/drivers/spi/omap2_mcspi.c
+++ linux-omap-2.6/drivers/spi/omap2_mcspi.c
@@ -41,6 +41,9 @@

 #define OMAP2_MCSPI_MAX_FREQ		48000000

+/* OMAP2 has 3 SPI controllers, while OMAP3 has 4 */
+#define OMAP2_MCSPI_MAX_CTRL 		4
+
 #define OMAP2_MCSPI_REVISION		0x00
 #define OMAP2_MCSPI_SYSCONFIG		0x10
 #define OMAP2_MCSPI_SYSSTATUS		0x14
@@ -133,6 +136,15 @@
 	int			word_len;
 };

+struct omap2_mcspi_regs {
+	u32 sysconfig;
+	u32 modulctrl;
+	u32 chconf0;
+	u32 wakeupenable;
+};
+
+static struct omap2_mcspi_regs omap2_mcspi_ctx[OMAP2_MCSPI_MAX_CTRL];
+
 static struct workqueue_struct *omap2_mcspi_wq;

 #define MOD_REG_BIT(val, mask, set) do { \
@@ -217,6 +229,45 @@
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
+	/*McSPI : context restore */
+	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_MODULCTRL,
+			omap2_mcspi_ctx[spi_cntrl->bus_num - 1].modulctrl);
+
+	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_SYSCONFIG,
+			omap2_mcspi_ctx[spi_cntrl->bus_num - 1].sysconfig);
+
+	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_CHCONF0,
+			omap2_mcspi_ctx[spi_cntrl->bus_num - 1].chconf0);
+
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
@@ -486,10 +537,12 @@
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
@@ -537,6 +590,8 @@

 	mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, l);

+	omap2_mcspi_ctx[spi_cntrl->bus_num - 1].chconf0 = l;
+
 	dev_dbg(&spi->dev, "setup: speed %d, sample %s edge, clk %s\n",
 			OMAP2_MCSPI_MAX_FREQ / (1 << div),
 			(spi->mode & SPI_CPHA) ? "trailing" : "leading",
@@ -649,11 +704,11 @@
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
@@ -685,8 +740,8 @@
 	mcspi = container_of(work, struct omap2_mcspi, work);
 	spin_lock_irq(&mcspi->lock);

-	clk_enable(mcspi->ick);
-	clk_enable(mcspi->fck);
+	if (omap2_mcspi_enable_clocks(mcspi))
+		return;

 	/* We only enable one channel at a time -- the one whose message is
 	 * at the head of the queue -- although this controller would gladly
@@ -788,8 +843,7 @@
 		spin_lock_irq(&mcspi->lock);
 	}

-	clk_disable(mcspi->fck);
-	clk_disable(mcspi->ick);
+	omap2_mcspi_disable_clocks(mcspi);

 	spin_unlock_irq(&mcspi->lock);
 }
@@ -877,8 +931,8 @@
 	struct spi_master	*master = mcspi->master;
 	u32			tmp;

-	clk_enable(mcspi->ick);
-	clk_enable(mcspi->fck);
+	if (omap2_mcspi_enable_clocks(mcspi))
+		return -1;

 	mcspi_write_reg(master, OMAP2_MCSPI_SYSCONFIG,
 			OMAP2_MCSPI_SYSCONFIG_SOFTRESET);
@@ -886,18 +940,18 @@
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




