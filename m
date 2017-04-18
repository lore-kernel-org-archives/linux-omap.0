From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v6 2/2] thermal: core: Add a back up thermal shutdown
 mechanism
Date: Tue, 18 Apr 2017 11:48:23 +0530
Message-ID: <0e342d5e-41d3-cfa9-03de-dde31fedab10@ti.com>
References: <1492489799-6452-1-git-send-email-j-keerthy@ti.com>
 <1492489799-6452-2-git-send-email-j-keerthy@ti.com>
 <3956aded-4a12-0841-9697-eafb74c983bc@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <3956aded-4a12-0841-9697-eafb74c983bc@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ravikumar <rk@ti.com>, rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org



On Tuesday 18 April 2017 11:45 AM, Ravikumar wrote:
> 
> 
> On Tuesday 18 April 2017 09:59 AM, Keerthy wrote:
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
> Care to add testing information?

I used THERMAL_EMULATION to fake temperature more than trip point.
If the delay is lesser (< 20S) then i see that backup poweroff is called
and the system shuts down immediately after the delay time expires else
orderly_poweroff gracefully shuts off the system. I do not have the logs
right now.

>> Reported-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> Acked-by: Eduardo Valentin <edubezval@gmail.com>
>> ---
>>
>> Changes in v6:
>>
>>    * Rephrased Kconfig description as per Eduardo's feedback.
>>    * Added check to verify positive values of delay in milli Seconds.
>>
>> Changes in v5:
>>
>>    * Mandated delay for thermal emergency poweroff to be a non-zero
>> value.
>>
>> Changes in v4:
>>
>>    * Updated documentation
>>    * changed emergency_poweroff_func to thermal_emergency_poweroff_func
>>
>> Changes in v3:
>>
>>    * Removed unnecessary mutex init.
>>    * Added WARN messages instead of a simple warning message.
>>    * Added Documentation.
>>
>>   Documentation/thermal/sysfs-api.txt | 21 +++++++++++++++
>>   drivers/thermal/Kconfig             | 17 ++++++++++++
>>   drivers/thermal/thermal_core.c      | 53
>> +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 91 insertions(+)
>>
>> diff --git a/Documentation/thermal/sysfs-api.txt
>> b/Documentation/thermal/sysfs-api.txt
>> index ef473dc..bb9a0a5 100644
>> --- a/Documentation/thermal/sysfs-api.txt
>> +++ b/Documentation/thermal/sysfs-api.txt
>> @@ -582,3 +582,24 @@ platform data is provided, this uses the
>> step_wise throttling policy.
>>   This function serves as an arbitrator to set the state of a cooling
>>   device. It sets the cooling device to the deepest cooling state if
>>   possible.
>> +
>> +6. thermal_emergency_poweroff:
>> +
> Should this be in sysfs-api doc?
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
> In order to come up with an ideal delay, we need to strike a balance
> between
> being paranoid vs being too late.
> In a different patch, I tried to justify setting crit temp @120C by quoting
> we need to give some time to orderly_poweroff()
> 
> So we got T = [3/temp change rate] seconds before the HW issues a reset.
> 
> within this T sec we need to give a chance to orderly_poweroff() and
> when it
> fails, bring out the big weapons.
> 
> crumb: we might actually be increasing the "temp rate change" by doing a
> lot of IO
> access for syncing.
> Let us hope someone is trying to cool the system down while we are
> trying to
> save the day..
>> +If set to 0 emergency poweroff will not be supported. So a carefully
>> +profiled non-zero positive value is a must for emergerncy poweroff to be
>> +triggered.
> Profiling should be done based on real data than emulation.
> That's when we get to know if the memory and IOs listen to the SoC
> when the lava is out.
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index 9347401..74bf92b 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -15,6 +15,23 @@ menuconfig THERMAL
>>     if THERMAL
>>   +config THERMAL_EMERGENCY_POWEROFF_DELAY_MS
>> +    int "Emergency poweroff delay in milli-seconds"
>> +    depends on THERMAL
>> +    default 0
>> +    help
>> +      Thermal subsystem will issue a graceful shutdown when
>> +      critical temperatures are reached using orderly_poweroff(). In
>> +      case of failure of an orderly_poweroff(), the thermal emergency
>> +      poweroff kicks in after a delay has elapsed and shuts down the
>> system.
>> +      This config is number of milliseconds to delay before emergency
>> +      poweroff kicks in. Similarly to the critical trip point,
>> +      the delay should be carefully profiled so as to give adequate
>> +      time for orderly_poweroff() to finish on regular execution.
>> +      If set to 0 emergency poweroff will not be supported.
>> +
>> +      In doubt, leave as 0.
>> +
>>   config THERMAL_HWMON
>>       bool
>>       prompt "Expose thermal sensors as hwmon device"
>> diff --git a/drivers/thermal/thermal_core.c
>> b/drivers/thermal/thermal_core.c
>> index 8337c27..b21b9cc 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -324,6 +324,54 @@ static void handle_non_critical_trips(struct
>> thermal_zone_device *tz,
>>                  def_governor->throttle(tz, trip);
>>   }
>>   +/**
>> + * thermal_emergency_poweroff_func - emergency poweroff work after a
>> known delay
> may needs to be re-phrased as this func itself can't handle the delay.
>> + * @work: work_struct associated with the emergency poweroff function
>> + *
>> + * This function is called in very critical situations to force
>> + * a kernel poweroff after a configurable timeout value.
>> + */
>> +static void thermal_emergency_poweroff_func(struct work_struct *work)
>> +{
>> +    /*
>> +     * We have reached here after the emergency thermal shutdown
>> +     * Waiting period has expired. This means orderly_poweroff has
>> +     * not been able to shut off the system for some reason.
>> +     * Try to shut down the system immediately using kernel_power_off
>> +     * if populated
>> +     */
>> +    WARN(1, "Attempting kernel_power_off: Temperature too high\n");
>> +    kernel_power_off();
>> +
>> +    /*
>> +     * Worst of the worst case trigger emergency restart
>> +     */
>> +    WARN(1, "Attempting emergency_restart: Temperature too high\n");
>> +    emergency_restart();
>> +}
>> +
>> +static DECLARE_DELAYED_WORK(thermal_emergency_poweroff_work,
>> +                thermal_emergency_poweroff_func);
>> +
>> +/**
>> + * thermal_emergency_poweroff - Trigger an emergency system poweroff
> Here you may say after a pre-set delay.
>> + *
>> + * This may be called from any critical situation to trigger a system
>> shutdown
>> + * after a known period of time. By default this is not scheduled.
> This will be called only on a critical temperature event, right?
>> + */
>> +void thermal_emergency_poweroff(void)
>> +{
>> +    int poweroff_delay_ms = CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS;
>> +    /*
>> +     * poweroff_delay_ms must be a carefully profiled positive value.
>> +     * Its a must for thermal_emergency_poweroff_work to be scheduled
> typo %s/Its/It's/
>> +     */
>> +    if (poweroff_delay_ms <= 0)
>> +        return;
> It may be helpful to provide hint before returning?
> "Back up thermal emergency poweroff service is not enabled, set
> 
> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS to a carefully profiled value
> to enable this service"
> 
>> +    schedule_delayed_work(&thermal_emergency_poweroff_work,
>> +                  msecs_to_jiffies(poweroff_delay_ms));
>> +}
>> +
>>   static void handle_critical_trips(struct thermal_zone_device *tz,
>>                     int trip, enum thermal_trip_type trip_type)
>>   {
>> @@ -346,6 +394,11 @@ static void handle_critical_trips(struct
>> thermal_zone_device *tz,
>>                 tz->temperature / 1000);
>>           mutex_lock(&poweroff_lock);
>>           if (!power_off_triggered) {
>> +            /*
>> +             * Queue a backup emergency shutdown in the event of
>> +             * orderly_poweroff failure
>> +             */
>> +            thermal_emergency_poweroff();
> This comment is misleading because calling the api is not enough to set
> a backup.
>>               orderly_poweroff(true);
>>               power_off_triggered = true;
>>           }
> Over all, much needed functionality. Thanks.
> 
> Regards,
> RK
