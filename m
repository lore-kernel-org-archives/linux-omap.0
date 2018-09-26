From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH 0/4] Update am437x and am335x dts to probe with ti-sysc
Date: Wed, 26 Sep 2018 09:38:12 +0530
Message-ID: <d98aa7c1-5131-34c5-51e5-c7ef57cbc31e@ti.com>
References: <20180925000545.22931-1-tony@atomide.com>
 <e9afe736-c2f0-6182-afd0-08279e09a35e@ti.com>
 <20180925144021.GN5662@atomide.com> <20180925175537.GQ5662@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180925175537.GQ5662@atomide.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Tero Kristo <t-kristo@ti.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On Tuesday 25 September 2018 11:25 PM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [180925 14:44]:
>> * Keerthy <j-keerthy@ti.com> [180925 05:18]:
>>> I tried Branch [1] above. AM335x-boneblack is doing all good with ds0.
>>> AM437x-gp the following is happening:
>>>
>>> https://pastebin.ubuntu.com/p/fmZNYgJ9Sp/
>>>
>>> There seems to be a timeout due to which resume is not immediate i see
>>> 1-2s delay and i see i2c timeout.
>>>
>>> [  402.247271] omap_i2c 4802a000.i2c: controller timed out
>>> [  402.247441] pixcir_ts 1-005c: pixcir_int_enable: can't read reg 0x34
>>> : -110
>>> [  402.247486] pixcir_ts 1-005c: Failed to disable interrupt generation:
>>> -110
>>> [  402.247522] pixcir_ts 1-005c: Failed to stop
>>> [  402.247607] dpm_run_callback(): pixcir_i2c_ts_resume+0x0/0x98
>>> [pixcir_i2c_ts] returns -110
>>>
>>> so pixcir_i2c_ts_resume is retuning -110 which is timeout error code.
>>>
>>> I did some touch screen testing after DS0 resume seems to be working.
>>> Everything is in pastebin link provided above.
>>
>> Thanks for testing. Hmm no idea what might be going on with
>> the pixcir. I have edt-ft5x06 on the am437x-sk-evm and that
>> behaves just fine for suspend and resume. Both are on i2c1,
>> pixcir calls pixcir_start/stop from suspend and resume while
>> edt-ft5x06 does not reconfigure anything.
>>
>> I'll try read some edt-ft5x06 register values on suspend
>> and resume, let's see if that makes it reproducable here.
> 
> So after adding a call to edt_ft5x06_ts_readwrite to
> edt_ft5x06_ts_resume I see -110 errors too. Looks like we
> have i2c-omap not idled for suspend because of autoidle if
> an i2c client reconfigures it's registers for suspend.
> 
> Care to test with the following patch applied? If that works
> for you, I'll send a proper patch for that.

https://pastebin.ubuntu.com/p/KKNDB6sCcD/

So the below patch is solving the problem only for the first iteration
but i see the problem recurring from second iteration of suspend.

I tried the above cycle multiple times on am437x-gp-evm. I believe
we are one step closer still not completely fixed.

> 
> Regards,
> 
> Tony
> 
> 8< -------------------
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -208,6 +208,8 @@ struct omap_i2c_dev {
>  						 * if set, should be trsh+1
>  						 */
>  	u32			rev;
> +	unsigned int		is_suspended:1;
> +	unsigned int		needs_resume:1;
>  	unsigned		b_hw:1;		/* bad h/w fixes */
>  	unsigned		bb_valid:1;	/* true when BB-bit reflects
>  						 * the I2C bus state
> @@ -1498,8 +1500,7 @@ static int omap_i2c_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM
> -static int omap_i2c_runtime_suspend(struct device *dev)
> +static int __maybe_unused omap_i2c_runtime_suspend(struct device *dev)
>  {
>  	struct omap_i2c_dev *omap = dev_get_drvdata(dev);
>  
> @@ -1521,11 +1522,12 @@ static int omap_i2c_runtime_suspend(struct device *dev)
>  	}
>  
>  	pinctrl_pm_select_sleep_state(dev);
> +	omap->is_suspended = true;
>  
>  	return 0;
>  }
>  
> -static int omap_i2c_runtime_resume(struct device *dev)
> +static int __maybe_unused omap_i2c_runtime_resume(struct device *dev)
>  {
>  	struct omap_i2c_dev *omap = dev_get_drvdata(dev);
>  
> @@ -1535,6 +1537,47 @@ static int omap_i2c_runtime_resume(struct device *dev)
>  		return 0;
>  
>  	__omap_i2c_init(omap);
> +	omap->is_suspended = false;
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused omap_i2c_suspend(struct device *dev)
> +{
> +	struct omap_i2c_dev *ddata = dev_get_drvdata(dev);
> +	int error;
> +
> +	/* Is device still enabled because of autosuspend? */
> +	if (!ddata->is_suspended) {
> +		error = pm_runtime_put_sync_suspend(dev);
> +		if (error < 0) {
> +			dev_err(dev, "%s failed: %i\n", __func__, error);
> +
> +			return error;
> +		}
> +		ddata->needs_resume = true;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused omap_i2c_resume(struct device *dev)
> +{
> +	struct omap_i2c_dev *ddata = dev_get_drvdata(dev);
> +	int error;
> +
> +	if (ddata->needs_resume) {
> +		error = pm_runtime_get_sync(dev);
> +		if (error < 0) {
> +			dev_err(dev, "%s failed: %i\n", __func__, error);
> +			pm_runtime_put_noidle(dev);
> +
> +			return error;
> +		}
> +		pm_runtime_mark_last_busy(dev);
> +		pm_runtime_put_autosuspend(dev);
> +		ddata->needs_resume = false;
> +	}
>  
>  	return 0;
>  }
> @@ -1542,18 +1585,15 @@ static int omap_i2c_runtime_resume(struct device *dev)
>  static const struct dev_pm_ops omap_i2c_pm_ops = {
>  	SET_RUNTIME_PM_OPS(omap_i2c_runtime_suspend,
>  			   omap_i2c_runtime_resume, NULL)
> +	SET_SYSTEM_SLEEP_PM_OPS(omap_i2c_suspend, omap_i2c_resume)
>  };
> -#define OMAP_I2C_PM_OPS (&omap_i2c_pm_ops)
> -#else
> -#define OMAP_I2C_PM_OPS NULL
> -#endif /* CONFIG_PM */
>  
>  static struct platform_driver omap_i2c_driver = {
>  	.probe		= omap_i2c_probe,
>  	.remove		= omap_i2c_remove,
>  	.driver		= {
>  		.name	= "omap_i2c",
> -		.pm	= OMAP_I2C_PM_OPS,
> +		.pm	= &omap_i2c_pm_ops,
>  		.of_match_table = of_match_ptr(omap_i2c_of_match),
>  	},
>  };
> 
