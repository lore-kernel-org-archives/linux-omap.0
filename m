From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v6 08/10] pwm: pwm-omap-dmtimer: Adapt driver to utilize
 dmtimer pdata ops
Date: Mon, 8 Jan 2018 15:44:38 +0100
Message-ID: <3b52c42c-8283-c7b9-6f82-1187766faab1@baylibre.com>
References: <1514887799-24605-1-git-send-email-j-keerthy@ti.com>
 <1514887799-24605-9-git-send-email-j-keerthy@ti.com>
 <e9f73341-5262-0d9c-ecb8-f04f18d0bb05@microchip.com>
 <fd544471-63d0-dbf1-cee5-53f05c837cdd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fd544471-63d0-dbf1-cee5-53f05c837cdd@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>, Claudiu Beznea <Claudiu.Beznea@microchip.com>, daniel.lezcano@linaro.org, tony@atomide.com, aaro.koskinen@iki.fi, thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, ladis@linux-mips.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, t-kristo@ti.com, grygorii.strashko@ti.com, sebastian.reichel@collabora.co.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 08/01/2018 15:33, Keerthy wrote:
> 
> 
> On Monday 08 January 2018 02:14 PM, Claudiu Beznea wrote:
>>
>>
>> On 02.01.2018 12:09, Keerthy wrote:
>>> Adapt driver to utilize dmtimer pdata ops instead of pdata-quirks.
>>>
>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>> Tested-by: Ladislav Michl <ladis@linux-mips.org>
>>> ---
>>>  drivers/pwm/pwm-omap-dmtimer.c | 39 ++++++++++++++++++++++-----------------
>>>  1 file changed, 22 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
>>> index 5ad42f3..3b27aff 100644
>>> --- a/drivers/pwm/pwm-omap-dmtimer.c
>>> +++ b/drivers/pwm/pwm-omap-dmtimer.c
>>> @@ -23,6 +23,7 @@
>>>  #include <linux/mutex.h>
>>>  #include <linux/of.h>
>>>  #include <linux/of_platform.h>
>>> +#include <linux/platform_data/dmtimer-omap.h>
>>>  #include <linux/platform_data/pwm_omap_dmtimer.h>
>>>  #include <linux/platform_device.h>
>>>  #include <linux/pm_runtime.h>
>>> @@ -37,7 +38,7 @@ struct pwm_omap_dmtimer_chip {
>>>  	struct pwm_chip chip;
>>>  	struct mutex mutex;
>>>  	pwm_omap_dmtimer *dm_timer;
>>> -	struct pwm_omap_dmtimer_pdata *pdata;
>>> +	struct omap_dm_timer_ops *pdata;
>>>  	struct platform_device *dm_timer_pdev;
>>>  };
>>>  
>>> @@ -242,19 +243,33 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
>>>  {
>>>  	struct device_node *np = pdev->dev.of_node;
>>>  	struct device_node *timer;
>>> +	struct platform_device *timer_pdev;
>>>  	struct pwm_omap_dmtimer_chip *omap;
>>> -	struct pwm_omap_dmtimer_pdata *pdata;
>>> +	struct dmtimer_platform_data *timer_pdata;
>>> +	struct omap_dm_timer_ops *pdata;
>>>  	pwm_omap_dmtimer *dm_timer;
>>>  	u32 v;
>>>  	int status;
>>>  
>>> -	pdata = dev_get_platdata(&pdev->dev);
>>> -	if (!pdata) {
>>> -		dev_err(&pdev->dev, "Missing dmtimer platform data\n");
>>> +	timer = of_parse_phandle(np, "ti,timers", 0);
>> of_node_put() should be called when done with device_node pointer returned
>> by of_parse_phandle() (you may want to check the return ERROR cases below
>> regarding this statement):
>>> +	if (!timer)
>>> +		return -ENODEV;
>>> +
>>> +	timer_pdev = of_find_device_by_node(timer);
>>> +	if (!timer_pdev) {
>>> +		dev_err(&pdev->dev, "Unable to find Timer pdev\n");
>> here
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	timer_pdata = dev_get_platdata(&timer_pdev->dev);
>>> +	if (!timer_pdata) {
>>> +		dev_err(&pdev->dev, "dmtimer pdata structure NULL\n");
>> here
>>>  		return -EINVAL;
>>>  	}
>>>  
>>> -	if (!pdata->request_by_node ||
>>> +	pdata = timer_pdata->timer_ops;
>>> +
>>> +	if (!pdata || !pdata->request_by_node ||
>>>  	    !pdata->free ||
>>>  	    !pdata->enable ||
>>>  	    !pdata->disable ||
>>> @@ -270,10 +285,6 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
>>>  		return -EINVAL;
>>>  	}
>>>  
>>> -	timer = of_parse_phandle(np, "ti,timers", 0);
>>> -	if (!timer)
>>> -		return -ENODEV;
>>> -
>>>  	if (!of_get_property(timer, "ti,timer-pwm", NULL)) {
>> here
>>>  		dev_err(&pdev->dev, "Missing ti,timer-pwm capability\n");
>>>  		return -ENODEV;
>>> @@ -291,13 +302,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
>>>  
>>>  	omap->pdata = pdata;
>>>  	omap->dm_timer = dm_timer;
>>> -
>>> -	omap->dm_timer_pdev = of_find_device_by_node(timer);
>>> -	if (!omap->dm_timer_pdev) {
>>> -		dev_err(&pdev->dev, "Unable to find timer pdev\n");
>>> -		omap->pdata->free(dm_timer);
>>> -		return -EINVAL;
>>> -	}
>>> +	omap->dm_timer_pdev = timer_pdev;
>>>  
>>>  	/*
>>>  	 * Ensure that the timer is stopped before we allow PWM core to call
>>>
>> And all the other return instructions from probe function not listed by git diff
> 
> Thanks for reviewing. I will add the of_node_put call for all the error
> paths.
> 
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

Apart the missing of_node_put() :

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
