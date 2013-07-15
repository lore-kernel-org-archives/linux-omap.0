From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH v3 2/2] iio: twl6030-gpadc: TWL6030, TWL6032 GPADC driver
Date: Mon, 15 Jul 2013 14:33:32 +0200
Message-ID: <51E3EC1C.9090507@metafoo.de>
References: <1373613482-28390-1-git-send-email-oleksandr.kozaruk@ti.com> <1373613482-28390-3-git-send-email-oleksandr.kozaruk@ti.com> <51E05F6C.1060506@metafoo.de> <51E3E362.6090903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51E3E362.6090903-l0cyMroinI0@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Oleksandr Kozaruk <oleksandr.kozaruk-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org, milo.kim-l0cyMroinI0@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 07/15/2013 01:56 PM, Grygorii Strashko wrote:
> Hi All,
> 
> I have a question regarding this patch and IIO in general
> - Does IIO provide sync mechanism with system wide suspend/resume or this
> should be handled by each driver itself?
> 
> What if during system suspend iio_read_channel_raw() (or any other consumer
> API) will be called after gpadc driver have been suspended already? (I did
> some investigation and seems it's possible - Am I right?)
> 
> If no, could "info_exist_lock" be reused for such purposes?

I think you can use the mlock for this purpose. Usually you'd have a flag in
your driver struct which you'd set to true in suspend and to false in
resume. And in the read_raw callback you'd check that flag before accessing
the hardware. If it turns out that this is a common pattern it probably
makes sense to add infrastructure for this to the IIO core. Something along
the lines of:

static int drv_suspend(...)
{
	...
	iio_device_set_suspended(iio_dev, true);
	...
}

static int drv_suspend(...)
{
	...
	iio_device_set_suspended(iio_dev, false);
	...
}

and then have the IIO core check that flag before calling the read_raw callback.

- Lars

> 
> Regards,
> -grygorii
> 
> 
> On 07/12/2013 10:56 PM, Lars-Peter Clausen wrote:
>>
>> A couple of comments inline.
>>
>> On 07/12/2013 09:18 AM, Oleksandr Kozaruk wrote:
>>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>>> index ab0767e6..87d699e 100644
>>> --- a/drivers/iio/adc/Kconfig
>>> +++ b/drivers/iio/adc/Kconfig
>>> @@ -157,4 +157,12 @@ config VIPERBOARD_ADC
>>>         Say yes here to access the ADC part of the Nano River
>>>         Technologies Viperboard.
>>>
>>> +config TWL6030_GPADC
>>> +    tristate "TWL6030 GPADC (General Purpose A/D Convertor) Support"
>>> +    depends on TWL4030_CORE
>>> +    default n
>>> +    help
>>> +      Say yes here if you want support for the TWL6030 General Purpose
>>> +      A/D Convertor.
>>> +
>>
>> Keep it in alphabetical order
>>
>>>   endmenu
>>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>>> index 0a825be..8b05633 100644
>>> --- a/drivers/iio/adc/Makefile
>>> +++ b/drivers/iio/adc/Makefile
>>> @@ -17,3 +17,4 @@ obj-$(CONFIG_MAX1363) += max1363.o
>>>   obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
>>>   obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
>>>   obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
>>> +obj-$(CONFIG_TWL6030_GPADC) += twl6030-gpadc.o
>>
>> Same here.
>>
>>> diff --git a/drivers/iio/adc/twl6030-gpadc.c
>>> b/drivers/iio/adc/twl6030-gpadc.c
>>> new file mode 100644
>>> index 0000000..6ceb789
>>> --- /dev/null
>>> +++ b/drivers/iio/adc/twl6030-gpadc.c
>>> @@ -0,0 +1,1019 @@
>> [...]
>>> +static u8 twl6032_channel_to_reg(int channel)
>>> +{
>>> +    return TWL6032_GPADC_GPCH0_LSB;
>>
>> There is more than one channel, isn't there?
>>
>> [...]
>>  > +static int twl6030_gpadc_read_raw(struct iio_dev *indio_dev,
>>  > +                 const struct iio_chan_spec *chan,
>>  > +                 int *val, int *val2, long mask)
>>  > +{
>>  > +    struct twl6030_gpadc_data *gpadc = iio_priv(indio_dev);
>>  > +    int ret = -EINVAL;
>>  > +
>>  > +    mutex_lock(&gpadc->lock);
>>  > +
>>  > +    ret = gpadc->pdata->start_conversion(chan->channel);
>>  > +    if (ret) {
>>  > +        dev_err(gpadc->dev, "failed to start conversion\n");
>>  > +        goto err;
>>  > +    }
>>  > +    /* wait for conversion to complete */
>>  > +    wait_for_completion_interruptible_timeout(&gpadc->irq_complete,
>>  > +                        msecs_to_jiffies(5000));
>>
>> wait_for_completion_interruptible_timeout() can return either a negative
>> error code if it was interrupted, 0 if it timed out, or a positive value
>> if it was successfully completed. You need to handle all three cases.
>> Have a look at other existing drivers to see how to do this properly.
>>
>>  > +
>>  > +    switch (mask) {
>>  > +    case IIO_CHAN_INFO_RAW:
>>  > +        ret = twl6030_gpadc_get_raw(gpadc, chan->channel, val);
>>  > +        ret = ret ? -EIO : IIO_VAL_INT;
>>  > +        break;
>>  > +
>>  > +    case IIO_CHAN_INFO_PROCESSED:
>>  > +        ret = twl6030_gpadc_get_processed(gpadc, chan->channel, val);
>>  > +        ret = ret ? -EIO : IIO_VAL_INT;
>>  > +        break;
>>  > +
>>  > +    default:
>>  > +        break;
>>  > +    }
>>  > +err:
>>  > +    mutex_unlock(&gpadc->lock);
>>  > +
>>  > +    return ret;
>>  > +}
>>
>>> +}
>>> +
>> [...]
>>> +static int twl6030_gpadc_probe(struct platform_device *pdev)
>>> +{
>>> +    struct device *dev = &pdev->dev;
>>> +    struct twl6030_gpadc_data *gpadc;
>>> +    const struct twl6030_gpadc_platform_data *pdata;
>>> +    const struct of_device_id *match;
>>> +    struct iio_dev *indio_dev;
>>> +    int irq;
>>> +    int ret = 0;
>>> +
>>> +    match = of_match_device(of_match_ptr(of_twl6030_match_tbl), dev);
>>> +    pdata = match ? match->data : dev->platform_data;
>>> +
>>> +    if (!pdata)
>>> +        return -EINVAL;
>>> +
>>> +    indio_dev = iio_device_alloc(sizeof(struct twl6030_gpadc_data));
>>
>> sizeof(*gpadc)
>>
>>> +    if (!indio_dev) {
>>> +        dev_err(dev, "failed allocating iio device\n");
>>> +        ret = -ENOMEM;
>>> +    }
>>> +
>>> +    gpadc = iio_priv(indio_dev);
>>> +
>>> +    gpadc->twl6030_cal_tbl = devm_kzalloc(dev,
>>> +                    sizeof(struct twl6030_chnl_calib) *
>>> +                    pdata->nchannels, GFP_KERNEL);
>>> +    if (!gpadc->twl6030_cal_tbl)
>>> +        goto err;
>>> +
>>> +    gpadc->dev = dev;
>>> +    gpadc->pdata = pdata;
>>> +
>>> +    platform_set_drvdata(pdev, indio_dev);
>>> +    mutex_init(&gpadc->lock);
>>> +    init_completion(&gpadc->irq_complete);
>>> +
>>> +    ret = pdata->calibrate(gpadc);
>>> +    if (ret < 0) {
>>> +        dev_err(&pdev->dev, "failed to read calibration registers\n");
>>> +        goto err;
>>> +    }
>>> +
>>> +    irq = platform_get_irq(pdev, 0);
>>> +    if (irq < 0) {
>>> +        dev_err(&pdev->dev, "failed to get irq\n");
>>> +        goto err;
>>> +    }
>>> +
>>> +    ret = devm_request_threaded_irq(dev, irq, NULL,
>>> +                    twl6030_gpadc_irq_handler,
>>> +                    IRQF_ONESHOT, "twl6030_gpadc", gpadc);
>>
>> You access memory in the interrupt handler which is freed before the
>> interrupt handler is freed.
>>
>>> +    if (ret) {
>>> +        dev_dbg(&pdev->dev, "could not request irq\n");
>>> +        goto err;
>>> +    }
>>> +
>>> +    ret = twl6030_gpadc_enable_irq(TWL6030_GPADC_RT_SW1_EOC_MASK);
>>> +    if (ret < 0) {
>>> +        dev_err(&pdev->dev, "failed to enable GPADC interrupt\n");
>>> +        goto err;
>>> +    }
>>> +    ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, TWL6030_GPADCS,
>>> +                    TWL6030_REG_TOGGLE1);
>>> +    if (ret < 0) {
>>> +        dev_err(&pdev->dev, "failed to enable GPADC module\n");
>>> +        goto err;
>>> +    }
>>> +
>>> +    indio_dev->name = DRIVER_NAME;
>>> +    indio_dev->dev.parent = dev;
>>> +    indio_dev->info = &twl6030_gpadc_iio_info;
>>> +    indio_dev->modes = INDIO_DIRECT_MODE;
>>> +    indio_dev->channels = pdata->iio_channels;
>>> +    indio_dev->num_channels = pdata->nchannels;
>>> +
>>> +    ret = iio_device_register(indio_dev);
>>> +    if (ret)
>>> +        goto err;
>>> +
>>> +    return ret;
>>> +err:
>>> +    iio_device_free(indio_dev);
>>> +    return ret;
>>> +}
>>> +
>> [...]
>>> +static int twl6030_gpadc_suspend(struct device *pdev)
>>> +{
>>> +    int ret;
>>> +
>>> +    ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, TWL6030_GPADCR,
>>> +                TWL6030_REG_TOGGLE1);
>>> +    if (ret)
>>> +        dev_err(pdev, "error reseting GPADC (%d)!\n", ret);
>>> +
>>> +    return 0;
>>> +};
>>> +
>>> +static int twl6030_gpadc_resume(struct device *pdev)
>>> +{
>>> +    int ret;
>>> +
>>> +    ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, TWL6030_GPADCS,
>>> +                TWL6030_REG_TOGGLE1);
>>> +    if (ret)
>>> +        dev_err(pdev, "error setting GPADC (%d)!\n", ret);
>>> +
>>> +    return 0;
>>> +};
>>> +
>>> +static const struct dev_pm_ops twl6030_gpadc_pm_ops = {
>>> +    .suspend = twl6030_gpadc_suspend,
>>> +    .resume = twl6030_gpadc_resume,
>>> +};
>>
>> SIMPLE_DEV_PM_OPS?
>>
>> [...]
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
