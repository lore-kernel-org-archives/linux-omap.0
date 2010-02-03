From: "Hemanth V" <hemanthv@ti.com>
Subject: [PATCH V2 3/3] Add support for Slave mode
Date: Wed, 3 Feb 2010 15:52:06 +0530 (IST)
Message-ID: <9735.10.24.255.17.1265192526.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45899 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932276Ab0BCKWQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Feb 2010 05:22:16 -0500
References: 
In-Reply-To: 
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net
Cc: linux-omap@vger.kernel.org, dbrownell@users.sourceforge.net, grant.likely@secretlab.ca

>From c13e2181154c793a71e132ab374bba1720ca421c Mon Sep 17 00:00:00 2001
From: Hemanth V <hemanthv@ti.com>
Date: Fri, 27 Nov 2009 14:37:20 +0530
Subject: [PATCH] Add McSPI slave support.

This patch adds support for mcspi slave mode.

Signed-off-by: Hemanth V <hemanthv@ti.com>
---
 drivers/spi/omap2_mcspi.c |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c index
d8e8ea0..f6041bf 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -428,6 +428,16 @@ static void omap2_mcspi_set_master_mode(struct spi_master
*master)
 	omap2_mcspi_ctx[master->bus_num - 1].modulctrl = l;
 }

+static void omap2_mcspi_set_slave_mode(struct spi_master *master) +{
+	u32 l;
+
+	l = mcspi_read_reg(master, OMAP2_MCSPI_MODULCTRL);
+	MOD_REG_BIT(l, OMAP2_MCSPI_MODULCTRL_STEST, 0);
+	MOD_REG_BIT(l, OMAP2_MCSPI_MODULCTRL_MS, 1);
+	mcspi_write_reg(master, OMAP2_MCSPI_MODULCTRL, l);
+}
+
 static int mcspi_wait_for_reg_bit(void __iomem *reg, unsigned long bit) {
 	unsigned long timeout;
@@ -827,10 +837,11 @@ static int omap2_mcspi_setup_transfer(struct spi_device
*spi,
 		l &= ~(OMAP2_MCSPI_CHCONF_IS|OMAP2_MCSPI_CHCONF_DPE1);
 		l |= OMAP2_MCSPI_CHCONF_DPE0;
 	} else {
-		return -EINVAL;
+		l |= OMAP2_MCSPI_CHCONF_IS;
+		l |= OMAP2_MCSPI_CHCONF_DPE1;
+		l &= ~OMAP2_MCSPI_CHCONF_DPE0;
 	}

-
 	/* wordlength */
 	l &= ~OMAP2_MCSPI_CHCONF_WL_MASK;
 	l |= (word_len - 1) << 7;
@@ -1216,7 +1227,6 @@ static int __init omap2_mcspi_reset(struct omap2_mcspi
*mcspi)
 {
 	struct spi_master	*master = mcspi->master;
 	u32			tmp;
-	u32			error = 0;

 	if (omap2_mcspi_enable_clocks(mcspi))
 		return -1;
@@ -1240,10 +1250,10 @@ static int __init omap2_mcspi_reset(struct omap2_mcspi
*mcspi)
 	if (mcspi->mcspi_mode == OMAP2_MCSPI_MASTER)
 		omap2_mcspi_set_master_mode(master);
 	else
-		error = -EINVAL;
+		omap2_mcspi_set_slave_mode(master);

 	omap2_mcspi_disable_clocks(mcspi);
-	return error;
+	return 0;
 }

 static u8 __initdata spi1_rxdma_id [] = {
@@ -1355,7 +1365,7 @@ static int __init omap2_mcspi_probe(struct
platform_device *pdev)

 	mcspi = spi_master_get_devdata(master);
 	mcspi->master = master;
-	mcspi->mcspi_mode = OMAP2_MCSPI_MASTER;
+	mcspi->mcspi_mode = pdata->mode;
 	mcspi->dma_mode = pdata->dma_mode;
 	mcspi->force_cs_mode = pdata->force_cs_mode;

-- 
1.5.6.3





