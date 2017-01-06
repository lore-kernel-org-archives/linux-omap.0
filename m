From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 2/2] thermal: arm: dra752: Remove all TSHUT related definitions
Date: Fri, 6 Jan 2017 11:31:43 +0530
Message-ID: <1483682503-27803-3-git-send-email-j-keerthy@ti.com>
References: <1483682503-27803-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1483682503-27803-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: rui.zhang@intel.com, linux-kernel@vger.kernel.org, j-keerthy@ti.com, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, rk@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

No configuration needs to be done for TSHUT from software.
Hence remove all the unnecessary definitions.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/thermal/ti-soc-thermal/dra752-bandgap.h    | 19 ----------------
 .../thermal/ti-soc-thermal/dra752-thermal-data.c   | 25 ----------------------
 2 files changed, 44 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/dra752-bandgap.h b/drivers/thermal/ti-soc-thermal/dra752-bandgap.h
index 6b0f2b1..a31e4b5 100644
--- a/drivers/thermal/ti-soc-thermal/dra752-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/dra752-bandgap.h
@@ -54,7 +54,6 @@
 #define DRA752_STD_FUSE_OPP_BGAP_CORE_OFFSET		0x8
 #define DRA752_TEMP_SENSOR_CORE_OFFSET			0x154
 #define DRA752_BANDGAP_THRESHOLD_CORE_OFFSET		0x1ac
-#define DRA752_BANDGAP_TSHUT_CORE_OFFSET		0x1b8
 #define DRA752_BANDGAP_CUMUL_DTEMP_CORE_OFFSET		0x1c4
 #define DRA752_DTEMP_CORE_0_OFFSET			0x208
 #define DRA752_DTEMP_CORE_1_OFFSET			0x20c
@@ -66,7 +65,6 @@
 #define DRA752_STD_FUSE_OPP_BGAP_IVA_OFFSET		0x388
 #define DRA752_TEMP_SENSOR_IVA_OFFSET			0x398
 #define DRA752_BANDGAP_THRESHOLD_IVA_OFFSET		0x3a4
-#define DRA752_BANDGAP_TSHUT_IVA_OFFSET			0x3ac
 #define DRA752_BANDGAP_CUMUL_DTEMP_IVA_OFFSET		0x3b4
 #define DRA752_DTEMP_IVA_0_OFFSET			0x3d0
 #define DRA752_DTEMP_IVA_1_OFFSET			0x3d4
@@ -78,7 +76,6 @@
 #define DRA752_STD_FUSE_OPP_BGAP_MPU_OFFSET		0x4
 #define DRA752_TEMP_SENSOR_MPU_OFFSET			0x14c
 #define DRA752_BANDGAP_THRESHOLD_MPU_OFFSET		0x1a4
-#define DRA752_BANDGAP_TSHUT_MPU_OFFSET			0x1b0
 #define DRA752_BANDGAP_CUMUL_DTEMP_MPU_OFFSET		0x1bc
 #define DRA752_DTEMP_MPU_0_OFFSET			0x1e0
 #define DRA752_DTEMP_MPU_1_OFFSET			0x1e4
@@ -90,7 +87,6 @@
 #define DRA752_STD_FUSE_OPP_BGAP_DSPEVE_OFFSET			0x384
 #define DRA752_TEMP_SENSOR_DSPEVE_OFFSET			0x394
 #define DRA752_BANDGAP_THRESHOLD_DSPEVE_OFFSET			0x3a0
-#define DRA752_BANDGAP_TSHUT_DSPEVE_OFFSET			0x3a8
 #define DRA752_BANDGAP_CUMUL_DTEMP_DSPEVE_OFFSET		0x3b0
 #define DRA752_DTEMP_DSPEVE_0_OFFSET				0x3bc
 #define DRA752_DTEMP_DSPEVE_1_OFFSET				0x3c0
@@ -102,7 +98,6 @@
 #define DRA752_STD_FUSE_OPP_BGAP_GPU_OFFSET		0x0
 #define DRA752_TEMP_SENSOR_GPU_OFFSET			0x150
 #define DRA752_BANDGAP_THRESHOLD_GPU_OFFSET		0x1a8
-#define DRA752_BANDGAP_TSHUT_GPU_OFFSET			0x1b4
 #define DRA752_BANDGAP_CUMUL_DTEMP_GPU_OFFSET		0x1c0
 #define DRA752_DTEMP_GPU_0_OFFSET			0x1f4
 #define DRA752_DTEMP_GPU_1_OFFSET			0x1f8
@@ -173,10 +168,6 @@
 #define DRA752_BANDGAP_THRESHOLD_HOT_MASK		(0x3ff << 16)
 #define DRA752_BANDGAP_THRESHOLD_COLD_MASK		(0x3ff << 0)
 
-/* DRA752.TSHUT_THRESHOLD */
-#define DRA752_TSHUT_THRESHOLD_MUXCTRL_MASK		BIT(31)
-#define DRA752_TSHUT_THRESHOLD_HOT_MASK			(0x3ff << 16)
-#define DRA752_TSHUT_THRESHOLD_COLD_MASK		(0x3ff << 0)
 
 /* DRA752.BANDGAP_CUMUL_DTEMP_CORE */
 #define DRA752_BANDGAP_CUMUL_DTEMP_CORE_MASK		(0xffffffff << 0)
@@ -216,8 +207,6 @@
 #define DRA752_GPU_MAX_TEMP				125000
 #define DRA752_GPU_HYST_VAL				5000
 /* interrupts thresholds */
-#define DRA752_GPU_TSHUT_HOT				915
-#define DRA752_GPU_TSHUT_COLD				900
 #define DRA752_GPU_T_HOT				800
 #define DRA752_GPU_T_COLD				795
 
@@ -230,8 +219,6 @@
 #define DRA752_MPU_MAX_TEMP				125000
 #define DRA752_MPU_HYST_VAL				5000
 /* interrupts thresholds */
-#define DRA752_MPU_TSHUT_HOT				915
-#define DRA752_MPU_TSHUT_COLD				900
 #define DRA752_MPU_T_HOT				800
 #define DRA752_MPU_T_COLD				795
 
@@ -244,8 +231,6 @@
 #define DRA752_CORE_MAX_TEMP				125000
 #define DRA752_CORE_HYST_VAL				5000
 /* interrupts thresholds */
-#define DRA752_CORE_TSHUT_HOT				915
-#define DRA752_CORE_TSHUT_COLD				900
 #define DRA752_CORE_T_HOT				800
 #define DRA752_CORE_T_COLD				795
 
@@ -258,8 +243,6 @@
 #define DRA752_DSPEVE_MAX_TEMP				125000
 #define DRA752_DSPEVE_HYST_VAL				5000
 /* interrupts thresholds */
-#define DRA752_DSPEVE_TSHUT_HOT				915
-#define DRA752_DSPEVE_TSHUT_COLD			900
 #define DRA752_DSPEVE_T_HOT				800
 #define DRA752_DSPEVE_T_COLD				795
 
@@ -272,8 +255,6 @@
 #define DRA752_IVA_MAX_TEMP				125000
 #define DRA752_IVA_HYST_VAL				5000
 /* interrupts thresholds */
-#define DRA752_IVA_TSHUT_HOT				915
-#define DRA752_IVA_TSHUT_COLD				900
 #define DRA752_IVA_T_HOT				800
 #define DRA752_IVA_T_COLD				795
 
diff --git a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
index 0a3f88d..118d7d8 100644
--- a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
@@ -49,9 +49,6 @@
 	.bgap_threshold = DRA752_BANDGAP_THRESHOLD_CORE_OFFSET,
 	.threshold_thot_mask = DRA752_BANDGAP_THRESHOLD_HOT_MASK,
 	.threshold_tcold_mask = DRA752_BANDGAP_THRESHOLD_COLD_MASK,
-	.tshut_threshold = DRA752_BANDGAP_TSHUT_CORE_OFFSET,
-	.tshut_hot_mask = DRA752_TSHUT_THRESHOLD_HOT_MASK,
-	.tshut_cold_mask = DRA752_TSHUT_THRESHOLD_COLD_MASK,
 	.bgap_status = DRA752_BANDGAP_STATUS_1_OFFSET,
 	.status_bgap_alert_mask = DRA752_BANDGAP_STATUS_1_ALERT_MASK,
 	.status_hot_mask = DRA752_BANDGAP_STATUS_1_HOT_CORE_MASK,
@@ -85,9 +82,6 @@
 	.bgap_threshold = DRA752_BANDGAP_THRESHOLD_IVA_OFFSET,
 	.threshold_thot_mask = DRA752_BANDGAP_THRESHOLD_HOT_MASK,
 	.threshold_tcold_mask = DRA752_BANDGAP_THRESHOLD_COLD_MASK,
-	.tshut_threshold = DRA752_BANDGAP_TSHUT_IVA_OFFSET,
-	.tshut_hot_mask = DRA752_TSHUT_THRESHOLD_HOT_MASK,
-	.tshut_cold_mask = DRA752_TSHUT_THRESHOLD_COLD_MASK,
 	.bgap_status = DRA752_BANDGAP_STATUS_2_OFFSET,
 	.status_bgap_alert_mask = DRA752_BANDGAP_STATUS_1_ALERT_MASK,
 	.status_hot_mask = DRA752_BANDGAP_STATUS_2_HOT_IVA_MASK,
@@ -121,9 +115,6 @@
 	.bgap_threshold = DRA752_BANDGAP_THRESHOLD_MPU_OFFSET,
 	.threshold_thot_mask = DRA752_BANDGAP_THRESHOLD_HOT_MASK,
 	.threshold_tcold_mask = DRA752_BANDGAP_THRESHOLD_COLD_MASK,
-	.tshut_threshold = DRA752_BANDGAP_TSHUT_MPU_OFFSET,
-	.tshut_hot_mask = DRA752_TSHUT_THRESHOLD_HOT_MASK,
-	.tshut_cold_mask = DRA752_TSHUT_THRESHOLD_COLD_MASK,
 	.bgap_status = DRA752_BANDGAP_STATUS_1_OFFSET,
 	.status_bgap_alert_mask = DRA752_BANDGAP_STATUS_1_ALERT_MASK,
 	.status_hot_mask = DRA752_BANDGAP_STATUS_1_HOT_MPU_MASK,
@@ -157,9 +148,6 @@
 	.bgap_threshold = DRA752_BANDGAP_THRESHOLD_DSPEVE_OFFSET,
 	.threshold_thot_mask = DRA752_BANDGAP_THRESHOLD_HOT_MASK,
 	.threshold_tcold_mask = DRA752_BANDGAP_THRESHOLD_COLD_MASK,
-	.tshut_threshold = DRA752_BANDGAP_TSHUT_DSPEVE_OFFSET,
-	.tshut_hot_mask = DRA752_TSHUT_THRESHOLD_HOT_MASK,
-	.tshut_cold_mask = DRA752_TSHUT_THRESHOLD_COLD_MASK,
 	.bgap_status = DRA752_BANDGAP_STATUS_2_OFFSET,
 	.status_bgap_alert_mask = DRA752_BANDGAP_STATUS_1_ALERT_MASK,
 	.status_hot_mask = DRA752_BANDGAP_STATUS_2_HOT_DSPEVE_MASK,
@@ -193,9 +181,6 @@
 	.bgap_threshold = DRA752_BANDGAP_THRESHOLD_GPU_OFFSET,
 	.threshold_thot_mask = DRA752_BANDGAP_THRESHOLD_HOT_MASK,
 	.threshold_tcold_mask = DRA752_BANDGAP_THRESHOLD_COLD_MASK,
-	.tshut_threshold = DRA752_BANDGAP_TSHUT_GPU_OFFSET,
-	.tshut_hot_mask = DRA752_TSHUT_THRESHOLD_HOT_MASK,
-	.tshut_cold_mask = DRA752_TSHUT_THRESHOLD_COLD_MASK,
 	.bgap_status = DRA752_BANDGAP_STATUS_1_OFFSET,
 	.status_bgap_alert_mask = DRA752_BANDGAP_STATUS_1_ALERT_MASK,
 	.status_hot_mask = DRA752_BANDGAP_STATUS_1_HOT_GPU_MASK,
@@ -211,8 +196,6 @@
 
 /* Thresholds and limits for DRA752 MPU temperature sensor */
 static struct temp_sensor_data dra752_mpu_temp_sensor_data = {
-	.tshut_hot = DRA752_MPU_TSHUT_HOT,
-	.tshut_cold = DRA752_MPU_TSHUT_COLD,
 	.t_hot = DRA752_MPU_T_HOT,
 	.t_cold = DRA752_MPU_T_COLD,
 	.min_freq = DRA752_MPU_MIN_FREQ,
@@ -226,8 +209,6 @@
 
 /* Thresholds and limits for DRA752 GPU temperature sensor */
 static struct temp_sensor_data dra752_gpu_temp_sensor_data = {
-	.tshut_hot = DRA752_GPU_TSHUT_HOT,
-	.tshut_cold = DRA752_GPU_TSHUT_COLD,
 	.t_hot = DRA752_GPU_T_HOT,
 	.t_cold = DRA752_GPU_T_COLD,
 	.min_freq = DRA752_GPU_MIN_FREQ,
@@ -241,8 +222,6 @@
 
 /* Thresholds and limits for DRA752 CORE temperature sensor */
 static struct temp_sensor_data dra752_core_temp_sensor_data = {
-	.tshut_hot = DRA752_CORE_TSHUT_HOT,
-	.tshut_cold = DRA752_CORE_TSHUT_COLD,
 	.t_hot = DRA752_CORE_T_HOT,
 	.t_cold = DRA752_CORE_T_COLD,
 	.min_freq = DRA752_CORE_MIN_FREQ,
@@ -256,8 +235,6 @@
 
 /* Thresholds and limits for DRA752 DSPEVE temperature sensor */
 static struct temp_sensor_data dra752_dspeve_temp_sensor_data = {
-	.tshut_hot = DRA752_DSPEVE_TSHUT_HOT,
-	.tshut_cold = DRA752_DSPEVE_TSHUT_COLD,
 	.t_hot = DRA752_DSPEVE_T_HOT,
 	.t_cold = DRA752_DSPEVE_T_COLD,
 	.min_freq = DRA752_DSPEVE_MIN_FREQ,
@@ -271,8 +248,6 @@
 
 /* Thresholds and limits for DRA752 IVA temperature sensor */
 static struct temp_sensor_data dra752_iva_temp_sensor_data = {
-	.tshut_hot = DRA752_IVA_TSHUT_HOT,
-	.tshut_cold = DRA752_IVA_TSHUT_COLD,
 	.t_hot = DRA752_IVA_T_HOT,
 	.t_cold = DRA752_IVA_T_COLD,
 	.min_freq = DRA752_IVA_MIN_FREQ,
-- 
1.9.1
