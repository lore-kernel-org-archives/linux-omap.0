From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 2/2] thermal: core: Add a back up thermal shutdown mechanism
Date: Thu, 13 Apr 2017 13:32:36 +0530
Message-ID: <1492070556-24660-2-git-send-email-j-keerthy@ti.com>
References: <1492070556-24660-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1492070556-24660-1-git-send-email-j-keerthy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: j-keerthy@ti.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

orderly_poweroff is triggered when a graceful shutdown
of system is desired. This may be used in many critical states of the
kernel such as when subsystems detects conditions such as critical
temperature conditions. However, in certain conditions in system
boot up sequences like those in the middle of driver probes being
initiated, userspace will be unable to power off the system in a clean
manner and leaves the system in a critical state. In cases like these,
the /sbin/poweroff will return success (having forked off to attempt
powering off the system. However, the system overall will fail to
completely poweroff (since other modules will be probed) and the system
is still functional with no userspace (since that would have shut itself
off).

However, there is no clean way of detecting such failure of userspace
powering off the system. In such scenarios, it is necessary for a backup
workqueue to be able to force a shutdown of the system when orderly
shutdown is not successful after a configurable time period.

Reported-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---

  * Changed the comment style
  * Added backup shutdown call before orderly_poweroff

 drivers/thermal/Kconfig        | 13 ++++++++++++
 drivers/thermal/thermal_core.c | 47 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 9347401..971fd54 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -15,6 +15,19 @@ menuconfig THERMAL
 
 if THERMAL
 
+config THERMAL_EMERGENCY_POWEROFF_DELAY_MS
+	int "Emergency poweroff delay in milli-seconds"
+	depends on THERMAL
+	default 0
+	help
+	  The number of milliseconds to delay before emergency
+	  poweroff kicks in. The delay should be carefully profiled
+	  so as to give adequate time for orderly_poweroff. In case
+	  of failure of an orderly_poweroff the emergency poweroff
+	  kicks in after the delay has elapsed and shuts down the system.
+
+	  If set to 0 poweroff will happen immediately.
+
 config THERMAL_HWMON
 	bool
 	prompt "Expose thermal sensors as hwmon device"
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 7462ae5..d60fa9e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -323,12 +323,54 @@ static void handle_non_critical_trips(struct thermal_zone_device *tz,
 		       def_governor->throttle(tz, trip);
 }
 
+/**
+ * emergency_poweroff_func - emergency poweroff work after a known delay
+ * @work: work_struct associated with the emergency poweroff function
+ *
+ * This function is called in very critical situations to force
+ * a kernel poweroff after a configurable timeout value.
+ */
+static void emergency_poweroff_func(struct work_struct *work)
+{
+	/*
+	 * We have reached here after the emergency thermal shutdown
+	 * Waiting period has expired. This means orderly_poweroff has
+	 * not been able to shut off the system for some reason.
+	 * Try to shut down the system immediately using kernel_power_off
+	 * if populated
+	 */
+	pr_warn("Attempting kernel_power_off\n");
+	kernel_power_off();
+
+	/*
+	 * Worst of the worst case trigger emergency restart
+	 */
+	pr_warn("kernel_power_off has failed! Attempting emergency_restart\n");
+	emergency_restart();
+}
+
+static DECLARE_DELAYED_WORK(emergency_poweroff_work, emergency_poweroff_func);
+
+/**
+ * emergency_poweroff - Trigger an emergency system poweroff
+ *
+ * This may be called from any critical situation to trigger a system shutdown
+ * after a known period of time. By default the delay is 0 millisecond
+ */
+void thermal_emergency_poweroff(void)
+{
+	schedule_delayed_work(&emergency_poweroff_work,
+			      msecs_to_jiffies(CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS));
+}
+
 static void handle_critical_trips(struct thermal_zone_device *tz,
 				  int trip, enum thermal_trip_type trip_type)
 {
 	int trip_temp;
 	static bool power_off_triggered;
+	static struct mutex poweroff_lock;
 
+	mutex_init(&poweroff_lock);
 	tz->ops->get_trip_temp(tz, trip, &trip_temp);
 
 	/* If we have not crossed the trip_temp, we do not care. */
@@ -345,6 +387,11 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 			  "critical temperature reached(%d C),shutting down\n",
 			  tz->temperature / 1000);
 		mutex_lock(&poweroff_lock);
+		/*
+		 * Queue a backup emergency shutdown in the event of
+		 * orderly_poweroff failure.
+		 */
+		thermal_emergency_poweroff();
 		orderly_poweroff(true);
 		power_off_triggered = true;
 		mutex_unlock(&poweroff_lock);
-- 
1.9.1
