From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 05/14] thermal: ti-soc-thermal: remove redundant methods
 from struct ti_bandgap_data
Date: Mon, 14 May 2018 13:42:12 +0200
Message-ID: <1526298141-14045-6-git-send-email-b.zolnierkie@samsung.com>
References: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180514114326epcas2p2e27987b5be7a1fe614114466c6cf30f8@epcas2p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-omap@vger.kernel.org

* Include ti-thermal.h header in ti-bandgap.c.

* ->expose_sensor and ->remove_sensor methods are always defined
  and set to ti_thermal_[expose,remove]_sensor() so we can use
  these functions directly (dummy functions will be provided in
  case of CONFIG_TI_THERMAL=n).

* ->report_temperature is defined only when TALERT feature is
  supported so it also redundant - it is only used when TALERT
  feature is enabled and the method is always defined to
  ti_thermal_report_sensor_temperature() (dummy function will
  be provided in case of CONFIG_TI_THERMAL=n).

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/ti-soc-thermal/dra752-thermal-data.c |  3 ---
 drivers/thermal/ti-soc-thermal/omap3-thermal-data.c  |  6 ------
 drivers/thermal/ti-soc-thermal/omap4-thermal-data.c  |  8 --------
 drivers/thermal/ti-soc-thermal/omap5-thermal-data.c  |  3 ---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c          | 20 ++++++++------------
 drivers/thermal/ti-soc-thermal/ti-bandgap.h          |  6 ------
 6 files changed, 8 insertions(+), 38 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
index e8ab7e5..c854642 100644
--- a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
@@ -336,9 +336,6 @@
 	.conv_table = dra752_adc_to_temp,
 	.adc_start_val = DRA752_ADC_START_VALUE,
 	.adc_end_val = DRA752_ADC_END_VALUE,
-	.expose_sensor = ti_thermal_expose_sensor,
-	.remove_sensor = ti_thermal_remove_sensor,
-	.report_temperature = ti_thermal_report_sensor_temperature,
 	.sensors = {
 		{
 		.registers = &dra752_mpu_temp_sensor_registers,
diff --git a/drivers/thermal/ti-soc-thermal/omap3-thermal-data.c b/drivers/thermal/ti-soc-thermal/omap3-thermal-data.c
index f536680..cc6498e 100644
--- a/drivers/thermal/ti-soc-thermal/omap3-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/omap3-thermal-data.c
@@ -80,9 +80,6 @@
 	.conv_table = omap34xx_adc_to_temp,
 	.adc_start_val = 0,
 	.adc_end_val = 127,
-	.expose_sensor = ti_thermal_expose_sensor,
-	.remove_sensor = ti_thermal_remove_sensor,
-
 	.sensors = {
 		{
 		.registers = &omap34xx_mpu_temp_sensor_registers,
@@ -148,9 +145,6 @@
 	.conv_table = omap36xx_adc_to_temp,
 	.adc_start_val = 0,
 	.adc_end_val = 127,
-	.expose_sensor = ti_thermal_expose_sensor,
-	.remove_sensor = ti_thermal_remove_sensor,
-
 	.sensors = {
 		{
 		.registers = &omap36xx_mpu_temp_sensor_registers,
diff --git a/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c b/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
index 85ba9dc..14d9fe2 100644
--- a/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
@@ -72,8 +72,6 @@
 	.conv_table = omap4430_adc_to_temp,
 	.adc_start_val = OMAP4430_ADC_START_VALUE,
 	.adc_end_val = OMAP4430_ADC_END_VALUE,
-	.expose_sensor = ti_thermal_expose_sensor,
-	.remove_sensor = ti_thermal_remove_sensor,
 	.sensors = {
 		{
 		.registers = &omap4430_mpu_temp_sensor_registers,
@@ -202,9 +200,6 @@
 	.conv_table = omap4460_adc_to_temp,
 	.adc_start_val = OMAP4460_ADC_START_VALUE,
 	.adc_end_val = OMAP4460_ADC_END_VALUE,
-	.expose_sensor = ti_thermal_expose_sensor,
-	.remove_sensor = ti_thermal_remove_sensor,
-	.report_temperature = ti_thermal_report_sensor_temperature,
 	.sensors = {
 		{
 		.registers = &omap4460_mpu_temp_sensor_registers,
@@ -233,9 +228,6 @@
 	.conv_table = omap4460_adc_to_temp,
 	.adc_start_val = OMAP4460_ADC_START_VALUE,
 	.adc_end_val = OMAP4460_ADC_END_VALUE,
-	.expose_sensor = ti_thermal_expose_sensor,
-	.remove_sensor = ti_thermal_remove_sensor,
-	.report_temperature = ti_thermal_report_sensor_temperature,
 	.sensors = {
 		{
 		.registers = &omap4460_mpu_temp_sensor_registers,
diff --git a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
index e384be1..843faa7 100644
--- a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
@@ -273,9 +273,6 @@
 	.conv_table = omap5430_adc_to_temp,
 	.adc_start_val = OMAP5430_ADC_START_VALUE,
 	.adc_end_val = OMAP5430_ADC_END_VALUE,
-	.expose_sensor = ti_thermal_expose_sensor,
-	.remove_sensor = ti_thermal_remove_sensor,
-	.report_temperature = ti_thermal_report_sensor_temperature,
 	.sensors = {
 		{
 		.registers = &omap5430_mpu_temp_sensor_registers,
diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index 097328d..3ac74fe 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -42,6 +42,7 @@
 #include <linux/io.h>
 
 #include "ti-bandgap.h"
+#include "ti-thermal.h"
 
 static int ti_bandgap_force_single_read(struct ti_bandgap *bgp, int id);
 
@@ -248,8 +249,7 @@ static irqreturn_t ti_bandgap_talert_irq_handler(int irq, void *data)
 			t_hot, t_cold);
 
 		/* report temperature to whom may concern */
-		if (bgp->conf->report_temperature)
-			bgp->conf->report_temperature(bgp, i);
+		ti_thermal_report_sensor_temperature(bgp, i);
 	}
 	spin_unlock(&bgp->lock);
 
@@ -1017,12 +1017,10 @@ int ti_bandgap_probe(struct platform_device *pdev)
 				goto remove_sensors;
 		}
 
-		if (bgp->conf->expose_sensor) {
-			domain = bgp->conf->sensors[i].domain;
-			ret = bgp->conf->expose_sensor(bgp, i, domain);
-			if (ret)
-				goto remove_last_cooling;
-		}
+		domain = bgp->conf->sensors[i].domain;
+		ret = ti_thermal_expose_sensor(bgp, i, domain);
+		if (ret)
+			goto remove_last_cooling;
 	}
 
 	/*
@@ -1048,8 +1046,7 @@ int ti_bandgap_probe(struct platform_device *pdev)
 	for (i--; i >= 0; i--) {
 		if (bgp->conf->sensors[i].unregister_cooling)
 			bgp->conf->sensors[i].unregister_cooling(bgp, i);
-		if (bgp->conf->remove_sensor)
-			bgp->conf->remove_sensor(bgp, i);
+		ti_thermal_remove_sensor(bgp, i);
 	}
 	ti_bandgap_power(bgp, false);
 disable_clk:
@@ -1079,8 +1076,7 @@ int ti_bandgap_remove(struct platform_device *pdev)
 		if (bgp->conf->sensors[i].unregister_cooling)
 			bgp->conf->sensors[i].unregister_cooling(bgp, i);
 
-		if (bgp->conf->remove_sensor)
-			bgp->conf->remove_sensor(bgp, i);
+		ti_thermal_remove_sensor(bgp, i);
 	}
 
 	ti_bandgap_power(bgp, false);
diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.h b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
index 68d39ad..809dbdc 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
@@ -313,9 +313,6 @@ struct ti_temp_sensor {
  * @fclock_name: clock name of the functional clock
  * @div_ck_name: clock name of the clock divisor
  * @sensor_count: count of temperature sensor within this bandgap device
- * @report_temperature: callback to report thermal alert to thermal API
- * @expose_sensor: callback to export sensor to thermal API
- * @remove_sensor: callback to destroy sensor from thermal API
  * @sensors: array of sensors present in this bandgap instance
  *
  * This is a data structure which should hold most of the static configuration
@@ -332,9 +329,6 @@ struct ti_bandgap_data {
 	char				*fclock_name;
 	char				*div_ck_name;
 	int				sensor_count;
-	int (*report_temperature)(struct ti_bandgap *bgp, int id);
-	int (*expose_sensor)(struct ti_bandgap *bgp, int id, char *domain);
-	int (*remove_sensor)(struct ti_bandgap *bgp, int id);
 
 	/* this needs to be at the end */
 	struct ti_temp_sensor		sensors[];
-- 
1.9.1
