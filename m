From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH v5 2/2] iio: twl6030-gpadc: TWL6030, TWL6032 GPADC driver
Date: Wed, 17 Jul 2013 20:04:37 +0200
Message-ID: <51E6DCB5.3070302@metafoo.de>
References: <1374059564-6872-1-git-send-email-oleksandr.kozaruk@ti.com> <1374059564-6872-3-git-send-email-oleksandr.kozaruk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1374059564-6872-3-git-send-email-oleksandr.kozaruk-l0cyMroinI0@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oleksandr Kozaruk <oleksandr.kozaruk-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org, milo.kim-l0cyMroinI0@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 07/17/2013 01:12 PM, Oleksandr Kozaruk wrote:
> The GPADC is general purpose ADC found on TWL6030, and TWL6032 PMIC,
> known also as Phoenix and PhoenixLite.
> 
> The TWL6030 and TWL6032 have GPADC with 17 and 19 channels
> respectively. Some channels have current source and are used for
> measuring voltage drop on resistive load for detecting battery ID
> resistance, or measuring voltage drop on NTC resistors for external
> temperature measurements. Some channels measure voltage, (i.e. battery
> voltage), and have voltage dividers, thus, capable to scale voltage.
> Some channels are dedicated for measuring die temperature.
> 
> Some channels are calibrated in 2 points, having offsets from ideal
> values kept in trim registers. This is used to correct measurements.
> 
> The differences between GPADC in TWL6030 and TWL6032:
> - 10 bit vs 12 bit ADC;
> - 17 vs 19 channels;
> - channels have different purpose(i.e. battery voltage
>   channel 8 vs channel 18);
> - trim values are interpreted differently.
> 
> Based on the driver patched from Balaji TK, Graeme Gregory, Ambresh K,
> Girish S Ghongdemath.
> 
> Signed-off-by: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Graeme Gregory <gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>
> Signed-off-by: Oleksandr Kozaruk <oleksandr.kozaruk-l0cyMroinI0@public.gmane.org>

Almost there (I hope). But please run scripts/checkpatch, make C=2 and make
coccicheck on your driver and fix all errors those tools give you before
submitting the driver upstream.

[...]
> +static int twl6030_gpadc_get_raw(struct twl6030_gpadc_data *gpadc,
> +		int channel, int *res)
> +{
> +	u8 reg = gpadc->pdata->channel_to_reg(channel);
> +	__le16 val;
> +	int raw_code;
> +	int ret;
> +
> +	ret = twl6030_gpadc_read(reg, (u8 *)&val);
> +	if (ret) {
> +		dev_dbg(gpadc->dev, "unable to read register 0x%X\n", reg);
> +		return ret;
> +	}
> +
> +	raw_code = le16_to_cpup(&val);

raw_code = le16_to_cpu(val)

> +	dev_dbg(gpadc->dev, "GPADC raw code: %d", raw_code);
> +
> +	if (twl6030_channel_calibrated(gpadc->pdata, channel))
> +		*res = twl6030_gpadc_make_correction(gpadc, channel, raw_code);
> +	else
> +		*res = raw_code;
> +
> +	return ret;
> +}
> +
[...]
> +static int twl6030_gpadc_read_raw(struct iio_dev *indio_dev,
> +			     const struct iio_chan_spec *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct twl6030_gpadc_data *gpadc = iio_priv(indio_dev);
> +	int ret = -EINVAL;
> +	long timeout;
> +
> +	mutex_lock(&gpadc->lock);
> +
> +	ret = gpadc->pdata->start_conversion(chan->channel);
> +	if (ret) {
> +		dev_err(gpadc->dev, "failed to start conversion\n");
> +		goto err;
> +	}
> +	/* wait for conversion to complete */
> +	timeout = wait_for_completion_interruptible_timeout(
> +				&gpadc->irq_complete, msecs_to_jiffies(5000));
> +	if (!timeout)
> +		return -ETIMEDOUT;
> +	else if (timeout < 0)
> +		return EINTR;

You still hold the mutex, try this instead:

	ret = wait_for_....
	if (ret == 0)
		ret = -ETIMEDOUT;
	if (ret < 0)
		goto err;


> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = twl6030_gpadc_get_raw(gpadc, chan->channel, val);
> +		ret = ret ? -EIO : IIO_VAL_INT;
> +		break;
> +
> +	case IIO_CHAN_INFO_PROCESSED:
> +		ret = twl6030_gpadc_get_processed(gpadc, chan->channel, val);
> +		ret = ret ? -EIO : IIO_VAL_INT;
> +		break;
> +
> +	default:
> +		break;
> +	}
> +err:
> +	mutex_unlock(&gpadc->lock);
> +
> +	return ret;
> +}
[...]
> +
> +static int twl6032_calibration(struct twl6030_gpadc_data *gpadc)
> +{
> +	int chn, d1 = 0, d2 = 0, temp;
> +	u8 trim_regs[17];
> +	int ret;
> +
> +	ret = twl_i2c_read(TWL6030_MODULE_ID2, trim_regs + 1,
> +			TWL6030_GPADC_TRIM1, 16);
> +	if (ret < 0) {
> +		dev_err(gpadc->dev, "calibration failed\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * Loop to calculate the value needed for returning voltages from
> +	 * GPADC not values.
> +	 *
> +	 * gain is calculated to 3 decimal places fixed point.
> +	 */
> +	for (chn = 0; chn < TWL6032_GPADC_MAX_CHANNELS; chn++) {
> +
> +		switch (chn) {
> +		case 0:
> +		case 1:
> +		case 2:
> +		case 3:
> +		case 4:
> +		case 5:
> +		case 6:
> +		case 11:
> +		case 12:
> +		case 13:
> +		case 14:
> +			/* D1 */
> +			d1 = (trim_regs[3] & 0x1F) << 2;
> +			d1 |= (trim_regs[1] & 0x06) >> 1;
> +			if (trim_regs[1] & 0x01)
> +				d1 = -d1;
> +
> +			/* D2 */
> +			d2 = (trim_regs[4] & 0x3F) << 2;
> +			d2 |= (trim_regs[2] & 0x06) >> 1;
> +			if (trim_regs[2] & 0x01)
> +				d2 = -d2;
> +			break;
> +		case 8:
> +			/* D1 */
> +			temp = (trim_regs[3] & 0x1F) << 2;
> +			temp |= (trim_regs[1] & 0x06) >> 1;
> +			if (trim_regs[1] & 0x01)
> +				temp = -temp;
> +
> +			d1 = (trim_regs[8] & 0x18) << 1;
> +			d1 |= (trim_regs[7] & 0x1E) >> 1;
> +			if (trim_regs[7] & 0x01)
> +				d1 = -d1;
> +
> +			d1 += temp;
> +
> +			/* D2 */
> +			temp = (trim_regs[4] & 0x3F) << 2;
> +			temp |= (trim_regs[2] & 0x06) >> 1;
> +			if (trim_regs[2] & 0x01)
> +				temp = -temp;
> +
> +			d2 = (trim_regs[10] & 0x1F) << 2;
> +			d2 |= (trim_regs[8] & 0x06) >> 1;
> +			if (trim_regs[8] & 0x01)
> +				d2 = -d2;
> +
> +			d2 += temp;
> +			break;
> +		case 9:
> +			/* D1 */
> +			temp = (trim_regs[3] & 0x1F) << 2;
> +			temp |= (trim_regs[1] & 0x06) >> 1;
> +			if (trim_regs[1] & 0x01)
> +				temp = -temp;
> +
> +			d1 = (trim_regs[14] & 0x18) << 1;
> +			d1 |= (trim_regs[12] & 0x1E) >> 1;
> +			if (trim_regs[12] & 0x01)
> +				d1 = -d1;
> +
> +			d1 += temp;
> +
> +			/* D2 */
> +			temp = (trim_regs[4] & 0x3F) << 2;
> +			temp |= (trim_regs[2] & 0x06) >> 1;
> +			if (trim_regs[2] & 0x01)
> +				temp = -temp;
> +
> +			d2 = (trim_regs[16] & 0x1F) << 2;
> +			d2 |= (trim_regs[14] & 0x06) >> 1;
> +			if (trim_regs[14] & 0x01)
> +				d2 = -d2;
> +
> +			d2 += temp;
> +		case 10:
> +			/* D1 */
> +			d1 = (trim_regs[11] & 0x0F) << 3;
> +			d1 |= (trim_regs[9] & 0x0E) >> 1;
> +			if (trim_regs[9] & 0x01)
> +				d1 = -d1;
> +
> +			/* D2 */
> +			d2 = (trim_regs[15] & 0x0F) << 3;
> +			d2 |= (trim_regs[13] & 0x0E) >> 1;
> +			if (trim_regs[13] & 0x01)
> +				d2 = -d2;
> +			break;
> +		case 7:
> +		case 18:
> +			/* D1 */
> +			temp = (trim_regs[3] & 0x1F) << 2;
> +			temp |= (trim_regs[1] & 0x06) >> 1;
> +			if (trim_regs[1] & 0x01)
> +				temp = -temp;
> +
> +			d1 = (trim_regs[5] & 0x7E) >> 1;
> +			if (trim_regs[5] & 0x01)
> +				d1 = -d1;
> +.
> +			d1 += temp;
> +
> +			/* D2 */
> +			temp = (trim_regs[4] & 0x3F) << 2;
> +			temp |= (trim_regs[2] & 0x06) >> 1;
> +			if (trim_regs[2] & 0x01)
> +				temp = -temp;
> +
> +			d2 = (trim_regs[6] & 0xFE) >> 1;
> +			if (trim_regs[6] & 0x01)
> +				d2 = -d2;
> +
> +			d2 += temp;
> +			break;


There is quite a bit of copy paste in here. Putting the bit swizziling into
a helper function should also improbe legibility.

> +		default:
> +			/* No data for other channels */
> +			continue;
> +		}
> +
> +		twl6030_calibrate_channel(gpadc, chn, d1, d2);
> +	}
> +
> +	return 0;
> +}

> +[...]
> +static int twl6030_gpadc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct twl6030_gpadc_data *gpadc;
> +	const struct twl6030_gpadc_platform_data *pdata;
> +	const struct of_device_id *match;
> +	struct iio_dev *indio_dev;
> +	int irq;
> +	int ret;
> +
> +	match = of_match_device(of_match_ptr(of_twl6030_match_tbl), dev);
> +	pdata = match ? match->data : dev->platform_data;

The twl6030_gpadc_platform_data struct is not available outside of this
file, so it is rather unlikely that dev->platfrom_data will contain such a
struct.

[...]
> +
> +static int twl6030_gpadc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +
> +	twl6030_gpadc_disable_irq(TWL6030_GPADC_RT_SW1_EOC_MASK);
> +	free_irq(platform_get_irq(pdev, 0), indio_dev);

The last parameter needs to match that of the request_irq call

> +	iio_device_unregister(indio_dev);
> +	iio_device_free(indio_dev);
> +
> +	return 0;
> +}
[...]
