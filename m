From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 09/14] thermal: ti-soc-thermal: use common struct
 temp_sensor_data for DRA752
Date: Mon, 14 May 2018 13:42:16 +0200
Message-ID: <1526298141-14045-10-git-send-email-b.zolnierkie@samsung.com>
References: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180514114340epcas2p10a9a4aad3064ad752cd2bea456581a98@epcas2p1.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-omap@vger.kernel.org

Currently all struct temp_sensor_data instances for DRA752 are
identical so just use one common structure to avoid duplication.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/ti-soc-thermal/dra752-bandgap.h    | 42 ++---------------
 .../thermal/ti-soc-thermal/dra752-thermal-data.c   | 54 +++++-----------------
 2 files changed, 16 insertions(+), 80 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/dra752-bandgap.h b/drivers/thermal/ti-soc-thermal/dra752-bandgap.h
index b7156bf..ac324b9 100644
--- a/drivers/thermal/ti-soc-thermal/dra752-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/dra752-bandgap.h
@@ -146,44 +146,12 @@
 #define DRA752_ADC_START_VALUE		540
 #define DRA752_ADC_END_VALUE		945
 
-/* DRA752.GPU temperature definitions */
+/* DRA752 GPU/MPU/CORE/DSPEVE/IVA temperature definitions */
 /* bandgap clock limits */
-#define DRA752_GPU_MAX_FREQ				1500000
-#define DRA752_GPU_MIN_FREQ				1000000
+#define DRA752_MAX_FREQ				1500000
+#define DRA752_MIN_FREQ				1000000
 /* interrupts thresholds */
-#define DRA752_GPU_T_HOT				800
-#define DRA752_GPU_T_COLD				795
-
-/* DRA752.MPU temperature definitions */
-/* bandgap clock limits */
-#define DRA752_MPU_MAX_FREQ				1500000
-#define DRA752_MPU_MIN_FREQ				1000000
-/* interrupts thresholds */
-#define DRA752_MPU_T_HOT				800
-#define DRA752_MPU_T_COLD				795
-
-/* DRA752.CORE temperature definitions */
-/* bandgap clock limits */
-#define DRA752_CORE_MAX_FREQ				1500000
-#define DRA752_CORE_MIN_FREQ				1000000
-/* interrupts thresholds */
-#define DRA752_CORE_T_HOT				800
-#define DRA752_CORE_T_COLD				795
-
-/* DRA752.DSPEVE temperature definitions */
-/* bandgap clock limits */
-#define DRA752_DSPEVE_MAX_FREQ				1500000
-#define DRA752_DSPEVE_MIN_FREQ				1000000
-/* interrupts thresholds */
-#define DRA752_DSPEVE_T_HOT				800
-#define DRA752_DSPEVE_T_COLD				795
-
-/* DRA752.IVA temperature definitions */
-/* bandgap clock limits */
-#define DRA752_IVA_MAX_FREQ				1500000
-#define DRA752_IVA_MIN_FREQ				1000000
-/* interrupts thresholds */
-#define DRA752_IVA_T_HOT				800
-#define DRA752_IVA_T_COLD				795
+#define DRA752_T_HOT				800
+#define DRA752_T_COLD				795
 
 #endif /* __DRA752_BANDGAP_H */
diff --git a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
index a88a0e5..3372cd7 100644
--- a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
@@ -144,44 +144,12 @@
 	.bgap_efuse = DRA752_STD_FUSE_OPP_BGAP_GPU_OFFSET,
 };
 
-/* Thresholds and limits for DRA752 MPU temperature sensor */
-static struct temp_sensor_data dra752_mpu_temp_sensor_data = {
-	.t_hot = DRA752_MPU_T_HOT,
-	.t_cold = DRA752_MPU_T_COLD,
-	.min_freq = DRA752_MPU_MIN_FREQ,
-	.max_freq = DRA752_MPU_MAX_FREQ,
-};
-
-/* Thresholds and limits for DRA752 GPU temperature sensor */
-static struct temp_sensor_data dra752_gpu_temp_sensor_data = {
-	.t_hot = DRA752_GPU_T_HOT,
-	.t_cold = DRA752_GPU_T_COLD,
-	.min_freq = DRA752_GPU_MIN_FREQ,
-	.max_freq = DRA752_GPU_MAX_FREQ,
-};
-
-/* Thresholds and limits for DRA752 CORE temperature sensor */
-static struct temp_sensor_data dra752_core_temp_sensor_data = {
-	.t_hot = DRA752_CORE_T_HOT,
-	.t_cold = DRA752_CORE_T_COLD,
-	.min_freq = DRA752_CORE_MIN_FREQ,
-	.max_freq = DRA752_CORE_MAX_FREQ,
-};
-
-/* Thresholds and limits for DRA752 DSPEVE temperature sensor */
-static struct temp_sensor_data dra752_dspeve_temp_sensor_data = {
-	.t_hot = DRA752_DSPEVE_T_HOT,
-	.t_cold = DRA752_DSPEVE_T_COLD,
-	.min_freq = DRA752_DSPEVE_MIN_FREQ,
-	.max_freq = DRA752_DSPEVE_MAX_FREQ,
-};
-
-/* Thresholds and limits for DRA752 IVA temperature sensor */
-static struct temp_sensor_data dra752_iva_temp_sensor_data = {
-	.t_hot = DRA752_IVA_T_HOT,
-	.t_cold = DRA752_IVA_T_COLD,
-	.min_freq = DRA752_IVA_MIN_FREQ,
-	.max_freq = DRA752_IVA_MAX_FREQ,
+/* Thresholds and limits for DRA752 temperature sensor */
+static struct temp_sensor_data dra752_temp_sensor_data = {
+	.t_hot = DRA752_T_HOT,
+	.t_cold = DRA752_T_COLD,
+	.min_freq = DRA752_MIN_FREQ,
+	.max_freq = DRA752_MAX_FREQ,
 };
 
 /*
@@ -329,7 +297,7 @@
 	.sensors = {
 		{
 		.registers = &dra752_mpu_temp_sensor_registers,
-		.ts_data = &dra752_mpu_temp_sensor_data,
+		.ts_data = &dra752_temp_sensor_data,
 		.domain = "cpu",
 		.register_cooling = ti_thermal_register_cpu_cooling,
 		.unregister_cooling = ti_thermal_unregister_cpu_cooling,
@@ -338,28 +306,28 @@
 		},
 		{
 		.registers = &dra752_gpu_temp_sensor_registers,
-		.ts_data = &dra752_gpu_temp_sensor_data,
+		.ts_data = &dra752_temp_sensor_data,
 		.domain = "gpu",
 		.slope_pcb = DRA752_GRADIENT_SLOPE_W_PCB,
 		.constant_pcb = DRA752_GRADIENT_CONST_W_PCB,
 		},
 		{
 		.registers = &dra752_core_temp_sensor_registers,
-		.ts_data = &dra752_core_temp_sensor_data,
+		.ts_data = &dra752_temp_sensor_data,
 		.domain = "core",
 		.slope_pcb = DRA752_GRADIENT_SLOPE_W_PCB,
 		.constant_pcb = DRA752_GRADIENT_CONST_W_PCB,
 		},
 		{
 		.registers = &dra752_dspeve_temp_sensor_registers,
-		.ts_data = &dra752_dspeve_temp_sensor_data,
+		.ts_data = &dra752_temp_sensor_data,
 		.domain = "dspeve",
 		.slope_pcb = DRA752_GRADIENT_SLOPE_W_PCB,
 		.constant_pcb = DRA752_GRADIENT_CONST_W_PCB,
 		},
 		{
 		.registers = &dra752_iva_temp_sensor_registers,
-		.ts_data = &dra752_iva_temp_sensor_data,
+		.ts_data = &dra752_temp_sensor_data,
 		.domain = "iva",
 		.slope_pcb = DRA752_GRADIENT_SLOPE_W_PCB,
 		.constant_pcb = DRA752_GRADIENT_CONST_W_PCB,
-- 
1.9.1
