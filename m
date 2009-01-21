From: "Hemanth V" <hemanthv@ti.com>
Subject: [PATCH] OMAP3 McSPI:  Adds context save/restore
Date: Wed, 21 Jan 2009 15:54:34 +0530 (IST)
Message-ID: <64283.10.24.255.17.1232533474.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41173 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754229AbZAUKYk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Jan 2009 05:24:40 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n0LAOZS8016031
	for <linux-omap@vger.kernel.org>; Wed, 21 Jan 2009 04:24:40 -0600
Received: from dbdmail.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id n0LAOWXB021302
	for <linux-omap@vger.kernel.org>; Wed, 21 Jan 2009 04:24:33 -0600 (CST)
References: 
In-Reply-To: 
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Hemanth V <hemanthv@ti.com>

This patch adds context save/restore feature to McSPI driver. This has been
tested by instrumenting the driver code i.e by adding a McSPI softreset
in omap2_mcspi_disable_clocks function.

Signed-off-by: Hemanth V <hemanthv@ti.com>

---
 drivers/spi/omap2_mcspi.c |   88 +++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 76 insertions(+), 12 deletions(-)

Index: linux-omap-2.6/drivers/spi/omap2_mcspi.c
===================================================================
--- linux-omap-2.6.orig/drivers/spi/omap2_mcspi.c	2009-01-21 15:03:12.000000000
+0530
+++ linux-omap-2.6/drivers/spi/omap2_mcspi.c	2009-01-21 15:05:20.000000000 +0530
@@ -133,6 +133,15 @@
 	int			word_len;
 };

+struct omap2_mcspi_regs {
+	u32 sysconfig;
+	u32 modulctrl;
+	u32 chconf0;
+	u32 wakeupenable;
+};
+
+static struct omap2_mcspi_regs omap2_mcspi_ctx[4];
+
 static struct workqueue_struct *omap2_mcspi_wq;

 #define MOD_REG_BIT(val, mask, set) do { \
@@ -219,6 +228,63 @@
 	mcspi_write_reg(master, OMAP2_MCSPI_MODULCTRL, l);
 }

+static void omap2_mcspi_save_ctx(struct omap2_mcspi *mcspi)
+{
+	struct spi_master *spi_cntrl;
+	spi_cntrl = mcspi->master;
+
+	/* McSPI : context save */
+	omap2_mcspi_ctx[spi_cntrl->bus_num - 1].modulctrl =
+		mcspi_read_reg(spi_cntrl, OMAP2_MCSPI_MODULCTRL);
+
+	omap2_mcspi_ctx[spi_cntrl->bus_num - 1].sysconfig =
+		mcspi_read_reg(spi_cntrl, OMAP2_MCSPI_SYSCONFIG);
+
+	omap2_mcspi_ctx[spi_cntrl->bus_num - 1].chconf0 =
+		mcspi_read_reg(spi_cntrl, OMAP2_MCSPI_CHCONF0);
+
+	omap2_mcspi_ctx[spi_cntrl->bus_num - 1].wakeupenable =
+		mcspi_read_reg(spi_cntrl, OMAP2_MCSPI_WAKEUPENABLE);
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
+	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_WAKEUPENABLE,
+			omap2_mcspi_ctx[spi_cntrl->bus_num - 1].wakeupenable);
+}
+static void omap2_mcspi_disable_clocks(struct omap2_mcspi *mcspi)
+{
+	omap2_mcspi_save_ctx(mcspi);
+
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
+}
+
 static unsigned
 omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 {
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
+		return;

 	/* We only enable one channel at a time -- the one whose message is
 	 * at the head of the queue -- although this controller would gladly
@@ -788,8 +854,7 @@
 		spin_lock_irq(&mcspi->lock);
 	}

-	clk_disable(mcspi->fck);
-	clk_disable(mcspi->ick);
+	omap2_mcspi_disable_clocks(mcspi);

 	spin_unlock_irq(&mcspi->lock);
 }
@@ -877,8 +942,8 @@
 	struct spi_master	*master = mcspi->master;
 	u32			tmp;

-	clk_enable(mcspi->ick);
-	clk_enable(mcspi->fck);
+	if (omap2_mcspi_enable_clocks(mcspi))
+		return -1;

 	mcspi_write_reg(master, OMAP2_MCSPI_SYSCONFIG,
 			OMAP2_MCSPI_SYSCONFIG_SOFTRESET);
@@ -896,8 +961,7 @@

 	omap2_mcspi_set_master_mode(master);

-	clk_disable(mcspi->fck);
-	clk_disable(mcspi->ick);
+	omap2_mcspi_disable_clocks(mcspi);
 	return 0;
 }

