From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v5.1 3/5] thermal: streamline get_trend callbacks
Date: Tue,  7 Jun 2016 21:01:39 +0800
Message-ID: <1465304499-14284-1-git-send-email-wxt@rock-chips.com>
References: <1465213489-14898-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1465213489-14898-1-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
To: edubezval@gmail.com, linux-pm@vger.kernel.org
Cc: heiko@sntech.de, j-keerthy@ti.com, s.hauer@pengutronix.de, linux-omap@vger.kernel.org, rui.zhang@intel.com, javi.merino@arm.com, peter@piie.net, dmitry.torokhov@gmail.com, huangtao@rock-chips.com, cf@rock-chips.com, linux-rockchip@lists.infradead.org, smbarber@google.com, briannorris@google.com, dianders@chromium.org, Caesar Wang <wxt@rock-chips.com>
List-Id: linux-omap@vger.kernel.org

From: Sascha Hauer <s.hauer@pengutronix.de>

The .get_trend callback in struct thermal_zone_device_ops has
the prototype:
        int (*get_trend) (struct thermal_zone_device *, int,
                          enum thermal_trend *);
whereas the .get_trend callback in struct thermal_zone_of_device_ops
has:
        int (*get_trend)(void *, long *);

Streamline both prototypes and add the trip argument to the OF callback
aswell and use enum thermal_trend * instead of an integer pointer.

While the OF prototype may be the better one, this should be decided at
framework level and not on OF level.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org
Reviewed-by: Keerthy <j-keerthy@ti.com>

---

Changes in v5.1:
- As the Keerthy comments, change the get_trend for of_thermal.c
- Add the Kee's Reviewed-by, I can remove it if you object it.
- I'm assumed that the Eduardo will apply it. I can do it if Eduardo wants
  me to resend them.

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/thermal/of-thermal.c                       | 16 +-------------
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 25 +++++++---------------
 include/linux/thermal.h                            |  2 +-
 3 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 2d2a06f..20822ab 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -202,25 +202,11 @@ static int of_thermal_get_trend(struct thermal_zone_device *tz, int trip,
 				enum thermal_trend *trend)
 {
 	struct __thermal_zone *data = tz->devdata;
-	long dev_trend;
-	int r;
 
 	if (!data->ops->get_trend)
 		return -EINVAL;
 
-	r = data->ops->get_trend(data->sensor_data, &dev_trend);
-	if (r)
-		return r;
-
-	/* TODO: These intervals might have some thresholds, but in core code */
-	if (dev_trend > 0)
-		*trend = THERMAL_TREND_RAISING;
-	else if (dev_trend < 0)
-		*trend = THERMAL_TREND_DROPPING;
-	else
-		*trend = THERMAL_TREND_STABLE;
-
-	return 0;
+	return data->ops->get_trend(data->sensor_data, trip, trend);
 }
 
 static int of_thermal_bind(struct thermal_zone_device *thermal,
diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 15c0a9a..4a6757c 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -239,7 +239,7 @@ static int ti_thermal_get_trip_temp(struct thermal_zone_device *thermal,
 	return 0;
 }
 
-static int __ti_thermal_get_trend(void *p, long *trend)
+static int __ti_thermal_get_trend(void *p, int trip, enum thermal_trend *trend)
 {
 	struct ti_thermal_data *data = p;
 	struct ti_bandgap *bgp;
@@ -252,22 +252,6 @@ static int __ti_thermal_get_trend(void *p, long *trend)
 	if (ret)
 		return ret;
 
-	*trend = tr;
-
-	return 0;
-}
-
-/* Get the temperature trend callback functions for thermal zone */
-static int ti_thermal_get_trend(struct thermal_zone_device *thermal,
-				int trip, enum thermal_trend *trend)
-{
-	int ret;
-	long tr;
-
-	ret = __ti_thermal_get_trend(thermal->devdata, &tr);
-	if (ret)
-		return ret;
-
 	if (tr > 0)
 		*trend = THERMAL_TREND_RAISING;
 	else if (tr < 0)
@@ -278,6 +262,13 @@ static int ti_thermal_get_trend(struct thermal_zone_device *thermal,
 	return 0;
 }
 
+/* Get the temperature trend callback functions for thermal zone */
+static int ti_thermal_get_trend(struct thermal_zone_device *thermal,
+				int trip, enum thermal_trend *trend)
+{
+	return __ti_thermal_get_trend(thermal->devdata, trip, trend);
+}
+
 /* Get critical temperature callback functions for thermal zone */
 static int ti_thermal_get_crit_temp(struct thermal_zone_device *thermal,
 				    int *temp)
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 2440b8d..d3ce3a5 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -352,7 +352,7 @@ struct thermal_genl_event {
  */
 struct thermal_zone_of_device_ops {
 	int (*get_temp)(void *, int *);
-	int (*get_trend)(void *, long *);
+	int (*get_trend)(void *, int, enum thermal_trend *);
 	int (*set_trips)(void *, int, int);
 	int (*set_emul_temp)(void *, int);
 	int (*set_trip_temp)(void *, int, int);
-- 
1.9.1

