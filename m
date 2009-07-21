From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 4/4] OMAP3: SPI: Restore also CHxCONF register when restoring context
Date: Tue, 21 Jul 2009 16:03:32 -0700
Message-ID: <1248217412-24078-5-git-send-email-khilman@deeprootsystems.com>
References: <1248217412-24078-1-git-send-email-khilman@deeprootsystems.com>
 <1248217412-24078-2-git-send-email-khilman@deeprootsystems.com>
 <1248217412-24078-3-git-send-email-khilman@deeprootsystems.com>
 <1248217412-24078-4-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:26442 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755940AbZGUXDp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jul 2009 19:03:45 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1017016wfd.4
        for <linux-omap@vger.kernel.org>; Tue, 21 Jul 2009 16:03:45 -0700 (PDT)
In-Reply-To: <1248217412-24078-4-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net
Cc: dbrownell@users.sourceforge.net, linux-omap@vger.kernel.org, Tero Kristo <tero.kristo@nokia.com>

From: Tero Kristo <tero.kristo@nokia.com>

Previous restore was lazy and only restored CHxCONF when it was needed by a
specific chip select. This could cause occasional errors on an SPI bus where
multiple chip selects are in use.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 drivers/spi/omap2_mcspi.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index 5240c01..672468a 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -134,6 +134,7 @@ struct omap2_mcspi_cs {
 	void __iomem		*base;
 	unsigned long		phys;
 	int			word_len;
+	struct list_head	node;
 	/* Context save and restore shadow register */
 	u32			chconf0;
 };
@@ -145,6 +146,7 @@ struct omap2_mcspi_regs {
 	u32 sysconfig;
 	u32 modulctrl;
 	u32 wakeupenable;
+	struct list_head cs;
 };
 
 static struct omap2_mcspi_regs omap2_mcspi_ctx[OMAP2_MCSPI_MAX_CTRL];
@@ -255,6 +257,7 @@ static void omap2_mcspi_set_master_mode(struct spi_master *master)
 static void omap2_mcspi_restore_ctx(struct omap2_mcspi *mcspi)
 {
 	struct spi_master *spi_cntrl;
+	struct omap2_mcspi_cs *cs;
 	spi_cntrl = mcspi->master;
 
 	/* McSPI: context restore */
@@ -266,6 +269,10 @@ static void omap2_mcspi_restore_ctx(struct omap2_mcspi *mcspi)
 
 	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_WAKEUPENABLE,
 			omap2_mcspi_ctx[spi_cntrl->bus_num - 1].wakeupenable);
+
+	list_for_each_entry(cs, &omap2_mcspi_ctx[spi_cntrl->bus_num - 1].cs,
+			node)
+		__raw_writel(cs->chconf0, cs->base + OMAP2_MCSPI_CHCONF0);
 }
 static void omap2_mcspi_disable_clocks(struct omap2_mcspi *mcspi)
 {
@@ -695,6 +702,9 @@ static int omap2_mcspi_setup(struct spi_device *spi)
 		cs->phys = mcspi->phys + spi->chip_select * 0x14;
 		cs->chconf0 = 0;
 		spi->controller_state = cs;
+		/* Link this to context save list */
+		list_add_tail(&cs->node,
+			&omap2_mcspi_ctx[mcspi->master->bus_num - 1].cs);
 	}
 
 	if (mcspi_dma->dma_rx_channel == -1
@@ -717,10 +727,15 @@ static void omap2_mcspi_cleanup(struct spi_device *spi)
 {
 	struct omap2_mcspi	*mcspi;
 	struct omap2_mcspi_dma	*mcspi_dma;
+	struct omap2_mcspi_cs	*cs;
 
 	mcspi = spi_master_get_devdata(spi->master);
 	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
 
+	/* Unlink controller state from context save list */
+	cs = spi->controller_state;
+	list_del(&cs->node);
+
 	kfree(spi->controller_state);
 
 	if (mcspi_dma->dma_rx_channel != -1) {
@@ -1085,6 +1100,7 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)
 
 	spin_lock_init(&mcspi->lock);
 	INIT_LIST_HEAD(&mcspi->msg_queue);
+	INIT_LIST_HEAD(&omap2_mcspi_ctx[master->bus_num - 1].cs);
 
 	mcspi->ick = clk_get(&pdev->dev, "ick");
 	if (IS_ERR(mcspi->ick)) {
-- 
1.6.3.3

