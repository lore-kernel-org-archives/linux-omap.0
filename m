From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 3/3] spi: spi-omap2-mcspi.c: Toggle CS after each word
Date: Wed, 23 Jan 2013 19:08:49 +0100
Message-ID: <1358964529-4905-1-git-send-email-matthias.bgg@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:47718 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755822Ab3AWSJB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jan 2013 13:09:01 -0500
Received: by mail-we0-f169.google.com with SMTP id t11so2515061wey.28
        for <linux-omap@vger.kernel.org>; Wed, 23 Jan 2013 10:08:59 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, Daniel Mack <zonque@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, eballetbo@gmail.com, javier.martinez@collabora.co.uk, ezequiel.garcia@free-electrons.com, spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org
Cc: Matthias Brugger <matthias.bgg@gmail.com>

This patch allows the board code to define SPI devices which needs to
toggle the chip select after every word send. This is needed to get a
better resolution reading e.g. an ADC data stream.
Apart from that, as in the normal code CS is controlled by software,
a transfer is done much faster.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/spi/spi-omap2-mcspi.c                 | 34 ++++++++++++++++++++-------
 include/linux/platform_data/spi-omap2-mcspi.h |  3 +++
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index b610f52..12789fc 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -927,6 +927,7 @@ static void omap2_mcspi_work(struct omap2_mcspi *mcspi, struct spi_message *m)
 
 	struct spi_device		*spi;
 	struct spi_transfer		*t = NULL;
+	struct spi_master		*master;
 	int				cs_active = 0;
 	struct omap2_mcspi_cs		*cs;
 	struct omap2_mcspi_device_config *cd;
@@ -935,6 +936,7 @@ static void omap2_mcspi_work(struct omap2_mcspi *mcspi, struct spi_message *m)
 	u32				chconf;
 
 	spi = m->spi;
+	master = spi->master;
 	cs = spi->controller_state;
 	cd = spi->controller_data;
 
@@ -952,6 +954,14 @@ static void omap2_mcspi_work(struct omap2_mcspi *mcspi, struct spi_message *m)
 			if (!t->speed_hz && !t->bits_per_word)
 				par_override = 0;
 		}
+		if (cd && cd->cs_per_word) {
+			chconf = mcspi->ctx.modulctrl;
+			chconf &= ~OMAP2_MCSPI_MODULCTRL_SINGLE;
+			mcspi_write_reg(master, OMAP2_MCSPI_MODULCTRL, chconf);
+			mcspi->ctx.modulctrl =
+				mcspi_read_cs_reg(spi, OMAP2_MCSPI_MODULCTRL);
+		}
+
 
 		if (!cs_active) {
 			omap2_mcspi_force_cs(spi, 1);
@@ -1013,6 +1023,14 @@ static void omap2_mcspi_work(struct omap2_mcspi *mcspi, struct spi_message *m)
 	if (cs_active)
 		omap2_mcspi_force_cs(spi, 0);
 
+	if (cd && cd->cs_per_word) {
+		chconf = mcspi->ctx.modulctrl;
+		chconf |= OMAP2_MCSPI_MODULCTRL_SINGLE;
+		mcspi_write_reg(master, OMAP2_MCSPI_MODULCTRL, chconf);
+		mcspi->ctx.modulctrl =
+			mcspi_read_cs_reg(spi, OMAP2_MCSPI_MODULCTRL);
+	}
+
 	omap2_mcspi_set_enable(spi, 0);
 
 	m->status = status;
@@ -1020,7 +1038,7 @@ static void omap2_mcspi_work(struct omap2_mcspi *mcspi, struct spi_message *m)
 }
 
 static int omap2_mcspi_transfer_one_message(struct spi_master *master,
-						struct spi_message *m)
+		struct spi_message *m)
 {
 	struct omap2_mcspi	*mcspi;
 	struct spi_transfer	*t;
@@ -1041,7 +1059,7 @@ static int omap2_mcspi_transfer_one_message(struct spi_master *master,
 				|| (len && !(rx_buf || tx_buf))
 				|| (t->bits_per_word &&
 					(  t->bits_per_word < 4
-					|| t->bits_per_word > 32))) {
+					   || t->bits_per_word > 32))) {
 			dev_dbg(mcspi->dev, "transfer: %d Hz, %d %s%s, %d bpw\n",
 					t->speed_hz,
 					len,
@@ -1052,8 +1070,8 @@ static int omap2_mcspi_transfer_one_message(struct spi_master *master,
 		}
 		if (t->speed_hz && t->speed_hz < (OMAP2_MCSPI_MAX_FREQ >> 15)) {
 			dev_dbg(mcspi->dev, "speed_hz %d below minimum %d Hz\n",
-				t->speed_hz,
-				OMAP2_MCSPI_MAX_FREQ >> 15);
+					t->speed_hz,
+					OMAP2_MCSPI_MAX_FREQ >> 15);
 			return -EINVAL;
 		}
 
@@ -1099,7 +1117,7 @@ static int omap2_mcspi_master_setup(struct omap2_mcspi *mcspi)
 		return ret;
 
 	mcspi_write_reg(master, OMAP2_MCSPI_WAKEUPENABLE,
-				OMAP2_MCSPI_WAKEUPENABLE_WKEN);
+			OMAP2_MCSPI_WAKEUPENABLE_WKEN);
 	ctx->wakeupenable = OMAP2_MCSPI_WAKEUPENABLE_WKEN;
 
 	omap2_mcspi_set_master_mode(master);
@@ -1228,7 +1246,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 
 		sprintf(dma_ch_name, "rx%d", i);
 		dma_res = platform_get_resource_byname(pdev, IORESOURCE_DMA,
-							dma_ch_name);
+				dma_ch_name);
 		if (!dma_res) {
 			dev_dbg(&pdev->dev, "cannot get DMA RX channel\n");
 			status = -ENODEV;
@@ -1238,7 +1256,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 		mcspi->dma_channels[i].dma_rx_sync_dev = dma_res->start;
 		sprintf(dma_ch_name, "tx%d", i);
 		dma_res = platform_get_resource_byname(pdev, IORESOURCE_DMA,
-							dma_ch_name);
+				dma_ch_name);
 		if (!dma_res) {
 			dev_dbg(&pdev->dev, "cannot get DMA TX channel\n");
 			status = -ENODEV;
@@ -1254,7 +1272,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
 	if (IS_ERR(pinctrl))
 		dev_warn(&pdev->dev,
-			"pins are not configured from the driver\n");
+				"pins are not configured from the driver\n");
 
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
diff --git a/include/linux/platform_data/spi-omap2-mcspi.h b/include/linux/platform_data/spi-omap2-mcspi.h
index a65572d..c100456 100644
--- a/include/linux/platform_data/spi-omap2-mcspi.h
+++ b/include/linux/platform_data/spi-omap2-mcspi.h
@@ -22,6 +22,9 @@ struct omap2_mcspi_dev_attr {
 
 struct omap2_mcspi_device_config {
 	unsigned turbo_mode:1;
+
+	/* toggle chip select after every word */
+	unsigned cs_per_word:1;
 };
 
 #endif
-- 
1.7.11.7

