From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v5 7/8] pwm: pwm-omap-dmtimer: Adapt driver to utilize
 dmtimer pdata ops
Date: Wed, 20 Dec 2017 10:12:25 +0530
Message-ID: <3df8c38f-cf73-098d-7ebe-ceab6c6eb9d1@ti.com>
References: <1513059137-21593-1-git-send-email-j-keerthy@ti.com>
 <1513059137-21593-8-git-send-email-j-keerthy@ti.com>
 <20171218093153.GA22729@lenoch> <e215a5e3-f729-1de4-2837-24c4a0120114@ti.com>
 <b780d238-91fa-035e-65dc-4e8ee607f6a7@ti.com>
 <a62814d7-f2d4-8740-92f5-114992ef5db1@ti.com> <20171219152140.GA22971@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <20171219152140.GA22971@lenoch>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: daniel.lezcano@linaro.org, tony@atomide.com, aaro.koskinen@iki.fi, thierry.reding@gmail.com, grygorii.strashko@ti.com, linux-omap@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, sebastian.reichel@collabora.co.uk, linux-kernel@vger.kernel.org, t-kristo@ti.com, linux@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org



On Tuesday 19 December 2017 08:51 PM, Ladislav Michl wrote:
> On Tue, Dec 19, 2017 at 01:55:48PM +0530, Keerthy wrote:
>> On Tuesday 19 December 2017 10:28 AM, Keerthy wrote:
>>> On Monday 18 December 2017 06:25 PM, Keerthy wrote:
>>>> On Monday 18 December 2017 03:01 PM, Ladislav Michl wrote:
>>>>> Keerthy,
>>>>>
>>>>> On Tue, Dec 12, 2017 at 11:42:16AM +0530, Keerthy wrote:
>>>>>> Adapt driver to utilize dmtimer pdata ops instead of pdata-quirks.
>>>>>>
>>>>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>>>>> ---
>>>>>>
>>>>>> Changes in v4:
>>>>>>
>>>>>>   * Switched to dev_get_platdata.
>>>>>
>>>>> Where do you expect dev.platform_data to be set? PWM driver is failing
>>>>> with:
>>>>> omap-dmtimer-pwm dmtimer-pwm: dmtimer pdata structure NULL
>>>>> omap-dmtimer-pwm: probe of dmtimer-pwm failed with error -22
>>>>>
>>>>> Which I fixed with patch bellow, to be able to test your patchset.
>>>>
>>>> Thanks! I will make the below patch part of my series.
>>>>
>>>>>
>>>>> Also I'm running a bit out of time, so I'll send few clean up
>>>>> patches and event capture code to get some feedback early.
>>>>>
>>>>> Regards,
>>>>> 	ladis
>>>>>
>>>>> diff --git a/drivers/clocksource/timer-dm.c b/drivers/clocksource/timer-dm.c
>>>>> index 39be39e6a8dd..d3d8a49cae0d 100644
>>>>> --- a/drivers/clocksource/timer-dm.c
>>>>> +++ b/drivers/clocksource/timer-dm.c
>>>>> @@ -773,6 +773,7 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
>>>>>  		dev_err(dev, "%s: no platform data.\n", __func__);
>>>>>  		return -ENODEV;
>>>>>  	}
>>>>> +	dev->platform_data = pdata;
>>>
>>> drivers/clocksource/timer-dm.c: In function 'omap_dm_timer_probe':
>>> drivers/clocksource/timer-dm.c:744:21: warning: assignment discards
>>> 'const' qualifier from pointer target type
>>>
>>> This cannot be done as we are assigning a const pointer to a non-const
>>> pointer.
> 
> Oh, I didn't even assume it as proper fix, just to show what is missing :)
> 
> But technically 'struct dmtimer_platform_data *pdata' is a constant which
> should not be changed. Also look how all that of_populate chain works -
> at the end const pointer is assigned to void* platform_data by simple
> (void *) overcast.
> 
>>> I will figure out a different way for this fix.
>>
>> Ladis,
>>
>> I fixed that:
>>
>> diff --git a/drivers/clocksource/timer-dm.c b/drivers/clocksource/timer-dm.c
>> index 1cbd954..e58f555 100644
>> --- a/drivers/clocksource/timer-dm.c
>> +++ b/drivers/clocksource/timer-dm.c
>> @@ -807,17 +807,21 @@ static int omap_dm_timer_probe(struct
>> platform_device *pdev)
>>         struct resource *mem, *irq;
>>         struct device *dev = &pdev->dev;
>>         const struct of_device_id *match;
>> -       const struct dmtimer_platform_data *pdata;
>> +       struct dmtimer_platform_data *pdata;
>>         int ret;
>>
>>         match = of_match_device(of_match_ptr(omap_timer_match), dev);
>> -       pdata = match ? match->data : dev->platform_data;
>> +       pdata = match ? (struct dmtimer_platform_data *)match->data :
>> +               dev->platform_data;
> 
> All that seems needlesly complicated, what about patch bellow?
> 
>>         if (!pdata && !dev->of_node) {
>>                 dev_err(dev, "%s: no platform data.\n", __func__);
>>                 return -ENODEV;
>>         }
>>
>> +       if (!dev->platform_data)
>> +               dev->platform_data = pdata;
> 
> Does the above condition bring us anything?

That was to avoid assigning the same thing.

> 
>>         irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>>         if (unlikely(!irq)) {
>>                 dev_err(dev, "%s: no IRQ resource.\n", __func__);
>> @@ -946,7 +950,7 @@ static int omap_dm_timer_remove(struct
>> platform_device *pdev)
>>         .write_status = omap_dm_timer_write_status,
>>  };
>>
>> -static const struct dmtimer_platform_data omap3plus_pdata = {
>> +static struct dmtimer_platform_data omap3plus_pdata = {
>>         .timer_errata = OMAP_TIMER_ERRATA_I103_I767,
>>         .timer_ops = &dmtimer_ops,
>>  };
>>
>> Can you check at your end if this works for you?
> 
> Note, it is untested as I ran out of time and will continue after New Year.
> 
> diff --git a/drivers/clocksource/timer-dm.c b/drivers/clocksource/timer-dm.c
> index 1cbd95420914..85024f11773a 100644
> --- a/drivers/clocksource/timer-dm.c
> +++ b/drivers/clocksource/timer-dm.c
> @@ -806,14 +806,16 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
>  	struct omap_dm_timer *timer;
>  	struct resource *mem, *irq;
>  	struct device *dev = &pdev->dev;
> -	const struct of_device_id *match;
>  	const struct dmtimer_platform_data *pdata;
>  	int ret;
>  
> -	match = of_match_device(of_match_ptr(omap_timer_match), dev);
> -	pdata = match ? match->data : dev->platform_data;
> +	pdata = of_device_get_match_data(dev);
> +	if (!pdata)
> +		pdata = dev_get_platdata(dev);
> +	else
> +		dev->platform_data = (void *) pdata;
>  
> -	if (!pdata && !dev->of_node) {
> +	if (!pdata) {
>  		dev_err(dev, "%s: no platform data.\n", __func__);
>  		return -ENODEV;
>  	}

Ladis,

I have tested this on AM437 for dmtimer only. But i have checked that
pdata gets neatly assigned to dev->platform_data. So i believe that was
what was lacking. I will pick the above patch from you and post v6 with
your Tested-by as the pdata hooking was the only missing link for pwm.

Thanks for the patch once again.

Regards,
Keerthy
> 
