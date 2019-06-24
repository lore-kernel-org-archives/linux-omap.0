From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 6/6] thermal/drivers/ti: Remove cooling device usage
Date: Mon, 24 Jun 2019 11:36:15 +0530
Message-ID: <20190624060615.ptdeejny75x44wue@vireshk-i7>
References: <20190621132302.30414-1-daniel.lezcano@linaro.org>
 <20190621132302.30414-6-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190621132302.30414-6-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: edubezval@gmail.com, linux-kernel@vger.kernel.org, Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>, "open list:TI BANDGAP AND THERMAL DRIVER" <linux-pm@vger.kernel.org>, "open list:TI BANDGAP AND THERMAL DRIVER" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 21-06-19, 15:23, Daniel Lezcano wrote:
> The cpufreq_cooling_unregister() function uses now the policy to
> unregister itself. The only purpose of the cooling device pointer is
> to unregister the cpu cooling device.
> 
> As there is no more need of this pointer, remove it.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> index 217b1aae8b4f..170b70b6ec61 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> @@ -41,7 +41,6 @@ struct ti_thermal_data {
>  	struct cpufreq_policy *policy;
>  	struct thermal_zone_device *ti_thermal;
>  	struct thermal_zone_device *pcb_tz;
> -	struct thermal_cooling_device *cool_dev;
>  	struct ti_bandgap *bgp;
>  	enum thermal_device_mode mode;
>  	struct work_struct thermal_wq;
> @@ -233,6 +232,7 @@ int ti_thermal_register_cpu_cooling(struct ti_bandgap *bgp, int id)
>  {
>  	struct ti_thermal_data *data;
>  	struct device_node *np = bgp->dev->of_node;
> +	struct thermal_cooling_device *cdev;
>  
>  	/*
>  	 * We are assuming here that if one deploys the zone
> @@ -256,9 +256,9 @@ int ti_thermal_register_cpu_cooling(struct ti_bandgap *bgp, int id)
>  	}
>  
>  	/* Register cooling device */
> -	data->cool_dev = cpufreq_cooling_register(data->policy);
> -	if (IS_ERR(data->cool_dev)) {
> -		int ret = PTR_ERR(data->cool_dev);
> +	cdev = cpufreq_cooling_register(data->policy);
> +	if (IS_ERR(cdev)) {
> +		int ret = PTR_ERR(cdev);
>  		dev_err(bgp->dev, "Failed to register cpu cooling device %d\n",
>  			ret);
>  		cpufreq_cpu_put(data->policy);

And this too..

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
