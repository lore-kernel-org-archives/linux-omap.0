From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 08/14] thermal: ti-soc-thermal: use common struct
 temp_sensor_data for OMAP5
Date: Mon, 14 May 2018 13:42:15 +0200
Message-ID: <1526298141-14045-9-git-send-email-b.zolnierkie@samsung.com>
References: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180514114337epcas1p1ba67790ed771ab09c0be25712c8b385f@epcas1p1.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-omap@vger.kernel.org

Currently all struct temp_sensor_data instances for OMAP5 are
identical so just use one common structure to avoid duplication.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 .../thermal/ti-soc-thermal/omap5-thermal-data.c    | 42 ++++++----------------
 drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h  | 34 ++++--------------
 2 files changed, 18 insertions(+), 58 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
index a7ca3b6..defa714 100644
--- a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
@@ -114,34 +114,14 @@
 	.bgap_efuse = OMAP5430_FUSE_OPP_BGAP_CORE,
 };
 
-/* Thresholds and limits for OMAP5430 MPU temperature sensor */
-static struct temp_sensor_data omap5430_mpu_temp_sensor_data = {
-	.tshut_hot = OMAP5430_MPU_TSHUT_HOT,
-	.tshut_cold = OMAP5430_MPU_TSHUT_COLD,
-	.t_hot = OMAP5430_MPU_T_HOT,
-	.t_cold = OMAP5430_MPU_T_COLD,
-	.min_freq = OMAP5430_MPU_MIN_FREQ,
-	.max_freq = OMAP5430_MPU_MAX_FREQ,
-};
-
-/* Thresholds and limits for OMAP5430 GPU temperature sensor */
-static struct temp_sensor_data omap5430_gpu_temp_sensor_data = {
-	.tshut_hot = OMAP5430_GPU_TSHUT_HOT,
-	.tshut_cold = OMAP5430_GPU_TSHUT_COLD,
-	.t_hot = OMAP5430_GPU_T_HOT,
-	.t_cold = OMAP5430_GPU_T_COLD,
-	.min_freq = OMAP5430_GPU_MIN_FREQ,
-	.max_freq = OMAP5430_GPU_MAX_FREQ,
-};
-
-/* Thresholds and limits for OMAP5430 CORE temperature sensor */
-static struct temp_sensor_data omap5430_core_temp_sensor_data = {
-	.tshut_hot = OMAP5430_CORE_TSHUT_HOT,
-	.tshut_cold = OMAP5430_CORE_TSHUT_COLD,
-	.t_hot = OMAP5430_CORE_T_HOT,
-	.t_cold = OMAP5430_CORE_T_COLD,
-	.min_freq = OMAP5430_CORE_MIN_FREQ,
-	.max_freq = OMAP5430_CORE_MAX_FREQ,
+/* Thresholds and limits for OMAP5430 MPU/GPU/CORE temperature sensor */
+static struct temp_sensor_data omap5430_temp_sensor_data = {
+	.tshut_hot = OMAP5430_TSHUT_HOT,
+	.tshut_cold = OMAP5430_TSHUT_COLD,
+	.t_hot = OMAP5430_T_HOT,
+	.t_cold = OMAP5430_T_COLD,
+	.min_freq = OMAP5430_MIN_FREQ,
+	.max_freq = OMAP5430_MAX_FREQ,
 };
 
 /*
@@ -264,7 +244,7 @@
 	.sensors = {
 		{
 		.registers = &omap5430_mpu_temp_sensor_registers,
-		.ts_data = &omap5430_mpu_temp_sensor_data,
+		.ts_data = &omap5430_temp_sensor_data,
 		.domain = "cpu",
 		.register_cooling = ti_thermal_register_cpu_cooling,
 		.unregister_cooling = ti_thermal_unregister_cpu_cooling,
@@ -273,14 +253,14 @@
 		},
 		{
 		.registers = &omap5430_gpu_temp_sensor_registers,
-		.ts_data = &omap5430_gpu_temp_sensor_data,
+		.ts_data = &omap5430_temp_sensor_data,
 		.domain = "gpu",
 		.slope_pcb = OMAP_GRADIENT_SLOPE_W_PCB_5430_GPU,
 		.constant_pcb = OMAP_GRADIENT_CONST_W_PCB_5430_GPU,
 		},
 		{
 		.registers = &omap5430_core_temp_sensor_registers,
-		.ts_data = &omap5430_core_temp_sensor_data,
+		.ts_data = &omap5430_temp_sensor_data,
 		.domain = "core",
 		},
 	},
diff --git a/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h b/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
index e931ae0..98438cf 100644
--- a/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
@@ -115,34 +115,14 @@
 #define OMAP5430_ADC_START_VALUE			540
 #define OMAP5430_ADC_END_VALUE				945
 
-/* OMAP5430.GPU temperature definitions */
+/* OMAP5430 sensor temperature definitions */
 /* bandgap clock limits */
-#define OMAP5430_GPU_MAX_FREQ				1500000
-#define OMAP5430_GPU_MIN_FREQ				1000000
+#define OMAP5430_MAX_FREQ				1500000
+#define OMAP5430_MIN_FREQ				1000000
 /* interrupts thresholds */
-#define OMAP5430_GPU_TSHUT_HOT				915
-#define OMAP5430_GPU_TSHUT_COLD				900
-#define OMAP5430_GPU_T_HOT				800
-#define OMAP5430_GPU_T_COLD				795
-
-/* OMAP5430.MPU temperature definitions */
-/* bandgap clock limits */
-#define OMAP5430_MPU_MAX_FREQ				1500000
-#define OMAP5430_MPU_MIN_FREQ				1000000
-/* interrupts thresholds */
-#define OMAP5430_MPU_TSHUT_HOT				915
-#define OMAP5430_MPU_TSHUT_COLD				900
-#define OMAP5430_MPU_T_HOT				800
-#define OMAP5430_MPU_T_COLD				795
-
-/* OMAP5430.CORE temperature definitions */
-/* bandgap clock limits */
-#define OMAP5430_CORE_MAX_FREQ				1500000
-#define OMAP5430_CORE_MIN_FREQ				1000000
-/* interrupts thresholds */
-#define OMAP5430_CORE_TSHUT_HOT				915
-#define OMAP5430_CORE_TSHUT_COLD			900
-#define OMAP5430_CORE_T_HOT				800
-#define OMAP5430_CORE_T_COLD				795
+#define OMAP5430_TSHUT_HOT				915
+#define OMAP5430_TSHUT_COLD				900
+#define OMAP5430_T_HOT					800
+#define OMAP5430_T_COLD					795
 
 #endif /* __OMAP5XXX_BANDGAP_H */
-- 
1.9.1
