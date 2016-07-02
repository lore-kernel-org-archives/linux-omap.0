From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v6 3/5] thermal: streamline get_trend callbacks
Date: Fri, 1 Jul 2016 19:41:54 -0700
Message-ID: <20160702024153.GA26067@localhost.localdomain>
References: <1466584925-4829-1-git-send-email-wxt@rock-chips.com>
 <1466584925-4829-4-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466584925-4829-4-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org, briannorris@google.com, smbarber@google.com, linux-rockchip@lists.infradead.org, cf@rock-chips.com, huangtao@rock-chips.com, dmitry.torokhov@gmail.com, javi.merino@arm.com, peter@piie.net, rocky.hao@rock-chips.com, Sascha Hauer <s.hauer@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 22, 2016 at 04:42:03PM +0800, Caesar Wang wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> The .get_trend callback in struct thermal_zone_device_ops has
> the prototype:
>         int (*get_trend) (struct thermal_zone_device *, int,
>                           enum thermal_trend *);
> whereas the .get_trend callback in struct thermal_zone_of_device_ops
> has:
>         int (*get_trend)(void *, long *);
> 
> Streamline both prototypes and add the trip argument to the OF callback
> aswell and use enum thermal_trend * instead of an integer pointer.
> 
> While the OF prototype may be the better one, this should be decided at
> framework level and not on OF level.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: linux-pm@vger.kernel.org
> Reviewed-by: Keerthy <j-keerthy@ti.com>

I had to append the following diff, because I merged a new qsens driver:


diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index b182272..446f70b 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -29,13 +29,13 @@ static int tsens_get_temp(void *data, int *temp)
        return tmdev->ops->get_temp(tmdev, s->id, temp);
 }
 
-static int tsens_get_trend(void *data, long *temp)
+static int tsens_get_trend(void *p, int trip, enum thermal_trend *trend)
 {
-       const struct tsens_sensor *s = data;
+       const struct tsens_sensor *s = p;
        struct tsens_device *tmdev = s->tmdev;
 
        if (tmdev->ops->get_trend)
-               return tmdev->ops->get_trend(tmdev, s->id, temp);
+               return  tmdev->ops->get_trend(tmdev, s->id, trend);
 
        return -ENOTSUPP;
 }

> 
> ---
> 
> Changes in v6:
> - as the Keerthy comments on https://patchwork.kernel.org/patch/9157913/,
>   change the get_trend for of_thermal.c.
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/thermal/of-thermal.c                       | 16 +-------------
>  drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 25 +++++++---------------
>  include/linux/thermal.h                            |  2 +-
>  3 files changed, 10 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index 2d2a06f..20822ab 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -202,25 +202,11 @@ static int of_thermal_get_trend(struct thermal_zone_device *tz, int trip,
>  				enum thermal_trend *trend)
>  {
>  	struct __thermal_zone *data = tz->devdata;
> -	long dev_trend;
> -	int r;
>  
>  	if (!data->ops->get_trend)
>  		return -EINVAL;
>  
> -	r = data->ops->get_trend(data->sensor_data, &dev_trend);
> -	if (r)
> -		return r;
> -
> -	/* TODO: These intervals might have some thresholds, but in core code */
> -	if (dev_trend > 0)
> -		*trend = THERMAL_TREND_RAISING;
> -	else if (dev_trend < 0)
> -		*trend = THERMAL_TREND_DROPPING;
> -	else
> -		*trend = THERMAL_TREND_STABLE;
> -
> -	return 0;
> +	return data->ops->get_trend(data->sensor_data, trip, trend);
>  }
>  
>  static int of_thermal_bind(struct thermal_zone_device *thermal,
> diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> index 15c0a9a..4a6757c 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> @@ -239,7 +239,7 @@ static int ti_thermal_get_trip_temp(struct thermal_zone_device *thermal,
>  	return 0;
>  }
>  
> -static int __ti_thermal_get_trend(void *p, long *trend)
> +static int __ti_thermal_get_trend(void *p, int trip, enum thermal_trend *trend)
>  {
>  	struct ti_thermal_data *data = p;
>  	struct ti_bandgap *bgp;
> @@ -252,22 +252,6 @@ static int __ti_thermal_get_trend(void *p, long *trend)
>  	if (ret)
>  		return ret;
>  
> -	*trend = tr;
> -
> -	return 0;
> -}
> -
> -/* Get the temperature trend callback functions for thermal zone */
> -static int ti_thermal_get_trend(struct thermal_zone_device *thermal,
> -				int trip, enum thermal_trend *trend)
> -{
> -	int ret;
> -	long tr;
> -
> -	ret = __ti_thermal_get_trend(thermal->devdata, &tr);
> -	if (ret)
> -		return ret;
> -
>  	if (tr > 0)
>  		*trend = THERMAL_TREND_RAISING;
>  	else if (tr < 0)
> @@ -278,6 +262,13 @@ static int ti_thermal_get_trend(struct thermal_zone_device *thermal,
>  	return 0;
>  }
>  
> +/* Get the temperature trend callback functions for thermal zone */
> +static int ti_thermal_get_trend(struct thermal_zone_device *thermal,
> +				int trip, enum thermal_trend *trend)
> +{
> +	return __ti_thermal_get_trend(thermal->devdata, trip, trend);
> +}
> +
>  /* Get critical temperature callback functions for thermal zone */
>  static int ti_thermal_get_crit_temp(struct thermal_zone_device *thermal,
>  				    int *temp)
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 2440b8d..d3ce3a5 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -352,7 +352,7 @@ struct thermal_genl_event {
>   */
>  struct thermal_zone_of_device_ops {
>  	int (*get_temp)(void *, int *);
> -	int (*get_trend)(void *, long *);
> +	int (*get_trend)(void *, int, enum thermal_trend *);
>  	int (*set_trips)(void *, int, int);
>  	int (*set_emul_temp)(void *, int);
>  	int (*set_trip_temp)(void *, int, int);
> -- 
> 1.9.1
> 
