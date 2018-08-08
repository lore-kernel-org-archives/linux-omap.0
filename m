From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH] clocksource: ti-32k: Add CLOCK_SOURCE_SUSPEND_NONSTOP
 flag for non-am43 SoCs
Date: Wed, 8 Aug 2018 18:40:50 +0530
Message-ID: <0f6601d6-5b14-8d1f-65db-2b8b5a50397d@ti.com>
References: <1533633926-28908-1-git-send-email-j-keerthy@ti.com>
 <20180808065852.GO99251@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180808065852.GO99251@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: daniel.lezcano@linaro.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, baolin.wang@linaro.org, d-gerlach@ti.com, grygorii.strashko@ti.com, t-kristo@ti.com, Lokesh Vutla <lokeshvutla@ti.com>
List-Id: linux-omap@vger.kernel.org



On 8/8/2018 12:28 PM, Tony Lindgren wrote:
> * Keerthy <j-keerthy@ti.com> [180807 09:29]:
>> The 32k clocksource is NONSTOP for non-am43 SoCs. Hence
>> add the flag for all the other SoCs.
>>
>> Reported-by: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Thanks Tony. Lokesh pointed out about am43x-epos. So will make a minor 
correction to this patch with compatible. I searched all the am4 boards 
& seems like ti,am43 is the most generic compatible cover am43x-epos as 
well. So i will retain your ack and send a v2 with am43 compatible 
changed to a more generic ti,am43.

> 
>> ---
>>   drivers/clocksource/timer-ti-32k.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/clocksource/timer-ti-32k.c b/drivers/clocksource/timer-ti-32k.c
>> index 29e2e1a..dd09171 100644
>> --- a/drivers/clocksource/timer-ti-32k.c
>> +++ b/drivers/clocksource/timer-ti-32k.c
>> @@ -97,6 +97,9 @@ static int __init ti_32k_timer_init(struct device_node *np)
>>   		return -ENXIO;
>>   	}
>>   
>> +	if (!of_machine_is_compatible("ti,am4372"))
>> +		ti_32k_timer.cs.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
>> +
>>   	ti_32k_timer.counter = ti_32k_timer.base;
>>   
>>   	/*
>> -- 
>> 1.9.1
>>
