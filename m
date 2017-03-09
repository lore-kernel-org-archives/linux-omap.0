From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 7/8] thermal: ti-soc-thermal: Remove redundant constants
Date: Thu, 9 Mar 2017 13:36:01 +0530
Message-ID: <1489046762-11288-8-git-send-email-j-keerthy@ti.com>
References: <1489046762-11288-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1489046762-11288-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, edubezval@gmail.com
Cc: rui.zhang@intel.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robh+dt@kernel.org, t-kristo@ti.com, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

Now that slope and offset data are being passed from
device tree no need to populate in driver data.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/thermal/ti-soc-thermal/dra752-thermal-data.c | 10 ----------
 drivers/thermal/ti-soc-thermal/omap3-thermal-data.c  |  4 ----
 drivers/thermal/ti-soc-thermal/omap4-thermal-data.c  |  6 ------
 drivers/thermal/ti-soc-thermal/omap5-thermal-data.c  |  4 ----
 drivers/thermal/ti-soc-thermal/ti-bandgap.h          |  4 ----
 drivers/thermal/ti-soc-thermal/ti-thermal.h          | 16 ----------------
 6 files changed, 44 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
index 118d7d8..4167373 100644
--- a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
@@ -410,8 +410,6 @@
 		.domain = "cpu",
 		.register_cooling = ti_thermal_register_cpu_cooling,
 		.unregister_cooling = ti_thermal_unregister_cpu_cooling,
-		.slope = DRA752_GRADIENT_SLOPE,
-		.constant = DRA752_GRADIENT_CONST,
 		.slope_pcb = DRA752_GRADIENT_SLOPE_W_PCB,
 		.constant_pcb = DRA752_GRADIENT_CONST_W_PCB,
 		},
@@ -419,8 +417,6 @@
 		.registers = &dra752_gpu_temp_sensor_registers,
 		.ts_data = &dra752_gpu_temp_sensor_data,
 		.domain = "gpu",
-		.slope = DRA752_GRADIENT_SLOPE,
-		.constant = DRA752_GRADIENT_CONST,
 		.slope_pcb = DRA752_GRADIENT_SLOPE_W_PCB,
 		.constant_pcb = DRA752_GRADIENT_CONST_W_PCB,
 		},
@@ -428,8 +424,6 @@
 		.registers = &dra752_core_temp_sensor_registers,
 		.ts_data = &dra752_core_temp_sensor_data,
 		.domain = "core",
-		.slope = DRA752_GRADIENT_SLOPE,
-		.constant = DRA752_GRADIENT_CONST,
 		.slope_pcb = DRA752_GRADIENT_SLOPE_W_PCB,
 		.constant_pcb = DRA752_GRADIENT_CONST_W_PCB,
 		},
@@ -437,8 +431,6 @@
 		.registers = &dra752_dspeve_temp_sensor_registers,
 		.ts_data = &dra752_dspeve_temp_sensor_data,
 		.domain = "dspeve",
-		.slope = DRA752_GRADIENT_SLOPE,
-		.constant = DRA752_GRADIENT_CONST,
 		.slope_pcb = DRA752_GRADIENT_SLOPE_W_PCB,
 		.constant_pcb = DRA752_GRADIENT_CONST_W_PCB,
 		},
@@ -446,8 +438,6 @@
 		.registers = &dra752_iva_temp_sensor_registers,
 		.ts_data = &dra752_iva_temp_sensor_data,
 		.domain = "iva",
-		.slope = DRA752_GRADIENT_SLOPE,
-		.constant = DRA752_GRADIENT_CONST,
 		.slope_pcb = DRA752_GRADIENT_SLOPE_W_PCB,
 		.constant_pcb = DRA752_GRADIENT_CONST_W_PCB,
 		},
diff --git a/drivers/thermal/ti-soc-thermal/omap3-thermal-data.c b/drivers/thermal/ti-soc-thermal/omap3-thermal-data.c
index 3ee3434..c6d2179 100644
--- a/drivers/thermal/ti-soc-thermal/omap3-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/omap3-thermal-data.c
@@ -91,8 +91,6 @@
 		.registers = &omap34xx_mpu_temp_sensor_registers,
 		.ts_data = &omap34xx_mpu_temp_sensor_data,
 		.domain = "cpu",
-		.slope = 0,
-		.constant = 20000,
 		.slope_pcb = 0,
 		.constant_pcb = 20000,
 		.register_cooling = NULL,
@@ -164,8 +162,6 @@
 		.registers = &omap36xx_mpu_temp_sensor_registers,
 		.ts_data = &omap36xx_mpu_temp_sensor_data,
 		.domain = "cpu",
-		.slope = 0,
-		.constant = 20000,
 		.slope_pcb = 0,
 		.constant_pcb = 20000,
 		.register_cooling = NULL,
diff --git a/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c b/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
index d255d33..fd11133 100644
--- a/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
@@ -82,8 +82,6 @@
 		.registers = &omap4430_mpu_temp_sensor_registers,
 		.ts_data = &omap4430_mpu_temp_sensor_data,
 		.domain = "cpu",
-		.slope = OMAP_GRADIENT_SLOPE_4430,
-		.constant = OMAP_GRADIENT_CONST_4430,
 		.slope_pcb = OMAP_GRADIENT_SLOPE_W_PCB_4430,
 		.constant_pcb = OMAP_GRADIENT_CONST_W_PCB_4430,
 		.register_cooling = ti_thermal_register_cpu_cooling,
@@ -222,8 +220,6 @@
 		.registers = &omap4460_mpu_temp_sensor_registers,
 		.ts_data = &omap4460_mpu_temp_sensor_data,
 		.domain = "cpu",
-		.slope = OMAP_GRADIENT_SLOPE_4460,
-		.constant = OMAP_GRADIENT_CONST_4460,
 		.slope_pcb = OMAP_GRADIENT_SLOPE_W_PCB_4460,
 		.constant_pcb = OMAP_GRADIENT_CONST_W_PCB_4460,
 		.register_cooling = ti_thermal_register_cpu_cooling,
@@ -255,8 +251,6 @@
 		.registers = &omap4460_mpu_temp_sensor_registers,
 		.ts_data = &omap4460_mpu_temp_sensor_data,
 		.domain = "cpu",
-		.slope = OMAP_GRADIENT_SLOPE_4470,
-		.constant = OMAP_GRADIENT_CONST_4470,
 		.slope_pcb = OMAP_GRADIENT_SLOPE_W_PCB_4470,
 		.constant_pcb = OMAP_GRADIENT_CONST_W_PCB_4470,
 		.register_cooling = ti_thermal_register_cpu_cooling,
diff --git a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
index 79ff70c..cd9a304 100644
--- a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
@@ -336,8 +336,6 @@
 		.domain = "cpu",
 		.register_cooling = ti_thermal_register_cpu_cooling,
 		.unregister_cooling = ti_thermal_unregister_cpu_cooling,
-		.slope = OMAP_GRADIENT_SLOPE_5430_CPU,
-		.constant = OMAP_GRADIENT_CONST_5430_CPU,
 		.slope_pcb = OMAP_GRADIENT_SLOPE_W_PCB_5430_CPU,
 		.constant_pcb = OMAP_GRADIENT_CONST_W_PCB_5430_CPU,
 		},
@@ -345,8 +343,6 @@
 		.registers = &omap5430_gpu_temp_sensor_registers,
 		.ts_data = &omap5430_gpu_temp_sensor_data,
 		.domain = "gpu",
-		.slope = OMAP_GRADIENT_SLOPE_5430_GPU,
-		.constant = OMAP_GRADIENT_CONST_5430_GPU,
 		.slope_pcb = OMAP_GRADIENT_SLOPE_W_PCB_5430_GPU,
 		.constant_pcb = OMAP_GRADIENT_CONST_W_PCB_5430_GPU,
 		},
diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.h b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
index fe0adb8..209c664 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
@@ -254,8 +254,6 @@ struct ti_bandgap {
  * @ts_data: pointer to struct with thresholds, limits of temperature sensor
  * @registers: pointer to the list of register offsets and bitfields
  * @domain: the name of the domain where the sensor is located
- * @slope: sensor gradient slope info for hotspot extrapolation equation
- * @constant: sensor gradient const info for hotspot extrapolation equation
  * @slope_pcb: sensor gradient slope info for hotspot extrapolation equation
  *             with no external influence
  * @constant_pcb: sensor gradient const info for hotspot extrapolation equation
@@ -274,8 +272,6 @@ struct ti_temp_sensor {
 	struct temp_sensor_registers	*registers;
 	char				*domain;
 	/* for hotspot extrapolation */
-	const int			slope;
-	const int			constant;
 	const int			slope_pcb;
 	const int			constant_pcb;
 	int (*register_cooling)(struct ti_bandgap *bgp, int id);
diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal.h b/drivers/thermal/ti-soc-thermal/ti-thermal.h
index f8b7ffe..8e85ca9 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal.h
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal.h
@@ -25,22 +25,6 @@
 
 #include "ti-bandgap.h"
 
-/* sensors gradient and offsets */
-#define OMAP_GRADIENT_SLOPE_4430				0
-#define OMAP_GRADIENT_CONST_4430				20000
-#define OMAP_GRADIENT_SLOPE_4460				348
-#define OMAP_GRADIENT_CONST_4460				-9301
-#define OMAP_GRADIENT_SLOPE_4470				308
-#define OMAP_GRADIENT_CONST_4470				-7896
-
-#define OMAP_GRADIENT_SLOPE_5430_CPU				65
-#define OMAP_GRADIENT_CONST_5430_CPU				-1791
-#define OMAP_GRADIENT_SLOPE_5430_GPU				117
-#define OMAP_GRADIENT_CONST_5430_GPU				-2992
-
-#define DRA752_GRADIENT_SLOPE					0
-#define DRA752_GRADIENT_CONST					2000
-
 /* PCB sensor calculation constants */
 #define OMAP_GRADIENT_SLOPE_W_PCB_4430				0
 #define OMAP_GRADIENT_CONST_W_PCB_4430				20000
-- 
1.9.1
