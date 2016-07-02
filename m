From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2] thermal: ti-soc-thermal: Add set_emul_temp hook
Date: Fri, 1 Jul 2016 19:57:48 -0700
Message-ID: <20160702025747.GA1058@localhost.localdomain>
References: <1464753550-2529-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464753550-2529-1-git-send-email-j-keerthy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: rui.zhang@intel.com, t-kristo@ti.com, nm@ti.com, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 01, 2016 at 09:29:10AM +0530, Keerthy wrote:
> Setting the emulation temperature helps reproduce critical
> temperature scenarios without risking the actual hardware at
> extreme temperatures. Adding __ti_thermal_set_emul_temp as
> the set_emul_temp hook.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> 
> Changes in v2:
> 
>   * Rebased on top of:
> git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal sysfs_locking
> 
> Tested on DRA7/DRA72 baords.
> 
>  drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> index 15c0a9a..8d069ee 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> @@ -278,6 +278,17 @@ static int ti_thermal_get_trend(struct thermal_zone_device *thermal,
>  	return 0;
>  }
>  
> +static int __ti_thermal_set_emul_temp(void *p, int temp)
> +{
> +	struct ti_thermal_data *data = p;
> +	struct thermal_zone_device *tz;
> +
> +	tz = data->ti_thermal;
> +	tz->emul_temperature = temp;
> +
> +	return 0;
> +}
> +
>  /* Get critical temperature callback functions for thermal zone */
>  static int ti_thermal_get_crit_temp(struct thermal_zone_device *thermal,
>  				    int *temp)
> @@ -289,6 +300,7 @@ static int ti_thermal_get_crit_temp(struct thermal_zone_device *thermal,
>  static const struct thermal_zone_of_device_ops ti_of_thermal_ops = {
>  	.get_temp = __ti_thermal_get_temp,
>  	.get_trend = __ti_thermal_get_trend,
> +	.set_emul_temp = __ti_thermal_set_emul_temp,

I am assuming this can be ignored after the fix on of thermal.

>  };
>  
>  static struct thermal_zone_device_ops ti_thermal_ops = {
> -- 
> 1.9.1
> 
