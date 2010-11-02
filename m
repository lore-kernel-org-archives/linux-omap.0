From: Bryan Wu <bryan.wu@canonical.com>
Subject: [PATCH 2/3] OMAP: DSS2: remove dummy panel driver duplicated panel drivers
Date: Tue,  2 Nov 2010 12:13:09 -0400
Message-ID: <1288714390-6159-3-git-send-email-bryan.wu@canonical.com>
References: <1288714390-6159-1-git-send-email-bryan.wu@canonical.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:47565 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915Ab0KBQNZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Nov 2010 12:13:25 -0400
Received: by gxk23 with SMTP id 23so4166278gxk.19
        for <linux-omap@vger.kernel.org>; Tue, 02 Nov 2010 09:13:24 -0700 (PDT)
In-Reply-To: <1288714390-6159-1-git-send-email-bryan.wu@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Still keep sharp_ls_panel driver, because it contains blacklight contro=
l driver.

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 drivers/video/omap2/displays/Kconfig               |   18 -
 drivers/video/omap2/displays/Makefile              |    3 -
 drivers/video/omap2/displays/panel-generic.c       |  174 -------
 .../video/omap2/displays/panel-sharp-lq043t1dg01.c |  165 ------
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |  535 ------------=
--------
 5 files changed, 0 insertions(+), 895 deletions(-)
 delete mode 100644 drivers/video/omap2/displays/panel-generic.c
 delete mode 100644 drivers/video/omap2/displays/panel-sharp-lq043t1dg0=
1.c
 delete mode 100644 drivers/video/omap2/displays/panel-tpo-td043mtea1.c

diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2=
/displays/Kconfig
index 4b2ed33..4a29863 100644
--- a/drivers/video/omap2/displays/Kconfig
+++ b/drivers/video/omap2/displays/Kconfig
@@ -9,12 +9,6 @@ config PANEL_DUMMY
 	  Supports LCD Panel used in TI SDP3430 and EVM boards,
 	  OMAP3517 EVM boards and CM-T35.
=20
-config PANEL_GENERIC
-        tristate "Generic Panel"
-        help
-	  Generic panel driver.
-	  Used for DVI output for Beagle and OMAP3 SDP.
-
 config PANEL_SHARP_LS037V7DW01
         tristate "Sharp LS037V7DW01 LCD Panel"
         depends on OMAP2_DSS
@@ -22,24 +16,12 @@ config PANEL_SHARP_LS037V7DW01
         help
           LCD Panel used in TI's SDP3430 and EVM boards
=20
-config PANEL_SHARP_LQ043T1DG01
-        tristate "Sharp LQ043T1DG01 LCD Panel"
-        depends on OMAP2_DSS
-        help
-          LCD Panel used in TI's OMAP3517 EVM boards
-
 config PANEL_TAAL
         tristate "Taal DSI Panel"
         depends on OMAP2_DSS_DSI
         help
           Taal DSI command mode panel from TPO.
=20
-config PANEL_TOPPOLY_TDO35S
-        tristate "Toppoly TDO35S LCD Panel support"
-        depends on OMAP2_DSS
-        help
-          LCD Panel used in CM-T35
-
 config PANEL_TPO_TD043MTEA1
         tristate "TPO TD043MTEA1 LCD Panel"
         depends on OMAP2_DSS && SPI
diff --git a/drivers/video/omap2/displays/Makefile b/drivers/video/omap=
2/displays/Makefile
index 5b50036..587bef8 100644
--- a/drivers/video/omap2/displays/Makefile
+++ b/drivers/video/omap2/displays/Makefile
@@ -1,9 +1,6 @@
 obj-$(CONFIG_PANEL_DUMMY) +=3D panel-dummy.o
-obj-$(CONFIG_PANEL_GENERIC) +=3D panel-generic.o
 obj-$(CONFIG_PANEL_SHARP_LS037V7DW01) +=3D panel-sharp-ls037v7dw01.o
-obj-$(CONFIG_PANEL_SHARP_LQ043T1DG01) +=3D panel-sharp-lq043t1dg01.o
=20
 obj-$(CONFIG_PANEL_TAAL) +=3D panel-taal.o
-obj-$(CONFIG_PANEL_TOPPOLY_TDO35S) +=3D panel-toppoly-tdo35s.o
 obj-$(CONFIG_PANEL_TPO_TD043MTEA1) +=3D panel-tpo-td043mtea1.o
 obj-$(CONFIG_PANEL_ACX565AKM) +=3D panel-acx565akm.o
diff --git a/drivers/video/omap2/displays/panel-generic.c b/drivers/vid=
eo/omap2/displays/panel-generic.c
deleted file mode 100644
index 395a68d..0000000
--- a/drivers/video/omap2/displays/panel-generic.c
+++ /dev/null
@@ -1,174 +0,0 @@
-/*
- * Generic panel support
- *
- * Copyright (C) 2008 Nokia Corporation
- * Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
- *
- * This program is free software; you can redistribute it and/or modif=
y it
- * under the terms of the GNU General Public License version 2 as publ=
ished by
- * the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but=
 WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Licen=
se for
- * more details.
- *
- * You should have received a copy of the GNU General Public License a=
long with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#include <linux/module.h>
-#include <linux/delay.h>
-
-#include <plat/display.h>
-
-static struct omap_video_timings generic_panel_timings =3D {
-	/* 640 x 480 @ 60 Hz  Reduced blanking VESA CVT 0.31M3-R */
-	.x_res		=3D 640,
-	.y_res		=3D 480,
-	.pixel_clock	=3D 23500,
-	.hfp		=3D 48,
-	.hsw		=3D 32,
-	.hbp		=3D 80,
-	.vfp		=3D 3,
-	.vsw		=3D 4,
-	.vbp		=3D 7,
-};
-
-static int generic_panel_power_on(struct omap_dss_device *dssdev)
-{
-	int r;
-
-	if (dssdev->state =3D=3D OMAP_DSS_DISPLAY_ACTIVE)
-		return 0;
-
-	r =3D omapdss_dpi_display_enable(dssdev);
-	if (r)
-		goto err0;
-
-	if (dssdev->platform_enable) {
-		r =3D dssdev->platform_enable(dssdev);
-		if (r)
-			goto err1;
-	}
-
-	return 0;
-err1:
-	omapdss_dpi_display_disable(dssdev);
-err0:
-	return r;
-}
-
-static void generic_panel_power_off(struct omap_dss_device *dssdev)
-{
-	if (dssdev->state !=3D OMAP_DSS_DISPLAY_ACTIVE)
-		return;
-
-	if (dssdev->platform_disable)
-		dssdev->platform_disable(dssdev);
-
-	omapdss_dpi_display_disable(dssdev);
-}
-
-static int generic_panel_probe(struct omap_dss_device *dssdev)
-{
-	dssdev->panel.config =3D OMAP_DSS_LCD_TFT;
-	dssdev->panel.timings =3D generic_panel_timings;
-
-	return 0;
-}
-
-static void generic_panel_remove(struct omap_dss_device *dssdev)
-{
-}
-
-static int generic_panel_enable(struct omap_dss_device *dssdev)
-{
-	int r =3D 0;
-
-	r =3D generic_panel_power_on(dssdev);
-	if (r)
-		return r;
-
-	dssdev->state =3D OMAP_DSS_DISPLAY_ACTIVE;
-
-	return 0;
-}
-
-static void generic_panel_disable(struct omap_dss_device *dssdev)
-{
-	generic_panel_power_off(dssdev);
-
-	dssdev->state =3D OMAP_DSS_DISPLAY_DISABLED;
-}
-
-static int generic_panel_suspend(struct omap_dss_device *dssdev)
-{
-	generic_panel_power_off(dssdev);
-	dssdev->state =3D OMAP_DSS_DISPLAY_SUSPENDED;
-	return 0;
-}
-
-static int generic_panel_resume(struct omap_dss_device *dssdev)
-{
-	int r =3D 0;
-
-	r =3D generic_panel_power_on(dssdev);
-	if (r)
-		return r;
-
-	dssdev->state =3D OMAP_DSS_DISPLAY_ACTIVE;
-
-	return 0;
-}
-
-static void generic_panel_set_timings(struct omap_dss_device *dssdev,
-		struct omap_video_timings *timings)
-{
-	dpi_set_timings(dssdev, timings);
-}
-
-static void generic_panel_get_timings(struct omap_dss_device *dssdev,
-		struct omap_video_timings *timings)
-{
-	*timings =3D dssdev->panel.timings;
-}
-
-static int generic_panel_check_timings(struct omap_dss_device *dssdev,
-		struct omap_video_timings *timings)
-{
-	return dpi_check_timings(dssdev, timings);
-}
-
-static struct omap_dss_driver generic_driver =3D {
-	.probe		=3D generic_panel_probe,
-	.remove		=3D generic_panel_remove,
-
-	.enable		=3D generic_panel_enable,
-	.disable	=3D generic_panel_disable,
-	.suspend	=3D generic_panel_suspend,
-	.resume		=3D generic_panel_resume,
-
-	.set_timings	=3D generic_panel_set_timings,
-	.get_timings	=3D generic_panel_get_timings,
-	.check_timings	=3D generic_panel_check_timings,
-
-	.driver         =3D {
-		.name   =3D "generic_panel",
-		.owner  =3D THIS_MODULE,
-	},
-};
-
-static int __init generic_panel_drv_init(void)
-{
-	return omap_dss_register_driver(&generic_driver);
-}
-
-static void __exit generic_panel_drv_exit(void)
-{
-	omap_dss_unregister_driver(&generic_driver);
-}
-
-module_init(generic_panel_drv_init);
-module_exit(generic_panel_drv_exit);
-MODULE_LICENSE("GPL");
diff --git a/drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c b/d=
rivers/video/omap2/displays/panel-sharp-lq043t1dg01.c
deleted file mode 100644
index 0c6896c..0000000
--- a/drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c
+++ /dev/null
@@ -1,165 +0,0 @@
-/*
- * LCD panel driver for Sharp LQ043T1DG01
- *
- * Copyright (C) 2009 Texas Instruments Inc
- * Author: Vaibhav Hiremath <hvaibhav@ti.com>
- *
- * This program is free software; you can redistribute it and/or modif=
y it
- * under the terms of the GNU General Public License version 2 as publ=
ished by
- * the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but=
 WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Licen=
se for
- * more details.
- *
- * You should have received a copy of the GNU General Public License a=
long with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#include <linux/module.h>
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/err.h>
-
-#include <plat/display.h>
-
-static struct omap_video_timings sharp_lq_timings =3D {
-	.x_res =3D 480,
-	.y_res =3D 272,
-
-	.pixel_clock	=3D 9000,
-
-	.hsw		=3D 42,
-	.hfp		=3D 3,
-	.hbp		=3D 2,
-
-	.vsw		=3D 11,
-	.vfp		=3D 3,
-	.vbp		=3D 2,
-};
-
-static int sharp_lq_panel_power_on(struct omap_dss_device *dssdev)
-{
-	int r;
-
-	if (dssdev->state =3D=3D OMAP_DSS_DISPLAY_ACTIVE)
-		return 0;
-
-	r =3D omapdss_dpi_display_enable(dssdev);
-	if (r)
-		goto err0;
-
-	/* wait couple of vsyncs until enabling the LCD */
-	msleep(50);
-
-	if (dssdev->platform_enable) {
-		r =3D dssdev->platform_enable(dssdev);
-		if (r)
-			goto err1;
-	}
-
-	return 0;
-err1:
-	omapdss_dpi_display_disable(dssdev);
-err0:
-	return r;
-}
-
-static void sharp_lq_panel_power_off(struct omap_dss_device *dssdev)
-{
-	if (dssdev->state !=3D OMAP_DSS_DISPLAY_ACTIVE)
-		return;
-
-	if (dssdev->platform_disable)
-		dssdev->platform_disable(dssdev);
-
-	/* wait at least 5 vsyncs after disabling the LCD */
-	msleep(100);
-
-	omapdss_dpi_display_disable(dssdev);
-}
-
-static int sharp_lq_panel_probe(struct omap_dss_device *dssdev)
-{
-
-	dssdev->panel.config =3D OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-		OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IEO;
-	dssdev->panel.acb =3D 0x0;
-	dssdev->panel.timings =3D sharp_lq_timings;
-
-	return 0;
-}
-
-static void sharp_lq_panel_remove(struct omap_dss_device *dssdev)
-{
-}
-
-static int sharp_lq_panel_enable(struct omap_dss_device *dssdev)
-{
-	int r =3D 0;
-
-	r =3D sharp_lq_panel_power_on(dssdev);
-	if (r)
-		return r;
-
-	dssdev->state =3D OMAP_DSS_DISPLAY_ACTIVE;
-
-	return 0;
-}
-
-static void sharp_lq_panel_disable(struct omap_dss_device *dssdev)
-{
-	sharp_lq_panel_power_off(dssdev);
-
-	dssdev->state =3D OMAP_DSS_DISPLAY_DISABLED;
-}
-
-static int sharp_lq_panel_suspend(struct omap_dss_device *dssdev)
-{
-	sharp_lq_panel_power_off(dssdev);
-	dssdev->state =3D OMAP_DSS_DISPLAY_SUSPENDED;
-	return 0;
-}
-
-static int sharp_lq_panel_resume(struct omap_dss_device *dssdev)
-{
-	int r =3D 0;
-
-	r =3D sharp_lq_panel_power_on(dssdev);
-	if (r)
-		return r;
-
-	dssdev->state =3D OMAP_DSS_DISPLAY_ACTIVE;
-
-	return 0;
-}
-
-static struct omap_dss_driver sharp_lq_driver =3D {
-	.probe		=3D sharp_lq_panel_probe,
-	.remove		=3D sharp_lq_panel_remove,
-
-	.enable		=3D sharp_lq_panel_enable,
-	.disable	=3D sharp_lq_panel_disable,
-	.suspend	=3D sharp_lq_panel_suspend,
-	.resume		=3D sharp_lq_panel_resume,
-
-	.driver         =3D {
-		.name   =3D "sharp_lq_panel",
-		.owner  =3D THIS_MODULE,
-	},
-};
-
-static int __init sharp_lq_panel_drv_init(void)
-{
-	return omap_dss_register_driver(&sharp_lq_driver);
-}
-
-static void __exit sharp_lq_panel_drv_exit(void)
-{
-	omap_dss_unregister_driver(&sharp_lq_driver);
-}
-
-module_init(sharp_lq_panel_drv_init);
-module_exit(sharp_lq_panel_drv_exit);
-MODULE_LICENSE("GPL");
diff --git a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c b/driv=
ers/video/omap2/displays/panel-tpo-td043mtea1.c
deleted file mode 100644
index dbe9d43..0000000
--- a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
+++ /dev/null
@@ -1,535 +0,0 @@
-/*
- * LCD panel driver for TPO TD043MTEA1
- *
- * Author: Gra=C5=BEvydas Ignotas <notasas@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modif=
y
- * it under the terms of the GNU General Public License as published b=
y
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#include <linux/module.h>
-#include <linux/delay.h>
-#include <linux/spi/spi.h>
-#include <linux/regulator/consumer.h>
-#include <linux/gpio.h>
-#include <linux/err.h>
-#include <linux/slab.h>
-
-#include <plat/display.h>
-
-#define TPO_R02_MODE(x)		((x) & 7)
-#define TPO_R02_MODE_800x480	7
-#define TPO_R02_NCLK_RISING	BIT(3)
-#define TPO_R02_HSYNC_HIGH	BIT(4)
-#define TPO_R02_VSYNC_HIGH	BIT(5)
-
-#define TPO_R03_NSTANDBY	BIT(0)
-#define TPO_R03_EN_CP_CLK	BIT(1)
-#define TPO_R03_EN_VGL_PUMP	BIT(2)
-#define TPO_R03_EN_PWM		BIT(3)
-#define TPO_R03_DRIVING_CAP_100	BIT(4)
-#define TPO_R03_EN_PRE_CHARGE	BIT(6)
-#define TPO_R03_SOFTWARE_CTL	BIT(7)
-
-#define TPO_R04_NFLIP_H		BIT(0)
-#define TPO_R04_NFLIP_V		BIT(1)
-#define TPO_R04_CP_CLK_FREQ_1H	BIT(2)
-#define TPO_R04_VGL_FREQ_1H	BIT(4)
-
-#define TPO_R03_VAL_NORMAL (TPO_R03_NSTANDBY | TPO_R03_EN_CP_CLK | \
-			TPO_R03_EN_VGL_PUMP |  TPO_R03_EN_PWM | \
-			TPO_R03_DRIVING_CAP_100 | TPO_R03_EN_PRE_CHARGE | \
-			TPO_R03_SOFTWARE_CTL)
-
-#define TPO_R03_VAL_STANDBY (TPO_R03_DRIVING_CAP_100 | \
-			TPO_R03_EN_PRE_CHARGE | TPO_R03_SOFTWARE_CTL)
-
-static const u16 tpo_td043_def_gamma[12] =3D {
-	106, 200, 289, 375, 460, 543, 625, 705, 785, 864, 942, 1020
-};
-
-struct tpo_td043_device {
-	struct spi_device *spi;
-	struct regulator *vcc_reg;
-	u16 gamma[12];
-	u32 mode;
-	u32 hmirror:1;
-	u32 vmirror:1;
-};
-
-static int tpo_td043_write(struct spi_device *spi, u8 addr, u8 data)
-{
-	struct spi_message	m;
-	struct spi_transfer	xfer;
-	u16			w;
-	int			r;
-
-	spi_message_init(&m);
-
-	memset(&xfer, 0, sizeof(xfer));
-
-	w =3D ((u16)addr << 10) | (1 << 8) | data;
-	xfer.tx_buf =3D &w;
-	xfer.bits_per_word =3D 16;
-	xfer.len =3D 2;
-	spi_message_add_tail(&xfer, &m);
-
-	r =3D spi_sync(spi, &m);
-	if (r < 0)
-		dev_warn(&spi->dev, "failed to write to LCD reg (%d)\n", r);
-	return r;
-}
-
-static void tpo_td043_write_gamma(struct spi_device *spi, u16 gamma[12=
])
-{
-	u8 i, val;
-
-	/* gamma bits [9:8] */
-	for (val =3D i =3D 0; i < 4; i++)
-		val |=3D (gamma[i] & 0x300) >> ((i + 1) * 2);
-	tpo_td043_write(spi, 0x11, val);
-
-	for (val =3D i =3D 0; i < 4; i++)
-		val |=3D (gamma[i+4] & 0x300) >> ((i + 1) * 2);
-	tpo_td043_write(spi, 0x12, val);
-
-	for (val =3D i =3D 0; i < 4; i++)
-		val |=3D (gamma[i+8] & 0x300) >> ((i + 1) * 2);
-	tpo_td043_write(spi, 0x13, val);
-
-	/* gamma bits [7:0] */
-	for (val =3D i =3D 0; i < 12; i++)
-		tpo_td043_write(spi, 0x14 + i, gamma[i] & 0xff);
-}
-
-static int tpo_td043_write_mirror(struct spi_device *spi, bool h, bool=
 v)
-{
-	u8 reg4 =3D TPO_R04_NFLIP_H | TPO_R04_NFLIP_V | \
-		TPO_R04_CP_CLK_FREQ_1H | TPO_R04_VGL_FREQ_1H;
-	if (h)
-		reg4 &=3D ~TPO_R04_NFLIP_H;
-	if (v)
-		reg4 &=3D ~TPO_R04_NFLIP_V;
-
-	return tpo_td043_write(spi, 4, reg4);
-}
-
-static int tpo_td043_set_hmirror(struct omap_dss_device *dssdev, bool =
enable)
-{
-	struct tpo_td043_device *tpo_td043 =3D dev_get_drvdata(&dssdev->dev);
-
-	tpo_td043->hmirror =3D enable;
-	return tpo_td043_write_mirror(tpo_td043->spi, tpo_td043->hmirror,
-			tpo_td043->vmirror);
-}
-
-static bool tpo_td043_get_hmirror(struct omap_dss_device *dssdev)
-{
-	struct tpo_td043_device *tpo_td043 =3D dev_get_drvdata(&dssdev->dev);
-
-	return tpo_td043->hmirror;
-}
-
-static ssize_t tpo_td043_vmirror_show(struct device *dev,
-	struct device_attribute *attr, char *buf)
-{
-	struct tpo_td043_device *tpo_td043 =3D dev_get_drvdata(dev);
-
-	return snprintf(buf, PAGE_SIZE, "%d\n", tpo_td043->vmirror);
-}
-
-static ssize_t tpo_td043_vmirror_store(struct device *dev,
-	struct device_attribute *attr, const char *buf, size_t count)
-{
-	struct tpo_td043_device *tpo_td043 =3D dev_get_drvdata(dev);
-	long val;
-	int ret;
-
-	ret =3D strict_strtol(buf, 0, &val);
-	if (ret < 0)
-		return ret;
-
-	ret =3D tpo_td043_write_mirror(tpo_td043->spi, tpo_td043->hmirror, va=
l);
-	if (ret < 0)
-		return ret;
-
-	tpo_td043->vmirror =3D val;
-
-	return count;
-}
-
-static ssize_t tpo_td043_mode_show(struct device *dev,
-	struct device_attribute *attr, char *buf)
-{
-	struct tpo_td043_device *tpo_td043 =3D dev_get_drvdata(dev);
-
-	return snprintf(buf, PAGE_SIZE, "%d\n", tpo_td043->mode);
-}
-
-static ssize_t tpo_td043_mode_store(struct device *dev,
-	struct device_attribute *attr, const char *buf, size_t count)
-{
-	struct tpo_td043_device *tpo_td043 =3D dev_get_drvdata(dev);
-	long val;
-	int ret;
-
-	ret =3D strict_strtol(buf, 0, &val);
-	if (ret !=3D 0 || val & ~7)
-		return -EINVAL;
-
-	tpo_td043->mode =3D val;
-
-	val |=3D TPO_R02_NCLK_RISING;
-	tpo_td043_write(tpo_td043->spi, 2, val);
-
-	return count;
-}
-
-static ssize_t tpo_td043_gamma_show(struct device *dev,
-	struct device_attribute *attr, char *buf)
-{
-	struct tpo_td043_device *tpo_td043 =3D dev_get_drvdata(dev);
-	ssize_t len =3D 0;
-	int ret;
-	int i;
-
-	for (i =3D 0; i < ARRAY_SIZE(tpo_td043->gamma); i++) {
-		ret =3D snprintf(buf + len, PAGE_SIZE - len, "%u ",
-				tpo_td043->gamma[i]);
-		if (ret < 0)
-			return ret;
-		len +=3D ret;
-	}
-	buf[len - 1] =3D '\n';
-
-	return len;
-}
-
-static ssize_t tpo_td043_gamma_store(struct device *dev,
-	struct device_attribute *attr, const char *buf, size_t count)
-{
-	struct tpo_td043_device *tpo_td043 =3D dev_get_drvdata(dev);
-	unsigned int g[12];
-	int ret;
-	int i;
-
-	ret =3D sscanf(buf, "%u %u %u %u %u %u %u %u %u %u %u %u",
-			&g[0], &g[1], &g[2], &g[3], &g[4], &g[5],
-			&g[6], &g[7], &g[8], &g[9], &g[10], &g[11]);
-
-	if (ret !=3D 12)
-		return -EINVAL;
-
-	for (i =3D 0; i < 12; i++)
-		tpo_td043->gamma[i] =3D g[i];
-
-	tpo_td043_write_gamma(tpo_td043->spi, tpo_td043->gamma);
-
-	return count;
-}
-
-static DEVICE_ATTR(vmirror, S_IRUGO | S_IWUSR,
-		tpo_td043_vmirror_show, tpo_td043_vmirror_store);
-static DEVICE_ATTR(mode, S_IRUGO | S_IWUSR,
-		tpo_td043_mode_show, tpo_td043_mode_store);
-static DEVICE_ATTR(gamma, S_IRUGO | S_IWUSR,
-		tpo_td043_gamma_show, tpo_td043_gamma_store);
-
-static struct attribute *tpo_td043_attrs[] =3D {
-	&dev_attr_vmirror.attr,
-	&dev_attr_mode.attr,
-	&dev_attr_gamma.attr,
-	NULL,
-};
-
-static struct attribute_group tpo_td043_attr_group =3D {
-	.attrs =3D tpo_td043_attrs,
-};
-
-static const struct omap_video_timings tpo_td043_timings =3D {
-	.x_res		=3D 800,
-	.y_res		=3D 480,
-
-	.pixel_clock	=3D 36000,
-
-	.hsw		=3D 1,
-	.hfp		=3D 68,
-	.hbp		=3D 214,
-
-	.vsw		=3D 1,
-	.vfp		=3D 39,
-	.vbp		=3D 34,
-};
-
-static int tpo_td043_power_on(struct omap_dss_device *dssdev)
-{
-	struct tpo_td043_device *tpo_td043 =3D dev_get_drvdata(&dssdev->dev);
-	int nreset_gpio =3D dssdev->reset_gpio;
-	int r;
-
-	if (dssdev->state =3D=3D OMAP_DSS_DISPLAY_ACTIVE)
-		return 0;
-
-	r =3D omapdss_dpi_display_enable(dssdev);
-	if (r)
-		goto err0;
-
-	if (dssdev->platform_enable) {
-		r =3D dssdev->platform_enable(dssdev);
-		if (r)
-			goto err1;
-	}
-
-	regulator_enable(tpo_td043->vcc_reg);
-
-	/* wait for power up */
-	msleep(160);
-
-	if (gpio_is_valid(nreset_gpio))
-		gpio_set_value(nreset_gpio, 1);
-
-	tpo_td043_write(tpo_td043->spi, 2,
-			TPO_R02_MODE(tpo_td043->mode) | TPO_R02_NCLK_RISING);
-	tpo_td043_write(tpo_td043->spi, 3, TPO_R03_VAL_NORMAL);
-	tpo_td043_write(tpo_td043->spi, 0x20, 0xf0);
-	tpo_td043_write(tpo_td043->spi, 0x21, 0xf0);
-	tpo_td043_write_mirror(tpo_td043->spi, tpo_td043->hmirror,
-			tpo_td043->vmirror);
-	tpo_td043_write_gamma(tpo_td043->spi, tpo_td043->gamma);
-
-	return 0;
-err1:
-	omapdss_dpi_display_disable(dssdev);
-err0:
-	return r;
-}
-
-static void tpo_td043_power_off(struct omap_dss_device *dssdev)
-{
-	struct tpo_td043_device *tpo_td043 =3D dev_get_drvdata(&dssdev->dev);
-	int nreset_gpio =3D dssdev->reset_gpio;
-
-	if (dssdev->state !=3D OMAP_DSS_DISPLAY_ACTIVE)
-		return;
-
-	tpo_td043_write(tpo_td043->spi, 3,
-			TPO_R03_VAL_STANDBY | TPO_R03_EN_PWM);
-
-	if (gpio_is_valid(nreset_gpio))
-		gpio_set_value(nreset_gpio, 0);
-
-	/* wait for at least 2 vsyncs before cutting off power */
-	msleep(50);
-
-	tpo_td043_write(tpo_td043->spi, 3, TPO_R03_VAL_STANDBY);
-
-	regulator_disable(tpo_td043->vcc_reg);
-
-	if (dssdev->platform_disable)
-		dssdev->platform_disable(dssdev);
-
-	omapdss_dpi_display_disable(dssdev);
-}
-
-static int tpo_td043_enable(struct omap_dss_device *dssdev)
-{
-	int ret;
-
-	dev_dbg(&dssdev->dev, "enable\n");
-
-	ret =3D tpo_td043_power_on(dssdev);
-	if (ret)
-		return ret;
-
-	dssdev->state =3D OMAP_DSS_DISPLAY_ACTIVE;
-
-	return 0;
-}
-
-static void tpo_td043_disable(struct omap_dss_device *dssdev)
-{
-	dev_dbg(&dssdev->dev, "disable\n");
-
-	tpo_td043_power_off(dssdev);
-
-	dssdev->state =3D OMAP_DSS_DISPLAY_DISABLED;
-}
-
-static int tpo_td043_suspend(struct omap_dss_device *dssdev)
-{
-	tpo_td043_power_off(dssdev);
-	dssdev->state =3D OMAP_DSS_DISPLAY_SUSPENDED;
-	return 0;
-}
-
-static int tpo_td043_resume(struct omap_dss_device *dssdev)
-{
-	int r =3D 0;
-
-	r =3D tpo_td043_power_on(dssdev);
-	if (r)
-		return r;
-
-	dssdev->state =3D OMAP_DSS_DISPLAY_ACTIVE;
-
-	return 0;
-}
-
-static int tpo_td043_probe(struct omap_dss_device *dssdev)
-{
-	struct tpo_td043_device *tpo_td043 =3D dev_get_drvdata(&dssdev->dev);
-	int nreset_gpio =3D dssdev->reset_gpio;
-	int ret =3D 0;
-
-	dev_dbg(&dssdev->dev, "probe\n");
-
-	if (tpo_td043 =3D=3D NULL) {
-		dev_err(&dssdev->dev, "missing tpo_td043_device\n");
-		return -ENODEV;
-	}
-
-	dssdev->panel.config =3D OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IHS |
-				OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IPC;
-	dssdev->panel.timings =3D tpo_td043_timings;
-	dssdev->ctrl.pixel_size =3D 24;
-
-	tpo_td043->mode =3D TPO_R02_MODE_800x480;
-	memcpy(tpo_td043->gamma, tpo_td043_def_gamma, sizeof(tpo_td043->gamma=
));
-
-	tpo_td043->vcc_reg =3D regulator_get(&dssdev->dev, "vcc");
-	if (IS_ERR(tpo_td043->vcc_reg)) {
-		dev_err(&dssdev->dev, "failed to get LCD VCC regulator\n");
-		ret =3D PTR_ERR(tpo_td043->vcc_reg);
-		goto fail_regulator;
-	}
-
-	if (gpio_is_valid(nreset_gpio)) {
-		ret =3D gpio_request(nreset_gpio, "lcd reset");
-		if (ret < 0) {
-			dev_err(&dssdev->dev, "couldn't request reset GPIO\n");
-			goto fail_gpio_req;
-		}
-
-		ret =3D gpio_direction_output(nreset_gpio, 0);
-		if (ret < 0) {
-			dev_err(&dssdev->dev, "couldn't set GPIO direction\n");
-			goto fail_gpio_direction;
-		}
-	}
-
-	ret =3D sysfs_create_group(&dssdev->dev.kobj, &tpo_td043_attr_group);
-	if (ret)
-		dev_warn(&dssdev->dev, "failed to create sysfs files\n");
-
-	return 0;
-
-fail_gpio_direction:
-	gpio_free(nreset_gpio);
-fail_gpio_req:
-	regulator_put(tpo_td043->vcc_reg);
-fail_regulator:
-	kfree(tpo_td043);
-	return ret;
-}
-
-static void tpo_td043_remove(struct omap_dss_device *dssdev)
-{
-	struct tpo_td043_device *tpo_td043 =3D dev_get_drvdata(&dssdev->dev);
-	int nreset_gpio =3D dssdev->reset_gpio;
-
-	dev_dbg(&dssdev->dev, "remove\n");
-
-	sysfs_remove_group(&dssdev->dev.kobj, &tpo_td043_attr_group);
-	regulator_put(tpo_td043->vcc_reg);
-	if (gpio_is_valid(nreset_gpio))
-		gpio_free(nreset_gpio);
-}
-
-static struct omap_dss_driver tpo_td043_driver =3D {
-	.probe		=3D tpo_td043_probe,
-	.remove		=3D tpo_td043_remove,
-
-	.enable		=3D tpo_td043_enable,
-	.disable	=3D tpo_td043_disable,
-	.suspend	=3D tpo_td043_suspend,
-	.resume		=3D tpo_td043_resume,
-	.set_mirror	=3D tpo_td043_set_hmirror,
-	.get_mirror	=3D tpo_td043_get_hmirror,
-
-	.driver         =3D {
-		.name	=3D "tpo_td043mtea1_panel",
-		.owner  =3D THIS_MODULE,
-	},
-};
-
-static int tpo_td043_spi_probe(struct spi_device *spi)
-{
-	struct omap_dss_device *dssdev =3D spi->dev.platform_data;
-	struct tpo_td043_device *tpo_td043;
-	int ret;
-
-	if (dssdev =3D=3D NULL) {
-		dev_err(&spi->dev, "missing dssdev\n");
-		return -ENODEV;
-	}
-
-	spi->bits_per_word =3D 16;
-	spi->mode =3D SPI_MODE_0;
-
-	ret =3D spi_setup(spi);
-	if (ret < 0) {
-		dev_err(&spi->dev, "spi_setup failed: %d\n", ret);
-		return ret;
-	}
-
-	tpo_td043 =3D kzalloc(sizeof(*tpo_td043), GFP_KERNEL);
-	if (tpo_td043 =3D=3D NULL)
-		return -ENOMEM;
-
-	tpo_td043->spi =3D spi;
-	dev_set_drvdata(&spi->dev, tpo_td043);
-	dev_set_drvdata(&dssdev->dev, tpo_td043);
-
-	omap_dss_register_driver(&tpo_td043_driver);
-
-	return 0;
-}
-
-static int __devexit tpo_td043_spi_remove(struct spi_device *spi)
-{
-	struct tpo_td043_device *tpo_td043 =3D dev_get_drvdata(&spi->dev);
-
-	omap_dss_unregister_driver(&tpo_td043_driver);
-	kfree(tpo_td043);
-
-	return 0;
-}
-
-static struct spi_driver tpo_td043_spi_driver =3D {
-	.driver =3D {
-		.name	=3D "tpo_td043mtea1_panel_spi",
-		.bus	=3D &spi_bus_type,
-		.owner	=3D THIS_MODULE,
-	},
-	.probe	=3D tpo_td043_spi_probe,
-	.remove	=3D __devexit_p(tpo_td043_spi_remove),
-};
-
-static int __init tpo_td043_init(void)
-{
-	return spi_register_driver(&tpo_td043_spi_driver);
-}
-
-static void __exit tpo_td043_exit(void)
-{
-	spi_unregister_driver(&tpo_td043_spi_driver);
-}
-
-module_init(tpo_td043_init);
-module_exit(tpo_td043_exit);
-
-MODULE_AUTHOR("Gra=C5=BEvydas Ignotas <notasas@gmail.com>");
-MODULE_DESCRIPTION("TPO TD043MTEA1 LCD Driver");
-MODULE_LICENSE("GPL");
--=20
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
