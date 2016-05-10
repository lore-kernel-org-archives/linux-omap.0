From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH] thermal: ti-soc-thermal: Add set_emul_temp hook
Date: Tue, 10 May 2016 17:12:10 +0530
Message-ID: <1462880530-13935-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, nm@ti.com, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

Setting the emulation temperature helps reproduce critical
temperature scenarios without risking the actual hardware at
extreme temperatures. Adding __ti_thermal_set_emul_temp as
the set_emul_temp hook.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Tested the emulation temperature feature on DRA72-EVM.

 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index b213a12..e6f7025 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -278,6 +278,20 @@ static int ti_thermal_get_trend(struct thermal_zone_device *thermal,
 	return 0;
 }
 
+static int __ti_thermal_set_emul_temp(void *p, int temp)
+{
+	struct ti_thermal_data *data = p;
+	struct thermal_zone_device *tz;
+
+	tz = data->ti_thermal;
+
+	mutex_lock(&tz->lock);
+	tz->emul_temperature = temp;
+	mutex_unlock(&tz->lock);
+
+	return 0;
+}
+
 /* Get critical temperature callback functions for thermal zone */
 static int ti_thermal_get_crit_temp(struct thermal_zone_device *thermal,
 				    int *temp)
@@ -289,6 +303,7 @@ static int ti_thermal_get_crit_temp(struct thermal_zone_device *thermal,
 static const struct thermal_zone_of_device_ops ti_of_thermal_ops = {
 	.get_temp = __ti_thermal_get_temp,
 	.get_trend = __ti_thermal_get_trend,
+	.set_emul_temp = __ti_thermal_set_emul_temp,
 };
 
 static struct thermal_zone_device_ops ti_thermal_ops = {
-- 
1.9.1

