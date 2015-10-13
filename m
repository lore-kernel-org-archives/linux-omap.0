From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/3] iio:adc: add iio driver for Palmas (twl6035/7)
 gpadc
Date: Tue, 13 Oct 2015 09:14:53 +0100
Message-ID: <20151013081453.GA17172@x1>
References: <86F849CB-1A50-4BEB-99C6-79FF97971DCB@goldelico.com>
 <cover.1444025625.git.hns@goldelico.com>
 <fba10a9902d88110569630da2a86ed4faf261e79.1444025628.git.hns@goldelico.com>
 <561A71B5.6020405@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <561A71B5.6020405-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Pradeep Goudagunta <pgoudagunta-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, jic23-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Sun, 11 Oct 2015, Jonathan Cameron wrote:

> On 05/10/15 07:14, H. Nikolaus Schaller wrote:
> > This driver code was found as:
> >=20
> > https://android.googlesource.com/kernel/tegra/+/aaabb2e045f31e5a970=
109ffdaae900dd403d17e/drivers/staging/iio/adc
> >=20
> > Fixed various compilation issues and test this driver on omap5 evm.
> >=20
> > Signed-off-by: Pradeep Goudagunta <pgoudagunta-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> > Signed-off-by: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
>=20
> I'm pretty much fine with this.  However, there are some edits within=
 the
> existing mfd support so I will want acks for that or for the driver t=
o go
> through the MFD tree (note that as it touched that, even if only a he=
ader,
> Lee and Samuel should have been cc'd).
>=20
> One thing that slightly confuses me is there seems to be hints of sup=
port in the
> mfd driver already... I can't find any sign of the child device howev=
er so
> I guess this is fine from that point of view.
>=20
> Reviewed-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > ---
> >  drivers/iio/adc/Kconfig        |   9 +
> >  drivers/iio/adc/Makefile       |   1 +
> >  drivers/iio/adc/palmas_gpadc.c | 818 +++++++++++++++++++++++++++++=
++++++++++++
> >  include/linux/mfd/palmas.h     |  75 ++--

Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

> >  4 files changed, 879 insertions(+), 24 deletions(-)
> >  create mode 100644 drivers/iio/adc/palmas_gpadc.c
> >=20
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index eb0cd89..05a0368 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -242,6 +242,15 @@ config NAU7802
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called nau7802.
> > =20
> > +config PALMAS_GPADC
> > +	tristate "TI Palmas General Purpose ADC"
> > +	depends on MFD_PALMAS
> > +	help
> > +	  Say yes here to build support for Texas Instruments Palmas.
> > +
> > +	  Palmas series pmic chip (twl6035/6037) is used in smartphones a=
nd
> > +	  tablets and supports a 16 channel general purpose ADC.
> > +
> >  config QCOM_SPMI_IADC
> >  	tristate "Qualcomm SPMI PMIC current ADC"
> >  	depends on SPMI
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index a096210..716f112 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -26,6 +26,7 @@ obj-$(CONFIG_MCP320X) +=3D mcp320x.o
> >  obj-$(CONFIG_MCP3422) +=3D mcp3422.o
> >  obj-$(CONFIG_MEN_Z188_ADC) +=3D men_z188_adc.o
> >  obj-$(CONFIG_NAU7802) +=3D nau7802.o
> > +obj-$(CONFIG_PALMAS_GPADC) +=3D palmas_gpadc.o
> >  obj-$(CONFIG_QCOM_SPMI_IADC) +=3D qcom-spmi-iadc.o
> >  obj-$(CONFIG_QCOM_SPMI_VADC) +=3D qcom-spmi-vadc.o
> >  obj-$(CONFIG_ROCKCHIP_SARADC) +=3D rockchip_saradc.o
> > diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palma=
s_gpadc.c
> > new file mode 100644
> > index 0000000..6805d81
> > --- /dev/null
> > +++ b/drivers/iio/adc/palmas_gpadc.c
> > @@ -0,0 +1,818 @@
> > +/*
> > + * palmas-adc.c -- TI PALMAS GPADC.
> > + *
> > + * Copyright (c) 2013, NVIDIA Corporation. All rights reserved.
> > + *
> > + * Author: Pradeep Goudagunta <pgoudagunta-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation version 2.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/err.h>
> > +#include <linux/irq.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +#include <linux/delay.h>
> > +#include <linux/i2c.h>
> > +#include <linux/pm.h>
> > +#include <linux/mfd/palmas.h>
> > +#include <linux/completion.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/machine.h>
> > +#include <linux/iio/driver.h>
> > +
> > +#define MOD_NAME "palmas-gpadc"
> > +#define PALMAS_ADC_CONVERSION_TIMEOUT	(msecs_to_jiffies(5000))
> > +#define PALMAS_TO_BE_CALCULATED 0
> > +#define PALMAS_GPADC_TRIMINVALID	-1
> > +
> > +struct palmas_gpadc_info {
> > +/* calibration codes and regs */
> > +	int x1;	/* lower ideal code */
> > +	int x2;	/* higher ideal code */
> > +	int v1;	/* expected lower volt reading */
> > +	int v2;	/* expected higher volt reading */
> > +	u8 trim1_reg;	/* register number for lower trim */
> > +	u8 trim2_reg;	/* register number for upper trim */
> > +	int gain;	/* calculated from above (after reading trim regs) */
> > +	int offset;	/* calculated from above (after reading trim regs) */
> > +	int gain_error;	/* calculated from above (after reading trim regs=
) */
> > +	bool is_uncalibrated;	/* if channel has calibration data */
> > +};
> > +
> > +#define PALMAS_ADC_INFO(_chan, _x1, _x2, _v1, _v2, _t1, _t2, _is_u=
ncalibrated) \
> > +	[PALMAS_ADC_CH_##_chan] =3D { \
> > +		.x1 =3D _x1, \
> > +		.x2 =3D _x2, \
> > +		.v1 =3D _v1, \
> > +		.v2 =3D _v2, \
> > +		.gain =3D PALMAS_TO_BE_CALCULATED, \
> > +		.offset =3D PALMAS_TO_BE_CALCULATED, \
> > +		.gain_error =3D PALMAS_TO_BE_CALCULATED, \
> > +		.trim1_reg =3D PALMAS_GPADC_TRIM##_t1, \
> > +		.trim2_reg =3D PALMAS_GPADC_TRIM##_t2,  \
> > +		.is_uncalibrated =3D _is_uncalibrated \
> > +	}
> > +
> > +static struct palmas_gpadc_info palmas_gpadc_info[] =3D {
> > +	PALMAS_ADC_INFO(IN0, 2064, 3112, 630, 950, 1, 2, false),
> > +	PALMAS_ADC_INFO(IN1, 2064, 3112, 630, 950, 1, 2, false),
> > +	PALMAS_ADC_INFO(IN2, 2064, 3112, 1260, 1900, 3, 4, false),
> > +	PALMAS_ADC_INFO(IN3, 2064, 3112, 630, 950, 1, 2, false),
> > +	PALMAS_ADC_INFO(IN4, 2064, 3112, 630, 950, 1, 2, false),
> > +	PALMAS_ADC_INFO(IN5, 2064, 3112, 630, 950, 1, 2, false),
> > +	PALMAS_ADC_INFO(IN6, 2064, 3112, 2520, 3800, 5, 6, false),
> > +	PALMAS_ADC_INFO(IN7, 2064, 3112, 2520, 3800, 7, 8, false),
> > +	PALMAS_ADC_INFO(IN8, 2064, 3112, 3150, 4750, 9, 10, false),
> > +	PALMAS_ADC_INFO(IN9, 2064, 3112, 5670, 8550, 11, 12, false),
> > +	PALMAS_ADC_INFO(IN10, 2064, 3112, 3465, 5225, 13, 14, false),
> > +	PALMAS_ADC_INFO(IN11, 0, 0, 0, 0, INVALID, INVALID, true),
> > +	PALMAS_ADC_INFO(IN12, 0, 0, 0, 0, INVALID, INVALID, true),
> > +	PALMAS_ADC_INFO(IN13, 0, 0, 0, 0, INVALID, INVALID, true),
> > +	PALMAS_ADC_INFO(IN14, 2064, 3112, 3645, 5225, 15, 16, false),
> > +	PALMAS_ADC_INFO(IN15, 0, 0, 0, 0, INVALID, INVALID, true),
> > +};
> > +
> > +/**
> > + * struct palmas_gpadc - the palmas_gpadc structure
> > + * @ch0_current:	channel 0 current source setting
> > + *    0: 0 uA
> > + *    1: 5 uA
> > + *    2: 15 uA
> > + *    3: 20 uA
> > + * @ch3_current:	channel 3 current source setting
> > + *    0: 0 uA
> > + *    1: 10 uA
> > + *    2: 400 uA
> > + *    3: 800 uA
> > + * @extended_delay:	enable the gpadc extended delay mode
> > + * @auto_conversion_period:	define the auto_conversion_period
> > + *
> > + * This is the palmas_gpadc structure to store run-time informatio=
n
> > + * and pointers for this driver instance.
> > + */
> > +
> > +struct palmas_gpadc {
> > +	struct device			*dev;
> > +	struct palmas			*palmas;
> > +	u8				ch0_current;
> > +	u8				ch3_current;
> > +	bool				extended_delay;
> > +	int				irq;
> > +	int				irq_auto_0;
> > +	int				irq_auto_1;
> > +	struct palmas_gpadc_info	*adc_info;
> > +	struct completion		conv_completion;
> > +	struct palmas_adc_wakeup_property wakeup1_data;
> > +	struct palmas_adc_wakeup_property wakeup2_data;
> > +	bool				wakeup1_enable;
> > +	bool				wakeup2_enable;
> > +	int				auto_conversion_period;
> > +};
> > +
> > +/*
> > + * GPADC lock issue in AUTO mode.
> > + * Impact: In AUTO mode, GPADC conversion can be locked after disa=
bling AUTO
> > + *	   mode feature.
> > + * Details:
> > + *	When the AUTO mode is the only conversion mode enabled, if the =
AUTO
> > + *	mode feature is disabled with bit GPADC_AUTO_CTRL.  AUTO_CONV1_=
EN =3D 0
> > + *	or bit GPADC_AUTO_CTRL.  AUTO_CONV0_EN =3D 0 during a conversio=
n, the
> > + *	conversion mechanism can be seen as locked meaning that all fol=
lowing
> > + *	conversion will give 0 as a result.  Bit GPADC_STATUS.GPADC_AVA=
ILABLE
> > + *	will stay at 0 meaning that GPADC is busy.  An RT conversion ca=
n unlock
> > + *	the GPADC.
> > + *
> > + * Workaround(s):
> > + *	To avoid the lock mechanism, the workaround to follow before an=
y stop
> > + *	conversion request is:
> > + *	Force the GPADC state machine to be ON by using the GPADC_CTRL1=
=2E
> > + *		GPADC_FORCE bit =3D 1
> > + *	Shutdown the GPADC AUTO conversion using
> > + *		GPADC_AUTO_CTRL.SHUTDOWN_CONV[01] =3D 0.
> > + *	After 100us, force the GPADC state machine to be OFF by using t=
he
> > + *		GPADC_CTRL1.  GPADC_FORCE bit =3D 0
> > + */
> > +
> > +static int palmas_disable_auto_conversion(struct palmas_gpadc *adc=
)
> > +{
> > +	int ret;
> > +
> > +	ret =3D palmas_update_bits(adc->palmas, PALMAS_GPADC_BASE,
> > +			PALMAS_GPADC_CTRL1,
> > +			PALMAS_GPADC_CTRL1_GPADC_FORCE,
> > +			PALMAS_GPADC_CTRL1_GPADC_FORCE);
> > +	if (ret < 0) {
> > +		dev_err(adc->dev, "GPADC_CTRL1 update failed: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret =3D palmas_update_bits(adc->palmas, PALMAS_GPADC_BASE,
> > +			PALMAS_GPADC_AUTO_CTRL,
> > +			PALMAS_GPADC_AUTO_CTRL_SHUTDOWN_CONV1 |
> > +			PALMAS_GPADC_AUTO_CTRL_SHUTDOWN_CONV0,
> > +			0);
> > +	if (ret < 0) {
> > +		dev_err(adc->dev, "AUTO_CTRL update failed: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	udelay(100);
> > +
> > +	ret =3D palmas_update_bits(adc->palmas, PALMAS_GPADC_BASE,
> > +			PALMAS_GPADC_CTRL1,
> > +			PALMAS_GPADC_CTRL1_GPADC_FORCE, 0);
> > +	if (ret < 0)
> > +		dev_err(adc->dev, "GPADC_CTRL1 update failed: %d\n", ret);
> > +
> > +	return ret;
> > +}
> > +
> > +static irqreturn_t palmas_gpadc_irq(int irq, void *data)
> > +{
> > +	struct palmas_gpadc *adc =3D data;
> > +
> > +	complete(&adc->conv_completion);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t palmas_gpadc_irq_auto(int irq, void *data)
> > +{
> > +	struct palmas_gpadc *adc =3D data;
> > +
> > +	dev_dbg(adc->dev, "Threshold interrupt %d occurs\n", irq);
> > +	palmas_disable_auto_conversion(adc);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int palmas_gpadc_start_mask_interrupt(struct palmas_gpadc *=
adc,
> > +							bool mask)
> > +{
> > +	int ret;
> > +
> > +	if (!mask)
> > +		ret =3D palmas_update_bits(adc->palmas, PALMAS_INTERRUPT_BASE,
> > +					PALMAS_INT3_MASK,
> > +					PALMAS_INT3_MASK_GPADC_EOC_SW, 0);
> > +	else
> > +		ret =3D palmas_update_bits(adc->palmas, PALMAS_INTERRUPT_BASE,
> > +					PALMAS_INT3_MASK,
> > +					PALMAS_INT3_MASK_GPADC_EOC_SW,
> > +					PALMAS_INT3_MASK_GPADC_EOC_SW);
> > +	if (ret < 0)
> > +		dev_err(adc->dev, "GPADC INT MASK update failed: %d\n", ret);
> > +
> > +	return ret;
> > +}
> > +
> > +static int palmas_gpadc_enable(struct palmas_gpadc *adc, int adc_c=
han,
> > +			       int enable)
> > +{
> > +	unsigned int mask, val;
> > +	int ret;
> > +
> > +	if (enable) {
> > +		val =3D (adc->extended_delay
> > +			<< PALMAS_GPADC_RT_CTRL_EXTEND_DELAY_SHIFT);
> > +		ret =3D palmas_update_bits(adc->palmas, PALMAS_GPADC_BASE,
> > +					PALMAS_GPADC_RT_CTRL,
> > +					PALMAS_GPADC_RT_CTRL_EXTEND_DELAY, val);
> > +		if (ret < 0) {
> > +			dev_err(adc->dev, "RT_CTRL update failed: %d\n", ret);
> > +			return ret;
> > +		}
> > +
> > +		mask =3D (PALMAS_GPADC_CTRL1_CURRENT_SRC_CH0_MASK |
> > +			PALMAS_GPADC_CTRL1_CURRENT_SRC_CH3_MASK |
> > +			PALMAS_GPADC_CTRL1_GPADC_FORCE);
> > +		val =3D (adc->ch0_current
> > +			<< PALMAS_GPADC_CTRL1_CURRENT_SRC_CH0_SHIFT);
> > +		val |=3D (adc->ch3_current
> > +			<< PALMAS_GPADC_CTRL1_CURRENT_SRC_CH3_SHIFT);
> > +		val |=3D PALMAS_GPADC_CTRL1_GPADC_FORCE;
> > +		ret =3D palmas_update_bits(adc->palmas, PALMAS_GPADC_BASE,
> > +				PALMAS_GPADC_CTRL1, mask, val);
> > +		if (ret < 0) {
> > +			dev_err(adc->dev,
> > +				"Failed to update current setting: %d\n", ret);
> > +			return ret;
> > +		}
> > +
> > +		mask =3D (PALMAS_GPADC_SW_SELECT_SW_CONV0_SEL_MASK |
> > +			PALMAS_GPADC_SW_SELECT_SW_CONV_EN);
> > +		val =3D (adc_chan | PALMAS_GPADC_SW_SELECT_SW_CONV_EN);
> > +		ret =3D palmas_update_bits(adc->palmas, PALMAS_GPADC_BASE,
> > +				PALMAS_GPADC_SW_SELECT, mask, val);
> > +		if (ret < 0) {
> > +			dev_err(adc->dev, "SW_SELECT update failed: %d\n", ret);
> > +			return ret;
> > +		}
> > +	} else {
> > +		ret =3D palmas_write(adc->palmas, PALMAS_GPADC_BASE,
> > +				PALMAS_GPADC_SW_SELECT, 0);
> > +		if (ret < 0)
> > +			dev_err(adc->dev, "SW_SELECT write failed: %d\n", ret);
> > +
> > +		ret =3D palmas_update_bits(adc->palmas, PALMAS_GPADC_BASE,
> > +				PALMAS_GPADC_CTRL1,
> > +				PALMAS_GPADC_CTRL1_GPADC_FORCE, 0);
> > +		if (ret < 0) {
> > +			dev_err(adc->dev, "CTRL1 update failed: %d\n", ret);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int palmas_gpadc_read_prepare(struct palmas_gpadc *adc, int=
 adc_chan)
> > +{
> > +	int ret;
> > +
> > +	ret =3D palmas_gpadc_enable(adc, adc_chan, true);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return palmas_gpadc_start_mask_interrupt(adc, 0);
> > +}
> > +
> > +static void palmas_gpadc_read_done(struct palmas_gpadc *adc, int a=
dc_chan)
> > +{
> > +	palmas_gpadc_start_mask_interrupt(adc, 1);
> > +	palmas_gpadc_enable(adc, adc_chan, false);
> > +}
> > +
> > +static int palmas_gpadc_calibrate(struct palmas_gpadc *adc, int ad=
c_chan)
> > +{
> > +	int k;
> > +	int d1;
> > +	int d2;
> > +	int ret;
> > +	int gain;
> > +	int x1 =3D  adc->adc_info[adc_chan].x1;
> > +	int x2 =3D  adc->adc_info[adc_chan].x2;
> > +	int v1 =3D adc->adc_info[adc_chan].v1;
> > +	int v2 =3D adc->adc_info[adc_chan].v2;
> > +
> > +	ret =3D palmas_read(adc->palmas, PALMAS_TRIM_GPADC_BASE,
> > +				adc->adc_info[adc_chan].trim1_reg, &d1);
> > +	if (ret < 0) {
> > +		dev_err(adc->dev, "TRIM read failed: %d\n", ret);
> > +		goto scrub;
> > +	}
> > +
> > +	ret =3D palmas_read(adc->palmas, PALMAS_TRIM_GPADC_BASE,
> > +				adc->adc_info[adc_chan].trim2_reg, &d2);
> > +	if (ret < 0) {
> > +		dev_err(adc->dev, "TRIM read failed: %d\n", ret);
> > +		goto scrub;
> > +	}
> > +
> > +	/* gain error calculation */
> > +	k =3D (1000 + (1000 * (d2 - d1)) / (x2 - x1));
> > +
> > +	/* gain calculation */
> > +	gain =3D ((v2 - v1) * 1000) / (x2 - x1);
> > +
> > +	adc->adc_info[adc_chan].gain_error =3D k;
> > +	adc->adc_info[adc_chan].gain =3D gain;
> > +	/* offset Calculation */
> > +	adc->adc_info[adc_chan].offset =3D (d1 * 1000) - ((k - 1000) * x1=
);
> > +
> > +scrub:
> > +	return ret;
> > +}
> > +
> > +static int palmas_gpadc_start_conversion(struct palmas_gpadc *adc,=
 int adc_chan)
> > +{
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	init_completion(&adc->conv_completion);
> > +	ret =3D palmas_update_bits(adc->palmas, PALMAS_GPADC_BASE,
> > +				PALMAS_GPADC_SW_SELECT,
> > +				PALMAS_GPADC_SW_SELECT_SW_START_CONV0,
> > +				PALMAS_GPADC_SW_SELECT_SW_START_CONV0);
> > +	if (ret < 0) {
> > +		dev_err(adc->dev, "SELECT_SW_START write failed: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret =3D wait_for_completion_timeout(&adc->conv_completion,
> > +				PALMAS_ADC_CONVERSION_TIMEOUT);
> > +	if (ret =3D=3D 0) {
> > +		dev_err(adc->dev, "conversion not completed\n");
> > +		return -ETIMEDOUT;
> > +	}
> > +
> > +	ret =3D palmas_bulk_read(adc->palmas, PALMAS_GPADC_BASE,
> > +				PALMAS_GPADC_SW_CONV0_LSB, &val, 2);
> > +	if (ret < 0) {
> > +		dev_err(adc->dev, "SW_CONV0_LSB read failed: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret =3D val & 0xFFF;
> > +
> > +	return ret;
> > +}
> > +
> > +static int palmas_gpadc_get_calibrated_code(struct palmas_gpadc *a=
dc,
> > +						int adc_chan, int val)
> > +{
> > +	if (!adc->adc_info[adc_chan].is_uncalibrated)
> > +		val  =3D (val*1000 - adc->adc_info[adc_chan].offset) /
> > +					adc->adc_info[adc_chan].gain_error;
> > +
> > +	if (val < 0) {
> > +		dev_err(adc->dev, "Mismatch with calibration\n");
> > +		return 0;
> > +	}
> > +
> > +	val =3D (val * adc->adc_info[adc_chan].gain) / 1000;
> > +
> > +	return val;
> > +}
> > +
> > +static int palmas_gpadc_read_raw(struct iio_dev *indio_dev,
> > +	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
> > +{
> > +	struct  palmas_gpadc *adc =3D iio_priv(indio_dev);
> > +	int adc_chan =3D chan->channel;
> > +	int ret =3D 0;
> > +
> > +	if (adc_chan > PALMAS_ADC_CH_MAX)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&indio_dev->mlock);
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +	case IIO_CHAN_INFO_PROCESSED:
> > +		ret =3D palmas_gpadc_read_prepare(adc, adc_chan);
> > +		if (ret < 0)
> > +			goto out;
> > +
> > +		ret =3D palmas_gpadc_start_conversion(adc, adc_chan);
> > +		if (ret < 0) {
> > +			dev_err(adc->dev,
> > +			"ADC start conversion failed\n");
> > +			goto out;
> > +		}
> > +
> > +		if (mask =3D=3D IIO_CHAN_INFO_PROCESSED)
> > +			ret =3D palmas_gpadc_get_calibrated_code(
> > +							adc, adc_chan, ret);
> > +
> > +		*val =3D ret;
> > +
> > +		ret =3D IIO_VAL_INT;
> > +		goto out;
> > +	}
> > +
> > +	mutex_unlock(&indio_dev->mlock);
> > +	return ret;
> > +
> > +out:
> > +	palmas_gpadc_read_done(adc, adc_chan);
> > +	mutex_unlock(&indio_dev->mlock);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct iio_info palmas_gpadc_iio_info =3D {
> > +	.read_raw =3D palmas_gpadc_read_raw,
> > +	.driver_module =3D THIS_MODULE,
> > +};
> > +
> > +#define PALMAS_ADC_CHAN_IIO(chan, _type, chan_info)	\
> > +{							\
> > +	.datasheet_name =3D PALMAS_DATASHEET_NAME(chan),	\
> > +	.type =3D _type,					\
> > +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |	\
> > +			BIT(chan_info),			\
> > +	.indexed =3D 1,					\
> > +	.channel =3D PALMAS_ADC_CH_##chan,		\
> > +}
> > +
> > +static const struct iio_chan_spec palmas_gpadc_iio_channel[] =3D {
> > +	PALMAS_ADC_CHAN_IIO(IN0, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
> > +	PALMAS_ADC_CHAN_IIO(IN1, IIO_TEMP, IIO_CHAN_INFO_RAW),
> > +	PALMAS_ADC_CHAN_IIO(IN2, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
> > +	PALMAS_ADC_CHAN_IIO(IN3, IIO_TEMP, IIO_CHAN_INFO_RAW),
> > +	PALMAS_ADC_CHAN_IIO(IN4, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
> > +	PALMAS_ADC_CHAN_IIO(IN5, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
> > +	PALMAS_ADC_CHAN_IIO(IN6, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
> > +	PALMAS_ADC_CHAN_IIO(IN7, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
> > +	PALMAS_ADC_CHAN_IIO(IN8, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
> > +	PALMAS_ADC_CHAN_IIO(IN9, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
> > +	PALMAS_ADC_CHAN_IIO(IN10, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
> > +	PALMAS_ADC_CHAN_IIO(IN11, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
> > +	PALMAS_ADC_CHAN_IIO(IN12, IIO_TEMP, IIO_CHAN_INFO_RAW),
> > +	PALMAS_ADC_CHAN_IIO(IN13, IIO_TEMP, IIO_CHAN_INFO_RAW),
> > +	PALMAS_ADC_CHAN_IIO(IN14, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
> > +	PALMAS_ADC_CHAN_IIO(IN15, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
> > +};
> > +
> > +static int palmas_gpadc_probe(struct platform_device *pdev)
> > +{
> > +	struct palmas_gpadc *adc;
> > +	struct palmas_platform_data *pdata;
> > +	struct palmas_gpadc_platform_data *gpadc_pdata =3D NULL;
> > +	struct iio_dev *indio_dev;
> > +	int ret, i;
> > +
> > +	pdata =3D dev_get_platdata(pdev->dev.parent);
> > +	if (!pdata || !pdata->gpadc_pdata) {
> > +		dev_err(&pdev->dev, "No platform data\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	gpadc_pdata =3D pdata->gpadc_pdata;
> > +
> > +	indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*adc));
> > +	if (!indio_dev) {
> > +		dev_err(&pdev->dev, "iio_device_alloc failed\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	adc =3D iio_priv(indio_dev);
> > +	adc->dev =3D &pdev->dev;
> > +	adc->palmas =3D dev_get_drvdata(pdev->dev.parent);
> > +	adc->adc_info =3D palmas_gpadc_info;
> > +	init_completion(&adc->conv_completion);
> > +	dev_set_drvdata(&pdev->dev, indio_dev);
> > +
> > +	adc->auto_conversion_period =3D gpadc_pdata->auto_conversion_peri=
od_ms;
> > +	adc->irq =3D palmas_irq_get_virq(adc->palmas, PALMAS_GPADC_EOC_SW=
_IRQ);
> > +	if (adc->irq < 0) {
> > +		dev_err(adc->dev,
> > +			"get virq failed: %d\n", adc->irq);
> > +		ret =3D adc->irq;
> > +		goto out;
> > +	}
> > +	ret =3D request_threaded_irq(adc->irq, NULL,
> > +		palmas_gpadc_irq,
> > +		IRQF_ONESHOT | IRQF_EARLY_RESUME, dev_name(adc->dev),
> > +		adc);
> > +	if (ret < 0) {
> > +		dev_err(adc->dev,
> > +			"request irq %d failed: %d\n", adc->irq, ret);
> > +		goto out;
> > +	}
> > +
> > +	if (gpadc_pdata->adc_wakeup1_data) {
> > +		memcpy(&adc->wakeup1_data, gpadc_pdata->adc_wakeup1_data,
> > +			sizeof(adc->wakeup1_data));
> > +		adc->wakeup1_enable =3D true;
> > +		adc->irq_auto_0 =3D  platform_get_irq(pdev, 1);
> > +		ret =3D request_threaded_irq(adc->irq_auto_0, NULL,
> > +				palmas_gpadc_irq_auto,
> > +				IRQF_ONESHOT | IRQF_EARLY_RESUME,
> > +				"palmas-adc-auto-0", adc);
> > +		if (ret < 0) {
> > +			dev_err(adc->dev, "request auto0 irq %d failed: %d\n",
> > +				adc->irq_auto_0, ret);
> > +			goto out_irq_free;
> > +		}
> > +	}
> > +
> > +	if (gpadc_pdata->adc_wakeup2_data) {
> > +		memcpy(&adc->wakeup2_data, gpadc_pdata->adc_wakeup2_data,
> > +				sizeof(adc->wakeup2_data));
> > +		adc->wakeup2_enable =3D true;
> > +		adc->irq_auto_1 =3D  platform_get_irq(pdev, 2);
> > +		ret =3D request_threaded_irq(adc->irq_auto_1, NULL,
> > +				palmas_gpadc_irq_auto,
> > +				IRQF_ONESHOT | IRQF_EARLY_RESUME,
> > +				"palmas-adc-auto-1", adc);
> > +		if (ret < 0) {
> > +			dev_err(adc->dev, "request auto1 irq %d failed: %d\n",
> > +				adc->irq_auto_1, ret);
> > +			goto out_irq_auto0_free;
> > +		}
> > +	}
> > +
> > +	/* set the current source 0 (value 0/5/15/20 uA =3D> 0..3) */
> > +	if (gpadc_pdata->ch0_current <=3D 1)
> > +		adc->ch0_current =3D PALMAS_ADC_CH0_CURRENT_SRC_0;
> > +	else if (gpadc_pdata->ch0_current <=3D 5)
> > +		adc->ch0_current =3D PALMAS_ADC_CH0_CURRENT_SRC_5;
> > +	else if (gpadc_pdata->ch0_current <=3D 15)
> > +		adc->ch0_current =3D PALMAS_ADC_CH0_CURRENT_SRC_15;
> > +	else
> > +		adc->ch0_current =3D PALMAS_ADC_CH0_CURRENT_SRC_20;
> > +
> > +	/* set the current source 3 (value 0/10/400/800 uA =3D> 0..3) */
> > +	if (gpadc_pdata->ch3_current <=3D 1)
> > +		adc->ch3_current =3D PALMAS_ADC_CH3_CURRENT_SRC_0;
> > +	else if (gpadc_pdata->ch3_current <=3D 10)
> > +		adc->ch3_current =3D PALMAS_ADC_CH3_CURRENT_SRC_10;
> > +	else if (gpadc_pdata->ch3_current <=3D 400)
> > +		adc->ch3_current =3D PALMAS_ADC_CH3_CURRENT_SRC_400;
> > +	else
> > +		adc->ch3_current =3D PALMAS_ADC_CH3_CURRENT_SRC_800;
> > +
> > +	adc->extended_delay =3D gpadc_pdata->extended_delay;
> > +
> > +	indio_dev->name =3D MOD_NAME;
> > +	indio_dev->dev.parent =3D &pdev->dev;
> > +	indio_dev->info =3D &palmas_gpadc_iio_info;
> > +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +	indio_dev->channels =3D palmas_gpadc_iio_channel;
> > +	indio_dev->num_channels =3D ARRAY_SIZE(palmas_gpadc_iio_channel);
> > +
> > +	ret =3D iio_device_register(indio_dev);
> > +	if (ret < 0) {
> > +		dev_err(adc->dev, "iio_device_register() failed: %d\n", ret);
> > +		goto out_irq_auto1_free;
> > +	}
> > +
> > +	device_set_wakeup_capable(&pdev->dev, 1);
> > +	for (i =3D 0; i < PALMAS_ADC_CH_MAX; i++) {
> > +		if (!(adc->adc_info[i].is_uncalibrated))
> > +			palmas_gpadc_calibrate(adc, i);
> > +	}
> > +
> > +	if (adc->wakeup1_enable || adc->wakeup2_enable)
> > +		device_wakeup_enable(&pdev->dev);
> > +
> > +	return 0;
> > +
> > +out_irq_auto1_free:
> > +	if (gpadc_pdata->adc_wakeup2_data)
> > +		free_irq(adc->irq_auto_1, adc);
> > +out_irq_auto0_free:
> > +	if (gpadc_pdata->adc_wakeup1_data)
> > +		free_irq(adc->irq_auto_0, adc);
> > +out_irq_free:
> > +	free_irq(adc->irq, adc);
> > +out:
> > +	return ret;
> > +}
> > +
> > +static int palmas_gpadc_remove(struct platform_device *pdev)
> > +{
> > +	struct iio_dev *indio_dev =3D dev_to_iio_dev(&pdev->dev);
> > +	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
> > +
> > +	if (adc->wakeup1_enable || adc->wakeup2_enable)
> > +		device_wakeup_disable(&pdev->dev);
> > +	iio_device_unregister(indio_dev);
> > +	free_irq(adc->irq, adc);
> > +	if (adc->wakeup1_enable)
> > +		free_irq(adc->irq_auto_0, adc);
> > +	if (adc->wakeup2_enable)
> > +		free_irq(adc->irq_auto_1, adc);
> > +
> > +	return 0;
> > +}
> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +static int palmas_adc_wakeup_configure(struct palmas_gpadc *adc)
> > +{
> > +	int adc_period, conv;
> > +	int i;
> > +	int ch0 =3D 0, ch1 =3D 0;
> > +	int thres;
> > +	int ret;
> > +
> > +	adc_period =3D adc->auto_conversion_period;
> > +	for (i =3D 0; i < 16; ++i) {
> > +		if (((1000 * (1 << i)) / 32) < adc_period)
> > +			continue;
> > +	}
> > +	if (i > 0)
> > +		i--;
> > +	adc_period =3D i;
> > +	ret =3D palmas_update_bits(adc->palmas, PALMAS_GPADC_BASE,
> > +			PALMAS_GPADC_AUTO_CTRL,
> > +			PALMAS_GPADC_AUTO_CTRL_COUNTER_CONV_MASK,
> > +			adc_period);
> > +	if (ret < 0) {
> > +		dev_err(adc->dev, "AUTO_CTRL write failed: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	conv =3D 0;
> > +	if (adc->wakeup1_enable) {
> > +		int polarity;
> > +
> > +		ch0 =3D adc->wakeup1_data.adc_channel_number;
> > +		conv |=3D PALMAS_GPADC_AUTO_CTRL_AUTO_CONV0_EN;
> > +		if (adc->wakeup1_data.adc_high_threshold > 0) {
> > +			thres =3D adc->wakeup1_data.adc_high_threshold;
> > +			polarity =3D 0;
> > +		} else {
> > +			thres =3D adc->wakeup1_data.adc_low_threshold;
> > +			polarity =3D PALMAS_GPADC_THRES_CONV0_MSB_THRES_CONV0_POL;
> > +		}
> > +
> > +		ret =3D palmas_write(adc->palmas, PALMAS_GPADC_BASE,
> > +				PALMAS_GPADC_THRES_CONV0_LSB, thres & 0xFF);
> > +		if (ret < 0) {
> > +			dev_err(adc->dev,
> > +				"THRES_CONV0_LSB write failed: %d\n", ret);
> > +			return ret;
> > +		}
> > +
> > +		ret =3D palmas_write(adc->palmas, PALMAS_GPADC_BASE,
> > +				PALMAS_GPADC_THRES_CONV0_MSB,
> > +				((thres >> 8) & 0xF) | polarity);
> > +		if (ret < 0) {
> > +			dev_err(adc->dev,
> > +				"THRES_CONV0_MSB write failed: %d\n", ret);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	if (adc->wakeup2_enable) {
> > +		int polarity;
> > +
> > +		ch1 =3D adc->wakeup2_data.adc_channel_number;
> > +		conv |=3D PALMAS_GPADC_AUTO_CTRL_AUTO_CONV1_EN;
> > +		if (adc->wakeup2_data.adc_high_threshold > 0) {
> > +			thres =3D adc->wakeup2_data.adc_high_threshold;
> > +			polarity =3D 0;
> > +		} else {
> > +			thres =3D adc->wakeup2_data.adc_low_threshold;
> > +			polarity =3D PALMAS_GPADC_THRES_CONV1_MSB_THRES_CONV1_POL;
> > +		}
> > +
> > +		ret =3D palmas_write(adc->palmas, PALMAS_GPADC_BASE,
> > +				PALMAS_GPADC_THRES_CONV1_LSB, thres & 0xFF);
> > +		if (ret < 0) {
> > +			dev_err(adc->dev,
> > +				"THRES_CONV1_LSB write failed: %d\n", ret);
> > +			return ret;
> > +		}
> > +
> > +		ret =3D palmas_write(adc->palmas, PALMAS_GPADC_BASE,
> > +				PALMAS_GPADC_THRES_CONV1_MSB,
> > +				((thres >> 8) & 0xF) | polarity);
> > +		if (ret < 0) {
> > +			dev_err(adc->dev,
> > +				"THRES_CONV1_MSB write failed: %d\n", ret);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	ret =3D palmas_write(adc->palmas, PALMAS_GPADC_BASE,
> > +			PALMAS_GPADC_AUTO_SELECT, (ch1 << 4) | ch0);
> > +	if (ret < 0) {
> > +		dev_err(adc->dev, "AUTO_SELECT write failed: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret =3D palmas_update_bits(adc->palmas, PALMAS_GPADC_BASE,
> > +			PALMAS_GPADC_AUTO_CTRL,
> > +			PALMAS_GPADC_AUTO_CTRL_AUTO_CONV1_EN |
> > +			PALMAS_GPADC_AUTO_CTRL_AUTO_CONV0_EN, conv);
> > +	if (ret < 0)
> > +		dev_err(adc->dev, "AUTO_CTRL write failed: %d\n", ret);
> > +
> > +	return ret;
> > +}
> > +
> > +static int palmas_adc_wakeup_reset(struct palmas_gpadc *adc)
> > +{
> > +	int ret;
> > +
> > +	ret =3D palmas_write(adc->palmas, PALMAS_GPADC_BASE,
> > +			PALMAS_GPADC_AUTO_SELECT, 0);
> > +	if (ret < 0) {
> > +		dev_err(adc->dev, "AUTO_SELECT write failed: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret =3D palmas_disable_auto_conversion(adc);
> > +	if (ret < 0)
> > +		dev_err(adc->dev, "Disable auto conversion failed: %d\n", ret);
> > +
> > +	return ret;
> > +}
> > +
> > +static int palmas_gpadc_suspend(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > +	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
> > +	int wakeup =3D adc->wakeup1_enable || adc->wakeup2_enable;
> > +	int ret;
> > +
> > +	if (!device_may_wakeup(dev) || !wakeup)
> > +		return 0;
> > +
> > +	ret =3D palmas_adc_wakeup_configure(adc);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (adc->wakeup1_enable)
> > +		enable_irq_wake(adc->irq_auto_0);
> > +
> > +	if (adc->wakeup2_enable)
> > +		enable_irq_wake(adc->irq_auto_1);
> > +
> > +	return 0;
> > +}
> > +
> > +static int palmas_gpadc_resume(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > +	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
> > +	int wakeup =3D adc->wakeup1_enable || adc->wakeup2_enable;
> > +	int ret;
> > +
> > +	if (!device_may_wakeup(dev) || !wakeup)
> > +		return 0;
> > +
> > +	ret =3D palmas_adc_wakeup_reset(adc);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (adc->wakeup1_enable)
> > +		disable_irq_wake(adc->irq_auto_0);
> > +
> > +	if (adc->wakeup2_enable)
> > +		disable_irq_wake(adc->irq_auto_1);
> > +
> > +	return 0;
> > +};
> > +#endif
> > +
> > +static const struct dev_pm_ops palmas_pm_ops =3D {
> > +	SET_SYSTEM_SLEEP_PM_OPS(palmas_gpadc_suspend,
> > +				palmas_gpadc_resume)
> > +};
> > +
> > +static struct platform_driver palmas_gpadc_driver =3D {
> > +	.probe =3D palmas_gpadc_probe,
> > +	.remove =3D palmas_gpadc_remove,
> > +	.driver =3D {
> > +		.name =3D MOD_NAME,
> > +		.owner =3D THIS_MODULE,
> > +		.pm =3D &palmas_pm_ops,
> > +	},
> > +};
> > +
> > +static int __init palmas_gpadc_init(void)
> > +{
> > +	return platform_driver_register(&palmas_gpadc_driver);
> > +}
> > +module_init(palmas_gpadc_init);
> > +
> > +static void __exit palmas_gpadc_exit(void)
> > +{
> > +	platform_driver_unregister(&palmas_gpadc_driver);
> > +}
> > +module_exit(palmas_gpadc_exit);
> > +
> > +MODULE_DESCRIPTION("palmas GPADC driver");
> > +MODULE_AUTHOR("Pradeep Goudagunta<pgoudagunta-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>");
> > +MODULE_ALIAS("platform:palmas-gpadc");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.=
h
> > index bb270bd..2fcd70e 100644
> > --- a/include/linux/mfd/palmas.h
> > +++ b/include/linux/mfd/palmas.h
> > @@ -133,21 +133,32 @@ struct palmas_pmic_driver_data {
> >  			    struct regulator_config config);
> >  };
> > =20
> > +struct palmas_adc_wakeup_property {
> > +	int adc_channel_number;
> > +	int adc_high_threshold;
> > +	int adc_low_threshold;
> > +};
> > +
> >  struct palmas_gpadc_platform_data {
> >  	/* Channel 3 current source is only enabled during conversion */
> > -	int ch3_current;
> > +	int ch3_current;	/* 0: off; 1: 10uA; 2: 400uA; 3: 800 uA */
> > =20
> >  	/* Channel 0 current source can be used for battery detection.
> >  	 * If used for battery detection this will cause a permanent curr=
ent
> >  	 * consumption depending on current level set here.
> >  	 */
> > -	int ch0_current;
> > +	int ch0_current;	/* 0: off; 1: 5uA; 2: 15uA; 3: 20 uA */
> > +	bool extended_delay;	/* use extended delay for conversion */
> > =20
> >  	/* default BAT_REMOVAL_DAT setting on device probe */
> >  	int bat_removal;
> > =20
> >  	/* Sets the START_POLARITY bit in the RT_CTRL register */
> >  	int start_polarity;
> > +
> > +	int auto_conversion_period_ms;
> > +	struct palmas_adc_wakeup_property *adc_wakeup1_data;
> > +	struct palmas_adc_wakeup_property *adc_wakeup2_data;
> >  };
> > =20
> >  struct palmas_reg_init {
> > @@ -404,28 +415,7 @@ struct palmas_gpadc_calibration {
> >  	s32 offset_error;
> >  };
> > =20
> > -struct palmas_gpadc {
> > -	struct device *dev;
> > -	struct palmas *palmas;
> > -
> > -	int ch3_current;
> > -	int ch0_current;
> > -
> > -	int gpadc_force;
> > -
> > -	int bat_removal;
> > -
> > -	struct mutex reading_lock;
> > -	struct completion irq_complete;
> > -
> > -	int eoc_sw_irq;
> > -
> > -	struct palmas_gpadc_calibration *palmas_cal_tbl;
> > -
> > -	int conv0_channel;
> > -	int conv1_channel;
> > -	int rt_channel;
> > -};
> > +#define PALMAS_DATASHEET_NAME(_name)	"palmas-gpadc-chan-"#_name
> > =20
> >  struct palmas_gpadc_result {
> >  	s32 raw_code;
> > @@ -519,6 +509,43 @@ enum palmas_irqs {
> >  	PALMAS_NUM_IRQ,
> >  };
> > =20
> > +/* Palmas GPADC Channels */
> > +enum {
> > +	PALMAS_ADC_CH_IN0,
> > +	PALMAS_ADC_CH_IN1,
> > +	PALMAS_ADC_CH_IN2,
> > +	PALMAS_ADC_CH_IN3,
> > +	PALMAS_ADC_CH_IN4,
> > +	PALMAS_ADC_CH_IN5,
> > +	PALMAS_ADC_CH_IN6,
> > +	PALMAS_ADC_CH_IN7,
> > +	PALMAS_ADC_CH_IN8,
> > +	PALMAS_ADC_CH_IN9,
> > +	PALMAS_ADC_CH_IN10,
> > +	PALMAS_ADC_CH_IN11,
> > +	PALMAS_ADC_CH_IN12,
> > +	PALMAS_ADC_CH_IN13,
> > +	PALMAS_ADC_CH_IN14,
> > +	PALMAS_ADC_CH_IN15,
> > +	PALMAS_ADC_CH_MAX,
> > +};
> > +
> > +/* Palmas GPADC Channel0 Current Source */
> > +enum {
> > +	PALMAS_ADC_CH0_CURRENT_SRC_0,
> > +	PALMAS_ADC_CH0_CURRENT_SRC_5,
> > +	PALMAS_ADC_CH0_CURRENT_SRC_15,
> > +	PALMAS_ADC_CH0_CURRENT_SRC_20,
> > +};
> > +
> > +/* Palmas GPADC Channel3 Current Source */
> > +enum {
> > +	PALMAS_ADC_CH3_CURRENT_SRC_0,
> > +	PALMAS_ADC_CH3_CURRENT_SRC_10,
> > +	PALMAS_ADC_CH3_CURRENT_SRC_400,
> > +	PALMAS_ADC_CH3_CURRENT_SRC_800,
> > +};
> > +
> >  struct palmas_pmic {
> >  	struct palmas *palmas;
> >  	struct device *dev;
> >=20
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
