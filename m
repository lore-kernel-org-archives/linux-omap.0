From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCH 1/8] ASoC: TPA6130A2 amplifier driver
Date: Thu,  8 Oct 2009 14:58:50 +0300
Message-ID: <1255003137-1034-2-git-send-email-eduardo.valentin@nokia.com>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:55038 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757648AbZJHMBE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 08:01:04 -0400
In-Reply-To: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, ext Tony Lindgren <tony@atomide.com>
Cc: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Driver for Texas Instruments TPA6130A2 headphone stereo
amplifier.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 include/sound/tpa6130a2-plat.h |   30 +++
 sound/soc/codecs/Kconfig       |    4 +
 sound/soc/codecs/Makefile      |    2 +
 sound/soc/codecs/tpa6130a2.c   |  380 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/tpa6130a2.h   |   62 +++++++
 5 files changed, 478 insertions(+), 0 deletions(-)
 create mode 100644 include/sound/tpa6130a2-plat.h
 create mode 100644 sound/soc/codecs/tpa6130a2.c
 create mode 100644 sound/soc/codecs/tpa6130a2.h

diff --git a/include/sound/tpa6130a2-plat.h b/include/sound/tpa6130a2-plat.h
new file mode 100644
index 0000000..d315728
--- /dev/null
+++ b/include/sound/tpa6130a2-plat.h
@@ -0,0 +1,30 @@
+/*
+ * TPA6130A2 driver platform header
+ *
+ * Copyright (C) Nokia Corporation
+ *
+ * Written by Peter Ujfalusi <peter.ujfalusi@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ */
+
+#ifndef TPA6130A2_PLAT_H
+#define TPA6130A2_PLAT_H
+
+struct tpa6130a2_platform_data {
+	int (*set_power)(int state);
+};
+
+#endif
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 0edca93..2437fd3 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -28,6 +28,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_TLV320AIC23 if I2C
 	select SND_SOC_TLV320AIC26 if SPI_MASTER
 	select SND_SOC_TLV320AIC3X if I2C
+	select SND_SOC_TPA6130A2 if I2C
 	select SND_SOC_TWL4030 if TWL4030_CORE
 	select SND_SOC_UDA134X
 	select SND_SOC_UDA1380 if I2C
@@ -220,3 +221,6 @@ config SND_SOC_WM9713
 # Amp
 config SND_SOC_MAX9877
 	tristate
+
+config SND_SOC_TPA6130A2
+	tristate
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index fb4af28..498c024 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -47,6 +47,7 @@ snd-soc-wm-hubs-objs := wm_hubs.o
 
 # Amp
 snd-soc-max9877-objs := max9877.o
+snd-soc-tpa6130a2-objs := tpa6130a2.o
 
 obj-$(CONFIG_SND_SOC_AC97_CODEC)	+= snd-soc-ac97.o
 obj-$(CONFIG_SND_SOC_AD1836)	+= snd-soc-ad1836.o
@@ -97,3 +98,4 @@ obj-$(CONFIG_SND_SOC_WM_HUBS)	+= snd-soc-wm-hubs.o
 
 # Amp
 obj-$(CONFIG_SND_SOC_MAX9877)	+= snd-soc-max9877.o
+obj-$(CONFIG_SND_SOC_TPA6130A2)	+= snd-soc-tpa6130a2.o
diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
new file mode 100644
index 0000000..d246aad
--- /dev/null
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -0,0 +1,380 @@
+/*
+ * ALSA SoC Texas Instruments TPA6130A2 headset stereo amplifier driver
+ *
+ * Copyright (C) Nokia Corporation
+ *
+ * Author: Peter Ujfalusi <peter.ujfalusi@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ */
+
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/sysfs.h>
+#include <sound/tpa6130a2-plat.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/tlv.h>
+
+#include "tpa6130a2.h"
+
+struct i2c_client *tpa6130a2_client;
+
+/* This struct is used to save the context */
+struct tpa6130a2_data {
+	/* mutex protect access to tpa6130a2_data structure */
+	struct mutex mutex;
+	unsigned char regs[TPA6130A2_CACHEREGNUM];
+	unsigned char power_state;
+	int (*set_power)(int state);
+};
+
+static int tpa6130a2_i2c_read(int reg)
+{
+	struct tpa6130a2_data *data;
+	int val;
+
+	BUG_ON(tpa6130a2_client == NULL);
+
+	data = i2c_get_clientdata(tpa6130a2_client);
+
+	/* If powered off, return the cached value */
+	if (data->power_state) {
+		val = i2c_smbus_read_byte_data(tpa6130a2_client, reg);
+		if (val < 0)
+			dev_err(&tpa6130a2_client->dev, "Read failed\n");
+		else
+			data->regs[reg] = val;
+	} else {
+		val = data->regs[reg];
+	}
+
+	return val;
+}
+
+static int tpa6130a2_i2c_write(int reg, u8 value)
+{
+	struct tpa6130a2_data *data;
+	int val = 0;
+
+	BUG_ON(tpa6130a2_client == NULL);
+
+	data = i2c_get_clientdata(tpa6130a2_client);
+
+	if (data->power_state) {
+		val = i2c_smbus_write_byte_data(tpa6130a2_client, reg, value);
+		if (val < 0)
+			dev_err(&tpa6130a2_client->dev, "Write failed\n");
+	}
+
+	/* Either powered on or off, we save the context */
+	data->regs[reg] = value;
+
+	return val;
+}
+
+static u8 tpa6130a2_read(int reg)
+{
+	struct tpa6130a2_data *data;
+
+	BUG_ON(tpa6130a2_client == NULL);
+
+	data = i2c_get_clientdata(tpa6130a2_client);
+
+	return data->regs[reg];
+}
+
+static void tpa6130a2_initialize(void)
+{
+	struct tpa6130a2_data *data;
+	int i;
+
+	BUG_ON(tpa6130a2_client == NULL);
+
+	data = i2c_get_clientdata(tpa6130a2_client);
+
+	for (i = 1; i < TPA6130A2_REG_VERSION; i++)
+		tpa6130a2_i2c_write(i, data->regs[i]);
+}
+
+void tpa6130a2_power(int power)
+{
+	struct	tpa6130a2_data *data;
+	u8	val;
+
+	data = i2c_get_clientdata(tpa6130a2_client);
+
+	mutex_lock(&data->mutex);
+	if (power) {
+		/* Power on */
+		if (data->set_power) {
+			data->set_power(1);
+			data->power_state = 1;
+			tpa6130a2_initialize();
+		}
+		/* Clear SWS */
+		val = tpa6130a2_read(TPA6130A2_REG_CONTROL);
+		val &= ~TPA6130A2_SWS;
+		tpa6130a2_i2c_write(TPA6130A2_REG_CONTROL, val);
+	} else {
+		/* set SWS */
+		val = tpa6130a2_read(TPA6130A2_REG_CONTROL);
+		val |= TPA6130A2_SWS;
+		tpa6130a2_i2c_write(TPA6130A2_REG_CONTROL, val);
+		/* Power off */
+		if (data->set_power) {
+			data->set_power(0);
+			data->power_state = 0;
+		}
+	}
+	mutex_unlock(&data->mutex);
+}
+
+static int tpa6130a2_get_reg(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	unsigned int reg = mc->reg;
+	unsigned int shift = mc->shift;
+	unsigned int mask = mc->max;
+	unsigned int invert = mc->invert;
+	struct tpa6130a2_data *data;
+
+	BUG_ON(tpa6130a2_client == NULL);
+
+	data = i2c_get_clientdata(tpa6130a2_client);
+
+	mutex_lock(&data->mutex);
+
+	ucontrol->value.integer.value[0] =
+		(tpa6130a2_read(reg) >> shift) & mask;
+
+	if (invert)
+		ucontrol->value.integer.value[0] =
+			mask - ucontrol->value.integer.value[0];
+
+	mutex_unlock(&data->mutex);
+	return 0;
+}
+
+static int tpa6130a2_set_reg(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	unsigned int reg = mc->reg;
+	unsigned int shift = mc->shift;
+	unsigned int mask = mc->max;
+	unsigned int invert = mc->invert;
+	unsigned int val = (ucontrol->value.integer.value[0] & mask);
+	unsigned int val_reg;
+	struct tpa6130a2_data *data;
+
+	BUG_ON(tpa6130a2_client == NULL);
+
+	data = i2c_get_clientdata(tpa6130a2_client);
+
+	if (invert)
+		val = mask - val;
+
+	mutex_lock(&data->mutex);
+
+	val_reg = tpa6130a2_read(reg);
+	if (((val_reg >> shift) & mask) == val) {
+		mutex_unlock(&data->mutex);
+		return 0;
+	}
+
+	val_reg &= ~(mask << shift);
+	val_reg |= val << shift;
+	tpa6130a2_i2c_write(reg, val_reg);
+
+	mutex_unlock(&data->mutex);
+
+	return 1;
+}
+
+/*
+ * TPA6130 volume. From -59.5 to 4 dB with increasing step size when going
+ * down in gain. Justify scale so that it is quite correct from -20 dB and
+ * up. This setting shows -30 dB at minimum, -12.95 dB at 49 % (actual
+ * is -10.3 dB) and 4.65 dB at maximum (actual is 4 dB).
+ */
+static const unsigned int tpa6130_tlv[] = {
+	TLV_DB_RANGE_HEAD(10),
+	0, 1, TLV_DB_SCALE_ITEM(-5950, 600, 0),
+	2, 3, TLV_DB_SCALE_ITEM(-5000, 250, 0),
+	4, 5, TLV_DB_SCALE_ITEM(-4550, 160, 0),
+	6, 7, TLV_DB_SCALE_ITEM(-4140, 190, 0),
+	8, 9, TLV_DB_SCALE_ITEM(-3650, 120, 0),
+	10, 11, TLV_DB_SCALE_ITEM(-3330, 160, 0),
+	12, 13, TLV_DB_SCALE_ITEM(-3040, 180, 0),
+	14, 20, TLV_DB_SCALE_ITEM(-2710, 110, 0),
+	21, 37, TLV_DB_SCALE_ITEM(-1960, 74, 0),
+	38, 63, TLV_DB_SCALE_ITEM(-720, 45, 0),
+};
+
+static const struct snd_kcontrol_new tpa6130a2_controls[] = {
+	SOC_SINGLE_EXT_TLV("TPA6130A2 Headphone Playback Volume",
+		       TPA6130A2_REG_VOL_MUTE, 0, 0x3f, 0,
+		       tpa6130a2_get_reg, tpa6130a2_set_reg,
+		       tpa6130_tlv),
+};
+
+static int tpa6130a2_hp_event(struct snd_soc_dapm_widget *w,
+			   struct snd_kcontrol *k, int event)
+{
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		tpa6130a2_power(1);
+	else
+		tpa6130a2_power(0);
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget tpa6130a2_dapm_widgets[] = {
+	/* Outputs */
+	SND_SOC_DAPM_HP("TPA6130A2 Headphone", tpa6130a2_hp_event),
+};
+
+int tpa6130a2_add_controls(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_new_controls(codec, tpa6130a2_dapm_widgets,
+				ARRAY_SIZE(tpa6130a2_dapm_widgets));
+
+	return snd_soc_add_controls(codec, tpa6130a2_controls,
+				ARRAY_SIZE(tpa6130a2_controls));
+
+}
+EXPORT_SYMBOL(tpa6130a2_add_controls);
+
+static int tpa6130a2_probe(struct i2c_client *client,
+			   const struct i2c_device_id *id)
+{
+	int err;
+	struct device *dev;
+	struct tpa6130a2_data *data;
+	struct tpa6130a2_platform_data *pdata;
+
+	dev = &client->dev;
+
+	tpa6130a2_client = client;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (data == NULL) {
+		err = -ENOMEM;
+		goto fail1;
+	}
+
+	i2c_set_clientdata(tpa6130a2_client, data);
+
+	if (client->dev.platform_data == NULL) {
+		dev_err(dev, "Platform data not set\n");
+		dump_stack();
+		err = -ENODEV;
+		goto fail2;
+	}
+
+	pdata = (struct tpa6130a2_platform_data *)client->dev.platform_data;
+	/* Set default register values */
+	data->regs[TPA6130A2_REG_CONTROL] = TPA6130A2_SWS |
+					    TPA6130A2_HP_EN_R |
+					    TPA6130A2_HP_EN_L;
+	data->regs[TPA6130A2_REG_VOL_MUTE] = TPA6130A2_VOLUME(20);
+
+	mutex_init(&data->mutex);
+
+	data->set_power = pdata->set_power;
+	if (!pdata->set_power) {
+		data->power_state = 1;
+		tpa6130a2_initialize();
+	}
+	tpa6130a2_power(1);
+
+	/* Read version */
+	err = tpa6130a2_i2c_read(TPA6130A2_REG_VERSION) &
+				 TPA6130A2_VERSION_MASK;
+	if ((err != 1) && (err != 2)) {
+		dev_err(dev, "Unexpected headphone amplifier chip version "
+		       "of 0x%02x, was expecting 0x01 or 0x02\n", err);
+		err = -ENODEV;
+
+		goto fail3;
+	}
+
+	dev_info(dev, "Version %d detected\n", err);
+
+	/* Disable the chip */
+	tpa6130a2_power(0);
+
+	return 0;
+fail3:
+	tpa6130a2_power(0);
+fail2:
+	kfree(data);
+	i2c_set_clientdata(tpa6130a2_client, NULL);
+fail1:
+	tpa6130a2_client = 0;
+
+	return err;
+}
+
+static int tpa6130a2_remove(struct i2c_client *client)
+{
+	struct tpa6130a2_data *data = i2c_get_clientdata(client);
+
+	tpa6130a2_power(0);
+	kfree(data);
+	tpa6130a2_client = 0;
+
+	return 0;
+}
+
+static const struct i2c_device_id tpa6130a2_id[] = {
+	{ "tpa6130a2", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tpa6130a2_id);
+
+static struct i2c_driver tpa6130a2_i2c_driver = {
+	.driver = {
+		.name = "tpa6130a2",
+		.owner = THIS_MODULE,
+	},
+	.probe = tpa6130a2_probe,
+	.remove = __devexit_p(tpa6130a2_remove),
+	.id_table = tpa6130a2_id,
+};
+
+static int __init tpa6130a2_init(void)
+{
+	return i2c_add_driver(&tpa6130a2_i2c_driver);
+}
+
+static void __exit tpa6130a2_exit(void)
+{
+	i2c_del_driver(&tpa6130a2_i2c_driver);
+}
+
+MODULE_AUTHOR("Peter Ujfalusi");
+MODULE_DESCRIPTION("TPA6130A2 Headphone amplifier driver");
+MODULE_LICENSE("GPL");
+
+module_init(tpa6130a2_init);
+module_exit(tpa6130a2_exit);
diff --git a/sound/soc/codecs/tpa6130a2.h b/sound/soc/codecs/tpa6130a2.h
new file mode 100644
index 0000000..6a794f1
--- /dev/null
+++ b/sound/soc/codecs/tpa6130a2.h
@@ -0,0 +1,62 @@
+/*
+ * ALSA SoC TPA6130A2 amplifier driver
+ *
+ * Copyright (C) Nokia Corporation
+ *
+ * Author: Peter Ujfalusi <peter.ujfalusi@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef __TPA6130A2_H__
+#define __TPA6130A2_H__
+
+/* Register addresses */
+#define TPA6130A2_REG_CONTROL		0x01
+#define TPA6130A2_REG_VOL_MUTE		0x02
+#define TPA6130A2_REG_OUT_IMPEDANCE	0x03
+#define TPA6130A2_REG_VERSION		0x04
+
+#define TPA6130A2_CACHEREGNUM	(TPA6130A2_REG_VERSION + 1)
+
+/* Register bits */
+/* TPA6130A2_REG_CONTROL (0x01) */
+#define TPA6130A2_SWS			(0x01 << 0)
+#define TPA6130A2_TERMAL		(0x01 << 1)
+#define TPA6130A2_MODE(x)		(x << 4)
+#define TPA6130A2_MODE_STEREO		(0x00)
+#define TPA6130A2_MODE_DUAL_MONO	(0x01)
+#define TPA6130A2_MODE_BRIDGE		(0x02)
+#define TPA6130A2_MODE_MASK		(0x03)
+#define TPA6130A2_HP_EN_R		(0x01 << 6)
+#define TPA6130A2_HP_EN_L		(0x01 << 7)
+
+/* TPA6130A2_REG_VOL_MUTE (0x02) */
+#define TPA6130A2_VOLUME(x)		((x & 0x3f) << 0)
+#define TPA6130A2_MUTE_R		(0x01 << 6)
+#define TPA6130A2_MUTE_L		(0x01 << 7)
+
+/* TPA6130A2_REG_OUT_IMPEDANCE (0x03) */
+#define TPA6130A2_HIZ_R			(0x01 << 0)
+#define TPA6130A2_HIZ_L			(0x01 << 1)
+
+/* TPA6130A2_REG_VERSION (0x04) */
+#define TPA6130A2_VERSION_MASK		(0x0f)
+
+extern int tpa6130a2_add_controls(struct snd_soc_codec *codec);
+extern void tpa6130a2_power(int power);
+
+#endif /* __TPA6130A2_H__ */
-- 
1.6.4.183.g04423

