From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC PATCH 09/11] ARM: OMAP4+: thermal: introduce
 bandgap temperature sensor
Date: Tue, 29 May 2012 15:14:48 +0200
Message-ID: <4FC4CBC8.2040600@ti.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
	<1337934361-1606-10-git-send-email-eduardo.valentin@ti.com>
	<4FBFAA18.4040103@ti.com> <20120528111624.GC3923@besouro>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120528111624.GC3923@besouro>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: eduardo.valentin@ti.com
Cc: amit.kucheria@linaro.org, balbi@ti.com, kishon@ti.com, kbaidarov@dev.rtsoft.ru, Keerthy <j-keerthy@ti.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 5/28/2012 1:16 PM, Eduardo Valentin wrote:
> Hello again,
>
> On Fri, May 25, 2012 at 05:49:44PM +0200, Cousson Benoit wrote:
>> On 5/25/2012 10:25 AM, Eduardo Valentin wrote:
>
> <big cut>
>
>>> +
>>> +static const struct omap_bandgap_data omap4460_data = {
>>> +	.has_talert = true,
>>> +	.has_tshut = true,
>>> +	.fclock_name = "bandgap_ts_fclk",
>>> +	.div_ck_name = "div_ts_ck",
>>
>> None of these clock data should be there ideally. You should ensure
>> that the proper device alias will be there using clkdev entries.
>
> In fact, it is a shame that it would be needed to have this entries there :-(
>
>>
>> Except that with DT, it will not work without the clock DT binding :-(
>>
>> I think Rob posted a latest update based on CCF... but for the
>> moment we are stuck :-(
>
> OK. But would it work for BG as well as it seams to be a special case?
>
>>
>>> +	.conv_table = omap4460_adc_to_temp,
>>> +	.sensors = {
>>> +		{
>>> +			.registers =&omap4460_mpu_temp_sensor_registers,
>>> +			.ts_data =&omap4460_mpu_temp_sensor_data,
>>> +			.domain = "cpu",
>>> +		},
>>> +	},
>>> +	.sensor_count = 1,
>>> +};
>>> +
>>> +static const struct omap_bandgap_data omap5430_data = {
>>> +	.has_talert = true,
>>> +	.has_tshut = true,
>>> +	.fclock_name = "ts_clk_div_ck",
>>> +	.div_ck_name = "ts_clk_div_ck",
>>> +	.conv_table = omap5430_adc_to_temp,
>>> +	.sensors = {
>>> +		{
>>> +			.registers =&omap5430_mpu_temp_sensor_registers,
>>> +			.ts_data =&omap5430_mpu_temp_sensor_data,
>>> +			.domain = "cpu",
>>> +		},
>>> +		{
>>> +			.registers =&omap5430_gpu_temp_sensor_registers,
>>> +			.ts_data =&omap5430_gpu_temp_sensor_data,
>>> +			.domain = "gpu",
>>> +		},
>>> +		{
>>> +			.registers =&omap5430_core_temp_sensor_registers,
>>> +			.ts_data =&omap5430_core_temp_sensor_data,
>>> +			.domain = "core",
>>> +		},
>>> +	},
>>> +	.sensor_count = 3,
>>
>> It can probably be replaced by a sizeof.
>
> ARRAY_SIZE prob, will check.

Ah, yes, that's one... I was looking for it for forgot the name :-)

>>> +};
>>> +
>>> +static const struct of_device_id of_omap_bandgap_match[] = {
>>> +	/*
>>> +	 * TODO: Add support to 4430
>>> +	 * { .compatible = "ti,omap4430-bandgap", .data = , },
>>> +	 */
>>> +	{
>>> +		.compatible = "ti,omap4460-bandgap",
>>> +		.data = (void *)&omap4460_data,
>>
>> No need to cast toward a void *.
>
> In this case, there is a need, because the omap4460_data is const but the .data field isn't. So I need to force it.
>
>>
>>> +	},
>>> +	{
>>> +		.compatible = "ti,omap5430-bandgap",
>>> +		.data = (void *)&omap5430_data,
>>> +	},
>>> +	/* Sentinel */
>>> +	{ },
>>> +};
>>> +
>>> +static struct omap_bandgap *omap_bandgap_build(struct platform_device *pdev)
>>> +{
>>> +	struct device_node *node = pdev->dev.of_node;
>>> +	const struct of_device_id *of_id;
>>> +	struct omap_bandgap *bg_ptr;
>>
>> bg_ptr is not a super name.
>
> Got a better name? Just don't want a long one to avoid code bending at 80th column...

My concern was mainly with the _ptr, it looks like a Hungarian notation. 
:-)...

Maybe bg only? Or omap_bg?

>
>>
>>> +	u32 prop;
>>> +
>>> +	/* just for the sake */
>>> +	if (!node) {
>>> +		dev_err(&pdev->dev, "no platform information available\n");
>>> +		return ERR_PTR(-EINVAL);
>>> +	}
>>
>> Not needed, just do the of_match_device here directly.
>
> Indeed...
>
>>
>>> +
>>> +	bg_ptr = devm_kzalloc(&pdev->dev, sizeof(struct omap_bandgap),
>>> +				    GFP_KERNEL);
>>> +	if (!bg_ptr) {
>>> +		dev_err(&pdev->dev, "Unable to allocate mem for driver ref\n");
>>> +		return ERR_PTR(-ENOMEM);
>>> +	}
>>> +
>>> +	of_id = of_match_device(of_omap_bandgap_match,&pdev->dev);
>>> +	if (of_id)
>>> +		bg_ptr->pdata = of_id->data;
>>
>> Nit: This is not really pdata anymore, so you should maybe remove
>> the "p" to avoid confusion.
>
> OK...
>
>>
>>> +
>>> +	if (bg_ptr->pdata->has_tshut) {
>>> +		if (of_property_read_u32(node, "ti,tshut-gpio",&prop)<   0) {
>>> +			dev_err(&pdev->dev, "missing tshut gpio in device tree\n");
>>> +			return ERR_PTR(-EINVAL);
>>> +		}
>>> +		bg_ptr->tshut_gpio = prop;
>>> +		if (!gpio_is_valid(bg_ptr->tshut_gpio)) {
>>> +			dev_err(&pdev->dev, "invalid gpio for tshut (%d)\n",
>>> +				bg_ptr->tshut_gpio);
>>> +			return ERR_PTR(-EINVAL);
>>> +		}
>>> +	}
>>> +
>>> +	return bg_ptr;
>>> +}
>>> +
>>> +static
>>> +int __devinit omap_bandgap_probe(struct platform_device *pdev)
>>> +{
>>> +	struct device *cdev = pdev->dev.parent;
>>> +	struct omap_bandgap *bg_ptr;
>>> +	int clk_rate, ret = 0, i;
>>> +
>>> +	if (!cdev) {
>>> +		dev_err(&pdev->dev, "no omap control ref in our parent\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	bg_ptr = omap_bandgap_build(pdev);
>>> +	if (IS_ERR_OR_NULL(bg_ptr)) {
>>> +		dev_err(&pdev->dev, "failed to fetch platform data\n");
>>> +		return PTR_ERR(bg_ptr);
>>> +	}
>>> +
>>> +	if (bg_ptr->pdata->has_talert) {
>>
>> Nit2: Yeah, in fact instead of pdata, "conf" or "settings" seems to
>> be more representative of what this structure really contain.
>
> conf looks good to me.
>
>>
>>> +		ret = omap_bandgap_talert_init(bg_ptr, pdev);
>>> +		if (ret) {
>>> +			dev_err(&pdev->dev, "failed to initialize Talert IRQ\n");
>>> +			return ret;
>>> +		}
>>> +	}
>>> +
>>> +	if (bg_ptr->pdata->has_tshut) {
>>> +		ret = omap_bandgap_tshut_init(bg_ptr, pdev);
>>> +		if (ret) {
>>> +			dev_err(&pdev->dev,
>>> +				"failed to initialize system tshut IRQ\n");
>>> +			goto free_talert;
>>> +		}
>>> +	}
>>> +
>>> +	bg_ptr->fclock = clk_get(NULL, bg_ptr->pdata->fclock_name);
>>
>> That's not good to get a clock without using the local dev alias.
>> But because of lack of clock DT binding yet, I'm not sure we have
>> the choice.
>
> In fact I didn't touch the clk data on purpose and left the clock handling
> as is. On my side I didn't know how the clock struct would look like with DT,
> so, I didn't mess with it.
>
> Do you have a reference to check the work in progress for clock DT ?

Rob sent a pull request, it seems that now it is up to Mike T. :-)

http://lists-archives.com/linux-kernel/27640907-dt-clk-binding-support.html

>
>>
>>> +	ret = IS_ERR_OR_NULL(bg_ptr->fclock);
>>> +	if (ret) {
>>> +		dev_err(&pdev->dev, "failed to request fclock reference\n");
>>> +		goto free_irqs;
>>> +	}
>>> +
>>> +	bg_ptr->div_clk = clk_get(NULL,  bg_ptr->pdata->div_ck_name);
>>> +	ret = IS_ERR_OR_NULL(bg_ptr->div_clk);
>>> +	if (ret) {
>>> +		dev_err(&pdev->dev,
>>> +			"failed to request div_ts_ck clock ref\n");
>>> +		goto free_irqs;
>>> +	}
>>> +
>>> +	bg_ptr->conv_table = bg_ptr->pdata->conv_table;
>>> +	for (i = 0; i<   bg_ptr->pdata->sensor_count; i++) {
>>> +		struct temp_sensor_registers *tsr;
>>> +		u32 val;
>>> +
>>> +		tsr = bg_ptr->pdata->sensors[i].registers;
>>> +		/*
>>> +		 * check if the efuse has a non-zero value if not
>>> +		 * it is an untrimmed sample and the temperatures
>>> +		 * may not be accurate
>>> +		 */
>>> +		ret = omap_control_readl(cdev, tsr->bgap_efuse,&val);
>>> +		if (ret || !val)
>>> +			dev_info(&pdev->dev,
>>> +				 "Non-trimmed BGAP, Temp not accurate\n");
>>> +	}
>>> +
>>> +	clk_rate = clk_round_rate(bg_ptr->div_clk,
>>> +				  bg_ptr->pdata->sensors[0].ts_data->max_freq);
>>> +	if (clk_rate<   bg_ptr->pdata->sensors[0].ts_data->min_freq ||
>>> +	    clk_rate == 0xffffffff) {
>>> +		ret = -ENODEV;
>>> +		goto put_clks;
>>> +	}
>>> +
>>> +	ret = clk_set_rate(bg_ptr->div_clk, clk_rate);
>>> +	if (ret) {
>>> +		dev_err(&pdev->dev, "Cannot set clock rate\n");
>>> +		goto put_clks;
>>> +	}
>>> +
>>> +	bg_ptr->clk_rate = clk_rate;
>>> +	clk_enable(bg_ptr->fclock);
>>> +
>>> +	mutex_init(&bg_ptr->bg_mutex);
>>> +	bg_ptr->dev =&pdev->dev;
>>> +	platform_set_drvdata(pdev, bg_ptr);
>>> +
>>> +	/* 1 clk cycle */
>>
>> What does that mean exactly?
>
> That's indeed a good question. I guess by default we configure the bandgap to
> wait only 1 cycle before it goes to the next read round, if in continuous mode.

OK, so some more explanation in that comment are maybe required.

Thanks,
Benoit

>
> That should get overwritten when we have, for instance, some policy initialized
> and changing the update rate based on the temperature level that the sensor is.
>
> These decisions would go under omapXX-thermal.c, BTW. Check my reply on your
> suggestion for data structure split.
>
>>
>> Regards,
>> Benoit
>>
>>> +	for (i = 0; i<   bg_ptr->pdata->sensor_count; i++)
>>> +		configure_temp_sensor_counter(bg_ptr, i, 1);
>>> +
>>> +	for (i = 0; i<   bg_ptr->pdata->sensor_count; i++) {
>>> +		struct temp_sensor_data *ts_data;
>>> +
>>> +		ts_data = bg_ptr->pdata->sensors[i].ts_data;
>>> +
>>> +		temp_sensor_init_talert_thresholds(bg_ptr, i,
>>> +						   ts_data->t_hot,
>>> +						   ts_data->t_cold);
>>> +		temp_sensor_configure_tshut_hot(bg_ptr, i,
>>> +						ts_data->tshut_hot);
>>> +		temp_sensor_configure_tshut_cold(bg_ptr, i,
>>> +						 ts_data->tshut_cold);
>>> +	}
>>> +
>>> +	enable_continuous_mode(bg_ptr);
>>> +
>>> +	/* Set .250 seconds time as default counter */
>>> +	for (i = 0; i<   bg_ptr->pdata->sensor_count; i++)
>>> +		configure_temp_sensor_counter(bg_ptr, i,
>>> +					      bg_ptr->clk_rate / 4);
>>> +
>>> +	/* Every thing is good? Then expose the sensors */
>>> +	for (i = 0; i<   bg_ptr->pdata->sensor_count; i++) {
>>> +		char *domain;
>>> +
>>> +		domain = bg_ptr->pdata->sensors[i].domain;
>>> +		if (bg_ptr->pdata->expose_sensor)
>>> +			bg_ptr->pdata->expose_sensor(bg_ptr, i, domain);
>>> +	}
>>> +
>>> +	return 0;
>>> +
>>> +put_clks:
>>> +	clk_disable(bg_ptr->fclock);
>>> +	clk_put(bg_ptr->fclock);
>>> +	clk_put(bg_ptr->div_clk);
>>> +free_irqs:
>>> +	free_irq(gpio_to_irq(bg_ptr->tshut_gpio), NULL);
>>> +	gpio_free(bg_ptr->tshut_gpio);
>>> +free_talert:
>>> +	free_irq(bg_ptr->irq, bg_ptr);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static
>>> +int __devexit omap_bandgap_remove(struct platform_device *pdev)
>>> +{
>>> +	struct omap_bandgap *bg_ptr = platform_get_drvdata(pdev);
>>> +
>>> +	clk_disable(bg_ptr->fclock);
>>> +	clk_put(bg_ptr->fclock);
>>> +	clk_put(bg_ptr->div_clk);
>>> +	free_irq(bg_ptr->irq, bg_ptr);
>>> +	free_irq(gpio_to_irq(bg_ptr->tshut_gpio), NULL);
>>> +	gpio_free(bg_ptr->tshut_gpio);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +#ifdef CONFIG_PM
>>> +static int omap_bandgap_save_ctxt(struct omap_bandgap *bg_ptr)
>>> +{
>>> +	struct device *cdev = bg_ptr->dev->parent;
>>> +	int err = 0;
>>> +	int i;
>>> +
>>> +	for (i = 0; i<   bg_ptr->pdata->sensor_count; i++) {
>>> +		struct temp_sensor_registers *tsr;
>>> +		struct temp_sensor_regval *rval;
>>> +
>>> +		rval = bg_ptr->pdata->sensors[i].regval;
>>> +		tsr = bg_ptr->pdata->sensors[i].registers;
>>> +
>>> +		err = omap_control_readl(cdev, tsr->bgap_mode_ctrl,
>>> +					&rval->bg_mode_ctrl);
>>> +		err |= omap_control_readl(cdev,	tsr->bgap_mask_ctrl,
>>> +					&rval->bg_ctrl);
>>> +		err |= omap_control_readl(cdev,	tsr->bgap_counter,
>>> +					&rval->bg_counter);
>>> +		err |= omap_control_readl(cdev, tsr->bgap_threshold,
>>> +					&rval->bg_threshold);
>>> +		err |= omap_control_readl(cdev, tsr->tshut_threshold,
>>> +					&rval->tshut_threshold);
>>> +
>>> +		if (err)
>>> +			dev_err(bg_ptr->dev, "could not save sensor %d\n", i);
>>> +	}
>>> +
>>> +	return err ? -EIO : 0;
>>> +}
>>> +
>>> +static int
>>> +omap_bandgap_force_single_read(struct omap_bandgap *bg_ptr, int id)
>>> +{
>>> +	struct device *cdev = bg_ptr->dev->parent;
>>> +	struct temp_sensor_registers *tsr;
>>> +	u32 temp = 0, counter = 1000;
>>> +	int err;
>>> +
>>> +	tsr = bg_ptr->pdata->sensors[id].registers;
>>> +	/* Select single conversion mode */
>>> +	err = omap_control_readl(cdev, tsr->bgap_mode_ctrl,&temp);
>>> +	temp&= ~(1<<   __ffs(tsr->mode_ctrl_mask));
>>> +	omap_control_writel(cdev, temp, tsr->bgap_mode_ctrl);
>>> +
>>> +	/* Start of Conversion = 1 */
>>> +	err |= omap_control_readl(cdev, tsr->temp_sensor_ctrl,&temp);
>>> +	temp |= 1<<   __ffs(tsr->bgap_soc_mask);
>>> +	omap_control_writel(cdev, temp, tsr->temp_sensor_ctrl);
>>> +	/* Wait until DTEMP is updated */
>>> +	err |= omap_control_readl(cdev, tsr->temp_sensor_ctrl,&temp);
>>> +	temp&= (tsr->bgap_dtemp_mask);
>>> +	while ((temp == 0)&&   --counter) {
>>> +		err |= omap_control_readl(cdev, tsr->temp_sensor_ctrl,&temp);
>>> +		temp&= (tsr->bgap_dtemp_mask);
>>> +	}
>>> +	/* Start of Conversion = 0 */
>>> +	err |= omap_control_readl(cdev, tsr->temp_sensor_ctrl,&temp);
>>> +	temp&= ~(1<<   __ffs(tsr->bgap_soc_mask));
>>> +	err |= omap_control_writel(cdev, temp, tsr->temp_sensor_ctrl);
>>> +
>>> +	return err ? -EIO : 0;
>>> +}
>>> +
>>> +static int omap_bandgap_restore_ctxt(struct omap_bandgap *bg_ptr)
>>> +{
>>> +	struct device *cdev = bg_ptr->dev->parent;
>>> +	int i, err = 0;
>>> +	u32 temp = 0;
>>> +
>>> +	for (i = 0; i<   bg_ptr->pdata->sensor_count; i++) {
>>> +		struct temp_sensor_registers *tsr;
>>> +		struct temp_sensor_regval *rval;
>>> +		u32 val;
>>> +
>>> +		rval = bg_ptr->pdata->sensors[i].regval;
>>> +		tsr = bg_ptr->pdata->sensors[i].registers;
>>> +
>>> +		err = omap_control_readl(cdev, tsr->bgap_counter,&val);
>>> +		if (val == 0) {
>>> +			err |= omap_control_writel(cdev, rval->bg_threshold,
>>> +						   tsr->bgap_threshold);
>>> +			err |= omap_control_writel(cdev, rval->tshut_threshold,
>>> +						   tsr->tshut_threshold);
>>> +			/* Force immediate temperature measurement and update
>>> +			 * of the DTEMP field
>>> +			 */
>>> +			omap_bandgap_force_single_read(bg_ptr, i);
>>> +			err |= omap_control_writel(cdev, rval->bg_counter,
>>> +						   tsr->bgap_counter);
>>> +			err |= omap_control_writel(cdev, rval->bg_mode_ctrl,
>>> +						   tsr->bgap_mode_ctrl);
>>> +			err |= omap_control_writel(cdev, rval->bg_ctrl,
>>> +						   tsr->bgap_mask_ctrl);
>>> +		} else {
>>> +			err |= omap_control_readl(cdev, tsr->temp_sensor_ctrl,
>>> +						&temp);
>>> +			temp&= (tsr->bgap_dtemp_mask);
>>> +			if (temp == 0) {
>>> +				omap_bandgap_force_single_read(bg_ptr, i);
>>> +				err |= omap_control_readl(cdev,
>>> +							  tsr->bgap_mask_ctrl,
>>> +							&temp);
>>> +				temp |= 1<<   __ffs(tsr->mode_ctrl_mask);
>>> +				err |= omap_control_writel(cdev, temp,
>>> +							   tsr->bgap_mask_ctrl);
>>> +			}
>>> +		}
>>> +		if (err)
>>> +			dev_err(bg_ptr->dev, "could not save sensor %d\n", i);
>>> +	}
>>> +
>>> +	return err ? -EIO : 0;
>>> +}
>>> +
>>> +static int omap_bandgap_suspend(struct device *dev)
>>> +{
>>> +	struct omap_bandgap *bg_ptr = dev_get_drvdata(dev);
>>> +	int err;
>>> +
>>> +	err = omap_bandgap_save_ctxt(bg_ptr);
>>> +	clk_disable(bg_ptr->fclock);
>>> +
>>> +	return err;
>>> +}
>>> +
>>> +static int omap_bandgap_resume(struct device *dev)
>>> +{
>>> +	struct omap_bandgap *bg_ptr = dev_get_drvdata(dev);
>>> +
>>> +	clk_enable(bg_ptr->fclock);
>>> +
>>> +	return omap_bandgap_restore_ctxt(bg_ptr);
>>> +}
>>> +static const struct dev_pm_ops omap_bandgap_dev_pm_ops = {
>>> +	SET_SYSTEM_SLEEP_PM_OPS(omap_bandgap_suspend,
>>> +				omap_bandgap_resume)
>>> +};
>>> +
>>> +#define DEV_PM_OPS	(&omap_bandgap_dev_pm_ops)
>>> +#else
>>> +#define DEV_PM_OPS	NULL
>>> +#endif
>>> +
>>> +static struct platform_driver omap_bandgap_sensor_driver = {
>>> +	.probe = omap_bandgap_probe,
>>> +	.remove = omap_bandgap_remove,
>>> +	.driver = {
>>> +			.name = "omap-bandgap",
>>> +			.pm = DEV_PM_OPS,
>>> +			.of_match_table	= of_omap_bandgap_match,
>>> +	},
>>> +};
>>> +
>>> +module_platform_driver(omap_bandgap_sensor_driver);
>>> +early_platform_init("early_omap_temperature",&omap_bandgap_sensor_driver);
>>> +
>>> +MODULE_DESCRIPTION("OMAP4+ bandgap temperature sensor driver");
>>> +MODULE_LICENSE("GPL v2");
>>> +MODULE_ALIAS("platform:omap-bandgap");
>>> +MODULE_AUTHOR("Texas Instrument Inc.");
>>> diff --git a/drivers/thermal/omap-bandgap.h b/drivers/thermal/omap-bandgap.h
>>> new file mode 100644
>>> index 0000000..12e0d6b
>>> --- /dev/null
>>> +++ b/drivers/thermal/omap-bandgap.h
>>> @@ -0,0 +1,63 @@
>>> +/*
>>> + * OMAP4 Bandgap temperature sensor driver
>>> + *
>>> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
>>> + * Contact:
>>> + *   Eduardo Valentin<eduardo.valentin@ti.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or
>>> + * modify it under the terms of the GNU General Public License
>>> + * version 2 as published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful, but
>>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>> + * General Public License for more details.
>>> + *
>>> + * You should have received a copy of the GNU General Public License
>>> + * along with this program; if not, write to the Free Software
>>> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>>> + * 02110-1301 USA
>>> + *
>>> + */
>>> +#ifndef __OMAP_BANDGAP_H
>>> +#define __OMAP_BANDGAP_H
>>> +
>>> +struct omap_bandgap_data;
>>> +
>>> +/**
>>> + * struct omap_bandgap - bandgap device structure
>>> + * @dev: device pointer
>>> + * @pdata: platform data with sensor data
>>> + * @fclock: pointer to functional clock of temperature sensor
>>> + * @div_clk: pointer to parent clock of temperature sensor fclk
>>> + * @conv_table: Pointer to adc to temperature conversion table
>>> + * @bg_mutex: Mutex for sysfs, irq and PM
>>> + * @irq: MPU Irq number for thermal alert
>>> + * @tshut_gpio: GPIO where Tshut signal is routed
>>> + * @clk_rate: Holds current clock rate
>>> + */
>>> +struct omap_bandgap {
>>> +	struct device			*dev;
>>> +	const struct omap_bandgap_data	*pdata;
>>> +	struct clk			*fclock;
>>> +	struct clk			*div_clk;
>>> +	const int			*conv_table;
>>> +	struct mutex			bg_mutex; /* Mutex for irq and PM */
>>> +	int				irq;
>>> +	int				tshut_gpio;
>>> +	u32				clk_rate;
>>> +};
>>> +
>>> +int omap_bandgap_read_thot(struct omap_bandgap *bg_ptr, int id, int *thot);
>>> +int omap_bandgap_write_thot(struct omap_bandgap *bg_ptr, int id, int val);
>>> +int omap_bandgap_read_tcold(struct omap_bandgap *bg_ptr, int id, int *tcold);
>>> +int omap_bandgap_write_tcold(struct omap_bandgap *bg_ptr, int id, int val);
>>> +int omap_bandgap_read_update_interval(struct omap_bandgap *bg_ptr, int id,
>>> +				      int *interval);
>>> +int omap_bandgap_write_update_interval(struct omap_bandgap *bg_ptr, int id,
>>> +				       u32 interval);
>>> +int omap_bandgap_read_temperature(struct omap_bandgap *bg_ptr, int id,
>>> +				  int *temperature);
>>> +
>>> +#endif
>>
>
> ---
> Eduardo
