From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv4 2/3] Input: pwm-vibra: new driver
Date: Mon, 4 Sep 2017 12:16:39 -0700
Message-ID: <20170904191639.GA31131@dtor-ws>
References: <20170714100151.31234-1-sebastian.reichel@collabora.co.uk>
 <20170714100151.31234-3-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170714100151.31234-3-sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jul 14, 2017 at 12:01:50PM +0200, Sebastian Reichel wrote:
> Provide a simple driver for PWM controllable vibrators.
> It will be used by Motorola Droid 4.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>

Applied, thank you.

> ---
>  drivers/input/misc/Kconfig     |  12 ++
>  drivers/input/misc/Makefile    |   1 +
>  drivers/input/misc/pwm-vibra.c | 267 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 280 insertions(+)
>  create mode 100644 drivers/input/misc/pwm-vibra.c
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 3872488c3fd7..7bb7285c4722 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -581,6 +581,18 @@ config INPUT_PWM_BEEPER
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called pwm-beeper.
>  
> +config INPUT_PWM_VIBRA
> +	tristate "PWM vibrator support"
> +	depends on PWM
> +	depends on INPUT_FF_MEMLESS
> +	help
> +	  Say Y here to get support for PWM based vibrator devices.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called pwm-vibra.
> +
>  config INPUT_GPIO_ROTARY_ENCODER
>  	tristate "Rotary encoders connected to GPIO pins"
>  	depends on GPIOLIB || COMPILE_TEST
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index b923a9828c88..36ea14997b40 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -59,6 +59,7 @@ obj-$(CONFIG_INPUT_PM8XXX_VIBRATOR)	+= pm8xxx-vibrator.o
>  obj-$(CONFIG_INPUT_PMIC8XXX_PWRKEY)	+= pmic8xxx-pwrkey.o
>  obj-$(CONFIG_INPUT_POWERMATE)		+= powermate.o
>  obj-$(CONFIG_INPUT_PWM_BEEPER)		+= pwm-beeper.o
> +obj-$(CONFIG_INPUT_PWM_VIBRA)		+= pwm-vibra.o
>  obj-$(CONFIG_INPUT_RB532_BUTTON)	+= rb532_button.o
>  obj-$(CONFIG_INPUT_REGULATOR_HAPTIC)	+= regulator-haptic.o
>  obj-$(CONFIG_INPUT_RETU_PWRBUTTON)	+= retu-pwrbutton.o
> diff --git a/drivers/input/misc/pwm-vibra.c b/drivers/input/misc/pwm-vibra.c
> new file mode 100644
> index 000000000000..55da191ae550
> --- /dev/null
> +++ b/drivers/input/misc/pwm-vibra.c
> @@ -0,0 +1,267 @@
> +/*
> + *  PWM vibrator driver
> + *
> + *  Copyright (C) 2017 Collabora Ltd.
> + *
> + *  Based on previous work from:
> + *  Copyright (C) 2012 Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> + *
> + *  Based on PWM beeper driver:
> + *  Copyright (C) 2010, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
> + *
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under  the terms of the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the License, or (at your
> + *  option) any later version.
> + */
> +
> +#include <linux/input.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/pwm.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +
> +struct pwm_vibrator {
> +	struct input_dev *input;
> +	struct pwm_device *pwm;
> +	struct pwm_device *pwm_dir;
> +	struct regulator *vcc;
> +
> +	struct work_struct play_work;
> +	u16 level;
> +	u32 direction_duty_cycle;
> +};
> +
> +static int pwm_vibrator_start(struct pwm_vibrator *vibrator)
> +{
> +	struct device *pdev = vibrator->input->dev.parent;
> +	struct pwm_state state;
> +	int err;
> +
> +	err = regulator_enable(vibrator->vcc);
> +	if (err) {
> +		dev_err(pdev, "failed to enable regulator: %d", err);
> +		return err;
> +	}
> +
> +	pwm_get_state(vibrator->pwm, &state);
> +	pwm_set_relative_duty_cycle(&state, vibrator->level, 0xffff);
> +	state.enabled = true;
> +
> +	err = pwm_apply_state(vibrator->pwm, &state);
> +	if (err) {
> +		dev_err(pdev, "failed to apply pwm state: %d", err);
> +		return err;
> +	}
> +
> +	if (vibrator->pwm_dir) {
> +		pwm_get_state(vibrator->pwm_dir, &state);
> +		state.duty_cycle = vibrator->direction_duty_cycle;
> +		state.enabled = true;
> +
> +		err = pwm_apply_state(vibrator->pwm_dir, &state);
> +		if (err) {
> +			dev_err(pdev, "failed to apply dir-pwm state: %d", err);
> +			pwm_disable(vibrator->pwm);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void pwm_vibrator_stop(struct pwm_vibrator *vibrator)
> +{
> +	regulator_disable(vibrator->vcc);
> +
> +	if (vibrator->pwm_dir)
> +		pwm_disable(vibrator->pwm_dir);
> +	pwm_disable(vibrator->pwm);
> +}
> +
> +static void pwm_vibrator_play_work(struct work_struct *work)
> +{
> +	struct pwm_vibrator *vibrator = container_of(work,
> +					struct pwm_vibrator, play_work);
> +
> +	if (vibrator->level)
> +		pwm_vibrator_start(vibrator);
> +	else
> +		pwm_vibrator_stop(vibrator);
> +}
> +
> +static int pwm_vibrator_play_effect(struct input_dev *dev, void *data,
> +				    struct ff_effect *effect)
> +{
> +	struct pwm_vibrator *vibrator = input_get_drvdata(dev);
> +
> +	vibrator->level = effect->u.rumble.strong_magnitude;
> +	if (!vibrator->level)
> +		vibrator->level = effect->u.rumble.weak_magnitude;
> +
> +	schedule_work(&vibrator->play_work);
> +
> +	return 0;
> +}
> +
> +static void pwm_vibrator_close(struct input_dev *input)
> +{
> +	struct pwm_vibrator *vibrator = input_get_drvdata(input);
> +
> +	cancel_work_sync(&vibrator->play_work);
> +	pwm_vibrator_stop(vibrator);
> +}
> +
> +static int pwm_vibrator_probe(struct platform_device *pdev)
> +{
> +	struct pwm_vibrator *vibrator;
> +	struct pwm_state state;
> +	int err;
> +
> +	vibrator = devm_kzalloc(&pdev->dev, sizeof(*vibrator), GFP_KERNEL);
> +	if (!vibrator)
> +		return -ENOMEM;
> +
> +	vibrator->input = devm_input_allocate_device(&pdev->dev);
> +	if (!vibrator->input)
> +		return -ENOMEM;
> +
> +	vibrator->vcc = devm_regulator_get(&pdev->dev, "vcc");
> +	err = PTR_ERR_OR_ZERO(vibrator->vcc);
> +	if (err) {
> +		if (err != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "Failed to request regulator: %d",
> +				err);
> +		return err;
> +	}
> +
> +	vibrator->pwm = devm_pwm_get(&pdev->dev, "enable");
> +	err = PTR_ERR_OR_ZERO(vibrator->pwm);
> +	if (err) {
> +		if (err != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "Failed to request main pwm: %d",
> +				err);
> +		return err;
> +	}
> +
> +	INIT_WORK(&vibrator->play_work, pwm_vibrator_play_work);
> +
> +	/* Sync up PWM state and ensure it is off. */
> +	pwm_init_state(vibrator->pwm, &state);
> +	state.enabled = false;
> +	err = pwm_apply_state(vibrator->pwm, &state);
> +	if (err) {
> +		dev_err(&pdev->dev, "failed to apply initial PWM state: %d",
> +			err);
> +		return err;
> +	}
> +
> +	vibrator->pwm_dir = devm_pwm_get(&pdev->dev, "direction");
> +	err = PTR_ERR_OR_ZERO(vibrator->pwm_dir);
> +	switch (err) {
> +	case 0:
> +		/* Sync up PWM state and ensure it is off. */
> +		pwm_init_state(vibrator->pwm_dir, &state);
> +		state.enabled = false;
> +		err = pwm_apply_state(vibrator->pwm_dir, &state);
> +		if (err) {
> +			dev_err(&pdev->dev, "failed to apply initial PWM state: %d",
> +				err);
> +			return err;
> +		}
> +
> +		vibrator->direction_duty_cycle =
> +			pwm_get_period(vibrator->pwm_dir) / 2;
> +		device_property_read_u32(&pdev->dev, "direction-duty-cycle-ns",
> +					 &vibrator->direction_duty_cycle);
> +		break;
> +
> +	case -ENODATA:
> +		/* Direction PWM is optional */
> +		vibrator->pwm_dir = NULL;
> +		break;
> +
> +	default:
> +		dev_err(&pdev->dev, "Failed to request direction pwm: %d", err);
> +		/* Fall through */
> +
> +	case -EPROBE_DEFER:
> +		return err;
> +	}
> +
> +	vibrator->input->name = "pwm-vibrator";
> +	vibrator->input->id.bustype = BUS_HOST;
> +	vibrator->input->dev.parent = &pdev->dev;
> +	vibrator->input->close = pwm_vibrator_close;
> +
> +	input_set_drvdata(vibrator->input, vibrator);
> +	input_set_capability(vibrator->input, EV_FF, FF_RUMBLE);
> +
> +	err = input_ff_create_memless(vibrator->input, NULL,
> +				      pwm_vibrator_play_effect);
> +	if (err) {
> +		dev_err(&pdev->dev, "Couldn't create FF dev: %d", err);
> +		return err;
> +	}
> +
> +	err = input_register_device(vibrator->input);
> +	if (err) {
> +		dev_err(&pdev->dev, "Couldn't register input dev: %d", err);
> +		return err;
> +	}
> +
> +	platform_set_drvdata(pdev, vibrator);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused pwm_vibrator_suspend(struct device *dev)
> +{
> +	struct pwm_vibrator *vibrator = dev_get_drvdata(dev);
> +
> +	cancel_work_sync(&vibrator->play_work);
> +	if (vibrator->level)
> +		pwm_vibrator_stop(vibrator);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused pwm_vibrator_resume(struct device *dev)
> +{
> +	struct pwm_vibrator *vibrator = dev_get_drvdata(dev);
> +
> +	if (vibrator->level)
> +		pwm_vibrator_start(vibrator);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(pwm_vibrator_pm_ops,
> +			 pwm_vibrator_suspend, pwm_vibrator_resume);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id pwm_vibra_dt_match_table[] = {
> +	{ .compatible = "pwm-vibrator" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, pwm_vibra_dt_match_table);
> +#endif
> +
> +static struct platform_driver pwm_vibrator_driver = {
> +	.probe	= pwm_vibrator_probe,
> +	.driver	= {
> +		.name	= "pwm-vibrator",
> +		.pm	= &pwm_vibrator_pm_ops,
> +		.of_match_table = of_match_ptr(pwm_vibra_dt_match_table),
> +	},
> +};
> +module_platform_driver(pwm_vibrator_driver);
> +
> +MODULE_AUTHOR("Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>");
> +MODULE_DESCRIPTION("PWM vibrator driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:pwm-vibrator");
> -- 
> 2.13.2
> 

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
