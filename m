From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH] thermal: of-thermal: Fix setting of set_emul_temp hook
Date: Mon, 27 Jun 2016 11:48:03 +0530
Message-ID: <5770C51B.30505@ti.com>
References: <1464857690-23330-1-git-send-email-j-keerthy@ti.com>
 <575A5DD0.4080208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <575A5DD0.4080208@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>, edubezval@gmail.com, rui.zhang@intel.com
Cc: nm@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On Friday 10 June 2016 11:57 AM, Keerthy wrote:
>
>
> On Thursday 02 June 2016 02:24 PM, Keerthy wrote:
>> Currently thermal zone set_emul_temp is set unconditionally
>> with of_thermal_set_emul_temp function. Set this only if the
>> set_emul_temp hook is provided for thermal_zone_of_device_ops.
>>
>> This fixes emul_temp failures on platforms for which set_emul_temp
>> hook is not populated.
>
> Eduardo,
>
> A gentle ping on this patch.

Eduardo,

Another gentle ping.


>
>
>>
>> Fixes: "184a4bf623f (thermal: of: Extend current
>>     of-thermal.c code to allow setting emulated temp)"
>> Suggested-by: Eduardo Valentin <edubezval@gmail.com>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>   drivers/thermal/of-thermal.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
>> index b8e509c..93d8ce0 100644
>> --- a/drivers/thermal/of-thermal.c
>> +++ b/drivers/thermal/of-thermal.c
>> @@ -181,9 +181,6 @@ static int of_thermal_set_emul_temp(struct
>> thermal_zone_device *tz,
>>   {
>>       struct __thermal_zone *data = tz->devdata;
>>
>> -    if (!data->ops || !data->ops->set_emul_temp)
>> -        return -EINVAL;
>> -
>>       return data->ops->set_emul_temp(data->sensor_data, temp);
>>   }
>>
>> @@ -427,7 +424,9 @@ thermal_zone_of_add_sensor(struct device_node *zone,
>>
>>       tzd->ops->get_temp = of_thermal_get_temp;
>>       tzd->ops->get_trend = of_thermal_get_trend;
>> -    tzd->ops->set_emul_temp = of_thermal_set_emul_temp;
>> +    if (ops->set_emul_temp)
>> +        tzd->ops->set_emul_temp = of_thermal_set_emul_temp;
>> +
>>       mutex_unlock(&tzd->lock);
>>
>>       return tzd;
>>
