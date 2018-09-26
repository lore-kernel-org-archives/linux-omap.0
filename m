From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 0/4] Update am437x and am335x dts to probe with ti-sysc
Date: Wed, 26 Sep 2018 16:36:59 -0500
Message-ID: <cfc3f1db-9468-ed92-a673-882b51b4dec8@ti.com>
References: <20180925000545.22931-1-tony@atomide.com>
 <e9afe736-c2f0-6182-afd0-08279e09a35e@ti.com>
 <20180925144021.GN5662@atomide.com> <20180925175537.GQ5662@atomide.com>
 <d98aa7c1-5131-34c5-51e5-c7ef57cbc31e@ti.com>
 <20180926155911.GT5662@atomide.com> <20180926162303.GU5662@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180926162303.GU5662@atomide.com>
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
To: Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>
Cc: devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Tero Kristo <t-kristo@ti.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On 09/26/2018 11:23 AM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [180926 16:04]:
>> * Keerthy <j-keerthy@ti.com> [180926 04:12]:
>>> So the below patch is solving the problem only for the first iteration
>>> but i see the problem recurring from second iteration of suspend.
>>>
>>> I tried the above cycle multiple times on am437x-gp-evm. I believe
>>> we are one step closer still not completely fixed.
>>
>> OK thanks, that's interesting, I'll take a look. Good to hear
>> that is the reason for pixcir issues though :)
> 
> Heh ooops the previous i2c-omap patch I posted does unpaired
> runtime_pm calls.. The put must be left out omap_i2c_resume().
> 
> Below is a better patch, seems to work for me multiple times
> now.
> 
> Regards,
> 
> Tony
> 
> 8< ---------------------------
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -208,6 +208,8 @@ struct omap_i2c_dev {
>   						 * if set, should be trsh+1
>   						 */
>   	u32			rev;
> +	unsigned int		is_suspended:1;
> +	unsigned int		needs_resume:1;
>   	unsigned		b_hw:1;		/* bad h/w fixes */
>   	unsigned		bb_valid:1;	/* true when BB-bit reflects
>   						 * the I2C bus state
> @@ -1498,8 +1500,7 @@ static int omap_i2c_remove(struct platform_device *pdev)
>   	return 0;
>   }
>   
> -#ifdef CONFIG_PM
> -static int omap_i2c_runtime_suspend(struct device *dev)
> +static int __maybe_unused omap_i2c_runtime_suspend(struct device *dev)
>   {
>   	struct omap_i2c_dev *omap = dev_get_drvdata(dev);
>   
> @@ -1521,11 +1522,12 @@ static int omap_i2c_runtime_suspend(struct device *dev)
>   	}
>   
>   	pinctrl_pm_select_sleep_state(dev);
> +	omap->is_suspended = true;
>   
>   	return 0;
>   }
>   
> -static int omap_i2c_runtime_resume(struct device *dev)
> +static int __maybe_unused omap_i2c_runtime_resume(struct device *dev)
>   {
>   	struct omap_i2c_dev *omap = dev_get_drvdata(dev);
>   
> @@ -1535,6 +1537,51 @@ static int omap_i2c_runtime_resume(struct device *dev)
>   		return 0;
>   
>   	__omap_i2c_init(omap);
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
> +	if (ddata->is_suspended)
> +		return 0;

Sry, but you can't do this. There is no sync between suspend and PM runtime.


> +
> +	/* Paired with call in omap_i2c_resume() */
> +	error = pm_runtime_put_sync_suspend(dev);

This is nop!!! More over, in general you can't predict how many times pm_runtime_get was called and
what's the current value of usage_count.

> +	if (error < 0) {
> +		dev_err(dev, "%s failed: %i\n", __func__, error);
> +
> +		return error;
> +	}
> +
> +	ddata->needs_resume = true;
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused omap_i2c_resume(struct device *dev)
> +{
> +	struct omap_i2c_dev *ddata = dev_get_drvdata(dev);
> +	int error;
> +
> +	if (!ddata->needs_resume)
> +		return 0;
> +
> +	/* Paired with call in omap_i2c_suspend() */
> +	error = pm_runtime_get_sync(dev);
> +	if (error < 0) {
> +		dev_err(dev, "%s failed: %i\n", __func__, error);
> +		pm_runtime_put_noidle(dev);
> +
> +		return error;
> +	}
> +
> +	ddata->needs_resume = false;
>   
>   	return 0;
>   }

To make things work the pm_runtime_force_xx() have to be used, or
like with omap_device, platform/bus code have to handle device state
at suspend_no_irq stage.

1) dev A :.suspend()  - device is in active state (PM runtime)
  - .suspend_noirq() - platform/bus/pm_domain - disable device and mark for resume
  - .resume_noirq() - platform/bus/pm_domain - enable device and clear mark 
  - .resume() - device in active state

2) dev A :.suspend() device is in suspended state and nothing to do
   .suspend_noirq() - platform/bus/pm_domain - nop
   .resume_noirq() - platform/bus/pm_domain - nop
   .resume() - device in suspended state. if smth need to be done - pm_runtime_get() have to be called

3) dev A :.suspend() device is in suspended state and dev A must be prepared for suspend
   -- pm_runtime_get()
   -- prepare dev A for suspend
  - .suspend_noirq() - platform/bus/pm_domain - disable device and mark for resume
  - .resume_noirq() - platform/bus/pm_domain - enable device and clear mark 
  - .resume() - device in active state. 
   -- resume dev A
   -- pm_runtime_put()

4)  dev A :.suspend() device is in suspended state and dev A must be prepared for suspend
   -- pm_runtime_get()
   -- prepare dev A for suspend
   -- pm_runtime_put() <-- dev will not be disabled just usage usage_count sync.

  - .suspend_noirq() - platform/bus/pm_domain - disable device and mark for resume
  - .resume_noirq() - platform/bus/pm_domain - enable device and clear mark 
  - .resume() - nothing to do
  - .complete() : device_complete()->pm_runtime_put() will disable device

-- 
regards,
-grygorii
