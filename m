From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/2] Input: misc: introduce palmas-pwrbutton
Date: Tue, 19 Aug 2014 05:17:52 -0500
Message-ID: <53F32450.5070809@ti.com>
References: <1408392810-16011-1-git-send-email-nm@ti.com> <1408392810-16011-3-git-send-email-nm@ti.com> <20140819052344.GA21199@core.coreip.homeip.net>
Reply-To: nm@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140819052344.GA21199@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Dmitry
On 08/19/2014 12:23 AM, Dmitry Torokhov wrote:
Thanks for the review.

[...]
>> +
>> +/**
>> + * pwron_irq() - button press isr
>> + * @irq:		irq
>> + * @palmas_pwron:	pwron struct
>> + */
>> +static irqreturn_t pwron_irq(int irq, void *palmas_pwron)
>> +{
>> +	struct palmas_pwron *pwron = palmas_pwron;
>> +	struct input_dev *input_dev = pwron->input_dev;
>> +
>> +	cancel_delayed_work_sync(&pwron->input_work);
>> +
>> +	pwron->current_state = PALMAS_PWR_KEY_PRESS;
>> +
>> +	input_report_key(input_dev, KEY_POWER, pwron->current_state);
>> +	pm_wakeup_event(input_dev->dev.parent, 0);
>> +	input_sync(input_dev);
>> +
>> +	schedule_delayed_work(&pwron->input_work, 0);
>
> Instead of cancel/schedule use mod_delayed_work. BTW, why do you need to
> schedule immediately instead of waiting key_recheck_ms? Also, are there any

Good point, I had missed these. Will fix.

> concerns about need to debounce?

I believe PMIC already takes care of debounce, let me see if there are 
configuration registers possible. if yes, I think it might be nice to 
add in.

[...]

>> +
>> +	irq = platform_get_irq(pdev, 0);
>> +
>> +	device_init_wakeup(dev, 1);
>> +
>> +	ret = devm_request_threaded_irq(dev, irq, NULL, pwron_irq,
>> +					IRQF_TRIGGER_HIGH |
>> +					IRQF_TRIGGER_LOW,
>> +					dev_name(dev),
>> +					pwron);
>
> I am confused about this code sequence. Why do we get IRQ, then set up wakeup,
> and then request irq? Normally you get irq number, and then you request it, and
> then do other stuff.

Uggh.. right.. will fix.

>
>> +	if (ret < 0) {
>> +		dev_err(dev, "Can't get IRQ for pwron: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	enable_irq_wake(irq);
>
> Shouldn't this be in suspend callback?

yes, it should have been.. my bad.. :( thanks for catching it.

>> +
>> +	ret = input_register_device(input_dev);
>> +	if (ret) {
>> +		dev_dbg(dev, "Can't register power button: %d\n", ret);
>> +		goto out_irq_wake;
>> +	}
>> +	pwron->irq = irq;
>> +
>> +	pwron->key_recheck_ms = PALMAS_PWR_KEY_Q_TIME_MS;
>> +
>> +	platform_set_drvdata(pdev, pwron);
>> +
>> +	return 0;
>> +
>> +out_irq_wake:
>> +	disable_irq_wake(irq);
>> +
>> +	return ret;
>> +}
>> +
>> +static int palmas_pwron_remove(struct platform_device *pdev)
>> +{
>> +	struct palmas_pwron *pwron = platform_get_drvdata(pdev);
>> +
>> +	disable_irq_wake(pwron->irq);
>
> Should be in resume callback().

yep.

>
>> +	input_unregister_device(pwron->input_dev);
>
> With devm you do not need to unregister input device. However this has problem:
> what will happen if interrupt arrives here and we schedule workqueue? You need
> free interrupt then cancel work and then free input device. Similar needs to be
> done in probe(). I'd recommend not use devm_* here as you need to manually
> unwind anyway.

True. I will fix these as well.

>> +
>> +	return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +/**
>> + * palmas_pwron_suspend() - suspend handler
>> + * @dev:	power button device
>> + *
>> + * Cancel all pending work items for the power button
>> + */
>> +static int palmas_pwron_suspend(struct device *dev)
>> +{
>> +	struct platform_device *pdev = to_platform_device(dev);
>> +	struct palmas_pwron *pwron = platform_get_drvdata(pdev);
>> +
>> +	cancel_delayed_work_sync(&pwron->input_work);
>> +
>> +	return 0;
>> +}
>> +
>> +static UNIVERSAL_DEV_PM_OPS(palmas_pwron_pm, palmas_pwron_suspend, NULL, NULL);
>
> Why universal? Do they make sense for runtime pm?
>
>> +
>> +#else
>> +static UNIVERSAL_DEV_PM_OPS(palmas_pwron_pm, NULL, NULL, NULL);
>> +#endif
>
> You do not need to protect these with #ifdef and have 2 versions, just pull
> UNIVERSAL_DEV_PM_OPS (and change to SIMPLE_DEV_PM_OPS) out of #idef code.

I will just switch over to SIMPLE_DEV_PM_OPS here.. it is better here. 
Thanks for the suggestion.

>> +
>> +#ifdef CONFIG_OF
>> +static struct of_device_id of_palmas_pwr_match[] = {
>> +	{.compatible = "ti,palmas-pwrbutton"},
>> +	{},
>> +};
>> +
>> +MODULE_DEVICE_TABLE(of, of_palmas_pwr_match);
>> +#endif
>> +
>> +static struct platform_driver palmas_pwron_driver = {
>> +	.probe = palmas_pwron_probe,
>> +	.remove = palmas_pwron_remove,
>> +	.driver = {
>> +		   .name = "palmas_pwrbutton",
>> +		   .owner = THIS_MODULE,
>> +		   .of_match_table = of_match_ptr(of_palmas_pwr_match),
>> +		   .pm = &palmas_pwron_pm,
>> +		   },
>
> Weird indentation here.

Ugggh.. Lindent.. :(


---
Regards,
Nishanth Menon
