From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v3 1/2] thermal: core: Allow orderly_poweroff to be called
 only once
Date: Fri, 14 Apr 2017 11:31:22 +0530
Message-ID: <34c86db1-daed-2e58-7c53-bcc49dafe29f@ti.com>
References: <1492147105-26692-1-git-send-email-j-keerthy@ti.com>
 <20170414060008.GA19715@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170414060008.GA19715@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org



On Friday 14 April 2017 11:30 AM, Eduardo Valentin wrote:
> On Fri, Apr 14, 2017 at 10:48:24AM +0530, Keerthy wrote:
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
>> Reported-by: Keerthy <j-keerthy@ti.com>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>
>> Changes in v3:
>>
>>   * Changed the place where mutex was locked and unlocked.
>>
>> Changes in v2:
>>
>>   * Added a global mutex to serialize poweroff code sequence.
>>
>>  drivers/thermal/thermal_core.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>> index 11f0675..9cad1ba 100644
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
> 
> I would prefer this to be closer to its lock. Can you please move this
> to the global section?

Sure. I can do that.

> 
>>  
>>  	tz->ops->get_trip_temp(tz, trip, &trip_temp);
>>  
>> @@ -342,7 +344,12 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
>>  		dev_emerg(&tz->device,
>>  			  "critical temperature reached(%d C),shutting down\n",
>>  			  tz->temperature / 1000);
>> -		orderly_poweroff(true);
>> +		mutex_lock(&poweroff_lock);
>> +		if (!power_off_triggered) {
>> +			orderly_poweroff(true);
>> +			power_off_triggered = true;
>> +		}
>> +		mutex_unlock(&poweroff_lock);
>>  	}
>>  }
>>  
>> @@ -1463,6 +1470,7 @@ static int __init thermal_init(void)
>>  {
>>  	int result;
>>  
>> +	mutex_init(&poweroff_lock);
>>  	result = thermal_register_governors();
>>  	if (result)
>>  		goto error;
>> @@ -1497,6 +1505,7 @@ static int __init thermal_init(void)
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
