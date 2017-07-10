From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] thermal: ti-soc-thermal: Potential error pointer dereferences
Date: Mon, 10 Jul 2017 10:24:23 +0300
Message-ID: <20170710072422.rs25i5oawmiaofrp@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

ti_bandgap_get_sensor_data() can return error pointers so we should
check for that.  There is no need to check "data->ti_thermal" for NULL
and we removed that from the other cleanup function so we may as well
from it in ti_thermal_remove_sensor() to be consistent.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index c211a8e4a210..9fea354ca90c 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -210,7 +210,7 @@ int ti_thermal_remove_sensor(struct ti_bandgap *bgp, int id)
 
 	data = ti_bandgap_get_sensor_data(bgp, id);
 
-	if (data && data->ti_thermal) {
+	if (data && !IS_ERR(data)) {
 		if (data->our_zone)
 			thermal_zone_device_unregister(data->ti_thermal);
 	}
@@ -276,7 +276,7 @@ int ti_thermal_unregister_cpu_cooling(struct ti_bandgap *bgp, int id)
 
 	data = ti_bandgap_get_sensor_data(bgp, id);
 
-	if (data) {
+	if (data && !IS_ERR(data)) {
 		cpufreq_cooling_unregister(data->cool_dev);
 		cpufreq_cpu_put(data->policy);
 	}
