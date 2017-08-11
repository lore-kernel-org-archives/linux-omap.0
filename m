From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: ti-soc-thermal: Potential error pointer
 dereferences
Date: Fri, 11 Aug 2017 10:00:33 +0800
Message-ID: <1502416833.2598.3.camel@intel.com>
References: <20170710072422.rs25i5oawmiaofrp@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20170710072422.rs25i5oawmiaofrp@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Keerthy <j-keerthy@ti.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 2017-07-10 at 10:24 +0300, Dan Carpenter wrote:
> ti_bandgap_get_sensor_data() can return error pointers so we should
> check for that.  There is no need to check "data->ti_thermal" for
> NULL
> and we removed that from the other cleanup function so we may as well
> from it in ti_thermal_remove_sensor() to be consistent.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> index c211a8e4a210..9fea354ca90c 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> @@ -210,7 +210,7 @@ int ti_thermal_remove_sensor(struct ti_bandgap
> *bgp, int id)
>  
>  	data = ti_bandgap_get_sensor_data(bgp, id);
>  
> -	if (data && data->ti_thermal) {
> +	if (data && !IS_ERR(data)) {

what about
	if (!IS_ERR_OR_NULL(data))

thanks,
rui

>  		if (data->our_zone)
>  			thermal_zone_device_unregister(data-
> >ti_thermal);
>  	}
> @@ -276,7 +276,7 @@ int ti_thermal_unregister_cpu_cooling(struct
> ti_bandgap *bgp, int id)
>  
>  	data = ti_bandgap_get_sensor_data(bgp, id);
>  
> -	if (data) {
> +	if (data && !IS_ERR(data)) {
>  		cpufreq_cooling_unregister(data->cool_dev);
>  		cpufreq_cpu_put(data->policy);
>  	}
