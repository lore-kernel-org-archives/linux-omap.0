From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 0/4] Update am437x and am335x dts to probe with ti-sysc
Date: Thu, 27 Sep 2018 14:11:44 -0500
Message-ID: <033a9b5f-c7cb-f2dd-31b4-3f178d74b79b@ti.com>
References: <20180925000545.22931-1-tony@atomide.com>
 <e9afe736-c2f0-6182-afd0-08279e09a35e@ti.com>
 <20180925144021.GN5662@atomide.com> <20180925175537.GQ5662@atomide.com>
 <d98aa7c1-5131-34c5-51e5-c7ef57cbc31e@ti.com>
 <20180926155911.GT5662@atomide.com> <20180926162303.GU5662@atomide.com>
 <cfc3f1db-9468-ed92-a673-882b51b4dec8@ti.com>
 <20180926233111.GY5662@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180926233111.GY5662@atomide.com>
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
Cc: devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On 09/26/2018 06:31 PM, Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko@ti.com> [180926 21:41]:
>> On 09/26/2018 11:23 AM, Tony Lindgren wrote:
>>> +static int __maybe_unused omap_i2c_suspend(struct device *dev)
>>> +{
>>> +	struct omap_i2c_dev *ddata = dev_get_drvdata(dev);
>>> +	int error;
>>> +
>>> +	/* Is device still enabled because of autosuspend? */
>>> +	if (ddata->is_suspended)
>>> +		return 0;
>>
>> Sry, but you can't do this. There is no sync between suspend and PM runtime.
>>
>>
>>> +
>>> +	/* Paired with call in omap_i2c_resume() */
>>> +	error = pm_runtime_put_sync_suspend(dev);
>>
>> This is nop!!! More over, in general you can't predict how many times pm_runtime_get was called and
>> what's the current value of usage_count.
> 
> Hmm yeah that's a good point.
> 
>> To make things work the pm_runtime_force_xx() have to be used, or
>> like with omap_device, platform/bus code have to handle device state
>> at suspend_no_irq stage.
> 
> OK. So looks like the other i2c bus drivers have already solved it
> with simply SET_NOIRQ_SYSTEM_SLEEP_PM_OPS which is along the lines
> you're suggesting.
> 
> The following works for me, does it look OK to you?
> 

it looks good, just curious if it will work both ti-sysc legacy/nonlegacy modes.

> 
> 8< ---------------------
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1498,8 +1498,7 @@ static int omap_i2c_remove(struct platform_device *pdev)
>   	return 0;
>   }
>   
> -#ifdef CONFIG_PM
> -static int omap_i2c_runtime_suspend(struct device *dev)
> +static int __maybe_unused omap_i2c_runtime_suspend(struct device *dev)
>   {
>   	struct omap_i2c_dev *omap = dev_get_drvdata(dev);
>   
> @@ -1525,7 +1524,7 @@ static int omap_i2c_runtime_suspend(struct device *dev)
>   	return 0;
>   }
>   
> -static int omap_i2c_runtime_resume(struct device *dev)
> +static int __maybe_unused omap_i2c_runtime_resume(struct device *dev)
>   {
>   	struct omap_i2c_dev *omap = dev_get_drvdata(dev);
>   
> @@ -1540,20 +1539,18 @@ static int omap_i2c_runtime_resume(struct device *dev)
>   }
>   
>   static const struct dev_pm_ops omap_i2c_pm_ops = {
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				      pm_runtime_force_resume)
>   	SET_RUNTIME_PM_OPS(omap_i2c_runtime_suspend,
>   			   omap_i2c_runtime_resume, NULL)
>   };
> -#define OMAP_I2C_PM_OPS (&omap_i2c_pm_ops)
> -#else
> -#define OMAP_I2C_PM_OPS NULL
> -#endif /* CONFIG_PM */
>   
>   static struct platform_driver omap_i2c_driver = {
>   	.probe		= omap_i2c_probe,
>   	.remove		= omap_i2c_remove,
>   	.driver		= {
>   		.name	= "omap_i2c",
> -		.pm	= OMAP_I2C_PM_OPS,
> +		.pm	= &omap_i2c_pm_ops,
>   		.of_match_table = of_match_ptr(omap_i2c_of_match),
>   	},
>   };
> 

-- 
regards,
-grygorii
