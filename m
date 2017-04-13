From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v2 1/2] thermal: core: Allow orderly_poweroff to be called
 only once
Date: Thu, 13 Apr 2017 23:00:42 +0530
Message-ID: <d5610630-689e-88cd-191d-710e628908d9@ti.com>
References: <1492070556-24660-1-git-send-email-j-keerthy@ti.com>
 <20170413151558.GA8412@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170413151558.GA8412@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org



On Thursday 13 April 2017 08:46 PM, Eduardo Valentin wrote:
> Hey,
> 
> On Thu, Apr 13, 2017 at 01:32:35PM +0530, Keerthy wrote:
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
>> Reported-by: Nishanth Menon <nm@ti.com>
> 
> Was this reported by nm or found by you?

Okay i found it when i was debugging the problem reported by nm :-).
I will fix that.

> 
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>
>> Changes in v2:
>>
>>   * Added a global mutex to serialize poweroff code sequence.
>>
>>  drivers/thermal/thermal_core.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>> index 11f0675..7462ae5 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -45,6 +45,7 @@
>>  
>>  static DEFINE_MUTEX(thermal_list_lock);
>>  static DEFINE_MUTEX(thermal_governor_lock);
>> +static DEFINE_MUTEX(poweroff_lock);
>>  
>>  static atomic_t in_suspend;
>>  
>> @@ -326,6 +327,7 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
>>  				  int trip, enum thermal_trip_type trip_type)
>>  {
>>  	int trip_temp;
>> +	static bool power_off_triggered;
>>  
>>  	tz->ops->get_trip_temp(tz, trip, &trip_temp);
>>  
>> @@ -338,11 +340,14 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
>>  	if (tz->ops->notify)
>>  		tz->ops->notify(tz, trip, trip_type);
>>  
>> -	if (trip_type == THERMAL_TRIP_CRITICAL) {
>> +	if (trip_type == THERMAL_TRIP_CRITICAL && !power_off_triggered) {
>>  		dev_emerg(&tz->device,
>>  			  "critical temperature reached(%d C),shutting down\n",
>>  			  tz->temperature / 1000);
>> +		mutex_lock(&poweroff_lock);
>>  		orderly_poweroff(true);
>> +		power_off_triggered = true;
>> +		mutex_unlock(&poweroff_lock);
> 
> The above code does not fully prevent orderly_poweroff() to be called
> only once, does it?
> 
> - thermal zone 0 goes all the way in the critical path, but gets
>   preempted between orderly_poweroff(true)l and power_off_triggered =
>   true;, i.e., preempted right before setting to true, therefore,
>   power_off_triggered still 0.
> - thermal zone 1 also enters critical path, but will sleep at the
>   power_off_lock, right?
> - then thermal zone 0 gets the CPU again, finishes the critical path,
>   unlocks poweroff_lock.
> - thermal zone 1 is unblocked, and call again orderly_poweroff(true);

Oh yes! I will fix that

if (trip_type == THERMAL_TRIP_CRITICAL) {

dev_emerg(&tz->device,
  			  "critical temperature reached(%d C),shutting
down\n",tz->temperature / 1000);

mutex_lock(&poweroff_lock);
if (!power_off_triggered) {
	orderly_poweroff(true);
	power_off_triggered = true;
}
mutex_unlock(&poweroff_lock);

}

The above should take care.
	
> 
> 
> 
> BR,
>>  	}
>>  }
>>  
>> @@ -1463,6 +1468,7 @@ static int __init thermal_init(void)
>>  {
>>  	int result;
>>  
>> +	mutex_init(&poweroff_lock);
>>  	result = thermal_register_governors();
>>  	if (result)
>>  		goto error;
>> @@ -1497,6 +1503,7 @@ static int __init thermal_init(void)
>>  	ida_destroy(&thermal_cdev_ida);
>>  	mutex_destroy(&thermal_list_lock);
>>  	mutex_destroy(&thermal_governor_lock);
>> +	mutex_destroy(&poweroff_lock);
>>  	return result;
>>  }
>>  
>> -- 
>> 1.9.1
>>
