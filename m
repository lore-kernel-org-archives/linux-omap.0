From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH] thermal: core: Allow orderly_poweroff to be called only
 once
Date: Thu, 13 Apr 2017 10:47:14 +0530
Message-ID: <df6eb3f3-a6ec-80ca-22a2-3456eca65443@ti.com>
References: <1491988332-13398-1-git-send-email-j-keerthy@ti.com>
 <20170413050637.GA7816@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170413050637.GA7816@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org



On Thursday 13 April 2017 10:36 AM, Eduardo Valentin wrote:
> Hey,
> 
> On Wed, Apr 12, 2017 at 02:42:12PM +0530, Keerthy wrote:
>> thermal_zone_device_check --> thermal_zone_device_update -->
>> handle_thermal_trip --> handle_critical_trips --> orderly_poweroff
>>
>> The above sequence happens every 250/500 mS based on the configuration.
>> The orderly_poweroff function is getting called every 250/500 mS.
>> With a full fledged file system it takes at least 5-10 Seconds to
>> power off gracefully.
>>
>> In that period due to the thermal_zone_device_check triggering
>> periodically the thermal work queues bombard with
>> orderly_poweroff calls multiple times eventually leading to
>> failures in gracefully powering off the system.
>>
>> Make sure that orderly_poweroff is called only once.
>>
>> Fixes: 0c01ebbfd3caf1d ("Thermal: Remove throttling logic out of thermal_sys.c")
> 
> Why? how the above commit introduced this issue?

git blame showed me that. I can remove this. Let me know if you have the
right commit that introduced this.

> 
>> Reported-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>  drivers/thermal/thermal_core.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>> index 11f0675..4e68ce0 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -326,6 +326,7 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
>>  				  int trip, enum thermal_trip_type trip_type)
>>  {
>>  	int trip_temp;
>> +	static bool power_off_triggered;
>>  
> 
> I am not convinced this change does what you say it does..
> 
>>  	tz->ops->get_trip_temp(tz, trip, &trip_temp);
>>  
>> @@ -338,11 +339,12 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
>>  	if (tz->ops->notify)
>>  		tz->ops->notify(tz, trip, trip_type);
>>  
>> -	if (trip_type == THERMAL_TRIP_CRITICAL) {
>> +	if (trip_type == THERMAL_TRIP_CRITICAL && !power_off_triggered) {
>>  		dev_emerg(&tz->device,
>>  			  "critical temperature reached(%d C),shutting down\n",
>>  			  tz->temperature / 1000);
>>  		orderly_poweroff(true);
> 
> Imagine you have two zones about to enter critical path. thermal zone 0
> first gets into critical, and at this line (btween orderly_poweroff()
> and you set your flag), it gets preempted. Then thermal zone 1 also
> enters the critical path, then happens to be scheduled, you essentially
> end up still calling orderly_poweroff() twice, which is what this patch
> is supposed to avoid.
> 
> You better simply use a lock to serialize code execution.

Okay understood. Will do it in the next version.

> 
> BR,
> 
>> +		power_off_triggered = true;
>>  	}
>>  }
>>  
>> -- 
>> 1.9.1
>>
