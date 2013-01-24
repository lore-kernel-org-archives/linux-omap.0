From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v2] spi: spi-omap2-mcspi.c: Toggle CS after each word
Date: Thu, 24 Jan 2013 13:40:41 +0100
Message-ID: <1359031241-3234-1-git-send-email-matthias.bgg@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:44540 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065Ab3AXMk5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jan 2013 07:40:57 -0500
Received: by mail-wg0-f45.google.com with SMTP id dq12so1409908wgb.12
        for <linux-omap@vger.kernel.org>; Thu, 24 Jan 2013 04:40:55 -0800 (PST)
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
 drivers/spi/spi-omap2-mcspi.c                 | 18 ++++++++++++++++++
 include/linux/platform_data/spi-omap2-mcspi.h |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 31f6e84..12789fc 100644
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

