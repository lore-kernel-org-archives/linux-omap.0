From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] Driver for omap34xx temperature sensor.
Date: Tue, 20 May 2008 15:29:20 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0805201515000.9463@utopia.booyaka.com>
References: <20080519135629.GB5040@codecarver.research.nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37647 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756729AbYETV3V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 May 2008 17:29:21 -0400
In-Reply-To: <20080519135629.GB5040@codecarver.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

Hi Peter,

a few quick comments.

On Mon, 19 May 2008, Peter 'p2' De Schrijver wrote:

> +#define SCM_CONTROL_TEMP_SENSOR	(OMAP343X_SCM_BASE + 0x524)

Consider moving this to include/asm-arm/arch-omap/control.h ?

> +#define CM_FCLKEN3_CORE (OMAP3430_CM_BASE + 0x200 + 0x8)

The above define doesn't appear to be used.

> +/* minimum delay for EOCZ rise after SOC rise is
> + * 11 cycles of the 32Khz clock */
> +#define EOCZ_MIN_RISING_DELAY (11 * 31250)

Doesn't the 32k sync timer run at 32KiHz == 32768 cycles/second?  I wonder 
if this might be affecting the temperature values.  

> +		temp_sensor_reg = omap_readl(SCM_CONTROL_TEMP_SENSOR);
> +		temp_sensor_reg |= TEMP_SENSOR_SOC;
> +		omap_writel(temp_sensor_reg, SCM_CONTROL_TEMP_SENSOR);

Consider ctrl_{read,write}_reg() instead.

> +		temp_sensor_reg &= ~TEMP_SENSOR_SOC;
> +		omap_writel(temp_sensor_reg, SCM_CONTROL_TEMP_SENSOR);

Likewise.

> +
> +		expire = ktime_add_ns(ktime_get(), EOCZ_MAX_FALLING_DELAY);
> +		timeout = ns_to_timespec(EOCZ_MIN_FALLING_DELAY);
> +		hrtimer_nanosleep(&timeout, NULL, HRTIMER_MODE_REL,
> +					CLOCK_MONOTONIC);
> +
> +		do {
> +			temp_sensor_reg = omap_readl(SCM_CONTROL_TEMP_SENSOR);
> +			if (!(temp_sensor_reg & TEMP_SENSOR_EOCZ))
> +				break;
> +		} while (ktime_us_delta(expire, ktime_get()) > 0);
> +
> +		if (temp_sensor_reg & TEMP_SENSOR_EOCZ)
> +			goto err;

The code in the above block is duplicated twice with only a few parameter 
changes -- perhaps move this into a function? 

> +static int __devinit omap34xx_temp_probe(void)
> +{
> +	int err;
> +	struct omap34xx_data *data;
> +
> +	err = platform_device_register(&omap34xx_temp_device);
> +	if (err) {
> +		printk(KERN_ERR
> +			"Unable to register omap34xx temperature device\n");
> +		goto exit;
> +	}

All of the following error paths in this function should call 
platform_device_unregister() also, correct?

> +static void __exit omap34xx_temp_exit(void)
> +{
> +	struct omap34xx_data *data =
> +			dev_get_drvdata(&omap34xx_temp_device.dev);
> +
> +	clk_put(data->clk_32k);
> +	hwmon_device_unregister(data->hwmon_dev);
> +	device_remove_file(&omap34xx_temp_device.dev,
> +			   &sensor_dev_attr_temp1_input.dev_attr);
> +	device_remove_file(&omap34xx_temp_device.dev, &dev_attr_name);
> +	kfree(data);

Should this also include a platform_device_unregister()?

> +}


- Paul
