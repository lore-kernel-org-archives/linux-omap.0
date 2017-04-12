From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH] thermal: core: Allow orderly_poweroff to be called only once
Date: Wed, 12 Apr 2017 14:42:12 +0530
Message-ID: <1491988332-13398-1-git-send-email-j-keerthy@ti.com>
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

Fixes: 0c01ebbfd3caf1d ("Thermal: Remove throttling logic out of thermal_sys.c")
Reported-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/thermal/thermal_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 11f0675..4e68ce0 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -326,6 +326,7 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 				  int trip, enum thermal_trip_type trip_type)
 {
 	int trip_temp;
+	static bool power_off_triggered;
 
 	tz->ops->get_trip_temp(tz, trip, &trip_temp);
 
@@ -338,11 +339,12 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 	if (tz->ops->notify)
 		tz->ops->notify(tz, trip, trip_type);
 
-	if (trip_type == THERMAL_TRIP_CRITICAL) {
+	if (trip_type == THERMAL_TRIP_CRITICAL && !power_off_triggered) {
 		dev_emerg(&tz->device,
 			  "critical temperature reached(%d C),shutting down\n",
 			  tz->temperature / 1000);
 		orderly_poweroff(true);
+		power_off_triggered = true;
 	}
 }
 
-- 
1.9.1
