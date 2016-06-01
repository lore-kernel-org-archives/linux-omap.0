From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2] thermal: ti-soc-thermal: Add set_emul_temp hook
Date: Wed, 1 Jun 2016 09:29:10 +0530
Message-ID: <1464753550-2529-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: t-kristo@ti.com, j-keerthy@ti.com, nm@ti.com, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Setting the emulation temperature helps reproduce critical
temperature scenarios without risking the actual hardware at
extreme temperatures. Adding __ti_thermal_set_emul_temp as
the set_emul_temp hook.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v2:

  * Rebased on top of:
git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal sysfs_locking

Tested on DRA7/DRA72 baords.

 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 15c0a9a..8d069ee 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -278,6 +278,17 @@ static int ti_thermal_get_trend(struct thermal_zone_device *thermal,
 	return 0;
 }
 
+static int __ti_thermal_set_emul_temp(void *p, int temp)
+{
+	struct ti_thermal_data *data = p;
+	struct thermal_zone_device *tz;
+
+	tz = data->ti_thermal;
+	tz->emul_temperature = temp;
+
+	return 0;
+}
+
 /* Get critical temperature callback functions for thermal zone */
 static int ti_thermal_get_crit_temp(struct thermal_zone_device *thermal,
 				    int *temp)
@@ -289,6 +300,7 @@ static int ti_thermal_get_crit_temp(struct thermal_zone_device *thermal,
 static const struct thermal_zone_of_device_ops ti_of_thermal_ops = {
 	.get_temp = __ti_thermal_get_temp,
 	.get_trend = __ti_thermal_get_trend,
+	.set_emul_temp = __ti_thermal_set_emul_temp,
 };
 
 static struct thermal_zone_device_ops ti_thermal_ops = {
-- 
1.9.1

