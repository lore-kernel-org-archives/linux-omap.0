From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 1/1] thermal: core: call thermal_zone_device_update() after mode update
Date: Tue, 21 Jun 2016 22:15:46 -0700
Message-ID: <1466572546-12944-1-git-send-email-edubezval@gmail.com>
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
Please ignore last version.

V1-> V2:
Cleaned the patch and remove unrelated changes.
---

 drivers/acpi/thermal.c                             | 2 --
 drivers/platform/x86/acerhdf.c                     | 1 -
 drivers/thermal/imx_thermal.c                      | 1 -
 drivers/thermal/of-thermal.c                       | 1 -
 drivers/thermal/thermal_sysfs.c                    | 1 +
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 1 -
 6 files changed, 1 insertion(+), 6 deletions(-)

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
index b8e509c..4602e2e 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -292,7 +292,6 @@ static int of_thermal_set_mode(struct thermal_zone_device *tz,
 	mutex_unlock(&tz->lock);
 
 	data->mode = mode;
-	thermal_zone_device_update(tz);
 
 	return 0;
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
