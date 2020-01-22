From: Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH 3/4] thermal: devfreq_cooling: Refactor code and switch to
 use Energy Model
Date: Wed, 22 Jan 2020 09:35:36 +0000
Message-ID: <6c4c5ac6-2d80-694e-866b-21fe5ef1853f@arm.com>
References: <20200116152032.11301-1-lukasz.luba@arm.com>
 <20200116152032.11301-4-lukasz.luba@arm.com>
 <20200121121124.1a1f3175@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20200121121124.1a1f3175@gandalf.local.home>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-imx@nxp.com, Morten.Rasmussen@arm.com, Dietmar.Eggemann@arm.com, Chris.Redpath@arm.com, ionela.voinescu@arm.com, javi.merino@arm.com, cw00.choi@samsung.com, b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com, viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org, rui.zhang@intel.com, amit.kucheria@verdurent.com, daniel.lezcano@linaro.org, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, qperret@google.com, bsegall@google.com, mgorman@suse.de, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.c
List-Id: linux-omap@vger.kernel.org



On 1/21/20 5:11 PM, Steven Rostedt wrote:
> On Thu, 16 Jan 2020 15:20:31 +0000
> lukasz.luba@arm.com wrote:
> 
>> diff --git a/include/trace/events/thermal.h b/include/trace/events/thermal.h
>> index 135e5421f003..8a5f04888abd 100644
>> --- a/include/trace/events/thermal.h
>> +++ b/include/trace/events/thermal.h
>> @@ -153,31 +153,30 @@ TRACE_EVENT(thermal_power_cpu_limit,
>>   TRACE_EVENT(thermal_power_devfreq_get_power,
>>   	TP_PROTO(struct thermal_cooling_device *cdev,
>>   		 struct devfreq_dev_status *status, unsigned long freq,
>> -		u32 dynamic_power, u32 static_power, u32 power),
>> +		u32 power),
>>   
>> -	TP_ARGS(cdev, status,  freq, dynamic_power, static_power, power),
>> +	TP_ARGS(cdev, status,  freq, power),
>>   
>>   	TP_STRUCT__entry(
>>   		__string(type,         cdev->type    )
>>   		__field(unsigned long, freq          )
>> -		__field(u32,           load          )
>> -		__field(u32,           dynamic_power )
>> -		__field(u32,           static_power  )
>> +		__field(u32,           busy_time)
>> +		__field(u32,           total_time)
>>   		__field(u32,           power)
>>   	),
>>   
>>   	TP_fast_assign(
>>   		__assign_str(type, cdev->type);
>>   		__entry->freq = freq;
>> -		__entry->load = (100 * status->busy_time) / status->total_time;
>> -		__entry->dynamic_power = dynamic_power;
>> -		__entry->static_power = static_power;
>> +		__entry->busy_time = status->busy_time;
>> +		__entry->total_time = status->total_time;
>>   		__entry->power = power;
>>   	),
>>   
>> -	TP_printk("type=%s freq=%lu load=%u dynamic_power=%u static_power=%u power=%u",
>> +	TP_printk("type=%s freq=%lu load=%u power=%u",
>>   		__get_str(type), __entry->freq,
>> -		__entry->load, __entry->dynamic_power, __entry->static_power,
>> +		__entry->total_time == 0 ? 0 :
>> +			(100 * __entry->busy_time) / __entry->total_time,
>>   		__entry->power)
>>   );
>>   
> 
> Tracing updates look fine to me. Having the division on the output
> makes more sense.
> 
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org> # for tracing code
> 
> -- Steve
> 

Thank you Steven, I will include it in the next version with a proper
label.

Regards,
Lukasz
