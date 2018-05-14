From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 11/14] thermal: ti-soc-thermal: use OMAP5 register tables
 for DRA752
Date: Mon, 14 May 2018 13:42:18 +0200
Message-ID: <1526298141-14045-12-git-send-email-b.zolnierkie@samsung.com>
References: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180514114346epcas1p4a59f6760861791ae53eac48975c9172a@epcas1p4.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-omap@vger.kernel.org

OMAP5 register tables for MPU, GPU & CORE sensors are almost
identical to these for DRA752 (OMAP5 ones also set value for
.tshut_threshold but it is used only when TSHUT_CONFIG feature
is enabled and DRA752 doesn't enable it) so just use them also
for DRA752 instead of duplicating them.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/ti-soc-thermal/Makefile            |  2 +-
 drivers/thermal/ti-soc-thermal/dra752-bandgap.h    |  4 ++
 .../thermal/ti-soc-thermal/dra752-thermal-data.c   | 75 +---------------------
 .../thermal/ti-soc-thermal/omap5-thermal-data.c    |  8 ++-
 4 files changed, 13 insertions(+), 76 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/Makefile b/drivers/thermal/ti-soc-thermal/Makefile
index f180ebe..aa1c38d 100644
--- a/drivers/thermal/ti-soc-thermal/Makefile
+++ b/drivers/thermal/ti-soc-thermal/Makefile
@@ -2,7 +2,7 @@
 obj-$(CONFIG_TI_SOC_THERMAL)		+= ti-soc-thermal.o
 ti-soc-thermal-y			:= ti-bandgap.o
 ti-soc-thermal-$(CONFIG_TI_THERMAL)	+= ti-thermal-common.o
-ti-soc-thermal-$(CONFIG_DRA752_THERMAL)	+= dra752-thermal-data.o
+ti-soc-thermal-$(CONFIG_DRA752_THERMAL)	+= dra752-thermal-data.o omap5-thermal-data.o
 ti-soc-thermal-$(CONFIG_OMAP3_THERMAL)	+= omap3-thermal-data.o
 ti-soc-thermal-$(CONFIG_OMAP4_THERMAL)	+= omap4-thermal-data.o
 ti-soc-thermal-$(CONFIG_OMAP5_THERMAL)	+= omap5-thermal-data.o
diff --git a/drivers/thermal/ti-soc-thermal/dra752-bandgap.h b/drivers/thermal/ti-soc-thermal/dra752-bandgap.h
index b9d65b4..c39af38 100644
--- a/drivers/thermal/ti-soc-thermal/dra752-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/dra752-bandgap.h
@@ -84,4 +84,8 @@
 #define DRA752_BANDGAP_STATUS_2_HOT_DSPEVE_MASK			BIT(1)
 #define DRA752_BANDGAP_STATUS_2_COLD_DSPEVE_MASK		BIT(0)
 
+extern struct temp_sensor_registers omap5430_mpu_temp_sensor_registers;
+extern struct temp_sensor_registers omap5430_gpu_temp_sensor_registers;
+extern struct temp_sensor_registers omap5430_core_temp_sensor_registers;
+
 #endif /* __DRA752_BANDGAP_H */
diff --git a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
index de412a2..dcc0b10 100644
--- a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
@@ -31,29 +31,6 @@
  */
 
 /*
- * DRA752 CORE thermal sensor register offsets and bit-fields
- */
-static struct temp_sensor_registers
-dra752_core_temp_sensor_registers = {
-	.temp_sensor_ctrl = OMAP5430_TEMP_SENSOR_CORE_OFFSET,
-	.bgap_tempsoff_mask = OMAP5430_BGAP_TEMPSOFF_MASK,
-	.bgap_eocz_mask = OMAP5430_BGAP_TEMP_SENSOR_EOCZ_MASK,
-	.bgap_dtemp_mask = OMAP5430_BGAP_TEMP_SENSOR_DTEMP_MASK,
-	.bgap_mask_ctrl = OMAP5430_BGAP_CTRL_OFFSET,
-	.mask_hot_mask = OMAP5430_MASK_HOT_CORE_MASK,
-	.mask_cold_mask = OMAP5430_MASK_COLD_CORE_MASK,
-	.mask_counter_delay_mask = OMAP5430_MASK_COUNTER_DELAY_MASK,
-	.mask_freeze_mask = OMAP5430_MASK_FREEZE_CORE_MASK,
-	.bgap_threshold = OMAP5430_BGAP_THRESHOLD_CORE_OFFSET,
-	.bgap_status = OMAP5430_BGAP_STATUS_OFFSET,
-	.status_hot_mask = OMAP5430_HOT_CORE_FLAG_MASK,
-	.status_cold_mask = OMAP5430_COLD_CORE_FLAG_MASK,
-	.ctrl_dtemp_1 = OMAP5430_BGAP_DTEMP_CORE_1_OFFSET,
-	.ctrl_dtemp_2 = OMAP5430_BGAP_DTEMP_CORE_2_OFFSET,
-	.bgap_efuse = OMAP5430_FUSE_OPP_BGAP_CORE,
-};
-
-/*
  * DRA752 IVA thermal sensor register offsets and bit-fields
  */
 static struct temp_sensor_registers
@@ -77,29 +54,6 @@
 };
 
 /*
- * DRA752 MPU thermal sensor register offsets and bit-fields
- */
-static struct temp_sensor_registers
-dra752_mpu_temp_sensor_registers = {
-	.temp_sensor_ctrl = OMAP5430_TEMP_SENSOR_MPU_OFFSET,
-	.bgap_tempsoff_mask = OMAP5430_BGAP_TEMPSOFF_MASK,
-	.bgap_eocz_mask = OMAP5430_BGAP_TEMP_SENSOR_EOCZ_MASK,
-	.bgap_dtemp_mask = OMAP5430_BGAP_TEMP_SENSOR_DTEMP_MASK,
-	.bgap_mask_ctrl = OMAP5430_BGAP_CTRL_OFFSET,
-	.mask_hot_mask = OMAP5430_MASK_HOT_MPU_MASK,
-	.mask_cold_mask = OMAP5430_MASK_COLD_MPU_MASK,
-	.mask_counter_delay_mask = OMAP5430_MASK_COUNTER_DELAY_MASK,
-	.mask_freeze_mask = OMAP5430_MASK_FREEZE_MPU_MASK,
-	.bgap_threshold = OMAP5430_BGAP_THRESHOLD_MPU_OFFSET,
-	.bgap_status = OMAP5430_BGAP_STATUS_OFFSET,
-	.status_hot_mask = OMAP5430_HOT_MPU_FLAG_MASK,
-	.status_cold_mask = OMAP5430_COLD_MPU_FLAG_MASK,
-	.ctrl_dtemp_1 = OMAP5430_BGAP_DTEMP_MPU_1_OFFSET,
-	.ctrl_dtemp_2 = OMAP5430_BGAP_DTEMP_MPU_2_OFFSET,
-	.bgap_efuse = OMAP5430_FUSE_OPP_BGAP_MPU,
-};
-
-/*
  * DRA752 DSPEVE thermal sensor register offsets and bit-fields
  */
 static struct temp_sensor_registers
@@ -122,29 +76,6 @@
 	.bgap_efuse = DRA752_STD_FUSE_OPP_BGAP_DSPEVE_OFFSET,
 };
 
-/*
- * DRA752 GPU thermal sensor register offsets and bit-fields
- */
-static struct temp_sensor_registers
-dra752_gpu_temp_sensor_registers = {
-	.temp_sensor_ctrl = OMAP5430_TEMP_SENSOR_GPU_OFFSET,
-	.bgap_tempsoff_mask = OMAP5430_BGAP_TEMPSOFF_MASK,
-	.bgap_eocz_mask = OMAP5430_BGAP_TEMP_SENSOR_EOCZ_MASK,
-	.bgap_dtemp_mask = OMAP5430_BGAP_TEMP_SENSOR_DTEMP_MASK,
-	.bgap_mask_ctrl = OMAP5430_BGAP_CTRL_OFFSET,
-	.mask_hot_mask = OMAP5430_MASK_HOT_GPU_MASK,
-	.mask_cold_mask = OMAP5430_MASK_COLD_GPU_MASK,
-	.mask_counter_delay_mask = OMAP5430_MASK_COUNTER_DELAY_MASK,
-	.mask_freeze_mask = OMAP5430_MASK_FREEZE_GPU_MASK,
-	.bgap_threshold = OMAP5430_BGAP_THRESHOLD_GPU_OFFSET,
-	.bgap_status = OMAP5430_BGAP_STATUS_OFFSET,
-	.status_hot_mask = OMAP5430_HOT_GPU_FLAG_MASK,
-	.status_cold_mask = OMAP5430_COLD_GPU_FLAG_MASK,
-	.ctrl_dtemp_1 = OMAP5430_BGAP_DTEMP_GPU_1_OFFSET,
-	.ctrl_dtemp_2 = OMAP5430_BGAP_DTEMP_GPU_2_OFFSET,
-	.bgap_efuse = OMAP5430_FUSE_OPP_BGAP_GPU,
-};
-
 /* Thresholds and limits for DRA752 temperature sensor */
 static struct temp_sensor_data dra752_temp_sensor_data = {
 	.t_hot = OMAP5430_T_HOT,
@@ -297,7 +228,7 @@
 	.adc_end_val = OMAP5430_ADC_END_VALUE,
 	.sensors = {
 		{
-		.registers = &dra752_mpu_temp_sensor_registers,
+		.registers = &omap5430_mpu_temp_sensor_registers,
 		.ts_data = &dra752_temp_sensor_data,
 		.domain = "cpu",
 		.register_cooling = ti_thermal_register_cpu_cooling,
@@ -306,14 +237,14 @@
 		.constant_pcb = DRA752_GRADIENT_CONST_W_PCB,
 		},
 		{
-		.registers = &dra752_gpu_temp_sensor_registers,
+		.registers = &omap5430_gpu_temp_sensor_registers,
 		.ts_data = &dra752_temp_sensor_data,
 		.domain = "gpu",
 		.slope_pcb = DRA752_GRADIENT_SLOPE_W_PCB,
 		.constant_pcb = DRA752_GRADIENT_CONST_W_PCB,
 		},
 		{
-		.registers = &dra752_core_temp_sensor_registers,
+		.registers = &omap5430_core_temp_sensor_registers,
 		.ts_data = &dra752_temp_sensor_data,
 		.domain = "core",
 		.slope_pcb = DRA752_GRADIENT_SLOPE_W_PCB,
diff --git a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
index defa714..fce6e30 100644
--- a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
@@ -28,7 +28,7 @@
 /*
  * OMAP5430 MPU thermal sensor register offset and bit-fields
  */
-static struct temp_sensor_registers
+struct temp_sensor_registers
 omap5430_mpu_temp_sensor_registers = {
 	.temp_sensor_ctrl = OMAP5430_TEMP_SENSOR_MPU_OFFSET,
 	.bgap_tempsoff_mask = OMAP5430_BGAP_TEMPSOFF_MASK,
@@ -57,7 +57,7 @@
 /*
  * OMAP5430 GPU thermal sensor register offset and bit-fields
  */
-static struct temp_sensor_registers
+struct temp_sensor_registers
 omap5430_gpu_temp_sensor_registers = {
 	.temp_sensor_ctrl = OMAP5430_TEMP_SENSOR_GPU_OFFSET,
 	.bgap_tempsoff_mask = OMAP5430_BGAP_TEMPSOFF_MASK,
@@ -87,7 +87,7 @@
 /*
  * OMAP5430 CORE thermal sensor register offset and bit-fields
  */
-static struct temp_sensor_registers
+struct temp_sensor_registers
 omap5430_core_temp_sensor_registers = {
 	.temp_sensor_ctrl = OMAP5430_TEMP_SENSOR_CORE_OFFSET,
 	.bgap_tempsoff_mask = OMAP5430_BGAP_TEMPSOFF_MASK,
@@ -114,6 +114,7 @@
 	.bgap_efuse = OMAP5430_FUSE_OPP_BGAP_CORE,
 };
 
+#ifdef CONFIG_OMAP5_THERMAL
 /* Thresholds and limits for OMAP5430 MPU/GPU/CORE temperature sensor */
 static struct temp_sensor_data omap5430_temp_sensor_data = {
 	.tshut_hot = OMAP5430_TSHUT_HOT,
@@ -266,3 +267,4 @@
 	},
 	.sensor_count = 3,
 };
+#endif /* CONFIG_OMAP5_THERMAL */
-- 
1.9.1
