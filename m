From: Caesar Wang <wxt@rock-chips.com>
Subject: Re: [PATCH v5 3/5] thermal: streamline get_trend callbacks
Date: Tue, 07 Jun 2016 20:44:56 +0800
Message-ID: <5756C1C8.1000007@rock-chips.com>
References: <1465213489-14898-1-git-send-email-wxt@rock-chips.com> <1465213489-14898-4-git-send-email-wxt@rock-chips.com> <57566656.4010002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57566656.4010002@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <a0393675@ti.com>
Cc: edubezval@gmail.com, linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org, briannorris@google.com, smbarber@google.com, linux-rockchip@lists.infradead.org, cf@rock-chips.com, huangtao@rock-chips.com, dmitry.torokhov@gmail.com, javi.merino@arm.com, peter@piie.net, Sascha Hauer <s.hauer@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


On 2016=E5=B9=B406=E6=9C=8807=E6=97=A5 14:14, Keerthy wrote:
>
>
> On Monday 06 June 2016 05:14 PM, Caesar Wang wrote:
>> From: Sascha Hauer <s.hauer@pengutronix.de>
>>
>> The .get_trend callback in struct thermal_zone_device_ops has
>> the prototype:
>> int (*get_trend) (struct thermal_zone_device *, int,
>> enum thermal_trend *);
>> whereas the .get_trend callback in struct thermal_zone_of_device_ops
>> has:
>> int (*get_trend)(void *, long *);
>>
>> Streamline both prototypes and add the trip argument to the OF callb=
ack
>> aswell and use enum thermal_trend * instead of an integer pointer.
>>
>> While the OF prototype may be the better one, this should be decided=
 at
>> framework level and not on OF level.
>
> Tested this patch on omap5-uevm using emulation feature and saw that
> cooling state was getting updated correctly w.r.t trip point=20
> tempereatures.
>
> A minor comment below apart from that.
>
> Reviewed-by: Keerthy <j-keerthy@ti.com>
>
>>
>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>> Cc: Zhang Rui <rui.zhang@intel.com>
>> Cc: Eduardo Valentin <edubezval@gmail.com>
>> Cc: linux-pm@vger.kernel.org
>> ---
>>
>> Changes in v5: None
>> Changes in v4: None
>> Changes in v3: None
>> Changes in v2: None
>>
>> drivers/thermal/of-thermal.c | 11 +---------
>> drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 25=20
>> +++++++---------------
>> include/linux/thermal.h | 2 +-
>> 3 files changed, 10 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-therm=
al.c
>> index 2d2a06f..ba72c35 100644
>> --- a/drivers/thermal/of-thermal.c
>> +++ b/drivers/thermal/of-thermal.c
>> @@ -202,24 +202,15 @@ static int of_thermal_get_trend(struct=20
>> thermal_zone_device *tz, int trip,
>> enum thermal_trend *trend)
>> {
>> struct __thermal_zone *data =3D tz->devdata;
>> - long dev_trend;
>> int r;
>
> int r =3D 0;
>
>>
>> if (!data->ops->get_trend)
>> return -EINVAL;
>>
>> - r =3D data->ops->get_trend(data->sensor_data, &dev_trend);
>> + r =3D data->ops->get_trend(data->sensor_data, trip, trend);
>> if (r)
>> return r;
>
> no need of this if check just
>
> return r;

Maybe, we can return it with "data->ops->get_trend(data->sensor_data,=20
trip, trend)"

return data->ops->get_trend(data->sensor_data, trip, trend);
>
>>
>> - /* TODO: These intervals might have some thresholds, but in core=20
>> code */
>> - if (dev_trend > 0)
>> - *trend =3D THERMAL_TREND_RAISING;
>> - else if (dev_trend < 0)
>> - *trend =3D THERMAL_TREND_DROPPING;
>> - else
>> - *trend =3D THERMAL_TREND_STABLE;
>> -
>> return 0;
>> }
>>
>> diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c=20
>> b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
>> index 15c0a9a..4a6757c 100644
>> --- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
>> +++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
>> @@ -239,7 +239,7 @@ static int ti_thermal_get_trip_temp(struct=20
>> thermal_zone_device *thermal,
>> return 0;
>> }
>>
>> -static int __ti_thermal_get_trend(void *p, long *trend)
>> +static int __ti_thermal_get_trend(void *p, int trip, enum=20
>> thermal_trend *trend)
>> {
>> struct ti_thermal_data *data =3D p;
>> struct ti_bandgap *bgp;
>> @@ -252,22 +252,6 @@ static int __ti_thermal_get_trend(void *p, long=
=20
>> *trend)
>> if (ret)
>> return ret;
>>
>> - *trend =3D tr;
>> -
>> - return 0;
>> -}
>> -
>> -/* Get the temperature trend callback functions for thermal zone */
>> -static int ti_thermal_get_trend(struct thermal_zone_device *thermal=
,
>> - int trip, enum thermal_trend *trend)
>> -{
>> - int ret;
>> - long tr;
>> -
>> - ret =3D __ti_thermal_get_trend(thermal->devdata, &tr);
>> - if (ret)
>> - return ret;
>> -
>> if (tr > 0)
>> *trend =3D THERMAL_TREND_RAISING;
>> else if (tr < 0)
>> @@ -278,6 +262,13 @@ static int ti_thermal_get_trend(struct=20
>> thermal_zone_device *thermal,
>> return 0;
>> }
>>
>> +/* Get the temperature trend callback functions for thermal zone */
>> +static int ti_thermal_get_trend(struct thermal_zone_device *thermal=
,
>> + int trip, enum thermal_trend *trend)
>> +{
>> + return __ti_thermal_get_trend(thermal->devdata, trip, trend);
>> +}
>> +
>> /* Get critical temperature callback functions for thermal zone */
>> static int ti_thermal_get_crit_temp(struct thermal_zone_device *ther=
mal,
>> int *temp)
>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>> index 2440b8d..d3ce3a5 100644
>> --- a/include/linux/thermal.h
>> +++ b/include/linux/thermal.h
>> @@ -352,7 +352,7 @@ struct thermal_genl_event {
>> */
>> struct thermal_zone_of_device_ops {
>> int (*get_temp)(void *, int *);
>> - int (*get_trend)(void *, long *);
>> + int (*get_trend)(void *, int, enum thermal_trend *);
>> int (*set_trips)(void *, int, int);
>> int (*set_emul_temp)(void *, int);
>> int (*set_trip_temp)(void *, int, int);
>>
>
>
>

--=20
caesar wang | software engineer | wxt@rock-chip.com
