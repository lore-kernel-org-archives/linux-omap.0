From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v8 8/9] pwm: pwm-omap-dmtimer: Adapt driver to utilize
 dmtimer pdata ops
Date: Wed, 24 Jan 2018 13:58:19 +0530
Message-ID: <e90aed55-e8db-e849-0e07-cbeb453b583c@ti.com>
References: <1516772680-28256-1-git-send-email-j-keerthy@ti.com>
 <20180124072432.GA11294@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180124072432.GA11294@lenoch>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: daniel.lezcano@linaro.org, thierry.reding@gmail.com, tony@atomide.com, aaro.koskinen@iki.fi, Claudiu.Beznea@microchip.com, narmstrong@baylibre.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sebastian.reichel@collabora.co.uk, linux-omap@vger.kernel.org, robh+dt@kernel.org, t-kristo@ti.com, grygorii.strashko@ti.com
List-Id: linux-omap@vger.kernel.org



On Wednesday 24 January 2018 12:54 PM, Ladislav Michl wrote:
> Keerthy,
> 
> On Wed, Jan 24, 2018 at 11:14:40AM +0530, Keerthy wrote:
>> Adapt driver to utilize dmtimer pdata ops instead of pdata-quirks.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
>> Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>> ---
>>
>> Changes in v8:
>>
>>   * Added of_node_put call in success case of probe.
>>
>> Boot tested on am437x-gp-evm and dra7xx-evm.
>> Also compile tested omap1_defconfig with other patches of v7
>> posted here:
>>
>> https://www.spinics.net/lists/linux-omap/msg141100.html
>>
>> With v8 version of Patch 8/9.
>>
>>  drivers/pwm/pwm-omap-dmtimer.c | 68 ++++++++++++++++++++++++++----------------
>>  1 file changed, 42 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
>> index 5ad42f3..c00e474 100644
>> --- a/drivers/pwm/pwm-omap-dmtimer.c
>> +++ b/drivers/pwm/pwm-omap-dmtimer.c
>> @@ -23,6 +23,7 @@
>>  #include <linux/mutex.h>
>>  #include <linux/of.h>
>>  #include <linux/of_platform.h>
>> +#include <linux/platform_data/dmtimer-omap.h>
>>  #include <linux/platform_data/pwm_omap_dmtimer.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/pm_runtime.h>
>> @@ -37,7 +38,7 @@ struct pwm_omap_dmtimer_chip {
>>  	struct pwm_chip chip;
>>  	struct mutex mutex;
>>  	pwm_omap_dmtimer *dm_timer;
>> -	struct pwm_omap_dmtimer_pdata *pdata;
>> +	struct omap_dm_timer_ops *pdata;
>>  	struct platform_device *dm_timer_pdev;
>>  };
>>  
>> @@ -242,19 +243,35 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
>>  {
>>  	struct device_node *np = pdev->dev.of_node;
>>  	struct device_node *timer;
>> +	struct platform_device *timer_pdev;
>>  	struct pwm_omap_dmtimer_chip *omap;
>> -	struct pwm_omap_dmtimer_pdata *pdata;
>> +	struct dmtimer_platform_data *timer_pdata;
>> +	struct omap_dm_timer_ops *pdata;
>>  	pwm_omap_dmtimer *dm_timer;
>>  	u32 v;
>> -	int status;
>> +	int status, ret = 0;
>>  
>> -	pdata = dev_get_platdata(&pdev->dev);
>> -	if (!pdata) {
>> -		dev_err(&pdev->dev, "Missing dmtimer platform data\n");
>> -		return -EINVAL;
>> +	timer = of_parse_phandle(np, "ti,timers", 0);
>> +	if (!timer)
>> +		return -ENODEV;
>> +
>> +	timer_pdev = of_find_device_by_node(timer);
>> +	if (!timer_pdev) {
>> +		dev_err(&pdev->dev, "Unable to find Timer pdev\n");
>> +		ret = -ENODEV;
>> +		goto put;
>>  	}
>>  
>> -	if (!pdata->request_by_node ||
>> +	timer_pdata = dev_get_platdata(&timer_pdev->dev);
>> +	if (!timer_pdata) {
>> +		dev_err(&pdev->dev, "dmtimer pdata structure NULL\n");
>> +		ret = -EINVAL;
>> +		goto put;
>> +	}
>> +
>> +	pdata = timer_pdata->timer_ops;
>> +
>> +	if (!pdata || !pdata->request_by_node ||
>>  	    !pdata->free ||
>>  	    !pdata->enable ||
>>  	    !pdata->disable ||
>> @@ -267,37 +284,32 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
>>  	    !pdata->set_prescaler ||
>>  	    !pdata->write_counter) {
>>  		dev_err(&pdev->dev, "Incomplete dmtimer pdata structure\n");
>> -		return -EINVAL;
>> +		ret = -EINVAL;
>> +		goto put;
>>  	}
>>  
>> -	timer = of_parse_phandle(np, "ti,timers", 0);
>> -	if (!timer)
>> -		return -ENODEV;
>> -
>>  	if (!of_get_property(timer, "ti,timer-pwm", NULL)) {
>>  		dev_err(&pdev->dev, "Missing ti,timer-pwm capability\n");
>> -		return -ENODEV;
>> +		ret = -ENODEV;
>> +		goto put;
> 
> Should we call of_node_put() even from here? of_get_property() failed, so
> reference was not updated.

The of_node_put to balance the of_parse_handle called for timer. I hope
that is what you wanted to check right?

> 
>>  	}
>>  
>>  	dm_timer = pdata->request_by_node(timer);
> 
> And timer seems to be used only here, so calling
> 	of_node_put(timer);
> just here should be enough.

Okay yes. This can be optimized. of_node_put(timer); can be called
here and the instances below need not have that additional step.

> 
>> -	if (!dm_timer)
>> -		return -EPROBE_DEFER;
>> +	if (!dm_timer) {
>> +		ret = -EPROBE_DEFER;
>> +		goto put;
>> +	}
>>  
>>  	omap = devm_kzalloc(&pdev->dev, sizeof(*omap), GFP_KERNEL);
>>  	if (!omap) {
>>  		pdata->free(dm_timer);
>> -		return -ENOMEM;
>> +		ret = -ENOMEM;
>> +		goto put;
>>  	}
>>  
>>  	omap->pdata = pdata;
>>  	omap->dm_timer = dm_timer;
>> -
>> -	omap->dm_timer_pdev = of_find_device_by_node(timer);
>> -	if (!omap->dm_timer_pdev) {
>> -		dev_err(&pdev->dev, "Unable to find timer pdev\n");
>> -		omap->pdata->free(dm_timer);
>> -		return -EINVAL;
>> -	}
>> +	omap->dm_timer_pdev = timer_pdev;
>>  
>>  	/*
>>  	 * Ensure that the timer is stopped before we allow PWM core to call
>> @@ -326,12 +338,16 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
>>  	if (status < 0) {
>>  		dev_err(&pdev->dev, "failed to register PWM\n");
>>  		omap->pdata->free(omap->dm_timer);
>> -		return status;
>> +		ret = status;
>> +		goto put;
>>  	}
>>  
>>  	platform_set_drvdata(pdev, omap);
>>  
>> -	return 0;
>> +put:
>> +	of_node_put(timer);
>> +
>> +	return ret;
>>  }
>>  
>>  static int pwm_omap_dmtimer_remove(struct platform_device *pdev)
>> -- 
>> 1.9.1
