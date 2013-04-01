From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 14/14] staging: ti-soc-thermal: Add get_trend support
Date: Mon, 1 Apr 2013 12:04:46 -0400
Message-ID: <1364832286-17304-15-git-send-email-eduardo.valentin@ti.com>
References: <1364832286-17304-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1364832286-17304-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, J Keerthy <j-keerthy@ti.com>, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

From: J Keerthy <j-keerthy@ti.com>

Patch adds get_trend functionality for OMAP Bandgap thermal devices.

Signed-off-by: J Keerthy <j-keerthy@ti.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/ti-soc-thermal/ti-thermal-common.c |   27 +++++++++++++++++++-
 1 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/ti-soc-thermal/ti-thermal-common.c b/drivers/staging/ti-soc-thermal/ti-thermal-common.c
index 231c549..092b39d 100644
--- a/drivers/staging/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/staging/ti-soc-thermal/ti-thermal-common.c
@@ -215,6 +215,31 @@ static int ti_thermal_get_trip_temp(struct thermal_zone_device *thermal,
 	return 0;
 }
 
+/* Get the temperature trend callback functions for thermal zone */
+static int ti_thermal_get_trend(struct thermal_zone_device *thermal,
+				int trip, enum thermal_trend *trend)
+{
+	struct ti_thermal_data *data = thermal->devdata;
+	struct ti_bandgap *bgp;
+	int id, tr, ret = 0;
+
+	bgp = data->bgp;
+	id = data->sensor_id;
+
+	ret = ti_bandgap_get_trend(bgp, id, &tr);
+	if (ret)
+		return ret;
+
+	if (tr > 0)
+		*trend = THERMAL_TREND_RAISING;
+	else if (tr < 0)
+		*trend = THERMAL_TREND_DROPPING;
+	else
+		*trend = THERMAL_TREND_STABLE;
+
+	return 0;
+}
+
 /* Get critical temperature callback functions for thermal zone */
 static int ti_thermal_get_crit_temp(struct thermal_zone_device *thermal,
 				    unsigned long *temp)
@@ -225,7 +250,7 @@ static int ti_thermal_get_crit_temp(struct thermal_zone_device *thermal,
 
 static struct thermal_zone_device_ops ti_thermal_ops = {
 	.get_temp = ti_thermal_get_temp,
-	/* TODO: add .get_trend */
+	.get_trend = ti_thermal_get_trend,
 	.bind = ti_thermal_bind,
 	.unbind = ti_thermal_unbind,
 	.get_mode = ti_thermal_get_mode,
-- 
1.7.7.1.488.ge8e1c

