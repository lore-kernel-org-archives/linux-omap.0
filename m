From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH PM 1/1] OMAP3 McSPI: Fix to restore chconf for all CSs
Date: Tue,  3 Feb 2009 15:35:21 +0200
Message-ID: <1233668121-32200-2-git-send-email-jouni.hogander@nokia.com>
References: <1233668121-32200-1-git-send-email-jouni.hogander@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:55395 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbZBCNhT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Feb 2009 08:37:19 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n13DbFAs020928
	for <linux-omap@vger.kernel.org>; Tue, 3 Feb 2009 15:37:17 +0200
Received: from localhost.localdomain (trdhcp147193.ntc.nokia.com [172.22.147.193])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n13DXEVE007687
	for <linux-omap@vger.kernel.org>; Tue, 3 Feb 2009 15:33:16 +0200
In-Reply-To: <1233668121-32200-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch saves/restores chconf0 for all CSs instead of only for CS0

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 drivers/spi/omap2_mcspi.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index a7ee3b7..45632dd 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -142,7 +142,7 @@ struct omap2_mcspi_cs {
 struct omap2_mcspi_regs {
 	u32 sysconfig;
 	u32 modulctrl;
-	u32 chconf0;
+	u32 chconf0[4];
 	u32 wakeupenable;
 };
 
@@ -238,8 +238,8 @@ static void omap2_mcspi_set_master_mode(struct spi_master *master)
 
 static void omap2_mcspi_restore_ctx(struct omap2_mcspi *mcspi)
 {
-	struct spi_master *spi_cntrl;
-	spi_cntrl = mcspi->master;
+	struct spi_master *spi_cntrl = mcspi->master;
+	int i;
 
 	/* McSPI: context restore */
 	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_MODULCTRL,
@@ -248,9 +248,9 @@ static void omap2_mcspi_restore_ctx(struct omap2_mcspi *mcspi)
 	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_SYSCONFIG,
 			omap2_mcspi_ctx[spi_cntrl->bus_num - 1].sysconfig);
 
-	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_CHCONF0,
-			omap2_mcspi_ctx[spi_cntrl->bus_num - 1].chconf0);
-
+	for (i = 0; i < spi_cntrl->num_chipselect; i++)
+		mcspi_write_reg(spi_cntrl, i * 0x14 + OMAP2_MCSPI_CHCONF0,
+				omap2_mcspi_ctx[spi_cntrl->bus_num - 1].chconf0[i]);
 
 	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_WAKEUPENABLE,
 			omap2_mcspi_ctx[spi_cntrl->bus_num - 1].wakeupenable);
@@ -593,7 +593,7 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 
 	mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, l);
 
-	omap2_mcspi_ctx[spi_cntrl->bus_num - 1].chconf0 = l;
+	omap2_mcspi_ctx[spi_cntrl->bus_num - 1].chconf0[spi->chip_select] = l;
 
 	dev_dbg(&spi->dev, "setup: speed %d, sample %s edge, clk %s\n",
 			OMAP2_MCSPI_MAX_FREQ / (1 << div),
-- 
1.6.0.1

