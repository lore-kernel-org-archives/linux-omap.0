From: Ben Gamari <bgamari.foss@gmail.com>
Subject: [PATCH] mcspi: Add support for GPIO chip select lines
Date: Tue, 30 Aug 2011 09:50:54 -0400
Message-ID: <1314712254-27199-2-git-send-email-bgamari.foss@gmail.com>
References: <CA+dZkakw9COsETWZkvMzp2v-ymfQdDEqp3jJuhWbrRTTTjpbGQ@mail.gmail.com>
 <1314712254-27199-1-git-send-email-bgamari.foss@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:56007 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754183Ab1H3Nv3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Aug 2011 09:51:29 -0400
Received: by qyk15 with SMTP id 15so1640710qyk.19
        for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 06:51:28 -0700 (PDT)
In-Reply-To: <1314712254-27199-1-git-send-email-bgamari.foss@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Raju Sana <venkat.rajuece@gmail.com>
Cc: beagleboard@googlegroups.com, linux-omap@vger.kernel.org, spi-devel-general@lists.sourceforge.net, Ben Gamari <bgamari.foss@gmail.com>

Many applications require more chip select lines than the board or
processor allow. Introduce a mechanism to allow use of GPIO pins as
chip select lines with the McSPI controller. To use this
tionality,
one simply provides a table mapping CS line numbers to GPIO numbers

omap2_mcspi_platform_config.cs_gpios.

Signed-off-by: Ben Gamari <bgamari.foss@gmail.com>
---
 arch/arm/plat-omap/include/plat/mcspi.h |    1 +
 drivers/spi/omap2_mcspi.c               |   19 +++++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mcspi.h b/arch/arm/plat-omap/include/plat/mcspi.h
index 3d51b18..c5670f2 100644
--- a/arch/arm/plat-omap/include/plat/mcspi.h
+++ b/arch/arm/plat-omap/include/plat/mcspi.h
@@ -10,6 +10,7 @@
 struct omap2_mcspi_platform_config {
 	unsigned short	num_cs;
 	unsigned int regs_offset;
+	int *cs_gpios;
 };
 
 struct omap2_mcspi_dev_attr {
diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index f41c906..20dec5d 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -36,6 +36,7 @@
 #include <linux/pm_runtime.h>
 
 #include <linux/spi/spi.h>
+#include <linux/gpio.h>
 
 #include <plat/dma.h>
 #include <plat/clock.h>
@@ -121,6 +122,7 @@ struct omap2_mcspi {
 	/* SPI1 has 4 channels, while SPI2 has 2 */
 	struct omap2_mcspi_dma	*dma_channels;
 	struct  device		*dev;
+        int                     *cs_gpios;
 };
 
 struct omap2_mcspi_cs {
@@ -227,7 +229,11 @@ static void omap2_mcspi_set_enable(const struct spi_device *spi, int enable)
 static void omap2_mcspi_force_cs(struct spi_device *spi, int cs_active)
 {
 	u32 l;
+	struct omap2_mcspi* mcspi = spi_master_get_devdata(spi->master);
+	if (mcspi->cs_gpios)
+		gpio_set_value(mcspi->cs_gpios[spi->chip_select], cs_active);
 
+	// TXS times out unless we force the CHCONF reg as well
 	l = mcspi_cached_chconf0(spi);
 	MOD_REG_BIT(l, OMAP2_MCSPI_CHCONF_FORCE, cs_active);
 	mcspi_write_chconf0(spi, l);
@@ -1088,6 +1094,8 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)
 	struct omap2_mcspi	*mcspi;
 	struct resource		*r;
 	int			status = 0, i;
+	struct omap2_mcspi_platform_config* pconfig = pdev->dev.platform_data;
+	int                     num_dma;
 
 	master = spi_alloc_master(&pdev->dev, sizeof *mcspi);
 	if (master == NULL) {
@@ -1110,6 +1118,13 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)
 
 	mcspi = spi_master_get_devdata(master);
 	mcspi->master = master;
+	if (pconfig && pconfig->cs_gpios) {
+		mcspi->cs_gpios = pconfig->cs_gpios;
+		num_dma = 1;
+	} else {
+		mcspi->cs_gpios = NULL;
+		num_dma = master->num_chipselect;
+	}
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (r == NULL) {
@@ -1139,14 +1154,14 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&mcspi->msg_queue);
 	INIT_LIST_HEAD(&omap2_mcspi_ctx[master->bus_num - 1].cs);
 
-	mcspi->dma_channels = kcalloc(master->num_chipselect,
+	mcspi->dma_channels = kcalloc(num_dma,
 			sizeof(struct omap2_mcspi_dma),
 			GFP_KERNEL);
 
 	if (mcspi->dma_channels == NULL)
 		goto err2;
 
-	for (i = 0; i < master->num_chipselect; i++) {
+	for (i = 0; i < num_dma; i++) {
 		char dma_ch_name[14];
 		struct resource *dma_res;
 
-- 
1.7.4.1

