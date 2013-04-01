From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 05/14] staging: ti-soc-thermal: report alert events on OMAP5 devices
Date: Mon, 1 Apr 2013 12:04:37 -0400
Message-ID: <1364832286-17304-6-git-send-email-eduardo.valentin@ti.com>
References: <1364832286-17304-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1364832286-17304-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

OMAP5430 devices have the capability to generate
alert temperature. Thus, whenever a T_ALERT IRQ is served,
the ti-bandgap will call .report_temperature to notify the
thermal framework about thermal zone update request.

This patch allows OMAP5430 devices to notify
the thermal framework about T_ALERT events.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 .../staging/ti-soc-thermal/omap5-thermal-data.c    |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/ti-soc-thermal/omap5-thermal-data.c b/drivers/staging/ti-soc-thermal/omap5-thermal-data.c
index 0afe9c8..aa16f92 100644
--- a/drivers/staging/ti-soc-thermal/omap5-thermal-data.c
+++ b/drivers/staging/ti-soc-thermal/omap5-thermal-data.c
@@ -323,6 +323,7 @@ const struct ti_bandgap_data omap5430_data = {
 	.adc_end_val = OMAP5430_ADC_END_VALUE,
 	.expose_sensor = ti_thermal_expose_sensor,
 	.remove_sensor = ti_thermal_remove_sensor,
+	.report_temperature = ti_thermal_report_sensor_temperature,
 	.sensors = {
 		{
 		.registers = &omap5430_mpu_temp_sensor_registers,
-- 
1.7.7.1.488.ge8e1c

