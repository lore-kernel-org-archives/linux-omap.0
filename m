From: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v5 3/5] thermal: streamline get_trend callbacks
Date: Tue, 7 Jun 2016 11:44:46 +0530
Message-ID: <57566656.4010002@ti.com>
References: <1465213489-14898-1-git-send-email-wxt@rock-chips.com>
 <1465213489-14898-4-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1465213489-14898-4-git-send-email-wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, javi.merino-5wv7dgnIgG8@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, peter-p08lbbvQ7EI@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, smbarber-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, briannorris-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On Monday 06 June 2016 05:14 PM, Caesar Wang wrote:
> From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>
> The .get_trend callback in struct thermal_zone_device_ops has
> the prototype:
>          int (*get_trend) (struct thermal_zone_device *, int,
>                            enum thermal_trend *);
> whereas the .get_trend callback in struct thermal_zone_of_device_ops
> has:
>          int (*get_trend)(void *, long *);
>
> Streamline both prototypes and add the trip argument to the OF callback
> aswell and use enum thermal_trend * instead of an integer pointer.
>
> While the OF prototype may be the better one, this should be decided at
> framework level and not on OF level.

Tested this patch on omap5-uevm using emulation feature and saw that
cooling state was getting updated correctly w.r.t trip point tempereatures.

A minor comment below apart from that.

Reviewed-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>

>
> Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> ---
>
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
>
>   drivers/thermal/of-thermal.c                       | 11 +---------
>   drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 25 +++++++---------------
>   include/linux/thermal.h                            |  2 +-
>   3 files changed, 10 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index 2d2a06f..ba72c35 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -202,24 +202,15 @@ static int of_thermal_get_trend(struct thermal_zone_device *tz, int trip,
>   				enum thermal_trend *trend)
>   {
>   	struct __thermal_zone *data = tz->devdata;
> -	long dev_trend;
>   	int r;

	int r = 0;

>
>   	if (!data->ops->get_trend)
>   		return -EINVAL;
>
> -	r = data->ops->get_trend(data->sensor_data, &dev_trend);
> +	r = data->ops->get_trend(data->sensor_data, trip, trend);
>   	if (r)
>   		return r;

no need of this if check just
	
	return r;

>
> -	/* TODO: These intervals might have some thresholds, but in core code */
> -	if (dev_trend > 0)
> -		*trend = THERMAL_TREND_RAISING;
> -	else if (dev_trend < 0)
> -		*trend = THERMAL_TREND_DROPPING;
> -	else
> -		*trend = THERMAL_TREND_STABLE;
> -
>   	return 0;
>   }
>
> diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> index 15c0a9a..4a6757c 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> @@ -239,7 +239,7 @@ static int ti_thermal_get_trip_temp(struct thermal_zone_device *thermal,
>   	return 0;
>   }
>
> -static int __ti_thermal_get_trend(void *p, long *trend)
> +static int __ti_thermal_get_trend(void *p, int trip, enum thermal_trend *trend)
>   {
>   	struct ti_thermal_data *data = p;
>   	struct ti_bandgap *bgp;
> @@ -252,22 +252,6 @@ static int __ti_thermal_get_trend(void *p, long *trend)
>   	if (ret)
>   		return ret;
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
>   	if (tr > 0)
>   		*trend = THERMAL_TREND_RAISING;
>   	else if (tr < 0)
> @@ -278,6 +262,13 @@ static int ti_thermal_get_trend(struct thermal_zone_device *thermal,
>   	return 0;
>   }
>
> +/* Get the temperature trend callback functions for thermal zone */
> +static int ti_thermal_get_trend(struct thermal_zone_device *thermal,
> +				int trip, enum thermal_trend *trend)
> +{
> +	return __ti_thermal_get_trend(thermal->devdata, trip, trend);
> +}
> +
>   /* Get critical temperature callback functions for thermal zone */
>   static int ti_thermal_get_crit_temp(struct thermal_zone_device *thermal,
>   				    int *temp)
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 2440b8d..d3ce3a5 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -352,7 +352,7 @@ struct thermal_genl_event {
>    */
>   struct thermal_zone_of_device_ops {
>   	int (*get_temp)(void *, int *);
> -	int (*get_trend)(void *, long *);
> +	int (*get_trend)(void *, int, enum thermal_trend *);
>   	int (*set_trips)(void *, int, int);
>   	int (*set_emul_temp)(void *, int);
>   	int (*set_trip_temp)(void *, int, int);
>
