From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 1/1] thermal: core: call thermal_zone_device_update() after mode update
Date: Tue, 21 Jun 2016 22:06:30 -0700
Message-ID: <1466571990-12346-1-git-send-email-edubezval@gmail.com>
References: <1466563538.2471.10.camel@intel.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1466563538.2471.10.camel@intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, Darren Hart <dvhart@infradead.org>, Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Because several drivers do the following pattern:
.set_mode()
   ...
   local_data->mode = new_mode;
   thermal_zone_device_update(tz);

makes sense to simply do the thermal_zone_device_update()
in thermal core, after setting the new mode.

Also, this patch also remove deadlocks on drivers that
call thermal_zone_device_update() on .set_mode(),
as .set_mode()  is now called always with tz->lock held.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Cc: "Lee, Chun-Yi" <jlee@suse.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
Rui, Keerthy,

I think this patch should take care of the introduced deadlock.

Let me know if solves on your end.

BR,

Eduardo
---

 drivers/acpi/thermal.c                             |  2 --
 drivers/platform/x86/acerhdf.c                     |  1 -
 drivers/thermal/imx_thermal.c                      |  1 -
 drivers/thermal/of-thermal.c                       |  8 ++---
 drivers/thermal/thermal_core.c                     | 41 +++++++++++++++++-----
 drivers/thermal/thermal_sysfs.c                    |  1 +
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  1 -
 7 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 82707f9..8582b88 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -519,8 +519,6 @@ static void acpi_thermal_check(void *data)
 
 	if (!tz->tz_enabled)
 		return;
-
-	thermal_zone_device_update(tz->thermal_zone);
 }
 
 /* sys I/F for generic thermal sysfs support */
diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 460fa67..aee33ba 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -405,7 +405,6 @@ static inline void acerhdf_enable_kernelmode(void)
 	kernelmode = 1;
 
 	thz_dev->polling_delay = interval*1000;
-	thermal_zone_device_update(thz_dev);
 	pr_notice("kernel mode fan control ON\n");
 }
 
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index c5547bd..a413eb6 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -246,7 +246,6 @@ static int imx_set_mode(struct thermal_zone_device *tz,
 	}
 
 	data->mode = mode;
-	thermal_zone_device_update(tz);
 
 	return 0;
 }
diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index b8e509c..b44c102 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -181,9 +181,6 @@ static int of_thermal_set_emul_temp(struct thermal_zone_device *tz,
 {
 	struct __thermal_zone *data = tz->devdata;
 
-	if (!data->ops || !data->ops->set_emul_temp)
-		return -EINVAL;
-
 	return data->ops->set_emul_temp(data->sensor_data, temp);
 }
 
@@ -292,7 +289,6 @@ static int of_thermal_set_mode(struct thermal_zone_device *tz,
 	mutex_unlock(&tz->lock);
 
 	data->mode = mode;
-	thermal_zone_device_update(tz);
 
 	return 0;
 }
@@ -427,7 +423,9 @@ thermal_zone_of_add_sensor(struct device_node *zone,
 
 	tzd->ops->get_temp = of_thermal_get_temp;
 	tzd->ops->get_trend = of_thermal_get_trend;
-	tzd->ops->set_emul_temp = of_thermal_set_emul_temp;
+	if (ops->set_emul_temp)
+		tzd->ops->set_emul_temp = of_thermal_set_emul_temp;
+
 	mutex_unlock(&tzd->lock);
 
 	return tzd;
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 09da955..bb1ede7 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -323,6 +323,21 @@ static void handle_non_critical_trips(struct thermal_zone_device *tz,
 		       def_governor->throttle(tz, trip);
 }
 
+static void thermal_zone_update_stats(struct thermal_zone_device *tz,
+				      int last_trip, int cur_trip)
+{
+	unsigned long long cur_time = get_jiffies_64();
+	struct thermal_zone_stats *cur, *last;
+
+	cur = tz->stats_table[cur_trip];
+	last = tz->stats_table[last_trip];
+
+	cur->counter++;
+	cur->last_time = cur_time;
+
+	last->time_in += cur_time - last->last_time;
+}
+
 static void thermal_tripped_notify(struct thermal_zone_device *tz,
 				   int trip, enum thermal_trip_type trip_type,
 				   int trip_temp)
@@ -333,6 +348,7 @@ static void thermal_tripped_notify(struct thermal_zone_device *tz,
 			NULL };
 	int upper_trip_hyst, upper_trip_temp, trip_hyst = 0;
 	int ret = 0;
+	int cur_trip, last_trip;
 
 	snprintf(tuv_name, sizeof(tuv_name), "THERMAL_ZONE=%s", tz->type);
 	snprintf(tuv_temp, sizeof(tuv_temp), "TEMP=%d", tz->temperature);
@@ -344,8 +360,11 @@ static void thermal_tripped_notify(struct thermal_zone_device *tz,
 	mutex_lock(&tz->lock);
 
 	/* crossing up */
-	if (tz->last_temperature < trip_temp && trip_temp < tz->temperature)
+	if (tz->last_temperature < trip_temp && trip_temp < tz->temperature) {
 		kobject_uevent_env(&tz->device.kobj, KOBJ_CHANGE, msg);
+		last_trip = trip - 1;
+		cur_trip = trip;
+	}
 
 	if (tz->ops->get_trip_hyst)
 		tz->ops->get_trip_hyst(tz, trip, &trip_hyst);
@@ -355,6 +374,8 @@ static void thermal_tripped_notify(struct thermal_zone_device *tz,
 	if (tz->last_temperature > trip_temp && trip_temp > tz->temperature) {
 		snprintf(tuv_trip, sizeof(tuv_trip), "TRIP=%d", trip - 1);
 		kobject_uevent_env(&tz->device.kobj, KOBJ_CHANGE, msg);
+		last_trip = trip;
+		cur_trip = trip - 1;
 	}
 
 	ret = tz->ops->get_trip_temp(tz, trip + 1, &upper_trip_temp);
@@ -369,19 +390,15 @@ static void thermal_tripped_notify(struct thermal_zone_device *tz,
 	    upper_trip_temp > tz->temperature)
 		kobject_uevent_env(&tz->device.kobj, KOBJ_CHANGE, msg);
 
+	thermal_zone_device_update_stats(tz, last_trip, cur_trip);
 unlock:
 	mutex_unlock(&tz->lock);
 }
 
 static void handle_critical_trips(struct thermal_zone_device *tz,
-				  int trip, enum thermal_trip_type trip_type)
+				  int trip, enum thermal_trip_type trip_type,
+				  int trip_temp)
 {
-	int trip_temp;
-
-	tz->ops->get_trip_temp(tz, trip, &trip_temp);
-
-	thermal_tripped_notify(tz, trip, trip_type, trip_temp);
-
 	/* If we have not crossed the trip_temp, we do not care. */
 	if (trip_temp <= 0 || tz->temperature < trip_temp)
 		return;
@@ -402,15 +419,21 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 {
 	enum thermal_trip_type type;
+	int trip_temp;
+
+	tz->ops->get_trip_temp(tz, trip, &trip_temp);
 
 	/* Ignore disabled trip points */
 	if (test_bit(trip, &tz->trips_disabled))
 		return;
 
 	tz->ops->get_trip_type(tz, trip, &type);
+	tz->ops->get_trip_type(tz, trip, &trip_temp);
+
+	thermal_tripped_notify(tz, trip, trip_type, trip_temp);
 
 	if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
-		handle_critical_trips(tz, trip, type);
+		handle_critical_trips(tz, trip, type, trip_temp);
 	else
 		handle_non_critical_trips(tz, trip, type);
 }
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 743df50..3d0dc30 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -100,6 +100,7 @@ mode_store(struct device *dev, struct device_attribute *attr,
 	mutex_lock(&tz->lock);
 	result = tz->ops->set_mode(tz, mode);
 	mutex_unlock(&tz->lock);
+	thermal_zone_device_update(tz);
 
 	if (result)
 		return result;
diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 15c0a9a..9a5a3a3 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -205,7 +205,6 @@ static int ti_thermal_set_mode(struct thermal_zone_device *thermal,
 	data->mode = mode;
 	ti_bandgap_write_update_interval(bgp, data->sensor_id,
 					data->ti_thermal->polling_delay);
-	thermal_zone_device_update(data->ti_thermal);
 	dev_dbg(&thermal->device, "thermal polling set for duration=%d msec\n",
 		data->ti_thermal->polling_delay);
 
-- 
2.1.4
