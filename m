From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 01/14] thermal: ti-soc-thermal: fix TALERT IRQ handling for
 DRA752
Date: Mon, 14 May 2018 13:42:08 +0200
Message-ID: <1526298141-14045-2-git-send-email-b.zolnierkie@samsung.com>
References: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180514114302epcas1p1890ad3296302900a736262b5d67aa10e@epcas1p1.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-omap@vger.kernel.org

.report_temperature is not set in dra752_data which
results in temperature updates not being propagated by
ti_bandgap_talert_irq_handler() (it doesn't make much
sense to handle TALERT IRQ without reporting temperature
updates to the thermal core). Fix it.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/ti-soc-thermal/dra752-thermal-data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
index 33a3030..e8ab7e5 100644
--- a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
@@ -338,6 +338,7 @@
 	.adc_end_val = DRA752_ADC_END_VALUE,
 	.expose_sensor = ti_thermal_expose_sensor,
 	.remove_sensor = ti_thermal_remove_sensor,
+	.report_temperature = ti_thermal_report_sensor_temperature,
 	.sensors = {
 		{
 		.registers = &dra752_mpu_temp_sensor_registers,
-- 
1.9.1
