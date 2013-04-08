From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 4/8] staging: ti-soc-thermal: introduce OMAP4430 extrapolation constants
Date: Mon, 8 Apr 2013 08:19:10 -0400
Message-ID: <1365423555-2669-5-git-send-email-eduardo.valentin@ti.com>
References: <1365423555-2669-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1365423555-2669-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch defines and utilizes the extrapolation constants for OMAP4430.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 .../staging/ti-soc-thermal/omap4-thermal-data.c    |    8 ++++----
 drivers/staging/ti-soc-thermal/ti-thermal.h        |    4 ++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/ti-soc-thermal/omap4-thermal-data.c b/drivers/staging/ti-soc-thermal/omap4-thermal-data.c
index ee9c902..d255d33 100644
--- a/drivers/staging/ti-soc-thermal/omap4-thermal-data.c
+++ b/drivers/staging/ti-soc-thermal/omap4-thermal-data.c
@@ -82,10 +82,10 @@ const struct ti_bandgap_data omap4430_data = {
 		.registers = &omap4430_mpu_temp_sensor_registers,
 		.ts_data = &omap4430_mpu_temp_sensor_data,
 		.domain = "cpu",
-		.slope = 0,
-		.constant = 20000,
-		.slope_pcb = 0,
-		.constant_pcb = 20000,
+		.slope = OMAP_GRADIENT_SLOPE_4430,
+		.constant = OMAP_GRADIENT_CONST_4430,
+		.slope_pcb = OMAP_GRADIENT_SLOPE_W_PCB_4430,
+		.constant_pcb = OMAP_GRADIENT_CONST_W_PCB_4430,
 		.register_cooling = ti_thermal_register_cpu_cooling,
 		.unregister_cooling = ti_thermal_unregister_cpu_cooling,
 		},
diff --git a/drivers/staging/ti-soc-thermal/ti-thermal.h b/drivers/staging/ti-soc-thermal/ti-thermal.h
index 7b2d600..47cc902 100644
--- a/drivers/staging/ti-soc-thermal/ti-thermal.h
+++ b/drivers/staging/ti-soc-thermal/ti-thermal.h
@@ -26,6 +26,8 @@
 #include "ti-bandgap.h"
 
 /* sensors gradient and offsets */
+#define OMAP_GRADIENT_SLOPE_4430				0
+#define OMAP_GRADIENT_CONST_4430				20000
 #define OMAP_GRADIENT_SLOPE_4460				348
 #define OMAP_GRADIENT_CONST_4460				-9301
 #define OMAP_GRADIENT_SLOPE_4470				308
@@ -37,6 +39,8 @@
 #define OMAP_GRADIENT_CONST_5430_GPU				978
 
 /* PCB sensor calculation constants */
+#define OMAP_GRADIENT_SLOPE_W_PCB_4430				0
+#define OMAP_GRADIENT_CONST_W_PCB_4430				20000
 #define OMAP_GRADIENT_SLOPE_W_PCB_4460				1142
 #define OMAP_GRADIENT_CONST_W_PCB_4460				-393
 #define OMAP_GRADIENT_SLOPE_W_PCB_4470				1063
-- 
1.7.7.1.488.ge8e1c

