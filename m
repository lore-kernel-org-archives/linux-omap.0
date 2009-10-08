From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCH 2/8] ASoC: OMAP: RX-51 Machine driver and AIC34b_dummy driver
Date: Thu,  8 Oct 2009 14:58:51 +0300
Message-ID: <1255003137-1034-3-git-send-email-eduardo.valentin@nokia.com>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:45226 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757796AbZJHMBL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 08:01:11 -0400
In-Reply-To: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, ext Tony Lindgren <tony@atomide.com>
Cc: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Eduardo Valentin <eduardo.valentin@nokia.com>

Introduce RX-51 Machine driver for ASoC and AIC34b_dummy (block B) i2c driver.

Also move the request_gpio of speaker_enabled
from board-rx51-peripherals.c to this machine driver.

These drivers were originally written by Jarkko Nikula.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 -
 sound/soc/omap/Kconfig                       |   10 +
 sound/soc/omap/Makefile                      |    2 +
 sound/soc/omap/aic34b_dummy.c                |  271 +++++++++
 sound/soc/omap/aic34b_dummy.h                |   32 +
 sound/soc/omap/rx51.c                        |  793 ++++++++++++++++++++++++++
 sound/soc/omap/rx51.h                        |   29 +
 7 files changed, 1137 insertions(+), 2 deletions(-)
 create mode 100644 sound/soc/omap/aic34b_dummy.c
 create mode 100644 sound/soc/omap/aic34b_dummy.h
 create mode 100644 sound/soc/omap/rx51.c
 create mode 100644 sound/soc/omap/rx51.h

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index c1af532..b227475 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -262,8 +262,6 @@ static int rx51_twlgpio_setup(struct device *dev, unsigned gpio, unsigned n)
 	/* FIXME this gpio setup is just a placeholder for now */
 	gpio_request(gpio + 6, "backlight_pwm");
 	gpio_direction_output(gpio + 6, 0);
-	gpio_request(gpio + 7, "speaker_en");
-	gpio_direction_output(gpio + 7, 1);
 
 	/* set up MMC adapters, linking their regulators to them */
 	twl4030_mmc_init(mmc);
diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 2dee983..bdcd4be 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -15,6 +15,16 @@ config SND_OMAP_SOC_N810
 	help
 	  Say Y if you want to add support for SoC audio on Nokia N810.
 
+config SND_OMAP_SOC_RX51
+	tristate "SoC Audio support for Nokia RX51"
+	depends on SND_OMAP_SOC && MACH_NOKIA_RX51
+	select OMAP_MCBSP
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_TLV320AIC3X
+	select SND_SOC_TPA6130A2
+	help
+	  Say Y if you want to add support for SoC audio on Nokia RX51.
+
 config SND_OMAP_SOC_AMS_DELTA
 	tristate "SoC Audio support for Amstrad E3 (Delta) videophone"
 	depends on SND_OMAP_SOC && MACH_AMS_DELTA
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index 02d6947..7dec270 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -16,8 +16,10 @@ snd-soc-sdp3430-objs := sdp3430.o
 snd-soc-omap3pandora-objs := omap3pandora.o
 snd-soc-omap3beagle-objs := omap3beagle.o
 snd-soc-zoom2-objs := zoom2.o
+snd-soc-rx51-objs := rx51.o
 
 obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
+obj-$(CONFIG_SND_OMAP_SOC_RX51) += snd-soc-rx51.o aic34b_dummy.o
 obj-$(CONFIG_SND_OMAP_SOC_AMS_DELTA) += snd-soc-ams-delta.o
 obj-$(CONFIG_SND_OMAP_SOC_OSK5912) += snd-soc-osk5912.o
 obj-$(CONFIG_SND_OMAP_SOC_OVERO) += snd-soc-overo.o
diff --git a/sound/soc/omap/aic34b_dummy.c b/sound/soc/omap/aic34b_dummy.c
new file mode 100644
index 0000000..17c4d9c
--- /dev/null
+++ b/sound/soc/omap/aic34b_dummy.c
@@ -0,0 +1,271 @@
+/*
+ * aic34b_dummy.c  --  Dummy driver for AIC34 block B parts used in Nokia RX51
+ *
+ * Purpose for this driver is to cover few audio connections on Nokia RX51 HW
+ * which are connected into block B of TLV320AIC34 dual codec.
+ *
+ * Copyright (C) 2008 - 2009 Nokia Corporation
+ *
+ * Contact: Peter Ujfalusi <peter.ujfalusi@nokia.com>
+ *          Eduardo Valentin <eduardo.valentin@nokia.com>
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
+ * TODO:
+ * - Get rid of this driver, at least when ASoC v2 is merged and when
+ *   we can support multiple codec instances in tlv320aic3x.c driver.
+ *   This driver is hacked only for Nokia RX51 HW.
+ */
+
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <sound/soc.h>
+
+#include "../codecs/tlv320aic3x.h"
+
+struct i2c_client *aic34b_client;
+static DEFINE_MUTEX(aic34b_mutex);
+static DEFINE_MUTEX(button_press_mutex);
+static ktime_t button_press_denial_start;
+static int aic34b_volume;
+static int button_press_denied;
+static int aic34b_bias;
+
+
+static int aic34b_read(struct i2c_client *client, unsigned int reg,
+		       u8 *value)
+{
+	int err;
+
+	err = i2c_smbus_read_byte_data(client, reg);
+	*value = err;
+	return (err >= 0) ? 0 : err;
+}
+
+static int aic34b_write(struct i2c_client *client, unsigned int reg,
+			u8 value)
+{
+	u8 data[2];
+
+	data[0] = reg & 0xff;
+	data[1] = value & 0xff;
+
+	return (i2c_master_send(client, data, 2) == 2) ? 0 : -EIO;
+}
+
+/*
+ * Introduce a derivative FIR filter to detect unnecessary button
+ * presses caused by a change in the MICBIAS. The filter returns
+ * TRUE in the event there has not been a change in MICBIAS within
+ * the time window (500ms). If the rate of change within the window
+ * is >= 1, all button presses are denied. In addition, if bias is
+ * zero, then all button presses are also denied explicitly.
+ */
+int allow_button_press(void)
+{
+	/* If bias is not on, no chance for button presses */
+	if (!aic34b_bias)
+		return 0;
+
+	/* If explicitly granted a button press */
+	if (!button_press_denied) {
+		return 1;
+	} else	{
+		int64_t delta;
+		/* This is the FIR portion with specified time window */
+		mutex_lock(&button_press_mutex);
+		delta = ktime_to_ns(ktime_sub(ktime_get(),
+					button_press_denial_start));
+
+		if (delta < 0) {
+			button_press_denied = 0;
+			/* If the clock ever wraps */
+			button_press_denial_start.tv.sec = 0;
+			button_press_denial_start.tv.nsec = 0;
+			mutex_unlock(&button_press_mutex);
+			return 1;
+		}
+		do_div(delta, 1000000);
+		/* Time window is 500ms */
+		if (delta >= 500) {
+			button_press_denied = 0;
+			mutex_unlock(&button_press_mutex);
+			return 1;
+		}
+		mutex_unlock(&button_press_mutex);
+	}
+
+	/* There was a change in MICBIAS within time window */
+	return 0;
+}
+EXPORT_SYMBOL(allow_button_press);
+
+static void deny_button_press(void)
+{
+	mutex_lock(&button_press_mutex);
+	button_press_denied = 1;
+	button_press_denial_start = ktime_get();
+	mutex_unlock(&button_press_mutex);
+}
+
+void aic34b_set_mic_bias(int bias)
+{
+	if (aic34b_client == NULL)
+		return;
+
+	mutex_lock(&aic34b_mutex);
+	aic34b_write(aic34b_client, MICBIAS_CTRL, (bias & 0x3) << 6);
+	aic34b_bias = bias;
+	deny_button_press();
+	mutex_unlock(&aic34b_mutex);
+}
+EXPORT_SYMBOL(aic34b_set_mic_bias);
+
+int aic34b_set_volume(u8 volume)
+{
+	u8 val;
+
+	if (aic34b_client == NULL)
+		return 0;
+
+	mutex_lock(&aic34b_mutex);
+
+	/* Volume control for Right PGA to HPLOUT */
+	aic34b_read(aic34b_client, 49, &val);
+	val &= ~0x7f;
+	aic34b_write(aic34b_client, 49, val | (~volume & 0x7f));
+
+	/* Volume control for Right PGA to HPLCOM */
+	aic34b_read(aic34b_client, 56, &val);
+	val &= ~0x7f;
+	aic34b_write(aic34b_client, 56, val | (~volume & 0x7f));
+
+	aic34b_volume = volume;
+	mutex_unlock(&aic34b_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL(aic34b_set_volume);
+
+void aic34b_ear_enable(int enable)
+{
+	u8 val;
+
+	if (aic34b_client == NULL)
+		return;
+
+	mutex_lock(&aic34b_mutex);
+	if (enable) {
+		/* Connect LINE2R to RADC */
+		aic34b_write(aic34b_client, LINE2R_2_RADC_CTRL, 0x80);
+		/* Unmute Right ADC-PGA */
+		aic34b_write(aic34b_client, RADC_VOL, 0x00);
+		/* Right PGA -> HPLOUT */
+		aic34b_read(aic34b_client, 49, &val);
+		aic34b_write(aic34b_client, 49, val | 0x80);
+		/* Unmute HPLOUT with 1 dB gain */
+		aic34b_write(aic34b_client, HPLOUT_CTRL, 0x19);
+		/* Right PGA -> HPLCOM */
+		aic34b_read(aic34b_client, 56, &val);
+		aic34b_write(aic34b_client, 56, val | 0x80);
+		/* Unmute HPLCOM with 1 dB gain */
+		aic34b_write(aic34b_client, HPLCOM_CTRL, 0x19);
+	} else {
+		/* Disconnect LINE2R from RADC */
+		aic34b_write(aic34b_client, LINE2R_2_RADC_CTRL, 0xF8);
+		/* Mute Right ADC-PGA */
+		aic34b_write(aic34b_client, RADC_VOL, 0x80);
+		/* Detach Right PGA from HPLOUT */
+		aic34b_write(aic34b_client, 49, (~aic34b_volume & 0x7f));
+		/* Power down HPLOUT */
+		aic34b_write(aic34b_client, HPLOUT_CTRL, 0x06);
+		/* Detach Right PGA from HPLCOM */
+		aic34b_write(aic34b_client, 56, (~aic34b_volume & 0x7f));
+		/* Power down HPLCOM */
+		aic34b_write(aic34b_client, HPLCOM_CTRL, 0x06);
+		/* Deny any possible keypresses for a second */
+		deny_button_press();
+		/* To regain low power consumption, reset is needed */
+		aic34b_write(aic34b_client, AIC3X_RESET, SOFT_RESET);
+		/* And need to restore volume level */
+		aic34b_write(aic34b_client, 49, (~aic34b_volume & 0x7f));
+		aic34b_write(aic34b_client, 56, (~aic34b_volume & 0x7f));
+		/* Need to restore MICBIAS if set */
+		if (aic34b_bias)
+			aic34b_write(aic34b_client, MICBIAS_CTRL,
+					(aic34b_bias & 0x3) << 6);
+	}
+	mutex_unlock(&aic34b_mutex);
+}
+EXPORT_SYMBOL(aic34b_ear_enable);
+
+static int aic34b_dummy_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	u8 val;
+
+	if (aic34b_read(client, AIC3X_PLL_PROGA_REG, &val) || val != 0x10) {
+		/* Chip not present */
+		return -ENODEV;
+	}
+	aic34b_client = client;
+
+	/* Configure LINE2R for differential mode */
+	aic34b_read(client, LINE2R_2_RADC_CTRL, &val);
+	aic34b_write(client, LINE2R_2_RADC_CTRL, val | 0x80);
+
+	return 0;
+}
+
+static int aic34b_dummy_remove(struct i2c_client *client)
+{
+	aic34b_client = NULL;
+
+	return 0;
+}
+
+static const struct i2c_device_id aic34b_dummy_id[] = {
+	{ "aic34b_dummy", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, aic34b_dummy_id);
+
+static struct i2c_driver aic34b_dummy_driver = {
+	.driver = {
+		.name	= "aic34b_dummy"
+	},
+	.probe		= aic34b_dummy_probe,
+	.remove		= aic34b_dummy_remove,
+	.id_table	= aic34b_dummy_id,
+};
+
+static int __init aic34b_dummy_init(void)
+{
+	return i2c_add_driver(&aic34b_dummy_driver);
+}
+
+static void __exit aic34b_dummy_exit(void)
+{
+	i2c_del_driver(&aic34b_dummy_driver);
+}
+
+MODULE_AUTHOR("Nokia Corporation");
+MODULE_DESCRIPTION("Dummy driver for AIC34 block B parts used on Nokia RX51");
+MODULE_LICENSE("GPL");
+
+module_init(aic34b_dummy_init);
+module_exit(aic34b_dummy_exit);
diff --git a/sound/soc/omap/aic34b_dummy.h b/sound/soc/omap/aic34b_dummy.h
new file mode 100644
index 0000000..2d386bf
--- /dev/null
+++ b/sound/soc/omap/aic34b_dummy.h
@@ -0,0 +1,32 @@
+/*
+ * aic34b_dummy.h
+ *
+ * Copyright (C) 2008 - 2009 Nokia Corporation
+ *
+ * Contact: Peter Ujfalusi <peter.ujfalusi@nokia.com>
+ *          Eduardo Valentin <eduardo.valentin@nokia.com>
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
+#ifndef __AIC34B_DUMMY__
+#define __AIC34B_DUMMY__
+
+extern void aic34b_ear_enable(int enable);
+void aic34b_set_mic_bias(int bias);
+int aic34b_set_volume(u8 volume);
+
+#endif
diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
new file mode 100644
index 0000000..74bafb2
--- /dev/null
+++ b/sound/soc/omap/rx51.c
@@ -0,0 +1,793 @@
+/*
+ * rx51.c  --  SoC audio for Nokia RX51
+ *
+ * Copyright (C) 2008 - 2009 Nokia Corporation
+ *
+ * Contact: Peter Ujfalusi <peter.ujfalusi@nokia.com>
+ *          Eduardo Valentin <eduardo.valentin@nokia.com>
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
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/jack.h>
+#include <sound/tlv.h>
+
+#include <linux/i2c/twl4030.h>
+#include <asm/mach-types.h>
+#include <mach/hardware.h>
+#include <linux/gpio.h>
+#include <mach/mcbsp.h>
+
+#include "omap-mcbsp.h"
+#include "omap-pcm.h"
+#include "../codecs/tlv320aic3x.h"
+#include "../codecs/tpa6130a2.h"
+#include "aic34b_dummy.h"
+
+#define RX51_CODEC_RESET_GPIO		60
+#define RX51_TVOUT_SEL_GPIO		40
+#define RX51_ECI_SWITCH_1_GPIO		178
+#define RX51_ECI_SWITCH_2_GPIO		182
+/* REVISIT: TWL4030 GPIO base in RX51. Now statically defined to 192 */
+#define RX51_SPEAKER_AMP_TWL_GPIO	(192 + 7)
+
+enum {
+	RX51_JACK_DISABLED,
+	RX51_JACK_HP,		/* headphone: stereo output, no mic */
+	RX51_JACK_HS,		/* headset: stereo output with mic */
+	RX51_JACK_MIC,		/* mic input only */
+	RX51_JACK_ECI,		/* ECI headset */
+	RX51_JACK_TVOUT,	/* stereo output with tv-out */
+};
+
+static int rx51_spk_func;
+static int rx51_jack_func;
+static int rx51_fmtx_func;
+static int rx51_dmic_func;
+static int rx51_ear_func;
+static struct snd_jack *rx51_jack;
+
+static DEFINE_MUTEX(eci_mutex);
+static int rx51_eci_mode = 1;
+static int rx51_dapm_jack_bias;
+static int tpa6130_enable;
+static int aic34b_volume;
+
+static void rx51_set_eci_switches(int mode)
+{
+	switch (mode) {
+	case 0: /* Bias off */
+	case 1: /* Bias according to rx51_dapm_jack_bias */
+	case 4: /* Bias on */
+		/* Codec connected to mic/bias line */
+		gpio_set_value(RX51_ECI_SWITCH_1_GPIO, 0);
+		gpio_set_value(RX51_ECI_SWITCH_2_GPIO, 1);
+		break;
+	case 2:
+		/* ECI INT#2 detect connected to mic/bias line */
+		gpio_set_value(RX51_ECI_SWITCH_1_GPIO, 0);
+		gpio_set_value(RX51_ECI_SWITCH_2_GPIO, 0);
+		break;
+	case 3:
+		/* ECI RX/TX connected to mic/bias line */
+		gpio_set_value(RX51_ECI_SWITCH_1_GPIO, 1);
+		gpio_set_value(RX51_ECI_SWITCH_2_GPIO, 0);
+		break;
+	}
+}
+
+static void rx51_set_jack_bias(void)
+{
+	int enable_bias = 0;
+
+	mutex_lock(&eci_mutex);
+	if ((rx51_eci_mode == 1 && rx51_dapm_jack_bias) || rx51_eci_mode == 4)
+		enable_bias = 1;
+	else if (rx51_eci_mode == 1 && rx51_jack_func == RX51_JACK_ECI)
+		enable_bias = 1;
+	mutex_unlock(&eci_mutex);
+	if (enable_bias)
+		aic34b_set_mic_bias(2); /* 2.5 V */
+	else
+		aic34b_set_mic_bias(0);
+}
+
+static void rx51_set_jack_bias_handler(struct work_struct *unused)
+{
+	rx51_set_jack_bias();
+}
+DECLARE_WORK(rx51_jack_bias_work, rx51_set_jack_bias_handler);
+
+static void rx51_ext_control(struct snd_soc_codec *codec)
+{
+	int hp = 0, mic = 0, tvout = 0;
+
+	switch (rx51_jack_func) {
+	case RX51_JACK_ECI:
+	case RX51_JACK_HS:
+		mic = 1;
+	case RX51_JACK_HP:
+		hp = 1;
+		break;
+	case RX51_JACK_MIC:
+		mic = 1;
+		break;
+	case RX51_JACK_TVOUT:
+		hp = 1;
+		tvout = 1;
+		break;
+	}
+
+	gpio_set_value(RX51_TVOUT_SEL_GPIO, tvout);
+
+	if (rx51_spk_func)
+		snd_soc_dapm_enable_pin(codec, "Ext Spk");
+	else
+		snd_soc_dapm_disable_pin(codec, "Ext Spk");
+	if (hp)
+		snd_soc_dapm_enable_pin(codec, "Headphone Jack");
+	else
+		snd_soc_dapm_disable_pin(codec, "Headphone Jack");
+	if (mic)
+		snd_soc_dapm_enable_pin(codec, "Mic Jack");
+	else
+		snd_soc_dapm_disable_pin(codec, "Mic Jack");
+	if (rx51_fmtx_func)
+		snd_soc_dapm_enable_pin(codec, "FM Transmitter");
+	else
+		snd_soc_dapm_disable_pin(codec, "FM Transmitter");
+	if (rx51_dmic_func)
+		snd_soc_dapm_enable_pin(codec, "DMic");
+	else
+		snd_soc_dapm_disable_pin(codec, "DMic");
+	if (rx51_ear_func)
+		snd_soc_dapm_enable_pin(codec, "Earphone");
+	else
+		snd_soc_dapm_disable_pin(codec, "Earphone");
+
+	snd_soc_dapm_sync(codec);
+}
+
+int rx51_set_eci_mode(int mode)
+{
+	if (mode < 0 || mode > 4)
+		return -EINVAL;
+
+	mutex_lock(&eci_mutex);
+	if (rx51_eci_mode == mode) {
+		mutex_unlock(&eci_mutex);
+		return 0;
+	}
+
+	rx51_eci_mode = mode;
+	rx51_set_eci_switches(rx51_eci_mode);
+	mutex_unlock(&eci_mutex);
+
+	rx51_set_jack_bias();
+
+	return 0;
+}
+EXPORT_SYMBOL(rx51_set_eci_mode);
+
+static ssize_t eci_mode_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	return sprintf(buf, "%d\n", rx51_eci_mode);
+}
+
+static ssize_t eci_mode_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	int mode, retval;
+	if (sscanf(buf, "%d", &mode) != 1)
+		return -EINVAL;
+	retval = rx51_set_eci_mode(mode);
+
+	return (retval < 0) ? retval : count;
+}
+
+static DEVICE_ATTR(eci_mode, S_IRUGO | S_IWUSR,
+		   eci_mode_show, eci_mode_store);
+
+void rx51_jack_report(int status)
+{
+	snd_jack_report(rx51_jack, status);
+}
+EXPORT_SYMBOL(rx51_jack_report);
+
+static int rx51_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_codec *codec = rtd->socdev->card->codec;
+
+	snd_pcm_hw_constraint_minmax(runtime,
+				     SNDRV_PCM_HW_PARAM_CHANNELS, 2, 2);
+
+	rx51_ext_control(codec);
+
+	return 0;
+}
+
+static int rx51_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	int err;
+
+	/* Set codec DAI configuration */
+	err = snd_soc_dai_set_fmt(codec_dai,
+				  SND_SOC_DAIFMT_DSP_A |
+				  SND_SOC_DAIFMT_IB_NF |
+				  SND_SOC_DAIFMT_CBM_CFM);
+	if (err < 0)
+		return err;
+
+	/* Set cpu DAI configuration */
+	err = snd_soc_dai_set_fmt(cpu_dai,
+				  SND_SOC_DAIFMT_DSP_A |
+				  SND_SOC_DAIFMT_IB_NF |
+				  SND_SOC_DAIFMT_CBM_CFM);
+	if (err < 0)
+		return err;
+
+	/* Set the codec system clock for DAC and ADC */
+	return snd_soc_dai_set_sysclk(codec_dai, 0, 19200000,
+				      SND_SOC_CLOCK_IN);
+}
+
+static int rx51_bt_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+
+	/* Set cpu DAI configuration */
+	return cpu_dai->ops->set_fmt(cpu_dai,
+					SND_SOC_DAIFMT_DSP_A |
+					SND_SOC_DAIFMT_IB_NF |
+					SND_SOC_DAIFMT_CBM_CFM);
+}
+
+static struct snd_soc_ops rx51_bt_ops = {
+	.hw_params = rx51_bt_hw_params,
+};
+
+static struct snd_soc_ops rx51_ops = {
+	.startup = rx51_startup,
+	.hw_params = rx51_hw_params,
+};
+
+static int rx51_get_spk(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = rx51_spk_func;
+
+	return 0;
+}
+
+static int rx51_set_spk(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+
+	if (rx51_spk_func == ucontrol->value.integer.value[0])
+		return 0;
+
+	rx51_spk_func = ucontrol->value.integer.value[0];
+	rx51_ext_control(codec);
+
+	return 1;
+}
+
+static int rx51_spk_event(struct snd_soc_dapm_widget *w,
+			  struct snd_kcontrol *k, int event)
+{
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		gpio_set_value(RX51_SPEAKER_AMP_TWL_GPIO, 1);
+	else
+		gpio_set_value(RX51_SPEAKER_AMP_TWL_GPIO, 0);
+
+	return 0;
+}
+
+static int rx51_get_jack(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = rx51_jack_func;
+
+	return 0;
+}
+
+static int rx51_set_jack(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+
+	if (rx51_jack_func == ucontrol->value.integer.value[0])
+		return 0;
+
+	rx51_jack_func = ucontrol->value.integer.value[0];
+
+	mutex_lock(&eci_mutex);
+	if (rx51_jack_func == RX51_JACK_ECI) {
+		/* Set ECI switches according to ECI mode */
+		rx51_set_eci_switches(rx51_eci_mode);
+		schedule_work(&rx51_jack_bias_work);
+	} else {
+		/*
+		 * Let the codec always be connected to mic/bias line when
+		 * jack is in non-ECI function
+		 */
+		rx51_set_eci_switches(1);
+		schedule_work(&rx51_jack_bias_work);
+	}
+	mutex_unlock(&eci_mutex);
+
+	rx51_ext_control(codec);
+
+	return 1;
+}
+
+static int rx51_jack_hp_event(struct snd_soc_dapm_widget *w,
+			      struct snd_kcontrol *k, int event)
+{
+	struct snd_soc_codec *codec =  snd_kcontrol_chip(k);
+	/*
+	 * Note: HP amp and fmtx must not be enabled at the same
+	 * time. We keep a shadow copy of the desired tpa_enable value but
+	 * keep the hpamp really disabled whenever fmtx is enabled. If
+	 * hpamp is requested on but fmtx is enabled, hpamp is kept
+	 * disabled and enabled later from rx51_set_fmtx function when
+	 * user disables fmtx.
+	 */
+	if (SND_SOC_DAPM_EVENT_ON(event)) {
+		if (!rx51_fmtx_func)
+			snd_soc_dapm_enable_pin(codec, "TPA6130A2 Headphone");
+		tpa6130_enable = 1;
+	} else {
+		tpa6130_enable = 1;
+		snd_soc_dapm_disable_pin(codec, "TPA6130A2 Headphone");
+		tpa6130_enable = 0;
+	}
+
+	return 0;
+}
+
+static int rx51_jack_mic_event(struct snd_soc_dapm_widget *w,
+			       struct snd_kcontrol *k, int event)
+{
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		rx51_dapm_jack_bias = 1;
+	else
+		rx51_dapm_jack_bias = 0;
+	schedule_work(&rx51_jack_bias_work);
+
+	return 0;
+}
+
+static int rx51_get_fmtx(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = rx51_fmtx_func;
+
+	return 0;
+}
+
+static int rx51_set_fmtx(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+
+	if (rx51_fmtx_func == ucontrol->value.integer.value[0])
+		return 0;
+
+	rx51_fmtx_func = ucontrol->value.integer.value[0];
+	rx51_ext_control(codec);
+
+	/* fmtx and tpa must not be enabled at the same time */
+	if (rx51_fmtx_func && tpa6130_enable)
+		snd_soc_dapm_disable_pin(codec, "TPA6130A2 Headphone");
+	if (!rx51_fmtx_func && tpa6130_enable)
+		snd_soc_dapm_enable_pin(codec, "TPA6130A2 Headphone");
+
+	return 1;
+}
+
+static int rx51_get_input(struct snd_kcontrol *kcontrol,
+			  struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = rx51_dmic_func;
+
+	return 0;
+}
+
+static int rx51_set_input(struct snd_kcontrol *kcontrol,
+			  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+
+	if (rx51_dmic_func == ucontrol->value.integer.value[0])
+		return 0;
+
+	rx51_dmic_func = ucontrol->value.integer.value[0];
+	rx51_ext_control(codec);
+
+	return 1;
+}
+
+static int rx51_get_ear(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = rx51_ear_func;
+
+	return 0;
+}
+
+static int rx51_set_ear(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+
+	if (rx51_ear_func == ucontrol->value.integer.value[0])
+		return 0;
+
+	rx51_ear_func = ucontrol->value.integer.value[0];
+	rx51_ext_control(codec);
+
+	return 1;
+}
+
+static int rx51_ear_event(struct snd_soc_dapm_widget *w,
+			  struct snd_kcontrol *k, int event)
+{
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		aic34b_ear_enable(1);
+	else
+		aic34b_ear_enable(0);
+
+	return 0;
+}
+
+enum {
+       RX51_EXT_API_AIC34B,
+};
+#define SOC_RX51_EXT_SINGLE_TLV(xname, ext_api, max, tlv_array) \
+{ \
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
+		  SNDRV_CTL_ELEM_ACCESS_READWRITE, \
+	.tlv.p = (tlv_array), \
+	.info = rx51_ext_info_volsw, \
+	.get = rx51_ext_get_volsw, \
+	.put = rx51_ext_put_volsw, \
+	.private_value = (ext_api) << 26 | (max) << 16, \
+}
+
+static int rx51_ext_info_volsw(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_info *uinfo)
+{
+	int max = (kcontrol->private_value >> 16) & 0xff;
+
+	if (max == 1)
+		uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	else
+		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = max;
+
+	return 0;
+}
+
+static int rx51_ext_get_volsw(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	int ext_api = (kcontrol->private_value >> 26) & 0x0f;
+
+	switch (ext_api) {
+	case RX51_EXT_API_AIC34B:
+		ucontrol->value.integer.value[0] = aic34b_volume;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rx51_ext_put_volsw(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	int ext_api = (kcontrol->private_value >> 26) & 0x0f;
+	int change = 0;
+
+	switch (ext_api) {
+	case RX51_EXT_API_AIC34B:
+		change = (aic34b_volume != ucontrol->value.integer.value[0]);
+		aic34b_volume = ucontrol->value.integer.value[0];
+		aic34b_set_volume(aic34b_volume);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return change;
+}
+
+static const struct snd_soc_dapm_widget aic34_dapm_widgets[] = {
+	SND_SOC_DAPM_SPK("Ext Spk", rx51_spk_event),
+	SND_SOC_DAPM_SPK("Headphone Jack", rx51_jack_hp_event),
+	SND_SOC_DAPM_MIC("Mic Jack", rx51_jack_mic_event),
+	SND_SOC_DAPM_OUTPUT("FM Transmitter"),
+	SND_SOC_DAPM_MIC("DMic", NULL),
+	SND_SOC_DAPM_SPK("Earphone", rx51_ear_event),
+};
+
+static const struct snd_soc_dapm_route audio_map[] = {
+	{"Ext Spk", NULL, "HPLOUT"},
+	{"Ext Spk", NULL, "HPROUT"},
+
+	{"TPA6130A2 Headphone", NULL, "LLOUT"},
+	{"TPA6130A2 Headphone", NULL, "RLOUT"},
+	{"LINE1L", NULL, "Mic Jack"},
+
+	{"FM Transmitter", NULL, "LLOUT"},
+	{"FM Transmitter", NULL, "RLOUT"},
+
+	{"Earphone", NULL, "MONO_LOUT"},
+
+	{"DMic Rate 64", NULL, "Mic Bias 2V"},
+	{"Mic Bias 2V", NULL, "DMic"},
+};
+
+static const char *spk_function[] = {"Off", "On"};
+static const char *jack_function[] = {"Off", "Headphone", "Headset",
+				      "Mic", "ECI Headset", "TV-OUT"};
+static const char *fmtx_function[] = {"Off", "On"};
+static const char *input_function[] = {"ADC", "Digital Mic"};
+static const char *ear_function[] = {"Off", "On"};
+
+static const struct soc_enum rx51_enum[] = {
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(spk_function), spk_function),
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(jack_function), jack_function),
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(fmtx_function), fmtx_function),
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(input_function), input_function),
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(ear_function), ear_function),
+};
+
+/*
+ * TLV320AIC3x output stage volumes. From -78.3 to 0 dB. Muted below -78.3 dB.
+ * Step size is approximately 0.5 dB over most of the scale but increasing
+ * near the very low levels.
+ * Define dB scale so that it is mostly correct for range about -55 to 0 dB
+ * but having increasing dB difference below that (and where it doesn't count
+ * so much). This setting shows -50 dB (actual is -50.3 dB) for register
+ * value 100 and -58.5 dB (actual is -78.3 dB) for register value 117.
+ */
+static DECLARE_TLV_DB_SCALE(aic3x_output_stage_tlv, -5900, 50, 1);
+
+static const struct snd_kcontrol_new aic34_rx51_controls[] = {
+	SOC_ENUM_EXT("Speaker Function", rx51_enum[0],
+		     rx51_get_spk, rx51_set_spk),
+	SOC_ENUM_EXT("Jack Function", rx51_enum[1],
+		     rx51_get_jack, rx51_set_jack),
+	SOC_ENUM_EXT("FMTX Function", rx51_enum[2],
+		     rx51_get_fmtx, rx51_set_fmtx),
+	SOC_ENUM_EXT("Input Select",  rx51_enum[3],
+		     rx51_get_input, rx51_set_input),
+	SOC_ENUM_EXT("Earphone Function",  rx51_enum[4],
+		     rx51_get_ear, rx51_set_ear),
+	SOC_RX51_EXT_SINGLE_TLV("Earphone Playback Volume",
+				RX51_EXT_API_AIC34B, 118,
+				aic3x_output_stage_tlv),
+};
+
+static int rx51_aic34_init(struct snd_soc_codec *codec)
+{
+	int i, err;
+
+	/* Add TPA6130A2 controls */
+	tpa6130a2_add_controls(codec);
+
+	/* set up NC codec pins */
+	snd_soc_dapm_nc_pin(codec, "MIC3L");
+	snd_soc_dapm_nc_pin(codec, "MIC3R");
+	snd_soc_dapm_nc_pin(codec, "LINE1R");
+
+	/* Create jack for accessory reporting */
+	err = snd_jack_new(codec->card, "Jack", SND_JACK_MECHANICAL |
+			SND_JACK_HEADSET | SND_JACK_AVOUT, &rx51_jack);
+	if (err < 0)
+		return err;
+
+	/* Add RX51 specific controls */
+	for (i = 0; i < ARRAY_SIZE(aic34_rx51_controls); i++) {
+		err = snd_ctl_add(codec->card,
+			snd_soc_cnew(&aic34_rx51_controls[i], codec, NULL));
+		if (err < 0)
+			return err;
+	}
+
+	/* Add RX51 specific widgets */
+	snd_soc_dapm_new_controls(codec, aic34_dapm_widgets,
+				  ARRAY_SIZE(aic34_dapm_widgets));
+
+	/* Set up RX51 specific audio path audio_map */
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+
+	snd_soc_dapm_enable_pin(codec, "Earphone");
+
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+/* Since all codec control is done by Bluetooth hardware
+   only some constrains need to be set for it */
+struct snd_soc_dai btcodec_dai = {
+	.name = "Bluetooth codec",
+	.playback = {
+		.stream_name = "BT Playback",
+		.channels_min = 1,
+		.channels_max = 1,
+		.rates = SNDRV_PCM_RATE_8000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+	.capture = {
+		.stream_name = "BT Capture",
+		.channels_min = 1,
+		.channels_max = 1,
+		.rates = SNDRV_PCM_RATE_8000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+};
+
+/* Digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link rx51_dai[] = {
+	{
+		.name = "TLV320AIC34",
+		.stream_name = "AIC34",
+		.cpu_dai = &omap_mcbsp_dai[0],
+		.codec_dai = &aic3x_dai,
+		.init = rx51_aic34_init,
+		.ops = &rx51_ops,
+	}, {
+		.name = "Bluetooth PCM",
+		.stream_name = "Bluetooth",
+		.cpu_dai = &omap_mcbsp_dai[1],
+		.codec_dai = &btcodec_dai,
+		.ops = &rx51_bt_ops,
+	}
+};
+
+/* Audio private data */
+static struct aic3x_setup_data rx51_aic34_setup = {
+	.gpio_func[0] = AIC3X_GPIO1_FUNC_DISABLED,
+	.gpio_func[1] = AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT,
+};
+
+/* Audio card */
+static struct snd_soc_card rx51_sound_card = {
+	.name = "RX51",
+	.dai_link = rx51_dai,
+	.num_links = ARRAY_SIZE(rx51_dai),
+	.platform = &omap_soc_platform,
+};
+
+/* Audio subsystem */
+static struct snd_soc_device rx51_snd_devdata = {
+	.card = &rx51_sound_card,
+	.codec_dev = &soc_codec_dev_aic3x,
+	.codec_data = &rx51_aic34_setup,
+};
+
+static struct platform_device *rx51_snd_device;
+
+#define REMAP_OFFSET		2
+#define DEDICATED_OFFSET	3
+#define VMMC2_DEV_GRP		0x2B
+#define VMMC2_285V		0x0a
+
+static int __init rx51_soc_init(void)
+{
+	int err;
+	struct device *dev;
+
+	if (!machine_is_nokia_rx51())
+		return -ENODEV;
+
+	if (gpio_request(RX51_CODEC_RESET_GPIO, NULL) < 0)
+		BUG();
+	if (gpio_request(RX51_TVOUT_SEL_GPIO, "tvout_sel") < 0)
+		BUG();
+	if (gpio_request(RX51_ECI_SWITCH_1_GPIO, "ECI switch 1") < 0)
+		BUG();
+	if (gpio_request(RX51_ECI_SWITCH_2_GPIO, "ECI switch 2") < 0)
+		BUG();
+	gpio_direction_output(RX51_CODEC_RESET_GPIO, 0);
+	gpio_direction_output(RX51_TVOUT_SEL_GPIO, 0);
+	gpio_direction_output(RX51_ECI_SWITCH_1_GPIO, 0);
+	gpio_direction_output(RX51_ECI_SWITCH_2_GPIO, 1);
+
+	gpio_set_value(RX51_CODEC_RESET_GPIO, 0);
+	udelay(1);
+	gpio_set_value(RX51_CODEC_RESET_GPIO, 1);
+	msleep(1);
+
+	if (gpio_request(RX51_SPEAKER_AMP_TWL_GPIO, NULL) < 0)
+		BUG();
+	gpio_direction_output(RX51_SPEAKER_AMP_TWL_GPIO, 0);
+
+	err = snd_soc_register_dai(&btcodec_dai);
+	if (err)
+		return err;
+
+	rx51_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!rx51_snd_device) {
+		err = -ENOMEM;
+		goto err0;
+	}
+
+	platform_set_drvdata(rx51_snd_device, &rx51_snd_devdata);
+	rx51_snd_devdata.dev = &rx51_snd_device->dev;
+	err = platform_device_add(rx51_snd_device);
+	if (err)
+		goto err1;
+
+	dev = &rx51_snd_device->dev;
+
+	*(unsigned int *)rx51_dai[0].cpu_dai->private_data = 1;
+	*(unsigned int *)rx51_dai[1].cpu_dai->private_data = 2;
+
+	err = device_create_file(dev, &dev_attr_eci_mode);
+	if (err)
+		goto err2;
+
+	return err;
+err2:
+	platform_device_del(rx51_snd_device);
+err1:
+	platform_device_put(rx51_snd_device);
+err0:
+	snd_soc_unregister_dai(&btcodec_dai);
+
+	return err;
+
+}
+
+static void __exit rx51_soc_exit(void)
+{
+	platform_device_unregister(rx51_snd_device);
+	snd_soc_unregister_dai(&btcodec_dai);
+}
+
+module_init(rx51_soc_init);
+module_exit(rx51_soc_exit);
+
+MODULE_AUTHOR("Nokia Corporation");
+MODULE_DESCRIPTION("ALSA SoC Nokia RX51");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/omap/rx51.h b/sound/soc/omap/rx51.h
new file mode 100644
index 0000000..ee55260
--- /dev/null
+++ b/sound/soc/omap/rx51.h
@@ -0,0 +1,29 @@
+#ifndef _RX51_H_
+#define _RX51_H_
+
+/*
+ *  rx51.h - SoC audio for Nokia RX51
+ *
+ *  Copyright (C) 2008 - 2009 Nokia Corporation
+ *
+ *  Contact: Peter Ujfalusi <peter.ujfalusi@nokia.com>
+ *           Eduardo Valentin <eduardo.valentin@nokia.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+int rx51_set_eci_mode(int mode);
+void rx51_jack_report(int status);
+
+#endif /* _RX51_H_ */
-- 
1.6.4.183.g04423

