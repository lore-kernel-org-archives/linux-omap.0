From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v5 2/2] thermal: core: Add a back up thermal shutdown
 mechanism
Date: Tue, 18 Apr 2017 09:43:23 +0530
Message-ID: <b3b62178-d84d-2407-e447-83f0d9375ad8@ti.com>
References: <1492225709-30932-1-git-send-email-j-keerthy@ti.com>
 <1492225709-30932-2-git-send-email-j-keerthy@ti.com>
 <20170417171616.GA9889@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170417171616.GA9889@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org



On Monday 17 April 2017 10:46 PM, Eduardo Valentin wrote:
> On Sat, Apr 15, 2017 at 08:38:29AM +0530, Keerthy wrote:
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
>>
>> However, there is no clean way of detecting such failure of userspace
>> powering off the system. In such scenarios, it is necessary for a backup
>> workqueue to be able to force a shutdown of the system when orderly
>> shutdown is not successful after a configurable time period.
>>
>> Reported-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>
>> Changes in v5:
>>
>>   * Mandated delay for thermal emergency poweroff to be a non-zero value.
>>
>> Changes in v4:
>>
>>   * Updated documentation
>>   * changed emergency_poweroff_func to thermal_emergency_poweroff_func
>>
>> Changes in v3:
>>
>>   * Removed unnecessary mutex init.
>>   * Added WARN messages instead of a simple warning message.
>>   * Added Documentation.
>>
>>  Documentation/thermal/sysfs-api.txt | 21 +++++++++++++++
>>  drivers/thermal/Kconfig             | 15 +++++++++++
>>  drivers/thermal/thermal_core.c      | 53 +++++++++++++++++++++++++++++++++++++
>>  3 files changed, 89 insertions(+)
>>
>> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
>> index ef473dc..98dc04f 100644
>> --- a/Documentation/thermal/sysfs-api.txt
>> +++ b/Documentation/thermal/sysfs-api.txt
>> @@ -582,3 +582,24 @@ platform data is provided, this uses the step_wise throttling policy.
>>  This function serves as an arbitrator to set the state of a cooling
>>  device. It sets the cooling device to the deepest cooling state if
>>  possible.
>> +
>> +6. thermal_emergency_poweroff:
>> +
>> +On an event of critical trip temperature crossing. Thermal framework
>> +allows the system to shutdown gracefully by calling orderly_poweroff().
>> +In the event of a failure of orderly_poweroff() to shut down the system
>> +we are in danger of keeping the system alive at undesirably high
>> +temperatures. To mitigate this high risk scenario we program a work
>> +queue to fire after a pre-determined number of seconds to start
>> +an emergency shutdown of the device using the kernel_power_off()
>> +function. In case kernel_power_off() fails then finally
>> +emergency_restart() is called in the worst case.
>> +
>> +The delay should be carefully profiled so as to give adequate time for
>> +orderly_poweroff(). In case of failure of an orderly_poweroff() the
>> +emergency poweroff kicks in after the delay has elapsed and shuts down
>> +the system.
>> +
>> +If set to 0 emergency poweroff will not be supported. So a carefully
>> +profiled non-zero positive value is a must for emergerncy poweroff to be
>> +triggered.
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index 9347401..2a748a6 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -15,6 +15,21 @@ menuconfig THERMAL
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
>> +	  so as to give adequate time for orderly_poweroff(). In case
>> +	  of failure of an orderly_poweroff() the emergency poweroff
>> +	  kicks in after the delay has elapsed and shuts down the system.
>> +
>> +	  If set to 0 emergency poweroff will not be supported. So a carefully
>> +	  profiled non-zero positive value is a must for emergerncy poweroff to be
>> +	  triggered.
> 
> Here is a suggestion for rephrase the above:
> 
>  +	help
>  +	  Thermal subsystem will issue a graceful shutdown when
>  +	  critical temperatures are reached using orderly_poweroff(). In
>  +	  case of failure of an orderly_poweroff(), the thermal emergency poweroff
>  +	  kicks in after a delay has elapsed and shuts down the system.
>  +	  This config is number of milliseconds to delay before emergency
>  +	  poweroff kicks in. Similarly to the critical trip point,
>  +	  the delay should be carefully profiled so as to give adequate
>  +	  time for orderly_poweroff() to finish on regular execution.
>  +	  If set to 0 emergency poweroff will not be supported.
>  +
>  +	  In doubt, leave as 0.
> 

Okay.

>> +
>>  config THERMAL_HWMON
>>  	bool
>>  	prompt "Expose thermal sensors as hwmon device"
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>> index 8337c27..de1f7be 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -324,6 +324,54 @@ static void handle_non_critical_trips(struct thermal_zone_device *tz,
>>  		       def_governor->throttle(tz, trip);
>>  }
>>  
>> +/**
>> + * thermal_emergency_poweroff_func - emergency poweroff work after a known delay
>> + * @work: work_struct associated with the emergency poweroff function
>> + *
>> + * This function is called in very critical situations to force
>> + * a kernel poweroff after a configurable timeout value.
>> + */
>> +static void thermal_emergency_poweroff_func(struct work_struct *work)
>> +{
>> +	/*
>> +	 * We have reached here after the emergency thermal shutdown
>> +	 * Waiting period has expired. This means orderly_poweroff has
>> +	 * not been able to shut off the system for some reason.
>> +	 * Try to shut down the system immediately using kernel_power_off
>> +	 * if populated
>> +	 */
>> +	WARN(1, "Attempting kernel_power_off: Temperature too high\n");
>> +	kernel_power_off();
>> +
>> +	/*
>> +	 * Worst of the worst case trigger emergency restart
>> +	 */
>> +	WARN(1, "Attempting emergency_restart: Temperature too high\n");
>> +	emergency_restart();
>> +}
>> +
>> +static DECLARE_DELAYED_WORK(thermal_emergency_poweroff_work,
>> +			    thermal_emergency_poweroff_func);
>> +
>> +/**
>> + * thermal_emergency_poweroff - Trigger an emergency system poweroff
>> + *
>> + * This may be called from any critical situation to trigger a system shutdown
>> + * after a known period of time. By default the delay is 0 millisecond
>> + */
>> +void thermal_emergency_poweroff(void)
>> +{
>> +	int poweroff_delay_ms = CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS;
>> +	/*
>> +	 * poweroff_delay_ms must be a carefully profiled non-zero value.
>> +	 * Its a must for thermal_emergency_poweroff_work to be scheduled
>> +	 */
>> +	if (!poweroff_delay_ms)
> 
> This cannot be negative. I think it better suits here:
>  +	if (poweroff_delay_ms <= 0)

Sure. I will fix this.

> 
> Let's avoid hidden unsigned round up issues here.
> 
> Despite the above, you can add my
> Acked-by: Eduardo Valentin <edubezval@gmail.com>

Thanks. I will change this and post it in the v6.

> 
> BR,
> 
> Eduardo Valentin
> 
