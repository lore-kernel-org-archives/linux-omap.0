From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 7/7] thermal: ti-soc-thermal: Remove redundant code
Date: Wed, 1 Mar 2017 15:59:50 +0530
Message-ID: <1488364190-23488-8-git-send-email-j-keerthy@ti.com>
References: <1488364190-23488-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1488364190-23488-1-git-send-email-j-keerthy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: tony@atomide.com, edubezval@gmail.com
Cc: rui.zhang@intel.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robh+dt@kernel.org, t-kristo@ti.com, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

ti_thermal_expose_sensor always takes the
devm_thermal_zone_of_sensor_register call for registration
with the device tree nodes present for all the bandgap sensors
for omap3/4/5 and dra7 family. There are large chunks of unused
code. Removing all of them.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 154 +--------------------
 1 file changed, 3 insertions(+), 151 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 6d9399f..59fd3a8 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -132,119 +132,6 @@ static inline int ti_thermal_get_temp(struct thermal_zone_device *thermal,
 	return __ti_thermal_get_temp(data, temp);
 }
 
-/* Bind callback functions for thermal zone */
-static int ti_thermal_bind(struct thermal_zone_device *thermal,
-			   struct thermal_cooling_device *cdev)
-{
-	struct ti_thermal_data *data = thermal->devdata;
-	int id;
-
-	if (!data || IS_ERR(data))
-		return -ENODEV;
-
-	/* check if this is the cooling device we registered */
-	if (data->cool_dev != cdev)
-		return 0;
-
-	id = data->sensor_id;
-
-	/* Simple thing, two trips, one passive another critical */
-	return thermal_zone_bind_cooling_device(thermal, 0, cdev,
-	/* bind with min and max states defined by cpu_cooling */
-						THERMAL_NO_LIMIT,
-						THERMAL_NO_LIMIT,
-						THERMAL_WEIGHT_DEFAULT);
-}
-
-/* Unbind callback functions for thermal zone */
-static int ti_thermal_unbind(struct thermal_zone_device *thermal,
-			     struct thermal_cooling_device *cdev)
-{
-	struct ti_thermal_data *data = thermal->devdata;
-
-	if (!data || IS_ERR(data))
-		return -ENODEV;
-
-	/* check if this is the cooling device we registered */
-	if (data->cool_dev != cdev)
-		return 0;
-
-	/* Simple thing, two trips, one passive another critical */
-	return thermal_zone_unbind_cooling_device(thermal, 0, cdev);
-}
-
-/* Get mode callback functions for thermal zone */
-static int ti_thermal_get_mode(struct thermal_zone_device *thermal,
-			       enum thermal_device_mode *mode)
-{
-	struct ti_thermal_data *data = thermal->devdata;
-
-	if (data)
-		*mode = data->mode;
-
-	return 0;
-}
-
-/* Set mode callback functions for thermal zone */
-static int ti_thermal_set_mode(struct thermal_zone_device *thermal,
-			       enum thermal_device_mode mode)
-{
-	struct ti_thermal_data *data = thermal->devdata;
-	struct ti_bandgap *bgp;
-
-	bgp = data->bgp;
-
-	if (!data->ti_thermal) {
-		dev_notice(&thermal->device, "thermal zone not registered\n");
-		return 0;
-	}
-
-	mutex_lock(&data->ti_thermal->lock);
-
-	if (mode == THERMAL_DEVICE_ENABLED)
-		data->ti_thermal->polling_delay = FAST_TEMP_MONITORING_RATE;
-	else
-		data->ti_thermal->polling_delay = 0;
-
-	mutex_unlock(&data->ti_thermal->lock);
-
-	data->mode = mode;
-	ti_bandgap_write_update_interval(bgp, data->sensor_id,
-					data->ti_thermal->polling_delay);
-	thermal_zone_device_update(data->ti_thermal, THERMAL_EVENT_UNSPECIFIED);
-	dev_dbg(&thermal->device, "thermal polling set for duration=%d msec\n",
-		data->ti_thermal->polling_delay);
-
-	return 0;
-}
-
-/* Get trip type callback functions for thermal zone */
-static int ti_thermal_get_trip_type(struct thermal_zone_device *thermal,
-				    int trip, enum thermal_trip_type *type)
-{
-	if (!ti_thermal_is_valid_trip(trip))
-		return -EINVAL;
-
-	if (trip + 1 == OMAP_TRIP_NUMBER)
-		*type = THERMAL_TRIP_CRITICAL;
-	else
-		*type = THERMAL_TRIP_PASSIVE;
-
-	return 0;
-}
-
-/* Get trip temperature callback functions for thermal zone */
-static int ti_thermal_get_trip_temp(struct thermal_zone_device *thermal,
-				    int trip, int *temp)
-{
-	if (!ti_thermal_is_valid_trip(trip))
-		return -EINVAL;
-
-	*temp = ti_thermal_get_trip_value(trip);
-
-	return 0;
-}
-
 static int __ti_thermal_get_trend(void *p, int trip, enum thermal_trend *trend)
 {
 	struct ti_thermal_data *data = p;
@@ -268,38 +155,11 @@ static int __ti_thermal_get_trend(void *p, int trip, enum thermal_trend *trend)
 	return 0;
 }
 
-/* Get the temperature trend callback functions for thermal zone */
-static int ti_thermal_get_trend(struct thermal_zone_device *thermal,
-				int trip, enum thermal_trend *trend)
-{
-	return __ti_thermal_get_trend(thermal->devdata, trip, trend);
-}
-
-/* Get critical temperature callback functions for thermal zone */
-static int ti_thermal_get_crit_temp(struct thermal_zone_device *thermal,
-				    int *temp)
-{
-	/* shutdown zone */
-	return ti_thermal_get_trip_temp(thermal, OMAP_TRIP_NUMBER - 1, temp);
-}
-
 static const struct thermal_zone_of_device_ops ti_of_thermal_ops = {
 	.get_temp = __ti_thermal_get_temp,
 	.get_trend = __ti_thermal_get_trend,
 };
 
-static struct thermal_zone_device_ops ti_thermal_ops = {
-	.get_temp = ti_thermal_get_temp,
-	.get_trend = ti_thermal_get_trend,
-	.bind = ti_thermal_bind,
-	.unbind = ti_thermal_unbind,
-	.get_mode = ti_thermal_get_mode,
-	.set_mode = ti_thermal_set_mode,
-	.get_trip_type = ti_thermal_get_trip_type,
-	.get_trip_temp = ti_thermal_get_trip_temp,
-	.get_crit_temp = ti_thermal_get_crit_temp,
-};
-
 static struct ti_thermal_data
 *ti_thermal_build_data(struct ti_bandgap *bgp, int id)
 {
@@ -337,18 +197,10 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
 	data->ti_thermal = devm_thermal_zone_of_sensor_register(bgp->dev, id,
 					data, &ti_of_thermal_ops);
 	if (IS_ERR(data->ti_thermal)) {
-		/* Create thermal zone */
-		data->ti_thermal = thermal_zone_device_register(domain,
-				OMAP_TRIP_NUMBER, 0, data, &ti_thermal_ops,
-				NULL, FAST_TEMP_MONITORING_RATE,
-				FAST_TEMP_MONITORING_RATE);
-		if (IS_ERR(data->ti_thermal)) {
-			dev_err(bgp->dev, "thermal zone device is NULL\n");
-			return PTR_ERR(data->ti_thermal);
-		}
-		data->ti_thermal->polling_delay = FAST_TEMP_MONITORING_RATE;
-		data->our_zone = true;
+		dev_err(bgp->dev, "thermal zone device is NULL\n");
+		return PTR_ERR(data->ti_thermal);
 	}
+
 	ti_bandgap_set_sensor_data(bgp, id, data);
 	ti_bandgap_write_update_interval(bgp, data->sensor_id,
 					data->ti_thermal->polling_delay);
-- 
1.9.1
