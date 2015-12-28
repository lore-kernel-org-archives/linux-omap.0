From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH] thermal: Schedule a backup thermal shutdown workqueue
 after a known period of time to tackle failed poweroff
Date: Mon, 28 Dec 2015 11:41:00 -0600
Message-ID: <5681742C.8050805@ti.com>
References: <1450676778-7840-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1450676778-7840-1-git-send-email-j-keerthy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>, rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-omap@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 12/20/2015 11:46 PM, Keerthy wrote:

+linux-pm.

> In few rare conditions like during boot up the orderly_poweroff
> function might not be able to complete fully leaving the device
> running at dangerously high temperatures. Hence adding a backup
> workqueue to act after a known period of time and poweroff the device.
> 


> Suggested-by: Nishanth Menon <nm@ti.com>
> Reported-by: Nishanth Menon <nm@ti.com>

The specific case I hit was a critical temperature event as soon as
the hwmon device was probed (the driver tmp102 was a kernel module).

> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/thermal/Kconfig        |  9 +++++++++
>  drivers/thermal/thermal_core.c | 26 ++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 8cc4ac6..25584ee 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -92,6 +92,15 @@ config THERMAL_DEFAULT_GOV_POWER_ALLOCATOR
>  
>  endchoice
>  
> +config THERMAL_BKUP_SHUTDOWN_DELAY_MS
> +        int "Thermal shutdown  backup delay in milli-seconds"
> +        depends on THERMAL
> +        default "5000"
> +        ---help---
> +        The number of milliseconds to delay after orderly_poweroff call.

Probably needs a rephrase.

> +
> +        Default: 5000 (5 seconds)
> +
>  config THERMAL_GOV_FAIR_SHARE
>  	bool "Fair-share thermal governor"
>  	help
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index d9e525c..b793857 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -61,6 +61,12 @@ static DEFINE_MUTEX(thermal_governor_lock);
>  
>  static struct thermal_governor *def_governor;
>  
> +#ifdef CONFIG_THERMAL_BKUP_SHUTDOWN_DELAY_MS
> +#define BKUP_SHUTDOWN_DELAY CONFIG_THERMAL_BKUP_SHUTDOWN_DELAY_MS
> +#else
> +#define BKUP_SHUTDOWN_DELAY 5000
> +#endif
> +

I am not sure if this #ifdeffery is even needed.


Eduardo, Rui: If this is not the suggested technique, maybe you guys
could suggest how we could handle a case where userspace might be
hungup due to some reason and a case where a critical temperature
event in the middle of device probe was triggered?

Obviously, we'd like to take into consideration userspace latencies as
well- but that is very specific to fs being run.. not really a simple
problem, IMHO..

>  static struct thermal_governor *__find_governor(const char *name)
>  {
>  	struct thermal_governor *pos;
> @@ -423,6 +429,18 @@ static void handle_non_critical_trips(struct thermal_zone_device *tz,
>  		       def_governor->throttle(tz, trip);
>  }
>  
> +static void bkup_shutdown_func(struct work_struct *unused);
> +static DECLARE_DELAYED_WORK(bkup_shutdown_work, bkup_shutdown_func);
> +
> +static void bkup_shutdown_func(struct work_struct *work)
> +{
> +	pr_warn("Orderly_poweroff has failed! Attempting kernel_power_off\n");
> +	kernel_power_off();
> +
> +	pr_warn("kernel_power_off has failed! Attempting emergency_restart\n");
> +	emergency_restart();

I think documentation is necessary that we are hoping for bootloader
to be able to detect and halt as needed -> risk here obviously is an
infinite reboot loop :( .


> +}
> +
>  static void handle_critical_trips(struct thermal_zone_device *tz,
>  				int trip, enum thermal_trip_type trip_type)
>  {
> @@ -443,6 +461,14 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
>  		dev_emerg(&tz->device,
>  			  "critical temperature reached(%d C),shutting down\n",
>  			  tz->temperature / 1000);
> +		/**

needs to be kernel doc style?

> +		 * This is a backup option to shutdown the
> +		 * system in case orderly_poweroff
> +		 * fails
Maybe adjust to 80char?

> +		 */
> +		schedule_delayed_work(&bkup_shutdown_work,
> +				      msecs_to_jiffies(BKUP_SHUTDOWN_DELAY));
> +
>  		orderly_poweroff(true);
>  	}
>  }
> 


-- 
Regards,
Nishanth Menon
