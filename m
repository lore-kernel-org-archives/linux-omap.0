From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 28/33] add tsc2301 driver
Date: Sat, 30 Aug 2008 20:16:28 +0300
Message-ID: <1220116593-862-29-git-send-email-me@felipebalbi.com>
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
 <1220116593-862-15-git-send-email-me@felipebalbi.com>
 <1220116593-862-16-git-send-email-me@felipebalbi.com>
 <1220116593-862-17-git-send-email-me@felipebalbi.com>
 <1220116593-862-18-git-send-email-me@felipebalbi.com>
 <1220116593-862-19-git-send-email-me@felipebalbi.com>
 <1220116593-862-20-git-send-email-me@felipebalbi.com>
 <1220116593-862-21-git-send-email-me@felipebalbi.com>
 <1220116593-862-22-git-send-email-me@felipebalbi.com>
 <1220116593-862-23-git-send-email-me@felipebalbi.com>
 <1220116593-862-24-git-send-email-me@felipebalbi.com>
 <1220116593-862-25-git-send-email-me@felipebalbi.com>
 <1220116593-862-26-git-send-email-me@felipebalbi.com>
 <1220116593-862-27-git-send-email-me@felipebalbi.com>
 <1220116593-862-28-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:36949 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753226AbYH3RYT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Aug 2008 13:24:19 -0400
In-Reply-To: <1220116593-862-28-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

=46rom: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/spi/Kconfig         |   22 +
 drivers/spi/Makefile        |    3 +
 drivers/spi/tsc2301-core.c  |  301 +++++++++++++
 drivers/spi/tsc2301-mixer.c | 1004 +++++++++++++++++++++++++++++++++++=
++++++++
 4 files changed, 1330 insertions(+), 0 deletions(-)
 create mode 100644 drivers/spi/tsc2301-core.c
 create mode 100644 drivers/spi/tsc2301-mixer.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 2a200ff..c891c1e 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -244,6 +244,28 @@ config SPI_TSC210X
 	  automatically enable touchscreen, sensors or audio
 	  functionality - enable these in their respective menus.
=20
+config SPI_TSC2301
+	tristate "TSC2301 driver"
+	depends on SPI_MASTER
+	help
+	  Say Y here if you have a TSC2301 chip connected to an SPI
+	  bus on your board.
+
+	  The TSC2301 is a highly integrated PDA analog interface circuit.
+	  It contains a complete 12-bit A/D resistive touch screen
+	  converter (ADC) including drivers, touch pressure measurement
+	  capability, keypad controller, and 8-bit D/A converter (DAC) output
+	  for LCD contrast control.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called tsc2301.
+
+config SPI_TSC2301_AUDIO
+	boolean "TSC2301 audio support"
+	depends on SPI_TSC2301 && SND
+	help
+	  Say Y here for if you are using the audio features of TSC2301.
+
 config SPI_SPIDEV
 	tristate "User mode SPI device driver support"
 	depends on EXPERIMENTAL
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index bf12723..f3841c8 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -36,6 +36,9 @@ obj-$(CONFIG_SPI_AT25)		+=3D at25.o
 obj-$(CONFIG_SPI_SPIDEV)	+=3D spidev.o
 obj-$(CONFIG_SPI_TLE62X0)	+=3D tle62x0.o
 obj-$(CONFIG_SPI_TSC210X)	+=3D tsc210x.o
+obj-$(CONFIG_SPI_TSC2301)	+=3D tsc2301.o
+tsc2301-objs			:=3D tsc2301-core.o
+tsc2301-$(CONFIG_SPI_TSC2301_AUDIO)	+=3D tsc2301-mixer.o
 # 	... add above this line ...
=20
 # SPI slave controller drivers (upstream link)
diff --git a/drivers/spi/tsc2301-core.c b/drivers/spi/tsc2301-core.c
new file mode 100644
index 0000000..939bc48
--- /dev/null
+++ b/drivers/spi/tsc2301-core.c
@@ -0,0 +1,301 @@
+/*
+ * TSC2301 driver
+ *
+ * Copyright (C) 2005, 2006 Nokia Corporation
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License as published b=
y
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307=
 USA
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/tsc2301.h>
+
+#ifdef CONFIG_ARCH_OMAP
+#include <mach/gpio.h>
+#endif
+
+u16 tsc2301_read_reg(struct tsc2301 *tsc, int reg)
+{
+	struct spi_transfer t[2];
+	struct spi_message m;
+	u16 data =3D 0, cmd;
+
+	cmd =3D reg;
+	cmd |=3D 0x8000;
+
+	memset(t, 0, sizeof(t));
+	spi_message_init(&m);
+	m.spi =3D tsc->spi;
+
+	t[0].tx_buf =3D &cmd;
+	t[0].rx_buf =3D NULL;
+	t[0].len =3D 2;
+	spi_message_add_tail(&t[0], &m);
+
+	t[1].tx_buf =3D NULL;
+	t[1].rx_buf =3D &data;
+	t[1].len =3D 2;
+	spi_message_add_tail(&t[1], &m);
+
+	spi_sync(m.spi, &m);
+
+	return data;
+}
+
+void tsc2301_write_reg(struct tsc2301 *tsc, int reg, u16 val)
+{
+	struct spi_transfer t;
+	struct spi_message m;
+	u16 data[2];
+
+	/* Now we prepare the command for transferring */
+	data[0] =3D reg;
+	data[1] =3D val;
+
+	spi_message_init(&m);
+	m.spi =3D tsc->spi;
+
+	memset(&t, 0, sizeof(t));
+	t.tx_buf =3D data;
+	t.rx_buf =3D NULL;
+	t.len =3D 4;
+	spi_message_add_tail(&t, &m);
+
+	spi_sync(m.spi, &m);
+}
+
+void tsc2301_write_kbc(struct tsc2301 *tsc, int val)
+{
+	u16 w;
+
+	w =3D tsc->config2_shadow;
+	w &=3D ~(0x03 << 14);
+	w |=3D (val & 0x03) << 14;
+	tsc2301_write_reg(tsc, TSC2301_REG_CONFIG2, w);
+	tsc->config2_shadow =3D w;
+}
+
+void tsc2301_write_pll(struct tsc2301 *tsc,
+		       int pll_n, int pll_a, int pll_pdc, int pct_e, int pll_o)
+{
+	u16 w;
+
+	w =3D tsc->config2_shadow;
+	w &=3D ~0x3fff;
+	w |=3D (pll_n & 0x0f) | ((pll_a & 0x0f) << 4) | ((pll_pdc & 0x0f) << =
8);
+	w |=3D pct_e ? (1 << 12) : 0;
+	w |=3D pll_o ? (1 << 13) : 0;
+	tsc2301_write_reg(tsc, TSC2301_REG_CONFIG2, w);
+	tsc->config2_shadow =3D w;
+}
+
+void tsc2301_read_buf(struct tsc2301 *tsc, int reg, u16 *rx_buf, int l=
en)
+{
+	struct spi_transfer t[2];
+	struct spi_message m;
+	u16 cmd, i;
+
+	cmd =3D reg;
+	cmd |=3D 0x8000;
+
+	spi_message_init(&m);
+	m.spi =3D tsc->spi;
+
+	memset(t, 0, sizeof(t));
+	t[0].tx_buf =3D &cmd;
+	t[0].rx_buf =3D NULL;
+	t[0].len =3D 2;
+	spi_message_add_tail(&t[0], &m);
+
+	t[1].tx_buf =3D NULL;
+	t[1].rx_buf =3D rx_buf;
+	t[1].len =3D 2 * len;
+	spi_message_add_tail(&t[1], &m);
+
+	spi_sync(m.spi, &m);
+
+	for (i =3D 0; i < len; i++)
+		printk(KERN_DEBUG "rx_buf[%d]: %04x\n", i, rx_buf[i]);
+}
+
+static int __devinit tsc2301_probe(struct spi_device *spi)
+{
+	struct tsc2301			*tsc;
+	struct tsc2301_platform_data	*pdata =3D spi->dev.platform_data;
+	int r;
+	u16 w;
+
+	if (!pdata) {
+		dev_dbg(&spi->dev, "no platform data?\n");
+		return -ENODEV;
+	}
+
+	tsc =3D kzalloc(sizeof(*tsc), GFP_KERNEL);
+	if (tsc =3D=3D NULL)
+		return -ENOMEM;
+
+	dev_set_drvdata(&spi->dev, tsc);
+	tsc->spi =3D spi;
+
+	tsc->enable_clock =3D pdata->enable_clock;
+	tsc->disable_clock =3D pdata->disable_clock;
+
+	if (pdata->reset_gpio >=3D 0) {
+		tsc->reset_gpio =3D pdata->reset_gpio;
+#ifdef CONFIG_ARCH_OMAP
+		r =3D omap_request_gpio(tsc->reset_gpio);
+		if (r < 0)
+			goto err1;
+		omap_set_gpio_dataout(tsc->reset_gpio, 1);
+		omap_set_gpio_direction(tsc->reset_gpio, 0);
+		mdelay(1);
+		omap_set_gpio_dataout(tsc->reset_gpio, 0);
+#endif
+	} else
+		tsc->reset_gpio =3D -1;
+
+	spi->mode =3D SPI_MODE_1;
+	spi->bits_per_word =3D 16;
+	/* The max speed might've been defined by the board-specific
+	 * struct */
+	if (!spi->max_speed_hz)
+		spi->max_speed_hz =3D TSC2301_HZ;
+	spi_setup(spi);
+
+	/* Soft reset */
+	tsc2301_write_reg(tsc, TSC2301_REG_RESET, 0xbb00);
+	msleep(1);
+
+	w =3D tsc2301_read_reg(tsc, TSC2301_REG_ADC);
+	if (!(w & (1 << 14))) {
+		dev_err(&spi->dev, "invalid ADC reg value: %04x\n", w);
+		r =3D -ENODEV;
+		goto err1;
+	}
+
+	w =3D tsc2301_read_reg(tsc, TSC2301_REG_DAC);
+	if (!(w & (1 << 15))) {
+		dev_err(&spi->dev, "invalid DAC reg value: %04x\n", w);
+		r =3D -ENODEV;
+		goto err1;
+	}
+
+	/* Stop keypad scanning */
+	tsc2301_write_reg(tsc, TSC2301_REG_KEY, 0x4000);
+
+	/* We have to cache this for read-modify-write, since we can't
+	 * read back BIT15 */
+	w =3D tsc2301_read_reg(tsc, TSC2301_REG_CONFIG2);
+	/* By default BIT15 is set */
+	w |=3D 1 << 15;
+	tsc->config2_shadow =3D w;
+
+	r =3D tsc2301_kp_init(tsc, pdata);
+	if (r)
+		goto err1;
+	r =3D tsc2301_ts_init(tsc, pdata);
+	if (r)
+		goto err2;
+	r =3D tsc2301_mixer_init(tsc, pdata);
+	if (r)
+		goto err3;
+	return 0;
+
+err3:
+	tsc2301_ts_exit(tsc);
+err2:
+	tsc2301_kp_exit(tsc);
+err1:
+	kfree(tsc);
+	return r;
+}
+
+static int __devexit tsc2301_remove(struct spi_device *spi)
+{
+	struct tsc2301 *tsc =3D dev_get_drvdata(&spi->dev);
+
+	tsc2301_mixer_exit(tsc);
+        tsc2301_ts_exit(tsc);
+        tsc2301_kp_exit(tsc);
+	kfree(tsc);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int tsc2301_suspend(struct spi_device *spi, pm_message_t mesg)
+{
+	struct tsc2301 *tsc =3D dev_get_drvdata(&spi->dev);
+	int r;
+
+	if ((r =3D tsc2301_mixer_suspend(tsc)) < 0)
+		return r;
+	if ((r =3D tsc2301_kp_suspend(tsc)) < 0)
+		goto err1;
+	if ((r =3D tsc2301_ts_suspend(tsc)) < 0)
+		goto err2;
+
+	return 0;
+err2:
+	tsc2301_kp_resume(tsc);
+err1:
+	tsc2301_mixer_resume(tsc);
+	return r;
+}
+
+static int tsc2301_resume(struct spi_device *spi)
+{
+	struct tsc2301 *tsc =3D dev_get_drvdata(&spi->dev);
+
+	tsc2301_ts_resume(tsc);
+	tsc2301_kp_resume(tsc);
+	tsc2301_mixer_resume(tsc);
+	return 0;
+}
+#endif
+
+static struct spi_driver tsc2301_driver =3D {
+	.driver =3D {
+		   .name =3D "tsc2301",
+		   .bus =3D &spi_bus_type,
+		   .owner =3D THIS_MODULE,
+	},
+#ifdef CONFIG_PM
+	.suspend =3D tsc2301_suspend,
+	.resume =3D tsc2301_resume,
+#endif
+	.probe =3D tsc2301_probe,
+	.remove =3D __devexit_p(tsc2301_remove),
+};
+
+static int __init tsc2301_init(void)
+{
+	printk("TSC2301 driver initializing\n");
+
+	return spi_register_driver(&tsc2301_driver);
+}
+module_init(tsc2301_init);
+
+static void __exit tsc2301_exit(void)
+{
+	spi_unregister_driver(&tsc2301_driver);
+}
+module_exit(tsc2301_exit);
+
+MODULE_AUTHOR("Juha Yrj=F6l=E4 <juha.yrjola@nokia.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/spi/tsc2301-mixer.c b/drivers/spi/tsc2301-mixer.c
new file mode 100644
index 0000000..31ec87c
--- /dev/null
+++ b/drivers/spi/tsc2301-mixer.c
@@ -0,0 +1,1004 @@
+/*
+ * ALSA Mixer implementation for TSC2301
+ *
+ * Copyright (C) 2006 Nokia Corporation.
+ *
+ * Contact: Jarkko Nikula <jarkko.nikula@nokia.com>
+ *          Juha Yrjola
+ *
+ * Some notes about TSC2301:
+ * - PLL will stop when DAC and ADC's are powered down.
+ * - Touchscreen will stop working when audio part is powered up and i=
f audio
+ *   MCLK is stopped. Problem is avoided if audio is powered down befo=
re
+ *   stopping MCLK.
+ * - Audio DAC or audio outputs will activate only after 100 msec from=
 the
+ *   chip power-up. Reason seems to be VCM since there is no this dela=
y if the
+ *   chip and VCM (bit AVPD on PD/MISC) were not powered down. The chi=
p will
+ *   consume about 1 mA if all other audio blocks are powered down exc=
ept the
+ *   chip itself and VCM. Full power down consumes only about few uA.
+ * - Power-down transition could happen earliest about 100 msec after =
the chip
+ *   power-up. Otherwise power-down will fail if there is no that 100 =
msec
+ *   on time before it. It's not obvious why is that since chip report=
s
+ *   power-up to be completed and also PLL output on GPIO_0 is active =
in few
+ *   milliseconds.
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
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/tsc2301.h>
+
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/control.h>
+
+/* shadow register indexes */
+enum {
+	/* audio control and volume registers */
+	AUDCNTL_INDEX,
+	ADCVOL_INDEX,
+	DACVOL_INDEX,
+	BPVOL_INDEX,
+	/* keyclick control register (not needed here) */
+	/* audio power control register */
+	PD_MISC_INDEX,
+	/* TSC2301 GPIO control register */
+	GPIO_INDEX,
+
+	SHADOW_REG_COUNT,
+};
+
+/* structure for driver private data */
+struct tsc2301_mixer {
+	struct tsc2301 *tsc;
+	struct mutex mutex;
+
+	/* shadow registers holding TSC2301 audio registers. Used to hold
+	 * their states during the sleep and also to reduce communication wit=
h
+	 * the chip since get callback functions could get register values
+	 * directly from these shadow registers without needing to read them
+	 * from the chip */
+	u16 shadow_regs[SHADOW_REG_COUNT];
+
+	/* audio controller driver usage of the ADC and DAC */
+	unsigned adc_enabled:1, dac_enabled:1;
+	unsigned pll_output:1;
+	unsigned mclk_enabled;
+
+	/* latest audio power-up timestamp */
+	unsigned long pu_jiffies;
+
+	/* these are used when upper layer(s) are going to power-down TSC2301
+	 * before 100 msec is passed from power-up */
+	struct delayed_work delayed_power_down;
+	unsigned delayed_pd_active:1;
+
+	int (* platform_init)(struct device *);
+	void (* platform_cleanup)(struct device *);
+
+	struct tsc2301_mixer_gpio *mixer_gpios;
+	int n_mixer_gpios;
+};
+
+#define TSC2301_DAC_DELAY		msecs_to_jiffies(100)
+#define TSC2301_MIN_PU_PERIOD		msecs_to_jiffies(100)
+
+#define TSC2301_REG_TO_PVAL(reg)	\
+	(TSC2301_REG_TO_PAGE(reg) << 6 | TSC2301_REG_TO_ADDR(reg))
+#define  TSC2301_PVAL_TO_REG(v)		\
+	(TSC2301_REG((((v) >> 6) & 3),((v) & 0x1f)))
+
+#define TSC2301_VOLUME_MASK		0x7f
+#define TSC2301_MIN_ADCVOL		6
+#define TSC2301_MIN_DACVOL		0
+#define TSC2301_MIN_BPVOL		31
+#define TSC2301_MUTE_LEFT_SHIFT		15
+#define TSC2301_VOL_LEFT_SHIFT		8
+#define TSC2301_MUTE_RIGHT_SHIFT	7
+#define TSC2301_VOL_RIGHT_SHIFT		0
+
+#define TSC2301_INM_MASK		3
+#define TSC2301_INML_SHIFT		12
+#define TSC2301_INMR_SHIFT		10
+
+#define TSC2301_MICG_MASK		3
+#define TSC2301_MICG_MIN		1 /* values 0 & 1 both mean 0 dB */
+#define TSC2301_MICG_SHIFT		8
+
+#define TSC2301_REG_AUDCNTL_MCLK(v)	(((v) & 3) << 6)
+#define TSC2301_REG_AUDCNTL_I2SFS(v)	(((v) & 0xf) << 2)
+#define TSC2301_REG_AUDCNTL_I2SFM(v)	(((v) & 3) << 0)
+
+#define TSC2301_SINGLE(xname, xindex, reg, shadow_index, shift, mask, =
min) \
+{\
+	.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name =3D xname, \
+	.index =3D xindex, \
+	.info =3D snd_tsc2301_info_single, \
+	.get =3D snd_tsc2301_get_single, \
+	.put =3D snd_tsc2301_put_single, \
+	.private_value =3D TSC2301_REG_TO_PVAL(reg) | \
+		(shadow_index << 8) | (shift << 16) | (mask << 24) | \
+		(min << 28) \
+}
+#define TSC2301_SINGLE_MINVAL(v)	(((v) >> 28) & 15)
+#define TSC2301_SINGLE_SHIFT(v)		(((v) >> 16) & 15)
+#define TSC2301_SINGLE_MASK(v)		(((v) >> 24) & 15)
+
+#define TSC2301_DOUBLE(xname, xindex, reg, shadow_index, ls, rs, mask,=
 min) \
+{\
+	.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name =3D xname, \
+	.index =3D xindex, \
+	.info =3D snd_tsc2301_info_double, \
+	.get =3D snd_tsc2301_get_double, \
+	.put =3D snd_tsc2301_put_double, \
+	.private_value =3D TSC2301_REG_TO_PVAL(reg) | \
+		(shadow_index << 8) | (min << 11) | \
+		(ls << 16) | (rs << 20) | (mask << 24) \
+}
+#define TSC2301_DOUBLE_MINVAL(v)	(((v) >> 11) & 0x1f)
+#define TSC2301_DOUBLE_LEFT_SHIFT(v)	(((v) >> 16) & 15)
+#define TSC2301_DOUBLE_RIGHT_SHIFT(v)	(((v) >> 20) & 15)
+#define TSC2301_DOUBLE_MASK(v)		(((v) >> 24) & TSC2301_VOLUME_MASK)
+
+#define TSC2301_MUX(xname, xindex, reg, shadow_index, ls, rs, mask) \
+{\
+	.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name =3D xname, \
+	.index =3D xindex, \
+	.info =3D snd_tsc2301_info_mux, \
+	.get =3D snd_tsc2301_get_mux, \
+	.put =3D snd_tsc2301_put_mux, \
+	.private_value =3D TSC2301_REG_TO_PVAL(reg) | \
+		(shadow_index << 8) | (ls << 16) | (rs << 20) | (mask << 24) \
+}
+#define TSC2301_MUX_LEFT_SHIFT(v)	(((v) >> 16) & 15)
+#define TSC2301_MUX_RIGHT_SHIFT(v)	(((v) >> 20) & 15)
+#define TSC2301_MUX_MASK(v)		(((v) >> 24) & TSC2301_VOLUME_MASK)
+
+#define TSC2301_BOOL(xname, xindex, reg, shadow_index, shift, invert, =
state) \
+{ \
+	.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name =3D xname, \
+	.index =3D xindex, \
+	.info =3D snd_tsc2301_info_bool, \
+	.get =3D snd_tsc2301_get_bool, \
+	.put =3D snd_tsc2301_put_bool, \
+	.private_value =3D TSC2301_REG_TO_PVAL(reg) | \
+		(shadow_index << 8) | (shift << 16) | \
+		(invert << 24) | (state << 25) \
+}
+#define TSC2301_BOOL_SHIFT(v)		(((v) >> 16) & 7)
+#define TSC2301_BOOL_INVERT(v)		(((v) >> 24) & 1)
+#define TSC2301_BOOL_STATE(v)		(((v) >> 25) & 1)
+
+#define TSC2301_SHADOW_INDEX(v)		(((v) >> 8) & 7)
+
+/*
+ * Power-down handler for additional GPIO mixer controls. GPIO state o=
f GPIO
+ * controls whose power-down flag is enabled are set to their false/de=
activate
+ * state
+ *
+ * Must be called tsc->mixer->mutex locked
+ */
+static void tsc2301_gpio_power_down(struct tsc2301 *tsc)
+{
+	struct tsc2301_mixer *mix =3D tsc->mixer;
+	u16 temp;
+	int i;
+
+	temp =3D mix->shadow_regs[GPIO_INDEX];
+	for (i =3D 0; i < mix->n_mixer_gpios; i++) {
+		const struct tsc2301_mixer_gpio *mg;
+
+		mg =3D mix->mixer_gpios + i;
+		if (mg->deactivate_on_pd) {
+			int gpio =3D mg->gpio;
+
+			temp &=3D ~(1 << gpio);
+			temp |=3D mg->inverted << gpio;
+		}
+	}
+	tsc2301_write_reg(tsc, TSC2301_REG_GPIO, temp);
+}
+
+/*
+ * Powers down/up audio blocks which are muted or become unused.
+ * shadow_index >=3D 0, changes power state of single audio block
+ * shadow_index < 0, changes power state of all blocks
+ *
+ * Must be called tsc->mixer->mutex locked
+ */
+#define TSC2301_MUTE_MASK \
+	((1 << TSC2301_MUTE_LEFT_SHIFT) | (1 << TSC2301_MUTE_RIGHT_SHIFT))
+static void tsc2301_power_ctrl(struct tsc2301 *tsc, int shadow_index,
+			       int poll_pdsts)
+{
+	struct tsc2301_mixer *mix =3D tsc->mixer;
+	u16 pd_ctrl, pd_ctrl_old, w;
+	unsigned long timeout;
+	int power_up =3D 0;
+
+	if (mix->delayed_pd_active) {
+		mix->delayed_pd_active =3D 0;
+		mix->mclk_enabled--;
+		cancel_delayed_work(&mix->delayed_power_down);
+	}
+
+	pd_ctrl =3D pd_ctrl_old =3D mix->shadow_regs[PD_MISC_INDEX];
+	/* power control helper based on used space mixer selections. See
+	 * actual power control decisions below */
+	if (shadow_index < 0 || shadow_index =3D=3D ADCVOL_INDEX) {
+		/* ADC left and right power down control */
+		if (mix->shadow_regs[ADCVOL_INDEX] &
+		    (1 << TSC2301_MUTE_LEFT_SHIFT))
+			/* left ADC muted. Power down the left ADC */
+			pd_ctrl |=3D TSC2301_REG_PD_MISC_ADPDL;
+		else
+			pd_ctrl &=3D ~TSC2301_REG_PD_MISC_ADPDL;
+		if (mix->shadow_regs[ADCVOL_INDEX] &
+		    (1 << TSC2301_MUTE_LEFT_SHIFT))
+			/* right ADC muted. Power down the right ADC */
+			pd_ctrl |=3D TSC2301_REG_PD_MISC_ADPDR;
+		else
+			pd_ctrl &=3D ~TSC2301_REG_PD_MISC_ADPDR;
+	}
+	if (shadow_index < 0 || shadow_index =3D=3D DACVOL_INDEX) {
+		/* DAC power down control */
+		if ((mix->shadow_regs[DACVOL_INDEX] &
+		     TSC2301_MUTE_MASK) =3D=3D TSC2301_MUTE_MASK)
+			/* both DACs muted. Power down the DAC */
+			pd_ctrl |=3D TSC2301_REG_PD_MISC_DAPD;
+		else
+			pd_ctrl &=3D ~TSC2301_REG_PD_MISC_DAPD;
+	}
+	if (shadow_index < 0 || shadow_index =3D=3D BPVOL_INDEX) {
+		/* line bypass power down control */
+		if ((mix->shadow_regs[BPVOL_INDEX] &
+		     TSC2301_MUTE_MASK) =3D=3D TSC2301_MUTE_MASK)
+			/* both line bypasses muted. Power down the bypass
+			 * path */
+			pd_ctrl |=3D TSC2301_REG_PD_MISC_ABPD;
+		else
+			pd_ctrl &=3D ~TSC2301_REG_PD_MISC_ABPD;
+	}
+	if (shadow_index < 0 || shadow_index =3D=3D AUDCNTL_INDEX) {
+		/* mic bias power down control */
+		if ((mix->shadow_regs[AUDCNTL_INDEX] &
+		     (3 << TSC2301_INML_SHIFT)) &&
+		    (mix->shadow_regs[AUDCNTL_INDEX] &
+		     (3 << TSC2301_INMR_SHIFT)))
+			/* both ADC channels use other than mic input. Power
+			 * down the mic bias output */
+			pd_ctrl |=3D TSC2301_REG_PD_MISC_MIBPD;
+		else
+			pd_ctrl &=3D ~TSC2301_REG_PD_MISC_MIBPD;
+	}
+
+	/* power control decisions based on codec usage and user space mixer
+	 * selections detected above */
+	pd_ctrl &=3D ~TSC2301_REG_PD_MISC_APD; /* audio not powered down */
+	if (mix->mclk_enabled) {
+		if (!mix->adc_enabled) {
+			/* ADC not used, power down both ADC's and mic bias
+			 * output independently of user space mixer
+			 * selections */
+			pd_ctrl |=3D TSC2301_REG_PD_MISC_ADPDL;
+			pd_ctrl |=3D TSC2301_REG_PD_MISC_ADPDR;
+			pd_ctrl |=3D TSC2301_REG_PD_MISC_MIBPD;
+		}
+		if (!mix->dac_enabled) {
+			/* DAC not used, power down DAC independently of user
+			 * space mixer selections */
+			pd_ctrl |=3D TSC2301_REG_PD_MISC_DAPD;
+		}
+
+		if (mix->pll_output) {
+			/* GPIO_0 is configured as PLL output so audio
+			 * controller is expecting clock from TSC2301. Either
+			 * ADC or DAC must be active in order to keep PLL on */
+			if ((pd_ctrl & TSC2301_REG_PD_MISC_ADPDL) &&
+			    (pd_ctrl & TSC2301_REG_PD_MISC_ADPDR) &&
+			    (pd_ctrl & TSC2301_REG_PD_MISC_DAPD)) {
+				/* neither ADC or DAC used. Force ADC on in
+				 * order to keep PLL active */
+				pd_ctrl &=3D ~(TSC2301_REG_PD_MISC_ADPDL |
+					     TSC2301_REG_PD_MISC_ADPDR);
+			}
+		}
+	} else {
+		/* audio input clock is not enabled so power down DAC and ADC
+		 * in order to shutdown PLL and to keep touchscreen and keypad
+		 * parts working. Touchscreen and keypad use audio clock when
+		 * PLL is on and internal clock otherwise */
+		pd_ctrl |=3D TSC2301_REG_PD_MISC_DAPD |
+			   TSC2301_REG_PD_MISC_ADPDL |
+			   TSC2301_REG_PD_MISC_ADPDR;
+	}
+
+	if ((pd_ctrl & TSC2301_REG_PD_MISC_ADPDL) &&
+	    (pd_ctrl & TSC2301_REG_PD_MISC_ADPDR) &&
+	    (pd_ctrl & TSC2301_REG_PD_MISC_DAPD) &&
+	    (pd_ctrl & TSC2301_REG_PD_MISC_ABPD)) {
+		/* all ADC, DAC and line bypass path unused. Power down the
+		 * whole audio part of the TSC2301 */
+		pd_ctrl |=3D TSC2301_REG_PD_MISC_APD;
+	}
+
+	if (pd_ctrl =3D=3D pd_ctrl_old)
+		return;
+
+	/* power down control changed. Update into TSC2301 */
+	if ((pd_ctrl ^ pd_ctrl_old) & TSC2301_REG_PD_MISC_APD) {
+		/* whole audio power state changed. Update GPIO states */
+		if (pd_ctrl & TSC2301_REG_PD_MISC_APD) {
+			/* power down GPIO controls before powering down
+			 * the codec */
+			tsc2301_gpio_power_down(tsc);
+			/* we must really ensure that codec has been on no less
+			 * than 100 msec before doing power-down */
+			timeout =3D mix->pu_jiffies + TSC2301_MIN_PU_PERIOD -
+				  jiffies;
+			if (timeout <=3D TSC2301_MIN_PU_PERIOD) {
+				mix->delayed_pd_active =3D 1;
+				mix->mclk_enabled++;
+				schedule_delayed_work(&mix->delayed_power_down,
+						      timeout + 1);
+				return;
+			}
+		} else
+			/* restore GPIOs after codec is powered up */
+			power_up =3D 1;
+	}
+	mix->shadow_regs[PD_MISC_INDEX] =3D pd_ctrl;
+	tsc2301_write_reg(tsc, TSC2301_REG_PD_MISC, pd_ctrl);
+	if (power_up)
+		mix->pu_jiffies =3D jiffies;
+	if (!poll_pdsts) {
+		if (power_up)
+			tsc2301_write_reg(tsc, TSC2301_REG_GPIO,
+					  mix->shadow_regs[GPIO_INDEX]);
+		return;
+	}
+
+	/* wait until power-up/-down is completed */
+	timeout =3D jiffies + msecs_to_jiffies(100);
+	w =3D 0;
+	do {
+		if (time_after(jiffies, timeout)) {
+			/* Print a warning only if the I2S clock is not
+			 * present / out of sync. This can happen during
+			 * init time, when that clock will be turned on
+			 * by another driver like in the OMAP EAC with
+			 * external clock case.
+			 */
+			if (w & TSC2301_REG_PD_MISC_OTSYN) {
+				dev_warn(&tsc->spi->dev,
+				   "I2S clock not in sync or off.\n");
+			} else {
+				dev_err(&tsc->spi->dev,
+				   "power-up/-down timed out "
+				   "(0x%04x, 0x%04x -> 0x%04x)\n",
+				   w, pd_ctrl_old, pd_ctrl);
+			}
+			goto out;
+		}
+		w =3D tsc2301_read_reg(tsc, TSC2301_REG_PD_MISC);
+	} while (!(w & TSC2301_REG_PD_MISC_PDSTS));
+
+out:
+	if (((pd_ctrl ^ pd_ctrl_old) & TSC2301_REG_PD_MISC_DAPD) &&
+	    !(pd_ctrl & TSC2301_REG_PD_MISC_DAPD)) {
+		/* DAC powered up now. Ensure that DAC and audio outputs are
+		 * activated. They are up 100 msec after the chip power-up
+		 * command */
+		timeout =3D mix->pu_jiffies + TSC2301_DAC_DELAY - jiffies;
+		if (timeout <=3D TSC2301_DAC_DELAY)
+			schedule_timeout_interruptible(timeout);
+		/* FIXME: This is lazy. We restore GPIOs only after activating
+		 * the DAC. It would be better to do some kind of delayed GPIO
+		 * restore. That ensures that we restore them also if only ADC
+		 * path is activated. But this is required only if there is
+		 * some input amplifier, bias control, etc. and their power
+		 * state is under TSC GPIO control */
+		tsc2301_write_reg(tsc, TSC2301_REG_GPIO,
+				  mix->shadow_regs[GPIO_INDEX]);
+	}
+}
+
+static int snd_tsc2301_info_single(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_info *uinfo)
+{
+	int mask =3D TSC2301_SINGLE_MASK(kcontrol->private_value);
+	int minval =3D TSC2301_SINGLE_MINVAL(kcontrol->private_value);
+
+	uinfo->type =3D SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count =3D 1;
+	uinfo->value.integer.min =3D minval;
+	uinfo->value.integer.max =3D mask;
+
+	return 0;
+}
+
+static int snd_tsc2301_get_single(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct tsc2301 *tsc =3D kcontrol->private_data;
+	unsigned long priv =3D kcontrol->private_value;
+	int mask =3D TSC2301_SINGLE_MASK(priv);
+	int shift =3D TSC2301_SINGLE_SHIFT(priv);
+	int shadow_index =3D TSC2301_SHADOW_INDEX(priv);
+	u16 shadow_reg;
+
+	shadow_reg =3D tsc->mixer->shadow_regs[shadow_index];
+
+	ucontrol->value.integer.value[0] =3D (shadow_reg >> shift) & mask;
+
+	return 0;
+}
+
+static int snd_tsc2301_put_single(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct tsc2301 *tsc =3D kcontrol->private_data;
+	unsigned long priv =3D kcontrol->private_value;
+	int mask =3D TSC2301_SINGLE_MASK(priv);
+	int shadow_index =3D TSC2301_SHADOW_INDEX(priv);
+	u16 shadow_reg, shadow_reg_old;
+	int shift =3D TSC2301_SINGLE_SHIFT(priv);
+	int reg =3D TSC2301_PVAL_TO_REG(priv);
+	int changed;
+
+	mutex_lock(&tsc->mixer->mutex);
+	shadow_reg =3D shadow_reg_old =3D tsc->mixer->shadow_regs[shadow_inde=
x];
+
+	/* zero bits to be modified */
+	shadow_reg &=3D ~(mask << shift);
+	/* modify with new value */
+	shadow_reg |=3D ((ucontrol->value.integer.value[0] & mask) << shift);
+
+	changed =3D (shadow_reg !=3D shadow_reg_old);
+	tsc->mixer->shadow_regs[shadow_index] =3D shadow_reg;
+
+	/* update into TSC2301 if necessary */
+	if (changed)
+		tsc2301_write_reg(tsc, reg, shadow_reg);
+	mutex_unlock(&tsc->mixer->mutex);
+
+	return changed;
+}
+
+static int snd_tsc2301_info_double(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_info *uinfo)
+{
+	/* mask =3D=3D 1 : Switch
+	 * mask > 1 : Max volume */
+	int mask =3D TSC2301_DOUBLE_MASK(kcontrol->private_value);
+	int minval =3D TSC2301_DOUBLE_MINVAL(kcontrol->private_value);
+
+	uinfo->type =3D mask =3D=3D 1 ? SNDRV_CTL_ELEM_TYPE_BOOLEAN :
+		SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count =3D 2;
+	uinfo->value.integer.min =3D minval;
+	uinfo->value.integer.max =3D mask;
+
+	return 0;
+}
+
+static int snd_tsc2301_get_double(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct tsc2301 *tsc =3D kcontrol->private_data;
+	unsigned long priv =3D kcontrol->private_value;
+	/* mask =3D=3D 1 : Switch
+	 * mask > 1 : Volume */
+	int mask =3D TSC2301_DOUBLE_MASK(priv);
+	int ls =3D TSC2301_DOUBLE_LEFT_SHIFT(priv);
+	int rs =3D TSC2301_DOUBLE_RIGHT_SHIFT(priv);
+	int shadow_index =3D TSC2301_SHADOW_INDEX(priv);
+	u16 shadow_reg;
+
+	shadow_reg =3D tsc->mixer->shadow_regs[shadow_index];
+
+	/* invert mute bits for the switches */
+	if (mask =3D=3D 1)
+		shadow_reg =3D ~shadow_reg;
+
+	ucontrol->value.integer.value[0] =3D (shadow_reg >> ls) & mask;
+	ucontrol->value.integer.value[1] =3D (shadow_reg >> rs) & mask;
+
+	return 0;
+}
+
+static int snd_tsc2301_put_double(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct tsc2301 *tsc =3D kcontrol->private_data;
+	unsigned long priv =3D kcontrol->private_value;
+	/* mask =3D=3D 1 : Switch
+	 * mask > 1 : Volume */
+	int mask =3D TSC2301_DOUBLE_MASK(priv);
+	int shadow_index =3D TSC2301_SHADOW_INDEX(priv);
+	u16 shadow_reg, shadow_reg_old;
+	int ls =3D TSC2301_DOUBLE_LEFT_SHIFT(priv);
+	int rs =3D TSC2301_DOUBLE_RIGHT_SHIFT(priv);
+	int reg =3D TSC2301_PVAL_TO_REG(priv);
+	int changed;
+
+	mutex_lock(&tsc->mixer->mutex);
+	shadow_reg =3D shadow_reg_old =3D tsc->mixer->shadow_regs[shadow_inde=
x];
+
+	/* zero bits to be modified */
+	shadow_reg &=3D ~((mask << ls) | (mask << rs));
+	/* modify with new value */
+	if (mask =3D=3D 1) {
+		/* switch. Invert switch values for the mute bits */
+		shadow_reg |=3D
+			((~ucontrol->value.integer.value[0] & mask) << ls) |
+			((~ucontrol->value.integer.value[1] & mask) << rs);
+	} else {
+		/* volume */
+		shadow_reg |=3D
+			(ucontrol->value.integer.value[0] << ls) |
+			(ucontrol->value.integer.value[1] << rs);
+	}
+
+	changed =3D (shadow_reg !=3D shadow_reg_old);
+	tsc->mixer->shadow_regs[shadow_index] =3D shadow_reg;
+
+	/* update into TSC2301 if necessary */
+	if (changed)
+		tsc2301_write_reg(tsc, reg, shadow_reg);
+
+	if (mask =3D=3D 1)
+		/* check is need to power down/up audio blocks in case of
+		 * muted state change */
+		tsc2301_power_ctrl(tsc, shadow_index, 0);
+	mutex_unlock(&tsc->mixer->mutex);
+
+	return changed;
+}
+
+static int snd_tsc2301_info_mux(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_info *uinfo)
+{
+	static char *texts[4] =3D {"Mic", "Line", "Line swapped", "Line mono"=
};
+
+	uinfo->type =3D SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count =3D 2;
+	uinfo->value.enumerated.items =3D 4;
+	if (uinfo->value.enumerated.item > 3)
+		uinfo->value.enumerated.item =3D 3;
+	strcpy(uinfo->value.enumerated.name,
+	       texts[uinfo->value.enumerated.item]);
+
+	return 0;
+}
+
+static int snd_tsc2301_get_mux(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct tsc2301 *tsc =3D kcontrol->private_data;
+	unsigned long priv =3D kcontrol->private_value;
+	int mask =3D TSC2301_MUX_MASK(priv);
+	int ls =3D TSC2301_MUX_LEFT_SHIFT(priv);
+	int rs =3D TSC2301_MUX_RIGHT_SHIFT(priv);
+	int shadow_index =3D TSC2301_SHADOW_INDEX(priv);
+	u16 shadow_reg;
+
+	shadow_reg =3D tsc->mixer->shadow_regs[shadow_index];
+	ucontrol->value.enumerated.item[0] =3D (shadow_reg >> ls) & mask;
+	ucontrol->value.enumerated.item[1] =3D (shadow_reg >> rs) & mask;
+
+	return 0;
+}
+
+static int snd_tsc2301_put_mux(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct tsc2301 *tsc =3D kcontrol->private_data;
+	unsigned long priv =3D kcontrol->private_value;
+	int mask =3D TSC2301_MUX_MASK(priv);
+	int shadow_index =3D TSC2301_SHADOW_INDEX(priv);
+	u16 shadow_reg, shadow_reg_old;
+	int ls =3D TSC2301_MUX_LEFT_SHIFT(priv);
+	int rs =3D TSC2301_MUX_RIGHT_SHIFT(priv);
+	int reg =3D TSC2301_PVAL_TO_REG(priv);
+	int changed;
+
+	mutex_lock(&tsc->mixer->mutex);
+	shadow_reg =3D shadow_reg_old =3D tsc->mixer->shadow_regs[shadow_inde=
x];
+
+	/* zero bits to be modified */
+	shadow_reg &=3D ~((mask << ls) | (mask << rs));
+	/* modify with new value */
+	shadow_reg |=3D (ucontrol->value.enumerated.item[0] << ls);
+	shadow_reg |=3D (ucontrol->value.enumerated.item[1] << rs);
+
+	changed =3D (shadow_reg !=3D shadow_reg_old);
+
+	/* update into TSC2301 if necessary */
+	if (changed) {
+		tsc->mixer->shadow_regs[shadow_index] =3D shadow_reg;
+		tsc2301_write_reg(tsc, reg, shadow_reg);
+	}
+
+	/* check is need to power up/down audio blocks in case of ADC input
+	 * change */
+	tsc2301_power_ctrl(tsc, shadow_index, 0);
+	mutex_unlock(&tsc->mixer->mutex);
+
+	return changed;
+}
+
+static int snd_tsc2301_info_bool(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type =3D SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count =3D 1;
+	uinfo->value.integer.min =3D 0;
+	uinfo->value.integer.max =3D 1;
+
+	return 0;
+}
+
+static int snd_tsc2301_get_bool(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct tsc2301 *tsc =3D kcontrol->private_data;
+	unsigned long priv =3D kcontrol->private_value;
+	int shadow_index =3D TSC2301_SHADOW_INDEX(priv);
+	int shift =3D TSC2301_BOOL_SHIFT(priv);
+	int invert =3D TSC2301_BOOL_INVERT(priv);
+	u16 shadow_reg;
+
+	shadow_reg =3D tsc->mixer->shadow_regs[shadow_index];
+	ucontrol->value.integer.value[0] =3D
+		invert ^ ((shadow_reg >> shift) & 1);
+
+	return 0;
+}
+
+static int snd_tsc2301_put_bool(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct tsc2301 *tsc =3D kcontrol->private_data;
+	unsigned long priv =3D kcontrol->private_value;
+	int shadow_index =3D TSC2301_SHADOW_INDEX(priv);
+	int shift =3D TSC2301_BOOL_SHIFT(priv);
+	int invert =3D TSC2301_BOOL_INVERT(priv);
+	int reg =3D TSC2301_PVAL_TO_REG(priv);
+	u16 shadow_reg, shadow_reg_old;
+	int changed;
+
+	mutex_lock(&tsc->mixer->mutex);
+	shadow_reg =3D shadow_reg_old =3D tsc->mixer->shadow_regs[shadow_inde=
x];
+
+	/* zero bit to be modified */
+	shadow_reg &=3D ~(1 << shift);
+	/* modify with new value */
+	shadow_reg |=3D
+		(invert ^ (ucontrol->value.integer.value[0] & 1)) << shift;
+
+	changed =3D (shadow_reg !=3D shadow_reg_old);
+
+	/* update into TSC2301 if necessary */
+	if (changed) {
+		tsc->mixer->shadow_regs[shadow_index] =3D shadow_reg;
+		if ((shadow_index =3D=3D GPIO_INDEX) &&
+		    (tsc->mixer->shadow_regs[PD_MISC_INDEX] &
+		     TSC2301_REG_PD_MISC_APD)) {
+			/* changing GPIO control and audio is powered down.
+			 * Update GPIO states according to their power-down
+			 * flag */
+			tsc2301_gpio_power_down(tsc);
+		} else
+			tsc2301_write_reg(tsc, reg, shadow_reg);
+	}
+	mutex_unlock(&tsc->mixer->mutex);
+
+	return changed;
+}
+
+/* TSC2301 internal mixer controls */
+static struct snd_kcontrol_new snd_tsc2301_controls[] =3D {
+	/* stereo ADC input switches and volumes */
+	TSC2301_DOUBLE("Capture Switch", 0,
+		TSC2301_REG_ADCVOL, ADCVOL_INDEX,
+		TSC2301_MUTE_LEFT_SHIFT, TSC2301_MUTE_RIGHT_SHIFT,
+		1, 0),
+	TSC2301_DOUBLE("Capture Volume", 0,
+		TSC2301_REG_ADCVOL, ADCVOL_INDEX,
+		TSC2301_VOL_LEFT_SHIFT, TSC2301_VOL_RIGHT_SHIFT,
+		TSC2301_VOLUME_MASK, TSC2301_MIN_ADCVOL),
+
+	/* stereo DAC output switches and volumes */
+	TSC2301_DOUBLE("PCM Playback Switch", 0,
+		TSC2301_REG_DACVOL, DACVOL_INDEX,
+		TSC2301_MUTE_LEFT_SHIFT, TSC2301_MUTE_RIGHT_SHIFT,
+		1, 0),
+	TSC2301_DOUBLE("PCM Playback Volume", 0,
+		TSC2301_REG_DACVOL, DACVOL_INDEX,
+		TSC2301_VOL_LEFT_SHIFT, TSC2301_VOL_RIGHT_SHIFT,
+		TSC2301_VOLUME_MASK, TSC2301_MIN_DACVOL),
+
+	/* stereo line input bypass switches and volumes */
+	TSC2301_DOUBLE("Line Playback Switch", 0,
+		TSC2301_REG_BPVOL, BPVOL_INDEX,
+		TSC2301_MUTE_LEFT_SHIFT, TSC2301_MUTE_RIGHT_SHIFT,
+		1, 0),
+	TSC2301_DOUBLE("Line Playback Volume", 0,
+		TSC2301_REG_BPVOL, BPVOL_INDEX,
+		TSC2301_VOL_LEFT_SHIFT, TSC2301_VOL_RIGHT_SHIFT,
+		TSC2301_VOLUME_MASK, TSC2301_MIN_BPVOL),
+
+	/* mono microphone input gain */
+	TSC2301_SINGLE("Mic Boost", 0,
+		TSC2301_REG_AUDCNTL, AUDCNTL_INDEX,
+		TSC2301_MICG_SHIFT,
+		TSC2301_MICG_MASK, TSC2301_MICG_MIN),
+
+	/* ADC input sources. Both channels could be selected separately */
+	TSC2301_MUX("Capture Source", 0,
+		TSC2301_REG_AUDCNTL, AUDCNTL_INDEX,
+		TSC2301_INML_SHIFT, TSC2301_INMR_SHIFT,
+		TSC2301_INM_MASK),
+};
+
+/* must be called tsc->mixer->mutex locked */
+static void tsc2301_flush_shadow_regs(struct tsc2301 *tsc)
+{
+	int i, page, addr;
+	u16 temp;
+
+	page =3D TSC2301_REG_TO_PAGE(TSC2301_REG_AUDCNTL);
+	addr =3D TSC2301_REG_TO_ADDR(TSC2301_REG_AUDCNTL);
+
+	for (i =3D 0; i < 4; i++) {
+		temp =3D tsc->mixer->shadow_regs[i];
+		tsc2301_write_reg(tsc, TSC2301_REG(page, addr + i), temp);
+	}
+	temp =3D tsc->mixer->shadow_regs[GPIO_INDEX];
+	tsc2301_write_reg(tsc, TSC2301_REG_GPIO, temp);
+
+	/* Update power state of all audio blocks depending are they
+	 * muted or unused. */
+	tsc2301_power_ctrl(tsc, -1, 0);
+}
+
+#ifdef CONFIG_PM
+int tsc2301_mixer_suspend(struct tsc2301 *tsc)
+{
+	/* power down entire audio section inside TSC2301 in case the
+	 * chip is still powered during the system sleep. However this driver
+	 * doesn't require that chip is powered because registers are restore=
d
+	 * in function tsc2301_mixer_resume */
+	mutex_lock(&tsc->mixer->mutex);
+	tsc2301_gpio_power_down(tsc);
+	tsc->mixer->shadow_regs[PD_MISC_INDEX] |=3D TSC2301_REG_PD_MISC_APD;
+	tsc2301_write_reg(tsc, TSC2301_REG_PD_MISC,
+			  tsc->mixer->shadow_regs[PD_MISC_INDEX]);
+	mutex_unlock(&tsc->mixer->mutex);
+	return 0;
+}
+
+void tsc2301_mixer_resume(struct tsc2301 *tsc)
+{
+	/* power up the TSC2301 audio section and restore registers */
+	mutex_lock(&tsc->mixer->mutex);
+	tsc->mixer->shadow_regs[PD_MISC_INDEX] &=3D ~TSC2301_REG_PD_MISC_APD;
+	tsc2301_flush_shadow_regs(tsc);
+	mutex_unlock(&tsc->mixer->mutex);
+}
+#endif
+
+void tsc2301_mixer_enable_mclk(struct device *dev)
+{
+	struct tsc2301 *tsc =3D dev_get_drvdata(dev);
+	struct tsc2301_mixer *mix =3D tsc->mixer;
+
+	mutex_lock(&mix->mutex);
+	if (!mix->mclk_enabled++ && tsc->enable_clock !=3D NULL) {
+		tsc->enable_clock(dev);
+	}
+	tsc2301_power_ctrl(tsc, -1, 1);
+	mutex_unlock(&mix->mutex);
+}
+
+void tsc2301_mixer_disable_mclk(struct device *dev)
+{
+	struct tsc2301 *tsc =3D dev_get_drvdata(dev);
+	struct tsc2301_mixer *mix =3D tsc->mixer;
+
+	mutex_lock(&mix->mutex);
+	mix->mclk_enabled--;
+	tsc2301_power_ctrl(tsc, -1, 1);
+	if (!mix->mclk_enabled && tsc->disable_clock !=3D NULL) {
+		tsc->disable_clock(dev);
+	}
+	mutex_unlock(&mix->mutex);
+}
+
+static void tsc2301_mixer_delayed_power_down(struct work_struct *work)
+{
+	struct tsc2301_mixer *mix =3D container_of(work, struct tsc2301_mixer=
,
+						 delayed_power_down.work);
+	struct tsc2301 *tsc =3D mix->tsc;
+
+	mutex_lock(&mix->mutex);
+	if (!mix->delayed_pd_active) {
+		mutex_unlock(&mix->mutex);
+		return;
+	}
+	mix->delayed_pd_active =3D 0;
+	mutex_unlock(&mix->mutex);
+	tsc2301_mixer_disable_mclk(&tsc->spi->dev);
+}
+
+/*
+ * Allows audio controller driver to notify its usage of ADC and DAC
+ */
+void tsc2301_mixer_set_power(struct device *dev, int dac, int adc)
+{
+	struct tsc2301 *tsc =3D dev_get_drvdata(dev);
+
+	mutex_lock(&tsc->mixer->mutex);
+	tsc->mixer->adc_enabled =3D adc;
+	tsc->mixer->dac_enabled =3D dac;
+
+	/* update power state of all audio blocks */
+	tsc2301_power_ctrl(tsc, -1, 1);
+	mutex_unlock(&tsc->mixer->mutex);
+}
+
+/*
+ * Registers TSC2301 ALSA Mixer controls for the given sound card
+ */
+int tsc2301_mixer_register_controls(struct device *dev, struct snd_car=
d *card)
+{
+	struct tsc2301 *tsc =3D dev_get_drvdata(dev);
+	struct tsc2301_mixer *mix =3D tsc->mixer;
+	int i, err;
+
+	/* Register ALSA mixer controls */
+	for (i =3D 0; i < ARRAY_SIZE(snd_tsc2301_controls); i++) {
+		err =3D snd_ctl_add(card,
+				  snd_ctl_new1(&snd_tsc2301_controls[i], tsc));
+		if (err < 0)
+			return err;
+	}
+
+	if (!mix->n_mixer_gpios)
+		return 0;
+
+	/* Register additional GPIO controls if defined */
+	for (i =3D 0; i < mix->n_mixer_gpios; i++) {
+		const struct tsc2301_mixer_gpio *mg =3D mix->mixer_gpios + i;
+		struct snd_kcontrol *ctrlp;
+		struct snd_kcontrol_new ctrl =3D
+			TSC2301_BOOL((char *)mg->name, 0,
+				     TSC2301_REG_GPIO, GPIO_INDEX,
+				     mg->gpio, mg->inverted, mg->def_enable);
+
+		ctrlp =3D snd_ctl_new1(&ctrl, tsc);
+		err =3D snd_ctl_add(card, ctrlp);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+int tsc2301_mixer_init(struct tsc2301 *tsc,
+		       struct tsc2301_platform_data *pdata)
+{
+	struct tsc2301_mixer *mix;
+	int err =3D 0;
+	u16 w;
+
+	mix =3D kzalloc(sizeof(*mix), GFP_KERNEL);
+	if (mix =3D=3D NULL)
+		return -ENOMEM;
+	tsc->mixer =3D mix;
+
+	mix->tsc =3D tsc;
+	mutex_init(&mix->mutex);
+	mix->platform_init =3D pdata->codec_init;
+	mix->platform_cleanup =3D pdata->codec_cleanup;
+	mix->pll_output =3D pdata->pll_output;
+
+	INIT_DELAYED_WORK(&mix->delayed_power_down,
+			  tsc2301_mixer_delayed_power_down);
+
+	/* initialize shadow register default values */
+	w =3D 0xc000;
+	w |=3D (pdata->mclk_ratio << 6) | (pdata->i2s_sample_rate << 2);
+	w |=3D pdata->i2s_format;
+	mix->shadow_regs[AUDCNTL_INDEX] =3D w;
+	mix->shadow_regs[ADCVOL_INDEX] =3D 0xd7d7;
+	mix->shadow_regs[DACVOL_INDEX] =3D 0xffff;
+	mix->shadow_regs[BPVOL_INDEX] =3D 0xe7e7;
+	mix->shadow_regs[PD_MISC_INDEX] =3D pdata->power_down_blocks;
+
+	/* if extra mixer controls configured, then configure associated
+	 * GPIOs as output and drive their default state */
+	if (pdata->n_mixer_gpios) {
+		int i;
+
+		w =3D 0;
+		for (i =3D 0; i < pdata->n_mixer_gpios; i++) {
+			const struct tsc2301_mixer_gpio *mg;
+			int gpio;
+
+			mg =3D pdata->mixer_gpios + i;
+			gpio =3D mg->gpio;
+			w |=3D (1 << gpio) << 8;
+			w |=3D (mg->inverted ^ mg->def_enable) << gpio;
+		}
+		mix->shadow_regs[GPIO_INDEX] =3D w;
+
+		mix->mixer_gpios =3D kmalloc(sizeof(*pdata->mixer_gpios) *
+					   pdata->n_mixer_gpios,
+					   GFP_KERNEL);
+		if (mix->mixer_gpios =3D=3D NULL) {
+			err =3D -ENOMEM;
+			goto err1;
+		}
+		memcpy(mix->mixer_gpios, pdata->mixer_gpios,
+		       sizeof(*pdata->mixer_gpios) * pdata->n_mixer_gpios);
+		mix->n_mixer_gpios =3D pdata->n_mixer_gpios;
+	}
+
+	/* PLL control */
+	tsc2301_write_pll(tsc, pdata->pll_n, pdata->pll_a, pdata->pll_pdc,
+			  0, mix->pll_output ? 0 : 1);
+
+	tsc2301_flush_shadow_regs(tsc);
+
+	if (mix->platform_init !=3D NULL) {
+		err =3D mix->platform_init(&tsc->spi->dev);
+		if (err < 0)
+			goto err2;
+	}
+
+	return 0;
+err2:
+	if (mix->mixer_gpios !=3D NULL)
+		kfree(mix->mixer_gpios);
+err1:
+	kfree(mix);
+	return err;
+}
+
+void tsc2301_mixer_exit(struct tsc2301 *tsc)
+{
+	struct tsc2301_mixer *mixer =3D tsc->mixer;
+
+	if (mixer->platform_cleanup !=3D NULL)
+		mixer->platform_cleanup(&tsc->spi->dev);
+
+	if (mixer->mixer_gpios !=3D NULL)
+		kfree(mixer->mixer_gpios);
+}
+
+MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@nokia.com>");
+MODULE_LICENSE("GPL");
--=20
1.6.0.1.141.g445ca

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
