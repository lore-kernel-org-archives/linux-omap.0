From: "Nagarajan, Rajkumar" <x0133774@ti.com>
Subject: [PATCH V6] OMAP: DSS: Add NEC NL8048HL11-01B display panel
Date: Fri, 21 May 2010 20:52:20 +0530
Message-ID: <FF55437E1F14DA4BAEB721A458B6701706BD6F2259@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33329 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933449Ab0EUPWZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 May 2010 11:22:25 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o4LFMLsu005825
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 21 May 2010 10:22:24 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o4LFML7h016687
	for <linux-omap@vger.kernel.org>; Fri, 21 May 2010 20:52:21 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From e0bfb90c4a24f13896e49e565118677aae5d9ed4 Mon Sep 17 00:00:00 2001
From: Erik Gilling <konkers@android.com>
Date: Tue, 18 May 2010 12:30:43 +0530
Subject: [PATCH] OMAP: DSS: Add NEC NL8048HL11-01B display panel

NEC WVGA LCD NL8048HL11-01B support has been added.

Signed-off-by: Mukund Mittal <mmittal@ti.com>
Signed-off-by: Kishore Y <kishore.y@ti.com>
Signed-off-by: Rajkumar N <rajkumar.nagarajan@ti.com>
Reviewed-by: Gadiyar, Anand <gadiyar@ti.com>
---
 drivers/video/omap2/displays/Kconfig               |    6 +
 drivers/video/omap2/displays/Makefile              |    1 +
 .../omap2/displays/panel-nec-nl8048hl11-01b.c      |  281 ++++++++++++++++++++
 3 files changed, 288 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c

diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
index 5f568a2..83f3224 100644
--- a/drivers/video/omap2/displays/Kconfig
+++ b/drivers/video/omap2/displays/Kconfig
@@ -37,6 +37,12 @@ config PANEL_TPO_TD043MTEA1
         help
           LCD Panel used in OMAP3 Pandora
 
+config PANEL_NEC_NL8048HL11_01B
+        tristate "NEC NL8048HL11-01B Panel support"
+        depends on OMAP2_DSS
+        help
+          LCD Panel from NEC.
+
 config PANEL_ACX565AKM
 	tristate "ACX565AKM Panel"
 	depends on OMAP2_DSS_SDI
diff --git a/drivers/video/omap2/displays/Makefile b/drivers/video/omap2/displays/Makefile
index aa38609..fc8aca3 100644
--- a/drivers/video/omap2/displays/Makefile
+++ b/drivers/video/omap2/displays/Makefile
@@ -5,4 +5,5 @@ obj-$(CONFIG_PANEL_SHARP_LQ043T1DG01) += panel-sharp-lq043t1dg01.o
 obj-$(CONFIG_PANEL_TAAL) += panel-taal.o
 obj-$(CONFIG_PANEL_TOPPOLY_TDO35S) += panel-toppoly-tdo35s.o
 obj-$(CONFIG_PANEL_TPO_TD043MTEA1) += panel-tpo-td043mtea1.o
+obj-$(CONFIG_PANEL_NEC_NL8048HL11_01B) += panel-nec-nl8048hl11-01b.o
 obj-$(CONFIG_PANEL_ACX565AKM) += panel-acx565akm.o
diff --git a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
new file mode 100644
index 0000000..ced8df2
--- /dev/null
+++ b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
@@ -0,0 +1,281 @@
+/*
+ * NEC panel support
+ *
+ * Copyright (C) 2010 Texas Instruments Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/spi/spi.h>
+
+#include <plat/display.h>
+
+#define LCD_XRES		800
+#define LCD_YRES		480
+/* NEC PIX Clock Ratings
+ * MIN:21.8MHz TYP:23.8MHz MAX:25.7MHz
+ */
+#define LCD_PIXEL_CLOCK		23800
+
+/* NEC NL8048HL11-01B  Manual
+ * defines HFB, HSW, HBP, VFP, VSW, VBP as shown below
+ */
+
+static struct omap_video_timings nec_8048_panel_timings = {
+	/* 800 x 480 @ 60 Hz  Reduced blanking VESA CVT 0.31M3-R */
+	.x_res          = LCD_XRES,
+	.y_res          = LCD_YRES,
+	.pixel_clock    = LCD_PIXEL_CLOCK,
+	.hfp            = 6,
+	.hsw            = 1,
+	.hbp            = 4,
+	.vfp            = 3,
+	.vsw            = 1,
+	.vbp            = 4,
+};
+
+static int nec_8048_panel_probe(struct omap_dss_device *dssdev)
+{
+	dssdev->panel.config = OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+				OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_RF |
+				OMAP_DSS_LCD_ONOFF;
+	dssdev->panel.timings = nec_8048_panel_timings;
+
+	return 0;
+}
+
+static void nec_8048_panel_remove(struct omap_dss_device *dssdev)
+{
+}
+
+static int nec_8048_panel_enable(struct omap_dss_device *dssdev)
+{
+	int r = 0;
+
+	if (dssdev->platform_enable)
+		r = dssdev->platform_enable(dssdev);
+	omapdss_dpi_display_enable(dssdev);
+
+	return r;
+}
+
+static void nec_8048_panel_disable(struct omap_dss_device *dssdev)
+{
+	omapdss_dpi_display_disable(dssdev);
+	if (dssdev->platform_disable)
+		dssdev->platform_disable(dssdev);
+}
+
+static int nec_8048_panel_suspend(struct omap_dss_device *dssdev)
+{
+	nec_8048_panel_disable(dssdev);
+	return 0;
+}
+
+static int nec_8048_panel_resume(struct omap_dss_device *dssdev)
+{
+	return nec_8048_panel_enable(dssdev);
+}
+
+static int nec_8048_recommended_bpp(struct omap_dss_device *dssdev)
+{
+	return 16;
+}
+
+static struct omap_dss_driver nec_8048_driver = {
+	.probe          = nec_8048_panel_probe,
+	.remove         = nec_8048_panel_remove,
+	.enable         = nec_8048_panel_enable,
+	.disable        = nec_8048_panel_disable,
+	.suspend        = nec_8048_panel_suspend,
+	.resume         = nec_8048_panel_resume,
+	.get_recommended_bpp = nec_8048_recommended_bpp,
+	.driver		= {
+		.name	= "NEC_8048_panel",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int
+spi_send(struct spi_device *spi, unsigned char reg_addr, unsigned char reg_data)
+{
+	int ret = 0;
+	unsigned int cmd = 0, data = 0;
+
+	cmd = 0x0000 | reg_addr; /* register address write */
+	data = 0x0100 | reg_data; /* register data write */
+	data = (cmd << 16) | data;
+	ret = spi_write(spi, (unsigned char *)&data, 4);
+	if (ret) {
+		printk(KERN_ERR "error in spi_write %x\n", data);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int init_nec_8048_wvga_lcd(struct spi_device *spi)
+{
+	/* Initialization Sequence */
+	/* spi_send(spi, REG, VAL) */
+	spi_send(spi, 3, 0x01);
+	spi_send(spi, 0, 0x00);
+	spi_send(spi, 1, 0x01);    /* R1 = 0x01 (normal), 0x03 (reversed) */
+	spi_send(spi, 4, 0x00);
+	spi_send(spi, 5, 0x14);
+	spi_send(spi, 6, 0x24);
+	spi_send(spi, 16, 0xD7);
+	spi_send(spi, 17, 0x00);
+	spi_send(spi, 18, 0x00);
+	spi_send(spi, 19, 0x55);
+	spi_send(spi, 20, 0x01);
+	spi_send(spi, 21, 0x70);
+	spi_send(spi, 22, 0x1E);
+	spi_send(spi, 23, 0x25);
+	spi_send(spi, 24, 0x25);
+	spi_send(spi, 25, 0x02);
+	spi_send(spi, 26, 0x02);
+	spi_send(spi, 27, 0xA0);
+	spi_send(spi, 32, 0x2F);
+	spi_send(spi, 33, 0x0F);
+	spi_send(spi, 34, 0x0F);
+	spi_send(spi, 35, 0x0F);
+	spi_send(spi, 36, 0x0F);
+	spi_send(spi, 37, 0x0F);
+	spi_send(spi, 38, 0x0F);
+	spi_send(spi, 39, 0x00);
+	spi_send(spi, 40, 0x02);
+	spi_send(spi, 41, 0x02);
+	spi_send(spi, 42, 0x02);
+	spi_send(spi, 43, 0x0F);
+	spi_send(spi, 44, 0x0F);
+	spi_send(spi, 45, 0x0F);
+	spi_send(spi, 46, 0x0F);
+	spi_send(spi, 47, 0x0F);
+	spi_send(spi, 48, 0x0F);
+	spi_send(spi, 49, 0x0F);
+	spi_send(spi, 50, 0x00);
+	spi_send(spi, 51, 0x02);
+	spi_send(spi, 52, 0x02);
+	spi_send(spi, 53, 0x02);
+	spi_send(spi, 80, 0x0C);
+	spi_send(spi, 83, 0x42);
+	spi_send(spi, 84, 0x42);
+	spi_send(spi, 85, 0x41);
+	spi_send(spi, 86, 0x14);
+	spi_send(spi, 89, 0x88);
+	spi_send(spi, 90, 0x01);
+	spi_send(spi, 91, 0x00);
+	spi_send(spi, 92, 0x02);
+	spi_send(spi, 93, 0x0C);
+	spi_send(spi, 94, 0x1C);
+	spi_send(spi, 95, 0x27);
+	spi_send(spi, 98, 0x49);
+	spi_send(spi, 99, 0x27);
+	spi_send(spi, 102, 0x76);
+	spi_send(spi, 103, 0x27);
+	spi_send(spi, 112, 0x01);
+	spi_send(spi, 113, 0x0E);
+	spi_send(spi, 114, 0x02);
+	spi_send(spi, 115, 0x0C);
+	spi_send(spi, 118, 0x0C);
+	spi_send(spi, 121, 0x30); /* R121 = 0x30 (normal), 0x10 (reversed) */
+	spi_send(spi, 130, 0x00);
+	spi_send(spi, 131, 0x00);
+	spi_send(spi, 132, 0xFC);
+	spi_send(spi, 134, 0x00);
+	spi_send(spi, 136, 0x00);
+	spi_send(spi, 138, 0x00);
+	spi_send(spi, 139, 0x00);
+	spi_send(spi, 140, 0x00);
+	spi_send(spi, 141, 0xFC);
+	spi_send(spi, 143, 0x00);
+	spi_send(spi, 145, 0x00);
+	spi_send(spi, 147, 0x00);
+	spi_send(spi, 148, 0x00);
+	spi_send(spi, 149, 0x00);
+	spi_send(spi, 150, 0xFC);
+	spi_send(spi, 152, 0x00);
+	spi_send(spi, 154, 0x00);
+	spi_send(spi, 156, 0x00);
+	spi_send(spi, 157, 0x00);
+	udelay(20);
+	spi_send(spi, 2, 0x00);
+
+	return 0;
+}
+
+static int nec_8048_spi_probe(struct spi_device *spi)
+{
+	spi->mode = SPI_MODE_0;
+	spi->bits_per_word = 32;
+	spi_setup(spi);
+
+	init_nec_8048_wvga_lcd(spi);
+
+	return omap_dss_register_driver(&nec_8048_driver);
+}
+
+static int nec_8048_spi_remove(struct spi_device *spi)
+{
+	omap_dss_unregister_driver(&nec_8048_driver);
+
+	return 0;
+}
+
+static int nec_8048_spi_suspend(struct spi_device *spi, pm_message_t mesg)
+{
+	spi_send(spi, 2, 0x01);
+	mdelay(40);
+
+	return 0;
+}
+
+static int nec_8048_spi_resume(struct spi_device *spi)
+{
+	/* reinitialize the panel */
+	spi_setup(spi);
+	spi_send(spi, 2, 0x00);
+	init_nec_8048_wvga_lcd(spi);
+
+	return 0;
+}
+
+static struct spi_driver nec_8048_spi_driver = {
+	.probe           = nec_8048_spi_probe,
+	.remove	= __devexit_p(nec_8048_spi_remove),
+	.suspend         = nec_8048_spi_suspend,
+	.resume          = nec_8048_spi_resume,
+	.driver         = {
+		.name   = "nec_8048_spi",
+		.bus    = &spi_bus_type,
+		.owner  = THIS_MODULE,
+	},
+};
+
+static int __init nec_8048_lcd_init(void)
+{
+	return spi_register_driver(&nec_8048_spi_driver);
+}
+
+static void __exit nec_8048_lcd_exit(void)
+{
+	return spi_unregister_driver(&nec_8048_spi_driver);
+}
+
+module_init(nec_8048_lcd_init);
+module_exit(nec_8048_lcd_exit);
+MODULE_LICENSE("GPL");
+
-- 
1.5.4.3
