From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 04/14] staging: ti-soc-thermal: report alert events on OMAP4 devices
Date: Mon, 1 Apr 2013 12:04:36 -0400
Message-ID: <1364832286-17304-5-git-send-email-eduardo.valentin@ti.com>
References: <1364832286-17304-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1364832286-17304-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

OMAP4460 and OMAP4470 devices have the capability to generate
alert temperature. Thus, whenever a T_ALERT IRQ is served,
the ti-bandgap will call .report_temperature to notify the
thermal framework about thermal zone update request.

This patch allows OMAP4460 and OMAP4470 devices to notify
the thermal framework about T_ALERT events.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 .../staging/ti-soc-thermal/omap4-thermal-data.c    |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/ti-soc-thermal/omap4-thermal-data.c b/drivers/staging/ti-soc-thermal/omap4-thermal-data.c
index 49d0324..ee9c902 100644
--- a/drivers/staging/ti-soc-thermal/omap4-thermal-data.c
+++ b/drivers/staging/ti-soc-thermal/omap4-thermal-data.c
@@ -216,6 +216,7 @@ const struct ti_bandgap_data omap4460_data = {
 	.adc_end_val = OMAP4460_ADC_END_VALUE,
 	.expose_sensor = ti_thermal_expose_sensor,
 	.remove_sensor = ti_thermal_remove_sensor,
+	.report_temperature = ti_thermal_report_sensor_temperature,
 	.sensors = {
 		{
 		.registers = &omap4460_mpu_temp_sensor_registers,
@@ -248,6 +249,7 @@ const struct ti_bandgap_data omap4470_data = {
 	.adc_end_val = OMAP4460_ADC_END_VALUE,
 	.expose_sensor = ti_thermal_expose_sensor,
 	.remove_sensor = ti_thermal_remove_sensor,
+	.report_temperature = ti_thermal_report_sensor_temperature,
 	.sensors = {
 		{
 		.registers = &omap4460_mpu_temp_sensor_registers,
-- 
1.7.7.1.488.ge8e1c

