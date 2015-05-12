From: Michael Welling <mwelling@ieee.org>
Subject: [PATCH] spi: omap2-mcspi: Fix native cs with new set_cs
Date: Tue, 12 May 2015 12:38:57 -0500
Message-ID: <1431452337-19280-1-git-send-email-mwelling@ieee.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:37462 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933161AbbELRjH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 May 2015 13:39:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-next@vger.kernel.org, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Michael Welling <mwelling@ieee.org>

GPIO chip select patch series appears to have broken the native chip select
support. This patch pulls the manual native chip select toggling out of
the transfer_one routine and adds a set_cs routine.

Tested natively on AM3354 with SPI serial flash on spi0cs0.

Signed-off-by: Michael Welling <mwelling@ieee.org>
---
 drivers/spi/spi-omap2-mcspi.c |   33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 90cf7e7..a7d85c5 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -243,17 +243,20 @@ static void omap2_mcspi_set_enable(const struct spi_device *spi, int enable)
 	mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCTRL0);
 }
 
-static void omap2_mcspi_force_cs(struct spi_device *spi, int cs_active)
+static void omap2_mcspi_set_cs(struct spi_device *spi, bool enable)
 {
 	u32 l;
 
-	l = mcspi_cached_chconf0(spi);
-	if (cs_active)
-		l |= OMAP2_MCSPI_CHCONF_FORCE;
-	else
-		l &= ~OMAP2_MCSPI_CHCONF_FORCE;
+	if (spi->controller_state) {
+		l = mcspi_cached_chconf0(spi);
 
-	mcspi_write_chconf0(spi, l);
+		if (enable)
+			l &= ~OMAP2_MCSPI_CHCONF_FORCE;
+		else
+			l |= OMAP2_MCSPI_CHCONF_FORCE;
+
+		mcspi_write_chconf0(spi, l);
+	}
 }
 
 static void omap2_mcspi_set_master_mode(struct spi_master *master)
@@ -1075,7 +1078,6 @@ static int omap2_mcspi_work_one(struct omap2_mcspi *mcspi,
 
 	struct spi_master		*master;
 	struct omap2_mcspi_dma		*mcspi_dma;
-	int				cs_active = 0;
 	struct omap2_mcspi_cs		*cs;
 	struct omap2_mcspi_device_config *cd;
 	int				par_override = 0;
@@ -1118,11 +1120,6 @@ static int omap2_mcspi_work_one(struct omap2_mcspi *mcspi,
 			mcspi_read_cs_reg(spi, OMAP2_MCSPI_MODULCTRL);
 	}
 
-	if (!cs_active) {
-		omap2_mcspi_force_cs(spi, 1);
-		cs_active = 1;
-	}
-
 	chconf = mcspi_cached_chconf0(spi);
 	chconf &= ~OMAP2_MCSPI_CHCONF_TRM_MASK;
 	chconf &= ~OMAP2_MCSPI_CHCONF_TURBO;
@@ -1169,12 +1166,6 @@ static int omap2_mcspi_work_one(struct omap2_mcspi *mcspi,
 	if (t->delay_usecs)
 		udelay(t->delay_usecs);
 
-	/* ignore the "leave it on after last xfer" hint */
-	if (t->cs_change) {
-		omap2_mcspi_force_cs(spi, 0);
-		cs_active = 0;
-	}
-
 	omap2_mcspi_set_enable(spi, 0);
 
 	if (mcspi->fifo_depth > 0)
@@ -1187,9 +1178,6 @@ out:
 		status = omap2_mcspi_setup_transfer(spi, NULL);
 	}
 
-	if (cs_active)
-		omap2_mcspi_force_cs(spi, 0);
-
 	if (cd && cd->cs_per_word) {
 		chconf = mcspi->ctx.modulctrl;
 		chconf |= OMAP2_MCSPI_MODULCTRL_SINGLE;
@@ -1334,6 +1322,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	master->setup = omap2_mcspi_setup;
 	master->auto_runtime_pm = true;
 	master->transfer_one = omap2_mcspi_transfer_one;
+	master->set_cs = omap2_mcspi_set_cs;
 	master->cleanup = omap2_mcspi_cleanup;
 	master->dev.of_node = node;
 	master->max_speed_hz = OMAP2_MCSPI_MAX_FREQ;
-- 
1.7.9.5

