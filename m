From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 1/2] thermal: core: Allow orderly_poweroff to be called only once
Date: Thu, 13 Apr 2017 13:32:35 +0530
Message-ID: <1492070556-24660-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: j-keerthy@ti.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

thermal_zone_device_check --> thermal_zone_device_update -->
handle_thermal_trip --> handle_critical_trips --> orderly_poweroff

The above sequence happens every 250/500 mS based on the configuration.
The orderly_poweroff function is getting called every 250/500 mS.
With a full fledged file system it takes at least 5-10 Seconds to
power off gracefully.

In that period due to the thermal_zone_device_check triggering
periodically the thermal work queues bombard with
orderly_poweroff calls multiple times eventually leading to
failures in gracefully powering off the system.

Make sure that orderly_poweroff is called only once.

Reported-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v2:

  * Added a global mutex to serialize poweroff code sequence.

 drivers/thermal/thermal_core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 11f0675..7462ae5 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -45,6 +45,7 @@
 
 static DEFINE_MUTEX(thermal_list_lock);
 static DEFINE_MUTEX(thermal_governor_lock);
+static DEFINE_MUTEX(poweroff_lock);
 
 static atomic_t in_suspend;
 
@@ -326,6 +327,7 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 				  int trip, enum thermal_trip_type trip_type)
 {
 	int trip_temp;
+	static bool power_off_triggered;
 
 	tz->ops->get_trip_temp(tz, trip, &trip_temp);
 
@@ -338,11 +340,14 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 	if (tz->ops->notify)
 		tz->ops->notify(tz, trip, trip_type);
 
-	if (trip_type == THERMAL_TRIP_CRITICAL) {
+	if (trip_type == THERMAL_TRIP_CRITICAL && !power_off_triggered) {
 		dev_emerg(&tz->device,
 			  "critical temperature reached(%d C),shutting down\n",
 			  tz->temperature / 1000);
+		mutex_lock(&poweroff_lock);
 		orderly_poweroff(true);
+		power_off_triggered = true;
+		mutex_unlock(&poweroff_lock);
 	}
 }
 
@@ -1463,6 +1468,7 @@ static int __init thermal_init(void)
 {
 	int result;
 
+	mutex_init(&poweroff_lock);
 	result = thermal_register_governors();
 	if (result)
 		goto error;
@@ -1497,6 +1503,7 @@ static int __init thermal_init(void)
 	ida_destroy(&thermal_cdev_ida);
 	mutex_destroy(&thermal_list_lock);
 	mutex_destroy(&thermal_governor_lock);
+	mutex_destroy(&poweroff_lock);
 	return result;
 }
 
-- 
1.9.1
