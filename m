From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH] thermal: core: Add a back up thermal shutdown mechanism
Date: Wed, 12 Apr 2017 08:19:19 +0530
Message-ID: <f64632d5-c780-e5fe-cff7-8ed1459348a0@ti.com>
References: <1490941820-13511-1-git-send-email-j-keerthy@ti.com>
 <20170411172918.GA5193@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170411172918.GA5193@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org



On Tuesday 11 April 2017 10:59 PM, Eduardo Valentin wrote:
> Hey,
> 
> On Fri, Mar 31, 2017 at 12:00:20PM +0530, Keerthy wrote:
>> orderly_poweroff is triggered when a graceful shutdown
>> of system is desired. This may be used in many critical states of the
>> kernel such as when subsystems detects conditions such as critical
>> temperature conditions. However, in certain conditions in system
>> boot up sequences like those in the middle of driver probes being
>> initiated, userspace will be unable to power off the system in a clean
>> manner and leaves the system in a critical state. In cases like these,
>> the /sbin/poweroff will return success (having forked off to attempt
>> powering off the system. However, the system overall will fail to
>> completely poweroff (since other modules will be probed) and the system
>> is still functional with no userspace (since that would have shut itself
>> off).
> 
> OK... This seams to me, still a corner case supposed to be fixed at
> orderly_power_off, not at thermal. But..
> 
>>
>> However, there is no clean way of detecting such failure of userspace
>> powering off the system. In such scenarios, it is necessary for a backup
>> workqueue to be able to force a shutdown of the system when orderly
>> shutdown is not successful after a configurable time period.
>>
> 
> Given that system running hot is a thermal issue, I guess we care more
> on this matter then..

Yes!

> 
>> Reported-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>  drivers/thermal/Kconfig        | 13 +++++++++++++
>>  drivers/thermal/thermal_core.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 55 insertions(+)
>>
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index 0a16cf4..4cc55f9 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -15,6 +15,19 @@ menuconfig THERMAL
>>  
>>  if THERMAL
>>  
>> +config THERMAL_EMERGENCY_POWEROFF_DELAY_MS
>> +	int "Emergency poweroff delay in milli-seconds"
>> +	depends on THERMAL
>> +	default 0
>> +	help
>> +	  The number of milliseconds to delay before emergency
>> +	  poweroff kicks in. The delay should be carefully profiled
>> +	  so as to give adequate time for orderly_poweroff. In case
>> +	  of failure of an orderly_poweroff the emergency poweroff
>> +	  kicks in after the delay has elapsed and shuts down the system.
>> +
>> +	  If set to 0 poweroff will happen immediately.
>> +
>>  config THERMAL_HWMON
>>  	bool
>>  	prompt "Expose thermal sensors as hwmon device"
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>> index 11f0675..dc7fdd4 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -322,6 +322,47 @@ static void handle_non_critical_trips(struct thermal_zone_device *tz,
>>  		       def_governor->throttle(tz, trip);
>>  }
>>  
>> +/**
>> + * emergency_poweroff_func - emergency poweroff work after a known delay
>> + * @work: work_struct associated with the emergency poweroff function
>> + *
>> + * This function is called in very critical situations to force
>> + * a kernel poweroff after a configurable timeout value.
>> + */
>> +static void emergency_poweroff_func(struct work_struct *work)
>> +{
>> +	/**
>> +	 * We have reached here after the emergency thermal shutdown
>> +	 * Waiting period has expired. This means orderly_poweroff has
>> +	 * not been able to shut off the system for some reason.
>> +	 * Try to shut down the system immediately using pm_power_off
>> +	 * if populated
>> +	 */
> 
> The above is not a kernel doc entry...

I will fix that.

> 
>> +	pr_warn("Attempting kernel_power_off\n");
>> +	if (pm_power_off)
>> +		pm_power_off();
> 
> Why not calling kernel_power_off() directly instead? That is what is called by orderly
> power off in case it fails, which seams to be  the missing part when
> user land returns success, and therefore we don't call
> kernel_power_off(). That path goes through the machine_power_off(),
> which seams to be the default for pm_power_off() anyway.
> 
> kernel_power_off() handles the power off system call too.

Yes. This is after orderly_poweroff fails so i felt why go through
kernel_power_off and directly call pm_power_off which directly pulls out
the power plug. This is in dire straits situation. Hence preferred to
call the last piece directly.

> 
>> +
>> +	/**
> 
> not a kernel doc entry...

Okay.

> 
>> +	 * Worst of the worst case trigger emergency restart
>> +	 */
>> +	pr_warn("kernel_power_off has failed! Attempting emergency_restart\n");
>> +	emergency_restart();
>> +}
>> +
>> +static DECLARE_DELAYED_WORK(emergency_poweroff_work, emergency_poweroff_func);
>> +
>> +/**
>> + * emergency_poweroff - Trigger an emergency system poweroff
>> + *
>> + * This may be called from any critical situation to trigger a system shutdown
>> + * after a known period of time. By default the delay is 0 millisecond
>> + */
>> +void thermal_emergency_poweroff(void)
>> +{
>> +	schedule_delayed_work(&emergency_poweroff_work,
>> +			      msecs_to_jiffies(CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS));
>> +}
>> +
>>  static void handle_critical_trips(struct thermal_zone_device *tz,
>>  				  int trip, enum thermal_trip_type trip_type)
>>  {
>> @@ -343,6 +384,7 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
>>  			  "critical temperature reached(%d C),shutting down\n",
>>  			  tz->temperature / 1000);
>>  		orderly_poweroff(true);
>> +		thermal_emergency_poweroff();
> 
> Shouldn't we start count the timeout before calling orderly_poweroff?

Okay yes. That makes more sense. Queue the emergency function, start the
countdown and immediately call the orderly_poweroff. I will fix the
above comments and send a v2. I still want to go with pm_power_off over
kernel_poweroff as we have already elapsed the time out and the first
thing we want is to shut off the SoC! Let me know.


> 
>>  	}
>>  }
>>  
>> -- 
>> 1.9.1
>>
