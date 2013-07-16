From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] iio: twl6030-gpadc: TWL6030, TWL6032 GPADC driver
Date: Tue, 16 Jul 2013 17:28:26 +0100
Message-ID: <c8f86766-822b-4fe3-ae2a-e0b12412ef39@email.android.com>
References: <1373974023-23521-1-git-send-email-oleksandr.kozaruk@ti.com>
 <1373974023-23521-3-git-send-email-oleksandr.kozaruk@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4041574489478654339=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1373974023-23521-3-git-send-email-oleksandr.kozaruk-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Oleksandr Kozaruk <oleksandr.kozaruk-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org, milo.kim-l0cyMroinI0@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--===============4041574489478654339==
Content-Type: multipart/alternative; boundary="----XVSS6TAREA0SBEDZUBMC6PM6O0YU72"

------XVSS6TAREA0SBEDZUBMC6PM6O0YU72
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Two very quick comments based on quick glance as it may be a while before=
 I can do a full review.

We still have channels that are only usable for temperature being output =
to user space as voltage channels?  Is the conversion so very hard?=20

You have the same entries in info_mask_shared by type and separate. That =
makes no sense. One or the other please!




Oleksandr Kozaruk <oleksandr.kozaruk-l0cyMroinI0@public.gmane.org> wrote:
>The GPADC is general purpose ADC found on TWL6030, and TWL6032 PMIC,
>known also as Phoenix and PhoenixLite.
>
>The TWL6030 and TWL6032 have GPADC with 17 and 19 channels
>respectively. Some channels have current source and are used for
>measuring voltage drop on resistive load for detecting battery ID
>resistance, or measuring voltage drop on NTC resistors for external
>temperature measurements. Some channels measure voltage, (i.e. battery
>voltage), and have voltage dividers, thus, capable to scale voltage.
>Some channels are dedicated for measuring die temperature.
>
>Some channels are calibrated in 2 points, having offsets from ideal
>values kept in trim registers. This is used to correct measurements.
>
>The differences between GPADC in TWL6030 and TWL6032:
>- 10 bit vs 12 bit ADC;
>- 17 vs 19 channels;
>- channels have different purpose(i.e. battery voltage
>  channel 8 vs channel 18);
>- trim values are interpreted differently.
>
>Based on the driver patched from Balaji TK, Graeme Gregory, Ambresh K,
>Girish S Ghongdemath.
>
>Signed-off-by: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
>Signed-off-by: Graeme Gregory <gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>
>Signed-off-by: Oleksandr Kozaruk <oleksandr.kozaruk-l0cyMroinI0@public.gmane.org>
>---
> drivers/iio/adc/Kconfig         |   14 +
> drivers/iio/adc/Makefile        |    1 +
>drivers/iio/adc/twl6030-gpadc.c | 1008
>+++++++++++++++++++++++++++++++++++++++
> 3 files changed, 1023 insertions(+)
> create mode 100644 drivers/iio/adc/twl6030-gpadc.c
>
>diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>index ab0767e6..3172461 100644
>--- a/drivers/iio/adc/Kconfig
>+++ b/drivers/iio/adc/Kconfig
>@@ -150,6 +150,20 @@ config TI_AM335X_ADC
> 	  Say yes here to build support for Texas Instruments ADC
> 	  driver which is also a MFD client.
>=20
>+config TWL6030_GPADC
>+	tristate "TWL6030 GPADC (General Purpose A/D Converter) Support"
>+	depends on TWL4030_CORE
>+	default n
>+	help
>+	  Say yes here if you want support for the TWL6030/TWL6032 General
>+	  Purpose A/D Converter. This will add support for battery type
>+	  detection, battery voltage and temperature measurement, die
>+	  temperature measurement, system supply voltage, audio accessory,
>+	  USB ID detection.
>+
>+	  This driver can also be built as a module. If so, the module will
>be
>+	  called twl6030-gpadc.
>+
> config VIPERBOARD_ADC
> 	tristate "Viperboard ADC support"
> 	depends on MFD_VIPERBOARD && USB
>diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>index 0a825be..996ba09 100644
>--- a/drivers/iio/adc/Makefile
>+++ b/drivers/iio/adc/Makefile
>@@ -16,4 +16,5 @@ obj-$(CONFIG_LP8788_ADC) +=3D lp8788_adc.o
> obj-$(CONFIG_MAX1363) +=3D max1363.o
> obj-$(CONFIG_TI_ADC081C) +=3D ti-adc081c.o
> obj-$(CONFIG_TI_AM335X_ADC) +=3D ti_am335x_adc.o
>+obj-$(CONFIG_TWL6030_GPADC) +=3D twl6030-gpadc.o
> obj-$(CONFIG_VIPERBOARD_ADC) +=3D viperboard_adc.o
>diff --git a/drivers/iio/adc/twl6030-gpadc.c
>b/drivers/iio/adc/twl6030-gpadc.c
>new file mode 100644
>index 0000000..658f35b
>--- /dev/null
>+++ b/drivers/iio/adc/twl6030-gpadc.c
>@@ -0,0 +1,1008 @@
>+/*
>+ * TWL6030 GPADC module driver
>+ *
>+ * Copyright (C) 2009-2013 Texas Instruments Inc.
>+ * Nishant Kamat <nskamat-l0cyMroinI0@public.gmane.org>
>+ * Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
>+ * Graeme Gregory <gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>
>+ * Girish S Ghongdemath <girishsg-l0cyMroinI0@public.gmane.org>
>+ * Ambresh K <ambresh-l0cyMroinI0@public.gmane.org>
>+ * Oleksandr Kozaruk <oleksandr.kozaruk-l0cyMroinI0@public.gmane.org
>+ *
>+ * Based on twl4030-madc.c
>+ * Copyright (C) 2008 Nokia Corporation
>+ * Mikko Ylinen <mikko.k.ylinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
>+ *
>+ * This program is free software; you can redistribute it and/or
>+ * modify it under the terms of the GNU General Public License
>+ * version 2 as published by the Free Software Foundation.
>+ *
>+ * This program is distributed in the hope that it will be useful, but
>+ * WITHOUT ANY WARRANTY; without even the implied warranty of
>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>+ * General Public License for more details.
>+ *
>+ * You should have received a copy of the GNU General Public License
>+ * along with this program; if not, write to the Free Software
>+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>+ * 02110-1301 USA
>+ *
>+ */
>+#include <linux/init.h>
>+#include <linux/interrupt.h>
>+#include <linux/kernel.h>
>+#include <linux/module.h>
>+#include <linux/platform_device.h>
>+#include <linux/of_platform.h>
>+#include <linux/i2c/twl.h>
>+#include <linux/iio/iio.h>
>+#include <linux/iio/sysfs.h>
>+
>+#define DRIVER_NAME		"twl6030_gpadc"
>+
>+#define TWL6030_GPADC_MAX_CHANNELS 17
>+#define TWL6032_GPADC_MAX_CHANNELS 19
>+
>+#define TWL6030_GPADC_CTRL_P1			0x05
>+
>+#define TWL6032_GPADC_GPSELECT_ISB		0x07
>+#define TWL6032_GPADC_CTRL_P1			0x08
>+
>+#define TWL6032_GPADC_GPCH0_LSB			0x0d
>+#define TWL6032_GPADC_GPCH0_MSB			0x0e
>+
>+#define TWL6030_GPADC_CTRL_P1_SP1		BIT(3)
>+
>+#define TWL6030_GPADC_GPCH0_LSB			(0x29)
>+
>+#define TWL6030_GPADC_RT_SW1_EOC_MASK		BIT(5)
>+
>+#define TWL6030_GPADC_TRIM1			0xCD
>+
>+#define TWL6030_REG_TOGGLE1			0x90
>+#define TWL6030_GPADCS				BIT(1)
>+#define TWL6030_GPADCR				BIT(0)
>+
>+/**
>+ * struct twl6030_chnl_calib - channel calibration
>+ * @gain:		slope coefficient for ideal curve
>+ * @gain_error:		gain error
>+ * @offset_error:	offset of the real curve
>+ */
>+struct twl6030_chnl_calib {
>+	s32 gain;
>+	s32 gain_error;
>+	s32 offset_error;
>+};
>+
>+/**
>+ * struct twl6030_ideal_code - GPADC calibration parameters
>+ * GPADC is calibrated in two points: close to the beginning and
>+ * to the and of the measurable input range
>+ *
>+ * @code1:	ideal code for the input at the beginning
>+ * @code2:	ideal code for at the end of the range
>+ * @volt1:	voltage input at the beginning(low voltage)
>+ * @volt2:	voltage input at the end(high voltage)
>+ */
>+struct twl6030_ideal_code {
>+	u16 code1;
>+	u16 code2;
>+	u16 volt1;
>+	u16 volt2;
>+};
>+
>+struct twl6030_gpadc_data;
>+
>+/**
>+ * struct twl6030_gpadc_platform_data - platform specific data
>+ * @nchannels:		number of GPADC channels
>+ * @iio_channels:	iio channels
>+ * @twl6030_ideal:	pointer to calibration parameters
>+ * @start_conversion:	pointer to ADC start conversion function
>+ * @channel_to_reg	pointer to ADC function to convert channel to
>+ * 			register address for reading conversion result
>+ * @calibrate:		pointer to calibration function
>+ */
>+struct twl6030_gpadc_platform_data {
>+	const int nchannels;
>+	const struct iio_chan_spec *iio_channels;
>+	const struct twl6030_ideal_code *ideal;
>+	int (*start_conversion)(int channel);
>+	u8 (*channel_to_reg)(int channel);
>+	int (*calibrate)(struct twl6030_gpadc_data *gpadc);
>+};
>+
>+/**
>+ * struct twl6030_gpadc_data - GPADC data
>+ * @dev:		device pointer
>+ * @lock:		mutual exclusion lock for the structure
>+ * @irq_complete:	completion to signal end of conversion
>+ * @twl6030_cal_tbl:	pointer to calibration data for each
>+ * 			channel with gain error and offset
>+ * @pdata:		pointer to device specific data
>+ */
>+struct twl6030_gpadc_data {
>+	struct device	*dev;
>+	struct mutex	lock;
>+	struct completion	irq_complete;
>+	struct twl6030_chnl_calib	*twl6030_cal_tbl;
>+	const struct twl6030_gpadc_platform_data *pdata;
>+};
>+
>+/*
>+ * channels 11, 12, 13, 15 and 16 have no calibration data
>+ * calibration offset is same for channels 1, 3, 4, 5
>+ *
>+ * The data is taken from GPADC_TRIM registers description.
>+ * GPADC_TRIM registers keeps difference between the code measured
>+ * at volt1 and volt2 input voltages and corresponding code1 and code2
>+ */
>+static const struct twl6030_ideal_code
>+	twl6030_ideal[TWL6030_GPADC_MAX_CHANNELS] =3D {
>+	[0] =3D { /* ch 0, external, battery type, resistor value */
>+		.code1 =3D 116,
>+		.code2 =3D 745,
>+		.volt1 =3D 141,
>+		.volt2 =3D 910,
>+	},
>+	[1] =3D { /* ch 1, external, battery temperature, NTC resistor value *=
/
>+		.code1 =3D 82,
>+		.code2 =3D 900,
>+		.volt1 =3D 100,
>+		.volt2 =3D 1100,
>+	},
>+	[2] =3D { /* ch 2, external, audio accessory/general purpose */
>+		.code1 =3D 55,
>+		.code2 =3D 818,
>+		.volt1 =3D 101,
>+		.volt2 =3D 1499,
>+	},
>+	[3] =3D { /* ch 3, external, general purpose */
>+		.code1 =3D 82,
>+		.code2 =3D 900,
>+		.volt1 =3D 100,
>+		.volt2 =3D 1100,
>+	},
>+	[4] =3D { /* ch 4, external, temperature measurement/general purpose *=
/
>+		.code1 =3D 82,
>+		.code2 =3D 900,
>+		.volt1 =3D 100,
>+		.volt2 =3D 1100,
>+	},
>+	[5] =3D { /* ch 5, external, general purpose */
>+		.code1 =3D 82,
>+		.code2 =3D 900,
>+		.volt1 =3D 100,
>+		.volt2 =3D 1100,
>+	},
>+	[6] =3D { /* ch 6, external, general purpose */
>+		.code1 =3D 82,
>+		.code2 =3D 900,
>+		.volt1 =3D 100,
>+		.volt2 =3D 1100,
>+	},
>+	[7] =3D { /* ch 7, internal, main battery */
>+		.code1 =3D 614,
>+		.code2 =3D 941,
>+		.volt1 =3D 3001,
>+		.volt2 =3D 4599,
>+	},
>+	[8] =3D { /* ch 8, internal, backup battery */
>+		.code1 =3D 82,
>+		.code2 =3D 688,
>+		.volt1 =3D 501,
>+		.volt2 =3D 4203,
>+	},
>+	[9] =3D { /* ch 9, internal, external charger input */
>+		.code1 =3D 182,
>+		.code2 =3D 818,
>+		.volt1 =3D 2001,
>+		.volt2 =3D 8996,
>+	},
>+	[10] =3D { /* ch 10, internal, VBUS */
>+		.code1 =3D 149,
>+		.code2 =3D 818,
>+		.volt1 =3D 1001,
>+		.volt2 =3D 5497,
>+	},
>+	[11] =3D {},	/* ch 11, internal, VBUS charging current */
>+	[12] =3D {},	/* ch 12, internal, Die temperature */
>+	[13] =3D {},	/* ch 13, internal, Die temperature */
>+	[14] =3D { /* ch 14, internal, USB ID line */
>+		.code1 =3D 48,
>+		.code2 =3D 714,
>+		.volt1 =3D 323,
>+		.volt2 =3D 4800,
>+	},
>+	[15] =3D {},	/* ch 15, internal, test network */
>+	[16] =3D {},	/* ch 16, internal, test network */
>+};
>+
>+static const struct twl6030_ideal_code
>+			twl6032_ideal[TWL6032_GPADC_MAX_CHANNELS] =3D {
>+	[0] =3D { /* ch 0, external, battery type, resistor value */
>+		.code1 =3D 1441,
>+		.code2 =3D 3276,
>+		.volt1 =3D 440,
>+		.volt2 =3D 1000,
>+	},
>+	[1] =3D { /* ch 1, external, battery temperature, NTC resistor value *=
/
>+		.code1 =3D 1441,
>+		.code2 =3D 3276,
>+		.volt1 =3D 440,
>+		.volt2 =3D 1000,
>+	},
>+	[2] =3D { /* ch 2, external, audio accessory/general purpose */
>+		.code1 =3D 1441,
>+		.code2 =3D 3276,
>+		.volt1 =3D 660,
>+		.volt2 =3D 1500,
>+	},
>+	[3] =3D { /* ch 3, external, temperature with external diode/general
>+								purpose */
>+		.code1 =3D 1441,
>+		.code2 =3D 3276,
>+		.volt1 =3D 440,
>+		.volt2 =3D 1000,
>+	},
>+	[4] =3D { /* ch 4, external, temperature measurement/general purpose *=
/
>+		.code1 =3D 1441,
>+		.code2 =3D 3276,
>+		.volt1 =3D 440,
>+		.volt2 =3D 1000,
>+	},
>+	[5] =3D { /* ch 5, external, general purpose */
>+		.code1 =3D 1441,
>+		.code2 =3D 3276,
>+		.volt1 =3D 440,
>+		.volt2 =3D 1000,
>+	},
>+	[6] =3D { /* ch 6, external, general purpose */
>+		.code1 =3D 1441,
>+		.code2 =3D 3276,
>+		.volt1 =3D 440,
>+		.volt2 =3D 1000,
>+	},
>+	[7] =3D { /* ch7, internal, system supply */
>+		.code1 =3D 1441,
>+		.code2 =3D 3276,
>+		.volt1 =3D 2200,
>+		.volt2 =3D 5000,
>+	},
>+	[8] =3D { /* ch8, internal, backup battery */
>+		.code1 =3D 1441,
>+		.code2 =3D 3276,
>+		.volt1 =3D 2200,
>+		.volt2 =3D 5000,
>+	},
>+	[9] =3D { /* ch 9, internal, external charger input */
>+		.code1 =3D 1441,
>+		.code2 =3D 3276,
>+		.volt1 =3D 3960,
>+		.volt2 =3D 9000,
>+	},
>+	[10] =3D { /* ch10, internal, VBUS */
>+		.code1 =3D 150,
>+		.code2 =3D 751,
>+		.volt1 =3D 1000,
>+		.volt2 =3D 5000,
>+	},
>+	[11] =3D { /* ch 11, internal, VBUS DC-DC output current */
>+		.code1 =3D 1441,
>+		.code2 =3D 3276,
>+		.volt1 =3D 660,
>+		.volt2 =3D 1500,
>+	},
>+	[12] =3D { /* ch 12, internal, Die temperature */
>+		.code1 =3D 1441,
>+		.code2 =3D 3276,
>+		.volt1 =3D 440,
>+		.volt2 =3D 1000,
>+	},
>+	[13] =3D { /* ch 13, internal, Die temperature */
>+		.code1 =3D 1441,
>+		.code2 =3D 3276,
>+		.volt1 =3D 440,
>+		.volt2 =3D 1000,
>+	},
>+	[14] =3D { /* ch 14, internal, USB ID line */
>+		.code1 =3D 1441,
>+		.code2 =3D 3276,
>+		.volt1 =3D 2420,
>+		.volt2 =3D 5500,
>+	},
>+	[15] =3D {},	/* ch 15, internal, test network */
>+	[16] =3D {},	/* ch 16, internal, test network */
>+	[17] =3D {},	/* ch 17, internal, battery charging current */
>+	[18] =3D { /* ch 18, internal, battery voltage */
>+		.code1 =3D 1441,
>+		.code2 =3D 3276,
>+		.volt1 =3D 2200,
>+		.volt2 =3D 5000,
>+	},
>+};
>+
>+static inline int twl6030_gpadc_write(u8 reg, u8 val)
>+{
>+	return twl_i2c_write_u8(TWL6030_MODULE_GPADC, val, reg);
>+}
>+
>+static inline int twl6030_gpadc_read(u8 reg, u8 *val)
>+{
>+
>+	return twl_i2c_read(TWL6030_MODULE_GPADC, val, reg, 2);
>+}
>+
>+static int twl6030_gpadc_enable_irq(u8 mask)
>+{
>+	int ret;
>+
>+	ret =3D twl6030_interrupt_unmask(mask, REG_INT_MSK_LINE_B);
>+	if (ret < 0)
>+		return ret;
>+
>+	ret =3D twl6030_interrupt_unmask(mask, REG_INT_MSK_STS_B);
>+
>+	return ret;
>+}
>+
>+static void twl6030_gpadc_disable_irq(u8 mask)
>+{
>+	twl6030_interrupt_mask(mask, REG_INT_MSK_LINE_B);
>+	twl6030_interrupt_mask(mask, REG_INT_MSK_STS_B);
>+}
>+
>+static irqreturn_t twl6030_gpadc_irq_handler(int irq, void *_gpadc)
>+{
>+	struct twl6030_gpadc_data *gpadc =3D _gpadc;
>+
>+	complete(&gpadc->irq_complete);
>+
>+	return IRQ_HANDLED;
>+}
>+
>+static int twl6030_start_conversion(int channel)
>+{
>+	return twl6030_gpadc_write(TWL6030_GPADC_CTRL_P1,
>+					TWL6030_GPADC_CTRL_P1_SP1);
>+}
>+
>+static int twl6032_start_conversion(int channel)
>+{
>+	int ret;
>+
>+	ret =3D twl6030_gpadc_write(TWL6032_GPADC_GPSELECT_ISB, channel);
>+	if (ret)
>+		return ret;
>+
>+	return twl6030_gpadc_write(TWL6032_GPADC_CTRL_P1,
>+						TWL6030_GPADC_CTRL_P1_SP1);
>+}
>+
>+static u8 twl6030_channel_to_reg(int channel)
>+{
>+	return TWL6030_GPADC_GPCH0_LSB + 2 * channel;
>+}
>+
>+static u8 twl6032_channel_to_reg(int channel)
>+{
>+	/*
>+	 * for any prior chosen channel, when the conversion is ready
>+	 * the result is avalable in GPCH0_LSB, GPCH0_MSB.
>+	 */
>+
>+	return TWL6032_GPADC_GPCH0_LSB;
>+}
>+
>+static int twl6030_gpadc_get_raw(struct twl6030_gpadc_data *gpadc,
>+		int channel, int *res)
>+{
>+	u8 reg =3D gpadc->pdata->channel_to_reg(channel);
>+	__le16 val;
>+	int ret;
>+
>+	ret =3D twl6030_gpadc_read(reg, (u8 *)&val);
>+	if (ret) {
>+		dev_dbg(gpadc->dev, "unable to read register 0x%X\n", reg);
>+		return ret;
>+	}
>+
>+	*res =3D le16_to_cpup(&val);
>+
>+	return ret;
>+}
>+
>+static int twl6030_gpadc_get_processed(struct twl6030_gpadc_data
>*gpadc,
>+		int channel, int *val)
>+{
>+	int raw_code;
>+	int corrected_code;
>+	int channel_value;
>+	int ret;
>+
>+	ret =3D twl6030_gpadc_get_raw(gpadc, channel, &raw_code);
>+	if (ret)
>+		return ret;
>+
>+	corrected_code =3D ((raw_code * 1000) -
>+		gpadc->twl6030_cal_tbl[channel].offset_error) /
>+		gpadc->twl6030_cal_tbl[channel].gain_error;
>+
>+	channel_value =3D corrected_code *
>+			gpadc->twl6030_cal_tbl[channel].gain;
>+
>+	/* Shift back into mV range */
>+	channel_value /=3D 1000;
>+
>+	dev_dbg(gpadc->dev, "GPADC raw code: %d", raw_code);
>+	dev_dbg(gpadc->dev, "GPADC corrected code: %d", corrected_code);
>+	dev_dbg(gpadc->dev, "GPADC value: %d", channel_value);
>+
>+	*val =3D channel_value;
>+
>+	return ret;
>+}
>+
>+static int twl6030_gpadc_read_raw(struct iio_dev *indio_dev,
>+			     const struct iio_chan_spec *chan,
>+			     int *val, int *val2, long mask)
>+{
>+	struct twl6030_gpadc_data *gpadc =3D iio_priv(indio_dev);
>+	int ret =3D -EINVAL;
>+	long timeout;
>+
>+	mutex_lock(&gpadc->lock);
>+
>+	ret =3D gpadc->pdata->start_conversion(chan->channel);
>+	if (ret) {
>+		dev_err(gpadc->dev, "failed to start conversion\n");
>+		goto err;
>+	}
>+	/* wait for conversion to complete */
>+	timeout =3D wait_for_completion_interruptible_timeout(
>+				&gpadc->irq_complete, msecs_to_jiffies(5000));
>+	if (!timeout)
>+		return -ETIMEDOUT;
>+	else if (timeout < 0)
>+		return EINTR;
>+
>+	switch (mask) {
>+	case IIO_CHAN_INFO_RAW:
>+		ret =3D twl6030_gpadc_get_raw(gpadc, chan->channel, val);
>+		ret =3D ret ? -EIO : IIO_VAL_INT;
>+		break;
>+
>+	case IIO_CHAN_INFO_PROCESSED:
>+		ret =3D twl6030_gpadc_get_processed(gpadc, chan->channel, val);
>+		ret =3D ret ? -EIO : IIO_VAL_INT;
>+		break;
>+
>+	default:
>+		break;
>+	}
>+err:
>+	mutex_unlock(&gpadc->lock);
>+
>+	return ret;
>+}
>+
>+/*
>+ * The GPADC channels are calibrated using a two point calibration
>method.
>+ * The channels measured with two known values: volt1 and volt2, and
>+ * ideal corresponding output codes are known: code1, code2.
>+ * The difference(d1, d2) between ideal and measured codes stored in
>trim
>+ * registers.
>+ * The goal is to find offset and gain of the real curve for each
>calibrated
>+ * channel.
>+ * gain: k =3D 1 + ((d2 - d1) / (x2 - x1))
>+ * offset: b =3D d1 + (k - 1) * x1
>+ */
>+static void twl6030_calibrate_channel(struct twl6030_gpadc_data
>*gpadc,
>+					int channel, int d1, int d2)
>+{
>+	int b, k, gain, x1, x2;
>+	const struct twl6030_ideal_code *ideal =3D gpadc->pdata->ideal;
>+
>+	/* Gain */
>+	gain =3D ((ideal[channel].volt2 - ideal[channel].volt1) * 1000) /
>+		(ideal[channel].code2 - ideal[channel].code1);
>+
>+	x1 =3D ideal[channel].code1;
>+	x2 =3D ideal[channel].code2;
>+
>+	/* k - real curve gain */
>+	k =3D 1000 + (((d2 - d1) * 1000) / (x2 - x1));
>+
>+	/* b - offset of the real curve gain */
>+	b =3D (d1 * 1000) - (k - 1000) * x1;
>+
>+	gpadc->twl6030_cal_tbl[channel].gain =3D gain;
>+	gpadc->twl6030_cal_tbl[channel].gain_error =3D k;
>+	gpadc->twl6030_cal_tbl[channel].offset_error =3D b;
>+
>+	dev_dbg(gpadc->dev, "GPADC d1   for Chn: %d =3D %d\n", channel, d1);
>+	dev_dbg(gpadc->dev, "GPADC d2   for Chn: %d =3D %d\n", channel, d2);
>+	dev_dbg(gpadc->dev, "GPADC x1   for Chn: %d =3D %d\n", channel, x1);
>+	dev_dbg(gpadc->dev, "GPADC x2   for Chn: %d =3D %d\n", channel, x2);
>+	dev_dbg(gpadc->dev, "GPADC Gain for Chn: %d =3D %d\n", channel, gain);
>+	dev_dbg(gpadc->dev, "GPADC k    for Chn: %d =3D %d\n", channel, k);
>+	dev_dbg(gpadc->dev, "GPADC b    for Chn: %d =3D %d\n", channel, b);
>+}
>+
>+static inline int twl6030_gpadc_get_trim_offset(s8 d)
>+{
>+	/*
>+	 * XXX NOTE!
>+	 * bit 0 - sign, bit 7 - reserved, 6..1 - trim value
>+	 * though, the documentation states that trim value
>+	 * is absolute value, the correct conversion results are
>+	 * obtained if the value is interpreted as 2's complement.
>+	 */
>+	__u32 temp =3D ((d & 0x7f) >> 1) | ((d & 1) << 6);
>+
>+	return sign_extend32(temp, 6);
>+}
>+
>+static int twl6030_calibration(struct twl6030_gpadc_data *gpadc)
>+{
>+	int ret;
>+	int chn;
>+	u8 trim_regs[TWL6030_GPADC_MAX_CHANNELS];
>+	s8 d1, d2;
>+
>+	/*
>+	 * for calibration two measurements have been performed at
>+	 * factory, for some channels, during the production test and
>+	 * have been stored in registers. This two stored values are
>+	 * used to correct the measurements. The values represent
>+	 * offsets for the given input from the output on ideal curve.
>+	 */
>+	ret =3D twl_i2c_read(TWL6030_MODULE_ID2, trim_regs,
>+			TWL6030_GPADC_TRIM1, 16);
>+	if (ret < 0) {
>+		dev_err(gpadc->dev, "calibration failed\n");
>+		return ret;
>+	}
>+
>+	for (chn =3D 0; chn < TWL6030_GPADC_MAX_CHANNELS; chn++) {
>+
>+		switch (chn) {
>+		case 0:
>+			d1 =3D trim_regs[0];
>+			d2 =3D trim_regs[1];
>+			break;
>+		case 1:
>+		case 3:
>+		case 4:
>+		case 5:
>+		case 6:
>+			d1 =3D trim_regs[4];
>+			d2 =3D trim_regs[5];
>+			break;
>+		case 2:
>+			d1 =3D trim_regs[12];
>+			d2 =3D trim_regs[13];
>+			break;
>+		case 7:
>+			d1 =3D trim_regs[6];
>+			d2 =3D trim_regs[7];
>+			break;
>+		case 8:
>+			d1 =3D trim_regs[2];
>+			d2 =3D trim_regs[3];
>+			break;
>+		case 9:
>+			d1 =3D trim_regs[8];
>+			d2 =3D trim_regs[9];
>+			break;
>+		case 10:
>+			d1 =3D trim_regs[10];
>+			d2 =3D trim_regs[11];
>+			break;
>+		case 14:
>+			d1 =3D trim_regs[14];
>+			d2 =3D trim_regs[15];
>+			break;
>+		default:
>+			continue;
>+		}
>+
>+		d1 =3D twl6030_gpadc_get_trim_offset(d1);
>+		d2 =3D twl6030_gpadc_get_trim_offset(d2);
>+
>+		twl6030_calibrate_channel(gpadc, chn, d1, d2);
>+	}
>+
>+	return 0;
>+}
>+
>+static int twl6032_calibration(struct twl6030_gpadc_data *gpadc)
>+{
>+	int chn, d1 =3D 0, d2 =3D 0, temp;
>+	u8 trim_regs[17];
>+	int ret;
>+
>+	ret =3D twl_i2c_read(TWL6030_MODULE_ID2, trim_regs + 1,
>+			TWL6030_GPADC_TRIM1, 16);
>+	if (ret < 0) {
>+		dev_err(gpadc->dev, "calibration failed\n");
>+		return ret;
>+	}
>+
>+	/*
>+	 * Loop to calculate the value needed for returning voltages from
>+	 * GPADC not values.
>+	 *
>+	 * gain is calculated to 3 decimal places fixed point.
>+	 */
>+	for (chn =3D 0; chn < TWL6032_GPADC_MAX_CHANNELS; chn++) {
>+
>+		switch (chn) {
>+		case 0:
>+		case 1:
>+		case 2:
>+		case 3:
>+		case 4:
>+		case 5:
>+		case 6:
>+		case 11:
>+		case 12:
>+		case 13:
>+		case 14:
>+			/* D1 */
>+			d1 =3D (trim_regs[3] & 0x1F) << 2;
>+			d1 |=3D (trim_regs[1] & 0x06) >> 1;
>+			if (trim_regs[1] & 0x01)
>+				d1 =3D -d1;
>+
>+			/* D2 */
>+			d2 =3D (trim_regs[4] & 0x3F) << 2;
>+			d2 |=3D (trim_regs[2] & 0x06) >> 1;
>+			if (trim_regs[2] & 0x01)
>+				d2 =3D -d2;
>+			break;
>+		case 8:
>+			/* D1 */
>+			temp =3D (trim_regs[3] & 0x1F) << 2;
>+			temp |=3D (trim_regs[1] & 0x06) >> 1;
>+			if (trim_regs[1] & 0x01)
>+				temp =3D -temp;
>+
>+			d1 =3D (trim_regs[8] & 0x18) << 1;
>+			d1 |=3D (trim_regs[7] & 0x1E) >> 1;
>+			if (trim_regs[7] & 0x01)
>+				d1 =3D -d1;
>+
>+			d1 +=3D temp;
>+
>+			/* D2 */
>+			temp =3D (trim_regs[4] & 0x3F) << 2;
>+			temp |=3D (trim_regs[2] & 0x06) >> 1;
>+			if (trim_regs[2] & 0x01)
>+				temp =3D -temp;
>+
>+			d2 =3D (trim_regs[10] & 0x1F) << 2;
>+			d2 |=3D (trim_regs[8] & 0x06) >> 1;
>+			if (trim_regs[8] & 0x01)
>+				d2 =3D -d2;
>+
>+			d2 +=3D temp;
>+			break;
>+		case 9:
>+			/* D1 */
>+			temp =3D (trim_regs[3] & 0x1F) << 2;
>+			temp |=3D (trim_regs[1] & 0x06) >> 1;
>+			if (trim_regs[1] & 0x01)
>+				temp =3D -temp;
>+
>+			d1 =3D (trim_regs[14] & 0x18) << 1;
>+			d1 |=3D (trim_regs[12] & 0x1E) >> 1;
>+			if (trim_regs[12] & 0x01)
>+				d1 =3D -d1;
>+
>+			d1 +=3D temp;
>+
>+			/* D2 */
>+			temp =3D (trim_regs[4] & 0x3F) << 2;
>+			temp |=3D (trim_regs[2] & 0x06) >> 1;
>+			if (trim_regs[2] & 0x01)
>+				temp =3D -temp;
>+
>+			d2 =3D (trim_regs[16] & 0x1F) << 2;
>+			d2 |=3D (trim_regs[14] & 0x06) >> 1;
>+			if (trim_regs[14] & 0x01)
>+				d2 =3D -d2;
>+
>+			d2 +=3D temp;
>+		case 10:
>+			/* D1 */
>+			d1 =3D (trim_regs[11] & 0x0F) << 3;
>+			d1 |=3D (trim_regs[9] & 0x0E) >> 1;
>+			if (trim_regs[9] & 0x01)
>+				d1 =3D -d1;
>+
>+			/* D2 */
>+			d2 =3D (trim_regs[15] & 0x0F) << 3;
>+			d2 |=3D (trim_regs[13] & 0x0E) >> 1;
>+			if (trim_regs[13] & 0x01)
>+				d2 =3D -d2;
>+			break;
>+		case 7:
>+		case 18:
>+			/* D1 */
>+			temp =3D (trim_regs[3] & 0x1F) << 2;
>+			temp |=3D (trim_regs[1] & 0x06) >> 1;
>+			if (trim_regs[1] & 0x01)
>+				temp =3D -temp;
>+
>+			d1 =3D (trim_regs[5] & 0x7E) >> 1;
>+			if (trim_regs[5] & 0x01)
>+				d1 =3D -d1;
>+
>+			d1 +=3D temp;
>+
>+			/* D2 */
>+			temp =3D (trim_regs[4] & 0x3F) << 2;
>+			temp |=3D (trim_regs[2] & 0x06) >> 1;
>+			if (trim_regs[2] & 0x01)
>+				temp =3D -temp;
>+
>+			d2 =3D (trim_regs[6] & 0xFE) >> 1;
>+			if (trim_regs[6] & 0x01)
>+				d2 =3D -d2;
>+
>+			d2 +=3D temp;
>+			break;
>+		default:
>+			/* No data for other channels */
>+			continue;
>+		}
>+
>+		twl6030_calibrate_channel(gpadc, chn, d1, d2);
>+	}
>+
>+	return 0;
>+}
>+
>+#define TWL6030_GPADC_CHAN(chn, chan_info) {		\
>+	.type =3D IIO_VOLTAGE,				\
>+	.channel =3D chn,					\
>+	.info_mask =3D BIT(chan_info),			\
>+	.info_mask_separate =3D BIT(chan_info), 		\
>+	.indexed =3D 1,					\
>+}
>+
>+/* internal test network channel */
>+#define TWL6030_GPADC_TEST_CHAN(chn, chan_info) {	\
>+	.type =3D IIO_VOLTAGE,				\
>+	.channel =3D chn,					\
>+	.info_mask =3D BIT(chan_info),			\
>+	.indexed =3D 1,					\
>+}
>+
>+static const struct iio_chan_spec twl6030_gpadc_iio_channels[] =3D {
>+	TWL6030_GPADC_CHAN(0, IIO_CHAN_INFO_PROCESSED),
>+	TWL6030_GPADC_CHAN(1, IIO_CHAN_INFO_PROCESSED),
>+	TWL6030_GPADC_CHAN(2, IIO_CHAN_INFO_PROCESSED),
>+	TWL6030_GPADC_CHAN(3, IIO_CHAN_INFO_PROCESSED),
>+	TWL6030_GPADC_CHAN(4, IIO_CHAN_INFO_PROCESSED),
>+	TWL6030_GPADC_CHAN(5, IIO_CHAN_INFO_PROCESSED),
>+	TWL6030_GPADC_CHAN(6, IIO_CHAN_INFO_PROCESSED),
>+	TWL6030_GPADC_CHAN(7, IIO_CHAN_INFO_PROCESSED),
>+	TWL6030_GPADC_CHAN(8, IIO_CHAN_INFO_PROCESSED),
>+	TWL6030_GPADC_CHAN(9, IIO_CHAN_INFO_PROCESSED),
>+	TWL6030_GPADC_CHAN(10, IIO_CHAN_INFO_PROCESSED),
>+	TWL6030_GPADC_CHAN(11, IIO_CHAN_INFO_RAW),
>+	TWL6030_GPADC_CHAN(12, IIO_CHAN_INFO_RAW),
>+	TWL6030_GPADC_CHAN(13, IIO_CHAN_INFO_RAW),
>+	TWL6030_GPADC_CHAN(14, IIO_CHAN_INFO_PROCESSED),
>+	TWL6030_GPADC_TEST_CHAN(15, IIO_CHAN_INFO_RAW),
>+	TWL6030_GPADC_TEST_CHAN(16, IIO_CHAN_INFO_RAW),
>+};
>+
>+static const struct iio_chan_spec twl6032_gpadc_iio_channels[] =3D {
>+	TWL6030_GPADC_CHAN(0, IIO_CHAN_INFO_PROCESSED),
>+	TWL6030_GPADC_CHAN(1, IIO_CHAN_INFO_PROCESSED),
>+	TWL6030_GPADC_CHAN(2, IIO_CHAN_INFO_PROCESSED),
>+	TWL6030_GPADC_CHAN(3, IIO_CHAN_INFO_PROCESSED),
>+	TWL6030_GPADC_CHAN(4, IIO_CHAN_INFO_PROCESSED),
>+	TWL6030_GPADC_CHAN(5, IIO_CHAN_INFO_PROCESSED),
>+	TWL6030_GPADC_CHAN(6, IIO_CHAN_INFO_PROCESSED),
>+	TWL6030_GPADC_CHAN(7, IIO_CHAN_INFO_PROCESSED),
>+	TWL6030_GPADC_CHAN(8, IIO_CHAN_INFO_PROCESSED),
>+	TWL6030_GPADC_CHAN(9, IIO_CHAN_INFO_PROCESSED),
>+	TWL6030_GPADC_CHAN(10, IIO_CHAN_INFO_PROCESSED),
>+	TWL6030_GPADC_CHAN(11, IIO_CHAN_INFO_PROCESSED),
>+	TWL6030_GPADC_CHAN(12, IIO_CHAN_INFO_PROCESSED),
>+	TWL6030_GPADC_CHAN(13, IIO_CHAN_INFO_PROCESSED),
>+	TWL6030_GPADC_CHAN(14, IIO_CHAN_INFO_PROCESSED),
>+	TWL6030_GPADC_TEST_CHAN(15, IIO_CHAN_INFO_RAW),
>+	TWL6030_GPADC_TEST_CHAN(16, IIO_CHAN_INFO_RAW),
>+	TWL6030_GPADC_CHAN(17, IIO_CHAN_INFO_RAW),
>+	TWL6030_GPADC_CHAN(18, IIO_CHAN_INFO_PROCESSED),
>+};
>+
>+static const struct iio_info twl6030_gpadc_iio_info =3D {
>+	.read_raw =3D &twl6030_gpadc_read_raw,
>+	.driver_module =3D THIS_MODULE,
>+};
>+
>+static const struct twl6030_gpadc_platform_data twl6030_pdata =3D {
>+	.iio_channels =3D twl6030_gpadc_iio_channels,
>+	.nchannels =3D TWL6030_GPADC_MAX_CHANNELS,
>+	.ideal =3D twl6030_ideal,
>+	.start_conversion =3D twl6030_start_conversion,
>+	.channel_to_reg =3D twl6030_channel_to_reg,
>+	.calibrate =3D twl6030_calibration,
>+};
>+
>+static const struct twl6030_gpadc_platform_data twl6032_pdata =3D {
>+	.iio_channels =3D twl6032_gpadc_iio_channels,
>+	.nchannels =3D TWL6032_GPADC_MAX_CHANNELS,
>+	.ideal =3D twl6032_ideal,
>+	.start_conversion =3D twl6032_start_conversion,
>+	.channel_to_reg =3D twl6032_channel_to_reg,
>+	.calibrate =3D twl6032_calibration,
>+};
>+
>+static const struct of_device_id of_twl6030_match_tbl[] =3D {
>+	{
>+		.compatible =3D "ti,twl6030_gpadc",
>+		.data =3D &twl6030_pdata,
>+	},
>+	{
>+		.compatible =3D "ti,twl6032_gpadc",
>+		.data =3D &twl6032_pdata,
>+	},
>+	{ /* end */ }
>+};
>+
>+static int twl6030_gpadc_probe(struct platform_device *pdev)
>+{
>+	struct device *dev =3D &pdev->dev;
>+	struct twl6030_gpadc_data *gpadc;
>+	const struct twl6030_gpadc_platform_data *pdata;
>+	const struct of_device_id *match;
>+	struct iio_dev *indio_dev;
>+	int irq;
>+	int ret;
>+
>+	match =3D of_match_device(of_match_ptr(of_twl6030_match_tbl), dev);
>+	pdata =3D match ? match->data : dev->platform_data;
>+
>+	if (!pdata)
>+		return -EINVAL;
>+
>+	indio_dev =3D iio_device_alloc(sizeof(*gpadc));
>+	if (!indio_dev) {
>+		dev_err(dev, "failed allocating iio device\n");
>+		ret =3D -ENOMEM;
>+	}
>+
>+	gpadc =3D iio_priv(indio_dev);
>+
>+	gpadc->twl6030_cal_tbl =3D devm_kzalloc(dev,
>+					sizeof(struct twl6030_chnl_calib) *
>+					pdata->nchannels, GFP_KERNEL);
>+	if (!gpadc->twl6030_cal_tbl)
>+		goto err_free_device;
>+
>+	gpadc->dev =3D dev;
>+	gpadc->pdata =3D pdata;
>+
>+	platform_set_drvdata(pdev, indio_dev);
>+	mutex_init(&gpadc->lock);
>+	init_completion(&gpadc->irq_complete);
>+
>+	ret =3D pdata->calibrate(gpadc);
>+	if (ret < 0) {
>+		dev_err(&pdev->dev, "failed to read calibration registers\n");
>+		goto err_free_device;
>+	}
>+
>+	irq =3D platform_get_irq(pdev, 0);
>+	if (irq < 0) {
>+		dev_err(&pdev->dev, "failed to get irq\n");
>+		goto err_free_device;
>+	}
>+
>+	ret =3D request_threaded_irq(irq, NULL, twl6030_gpadc_irq_handler,
>+				IRQF_ONESHOT, "twl6030_gpadc", gpadc);
>+	if (ret) {
>+		dev_dbg(&pdev->dev, "could not request irq\n");
>+		goto err_free_device;
>+	}
>+
>+	ret =3D twl6030_gpadc_enable_irq(TWL6030_GPADC_RT_SW1_EOC_MASK);
>+	if (ret < 0) {
>+		dev_err(&pdev->dev, "failed to enable GPADC interrupt\n");
>+		goto err_free_irq;
>+	}
>+
>+	ret =3D twl_i2c_write_u8(TWL6030_MODULE_ID1, TWL6030_GPADCS,
>+					TWL6030_REG_TOGGLE1);
>+	if (ret < 0) {
>+		dev_err(&pdev->dev, "failed to enable GPADC module\n");
>+		goto err_free_irq;
>+	}
>+
>+	indio_dev->name =3D DRIVER_NAME;
>+	indio_dev->dev.parent =3D dev;
>+	indio_dev->info =3D &twl6030_gpadc_iio_info;
>+	indio_dev->modes =3D INDIO_DIRECT_MODE;
>+	indio_dev->channels =3D pdata->iio_channels;
>+	indio_dev->num_channels =3D pdata->nchannels;
>+
>+	ret =3D iio_device_register(indio_dev);
>+	if (ret)
>+		goto err_free_irq;
>+
>+	return ret;
>+
>+err_free_irq:
>+	free_irq(irq, indio_dev);
>+err_free_device:
>+	iio_device_free(indio_dev);
>+
>+	return ret;
>+}
>+
>+static int twl6030_gpadc_remove(struct platform_device *pdev)
>+{
>+	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
>+
>+	twl6030_gpadc_disable_irq(TWL6030_GPADC_RT_SW1_EOC_MASK);
>+	free_irq(platform_get_irq(pdev, 0), indio_dev);
>+	iio_device_unregister(indio_dev);
>+	iio_device_free(indio_dev);
>+
>+	return 0;
>+}
>+
>+#ifdef CONFIG_PM_SLEEP
>+static int twl6030_gpadc_suspend(struct device *pdev)
>+{
>+	int ret;
>+
>+	ret =3D twl_i2c_write_u8(TWL6030_MODULE_ID1, TWL6030_GPADCR,
>+				TWL6030_REG_TOGGLE1);
>+	if (ret)
>+		dev_err(pdev, "error reseting GPADC (%d)!\n", ret);
>+
>+	return 0;
>+};
>+
>+static int twl6030_gpadc_resume(struct device *pdev)
>+{
>+	int ret;
>+
>+	ret =3D twl_i2c_write_u8(TWL6030_MODULE_ID1, TWL6030_GPADCS,
>+				TWL6030_REG_TOGGLE1);
>+	if (ret)
>+		dev_err(pdev, "error setting GPADC (%d)!\n", ret);
>+
>+	return 0;
>+};
>+#endif
>+
>+SIMPLE_DEV_PM_OPS(twl6030_gpadc_pm_ops, twl6030_gpadc_suspend,
>+					twl6030_gpadc_resume);
>+
>+static struct platform_driver twl6030_gpadc_driver =3D {
>+	.probe		=3D twl6030_gpadc_probe,
>+	.remove		=3D twl6030_gpadc_remove,
>+	.driver		=3D {
>+		.name	=3D DRIVER_NAME,
>+		.owner	=3D THIS_MODULE,
>+		.pm	=3D &twl6030_gpadc_pm_ops,
>+		.of_match_table =3D of_twl6030_match_tbl,
>+	},
>+};
>+
>+module_platform_driver(twl6030_gpadc_driver);
>+
>+MODULE_ALIAS("platform: " DRIVER_NAME);
>+MODULE_AUTHOR("Texas Instruments Inc.");
>+MODULE_DESCRIPTION("twl6030 ADC driver");
>+MODULE_LICENSE("GPL");
>--=20
>1.8.1.2
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
------XVSS6TAREA0SBEDZUBMC6PM6O0YU72
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body>Two very quick comments based on quick glance as=
 it may be a while before I can do a full review.<br>
<br>
We still have channels that are only usable for temperature being output =
to user space as voltage channels?  Is the conversion so very hard? <br>
<br>
You have the same entries in info_mask_shared by type and separate. That =
makes no sense. One or the other please!<br>
<br>
<br>
<br><br><div class=3D"gmail_quote">Oleksandr Kozaruk &lt;oleksandr.kozaru=
k@ti.com&gt; wrote:<blockquote class=3D"gmail_quote" style=3D"margin: 0pt=
 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: =
1ex;">
<pre class=3D"k9mail">The GPADC is general purpose ADC found on TWL6030, =
and TWL6032 PMIC,<br />known also as Phoenix and PhoenixLite.<br /><br />=
The TWL6030 and TWL6032 have GPADC with 17 and 19 channels<br />respectiv=
ely. Some channels have current source and are used for<br />measuring vo=
ltage drop on resistive load for detecting battery ID<br />resistance, or=
 measuring voltage drop on NTC resistors for external<br />temperature me=
asurements. Some channels measure voltage, (i.e. battery<br />voltage), a=
nd have voltage dividers, thus, capable to scale voltage.<br />Some chann=
els are dedicated for measuring die temperature.<br /><br />Some channels=
 are calibrated in 2 points, having offsets from ideal<br />values kept i=
n trim registers. This is used to correct measurements.<br /><br />The di=
fferences between GPADC in TWL6030 and TWL6032:<br />- 10 bit vs 12 bit A=
DC;<br />- 17 vs 19 channels;<br />- channels have different purpose(i.e.=
 battery voltage<br />channel 8 vs channel 18);<br
/>- trim values are interpreted differently.<br /><br />Based on the driv=
er patched from Balaji TK, Graeme Gregory, Ambresh K,<br />Girish S Ghong=
demath.<br /><br />Signed-off-by: Balaji T K &lt;balajitk-l0cyMroinI0@public.gmane.org&gt;<br /=
>Signed-off-by: Graeme Gregory &lt;gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org&gt;<br />Signed-off=
-by: Oleksandr Kozaruk &lt;oleksandr.kozaruk-l0cyMroinI0@public.gmane.org&gt;<br />---<br />dri=
vers/iio/adc/Kconfig         |   14 +<br />drivers/iio/adc/Makefile      =
  |    1 +<br />drivers/iio/adc/twl6030-gpadc.c | 1008 ++++++++++++++++++=
+++++++++++++++++++++<br />3 files changed, 1023 insertions(+)<br />creat=
e mode 100644 drivers/iio/adc/twl6030-gpadc.c<br /><br />diff --git a/dri=
vers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig<br />index ab0767e6..31724=
61 100644<br />--- a/drivers/iio/adc/Kconfig<br />+++ b/drivers/iio/adc/K=
config<br />@@ -150,6 +150,20 @@ config TI_AM335X_ADC<br />   Say yes her=
e to build support for Texas Instruments ADC<br />   driver which is also=
 a MFD client.<br /><br />+config
TWL6030_GPADC<br />+ tristate "TWL6030 GPADC (General Purpose A/D Convert=
er) Support"<br />+ depends on TWL4030_CORE<br />+ default n<br />+ help<=
br />+   Say yes here if you want support for the TWL6030/TWL6032 General=
<br />+   Purpose A/D Converter. This will add support for battery type<b=
r />+   detection, battery voltage and temperature measurement, die<br />=
+   temperature measurement, system supply voltage, audio accessory,<br /=
>+   USB ID detection.<br />+<br />+   This driver can also be built as a=
 module. If so, the module will be<br />+   called twl6030-gpadc.<br />+<=
br />config VIPERBOARD_ADC<br /> tristate "Viperboard ADC support"<br /> =
depends on MFD_VIPERBOARD &amp;&amp; USB<br />diff --git a/drivers/iio/ad=
c/Makefile b/drivers/iio/adc/Makefile<br />index 0a825be..996ba09 100644<=
br />--- a/drivers/iio/adc/Makefile<br />+++ b/drivers/iio/adc/Makefile<b=
r />@@ -16,4 +16,5 @@ obj-$(CONFIG_LP8788_ADC) +=3D lp8788_adc.o<br />obj=
-$(CONFIG_MAX1363) +=3D max1363.o<br
/>obj-$(CONFIG_TI_ADC081C) +=3D ti-adc081c.o<br />obj-$(CONFIG_TI_AM335X_=
ADC) +=3D ti_am335x_adc.o<br />+obj-$(CONFIG_TWL6030_GPADC) +=3D twl6030-=
gpadc.o<br />obj-$(CONFIG_VIPERBOARD_ADC) +=3D viperboard_adc.o<br />diff=
 --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.=
c<br />new file mode 100644<br />index 0000000..658f35b<br />--- /dev/nul=
l<br />+++ b/drivers/iio/adc/twl6030-gpadc.c<br />@@ -0,0 +1,1008 @@<br /=
>+/*<br />+ * TWL6030 GPADC module driver<br />+ *<br />+ * Copyright (C)=
 2009-2013 Texas Instruments Inc.<br />+ * Nishant Kamat &lt;nskamat@ti.c=
om&gt;<br />+ * Balaji T K &lt;balajitk-l0cyMroinI0@public.gmane.org&gt;<br />+ * Graeme Gregor=
y &lt;gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org&gt;<br />+ * Girish S Ghongdemath &lt;girishsg@t=
i.com&gt;<br />+ * Ambresh K &lt;ambresh-l0cyMroinI0@public.gmane.org&gt;<br />+ * Oleksandr Ko=
zaruk &lt;oleksandr.kozaruk-l0cyMroinI0@public.gmane.org<br />+ *<br />+ * Based on twl4030-mad=
c.c<br />+ * Copyright (C) 2008 Nokia Corporation<br />+ * Mikko Ylinen &=
lt;mikko.k.ylinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org&gt;<br />+ *<br />+ * This
program is free software; you can redistribute it and/or<br />+ * modify =
it under the terms of the GNU General Public License<br />+ * version 2 a=
s published by the Free Software Foundation.<br />+ *<br />+ * This progr=
am is distributed in the hope that it will be useful, but<br />+ * WITHOU=
T ANY WARRANTY; without even the implied warranty of<br />+ * MERCHANTABI=
LITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU<br />+ * General P=
ublic License for more details.<br />+ *<br />+ * You should have receive=
d a copy of the GNU General Public License<br />+ * along with this progr=
am; if not, write to the Free Software<br />+ * Foundation, Inc., 51 Fran=
klin St, Fifth Floor, Boston, MA<br />+ * 02110-1301 USA<br />+ *<br />+ =
*/<br />+#include &lt;linux/init.h&gt;<br />+#include &lt;linux/interrupt=
.h&gt;<br />+#include &lt;linux/kernel.h&gt;<br />+#include &lt;linux/mod=
ule.h&gt;<br />+#include &lt;linux/platform_device.h&gt;<br />+#include &=
lt;linux/of_platform.h&gt;<br />+#include
&lt;linux/i2c/twl.h&gt;<br />+#include &lt;linux/iio/iio.h&gt;<br />+#inc=
lude &lt;linux/iio/sysfs.h&gt;<br />+<br />+#define DRIVER_NAME  "twl6030=
_gpadc"<br />+<br />+#define TWL6030_GPADC_MAX_CHANNELS 17<br />+#define =
TWL6032_GPADC_MAX_CHANNELS 19<br />+<br />+#define TWL6030_GPADC_CTRL_P1 =
  0x05<br />+<br />+#define TWL6032_GPADC_GPSELECT_ISB  0x07<br />+#defin=
e TWL6032_GPADC_CTRL_P1   0x08<br />+<br />+#define TWL6032_GPADC_GPCH0_L=
SB   0x0d<br />+#define TWL6032_GPADC_GPCH0_MSB   0x0e<br />+<br />+#defi=
ne TWL6030_GPADC_CTRL_P1_SP1  BIT(3)<br />+<br />+#define TWL6030_GPADC_G=
PCH0_LSB   (0x29)<br />+<br />+#define TWL6030_GPADC_RT_SW1_EOC_MASK  BIT=
(5)<br />+<br />+#define TWL6030_GPADC_TRIM1   0xCD<br />+<br />+#define =
TWL6030_REG_TOGGLE1   0x90<br />+#define TWL6030_GPADCS    BIT(1)<br />+#=
define TWL6030_GPADCR    BIT(0)<br />+<br />+/**<br />+ * struct twl6030_=
chnl_calib - channel calibration<br />+ * @gain:  slope coefficient for i=
deal curve<br />+ * @gain_error:  gain error<br
/>+ * @offset_error: offset of the real curve<br />+ */<br />+struct twl6=
030_chnl_calib {<br />+ s32 gain;<br />+ s32 gain_error;<br />+ s32 offse=
t_error;<br />+};<br />+<br />+/**<br />+ * struct twl6030_ideal_code - G=
PADC calibration parameters<br />+ * GPADC is calibrated in two points: c=
lose to the beginning and<br />+ * to the and of the measurable input ran=
ge<br />+ *<br />+ * @code1: ideal code for the input at the beginning<br=
 />+ * @code2: ideal code for at the end of the range<br />+ * @volt1: vo=
ltage input at the beginning(low voltage)<br />+ * @volt2: voltage input =
at the end(high voltage)<br />+ */<br />+struct twl6030_ideal_code {<br /=
>+ u16 code1;<br />+ u16 code2;<br />+ u16 volt1;<br />+ u16 volt2;<br />=
+};<br />+<br />+struct twl6030_gpadc_data;<br />+<br />+/**<br />+ * str=
uct twl6030_gpadc_platform_data - platform specific data<br />+ * @nchann=
els:  number of GPADC channels<br />+ * @iio_channels: iio channels<br />=
+ * @twl6030_ideal: pointer to calibration
parameters<br />+ * @start_conversion: pointer to ADC start conversion fu=
nction<br />+ * @channel_to_reg pointer to ADC function to convert channe=
l to<br />+ *    register address for reading conversion result<br />+ * =
@calibrate:  pointer to calibration function<br />+ */<br />+struct twl60=
30_gpadc_platform_data {<br />+ const int nchannels;<br />+ const struct =
iio_chan_spec *iio_channels;<br />+ const struct twl6030_ideal_code *idea=
l;<br />+ int (*start_conversion)(int channel);<br />+ u8 (*channel_to_re=
g)(int channel);<br />+ int (*calibrate)(struct twl6030_gpadc_data *gpadc=
);<br />+};<br />+<br />+/**<br />+ * struct twl6030_gpadc_data - GPADC d=
ata<br />+ * @dev:  device pointer<br />+ * @lock:  mutual exclusion lock=
 for the structure<br />+ * @irq_complete: completion to signal end of co=
nversion<br />+ * @twl6030_cal_tbl: pointer to calibration data for each<=
br />+ *    channel with gain error and offset<br />+ * @pdata:  pointer =
to device specific data<br />+ */<br />+struct
twl6030_gpadc_data {<br />+ struct device *dev;<br />+ struct mutex lock;=
<br />+ struct completion irq_complete;<br />+ struct twl6030_chnl_calib =
*twl6030_cal_tbl;<br />+ const struct twl6030_gpadc_platform_data *pdata;=
<br />+};<br />+<br />+/*<br />+ * channels 11, 12, 13, 15 and 16 have no=
 calibration data<br />+ * calibration offset is same for channels 1, 3, =
4, 5<br />+ *<br />+ * The data is taken from GPADC_TRIM registers descri=
ption.<br />+ * GPADC_TRIM registers keeps difference between the code me=
asured<br />+ * at volt1 and volt2 input voltages and corresponding code1=
 and code2<br />+ */<br />+static const struct twl6030_ideal_code<br />+ =
twl6030_ideal[TWL6030_GPADC_MAX_CHANNELS] =3D {<br />+ [0] =3D { /* ch 0,=
 external, battery type, resistor value */<br />+  .code1 =3D 116,<br />+=
  .code2 =3D 745,<br />+  .volt1 =3D 141,<br />+  .volt2 =3D 910,<br />+ =
},<br />+ [1] =3D { /* ch 1, external, battery temperature, NTC resistor =
value */<br />+  .code1 =3D 82,<br />+  .code2 =3D 900,<br />+=20
volt1 =3D 100,<br />+  .volt2 =3D 1100,<br />+ },<br />+ [2] =3D { /* ch =
2, external, audio accessory/general purpose */<br />+  .code1 =3D 55,<br=
 />+  .code2 =3D 818,<br />+  .volt1 =3D 101,<br />+  .volt2 =3D 1499,<br=
 />+ },<br />+ [3] =3D { /* ch 3, external, general purpose */<br />+  .c=
ode1 =3D 82,<br />+  .code2 =3D 900,<br />+  .volt1 =3D 100,<br />+  .vol=
t2 =3D 1100,<br />+ },<br />+ [4] =3D { /* ch 4, external, temperature me=
asurement/general purpose */<br />+  .code1 =3D 82,<br />+  .code2 =3D 90=
0,<br />+  .volt1 =3D 100,<br />+  .volt2 =3D 1100,<br />+ },<br />+ [5] =
=3D { /* ch 5, external, general purpose */<br />+  .code1 =3D 82,<br />+=
  .code2 =3D 900,<br />+  .volt1 =3D 100,<br />+  .volt2 =3D 1100,<br />+=
 },<br />+ [6] =3D { /* ch 6, external, general purpose */<br />+  .code1=
 =3D 82,<br />+  .code2 =3D 900,<br />+  .volt1 =3D 100,<br />+  .volt2 =3D=
 1100,<br />+ },<br />+ [7] =3D { /* ch 7, internal, main battery */<br /=
>+  .code1 =3D 614,<br />+  .code2 =3D 941,<br />+  .volt1 =3D 3001,<br /=
>+  .volt2 =3D 4599,<br />+ },<br
/>+ [8] =3D { /* ch 8, internal, backup battery */<br />+  .code1 =3D 82,=
<br />+  .code2 =3D 688,<br />+  .volt1 =3D 501,<br />+  .volt2 =3D 4203,=
<br />+ },<br />+ [9] =3D { /* ch 9, internal, external charger input */<=
br />+  .code1 =3D 182,<br />+  .code2 =3D 818,<br />+  .volt1 =3D 2001,<=
br />+  .volt2 =3D 8996,<br />+ },<br />+ [10] =3D { /* ch 10, internal, =
VBUS */<br />+  .code1 =3D 149,<br />+  .code2 =3D 818,<br />+  .volt1 =3D=
 1001,<br />+  .volt2 =3D 5497,<br />+ },<br />+ [11] =3D {}, /* ch 11, i=
nternal, VBUS charging current */<br />+ [12] =3D {}, /* ch 12, internal,=
 Die temperature */<br />+ [13] =3D {}, /* ch 13, internal, Die temperatu=
re */<br />+ [14] =3D { /* ch 14, internal, USB ID line */<br />+  .code1=
 =3D 48,<br />+  .code2 =3D 714,<br />+  .volt1 =3D 323,<br />+  .volt2 =3D=
 4800,<br />+ },<br />+ [15] =3D {}, /* ch 15, internal, test network */<=
br />+ [16] =3D {}, /* ch 16, internal, test network */<br />+};<br />+<b=
r />+static const struct twl6030_ideal_code<br />+   twl6032_ideal[TWL603=
2_GPADC_MAX_CHANNELS]
=3D {<br />+ [0] =3D { /* ch 0, external, battery type, resistor value */=
<br />+  .code1 =3D 1441,<br />+  .code2 =3D 3276,<br />+  .volt1 =3D 440=
,<br />+  .volt2 =3D 1000,<br />+ },<br />+ [1] =3D { /* ch 1, external, =
battery temperature, NTC resistor value */<br />+  .code1 =3D 1441,<br />=
+  .code2 =3D 3276,<br />+  .volt1 =3D 440,<br />+  .volt2 =3D 1000,<br /=
>+ },<br />+ [2] =3D { /* ch 2, external, audio accessory/general purpose=
 */<br />+  .code1 =3D 1441,<br />+  .code2 =3D 3276,<br />+  .volt1 =3D =
660,<br />+  .volt2 =3D 1500,<br />+ },<br />+ [3] =3D { /* ch 3, externa=
l, temperature with external diode/general<br />+        purpose */<br />=
+  .code1 =3D 1441,<br />+  .code2 =3D 3276,<br />+  .volt1 =3D 440,<br /=
>+  .volt2 =3D 1000,<br />+ },<br />+ [4] =3D { /* ch 4, external, temper=
ature measurement/general purpose */<br />+  .code1 =3D 1441,<br />+  .co=
de2 =3D 3276,<br />+  .volt1 =3D 440,<br />+  .volt2 =3D 1000,<br />+ },<=
br />+ [5] =3D { /* ch 5, external, general purpose */<br />+  .code1 =3D=
 1441,<br />+  .code2 =3D
3276,<br />+  .volt1 =3D 440,<br />+  .volt2 =3D 1000,<br />+ },<br />+ [=
6] =3D { /* ch 6, external, general purpose */<br />+  .code1 =3D 1441,<b=
r />+  .code2 =3D 3276,<br />+  .volt1 =3D 440,<br />+  .volt2 =3D 1000,<=
br />+ },<br />+ [7] =3D { /* ch7, internal, system supply */<br />+  .co=
de1 =3D 1441,<br />+  .code2 =3D 3276,<br />+  .volt1 =3D 2200,<br />+  .=
volt2 =3D 5000,<br />+ },<br />+ [8] =3D { /* ch8, internal, backup batte=
ry */<br />+  .code1 =3D 1441,<br />+  .code2 =3D 3276,<br />+  .volt1 =3D=
 2200,<br />+  .volt2 =3D 5000,<br />+ },<br />+ [9] =3D { /* ch 9, inter=
nal, external charger input */<br />+  .code1 =3D 1441,<br />+  .code2 =3D=
 3276,<br />+  .volt1 =3D 3960,<br />+  .volt2 =3D 9000,<br />+ },<br />+=
 [10] =3D { /* ch10, internal, VBUS */<br />+  .code1 =3D 150,<br />+  .c=
ode2 =3D 751,<br />+  .volt1 =3D 1000,<br />+  .volt2 =3D 5000,<br />+ },=
<br />+ [11] =3D { /* ch 11, internal, VBUS DC-DC output current */<br />=
+  .code1 =3D 1441,<br />+  .code2 =3D 3276,<br />+  .volt1 =3D 660,<br /=
>+  .volt2 =3D 1500,<br />+ },<br />+
[12] =3D { /* ch 12, internal, Die temperature */<br />+  .code1 =3D 1441=
,<br />+  .code2 =3D 3276,<br />+  .volt1 =3D 440,<br />+  .volt2 =3D 100=
0,<br />+ },<br />+ [13] =3D { /* ch 13, internal, Die temperature */<br =
/>+  .code1 =3D 1441,<br />+  .code2 =3D 3276,<br />+  .volt1 =3D 440,<br=
 />+  .volt2 =3D 1000,<br />+ },<br />+ [14] =3D { /* ch 14, internal, US=
B ID line */<br />+  .code1 =3D 1441,<br />+  .code2 =3D 3276,<br />+  .v=
olt1 =3D 2420,<br />+  .volt2 =3D 5500,<br />+ },<br />+ [15] =3D {}, /* =
ch 15, internal, test network */<br />+ [16] =3D {}, /* ch 16, internal, =
test network */<br />+ [17] =3D {}, /* ch 17, internal, battery charging =
current */<br />+ [18] =3D { /* ch 18, internal, battery voltage */<br />=
+  .code1 =3D 1441,<br />+  .code2 =3D 3276,<br />+  .volt1 =3D 2200,<br =
/>+  .volt2 =3D 5000,<br />+ },<br />+};<br />+<br />+static inline int t=
wl6030_gpadc_write(u8 reg, u8 val)<br />+{<br />+ return twl_i2c_write_u8=
(TWL6030_MODULE_GPADC, val, reg);<br />+}<br />+<br />+static inline int =
twl6030_gpadc_read(u8
reg, u8 *val)<br />+{<br />+<br />+ return twl_i2c_read(TWL6030_MODULE_GP=
ADC, val, reg, 2);<br />+}<br />+<br />+static int twl6030_gpadc_enable_i=
rq(u8 mask)<br />+{<br />+ int ret;<br />+<br />+ ret =3D twl6030_interru=
pt_unmask(mask, REG_INT_MSK_LINE_B);<br />+ if (ret &lt; 0)<br />+  retur=
n ret;<br />+<br />+ ret =3D twl6030_interrupt_unmask(mask, REG_INT_MSK_S=
TS_B);<br />+<br />+ return ret;<br />+}<br />+<br />+static void twl6030=
_gpadc_disable_irq(u8 mask)<br />+{<br />+ twl6030_interrupt_mask(mask, R=
EG_INT_MSK_LINE_B);<br />+ twl6030_interrupt_mask(mask, REG_INT_MSK_STS_B=
);<br />+}<br />+<br />+static irqreturn_t twl6030_gpadc_irq_handler(int =
irq, void *_gpadc)<br />+{<br />+ struct twl6030_gpadc_data *gpadc =3D _g=
padc;<br />+<br />+ complete(&amp;gpadc-&gt;irq_complete);<br />+<br />+ =
return IRQ_HANDLED;<br />+}<br />+<br />+static int twl6030_start_convers=
ion(int channel)<br />+{<br />+ return twl6030_gpadc_write(TWL6030_GPADC_=
CTRL_P1,<br />+     TWL6030_GPADC_CTRL_P1_SP1);<br
/>+}<br />+<br />+static int twl6032_start_conversion(int channel)<br />+=
{<br />+ int ret;<br />+<br />+ ret =3D twl6030_gpadc_write(TWL6032_GPADC=
_GPSELECT_ISB, channel);<br />+ if (ret)<br />+  return ret;<br />+<br />=
+ return twl6030_gpadc_write(TWL6032_GPADC_CTRL_P1,<br />+      TWL6030_G=
PADC_CTRL_P1_SP1);<br />+}<br />+<br />+static u8 twl6030_channel_to_reg(=
int channel)<br />+{<br />+ return TWL6030_GPADC_GPCH0_LSB + 2 * channel;=
<br />+}<br />+<br />+static u8 twl6032_channel_to_reg(int channel)<br />=
+{<br />+ /*<br />+  * for any prior chosen channel, when the conversion =
is ready<br />+  * the result is avalable in GPCH0_LSB, GPCH0_MSB.<br />+=
  */<br />+<br />+ return TWL6032_GPADC_GPCH0_LSB;<br />+}<br />+<br />+s=
tatic int twl6030_gpadc_get_raw(struct twl6030_gpadc_data *gpadc,<br />+ =
 int channel, int *res)<br />+{<br />+ u8 reg =3D gpadc-&gt;pdata-&gt;cha=
nnel_to_reg(channel);<br />+ __le16 val;<br />+ int ret;<br />+<br />+ re=
t =3D twl6030_gpadc_read(reg, (u8 *)&amp;val);<br />+
if (ret) {<br />+  dev_dbg(gpadc-&gt;dev, "unable to read register 0x%X\n=
", reg);<br />+  return ret;<br />+ }<br />+<br />+ *res =3D le16_to_cpup=
(&amp;val);<br />+<br />+ return ret;<br />+}<br />+<br />+static int twl=
6030_gpadc_get_processed(struct twl6030_gpadc_data *gpadc,<br />+  int ch=
annel, int *val)<br />+{<br />+ int raw_code;<br />+ int corrected_code;<=
br />+ int channel_value;<br />+ int ret;<br />+<br />+ ret =3D twl6030_g=
padc_get_raw(gpadc, channel, &amp;raw_code);<br />+ if (ret)<br />+  retu=
rn ret;<br />+<br />+ corrected_code =3D ((raw_code * 1000) -<br />+  gpa=
dc-&gt;twl6030_cal_tbl[channel].offset_error) /<br />+  gpadc-&gt;twl6030=
_cal_tbl[channel].gain_error;<br />+<br />+ channel_value =3D corrected_c=
ode *<br />+   gpadc-&gt;twl6030_cal_tbl[channel].gain;<br />+<br />+ /* =
Shift back into mV range */<br />+ channel_value /=3D 1000;<br />+<br />+=
 dev_dbg(gpadc-&gt;dev, "GPADC raw code: %d", raw_code);<br />+ dev_dbg(g=
padc-&gt;dev, "GPADC corrected code: %d",
corrected_code);<br />+ dev_dbg(gpadc-&gt;dev, "GPADC value: %d", channel=
_value);<br />+<br />+ *val =3D channel_value;<br />+<br />+ return ret;<=
br />+}<br />+<br />+static int twl6030_gpadc_read_raw(struct iio_dev *in=
dio_dev,<br />+        const struct iio_chan_spec *chan,<br />+        in=
t *val, int *val2, long mask)<br />+{<br />+ struct twl6030_gpadc_data *g=
padc =3D iio_priv(indio_dev);<br />+ int ret =3D -EINVAL;<br />+ long tim=
eout;<br />+<br />+ mutex_lock(&amp;gpadc-&gt;lock);<br />+<br />+ ret =3D=
 gpadc-&gt;pdata-&gt;start_conversion(chan-&gt;channel);<br />+ if (ret) =
{<br />+  dev_err(gpadc-&gt;dev, "failed to start conversion\n");<br />+ =
 goto err;<br />+ }<br />+ /* wait for conversion to complete */<br />+ t=
imeout =3D wait_for_completion_interruptible_timeout(<br />+    &amp;gpad=
c-&gt;irq_complete, msecs_to_jiffies(5000));<br />+ if (!timeout)<br />+ =
 return -ETIMEDOUT;<br />+ else if (timeout &lt; 0)<br />+  return EINTR;=
<br />+<br />+ switch (mask) {<br />+ case
IIO_CHAN_INFO_RAW:<br />+  ret =3D twl6030_gpadc_get_raw(gpadc, chan-&gt;=
channel, val);<br />+  ret =3D ret ? -EIO : IIO_VAL_INT;<br />+  break;<b=
r />+<br />+ case IIO_CHAN_INFO_PROCESSED:<br />+  ret =3D twl6030_gpadc_=
get_processed(gpadc, chan-&gt;channel, val);<br />+  ret =3D ret ? -EIO :=
 IIO_VAL_INT;<br />+  break;<br />+<br />+ default:<br />+  break;<br />+=
 }<br />+err:<br />+ mutex_unlock(&amp;gpadc-&gt;lock);<br />+<br />+ ret=
urn ret;<br />+}<br />+<br />+/*<br />+ * The GPADC channels are calibrat=
ed using a two point calibration method.<br />+ * The channels measured w=
ith two known values: volt1 and volt2, and<br />+ * ideal corresponding o=
utput codes are known: code1, code2.<br />+ * The difference(d1, d2) betw=
een ideal and measured codes stored in trim<br />+ * registers.<br />+ * =
The goal is to find offset and gain of the real curve for each calibrated=
<br />+ * channel.<br />+ * gain: k =3D 1 + ((d2 - d1) / (x2 - x1))<br />=
+ * offset: b =3D d1 + (k - 1) * x1<br />+ */<br />+static
void twl6030_calibrate_channel(struct twl6030_gpadc_data *gpadc,<br />+  =
   int channel, int d1, int d2)<br />+{<br />+ int b, k, gain, x1, x2;<br=
 />+ const struct twl6030_ideal_code *ideal =3D gpadc-&gt;pdata-&gt;ideal=
;<br />+<br />+ /* Gain */<br />+ gain =3D ((ideal[channel].volt2 - ideal=
[channel].volt1) * 1000) /<br />+  (ideal[channel].code2 - ideal[channel]=
.code1);<br />+<br />+ x1 =3D ideal[channel].code1;<br />+ x2 =3D ideal[c=
hannel].code2;<br />+<br />+ /* k - real curve gain */<br />+ k =3D 1000 =
+ (((d2 - d1) * 1000) / (x2 - x1));<br />+<br />+ /* b - offset of the re=
al curve gain */<br />+ b =3D (d1 * 1000) - (k - 1000) * x1;<br />+<br />=
+ gpadc-&gt;twl6030_cal_tbl[channel].gain =3D gain;<br />+ gpadc-&gt;twl6=
030_cal_tbl[channel].gain_error =3D k;<br />+ gpadc-&gt;twl6030_cal_tbl[c=
hannel].offset_error =3D b;<br />+<br />+ dev_dbg(gpadc-&gt;dev, "GPADC d=
1   for Chn: %d =3D %d\n", channel, d1);<br />+ dev_dbg(gpadc-&gt;dev, "G=
PADC d2   for Chn: %d =3D %d\n", channel, d2);<br />+
dev_dbg(gpadc-&gt;dev, "GPADC x1   for Chn: %d =3D %d\n", channel, x1);<b=
r />+ dev_dbg(gpadc-&gt;dev, "GPADC x2   for Chn: %d =3D %d\n", channel, =
x2);<br />+ dev_dbg(gpadc-&gt;dev, "GPADC Gain for Chn: %d =3D %d\n", cha=
nnel, gain);<br />+ dev_dbg(gpadc-&gt;dev, "GPADC k    for Chn: %d =3D %d=
\n", channel, k);<br />+ dev_dbg(gpadc-&gt;dev, "GPADC b    for Chn: %d =3D=
 %d\n", channel, b);<br />+}<br />+<br />+static inline int twl6030_gpadc=
_get_trim_offset(s8 d)<br />+{<br />+ /*<br />+  * XXX NOTE!<br />+  * bi=
t 0 - sign, bit 7 - reserved, 6..1 - trim value<br />+  * though, the doc=
umentation states that trim value<br />+  * is absolute value, the correc=
t conversion results are<br />+  * obtained if the value is interpreted a=
s 2's complement.<br />+  */<br />+ __u32 temp =3D ((d &amp; 0x7f) &gt;&g=
t; 1) | ((d &amp; 1) &lt;&lt; 6);<br />+<br />+ return sign_extend32(temp=
, 6);<br />+}<br />+<br />+static int twl6030_calibration(struct twl6030_=
gpadc_data *gpadc)<br />+{<br />+ int ret;<br />+ int
chn;<br />+ u8 trim_regs[TWL6030_GPADC_MAX_CHANNELS];<br />+ s8 d1, d2;<b=
r />+<br />+ /*<br />+  * for calibration two measurements have been perf=
ormed at<br />+  * factory, for some channels, during the production test=
 and<br />+  * have been stored in registers. This two stored values are<=
br />+  * used to correct the measurements. The values represent<br />+  =
* offsets for the given input from the output on ideal curve.<br />+  */<=
br />+ ret =3D twl_i2c_read(TWL6030_MODULE_ID2, trim_regs,<br />+   TWL60=
30_GPADC_TRIM1, 16);<br />+ if (ret &lt; 0) {<br />+  dev_err(gpadc-&gt;d=
ev, "calibration failed\n");<br />+  return ret;<br />+ }<br />+<br />+ f=
or (chn =3D 0; chn &lt; TWL6030_GPADC_MAX_CHANNELS; chn++) {<br />+<br />=
+  switch (chn) {<br />+  case 0:<br />+   d1 =3D trim_regs[0];<br />+   =
d2 =3D trim_regs[1];<br />+   break;<br />+  case 1:<br />+  case 3:<br /=
>+  case 4:<br />+  case 5:<br />+  case 6:<br />+   d1 =3D trim_regs[4];=
<br />+   d2 =3D trim_regs[5];<br />+   break;<br />+  case
2:<br />+   d1 =3D trim_regs[12];<br />+   d2 =3D trim_regs[13];<br />+  =
 break;<br />+  case 7:<br />+   d1 =3D trim_regs[6];<br />+   d2 =3D tri=
m_regs[7];<br />+   break;<br />+  case 8:<br />+   d1 =3D trim_regs[2];<=
br />+   d2 =3D trim_regs[3];<br />+   break;<br />+  case 9:<br />+   d1=
 =3D trim_regs[8];<br />+   d2 =3D trim_regs[9];<br />+   break;<br />+  =
case 10:<br />+   d1 =3D trim_regs[10];<br />+   d2 =3D trim_regs[11];<br=
 />+   break;<br />+  case 14:<br />+   d1 =3D trim_regs[14];<br />+   d2=
 =3D trim_regs[15];<br />+   break;<br />+  default:<br />+   continue;<b=
r />+  }<br />+<br />+  d1 =3D twl6030_gpadc_get_trim_offset(d1);<br />+ =
 d2 =3D twl6030_gpadc_get_trim_offset(d2);<br />+<br />+  twl6030_calibra=
te_channel(gpadc, chn, d1, d2);<br />+ }<br />+<br />+ return 0;<br />+}<=
br />+<br />+static int twl6032_calibration(struct twl6030_gpadc_data *gp=
adc)<br />+{<br />+ int chn, d1 =3D 0, d2 =3D 0, temp;<br />+ u8 trim_reg=
s[17];<br />+ int ret;<br />+<br />+ ret =3D twl_i2c_read(TWL6030_MODULE_=
ID2,
trim_regs + 1,<br />+   TWL6030_GPADC_TRIM1, 16);<br />+ if (ret &lt; 0) =
{<br />+  dev_err(gpadc-&gt;dev, "calibration failed\n");<br />+  return =
ret;<br />+ }<br />+<br />+ /*<br />+  * Loop to calculate the value need=
ed for returning voltages from<br />+  * GPADC not values.<br />+  *<br /=
>+  * gain is calculated to 3 decimal places fixed point.<br />+  */<br /=
>+ for (chn =3D 0; chn &lt; TWL6032_GPADC_MAX_CHANNELS; chn++) {<br />+<b=
r />+  switch (chn) {<br />+  case 0:<br />+  case 1:<br />+  case 2:<br =
/>+  case 3:<br />+  case 4:<br />+  case 5:<br />+  case 6:<br />+  case=
 11:<br />+  case 12:<br />+  case 13:<br />+  case 14:<br />+   /* D1 */=
<br />+   d1 =3D (trim_regs[3] &amp; 0x1F) &lt;&lt; 2;<br />+   d1 |=3D (=
trim_regs[1] &amp; 0x06) &gt;&gt; 1;<br />+   if (trim_regs[1] &amp; 0x01=
)<br />+    d1 =3D -d1;<br />+<br />+   /* D2 */<br />+   d2 =3D (trim_re=
gs[4] &amp; 0x3F) &lt;&lt; 2;<br />+   d2 |=3D (trim_regs[2] &amp; 0x06) =
&gt;&gt; 1;<br />+   if (trim_regs[2] &amp; 0x01)<br />+  =20
d2 =3D -d2;<br />+   break;<br />+  case 8:<br />+   /* D1 */<br />+   te=
mp =3D (trim_regs[3] &amp; 0x1F) &lt;&lt; 2;<br />+   temp |=3D (trim_reg=
s[1] &amp; 0x06) &gt;&gt; 1;<br />+   if (trim_regs[1] &amp; 0x01)<br />+=
    temp =3D -temp;<br />+<br />+   d1 =3D (trim_regs[8] &amp; 0x18) &lt;=
&lt; 1;<br />+   d1 |=3D (trim_regs[7] &amp; 0x1E) &gt;&gt; 1;<br />+   i=
f (trim_regs[7] &amp; 0x01)<br />+    d1 =3D -d1;<br />+<br />+   d1 +=3D=
 temp;<br />+<br />+   /* D2 */<br />+   temp =3D (trim_regs[4] &amp; 0x3=
F) &lt;&lt; 2;<br />+   temp |=3D (trim_regs[2] &amp; 0x06) &gt;&gt; 1;<b=
r />+   if (trim_regs[2] &amp; 0x01)<br />+    temp =3D -temp;<br />+<br =
/>+   d2 =3D (trim_regs[10] &amp; 0x1F) &lt;&lt; 2;<br />+   d2 |=3D (tri=
m_regs[8] &amp; 0x06) &gt;&gt; 1;<br />+   if (trim_regs[8] &amp; 0x01)<b=
r />+    d2 =3D -d2;<br />+<br />+   d2 +=3D temp;<br />+   break;<br />+=
  case 9:<br />+   /* D1 */<br />+   temp =3D (trim_regs[3] &amp; 0x1F) &=
lt;&lt; 2;<br />+   temp |=3D (trim_regs[1] &amp; 0x06) &gt;&gt; 1;<br />=
+   if
(trim_regs[1] &amp; 0x01)<br />+    temp =3D -temp;<br />+<br />+   d1 =3D=
 (trim_regs[14] &amp; 0x18) &lt;&lt; 1;<br />+   d1 |=3D (trim_regs[12] &=
amp; 0x1E) &gt;&gt; 1;<br />+   if (trim_regs[12] &amp; 0x01)<br />+    d=
1 =3D -d1;<br />+<br />+   d1 +=3D temp;<br />+<br />+   /* D2 */<br />+ =
  temp =3D (trim_regs[4] &amp; 0x3F) &lt;&lt; 2;<br />+   temp |=3D (trim=
_regs[2] &amp; 0x06) &gt;&gt; 1;<br />+   if (trim_regs[2] &amp; 0x01)<br=
 />+    temp =3D -temp;<br />+<br />+   d2 =3D (trim_regs[16] &amp; 0x1F)=
 &lt;&lt; 2;<br />+   d2 |=3D (trim_regs[14] &amp; 0x06) &gt;&gt; 1;<br /=
>+   if (trim_regs[14] &amp; 0x01)<br />+    d2 =3D -d2;<br />+<br />+   =
d2 +=3D temp;<br />+  case 10:<br />+   /* D1 */<br />+   d1 =3D (trim_re=
gs[11] &amp; 0x0F) &lt;&lt; 3;<br />+   d1 |=3D (trim_regs[9] &amp; 0x0E)=
 &gt;&gt; 1;<br />+   if (trim_regs[9] &amp; 0x01)<br />+    d1 =3D -d1;<=
br />+<br />+   /* D2 */<br />+   d2 =3D (trim_regs[15] &amp; 0x0F) &lt;&=
lt; 3;<br />+   d2 |=3D (trim_regs[13] &amp; 0x0E) &gt;&gt; 1;<br />+   i=
f
(trim_regs[13] &amp; 0x01)<br />+    d2 =3D -d2;<br />+   break;<br />+  =
case 7:<br />+  case 18:<br />+   /* D1 */<br />+   temp =3D (trim_regs[3=
] &amp; 0x1F) &lt;&lt; 2;<br />+   temp |=3D (trim_regs[1] &amp; 0x06) &g=
t;&gt; 1;<br />+   if (trim_regs[1] &amp; 0x01)<br />+    temp =3D -temp;=
<br />+<br />+   d1 =3D (trim_regs[5] &amp; 0x7E) &gt;&gt; 1;<br />+   if=
 (trim_regs[5] &amp; 0x01)<br />+    d1 =3D -d1;<br />+<br />+   d1 +=3D =
temp;<br />+<br />+   /* D2 */<br />+   temp =3D (trim_regs[4] &amp; 0x3F=
) &lt;&lt; 2;<br />+   temp |=3D (trim_regs[2] &amp; 0x06) &gt;&gt; 1;<br=
 />+   if (trim_regs[2] &amp; 0x01)<br />+    temp =3D -temp;<br />+<br /=
>+   d2 =3D (trim_regs[6] &amp; 0xFE) &gt;&gt; 1;<br />+   if (trim_regs[=
6] &amp; 0x01)<br />+    d2 =3D -d2;<br />+<br />+   d2 +=3D temp;<br />+=
   break;<br />+  default:<br />+   /* No data for other channels */<br /=
>+   continue;<br />+  }<br />+<br />+  twl6030_calibrate_channel(gpadc, =
chn, d1, d2);<br />+ }<br />+<br />+ return 0;<br />+}<br />+<br
/>+#define TWL6030_GPADC_CHAN(chn, chan_info) {  \<br />+ .type =3D IIO_V=
OLTAGE,    \<br />+ .channel =3D chn,     \<br />+ .info_mask =3D BIT(cha=
n_info),   \<br />+ .info_mask_separate =3D BIT(chan_info),   \<br />+ .i=
ndexed =3D 1,     \<br />+}<br />+<br />+/* internal test network channel=
 */<br />+#define TWL6030_GPADC_TEST_CHAN(chn, chan_info) { \<br />+ .typ=
e =3D IIO_VOLTAGE,    \<br />+ .channel =3D chn,     \<br />+ .info_mask =
=3D BIT(chan_info),   \<br />+ .indexed =3D 1,     \<br />+}<br />+<br />=
+static const struct iio_chan_spec twl6030_gpadc_iio_channels[] =3D {<br =
/>+ TWL6030_GPADC_CHAN(0, IIO_CHAN_INFO_PROCESSED),<br />+ TWL6030_GPADC_=
CHAN(1, IIO_CHAN_INFO_PROCESSED),<br />+ TWL6030_GPADC_CHAN(2, IIO_CHAN_I=
NFO_PROCESSED),<br />+ TWL6030_GPADC_CHAN(3, IIO_CHAN_INFO_PROCESSED),<br=
 />+ TWL6030_GPADC_CHAN(4, IIO_CHAN_INFO_PROCESSED),<br />+ TWL6030_GPADC=
_CHAN(5, IIO_CHAN_INFO_PROCESSED),<br />+ TWL6030_GPADC_CHAN(6, IIO_CHAN_=
INFO_PROCESSED),<br />+ TWL6030_GPADC_CHAN(7,
IIO_CHAN_INFO_PROCESSED),<br />+ TWL6030_GPADC_CHAN(8, IIO_CHAN_INFO_PROC=
ESSED),<br />+ TWL6030_GPADC_CHAN(9, IIO_CHAN_INFO_PROCESSED),<br />+ TWL=
6030_GPADC_CHAN(10, IIO_CHAN_INFO_PROCESSED),<br />+ TWL6030_GPADC_CHAN(1=
1, IIO_CHAN_INFO_RAW),<br />+ TWL6030_GPADC_CHAN(12, IIO_CHAN_INFO_RAW),<=
br />+ TWL6030_GPADC_CHAN(13, IIO_CHAN_INFO_RAW),<br />+ TWL6030_GPADC_CH=
AN(14, IIO_CHAN_INFO_PROCESSED),<br />+ TWL6030_GPADC_TEST_CHAN(15, IIO_C=
HAN_INFO_RAW),<br />+ TWL6030_GPADC_TEST_CHAN(16, IIO_CHAN_INFO_RAW),<br =
/>+};<br />+<br />+static const struct iio_chan_spec twl6032_gpadc_iio_ch=
annels[] =3D {<br />+ TWL6030_GPADC_CHAN(0, IIO_CHAN_INFO_PROCESSED),<br =
/>+ TWL6030_GPADC_CHAN(1, IIO_CHAN_INFO_PROCESSED),<br />+ TWL6030_GPADC_=
CHAN(2, IIO_CHAN_INFO_PROCESSED),<br />+ TWL6030_GPADC_CHAN(3, IIO_CHAN_I=
NFO_PROCESSED),<br />+ TWL6030_GPADC_CHAN(4, IIO_CHAN_INFO_PROCESSED),<br=
 />+ TWL6030_GPADC_CHAN(5, IIO_CHAN_INFO_PROCESSED),<br />+ TWL6030_GPADC=
_CHAN(6, IIO_CHAN_INFO_PROCESSED),<br />+
TWL6030_GPADC_CHAN(7, IIO_CHAN_INFO_PROCESSED),<br />+ TWL6030_GPADC_CHAN=
(8, IIO_CHAN_INFO_PROCESSED),<br />+ TWL6030_GPADC_CHAN(9, IIO_CHAN_INFO_=
PROCESSED),<br />+ TWL6030_GPADC_CHAN(10, IIO_CHAN_INFO_PROCESSED),<br />=
+ TWL6030_GPADC_CHAN(11, IIO_CHAN_INFO_PROCESSED),<br />+ TWL6030_GPADC_C=
HAN(12, IIO_CHAN_INFO_PROCESSED),<br />+ TWL6030_GPADC_CHAN(13, IIO_CHAN_=
INFO_PROCESSED),<br />+ TWL6030_GPADC_CHAN(14, IIO_CHAN_INFO_PROCESSED),<=
br />+ TWL6030_GPADC_TEST_CHAN(15, IIO_CHAN_INFO_RAW),<br />+ TWL6030_GPA=
DC_TEST_CHAN(16, IIO_CHAN_INFO_RAW),<br />+ TWL6030_GPADC_CHAN(17, IIO_CH=
AN_INFO_RAW),<br />+ TWL6030_GPADC_CHAN(18, IIO_CHAN_INFO_PROCESSED),<br =
/>+};<br />+<br />+static const struct iio_info twl6030_gpadc_iio_info =3D=
 {<br />+ .read_raw =3D &amp;twl6030_gpadc_read_raw,<br />+ .driver_modul=
e =3D THIS_MODULE,<br />+};<br />+<br />+static const struct twl6030_gpad=
c_platform_data twl6030_pdata =3D {<br />+ .iio_channels =3D twl6030_gpad=
c_iio_channels,<br />+ .nchannels =3D
TWL6030_GPADC_MAX_CHANNELS,<br />+ .ideal =3D twl6030_ideal,<br />+ .star=
t_conversion =3D twl6030_start_conversion,<br />+ .channel_to_reg =3D twl=
6030_channel_to_reg,<br />+ .calibrate =3D twl6030_calibration,<br />+};<=
br />+<br />+static const struct twl6030_gpadc_platform_data twl6032_pdat=
a =3D {<br />+ .iio_channels =3D twl6032_gpadc_iio_channels,<br />+ .ncha=
nnels =3D TWL6032_GPADC_MAX_CHANNELS,<br />+ .ideal =3D twl6032_ideal,<br=
 />+ .start_conversion =3D twl6032_start_conversion,<br />+ .channel_to_r=
eg =3D twl6032_channel_to_reg,<br />+ .calibrate =3D twl6032_calibration,=
<br />+};<br />+<br />+static const struct of_device_id of_twl6030_match_=
tbl[] =3D {<br />+ {<br />+  .compatible =3D "ti,twl6030_gpadc",<br />+  =
.data =3D &amp;twl6030_pdata,<br />+ },<br />+ {<br />+  .compatible =3D =
"ti,twl6032_gpadc",<br />+  .data =3D &amp;twl6032_pdata,<br />+ },<br />=
+ { /* end */ }<br />+};<br />+<br />+static int twl6030_gpadc_probe(stru=
ct platform_device *pdev)<br />+{<br />+ struct device *dev =3D
&amp;pdev-&gt;dev;<br />+ struct twl6030_gpadc_data *gpadc;<br />+ const =
struct twl6030_gpadc_platform_data *pdata;<br />+ const struct of_device_=
id *match;<br />+ struct iio_dev *indio_dev;<br />+ int irq;<br />+ int r=
et;<br />+<br />+ match =3D of_match_device(of_match_ptr(of_twl6030_match=
_tbl), dev);<br />+ pdata =3D match ? match-&gt;data : dev-&gt;platform_d=
ata;<br />+<br />+ if (!pdata)<br />+  return -EINVAL;<br />+<br />+ indi=
o_dev =3D iio_device_alloc(sizeof(*gpadc));<br />+ if (!indio_dev) {<br /=
>+  dev_err(dev, "failed allocating iio device\n");<br />+  ret =3D -ENOM=
EM;<br />+ }<br />+<br />+ gpadc =3D iio_priv(indio_dev);<br />+<br />+ g=
padc-&gt;twl6030_cal_tbl =3D devm_kzalloc(dev,<br />+     sizeof(struct t=
wl6030_chnl_calib) *<br />+     pdata-&gt;nchannels, GFP_KERNEL);<br />+ =
if (!gpadc-&gt;twl6030_cal_tbl)<br />+  goto err_free_device;<br />+<br /=
>+ gpadc-&gt;dev =3D dev;<br />+ gpadc-&gt;pdata =3D pdata;<br />+<br />+=
 platform_set_drvdata(pdev, indio_dev);<br />+
mutex_init(&amp;gpadc-&gt;lock);<br />+ init_completion(&amp;gpadc-&gt;ir=
q_complete);<br />+<br />+ ret =3D pdata-&gt;calibrate(gpadc);<br />+ if =
(ret &lt; 0) {<br />+  dev_err(&amp;pdev-&gt;dev, "failed to read calibra=
tion registers\n");<br />+  goto err_free_device;<br />+ }<br />+<br />+ =
irq =3D platform_get_irq(pdev, 0);<br />+ if (irq &lt; 0) {<br />+  dev_e=
rr(&amp;pdev-&gt;dev, "failed to get irq\n");<br />+  goto err_free_devic=
e;<br />+ }<br />+<br />+ ret =3D request_threaded_irq(irq, NULL, twl6030=
_gpadc_irq_handler,<br />+    IRQF_ONESHOT, "twl6030_gpadc", gpadc);<br /=
>+ if (ret) {<br />+  dev_dbg(&amp;pdev-&gt;dev, "could not request irq\n=
");<br />+  goto err_free_device;<br />+ }<br />+<br />+ ret =3D twl6030_=
gpadc_enable_irq(TWL6030_GPADC_RT_SW1_EOC_MASK);<br />+ if (ret &lt; 0) {=
<br />+  dev_err(&amp;pdev-&gt;dev, "failed to enable GPADC interrupt\n")=
;<br />+  goto err_free_irq;<br />+ }<br />+<br />+ ret =3D twl_i2c_write=
_u8(TWL6030_MODULE_ID1, TWL6030_GPADCS,<br />+   =20
TWL6030_REG_TOGGLE1);<br />+ if (ret &lt; 0) {<br />+  dev_err(&amp;pdev-=
&gt;dev, "failed to enable GPADC module\n");<br />+  goto err_free_irq;<b=
r />+ }<br />+<br />+ indio_dev-&gt;name =3D DRIVER_NAME;<br />+ indio_de=
v-&gt;dev.parent =3D dev;<br />+ indio_dev-&gt;info =3D &amp;twl6030_gpad=
c_iio_info;<br />+ indio_dev-&gt;modes =3D INDIO_DIRECT_MODE;<br />+ indi=
o_dev-&gt;channels =3D pdata-&gt;iio_channels;<br />+ indio_dev-&gt;num_c=
hannels =3D pdata-&gt;nchannels;<br />+<br />+ ret =3D iio_device_registe=
r(indio_dev);<br />+ if (ret)<br />+  goto err_free_irq;<br />+<br />+ re=
turn ret;<br />+<br />+err_free_irq:<br />+ free_irq(irq, indio_dev);<br =
/>+err_free_device:<br />+ iio_device_free(indio_dev);<br />+<br />+ retu=
rn ret;<br />+}<br />+<br />+static int twl6030_gpadc_remove(struct platf=
orm_device *pdev)<br />+{<br />+ struct iio_dev *indio_dev =3D platform_g=
et_drvdata(pdev);<br />+<br />+ twl6030_gpadc_disable_irq(TWL6030_GPADC_R=
T_SW1_EOC_MASK);<br />+ free_irq(platform_get_irq(pdev, 0),
indio_dev);<br />+ iio_device_unregister(indio_dev);<br />+ iio_device_fr=
ee(indio_dev);<br />+<br />+ return 0;<br />+}<br />+<br />+#ifdef CONFIG=
_PM_SLEEP<br />+static int twl6030_gpadc_suspend(struct device *pdev)<br =
/>+{<br />+ int ret;<br />+<br />+ ret =3D twl_i2c_write_u8(TWL6030_MODUL=
E_ID1, TWL6030_GPADCR,<br />+    TWL6030_REG_TOGGLE1);<br />+ if (ret)<br=
 />+  dev_err(pdev, "error reseting GPADC (%d)!\n", ret);<br />+<br />+ r=
eturn 0;<br />+};<br />+<br />+static int twl6030_gpadc_resume(struct dev=
ice *pdev)<br />+{<br />+ int ret;<br />+<br />+ ret =3D twl_i2c_write_u8=
(TWL6030_MODULE_ID1, TWL6030_GPADCS,<br />+    TWL6030_REG_TOGGLE1);<br /=
>+ if (ret)<br />+  dev_err(pdev, "error setting GPADC (%d)!\n", ret);<br=
 />+<br />+ return 0;<br />+};<br />+#endif<br />+<br />+SIMPLE_DEV_PM_OP=
S(twl6030_gpadc_pm_ops, twl6030_gpadc_suspend,<br />+     twl6030_gpadc_r=
esume);<br />+<br />+static struct platform_driver twl6030_gpadc_driver =3D=
 {<br />+ .probe  =3D twl6030_gpadc_probe,<br />+
remove  =3D twl6030_gpadc_remove,<br />+ .driver  =3D {<br />+  .name =3D=
 DRIVER_NAME,<br />+  .owner =3D THIS_MODULE,<br />+  .pm =3D &amp;twl603=
0_gpadc_pm_ops,<br />+  .of_match_table =3D of_twl6030_match_tbl,<br />+ =
},<br />+};<br />+<br />+module_platform_driver(twl6030_gpadc_driver);<br=
 />+<br />+MODULE_ALIAS("platform: " DRIVER_NAME);<br />+MODULE_AUTHOR("T=
exas Instruments Inc.");<br />+MODULE_DESCRIPTION("twl6030 ADC driver");<=
br />+MODULE_LICENSE("GPL");</pre></blockquote></div><br>
-- <br>
Sent from my Android phone with K-9 Mail. Please excuse my brevity.</body=
></html>
------XVSS6TAREA0SBEDZUBMC6PM6O0YU72--


--===============4041574489478654339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============4041574489478654339==--
