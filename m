From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 14/33] add tsc210x touchscreen driver
Date: Sat, 30 Aug 2008 20:16:14 +0300
Message-ID: <1220116593-862-15-git-send-email-me@felipebalbi.com>
References: <1220116593-862-1-git-send-email-me@felipebalbi.com>
 <1220116593-862-2-git-send-email-me@felipebalbi.com>
 <1220116593-862-3-git-send-email-me@felipebalbi.com>
 <1220116593-862-4-git-send-email-me@felipebalbi.com>
 <1220116593-862-5-git-send-email-me@felipebalbi.com>
 <1220116593-862-6-git-send-email-me@felipebalbi.com>
 <1220116593-862-7-git-send-email-me@felipebalbi.com>
 <1220116593-862-8-git-send-email-me@felipebalbi.com>
 <1220116593-862-9-git-send-email-me@felipebalbi.com>
 <1220116593-862-10-git-send-email-me@felipebalbi.com>
 <1220116593-862-11-git-send-email-me@felipebalbi.com>
 <1220116593-862-12-git-send-email-me@felipebalbi.com>
 <1220116593-862-13-git-send-email-me@felipebalbi.com>
 <1220116593-862-14-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:36321 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917AbYH3RT5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Aug 2008 13:19:57 -0400
In-Reply-To: <1220116593-862-14-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/input/touchscreen/Kconfig      |   14 ++
 drivers/input/touchscreen/Makefile     |    1 +
 drivers/input/touchscreen/tsc210x_ts.c |  160 ++++++++++++++++++++++
 include/linux/spi/tsc210x.h            |  231 ++++++++++++++++++++++++++++++++
 4 files changed, 406 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/touchscreen/tsc210x_ts.c
 create mode 100644 include/linux/spi/tsc210x.h

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index a115f38..f45cdac 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -222,6 +222,20 @@ config TOUCHSCREEN_TSC2005
 	help
 	  Say Y here for if you are using the touchscreen features of TSC2301.
 
+config TOUCHSCREEN_TSC210X
+	tristate "TI TSC210x based touchscreens"
+	depends on SPI_MASTER
+	select SPI_TSC210X
+	help
+	  Say Y here if you have a touchscreen interface using a
+	  TI TSC210x controller, and your board-specific initialisation
+	  code includes that in its table of SPI devices.
+
+	  If unsure, say N (but it's safe to say "Y").
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called tsc210x_ts.
+
 config TOUCHSCREEN_UCB1400
 	tristate "Philips UCB1400 touchscreen"
 	select AC97_BUS
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index e0bc8fb..411c44a 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_TOUCHSCREEN_TOUCHWIN)	+= touchwin.o
 obj-$(CONFIG_TOUCHSCREEN_UCB1400)	+= ucb1400_ts.o
 obj-$(CONFIG_TOUCHSCREEN_TSC2005)	+= tsc2005.o
 obj-$(CONFIG_TOUCHSCREEN_OMAP)	+= omap/
+obj-$(CONFIG_TOUCHSCREEN_TSC210X)	+= tsc210x_ts.o
 obj-$(CONFIG_TOUCHSCREEN_WM97XX)	+= wm97xx-ts.o
 wm97xx-ts-$(CONFIG_TOUCHSCREEN_WM9705)	+= wm9705.o
 wm97xx-ts-$(CONFIG_TOUCHSCREEN_WM9712)	+= wm9712.o
diff --git a/drivers/input/touchscreen/tsc210x_ts.c b/drivers/input/touchscreen/tsc210x_ts.c
new file mode 100644
index 0000000..5828b6d
--- /dev/null
+++ b/drivers/input/touchscreen/tsc210x_ts.c
@@ -0,0 +1,160 @@
+/*
+ * tsc210x_ts.c - touchscreen input device for TI TSC210x chips
+ *
+ * Copyright (c) 2006-2007 Andrzej Zaborowski  <balrog@zabor.org>
+ *
+ * This package is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This package is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this package; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/input.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+
+#include <linux/spi/tsc210x.h>
+
+
+/*
+ * The sensor ADC on tsc210x chips is most often used with the smart
+ * touchscreen controller.   Those controllers can be made to improve
+ * sample quality directly by multi-sampling and by taking the mean or
+ * median of various numbers of samples.  They also take X, Y, and
+ * pressure measurements automatically, so this driver has relatively
+ * little to do.
+ *
+ * There are a few chips in this family that don't have quite the same
+ * touchscreen interface, e.g. no "median" mode.
+ */
+
+static void tsc210x_touch(void *context, int touching)
+{
+	struct input_dev *dev = context;
+
+	if (!touching) {
+		input_report_abs(dev, ABS_X, 0);
+		input_report_abs(dev, ABS_Y, 0);
+		input_report_abs(dev, ABS_PRESSURE, 0);
+		input_sync(dev);
+	}
+
+	input_report_key(dev, BTN_TOUCH, touching);
+}
+
+static void tsc210x_coords(void *context, int x, int y, int z1, int z2)
+{
+	struct input_dev *dev = context;
+	int p;
+
+	/* Calculate the touch resistance a la equation #1 */
+	if (z1 != 0)
+		p = x * (z2 - z1) / (z1 << 4);
+	else
+		p = 1;
+
+	input_report_abs(dev, ABS_X, x);
+	input_report_abs(dev, ABS_Y, y);
+	input_report_abs(dev, ABS_PRESSURE, p);
+	input_sync(dev);
+}
+
+static int tsc210x_ts_probe(struct platform_device *pdev)
+{
+	int status;
+	struct input_dev *dev;
+
+	dev = input_allocate_device();
+	if (!dev)
+		return -ENOMEM;
+
+	status = tsc210x_touch_cb(pdev->dev.parent, tsc210x_touch, dev);
+	if (status) {
+		input_free_device(dev);
+		return status;
+	}
+
+	status = tsc210x_coords_cb(pdev->dev.parent, tsc210x_coords, dev);
+	if (status) {
+		tsc210x_touch_cb(pdev->dev.parent, NULL, NULL);
+		input_free_device(dev);
+		return status;
+	}
+
+	dev->name = "TSC210x Touchscreen";
+	dev->dev.parent = &pdev->dev;
+	dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
+	dev->keybit[BIT_WORD(BTN_TOUCH)] |= BIT_MASK(BTN_TOUCH);
+	dev->absbit[0] = BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE);
+	dev->phys = "tsc210x/input0";
+	dev->id.bustype = BUS_HOST;
+	dev->id.vendor = 0x0001;
+	dev->id.product = 0x2100;
+	dev->id.version = 0x0001;
+
+	status = input_register_device(dev);
+	if (status) {
+		tsc210x_coords_cb(pdev->dev.parent, NULL, NULL);
+		tsc210x_touch_cb(pdev->dev.parent, NULL, NULL);
+		input_free_device(dev);
+		return status;
+	}
+
+	platform_set_drvdata(pdev, dev);
+	printk(KERN_INFO "TSC210x touchscreen initialised\n");
+	return 0;
+}
+
+static int __exit tsc210x_ts_remove(struct platform_device *pdev)
+{
+	struct input_dev *dev = platform_get_drvdata(pdev);
+
+	tsc210x_touch_cb(pdev->dev.parent, NULL, NULL);
+	tsc210x_coords_cb(pdev->dev.parent, NULL, NULL);
+	platform_set_drvdata(pdev, NULL);
+	input_unregister_device(dev);
+	input_free_device(dev);
+
+	return 0;
+}
+
+static struct platform_driver tsc210x_ts_driver = {
+	.probe		= tsc210x_ts_probe,
+	.remove		= __exit_p(tsc210x_ts_remove),
+	/* Nothing to do on suspend/resume */
+	.driver		= {
+		.name	= "tsc210x-ts",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init tsc210x_ts_init(void)
+{
+	/* can't use driver_probe() here since the parent device
+	 * gets registered "late"
+	 */
+	return platform_driver_register(&tsc210x_ts_driver);
+}
+module_init(tsc210x_ts_init);
+
+static void __exit tsc210x_ts_exit(void)
+{
+	platform_driver_unregister(&tsc210x_ts_driver);
+}
+module_exit(tsc210x_ts_exit);
+
+MODULE_AUTHOR("Andrzej Zaborowski");
+MODULE_DESCRIPTION("Touchscreen input driver for TI TSC2101/2102.");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/spi/tsc210x.h b/include/linux/spi/tsc210x.h
new file mode 100644
index 0000000..b1a9ae6
--- /dev/null
+++ b/include/linux/spi/tsc210x.h
@@ -0,0 +1,231 @@
+/*
+ * include/linux/spi/tsc2102.h
+ *
+ * TI TSC2101/2102 control register definitions.
+ *
+ * Copyright (c) 2005-2007 Andrzej Zaborowski  <balrog@zabor.org>
+ *
+ * This package is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This package is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this package; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef __LINUX_SPI_TSC210X_H
+#define __LINUX_SPI_TSC210X_H
+
+struct apm_power_info;
+
+struct tsc210x_config {
+	int use_internal;	/* Use internal reference voltage */
+	u32 monitor;		/* What inputs are wired on this board */
+	int temp_at25c[2];	/* Thermometer calibration data */
+	void (*apm_report)(struct apm_power_info *info, int battery[]);
+				/* Report status to APM based on battery[] */
+	void *alsa_config;	/* .platform_data for the ALSA device */
+	const char *mclk;	/* Optional: mclk name */
+	const char *bclk;	/* Optional: bclk name */
+};
+
+#define TSC_BAT1	(1 << 0)
+#define TSC_BAT2	(1 << 1)
+#define TSC_AUX1	(1 << 2)
+#define TSC_AUX2	(1 << 3)
+#define TSC_TEMP	(1 << 4)
+
+#define TSC_AUX		TSC_AUX1
+#define TSC_VBAT	TSC_BAT1
+
+struct tsc210x_dev;
+
+/* Drivers for tsc210x components like touchscreen, sensor, and audio
+ * are packaged as platform drivers which can issue synchronous register
+ * acceses, and may also register a callback to process their particular
+ * type of data when that data is automatically sampled.  The platform
+ * device is a child of the TSC spi device.
+ */
+
+extern int tsc210x_read_sync(struct tsc210x_dev *dev, int page, u8 address);
+extern int tsc210x_reads_sync(struct tsc210x_dev *dev, int page,
+		u8 startaddress, u16 *data, int numregs);
+extern int tsc210x_write_sync(struct tsc210x_dev *dev, int page,
+		u8 address, u16 data);
+
+typedef void (*tsc210x_touch_t)(void *context, int touching);
+typedef void (*tsc210x_coords_t)(void *context, int x, int y, int z1, int z2);
+typedef void (*tsc210x_ports_t)(void *context, int bat[], int aux[]);
+typedef void (*tsc210x_temp_t)(void *context, int temp);
+
+extern int tsc210x_touch_cb(struct device *dev,
+		tsc210x_touch_t handler, void *context);
+extern int tsc210x_coords_cb(struct device *dev,
+		tsc210x_coords_t handler, void *context);
+extern int tsc210x_ports_cb(struct device *dev,
+		tsc210x_ports_t handler, void *context);
+extern int tsc210x_temp1_cb(struct device *dev,
+		tsc210x_temp_t handler, void *context);
+extern int tsc210x_temp2_cb(struct device *dev,
+		tsc210x_temp_t handler, void *context);
+
+#if defined(CONFIG_SOUND) || defined(CONFIG_SOUND_MODULE)
+extern void tsc210x_set_dac_volume(struct device *dev, u8 left, u8 right);
+extern void tsc210x_set_dac_mute(struct device *dev, int left, int right);
+extern void tsc210x_get_dac_mute(struct device *dev, int *left, int *right);
+extern void tsc210x_dac_power(struct device *dev, int on);
+extern int tsc210x_set_rate(struct device *dev, int rate);
+extern void tsc210x_set_i2s_master(struct device *dev, int state);
+extern void tsc210x_set_deemphasis(struct device *dev, int enable);
+extern void tsc2102_set_bassboost(struct device *dev, int enable);
+#endif
+
+/*
+ * Emit a short keyclick typically in order to give feedback to
+ * user on specific events.
+ *
+ * amplitude must be between 0 (lowest) and 2 (highest).
+ * freq must be between 0 (corresponds to 62.5 Hz) and 7 (8 kHz).
+ * length should be between 2 and 32 periods.
+ *
+ * This function sleeps but for a period unrelated to the length of
+ * the sound, i.e. returning doesn't indicate that the sound has
+ * finished.
+ */
+extern void tsc210x_keyclick(struct tsc210x_dev *dev,
+		int amplitude, int freq, int length);
+
+/* Page 0, Touch Screen & Keypad Data registers */
+#define TSC210X_TS_X			0, 0x00
+#define TSC210X_TS_Y			0, 0x01
+#define TSC210X_TS_Z1			0, 0x02
+#define TSC210X_TS_Z2			0, 0x03
+#define TSC210X_TS_BAT1			0, 0x05
+#define TSC2102_TS_BAT2			0, 0x06
+#define TSC210X_TS_AUX1			0, 0x07
+#define TSC2101_TS_AUX2			0, 0x08
+#define TSC210X_TS_TEMP1		0, 0x09
+#define TSC210X_TS_TEMP2		0, 0x0a
+
+/* Page 1, Touch Screen & Keypad Control registers */
+#define TSC210X_TS_ADC_CTRL		1, 0x00
+#define TSC210X_TS_STATUS_CTRL		1, 0x01
+#define TSC2101_TS_BUFFER_CTRL		1, 0x02
+#define TSC210X_TS_REF_CTRL		1, 0x03
+#define TSC210X_TS_RESET_CTRL		1, 0x04
+#define TSC210X_TS_CONFIG_CTRL		1, 0x05
+#define TSC2101_TS_TEMPMAX_CTRL		1, 0x06
+#define TSC2101_TS_TEMPMIN_CTRL		1, 0x07
+#define TSC2101_TS_AUX1MAX_CTRL		1, 0x08
+#define TSC2101_TS_AUX1MIN_CTRL		1, 0x09
+#define TSC2101_TS_AUX2MAX_CTRL		1, 0x0a
+#define TSC2101_TS_AUX2MIN_CTRL		1, 0x0b
+#define TSC2101_TS_MCONFIG_CTRL		1, 0x0c
+#define TSC2101_TS_DELAY_CTRL		1, 0x0d
+
+/* Page 2, Audio Control registers */
+#define TSC210X_AUDIO1_CTRL		2, 0x00
+#define TSC2101_HEADSET_GAIN_CTRL	2, 0x01
+#define TSC210X_DAC_GAIN_CTRL		2, 0x02
+#define TSC2101_MIXER_GAIN_CTRL		2, 0x03
+#define TSC210X_AUDIO2_CTRL		2, 0x04
+#define TSC210X_POWER_CTRL		2, 0x05
+#define TSC210X_AUDIO3_CTRL		2, 0x06
+#define TSC210X_LCH_BASS_BOOST_N0	2, 0x07
+#define TSC210X_LCH_BASS_BOOST_N1	2, 0x08
+#define TSC210X_LCH_BASS_BOOST_N2	2, 0x09
+#define TSC210X_LCH_BASS_BOOST_N3	2, 0x0a
+#define TSC210X_LCH_BASS_BOOST_N4	2, 0x0b
+#define TSC210X_LCH_BASS_BOOST_N5	2, 0x0c
+#define TSC210X_LCH_BASS_BOOST_D1	2, 0x0d
+#define TSC210X_LCH_BASS_BOOST_D2	2, 0x0e
+#define TSC210X_LCH_BASS_BOOST_D4	2, 0x0f
+#define TSC210X_LCH_BASS_BOOST_D5	2, 0x10
+#define TSC210X_RCH_BASS_BOOST_N0	2, 0x11
+#define TSC210X_RCH_BASS_BOOST_N1	2, 0x12
+#define TSC210X_RCH_BASS_BOOST_N2	2, 0x13
+#define TSC210X_RCH_BASS_BOOST_N3	2, 0x14
+#define TSC210X_RCH_BASS_BOOST_N4	2, 0x15
+#define TSC210X_RCH_BASS_BOOST_N5	2, 0x16
+#define TSC210X_RCH_BASS_BOOST_D1	2, 0x17
+#define TSC210X_RCH_BASS_BOOST_D2	2, 0x18
+#define TSC210X_RCH_BASS_BOOST_D4	2, 0x19
+#define TSC210X_RCH_BASS_BOOST_D5	2, 0x1a
+#define TSC210X_PLL1_CTRL		2, 0x1b
+#define TSC210X_PLL2_CTRL		2, 0x1c
+#define TSC210X_AUDIO4_CTRL		2, 0x1d
+#define TSC2101_HANDSET_GAIN_CTRL	2, 0x1e
+#define TSC2101_CELL_GAIN_CTRL		2, 0x1f
+#define TSC2101_AUIDO5_CTRL		2, 0x20
+#define TSC2101_AUDIO6_CTRL		2, 0x21
+#define TSC2101_AUDIO7_CTRL		2, 0x22
+#define TSC2101_GPIO_CTRL		2, 0x23
+#define TSC2101_IN_AGC_CTRL		2, 0x24
+#define TSC2101_POWER_STATUS		2, 0x25
+#define TSC2101_MIX_AGC_CTRL		2, 0x26
+#define TSC2101_CELL_AGC_CTRL		2, 0x27
+
+/* Field masks for Audio Control 1 */
+#define AC1_WLEN(ARG)			(((ARG) & 0x03) << 10)
+#define AC1_DATFM(ARG)			(((ARG) & 0x03) << 8)
+#define AC1_DACFS(ARG)			((ARG) & 0x3f)
+
+/* Field masks for TSC2102_DAC_GAIN_CTRL */
+#define DGC_DALMU			(1 << 15)
+#define DGC_DALVL(ARG)			(((ARG) & 0x7f) << 8)
+#define DGC_DARMU			(1 << 7)
+#define DGC_DARVL(ARG)			(((ARG) & 0x7f))
+
+/* Field formats for TSC210X_AUDIO2_CTRL */
+#define AC2_KCLEN			(1 << 15)
+#define AC2_KCLAC(ARG)			(((ARG) & 0x07) << 12)
+#define AC2_KCLFRQ(ARG)			(((ARG) & 0x07) << 8)
+#define AC2_KCLLN(ARG)			(((ARG) & 0x0f) << 4)
+#define AC2_DLGAF			(1 << 3)
+#define AC2_DRGAF			(1 << 2)
+#define AC2_DASTC			(1 << 1)
+
+/* Field masks for TSC210X_DAC_POWER_CTRL */
+#define CPC_PWDNC			(1 << 15)
+#define CPC_DAODRC			(1 << 12)
+#define CPC_DAPWDN			(1 << 10)
+#define CPC_VGPWDN			(1 << 8)
+#define CPC_DAPWDF			(1 << 6)
+#define CPC_BASSBC			(1 << 1)
+#define CPC_DEEMPF			(0x01)
+
+/* Field masks for TSC210X_AUDIO3_CTRL */
+#define AC3_DMSVOL(ARG)			(((ARG) & 0x03) << 14)
+#define AC3_REFFS			(1 << 13)
+#define AC3_DAXFM			(1 << 12)
+#define AC3_SLVMS			(1 << 11)
+#define AC3_DALOVF			(1 << 7)
+#define AC3_DAROVF			(1 << 6)
+#define AC3_REVID(ARG)			(((ARG) & 0x07))
+
+/* Field masks for TSC210X_PLL1_CTRL */
+#define PLL1_PLLEN			(1 << 15)
+#define PLL1_Q_VAL(ARG)			(((ARG) & 0x0f) << 11)
+#define PLL1_P_VAL(ARG)			(((ARG) & 0x07) << 8)
+#define PLL1_I_VAL(ARG)			(((ARG) & 0x3f) << 2)
+
+/* Field masks for TSC210X_PLL2_CTRL */
+#define PLL2_D_VAL(ARG)			(((ARG) & 0x3fff) << 2)
+
+/* Field masks for TSC210X_AUDIO4_CTRL */
+#define AC4_DASTPD			(1 << 14)
+
+struct tsc210x_rate_info_s {
+	u16 sample_rate;
+	u8 divisor;
+	u8 fs_44k;	/* 44.1 kHz Fsref if 1, 48 kHz if 0 */
+};
+
+#endif	/* __LINUX_SPI_TSC210X_H */
-- 
1.6.0.1.141.g445ca

