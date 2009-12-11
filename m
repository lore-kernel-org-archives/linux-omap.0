From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] OMAP: DSS: add TPO TD043MTEA1 panel
Date: Fri, 11 Dec 2009 21:30:14 +0200
Message-ID: <1260559814-25075-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:45159 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761018AbZLKTaZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 14:30:25 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>

Add support of TPO TD043MTEA1 TFT LCD panel to DSS2 driver.
This panel is used by OMAP3 Pandora device.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/video/omap2/displays/Kconfig               |    6 +
 drivers/video/omap2/displays/Makefile              |    1 +
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |  489 ++++++++++++=
++++++++
 3 files changed, 496 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/omap2/displays/panel-tpo-td043mtea1.c

diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2=
/displays/Kconfig
index b12a59c..a1d0ce4 100644
--- a/drivers/video/omap2/displays/Kconfig
+++ b/drivers/video/omap2/displays/Kconfig
@@ -19,4 +19,10 @@ config PANEL_TAAL
         help
           Taal DSI command mode panel from TPO.
=20
+config PANEL_TPO_TD043MTEA1
+        tristate "TPO TD043MTEA1 LCD Panel"
+        depends on OMAP2_DSS && I2C
+        help
+          LCD Panel used in OMAP3 Pandora
+
 endmenu
diff --git a/drivers/video/omap2/displays/Makefile b/drivers/video/omap=
2/displays/Makefile
index 9556464..143a717 100644
--- a/drivers/video/omap2/displays/Makefile
+++ b/drivers/video/omap2/displays/Makefile
@@ -2,3 +2,4 @@ obj-$(CONFIG_PANEL_GENERIC) +=3D panel-generic.o
 obj-$(CONFIG_PANEL_SHARP_LS037V7DW01) +=3D panel-sharp-ls037v7dw01.o
=20
 obj-$(CONFIG_PANEL_TAAL) +=3D panel-taal.o
+obj-$(CONFIG_PANEL_TPO_TD043MTEA1) +=3D panel-tpo-td043mtea1.o
diff --git a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c b/driv=
ers/video/omap2/displays/panel-tpo-td043mtea1.c
new file mode 100644
index 0000000..f297a46
--- /dev/null
+++ b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
@@ -0,0 +1,489 @@
+/*
+ * LCD panel driver for TPO TD043MTEA1
+ *
+ * Author: Gra=C5=BEvydas Ignotas <notasas@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License as published b=
y
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/spi/spi.h>
+#include <linux/regulator/consumer.h>
+#include <linux/gpio.h>
+#include <linux/err.h>
+
+#include <plat/display.h>
+
+#define TPO_R02_MODE(x)		((x) & 7)
+#define TPO_R02_MODE_800x480	7
+#define TPO_R02_NCLK_RISING	BIT(3)
+#define TPO_R02_HSYNC_HIGH	BIT(4)
+#define TPO_R02_VSYNC_HIGH	BIT(5)
+
+#define TPO_R03_NSTANDBY	BIT(0)
+#define TPO_R03_EN_CP_CLK	BIT(1)
+#define TPO_R03_EN_VGL_PUMP	BIT(2)
+#define TPO_R03_EN_PWM		BIT(3)
+#define TPO_R03_DRIVING_CAP_100	BIT(4)
+#define TPO_R03_EN_PRE_CHARGE	BIT(6)
+#define TPO_R03_SOFTWARE_CTL	BIT(7)
+
+#define TPO_R04_NFLIP_H		BIT(0)
+#define TPO_R04_NFLIP_V		BIT(1)
+#define TPO_R04_CP_CLK_FREQ_1H	BIT(2)
+#define TPO_R04_VGL_FREQ_1H	BIT(4)
+
+#define TPO_R03_VAL_NORMAL (TPO_R03_NSTANDBY | TPO_R03_EN_CP_CLK | \
+			TPO_R03_EN_VGL_PUMP |  TPO_R03_EN_PWM | \
+			TPO_R03_DRIVING_CAP_100 | TPO_R03_EN_PRE_CHARGE | \
+			TPO_R03_SOFTWARE_CTL)
+
+#define TPO_R03_VAL_STANDBY (TPO_R03_DRIVING_CAP_100 | \
+			TPO_R03_EN_PRE_CHARGE | TPO_R03_SOFTWARE_CTL)
+
+static const u16 tpo_td043_def_gamma[12] =3D {
+	106, 200, 289, 375, 460, 543, 625, 705, 785, 864, 942, 1020
+};
+
+struct tpo_td043_device {
+	struct spi_device *spi;
+	struct regulator *vcc_reg;
+	u16 gamma[12];
+	u32 mode;
+	u32 hmirror:1;
+	u32 vmirror:1;
+};
+
+static int tpo_td043_write(struct spi_device *spi, u8 addr, u8 data)
+{
+	struct spi_message	m;
+	struct spi_transfer	xfer;
+	u16			w;
+	int			r;
+
+	spi_message_init(&m);
+
+	memset(&xfer, 0, sizeof(xfer));
+
+	w =3D ((u16)addr << 10) | (1 << 8) | data;
+	xfer.tx_buf =3D &w;
+	xfer.bits_per_word =3D 16;
+	xfer.len =3D 2;
+	spi_message_add_tail(&xfer, &m);
+
+	r =3D spi_sync(spi, &m);
+	if (r < 0)
+		dev_warn(&spi->dev, "failed to write to LCD reg (%d)\n", r);
+	return r;
+}
+
+static void tpo_td043_write_gamma(struct spi_device *spi, u16 gamma[12=
])
+{
+	u8 i, val;
+
+	/* gamma bits [9:8] */
+	for (val =3D i =3D 0; i < 4; i++)
+		val |=3D (gamma[i] & 0x300) >> ((i + 1) * 2);
+	tpo_td043_write(spi, 0x11, val);
+
+	for (val =3D i =3D 0; i < 4; i++)
+		val |=3D (gamma[i+4] & 0x300) >> ((i + 1) * 2);
+	tpo_td043_write(spi, 0x12, val);
+
+	for (val =3D i =3D 0; i < 4; i++)
+		val |=3D (gamma[i+8] & 0x300) >> ((i + 1) * 2);
+	tpo_td043_write(spi, 0x13, val);
+
+	/* gamma bits [7:0] */
+	for (val =3D i =3D 0; i < 12; i++)
+		tpo_td043_write(spi, 0x14 + i, gamma[i] & 0xff);
+}
+
+static int tpo_td043_write_mirror(struct spi_device *spi, bool h, bool=
 v)
+{
+	u8 reg4 =3D TPO_R04_NFLIP_H | TPO_R04_NFLIP_V | \
+		TPO_R04_CP_CLK_FREQ_1H | TPO_R04_VGL_FREQ_1H;
+	if (h)
+		reg4 &=3D ~TPO_R04_NFLIP_H;
+	if (v)
+		reg4 &=3D ~TPO_R04_NFLIP_V;
+
+	return tpo_td043_write(spi, 4, reg4);
+}
+
+static int tpo_td043_set_hmirror(struct omap_dss_device *dssdev, bool =
enable)
+{
+	struct tpo_td043_device *tpo_td043 =3D dev_get_drvdata(&dssdev->dev);
+
+	tpo_td043->hmirror =3D enable;
+	return tpo_td043_write_mirror(tpo_td043->spi, tpo_td043->hmirror,
+			tpo_td043->vmirror);
+}
+
+static bool tpo_td043_get_hmirror(struct omap_dss_device *dssdev)
+{
+	struct tpo_td043_device *tpo_td043 =3D dev_get_drvdata(&dssdev->dev);
+
+	return tpo_td043->hmirror;
+}
+
+static ssize_t tpo_td043_vmirror_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct tpo_td043_device *tpo_td043 =3D dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", tpo_td043->vmirror);
+}
+
+static ssize_t tpo_td043_vmirror_store(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct tpo_td043_device *tpo_td043 =3D dev_get_drvdata(dev);
+	long val;
+	int ret;
+
+	ret =3D strict_strtol(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	ret =3D tpo_td043_write_mirror(tpo_td043->spi, tpo_td043->hmirror, va=
l);
+	if (ret < 0)
+		return ret;
+
+	tpo_td043->vmirror =3D val;
+
+	return count;
+}
+
+static ssize_t tpo_td043_mode_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct tpo_td043_device *tpo_td043 =3D dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", tpo_td043->mode);
+}
+
+static ssize_t tpo_td043_mode_store(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct tpo_td043_device *tpo_td043 =3D dev_get_drvdata(dev);
+	long val;
+	int ret;
+
+	ret =3D strict_strtol(buf, 0, &val);
+	if (ret !=3D 0 || val & ~7)
+		return -EINVAL;
+
+	tpo_td043->mode =3D val;
+
+	val |=3D TPO_R02_NCLK_RISING;
+	tpo_td043_write(tpo_td043->spi, 2, val);
+
+	return count;
+}
+
+static ssize_t tpo_td043_gamma_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct tpo_td043_device *tpo_td043 =3D dev_get_drvdata(dev);
+	ssize_t len =3D 0;
+	int ret;
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(tpo_td043->gamma); i++) {
+		ret =3D snprintf(buf + len, PAGE_SIZE - len, "%u ",
+				tpo_td043->gamma[i]);
+		if (ret < 0)
+			return ret;
+		len +=3D ret;
+	}
+	buf[len - 1] =3D '\n';
+
+	return len;
+}
+
+static ssize_t tpo_td043_gamma_store(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct tpo_td043_device *tpo_td043 =3D dev_get_drvdata(dev);
+	unsigned int g[12];
+	int ret;
+	int i;
+
+	ret =3D sscanf(buf, "%u %u %u %u %u %u %u %u %u %u %u %u",
+			&g[0], &g[1], &g[2], &g[3], &g[4], &g[5],
+			&g[6], &g[7], &g[8], &g[9], &g[10], &g[11]);
+
+	if (ret !=3D 12)
+		return -EINVAL;
+
+	for (i =3D 0; i < 12; i++)
+		tpo_td043->gamma[i] =3D g[i];
+
+	tpo_td043_write_gamma(tpo_td043->spi, tpo_td043->gamma);
+
+	return count;
+}
+
+static DEVICE_ATTR(vmirror, S_IRUGO | S_IWUSR,
+		tpo_td043_vmirror_show, tpo_td043_vmirror_store);
+static DEVICE_ATTR(mode, S_IRUGO | S_IWUSR,
+		tpo_td043_mode_show, tpo_td043_mode_store);
+static DEVICE_ATTR(gamma, S_IRUGO | S_IWUSR,
+		tpo_td043_gamma_show, tpo_td043_gamma_store);
+
+static struct attribute *tpo_td043_attrs[] =3D {
+	&dev_attr_vmirror.attr,
+	&dev_attr_mode.attr,
+	&dev_attr_gamma.attr,
+	NULL,
+};
+
+static struct attribute_group tpo_td043_attr_group =3D {
+	.attrs =3D tpo_td043_attrs,
+};
+
+static const struct omap_video_timings tpo_td043_timings =3D {
+	.x_res		=3D 800,
+	.y_res		=3D 480,
+
+	.pixel_clock	=3D 36000,
+
+	.hsw		=3D 1,
+	.hfp		=3D 68,
+	.hbp		=3D 214,
+
+	.vsw		=3D 1,
+	.vfp		=3D 39,
+	.vbp		=3D 34,
+};
+
+static int tpo_td043_enable(struct omap_dss_device *dssdev)
+{
+	struct tpo_td043_device *tpo_td043 =3D dev_get_drvdata(&dssdev->dev);
+	int nreset_gpio =3D dssdev->reset_gpio;
+	int ret;
+
+	dev_dbg(&dssdev->dev, "enable\n");
+
+	if (dssdev->platform_enable) {
+		ret =3D dssdev->platform_enable(dssdev);
+		if (ret)
+			return ret;
+	}
+
+	regulator_enable(tpo_td043->vcc_reg);
+
+	/* wait for power up */
+	msleep(160);
+
+	if (gpio_is_valid(nreset_gpio))
+		gpio_set_value(nreset_gpio, 1);
+
+	tpo_td043_write(tpo_td043->spi, 2,
+			TPO_R02_MODE(tpo_td043->mode) | TPO_R02_NCLK_RISING);
+	tpo_td043_write(tpo_td043->spi, 3, TPO_R03_VAL_NORMAL);
+	tpo_td043_write(tpo_td043->spi, 0x20, 0xf0);
+	tpo_td043_write(tpo_td043->spi, 0x21, 0xf0);
+	tpo_td043_write_mirror(tpo_td043->spi, tpo_td043->hmirror,
+			tpo_td043->vmirror);
+	tpo_td043_write_gamma(tpo_td043->spi, tpo_td043->gamma);
+
+	return 0;
+}
+
+static void tpo_td043_disable(struct omap_dss_device *dssdev)
+{
+	struct tpo_td043_device *tpo_td043 =3D dev_get_drvdata(&dssdev->dev);
+	int nreset_gpio =3D dssdev->reset_gpio;
+
+	dev_dbg(&dssdev->dev, "disable\n");
+
+	tpo_td043_write(tpo_td043->spi, 3,
+			TPO_R03_VAL_STANDBY | TPO_R03_EN_PWM);
+
+	if (gpio_is_valid(nreset_gpio))
+		gpio_set_value(nreset_gpio, 0);
+
+	/* wait for at least 2 vsyncs before cutting off power */
+	msleep(50);
+
+	tpo_td043_write(tpo_td043->spi, 3, TPO_R03_VAL_STANDBY);
+
+	regulator_disable(tpo_td043->vcc_reg);
+
+	if (dssdev->platform_disable)
+		dssdev->platform_disable(dssdev);
+}
+
+static int tpo_td043_suspend(struct omap_dss_device *dssdev)
+{
+	tpo_td043_disable(dssdev);
+	return 0;
+}
+
+static int tpo_td043_resume(struct omap_dss_device *dssdev)
+{
+	return tpo_td043_enable(dssdev);
+}
+
+static int tpo_td043_probe(struct omap_dss_device *dssdev)
+{
+	struct tpo_td043_device *tpo_td043 =3D dev_get_drvdata(&dssdev->dev);
+	int nreset_gpio =3D dssdev->reset_gpio;
+	int ret =3D 0;
+
+	dev_dbg(&dssdev->dev, "probe\n");
+
+	if (tpo_td043 =3D=3D NULL) {
+		dev_err(&dssdev->dev, "missing tpo_td043_device\n");
+		return -ENODEV;
+	}
+
+	dssdev->panel.config =3D OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IHS |
+				OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IPC;
+	dssdev->panel.timings =3D tpo_td043_timings;
+	dssdev->ctrl.pixel_size =3D 24;
+
+	tpo_td043->mode =3D TPO_R02_MODE_800x480;
+	memcpy(tpo_td043->gamma, tpo_td043_def_gamma, sizeof(tpo_td043->gamma=
));
+
+	tpo_td043->vcc_reg =3D regulator_get(&dssdev->dev, "vcc");
+	if (IS_ERR(tpo_td043->vcc_reg)) {
+		dev_err(&dssdev->dev, "failed to get LCD VCC regulator\n");
+		ret =3D PTR_ERR(tpo_td043->vcc_reg);
+		goto fail_regulator;
+	}
+
+	if (gpio_is_valid(nreset_gpio)) {
+		ret =3D gpio_request(nreset_gpio, "lcd reset");
+		if (ret < 0) {
+			dev_err(&dssdev->dev, "couldn't request reset GPIO\n");
+			goto fail_gpio_req;
+		}
+
+		ret =3D gpio_direction_output(nreset_gpio, 0);
+		if (ret < 0) {
+			dev_err(&dssdev->dev, "couldn't set GPIO direction\n");
+			goto fail_gpio_direction;
+		}
+	}
+
+	ret =3D sysfs_create_group(&dssdev->dev.kobj, &tpo_td043_attr_group);
+	if (ret)
+		dev_warn(&dssdev->dev, "failed to create sysfs files\n");
+
+	return 0;
+
+fail_gpio_direction:
+	gpio_free(nreset_gpio);
+fail_gpio_req:
+	regulator_put(tpo_td043->vcc_reg);
+fail_regulator:
+	kfree(tpo_td043);
+	return ret;
+}
+
+static void tpo_td043_remove(struct omap_dss_device *dssdev)
+{
+	struct tpo_td043_device *tpo_td043 =3D dev_get_drvdata(&dssdev->dev);
+	int nreset_gpio =3D dssdev->reset_gpio;
+
+	dev_dbg(&dssdev->dev, "remove\n");
+
+	sysfs_remove_group(&dssdev->dev.kobj, &tpo_td043_attr_group);
+	regulator_put(tpo_td043->vcc_reg);
+	if (gpio_is_valid(nreset_gpio))
+		gpio_free(nreset_gpio);
+}
+
+static struct omap_dss_driver tpo_td043_driver =3D {
+	.probe		=3D tpo_td043_probe,
+	.remove		=3D tpo_td043_remove,
+
+	.enable		=3D tpo_td043_enable,
+	.disable	=3D tpo_td043_disable,
+	.suspend	=3D tpo_td043_suspend,
+	.resume		=3D tpo_td043_resume,
+	.set_mirror	=3D tpo_td043_set_hmirror,
+	.get_mirror	=3D tpo_td043_get_hmirror,
+
+	.driver         =3D {
+		.name	=3D "tpo_td043mtea1_panel",
+		.owner  =3D THIS_MODULE,
+	},
+};
+
+static int tpo_td043_spi_probe(struct spi_device *spi)
+{
+	struct omap_dss_device *dssdev =3D spi->dev.platform_data;
+	struct tpo_td043_device *tpo_td043;
+	int ret;
+
+	if (dssdev =3D=3D NULL) {
+		dev_err(&spi->dev, "missing dssdev\n");
+		return -ENODEV;
+	}
+
+	spi->bits_per_word =3D 16;
+	spi->mode =3D SPI_MODE_0;
+
+	ret =3D spi_setup(spi);
+	if (ret < 0) {
+		dev_err(&spi->dev, "spi_setup failed: %d\n", ret);
+		return ret;
+	}
+
+	tpo_td043 =3D kzalloc(sizeof(*tpo_td043), GFP_KERNEL);
+	if (tpo_td043 =3D=3D NULL)
+		return -ENOMEM;
+
+	tpo_td043->spi =3D spi;
+	dev_set_drvdata(&spi->dev, tpo_td043);
+	dev_set_drvdata(&dssdev->dev, tpo_td043);
+
+	omap_dss_register_driver(&tpo_td043_driver);
+
+	return 0;
+}
+
+static int __devexit tpo_td043_spi_remove(struct spi_device *spi)
+{
+	struct tpo_td043_device *tpo_td043 =3D dev_get_drvdata(&spi->dev);
+
+	omap_dss_unregister_driver(&tpo_td043_driver);
+	kfree(tpo_td043);
+
+	return 0;
+}
+
+static struct spi_driver tpo_td043_spi_driver =3D {
+	.driver =3D {
+		.name	=3D "tpo_td043mtea1_panel_spi",
+		.bus	=3D &spi_bus_type,
+		.owner	=3D THIS_MODULE,
+	},
+	.probe	=3D tpo_td043_spi_probe,
+	.remove	=3D __devexit_p(tpo_td043_spi_remove),
+};
+
+static int __init tpo_td043_init(void)
+{
+	return spi_register_driver(&tpo_td043_spi_driver);
+}
+
+static void __exit tpo_td043_exit(void)
+{
+	spi_unregister_driver(&tpo_td043_spi_driver);
+}
+
+module_init(tpo_td043_init);
+module_exit(tpo_td043_exit);
+
+MODULE_AUTHOR("Gra=C5=BEvydas Ignotas <notasas@gmail.com>");
+MODULE_DESCRIPTION("TPO TD043MTEA1 LCD Driver");
+MODULE_LICENSE("GPL");
--=20
1.6.3.3

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
