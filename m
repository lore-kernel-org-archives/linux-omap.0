From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCHv4 1/1] thermal: core: call thermal_zone_device_update()
 after mode update
Date: Thu, 23 Jun 2016 10:08:09 +0530
Message-ID: <576B67B1.603@ti.com>
References: <1466563538.2471.10.camel@intel.com>
 <1466607798-30025-1-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1466607798-30025-1-git-send-email-edubezval@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Rui Zhang <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, Darren Hart <dvhart@infradead.org>, Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On Wednesday 22 June 2016 08:33 PM, Eduardo Valentin wrote:
> Because several drivers do the following pattern:
> .set_mode()
>     ...
>     local_data->mode = new_mode;
>     thermal_zone_device_update(tz);
>
> makes sense to simply do the thermal_zone_device_update()
> in thermal core, after setting the new mode.
>
> Also, this patch also remove deadlocks on drivers that
> call thermal_zone_device_update() on .set_mode(),
> as .set_mode()  is now called always with tz->lock held.

I do not see the issue anymore. Boot Tested multiple times on DRA72-EVM.

Tested-by: Keerthy <j-keerthy@ti.com>

>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Cc: "Lee, Chun-Yi" <jlee@suse.com>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Cc: platform-driver-x86@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> ---
> Hello,
>
> V3->V4:
> - ti-soc: Removed extra locking from TI SoC in set_mode
> - ACPI: Kept the update on check as it is called on other places
>
> BR,
>
> Eduardo
>
>   drivers/acpi/thermal.c                             | 1 -
>   drivers/platform/x86/acerhdf.c                     | 1 -
>   drivers/thermal/imx_thermal.c                      | 1 -
>   drivers/thermal/of-thermal.c                       | 5 -----
>   drivers/thermal/thermal_sysfs.c                    | 1 +
>   drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 5 -----
>   6 files changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 82707f9..03c3460 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -581,7 +581,6 @@ static int thermal_set_mode(struct thermal_zone_device *thermal,
>   		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>   			"%s kernel ACPI thermal control\n",
>   			tz->tz_enabled ? "Enable" : "Disable"));
> -		acpi_thermal_check(tz);
>   	}
>   	return 0;
>   }
> diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
> index 460fa67..aee33ba 100644
> --- a/drivers/platform/x86/acerhdf.c
> +++ b/drivers/platform/x86/acerhdf.c
> @@ -405,7 +405,6 @@ static inline void acerhdf_enable_kernelmode(void)
>   	kernelmode = 1;
>
>   	thz_dev->polling_delay = interval*1000;
> -	thermal_zone_device_update(thz_dev);
>   	pr_notice("kernel mode fan control ON\n");
>   }
>
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index c5547bd..a413eb6 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -246,7 +246,6 @@ static int imx_set_mode(struct thermal_zone_device *tz,
>   	}
>
>   	data->mode = mode;
> -	thermal_zone_device_update(tz);
>
>   	return 0;
>   }
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index b8e509c..95c47da 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -282,17 +282,12 @@ static int of_thermal_set_mode(struct thermal_zone_device *tz,
>   {
>   	struct __thermal_zone *data = tz->devdata;
>
> -	mutex_lock(&tz->lock);
> -
>   	if (mode == THERMAL_DEVICE_ENABLED)
>   		tz->polling_delay = data->polling_delay;
>   	else
>   		tz->polling_delay = 0;
>
> -	mutex_unlock(&tz->lock);
> -
>   	data->mode = mode;
> -	thermal_zone_device_update(tz);
>
>   	return 0;
>   }
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index 743df50..3d0dc30 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -100,6 +100,7 @@ mode_store(struct device *dev, struct device_attribute *attr,
>   	mutex_lock(&tz->lock);
>   	result = tz->ops->set_mode(tz, mode);
>   	mutex_unlock(&tz->lock);
> +	thermal_zone_device_update(tz);
>
>   	if (result)
>   		return result;
> diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> index 15c0a9a..5dce053 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> @@ -193,19 +193,14 @@ static int ti_thermal_set_mode(struct thermal_zone_device *thermal,
>   		return 0;
>   	}
>
> -	mutex_lock(&data->ti_thermal->lock);
> -
>   	if (mode == THERMAL_DEVICE_ENABLED)
>   		data->ti_thermal->polling_delay = FAST_TEMP_MONITORING_RATE;
>   	else
>   		data->ti_thermal->polling_delay = 0;
>
> -	mutex_unlock(&data->ti_thermal->lock);
> -
>   	data->mode = mode;
>   	ti_bandgap_write_update_interval(bgp, data->sensor_id,
>   					data->ti_thermal->polling_delay);
> -	thermal_zone_device_update(data->ti_thermal);
>   	dev_dbg(&thermal->device, "thermal polling set for duration=%d msec\n",
>   		data->ti_thermal->polling_delay);
>
>
