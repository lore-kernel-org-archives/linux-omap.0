From: Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH] iio: adc: cpcap: Add minimal support for CPCAP PMIC
 ADC
Date: Fri, 17 Mar 2017 07:42:06 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1703170721350.2053@vps.pmeerw.net>
References: <20170317014344.27201-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170317014344.27201-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


> On Motorola phones like droid 4 there is a custom CPCAP PMIC. This PMIC
> has ADCs that are used for battery charging and USB PHY VBUS and ID pin
> detection.
> 
> Unfortunately the only documentation for this ADC seems to be the
> Motorola mapphone Linux kernel tree. I have tested that reading raw and
> scaled values works, but I have not used the timed sampling that the ADC
> seems to support.

comments below
 
> Let's add a minimal support for it so we can eventually provide IIO
> channels for the related battery charging and USB PHY drivers.
> 
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
> Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Tony Lindgrne <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Lindgren

> ---
>  .../devicetree/bindings/iio/adc/cpcap-adc.txt      |  16 +
>  drivers/iio/adc/Kconfig                            |  11 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/cpcap-adc.c                        | 997 +++++++++++++++++++++
>  4 files changed, 1025 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/cpcap-adc.txt
>  create mode 100644 drivers/iio/adc/cpcap-adc.c
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/cpcap-adc.txt b/Documentation/devicetree/bindings/iio/adc/cpcap-adc.txt
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/cpcap-adc.txt
> @@ -0,0 +1,16 @@
> +Motorola CPCAP PMIC ADC binding
> +
> +Required properties:
> +- compatible: Should be "motorola,cpcap-adc" or "motorola,mapphone-cpcap-adc"
> +- interrupts: The interrupt number for the ADC device
> +- interrupt-names: Should be "adcdone"
> +- #io-channel-cells: Number of cells in an IIO specifier
> +
> +Example:
> +
> +cpcap_adc: adc {
> +	compatible = "motorola,mapphone-cpcap-adc";
> +	interrupts-extended = <&cpcap 8 0>;

interrupts?

> +	interrupt-names = "adcdone";
> +	#io-channel-cells = <1>;
> +};
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -195,6 +195,17 @@ config CC10001_ADC
>  	  This driver can also be built as a module. If so, the module will be
>  	  called cc10001_adc.
>  
> +config CPCAP_ADC
> +	tristate "Motorola CPCAP PMIC ADC driver"
> +	depends on MFD_CPCAP
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say yes here to build support for Motorola CPCAP PMIC ADC.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called cpcap-adc.
> +
>  config DA9150_GPADC
>  	tristate "Dialog DA9150 GPADC driver support"
>  	depends on MFD_DA9150
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_AXP288_ADC) += axp288_adc.o
>  obj-$(CONFIG_BCM_IPROC_ADC) += bcm_iproc_adc.o
>  obj-$(CONFIG_BERLIN2_ADC) += berlin2-adc.o
>  obj-$(CONFIG_CC10001_ADC) += cc10001_adc.o
> +obj-$(CONFIG_CPCAP_ADC) += cpcap-adc.o
>  obj-$(CONFIG_DA9150_GPADC) += da9150-gpadc.o
>  obj-$(CONFIG_ENVELOPE_DETECTOR) += envelope-detector.o
>  obj-$(CONFIG_EXYNOS_ADC) += exynos_adc.o
> diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/iio/adc/cpcap-adc.c
> @@ -0,0 +1,997 @@
> +/*
> + * Copyright (C) 2017 Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> + *
> + * Rewritten for Linux IIO framework with register managing functions
> + * based on earlier driver found in the Motorola Linux kernel:
> + *
> + * Copyright (C) 2009-2010 Motorola, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/driver.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/mfd/motorola-cpcap.h>
> +
> +/* Register CPCAP_REG_ADCC1 bits */
> +#define CPCAP_BIT_ADEN_AUTO_CLR		BIT(15)	/* Currently unused */
> +#define CPCAP_BIT_CAL_MODE		BIT(14) /* Set with BIT_RAND0 */
> +#define CPCAP_BIT_ADC_CLK_SEL1		BIT(13)	/* Currently unused */
> +#define CPCAP_BIT_ADC_CLK_SEL0		BIT(12)	/* Currently unused */
> +#define CPCAP_BIT_ATOX			BIT(11)	/* in/out ps factor */

wondering what a 'ps' factor is...

> +#define CPCAP_BIT_ATO3			BIT(10)
> +#define CPCAP_BIT_ATO2			BIT(9)
> +#define CPCAP_BIT_ATO1			BIT(8)
> +#define CPCAP_BIT_ATO0			BIT(7)
> +#define CPCAP_BIT_ADA2			BIT(6)
> +#define CPCAP_BIT_ADA1			BIT(5)
> +#define CPCAP_BIT_ADA0			BIT(4)
> +#define CPCAP_BIT_AD_SEL1		BIT(3)	/* Set for ADC_TYPE_BANK_1 */
> +#define CPCAP_BIT_RAND1			BIT(2)	/* Set for ADC_TYPE_BATT_PI */
> +#define CPCAP_BIT_RAND0			BIT(1)	/* Set with CAL_MODE */
> +#define CPCAP_BIT_ADEN			BIT(0)	/* Currently unused */
> +
> +/* Register CPCAP_REG_ADCC2 bits */
> +#define CPCAP_BIT_CAL_FACTOR_ENABLE	BIT(15)	/* Currently unused */
> +#define CPCAP_BIT_BATDETB_EN		BIT(14)	/* Currently unused */
> +#define CPCAP_BIT_ADTRIG_ONESHOT	BIT(13)	/* Set for !TIMING_IMM */
> +#define CPCAP_BIT_ASC			BIT(12)	/* Set for TIMING_IMM */
> +#define CPCAP_BIT_ATOX_PS_FACTOR	BIT(11)	/* in/out ps factor */
> +#define CPCAP_BIT_ADC_PS_FACTOR1	BIT(10)	/* in/out ps factor */
> +#define CPCAP_BIT_ADC_PS_FACTOR0	BIT(9)	/* in/out ps factor */
> +#define CPCAP_BIT_AD4_SELECT		BIT(8)	/* Currently unused */
> +#define CPCAP_BIT_ADC_BUSY		BIT(7)	/* Currently unused */
> +#define CPCAP_BIT_THERMBIAS_EN		BIT(6)	/* Currently unused */
> +#define CPCAP_BIT_ADTRIG_DIS		BIT(5)	/* Disable interrupt */
> +#define CPCAP_BIT_LIADC			BIT(4)	/* Currently unused */
> +#define CPCAP_BIT_TS_REFEN		BIT(3)	/* Currently unused */
> +#define CPCAP_BIT_TS_M2			BIT(2)	/* Currently unused */
> +#define CPCAP_BIT_TS_M1			BIT(1)	/* Currently unused */
> +#define CPCAP_BIT_TS_M0			BIT(0)	/* Currently unused */
> +
> +#define MAX_TEMP_LVL			27

generally, we want the CPAP_ prefix

> +#define FOUR_POINT_TWO_ADC		801
> +#define ST_ADC_CAL_CHRGI_UPPER_THRESHOLD 530
> +#define ST_ADC_CAL_CHRGI_LOWER_THRESHOLD 494
> +#define ST_ADC_CAL_BATTI_UPPER_THRESHOLD 530
> +#define ST_ADC_CAL_BATTI_LOWER_THRESHOLD 494
> +#define ST_ADC_CALIBRATE_DIFF_THRESHOLD	3
> +
> +/**
> + * struct cpcap_adc_ato - timing settings for cpcap adc
> + *
> + * Unfortunately no cpcap documentation available, please document when
> + * using these.
> + */
> +struct cpcap_adc_ato {
> +	unsigned short ato_in;
> +	unsigned short atox_in;
> +	unsigned short adc_ps_factor_in;
> +	unsigned short atox_ps_factor_in;
> +	unsigned short ato_out;
> +	unsigned short atox_out;
> +	unsigned short adc_ps_factor_out;
> +	unsigned short atox_ps_factor_out;
> +};
> +
> +/**
> + * struct cpcap-adc - cpcap adc device driver data
> + * @reg: cpcap regmap
> + * @dev: struct device
> + * @vendor: cpcap vendor
> + * @irq: interrupt
> + * @lock: mutex
> + * @ato: request timings
> + * @wq_data_avail: work queue
> + * @done: work done
> + */
> +struct cpcap_adc {
> +	struct regmap *reg;
> +	struct device *dev;
> +	u16 vendor;
> +	int irq;
> +	struct mutex lock;	/* ADC register access lock */
> +	const struct cpcap_adc_ato *ato;
> +	wait_queue_head_t wq_data_avail;
> +	bool done;
> +};
> +
> +/**
> + * enum cpcap_adc_bank0 - cpcap adc bank0 channels
> + */
> +enum cpcap_adc_bank0 {
> +	CPCAP_ADC_AD0_BATTDETB,
> +	CPCAP_ADC_BATTP,
> +	CPCAP_ADC_VBUS,
> +	CPCAP_ADC_AD3,
> +	CPCAP_ADC_BPLUS_AD4,
> +	CPCAP_ADC_CHG_ISENSE,
> +	CPCAP_ADC_BATTI_ADC,
> +	CPCAP_ADC_USB_ID,
> +	CPCAP_ADC_BANK0_NUM,
> +};
> +
> +/**
> + * enum cpcap_adc_bank1 - cpcap adc bank1 channels
> + */
> +enum cpcap_adc_bank1 {
> +	CPCAP_ADC_AD8,
> +	CPCAP_ADC_AD9,
> +	CPCAP_ADC_LICELL,
> +	CPCAP_ADC_HV_BATTP,
> +	CPCAP_ADC_TSX1_AD12,
> +	CPCAP_ADC_TSX2_AD13,
> +	CPCAP_ADC_TSY1_AD14,
> +	CPCAP_ADC_TSY2_AD15,
> +	CPCAP_ADC_BANK1_NUM,
> +};
> +
> +/**
> + * enum cpcap_adc_timing - cpcap adc timing options
> + *
> + * CPCAP_ADC_TIMING_IMM seems to be immediate with no timings.
> + * Please document when using.
> + */
> +enum cpcap_adc_timing {
> +	CPCAP_ADC_TIMING_IMM,
> +	CPCAP_ADC_TIMING_IN,
> +	CPCAP_ADC_TIMING_OUT,
> +};
> +
> +/**
> + * enum cpcap_adc_type - cpcap adc types
> + *
> + * Two banks of channels with eight channels in each. The first two channels
> + * in bank0 can be muxed for other functionality with CPCAP_ADC_TYPE_BATT_PI.
> + */
> +enum cpcap_adc_type {
> +	CPCAP_ADC_TYPE_BANK_0,
> +	CPCAP_ADC_TYPE_BANK_1,
> +	CPCAP_ADC_TYPE_BATT_PI,
> +};
> +
> +/**
> + * struct cpcap_adc_request - cpcap adc request
> + * @timing: timing settings
> + * @type: bank type, bank0, 1 or remuxed bank0
> + * @result: result array
> + */
> +struct cpcap_adc_request {
> +	enum cpcap_adc_timing timing;
> +	enum cpcap_adc_type type;
> +	int result[CPCAP_ADC_BANK0_NUM];
> +};
> +
> +/**
> + * struct cpcap_adc_phasing_tbl - cpcap phasing table
> + * @offset: offset in the phasing table
> + * @multiplier: multiplier in the phasing table
> + * @divider: divider in the phasing table
> + * @min: minimum value
> + * @max: maximum value
> + */
> +struct cpcap_adc_phasing_tbl {
> +	short offset;
> +	unsigned short multiplier;
> +	unsigned short divider;
> +	short min;
> +	short max;
> +};
> +
> +/**
> + * enum cpcap_adc_conv_type - cpcap conversion types
> + */
> +enum cpcap_adc_conv_type {
> +	CONV_TYPE_NONE,
> +	CONV_TYPE_DIRECT,
> +	CONV_TYPE_MAPPING,
> +};
> +
> +/**
> + * struct cpcap_adc_conversion_tbl - cpcap conversion table
> + * @conv_type: conversion type
> + * @align_offset: align offset
> + * @conv_offset: conversion offset
> + * @cal_offset: calibration offset
> + * @multiplier: conversion multiplier
> + * @divider: conversion divider
> + */
> +struct cpcap_adc_conversion_tbl {
> +	enum cpcap_adc_conv_type conv_type;
> +	int align_offset;
> +	int conv_offset;
> +	int cal_offset;
> +	int multiplier;
> +	int divider;
> +};
> +
> +/* Phasing table for bank0 */
> +static struct cpcap_adc_phasing_tbl bank0_phasing[CPCAP_ADC_BANK0_NUM] = {

const

> +	[CPCAP_ADC_AD0_BATTDETB] = {0, 0x80, 0x80,    0, 1023},
> +	[CPCAP_ADC_BATTP] =        {0, 0x80, 0x80,    0, 1023},
> +	[CPCAP_ADC_VBUS] =         {0, 0x80, 0x80,    0, 1023},
> +	[CPCAP_ADC_AD3] =          {0, 0x80, 0x80,    0, 1023},
> +	[CPCAP_ADC_BPLUS_AD4] =    {0, 0x80, 0x80,    0, 1023},
> +	[CPCAP_ADC_CHG_ISENSE] =   {0, 0x80, 0x80, -512,  511},
> +	[CPCAP_ADC_BATTI_ADC] =    {0, 0x80, 0x80, -512,  511},
> +	[CPCAP_ADC_USB_ID] =       {0, 0x80, 0x80,    0, 1023},
> +};
> +
> +/* Phasing table for bank1 */
> +static struct cpcap_adc_phasing_tbl bank1_phasing[CPCAP_ADC_BANK1_NUM] = {

const

> +	[CPCAP_ADC_AD8] =          {0, 0x80, 0x80,    0, 1023},
> +	[CPCAP_ADC_AD9] =          {0, 0x80, 0x80,    0, 1023},
> +	[CPCAP_ADC_LICELL] =       {0, 0x80, 0x80,    0, 1023},
> +	[CPCAP_ADC_HV_BATTP] =     {0, 0x80, 0x80,    0, 1023},
> +	[CPCAP_ADC_TSX1_AD12] =    {0, 0x80, 0x80,    0, 1023},
> +	[CPCAP_ADC_TSX2_AD13] =    {0, 0x80, 0x80,    0, 1023},
> +	[CPCAP_ADC_TSY1_AD14] =    {0, 0x80, 0x80,    0, 1023},
> +	[CPCAP_ADC_TSY2_AD15] =    {0, 0x80, 0x80,    0, 1023},
> +};
> +
> +/* Conversion table for bank0 */
> +static struct cpcap_adc_conversion_tbl bank0_conversion[CPCAP_ADC_BANK0_NUM] = {

const

> +	[CPCAP_ADC_AD0_BATTDETB] = {
> +		CONV_TYPE_MAPPING,   0,    0, 0,     1,    1,
> +	},
> +	[CPCAP_ADC_BATTP] = {
> +		CONV_TYPE_DIRECT,    0, 2400, 0,  2300, 1023,
> +	},
> +	[CPCAP_ADC_VBUS] = {
> +		CONV_TYPE_DIRECT,    0,    0, 0, 10000, 1023,
> +	},
> +	[CPCAP_ADC_AD3] = {
> +		CONV_TYPE_MAPPING,   0,    0, 0,     1,    1,
> +		},
> +	[CPCAP_ADC_BPLUS_AD4] = {
> +		CONV_TYPE_DIRECT,    0, 2400, 0,  2300, 1023,
> +	},
> +	[CPCAP_ADC_CHG_ISENSE] = {
> +		CONV_TYPE_DIRECT, -512,    2, 0,  5000, 1023,
> +	},
> +	[CPCAP_ADC_BATTI_ADC] = {
> +		CONV_TYPE_DIRECT, -512,    2, 0,  5000, 1023,
> +	},
> +	[CPCAP_ADC_USB_ID] = {
> +		CONV_TYPE_NONE,      0,    0, 0,     1,    1,
> +	},
> +};
> +
> +/* Conversion table for bank1 */
> +static struct cpcap_adc_conversion_tbl bank1_conversion[CPCAP_ADC_BANK1_NUM] = {

const

> +	[CPCAP_ADC_AD8] =          {CONV_TYPE_NONE,   0,  0,  0,    1,    1},
> +	[CPCAP_ADC_AD9] =          {CONV_TYPE_NONE,   0,  0,  0,    1,    1},
> +	[CPCAP_ADC_LICELL] =       {CONV_TYPE_DIRECT, 0,  0,  0, 3400, 1023},
> +	[CPCAP_ADC_HV_BATTP] =     {CONV_TYPE_NONE,   0,  0,  0,    1,    1},
> +	[CPCAP_ADC_TSX1_AD12] =    {CONV_TYPE_NONE,   0,  0,  0,    1,    1},
> +	[CPCAP_ADC_TSX2_AD13] =    {CONV_TYPE_NONE,   0,  0,  0,    1,    1},
> +	[CPCAP_ADC_TSY1_AD14] =    {CONV_TYPE_NONE,   0,  0,  0,    1,    1},
> +	[CPCAP_ADC_TSY2_AD15] =    {CONV_TYPE_NONE,   0,  0,  0,    1,    1},
> +};
> +
> +/*
> + * Temperature lookup table of register values to milliCelcius.
> + * REVISIT: Check the duplicate 0x3ff entry in a freezer
> + */
> +static const int temp_map[MAX_TEMP_LVL][2] = {
> +	{ 0x03ff, -40000 },
> +	{ 0x03ff, -35000 },
> +	{ 0x03ef, -30000 },
> +	{ 0x03b2, -25000 },
> +	{ 0x036c, -20000 },
> +	{ 0x0320, -15000 },
> +	{ 0x02d0, -10000 },
> +	{ 0x027f, -5000 },
> +	{ 0x022f, 0 },
> +	{ 0x01e4, 5000 },
> +	{ 0x019f, 10000 },
> +	{ 0x0161, 15000 },
> +	{ 0x012b, 20000 },
> +	{ 0x00fc, 25000 },
> +	{ 0x00d4, 30000 },
> +	{ 0x00b2, 35000 },
> +	{ 0x0095, 40000 },
> +	{ 0x007d, 45000 },
> +	{ 0x0069, 50000 },
> +	{ 0x0059, 55000 },
> +	{ 0x004b, 60000 },
> +	{ 0x003f, 65000 },
> +	{ 0x0036, 70000 },
> +	{ 0x002e, 75000 },
> +	{ 0x0027, 80000 },
> +	{ 0x0022, 85000 },
> +	{ 0x001d, 90000 },
> +};
> +
> +static irqreturn_t cpcap_adc_irq_thread(int irq, void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +	struct cpcap_adc *ddata = iio_priv(indio_dev);
> +	int error;
> +
> +	error = regmap_update_bits(ddata->reg, CPCAP_REG_ADCC2,
> +				   CPCAP_BIT_ADTRIG_DIS,
> +				   CPCAP_BIT_ADTRIG_DIS);
> +	if (error)
> +		return IRQ_NONE;
> +
> +	ddata->done = true;
> +	wake_up_interruptible(&ddata->wq_data_avail);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +#define CPCAP_CHAN(_type, _index, _address, _datasheet_name) {	\
> +	.type = (_type), \
> +	.address = (_address), \
> +	.indexed = 1, \
> +	.channel = (_index), \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> +			      BIT(IIO_CHAN_INFO_SCALE), \
> +	.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
> +				   BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \

I don't see SAMP_FREQ and _OVERSAMPLING handled?

> +	.scan_index = (_index), \
> +	.scan_type = { \
> +		.sign = 'u', \
> +		.realbits = 10, \
> +		.storagebits = 16, \
> +		.endianness = IIO_CPU, \
> +	}, \
> +	.datasheet_name = (_datasheet_name), \
> +}
> +
> +/*
> + * The datasheet names are from Motorola mapphone Linux kernel except
> + * for the last two which might be uncalibrated charge voltage and
> + * current.
> + */
> +static const struct iio_chan_spec cpcap_adc_channels[] = {
> +	CPCAP_CHAN(IIO_TEMP, 0, CPCAP_REG_ADCD0, "battdetb"),
> +	CPCAP_CHAN(IIO_VOLTAGE, 1, CPCAP_REG_ADCD1, "battp"),
> +	CPCAP_CHAN(IIO_VOLTAGE, 2, CPCAP_REG_ADCD2, "vbus"),
> +	CPCAP_CHAN(IIO_TEMP, 3, CPCAP_REG_ADCD3, "ad3"),
> +	CPCAP_CHAN(IIO_VOLTAGE, 4, CPCAP_REG_ADCD4, "ad4"),
> +	CPCAP_CHAN(IIO_CURRENT, 5, CPCAP_REG_ADCD5, "chg_isense"),
> +	CPCAP_CHAN(IIO_CURRENT, 6, CPCAP_REG_ADCD6, "batti"),
> +	CPCAP_CHAN(IIO_VOLTAGE, 7, CPCAP_REG_ADCD7, "usb_id"),
> +
> +	CPCAP_CHAN(IIO_CURRENT, 8, CPCAP_REG_ADCD0, "ad8"),
> +	CPCAP_CHAN(IIO_VOLTAGE, 9, CPCAP_REG_ADCD1, "ad9"),
> +	CPCAP_CHAN(IIO_VOLTAGE, 10, CPCAP_REG_ADCD2, "licell"),
> +	CPCAP_CHAN(IIO_VOLTAGE, 11, CPCAP_REG_ADCD3, "hv_battp"),
> +	CPCAP_CHAN(IIO_VOLTAGE, 12, CPCAP_REG_ADCD4, "tsx1_ad12"),
> +	CPCAP_CHAN(IIO_VOLTAGE, 13, CPCAP_REG_ADCD5, "tsx2_ad13"),
> +	CPCAP_CHAN(IIO_VOLTAGE, 14, CPCAP_REG_ADCD6, "tsy1_ad14"),
> +	CPCAP_CHAN(IIO_VOLTAGE, 15, CPCAP_REG_ADCD7, "tsy2_ad15"),
> +
> +	/* There are two registers with multiplexed functionality */
> +	CPCAP_CHAN(IIO_VOLTAGE, 16, CPCAP_REG_ADCD0, "chg_vsense"),
> +	CPCAP_CHAN(IIO_CURRENT, 17, CPCAP_REG_ADCD1, "batti2"),
> +};
> +
> +/* ADC calibration functions */
> +

drop newline

> +static void cpcap_adc_setup_calibrate(struct cpcap_adc *ddata,
> +				      enum cpcap_adc_bank0 chan)
> +{
> +	unsigned int value = 0;
> +	unsigned long timeout = jiffies + msecs_to_jiffies(3000);
> +	int error;
> +
> +	if ((chan != CPCAP_ADC_CHG_ISENSE) &&
> +	    (chan != CPCAP_ADC_BATTI_ADC))
> +		return;
> +
> +	value |= CPCAP_BIT_CAL_MODE | CPCAP_BIT_RAND0;
> +	value |= ((chan << 4) &
> +		  (CPCAP_BIT_ADA2 | CPCAP_BIT_ADA1 | CPCAP_BIT_ADA0));
> +
> +	error = regmap_update_bits(ddata->reg, CPCAP_REG_ADCC1,
> +				   CPCAP_BIT_CAL_MODE | CPCAP_BIT_ATOX |
> +				   CPCAP_BIT_ATO3 | CPCAP_BIT_ATO2 |
> +				   CPCAP_BIT_ATO1 | CPCAP_BIT_ATO0 |
> +				   CPCAP_BIT_ADA2 | CPCAP_BIT_ADA1 |
> +				   CPCAP_BIT_ADA0 | CPCAP_BIT_AD_SEL1 |
> +				   CPCAP_BIT_RAND1 | CPCAP_BIT_RAND0,
> +				   value);
> +	if (error)
> +		return;
> +
> +	error = regmap_update_bits(ddata->reg, CPCAP_REG_ADCC2,
> +				   CPCAP_BIT_ATOX_PS_FACTOR |
> +				   CPCAP_BIT_ADC_PS_FACTOR1 |
> +				   CPCAP_BIT_ADC_PS_FACTOR0,
> +				   0);
> +	if (error)
> +		return;
> +
> +	error = regmap_update_bits(ddata->reg, CPCAP_REG_ADCC2,
> +				   CPCAP_BIT_ADTRIG_DIS,
> +				   CPCAP_BIT_ADTRIG_DIS);
> +	if (error)
> +		return;
> +
> +	error = regmap_update_bits(ddata->reg, CPCAP_REG_ADCC2,
> +				   CPCAP_BIT_ASC,
> +				   CPCAP_BIT_ASC);
> +	if (error)
> +		return;
> +
> +	do {
> +		schedule_timeout_uninterruptible(1);
> +		error = regmap_read(ddata->reg, CPCAP_REG_ADCC2, &value);
> +		if (error)
> +			return;
> +	} while ((value & CPCAP_BIT_ASC) && time_before(jiffies, timeout));
> +
> +	if (value & CPCAP_BIT_ASC)
> +		dev_err(ddata->dev,
> +			"Timeout waiting for calibration to complete\n");
> +
> +	error = regmap_update_bits(ddata->reg, CPCAP_REG_ADCC1,
> +				   CPCAP_BIT_CAL_MODE, 0);
> +	if (error)
> +		return;
> +}
> +
> +static int cpcap_adc_calibrate(struct cpcap_adc *ddata)
> +{
> +	unsigned int cal_data[2];
> +	unsigned short cal_data_diff;
> +	int i, error;
> +
> +	i = 0;
> +	do {
> +		cal_data[0]  = 0;
> +		cal_data[1]  = 0;
> +		cal_data_diff = 0;
> +		cpcap_adc_setup_calibrate(ddata, CPCAP_ADC_CHG_ISENSE);
> +		error = regmap_read(ddata->reg, CPCAP_REG_ADCAL1, &cal_data[0]);
> +		if (error)
> +			return error;
> +		cpcap_adc_setup_calibrate(ddata, CPCAP_ADC_CHG_ISENSE);
> +		error = regmap_read(ddata->reg, CPCAP_REG_ADCAL1, &cal_data[1]);
> +		if (error)
> +			return error;
> +
> +		if (cal_data[0] > cal_data[1])
> +			cal_data_diff = cal_data[0] - cal_data[1];
> +		else
> +			cal_data_diff = cal_data[1] - cal_data[0];
> +
> +		if (((cal_data[1] >= ST_ADC_CAL_CHRGI_LOWER_THRESHOLD) &&
> +		     (cal_data[1] <= ST_ADC_CAL_CHRGI_UPPER_THRESHOLD) &&
> +		     (cal_data_diff <= ST_ADC_CALIBRATE_DIFF_THRESHOLD)) ||
> +		    (ddata->vendor == CPCAP_VENDOR_TI)) {
> +			bank0_conversion[CPCAP_ADC_CHG_ISENSE].cal_offset =
> +				((short)cal_data[1] * -1) + 512;
> +			dev_info(ddata->dev,
> +				 "cpcap_adc_probe: CHRGI Cal complete!\n");

maybe calibration instead of Cal

> +			break;
> +		}
> +
> +		msleep(5);

I guess this will trigger a checkpatch warning

> +		i++;
> +	} while (i > 5);

should be < 5????
why not just use a for look?

> +
> +	i = 0;
> +	do {

can't this code duplication be avoided?

> +		cal_data[0]  = 0;
> +		cal_data[1]  = 0;
> +		cal_data_diff = 0;
> +		cpcap_adc_setup_calibrate(ddata, CPCAP_ADC_BATTI_ADC);
> +		error = regmap_read(ddata->reg, CPCAP_REG_ADCAL2, &cal_data[0]);
> +		if (error)
> +			return error;
> +		cpcap_adc_setup_calibrate(ddata, CPCAP_ADC_BATTI_ADC);
> +		error = regmap_read(ddata->reg, CPCAP_REG_ADCAL2, &cal_data[1]);
> +		if (error)
> +			return error;
> +
> +		if (cal_data[0] > cal_data[1])
> +			cal_data_diff = cal_data[0] - cal_data[1];
> +		else
> +			cal_data_diff = cal_data[1] - cal_data[0];
> +
> +		if (((cal_data[1] >= ST_ADC_CAL_BATTI_LOWER_THRESHOLD) &&
> +		     (cal_data[1] <= ST_ADC_CAL_BATTI_UPPER_THRESHOLD) &&
> +		     (cal_data_diff <= ST_ADC_CALIBRATE_DIFF_THRESHOLD)) ||
> +		    (ddata->vendor == CPCAP_VENDOR_TI)) {
> +			bank0_conversion[CPCAP_ADC_BATTI_ADC].cal_offset =
> +				((short)cal_data[1] * -1) + 512;
> +			dev_info(ddata->dev,
> +				 "cpcap_adc_probe: BATTI Cal complete!\n");
> +			break;
> +		}
> +
> +		msleep(5);

I guess this will trigger a checkpatch warning

> +		i++;
> +	} while (i > 5);

should be < 5????

> +
> +	return 0;
> +}
> +
> +/* ADC setup, read and scale functions */


drop newline

> +
> +static void cpcap_adc_setup_bank(struct cpcap_adc *ddata,
> +				 enum cpcap_adc_type type,
> +				 enum cpcap_adc_timing timing)
> +{
> +	const struct cpcap_adc_ato *ato = ddata->ato;
> +	unsigned short value1 = 0;
> +	unsigned short value2 = 0;
> +	int error;
> +
> +	if (!ato)
> +		return;
> +
> +	if (type == CPCAP_ADC_TYPE_BANK_1)
> +		value1 |= CPCAP_BIT_AD_SEL1;
> +	else if (type == CPCAP_ADC_TYPE_BATT_PI)
> +		value1 |= CPCAP_BIT_RAND1;
> +
> +	switch (timing) {
> +	case CPCAP_ADC_TIMING_IN:
> +		value1 |= ato->ato_in;
> +		value1 |= ato->atox_in;
> +		value2 |= ato->adc_ps_factor_in;
> +		value2 |= ato->atox_ps_factor_in;
> +		break;
> +
> +	case CPCAP_ADC_TIMING_OUT:
> +		value1 |= ato->ato_out;
> +		value1 |= ato->atox_out;
> +		value2 |= ato->adc_ps_factor_out;
> +		value2 |= ato->atox_ps_factor_out;
> +		break;
> +
> +	case CPCAP_ADC_TIMING_IMM:
> +	default:
> +		break;
> +	}
> +
> +	error = regmap_update_bits(ddata->reg, CPCAP_REG_ADCC1,
> +				   CPCAP_BIT_CAL_MODE | CPCAP_BIT_ATOX |
> +				   CPCAP_BIT_ATO3 | CPCAP_BIT_ATO2 |
> +				   CPCAP_BIT_ATO1 | CPCAP_BIT_ATO0 |
> +				   CPCAP_BIT_ADA2 | CPCAP_BIT_ADA1 |
> +				   CPCAP_BIT_ADA0 | CPCAP_BIT_AD_SEL1 |
> +				   CPCAP_BIT_RAND1 | CPCAP_BIT_RAND0,
> +				   value1);
> +	if (error)
> +		return;
> +
> +	error = regmap_update_bits(ddata->reg, CPCAP_REG_ADCC2,
> +				   CPCAP_BIT_ATOX_PS_FACTOR |
> +				   CPCAP_BIT_ADC_PS_FACTOR1 |
> +				   CPCAP_BIT_ADC_PS_FACTOR0,
> +				   value2);
> +	if (error)
> +		return;
> +
> +	if (timing == CPCAP_ADC_TIMING_IMM) {
> +		error = regmap_update_bits(ddata->reg, CPCAP_REG_ADCC2,
> +					   CPCAP_BIT_ADTRIG_DIS,
> +					   CPCAP_BIT_ADTRIG_DIS);
> +		if (error)
> +			return;
> +
> +		error = regmap_update_bits(ddata->reg, CPCAP_REG_ADCC2,
> +					   CPCAP_BIT_ASC,
> +					   CPCAP_BIT_ASC);
> +		if (error)
> +			return;
> +	} else {
> +		error = regmap_update_bits(ddata->reg, CPCAP_REG_ADCC2,
> +					   CPCAP_BIT_ADTRIG_ONESHOT,
> +					   CPCAP_BIT_ADTRIG_ONESHOT);
> +		if (error)
> +			return;
> +
> +		error = regmap_update_bits(ddata->reg, CPCAP_REG_ADCC2,
> +					   CPCAP_BIT_ADTRIG_DIS, 0);
> +		if (error)
> +			return;
> +	}
> +}
> +
> +/*
> + * Occasionally the ADC does not seem to start and there will be no
> + * interrupt. Let's re-init interrupt to prevent the ADC from hanging
> + * for the next request. It is unclear why this happens, but the next
> + * request will usually work after doing this.
> + */
> +static void cpcap_adc_quirk_reset_lost_irq(struct cpcap_adc *ddata)
> +{
> +	int error;
> +
> +	dev_info(ddata->dev, "lost ADC irq, attempting to reinit\n");
> +	disable_irq(ddata->irq);
> +	error = regmap_update_bits(ddata->reg, CPCAP_REG_ADCC2,
> +				   CPCAP_BIT_ADTRIG_DIS,
> +				   CPCAP_BIT_ADTRIG_DIS);
> +	if (error)
> +		dev_warn(ddata->dev, "%s reset failed: %i\n",
> +			 __func__, error);
> +	enable_irq(ddata->irq);
> +}
> +
> +static int cpcap_adc_start_bank(struct cpcap_adc *ddata,
> +				struct cpcap_adc_request *req)
> +{
> +	int i, error;
> +
> +	req->timing = CPCAP_ADC_TIMING_IMM;
> +	ddata->done = false;
> +
> +	for (i = 0; i < 5; i++) {
> +		cpcap_adc_setup_bank(ddata, req->type, req->timing);
> +		error = wait_event_interruptible_timeout(ddata->wq_data_avail,
> +							 ddata->done,
> +							 msecs_to_jiffies(50));
> +		if (error >= 0)
> +			return 0;
> +
> +		if (error == 0) {

error has been checked >= 0 above already?!

> +			cpcap_adc_quirk_reset_lost_irq(ddata);
> +			error = -ETIMEDOUT;
> +			continue;
> +		}
> +
> +		if (error < 0)
> +			return error;
> +	}
> +
> +	return error;
> +}
> +
> +static void cpcap_adc_phase(struct cpcap_adc_request *req, int index)
> +{
> +	struct cpcap_adc_conversion_tbl *conv_tbl = bank0_conversion;
> +	struct cpcap_adc_phasing_tbl *phase_tbl = bank0_phasing;
> +	int tbl_index = index;
> +
> +	if (req->type == CPCAP_ADC_TYPE_BANK_1) {
> +		conv_tbl = bank1_conversion;
> +		phase_tbl = bank1_phasing;
> +	}
> +
> +	if (req->type == CPCAP_ADC_TYPE_BATT_PI)
> +		tbl_index = (tbl_index % 2) ? CPCAP_ADC_BATTI_ADC :
> +			CPCAP_ADC_BATTP;
> +
> +	if (((req->type == CPCAP_ADC_TYPE_BANK_0) ||
> +	     (req->type == CPCAP_ADC_TYPE_BATT_PI)) &&
> +	    (tbl_index == CPCAP_ADC_BATTP)) {
> +		req->result[index] -= phase_tbl[tbl_index].offset;
> +		req->result[index] -= FOUR_POINT_TWO_ADC;
> +		req->result[index] *= phase_tbl[tbl_index].multiplier;
> +		if (phase_tbl[tbl_index].divider == 0)
> +			return;
> +		req->result[index] /= phase_tbl[tbl_index].divider;
> +		req->result[index] += FOUR_POINT_TWO_ADC;
> +	} else {
> +		req->result[index] += conv_tbl[tbl_index].cal_offset;
> +		req->result[index] += conv_tbl[tbl_index].align_offset;
> +		req->result[index] *= phase_tbl[tbl_index].multiplier;
> +		if (phase_tbl[tbl_index].divider == 0)
> +			return;
> +		req->result[index] /= phase_tbl[tbl_index].divider;
> +		req->result[index] += phase_tbl[tbl_index].offset;
> +	}
> +
> +	if (req->result[index] < phase_tbl[tbl_index].min)
> +		req->result[index] = phase_tbl[tbl_index].min;
> +	else if (req->result[index] > phase_tbl[tbl_index].max)
> +		req->result[index] = phase_tbl[tbl_index].max;
> +}
> +
> +/* Looks up temperatures in a table and calculates averages if needed */
> +static unsigned short cpcap_adc_table_to_millicelcius(unsigned short value)

why unsigned if it returns millicelcius, shouldn't this be int to cover 
the temperature rate?

> +{
> +	int i;
> +	int result = 0, alpha = 0;

initialization not needed

> +
> +	if (value <= temp_map[MAX_TEMP_LVL - 1][0])
> +		return temp_map[MAX_TEMP_LVL - 1][1];
> +
> +	if (value >= temp_map[0][0])
> +		return temp_map[0][1];
> +
> +	for (i = 0; i < MAX_TEMP_LVL - 1; i++) {
> +		if ((value <= temp_map[i][0]) &&
> +		    (value >= temp_map[i + 1][0])) {
> +			if (value == temp_map[i][0]) {
> +				result = temp_map[i][1];
> +			} else if (value == temp_map[i + 1][0]) {
> +				result = temp_map[i + 1][1];
> +			} else {
> +				alpha = ((value - temp_map[i][0]) * 1000) /
> +					(temp_map[i + 1][0] - temp_map[i][0]);
> +
> +				result = temp_map[i][1] +
> +					((alpha * (temp_map[i + 1][1] -
> +						 temp_map[i][1])) / 1000);
> +			}
> +			break;
> +		}
> +	}
> +
> +	return result;
> +}
> +
> +static void cpcap_adc_convert(struct cpcap_adc_request *req, int index)
> +{
> +	struct cpcap_adc_conversion_tbl *conv_tbl = bank0_conversion;
> +	int tbl_index = index;
> +
> +	if (req->type == CPCAP_ADC_TYPE_BANK_1)
> +		conv_tbl = bank1_conversion;
> +
> +	if (req->type == CPCAP_ADC_TYPE_BATT_PI)
> +		tbl_index = (tbl_index % 2) ? CPCAP_ADC_BATTI_ADC :
> +			    CPCAP_ADC_BATTP;
> +
> +	if (conv_tbl[tbl_index].conv_type == CONV_TYPE_DIRECT) {
> +		req->result[index] *= conv_tbl[tbl_index].multiplier;
> +		if (conv_tbl[tbl_index].divider == 0)
> +			return;
> +		req->result[index] /= conv_tbl[tbl_index].divider;
> +		req->result[index] += conv_tbl[tbl_index].conv_offset;
> +	} else if (conv_tbl[tbl_index].conv_type == CONV_TYPE_MAPPING)
> +		req->result[index] =
> +			cpcap_adc_table_to_millicelcius(req->result[tbl_index]);
> +}
> +
> +static int cpcap_adc_read_bank_scaled(struct cpcap_adc *ddata,
> +				      struct cpcap_adc_request *req,
> +				      const unsigned long channel_mask)
> +{
> +	unsigned int i;
> +	int cal_data, error;
> +
> +	if (ddata->vendor == CPCAP_VENDOR_TI) {
> +		cal_data = 0;
> +		error = regmap_read(ddata->reg, CPCAP_REG_ADCAL1, &cal_data);
> +		if (error)
> +			return error;
> +		bank0_conversion[CPCAP_ADC_CHG_ISENSE].cal_offset =
> +			((short)cal_data * -1) + 512;
> +	}
> +
> +	if (ddata->vendor == CPCAP_VENDOR_TI) {
> +		cal_data = 0;
> +		error = regmap_read(ddata->reg, CPCAP_REG_ADCAL2, &cal_data);
> +		if (error)
> +			return error;
> +		bank0_conversion[CPCAP_ADC_BATTI_ADC].cal_offset =
> +			((short)cal_data * -1) + 512;
> +	}
> +
> +	for_each_set_bit(i, &channel_mask, 8) {
> +		int addr = CPCAP_REG_ADCD0 + i * 4;
> +
> +		error = regmap_read(ddata->reg, addr, &req->result[i]);
> +		if (error)
> +			return error;
> +
> +		req->result[i] &= 0x3ff;
> +		cpcap_adc_phase(req, i);
> +		cpcap_adc_convert(req, i);
> +	}
> +
> +	return 0;
> +}
> +
> +static int cpcap_adc_read(struct iio_dev *indio_dev,
> +			  struct iio_chan_spec const *chan,
> +			  int *val, int *val2, long mask)
> +{
> +	struct cpcap_adc *ddata = iio_priv(indio_dev);
> +	struct cpcap_adc_request req;
> +	int index, error;
> +
> +	if (chan->channel < 8) {
> +		index = chan->channel;
> +		req.type = CPCAP_ADC_TYPE_BANK_0;
> +	} else if (chan->channel < 16) {
> +		index = chan->channel - 8;
> +		req.type = CPCAP_ADC_TYPE_BANK_1;
> +	} else if (chan->channel < 18) {
> +		index = chan->channel - 16;
> +		req.type = CPCAP_ADC_TYPE_BATT_PI;
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&ddata->lock);
> +		error = cpcap_adc_start_bank(ddata, &req);
> +		if (error)
> +			goto err_unlock;
> +		error = regmap_read(ddata->reg, chan->address, val);
> +		if (error)
> +			goto err_unlock;
> +		mutex_unlock(&ddata->lock);
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		mutex_lock(&ddata->lock);
> +		error = cpcap_adc_start_bank(ddata, &req);
> +		if (error)
> +			goto err_unlock;
> +		error = cpcap_adc_read_bank_scaled(ddata, &req, BIT(index));
> +		if (error)
> +			goto err_unlock;
> +		mutex_unlock(&ddata->lock);
> +		*val = req.result[index];
> +		break;
> +	default:

-EINVAL here?

> +		break;
> +	}
> +
> +	return IIO_VAL_INT;
> +
> +err_unlock:
> +	mutex_unlock(&ddata->lock);
> +	dev_err(ddata->dev, "error reading ADC: %i\n", error);
> +
> +	return error;
> +}
> +
> +static const struct iio_info cpcap_adc_info = {
> +	.read_raw = &cpcap_adc_read,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +/*
> + * Configuration for Motorola mapphone series such as droid 4.
> + * Copied from the Motorola mapphone kernel tree.
> + */
> +static const struct cpcap_adc_ato mapphone_adc = {
> +	.ato_in = 0x0480,
> +	.atox_in = 0,
> +	.adc_ps_factor_in = 0x0200,
> +	.atox_ps_factor_in = 0,
> +	.ato_out = 0,
> +	.atox_out = 0,
> +	.adc_ps_factor_out = 0,
> +	.atox_ps_factor_out = 0,
> +};
> +
> +static const struct of_device_id cpcap_adc_id_table[] = {
> +	{
> +		.compatible = "motorola,cpcap-adc",
> +	},
> +	{
> +		.compatible = "motorola,mapphone-cpcap-adc",
> +		.data = &mapphone_adc,
> +	},
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, cpcap_adc_id_table);
> +
> +static int cpcap_adc_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *match;
> +	struct cpcap_adc *ddata;
> +	struct iio_dev *indio_dev;
> +	struct iio_buffer *buf;
> +	int error;
> +
> +	match = of_match_device(of_match_ptr(cpcap_adc_id_table),
> +				&pdev->dev);
> +	if (!match)
> +		return -EINVAL;
> +
> +	if (!match->data) {
> +		dev_err(&pdev->dev, "no configuration data found\n");
> +
> +		return -ENODEV;
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*ddata));
> +	if (!indio_dev) {
> +		dev_err(&pdev->dev, "failed to allocate iio device\n");
> +
> +		return -ENOMEM;
> +	}
> +	ddata = iio_priv(indio_dev);
> +	ddata->ato = match->data;
> +	ddata->dev = &pdev->dev;
> +
> +	mutex_init(&ddata->lock);
> +	init_waitqueue_head(&ddata->wq_data_avail);
> +
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
> +	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->dev.of_node = pdev->dev.of_node;
> +	indio_dev->channels = cpcap_adc_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(cpcap_adc_channels);
> +	indio_dev->name = dev_name(&pdev->dev);
> +	indio_dev->info = &cpcap_adc_info;
> +
> +	ddata->reg = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!ddata->reg)
> +		return -ENODEV;
> +
> +	error = cpcap_get_vendor(ddata->dev, ddata->reg, &ddata->vendor);
> +	if (error)
> +		return error;
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	ddata->irq = platform_get_irq_byname(pdev, "adcdone");
> +	if (!ddata->irq)
> +		return -ENODEV;
> +
> +	error = devm_request_threaded_irq(&pdev->dev, ddata->irq, NULL,
> +					  cpcap_adc_irq_thread, IRQ_NONE,
> +					  "cpcap-adc", indio_dev);
> +	if (error) {
> +		dev_err(&pdev->dev, "could not get irq: %i\n",
> +			error);
> +
> +		return error;
> +	}
> +
> +	error = cpcap_adc_calibrate(ddata);
> +	if (error)
> +		return error;
> +
> +	buf = devm_iio_kfifo_allocate(&indio_dev->dev);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	iio_device_attach_buffer(indio_dev, buf);
> +
> +	dev_info(&pdev->dev, "CPCAP ADC device probed\n");
> +
> +	return iio_device_register(indio_dev);
> +}
> +
> +static int cpcap_adc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +
> +	iio_device_unregister(indio_dev);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver cpcap_adc_driver = {
> +	.driver = {
> +		.name = "cpcap_adc",
> +		.of_match_table = of_match_ptr(cpcap_adc_id_table),
> +	},
> +	.probe = cpcap_adc_probe,
> +	.remove = cpcap_adc_remove,
> +};
> +
> +module_platform_driver(cpcap_adc_driver);
> +
> +MODULE_ALIAS("platform:cpcap_adc");
> +MODULE_DESCRIPTION("CPCAP ADC driver");
> +MODULE_AUTHOR("Motorola and Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org");
> +MODULE_LICENSE("GPL v2");
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
