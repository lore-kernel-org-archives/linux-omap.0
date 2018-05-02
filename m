From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] thermal: ti-soc-thermal: remove dead code
Date: Wed, 02 May 2018 15:20:35 +0200
Message-ID: <10747698.EAsn0e6Ddm@amdc3058>
References: <CGME20180502132036eucas1p14cb3b3dfc0ef30b8c9e8e4f147a3c8a7@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Majority of this code (i.e. functions from ti-bandgap.c) has been
introduced in May 2013 by commit eb982001dbd8 ("thermal: introduce TI
SoC thermal driver"). Just remove it altogether (in case it is needed
it can be easily resurrected from git repo).

While at it fix incorrect "not used" comments.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/ti-soc-thermal/dra752-bandgap.h      |   68 ---
 drivers/thermal/ti-soc-thermal/dra752-thermal-data.c |   65 ---
 drivers/thermal/ti-soc-thermal/omap3-thermal-data.c  |    6 
 drivers/thermal/ti-soc-thermal/omap4-thermal-data.c  |   10 
 drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h    |   10 
 drivers/thermal/ti-soc-thermal/omap5-thermal-data.c  |   46 --
 drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h    |   41 --
 drivers/thermal/ti-soc-thermal/ti-bandgap.c          |  370 -------------------
 drivers/thermal/ti-soc-thermal/ti-bandgap.h          |   43 --
 9 files changed, 5 insertions(+), 654 deletions(-)

Index: b/drivers/thermal/ti-soc-thermal/dra752-bandgap.h
===================================================================
--- a/drivers/thermal/ti-soc-thermal/dra752-bandgap.h	2018-05-02 15:14:18.133522058 +0200
+++ b/drivers/thermal/ti-soc-thermal/dra752-bandgap.h	2018-05-02 15:14:18.125522058 +0200
@@ -54,56 +54,36 @@
 #define DRA752_STD_FUSE_OPP_BGAP_CORE_OFFSET		0x8
 #define DRA752_TEMP_SENSOR_CORE_OFFSET			0x154
 #define DRA752_BANDGAP_THRESHOLD_CORE_OFFSET		0x1ac
-#define DRA752_BANDGAP_CUMUL_DTEMP_CORE_OFFSET		0x1c4
-#define DRA752_DTEMP_CORE_0_OFFSET			0x208
 #define DRA752_DTEMP_CORE_1_OFFSET			0x20c
 #define DRA752_DTEMP_CORE_2_OFFSET			0x210
-#define DRA752_DTEMP_CORE_3_OFFSET			0x214
-#define DRA752_DTEMP_CORE_4_OFFSET			0x218
 
 /* DRA752.iva register offsets */
 #define DRA752_STD_FUSE_OPP_BGAP_IVA_OFFSET		0x388
 #define DRA752_TEMP_SENSOR_IVA_OFFSET			0x398
 #define DRA752_BANDGAP_THRESHOLD_IVA_OFFSET		0x3a4
-#define DRA752_BANDGAP_CUMUL_DTEMP_IVA_OFFSET		0x3b4
-#define DRA752_DTEMP_IVA_0_OFFSET			0x3d0
 #define DRA752_DTEMP_IVA_1_OFFSET			0x3d4
 #define DRA752_DTEMP_IVA_2_OFFSET			0x3d8
-#define DRA752_DTEMP_IVA_3_OFFSET			0x3dc
-#define DRA752_DTEMP_IVA_4_OFFSET			0x3e0
 
 /* DRA752.mpu register offsets */
 #define DRA752_STD_FUSE_OPP_BGAP_MPU_OFFSET		0x4
 #define DRA752_TEMP_SENSOR_MPU_OFFSET			0x14c
 #define DRA752_BANDGAP_THRESHOLD_MPU_OFFSET		0x1a4
-#define DRA752_BANDGAP_CUMUL_DTEMP_MPU_OFFSET		0x1bc
-#define DRA752_DTEMP_MPU_0_OFFSET			0x1e0
 #define DRA752_DTEMP_MPU_1_OFFSET			0x1e4
 #define DRA752_DTEMP_MPU_2_OFFSET			0x1e8
-#define DRA752_DTEMP_MPU_3_OFFSET			0x1ec
-#define DRA752_DTEMP_MPU_4_OFFSET			0x1f0
 
 /* DRA752.dspeve register offsets */
 #define DRA752_STD_FUSE_OPP_BGAP_DSPEVE_OFFSET			0x384
 #define DRA752_TEMP_SENSOR_DSPEVE_OFFSET			0x394
 #define DRA752_BANDGAP_THRESHOLD_DSPEVE_OFFSET			0x3a0
-#define DRA752_BANDGAP_CUMUL_DTEMP_DSPEVE_OFFSET		0x3b0
-#define DRA752_DTEMP_DSPEVE_0_OFFSET				0x3bc
 #define DRA752_DTEMP_DSPEVE_1_OFFSET				0x3c0
 #define DRA752_DTEMP_DSPEVE_2_OFFSET				0x3c4
-#define DRA752_DTEMP_DSPEVE_3_OFFSET				0x3c8
-#define DRA752_DTEMP_DSPEVE_4_OFFSET				0x3cc
 
 /* DRA752.gpu register offsets */
 #define DRA752_STD_FUSE_OPP_BGAP_GPU_OFFSET		0x0
 #define DRA752_TEMP_SENSOR_GPU_OFFSET			0x150
 #define DRA752_BANDGAP_THRESHOLD_GPU_OFFSET		0x1a8
-#define DRA752_BANDGAP_CUMUL_DTEMP_GPU_OFFSET		0x1c0
-#define DRA752_DTEMP_GPU_0_OFFSET			0x1f4
 #define DRA752_DTEMP_GPU_1_OFFSET			0x1f8
 #define DRA752_DTEMP_GPU_2_OFFSET			0x1fc
-#define DRA752_DTEMP_GPU_3_OFFSET			0x200
-#define DRA752_DTEMP_GPU_4_OFFSET			0x204
 
 /**
  * Register bitfields for DRA752
@@ -114,7 +94,6 @@
  */
 
 /* DRA752.BANDGAP_STATUS_1 */
-#define DRA752_BANDGAP_STATUS_1_ALERT_MASK		BIT(31)
 #define DRA752_BANDGAP_STATUS_1_HOT_CORE_MASK		BIT(5)
 #define DRA752_BANDGAP_STATUS_1_COLD_CORE_MASK		BIT(4)
 #define DRA752_BANDGAP_STATUS_1_HOT_GPU_MASK		BIT(3)
@@ -125,10 +104,6 @@
 /* DRA752.BANDGAP_CTRL_2 */
 #define DRA752_BANDGAP_CTRL_2_FREEZE_IVA_MASK			BIT(22)
 #define DRA752_BANDGAP_CTRL_2_FREEZE_DSPEVE_MASK		BIT(21)
-#define DRA752_BANDGAP_CTRL_2_CLEAR_IVA_MASK			BIT(19)
-#define DRA752_BANDGAP_CTRL_2_CLEAR_DSPEVE_MASK			BIT(18)
-#define DRA752_BANDGAP_CTRL_2_CLEAR_ACCUM_IVA_MASK		BIT(16)
-#define DRA752_BANDGAP_CTRL_2_CLEAR_ACCUM_DSPEVE_MASK		BIT(15)
 #define DRA752_BANDGAP_CTRL_2_MASK_HOT_IVA_MASK			BIT(3)
 #define DRA752_BANDGAP_CTRL_2_MASK_COLD_IVA_MASK		BIT(2)
 #define DRA752_BANDGAP_CTRL_2_MASK_HOT_DSPEVE_MASK		BIT(1)
@@ -141,17 +116,10 @@
 #define DRA752_BANDGAP_STATUS_2_COLD_DSPEVE_MASK		BIT(0)
 
 /* DRA752.BANDGAP_CTRL_1 */
-#define DRA752_BANDGAP_CTRL_1_SIDLEMODE_MASK			(0x3 << 30)
 #define DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_MASK		(0x7 << 27)
 #define DRA752_BANDGAP_CTRL_1_FREEZE_CORE_MASK			BIT(23)
 #define DRA752_BANDGAP_CTRL_1_FREEZE_GPU_MASK			BIT(22)
 #define DRA752_BANDGAP_CTRL_1_FREEZE_MPU_MASK			BIT(21)
-#define DRA752_BANDGAP_CTRL_1_CLEAR_CORE_MASK			BIT(20)
-#define DRA752_BANDGAP_CTRL_1_CLEAR_GPU_MASK			BIT(19)
-#define DRA752_BANDGAP_CTRL_1_CLEAR_MPU_MASK			BIT(18)
-#define DRA752_BANDGAP_CTRL_1_CLEAR_ACCUM_CORE_MASK		BIT(17)
-#define DRA752_BANDGAP_CTRL_1_CLEAR_ACCUM_GPU_MASK		BIT(16)
-#define DRA752_BANDGAP_CTRL_1_CLEAR_ACCUM_MPU_MASK		BIT(15)
 #define DRA752_BANDGAP_CTRL_1_MASK_HOT_CORE_MASK		BIT(5)
 #define DRA752_BANDGAP_CTRL_1_MASK_COLD_CORE_MASK		BIT(4)
 #define DRA752_BANDGAP_CTRL_1_MASK_HOT_GPU_MASK			BIT(3)
@@ -168,22 +136,6 @@
 #define DRA752_BANDGAP_THRESHOLD_HOT_MASK		(0x3ff << 16)
 #define DRA752_BANDGAP_THRESHOLD_COLD_MASK		(0x3ff << 0)
 
-
-/* DRA752.BANDGAP_CUMUL_DTEMP_CORE */
-#define DRA752_BANDGAP_CUMUL_DTEMP_CORE_MASK		(0xffffffff << 0)
-
-/* DRA752.BANDGAP_CUMUL_DTEMP_IVA */
-#define DRA752_BANDGAP_CUMUL_DTEMP_IVA_MASK		(0xffffffff << 0)
-
-/* DRA752.BANDGAP_CUMUL_DTEMP_MPU */
-#define DRA752_BANDGAP_CUMUL_DTEMP_MPU_MASK		(0xffffffff << 0)
-
-/* DRA752.BANDGAP_CUMUL_DTEMP_DSPEVE */
-#define DRA752_BANDGAP_CUMUL_DTEMP_DSPEVE_MASK		(0xffffffff << 0)
-
-/* DRA752.BANDGAP_CUMUL_DTEMP_GPU */
-#define DRA752_BANDGAP_CUMUL_DTEMP_GPU_MASK		(0xffffffff << 0)
-
 /**
  * Temperature limits and thresholds for DRA752
  *
@@ -202,10 +154,6 @@
 /* bandgap clock limits */
 #define DRA752_GPU_MAX_FREQ				1500000
 #define DRA752_GPU_MIN_FREQ				1000000
-/* sensor limits */
-#define DRA752_GPU_MIN_TEMP				-40000
-#define DRA752_GPU_MAX_TEMP				125000
-#define DRA752_GPU_HYST_VAL				5000
 /* interrupts thresholds */
 #define DRA752_GPU_T_HOT				800
 #define DRA752_GPU_T_COLD				795
@@ -214,10 +162,6 @@
 /* bandgap clock limits */
 #define DRA752_MPU_MAX_FREQ				1500000
 #define DRA752_MPU_MIN_FREQ				1000000
-/* sensor limits */
-#define DRA752_MPU_MIN_TEMP				-40000
-#define DRA752_MPU_MAX_TEMP				125000
-#define DRA752_MPU_HYST_VAL				5000
 /* interrupts thresholds */
 #define DRA752_MPU_T_HOT				800
 #define DRA752_MPU_T_COLD				795
@@ -226,10 +170,6 @@
 /* bandgap clock limits */
 #define DRA752_CORE_MAX_FREQ				1500000
 #define DRA752_CORE_MIN_FREQ				1000000
-/* sensor limits */
-#define DRA752_CORE_MIN_TEMP				-40000
-#define DRA752_CORE_MAX_TEMP				125000
-#define DRA752_CORE_HYST_VAL				5000
 /* interrupts thresholds */
 #define DRA752_CORE_T_HOT				800
 #define DRA752_CORE_T_COLD				795
@@ -238,10 +178,6 @@
 /* bandgap clock limits */
 #define DRA752_DSPEVE_MAX_FREQ				1500000
 #define DRA752_DSPEVE_MIN_FREQ				1000000
-/* sensor limits */
-#define DRA752_DSPEVE_MIN_TEMP				-40000
-#define DRA752_DSPEVE_MAX_TEMP				125000
-#define DRA752_DSPEVE_HYST_VAL				5000
 /* interrupts thresholds */
 #define DRA752_DSPEVE_T_HOT				800
 #define DRA752_DSPEVE_T_COLD				795
@@ -250,10 +186,6 @@
 /* bandgap clock limits */
 #define DRA752_IVA_MAX_FREQ				1500000
 #define DRA752_IVA_MIN_FREQ				1000000
-/* sensor limits */
-#define DRA752_IVA_MIN_TEMP				-40000
-#define DRA752_IVA_MAX_TEMP				125000
-#define DRA752_IVA_HYST_VAL				5000
 /* interrupts thresholds */
 #define DRA752_IVA_T_HOT				800
 #define DRA752_IVA_T_COLD				795
Index: b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
===================================================================
--- a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c	2018-05-02 15:14:18.133522058 +0200
+++ b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c	2018-05-02 15:14:18.125522058 +0200
@@ -41,24 +41,16 @@ dra752_core_temp_sensor_registers = {
 	.bgap_mask_ctrl = DRA752_BANDGAP_CTRL_1_OFFSET,
 	.mask_hot_mask = DRA752_BANDGAP_CTRL_1_MASK_HOT_CORE_MASK,
 	.mask_cold_mask = DRA752_BANDGAP_CTRL_1_MASK_COLD_CORE_MASK,
-	.mask_sidlemode_mask = DRA752_BANDGAP_CTRL_1_SIDLEMODE_MASK,
 	.mask_counter_delay_mask = DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_MASK,
 	.mask_freeze_mask = DRA752_BANDGAP_CTRL_1_FREEZE_CORE_MASK,
-	.mask_clear_mask = DRA752_BANDGAP_CTRL_1_CLEAR_CORE_MASK,
-	.mask_clear_accum_mask = DRA752_BANDGAP_CTRL_1_CLEAR_ACCUM_CORE_MASK,
 	.bgap_threshold = DRA752_BANDGAP_THRESHOLD_CORE_OFFSET,
 	.threshold_thot_mask = DRA752_BANDGAP_THRESHOLD_HOT_MASK,
 	.threshold_tcold_mask = DRA752_BANDGAP_THRESHOLD_COLD_MASK,
 	.bgap_status = DRA752_BANDGAP_STATUS_1_OFFSET,
-	.status_bgap_alert_mask = DRA752_BANDGAP_STATUS_1_ALERT_MASK,
 	.status_hot_mask = DRA752_BANDGAP_STATUS_1_HOT_CORE_MASK,
 	.status_cold_mask = DRA752_BANDGAP_STATUS_1_COLD_CORE_MASK,
-	.bgap_cumul_dtemp = DRA752_BANDGAP_CUMUL_DTEMP_CORE_OFFSET,
-	.ctrl_dtemp_0 = DRA752_DTEMP_CORE_0_OFFSET,
 	.ctrl_dtemp_1 = DRA752_DTEMP_CORE_1_OFFSET,
 	.ctrl_dtemp_2 = DRA752_DTEMP_CORE_2_OFFSET,
-	.ctrl_dtemp_3 = DRA752_DTEMP_CORE_3_OFFSET,
-	.ctrl_dtemp_4 = DRA752_DTEMP_CORE_4_OFFSET,
 	.bgap_efuse = DRA752_STD_FUSE_OPP_BGAP_CORE_OFFSET,
 };
 
@@ -74,24 +66,16 @@ dra752_iva_temp_sensor_registers = {
 	.bgap_mask_ctrl = DRA752_BANDGAP_CTRL_2_OFFSET,
 	.mask_hot_mask = DRA752_BANDGAP_CTRL_2_MASK_HOT_IVA_MASK,
 	.mask_cold_mask = DRA752_BANDGAP_CTRL_2_MASK_COLD_IVA_MASK,
-	.mask_sidlemode_mask = DRA752_BANDGAP_CTRL_1_SIDLEMODE_MASK,
 	.mask_counter_delay_mask = DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_MASK,
 	.mask_freeze_mask = DRA752_BANDGAP_CTRL_2_FREEZE_IVA_MASK,
-	.mask_clear_mask = DRA752_BANDGAP_CTRL_2_CLEAR_IVA_MASK,
-	.mask_clear_accum_mask = DRA752_BANDGAP_CTRL_2_CLEAR_ACCUM_IVA_MASK,
 	.bgap_threshold = DRA752_BANDGAP_THRESHOLD_IVA_OFFSET,
 	.threshold_thot_mask = DRA752_BANDGAP_THRESHOLD_HOT_MASK,
 	.threshold_tcold_mask = DRA752_BANDGAP_THRESHOLD_COLD_MASK,
 	.bgap_status = DRA752_BANDGAP_STATUS_2_OFFSET,
-	.status_bgap_alert_mask = DRA752_BANDGAP_STATUS_1_ALERT_MASK,
 	.status_hot_mask = DRA752_BANDGAP_STATUS_2_HOT_IVA_MASK,
 	.status_cold_mask = DRA752_BANDGAP_STATUS_2_COLD_IVA_MASK,
-	.bgap_cumul_dtemp = DRA752_BANDGAP_CUMUL_DTEMP_IVA_OFFSET,
-	.ctrl_dtemp_0 = DRA752_DTEMP_IVA_0_OFFSET,
 	.ctrl_dtemp_1 = DRA752_DTEMP_IVA_1_OFFSET,
 	.ctrl_dtemp_2 = DRA752_DTEMP_IVA_2_OFFSET,
-	.ctrl_dtemp_3 = DRA752_DTEMP_IVA_3_OFFSET,
-	.ctrl_dtemp_4 = DRA752_DTEMP_IVA_4_OFFSET,
 	.bgap_efuse = DRA752_STD_FUSE_OPP_BGAP_IVA_OFFSET,
 };
 
@@ -107,24 +91,16 @@ dra752_mpu_temp_sensor_registers = {
 	.bgap_mask_ctrl = DRA752_BANDGAP_CTRL_1_OFFSET,
 	.mask_hot_mask = DRA752_BANDGAP_CTRL_1_MASK_HOT_MPU_MASK,
 	.mask_cold_mask = DRA752_BANDGAP_CTRL_1_MASK_COLD_MPU_MASK,
-	.mask_sidlemode_mask = DRA752_BANDGAP_CTRL_1_SIDLEMODE_MASK,
 	.mask_counter_delay_mask = DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_MASK,
 	.mask_freeze_mask = DRA752_BANDGAP_CTRL_1_FREEZE_MPU_MASK,
-	.mask_clear_mask = DRA752_BANDGAP_CTRL_1_CLEAR_MPU_MASK,
-	.mask_clear_accum_mask = DRA752_BANDGAP_CTRL_1_CLEAR_ACCUM_MPU_MASK,
 	.bgap_threshold = DRA752_BANDGAP_THRESHOLD_MPU_OFFSET,
 	.threshold_thot_mask = DRA752_BANDGAP_THRESHOLD_HOT_MASK,
 	.threshold_tcold_mask = DRA752_BANDGAP_THRESHOLD_COLD_MASK,
 	.bgap_status = DRA752_BANDGAP_STATUS_1_OFFSET,
-	.status_bgap_alert_mask = DRA752_BANDGAP_STATUS_1_ALERT_MASK,
 	.status_hot_mask = DRA752_BANDGAP_STATUS_1_HOT_MPU_MASK,
 	.status_cold_mask = DRA752_BANDGAP_STATUS_1_COLD_MPU_MASK,
-	.bgap_cumul_dtemp = DRA752_BANDGAP_CUMUL_DTEMP_MPU_OFFSET,
-	.ctrl_dtemp_0 = DRA752_DTEMP_MPU_0_OFFSET,
 	.ctrl_dtemp_1 = DRA752_DTEMP_MPU_1_OFFSET,
 	.ctrl_dtemp_2 = DRA752_DTEMP_MPU_2_OFFSET,
-	.ctrl_dtemp_3 = DRA752_DTEMP_MPU_3_OFFSET,
-	.ctrl_dtemp_4 = DRA752_DTEMP_MPU_4_OFFSET,
 	.bgap_efuse = DRA752_STD_FUSE_OPP_BGAP_MPU_OFFSET,
 };
 
@@ -140,24 +116,16 @@ dra752_dspeve_temp_sensor_registers = {
 	.bgap_mask_ctrl = DRA752_BANDGAP_CTRL_2_OFFSET,
 	.mask_hot_mask = DRA752_BANDGAP_CTRL_2_MASK_HOT_DSPEVE_MASK,
 	.mask_cold_mask = DRA752_BANDGAP_CTRL_2_MASK_COLD_DSPEVE_MASK,
-	.mask_sidlemode_mask = DRA752_BANDGAP_CTRL_1_SIDLEMODE_MASK,
 	.mask_counter_delay_mask = DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_MASK,
 	.mask_freeze_mask = DRA752_BANDGAP_CTRL_2_FREEZE_DSPEVE_MASK,
-	.mask_clear_mask = DRA752_BANDGAP_CTRL_2_CLEAR_DSPEVE_MASK,
-	.mask_clear_accum_mask = DRA752_BANDGAP_CTRL_2_CLEAR_ACCUM_DSPEVE_MASK,
 	.bgap_threshold = DRA752_BANDGAP_THRESHOLD_DSPEVE_OFFSET,
 	.threshold_thot_mask = DRA752_BANDGAP_THRESHOLD_HOT_MASK,
 	.threshold_tcold_mask = DRA752_BANDGAP_THRESHOLD_COLD_MASK,
 	.bgap_status = DRA752_BANDGAP_STATUS_2_OFFSET,
-	.status_bgap_alert_mask = DRA752_BANDGAP_STATUS_1_ALERT_MASK,
 	.status_hot_mask = DRA752_BANDGAP_STATUS_2_HOT_DSPEVE_MASK,
 	.status_cold_mask = DRA752_BANDGAP_STATUS_2_COLD_DSPEVE_MASK,
-	.bgap_cumul_dtemp = DRA752_BANDGAP_CUMUL_DTEMP_DSPEVE_OFFSET,
-	.ctrl_dtemp_0 = DRA752_DTEMP_DSPEVE_0_OFFSET,
 	.ctrl_dtemp_1 = DRA752_DTEMP_DSPEVE_1_OFFSET,
 	.ctrl_dtemp_2 = DRA752_DTEMP_DSPEVE_2_OFFSET,
-	.ctrl_dtemp_3 = DRA752_DTEMP_DSPEVE_3_OFFSET,
-	.ctrl_dtemp_4 = DRA752_DTEMP_DSPEVE_4_OFFSET,
 	.bgap_efuse = DRA752_STD_FUSE_OPP_BGAP_DSPEVE_OFFSET,
 };
 
@@ -173,24 +141,16 @@ dra752_gpu_temp_sensor_registers = {
 	.bgap_mask_ctrl = DRA752_BANDGAP_CTRL_1_OFFSET,
 	.mask_hot_mask = DRA752_BANDGAP_CTRL_1_MASK_HOT_GPU_MASK,
 	.mask_cold_mask = DRA752_BANDGAP_CTRL_1_MASK_COLD_GPU_MASK,
-	.mask_sidlemode_mask = DRA752_BANDGAP_CTRL_1_SIDLEMODE_MASK,
 	.mask_counter_delay_mask = DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_MASK,
 	.mask_freeze_mask = DRA752_BANDGAP_CTRL_1_FREEZE_GPU_MASK,
-	.mask_clear_mask = DRA752_BANDGAP_CTRL_1_CLEAR_GPU_MASK,
-	.mask_clear_accum_mask = DRA752_BANDGAP_CTRL_1_CLEAR_ACCUM_GPU_MASK,
 	.bgap_threshold = DRA752_BANDGAP_THRESHOLD_GPU_OFFSET,
 	.threshold_thot_mask = DRA752_BANDGAP_THRESHOLD_HOT_MASK,
 	.threshold_tcold_mask = DRA752_BANDGAP_THRESHOLD_COLD_MASK,
 	.bgap_status = DRA752_BANDGAP_STATUS_1_OFFSET,
-	.status_bgap_alert_mask = DRA752_BANDGAP_STATUS_1_ALERT_MASK,
 	.status_hot_mask = DRA752_BANDGAP_STATUS_1_HOT_GPU_MASK,
 	.status_cold_mask = DRA752_BANDGAP_STATUS_1_COLD_GPU_MASK,
-	.bgap_cumul_dtemp = DRA752_BANDGAP_CUMUL_DTEMP_GPU_OFFSET,
-	.ctrl_dtemp_0 = DRA752_DTEMP_GPU_0_OFFSET,
 	.ctrl_dtemp_1 = DRA752_DTEMP_GPU_1_OFFSET,
 	.ctrl_dtemp_2 = DRA752_DTEMP_GPU_2_OFFSET,
-	.ctrl_dtemp_3 = DRA752_DTEMP_GPU_3_OFFSET,
-	.ctrl_dtemp_4 = DRA752_DTEMP_GPU_4_OFFSET,
 	.bgap_efuse = DRA752_STD_FUSE_OPP_BGAP_GPU_OFFSET,
 };
 
@@ -200,11 +160,6 @@ static struct temp_sensor_data dra752_mp
 	.t_cold = DRA752_MPU_T_COLD,
 	.min_freq = DRA752_MPU_MIN_FREQ,
 	.max_freq = DRA752_MPU_MAX_FREQ,
-	.max_temp = DRA752_MPU_MAX_TEMP,
-	.min_temp = DRA752_MPU_MIN_TEMP,
-	.hyst_val = DRA752_MPU_HYST_VAL,
-	.update_int1 = 1000,
-	.update_int2 = 2000,
 };
 
 /* Thresholds and limits for DRA752 GPU temperature sensor */
@@ -213,11 +168,6 @@ static struct temp_sensor_data dra752_gp
 	.t_cold = DRA752_GPU_T_COLD,
 	.min_freq = DRA752_GPU_MIN_FREQ,
 	.max_freq = DRA752_GPU_MAX_FREQ,
-	.max_temp = DRA752_GPU_MAX_TEMP,
-	.min_temp = DRA752_GPU_MIN_TEMP,
-	.hyst_val = DRA752_GPU_HYST_VAL,
-	.update_int1 = 1000,
-	.update_int2 = 2000,
 };
 
 /* Thresholds and limits for DRA752 CORE temperature sensor */
@@ -226,11 +176,6 @@ static struct temp_sensor_data dra752_co
 	.t_cold = DRA752_CORE_T_COLD,
 	.min_freq = DRA752_CORE_MIN_FREQ,
 	.max_freq = DRA752_CORE_MAX_FREQ,
-	.max_temp = DRA752_CORE_MAX_TEMP,
-	.min_temp = DRA752_CORE_MIN_TEMP,
-	.hyst_val = DRA752_CORE_HYST_VAL,
-	.update_int1 = 1000,
-	.update_int2 = 2000,
 };
 
 /* Thresholds and limits for DRA752 DSPEVE temperature sensor */
@@ -239,11 +184,6 @@ static struct temp_sensor_data dra752_ds
 	.t_cold = DRA752_DSPEVE_T_COLD,
 	.min_freq = DRA752_DSPEVE_MIN_FREQ,
 	.max_freq = DRA752_DSPEVE_MAX_FREQ,
-	.max_temp = DRA752_DSPEVE_MAX_TEMP,
-	.min_temp = DRA752_DSPEVE_MIN_TEMP,
-	.hyst_val = DRA752_DSPEVE_HYST_VAL,
-	.update_int1 = 1000,
-	.update_int2 = 2000,
 };
 
 /* Thresholds and limits for DRA752 IVA temperature sensor */
@@ -252,11 +192,6 @@ static struct temp_sensor_data dra752_iv
 	.t_cold = DRA752_IVA_T_COLD,
 	.min_freq = DRA752_IVA_MIN_FREQ,
 	.max_freq = DRA752_IVA_MAX_FREQ,
-	.max_temp = DRA752_IVA_MAX_TEMP,
-	.min_temp = DRA752_IVA_MIN_TEMP,
-	.hyst_val = DRA752_IVA_HYST_VAL,
-	.update_int1 = 1000,
-	.update_int2 = 2000,
 };
 
 /*
Index: b/drivers/thermal/ti-soc-thermal/omap3-thermal-data.c
===================================================================
--- a/drivers/thermal/ti-soc-thermal/omap3-thermal-data.c	2018-05-02 15:14:18.133522058 +0200
+++ b/drivers/thermal/ti-soc-thermal/omap3-thermal-data.c	2018-05-02 15:14:18.125522058 +0200
@@ -48,9 +48,6 @@ omap34xx_mpu_temp_sensor_registers = {
 static struct temp_sensor_data omap34xx_mpu_temp_sensor_data = {
 	.min_freq = 32768,
 	.max_freq = 32768,
-	.max_temp = 125000,
-	.min_temp = -40000,
-	.hyst_val = 5000,
 };
 
 /*
@@ -119,9 +116,6 @@ omap36xx_mpu_temp_sensor_registers = {
 static struct temp_sensor_data omap36xx_mpu_temp_sensor_data = {
 	.min_freq = 32768,
 	.max_freq = 32768,
-	.max_temp = 125000,
-	.min_temp = -40000,
-	.hyst_val = 5000,
 };
 
 /*
Index: b/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
===================================================================
--- a/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c	2018-05-02 15:14:18.133522058 +0200
+++ b/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c	2018-05-02 15:14:18.125522058 +0200
@@ -42,9 +42,6 @@ omap4430_mpu_temp_sensor_registers = {
 static struct temp_sensor_data omap4430_mpu_temp_sensor_data = {
 	.min_freq = OMAP4430_MIN_FREQ,
 	.max_freq = OMAP4430_MAX_FREQ,
-	.max_temp = OMAP4430_MAX_TEMP,
-	.min_temp = OMAP4430_MIN_TEMP,
-	.hyst_val = OMAP4430_HYST_VAL,
 };
 
 /*
@@ -121,8 +118,6 @@ omap4460_mpu_temp_sensor_registers = {
 	.tshut_cold_mask = OMAP4460_TSHUT_COLD_MASK,
 
 	.bgap_status = OMAP4460_BGAP_STATUS_OFFSET,
-	.status_clean_stop_mask = OMAP4460_CLEAN_STOP_MASK,
-	.status_bgap_alert_mask = OMAP4460_BGAP_ALERT_MASK,
 	.status_hot_mask = OMAP4460_HOT_FLAG_MASK,
 	.status_cold_mask = OMAP4460_COLD_FLAG_MASK,
 
@@ -137,11 +132,6 @@ static struct temp_sensor_data omap4460_
 	.t_cold = OMAP4460_T_COLD,
 	.min_freq = OMAP4460_MIN_FREQ,
 	.max_freq = OMAP4460_MAX_FREQ,
-	.max_temp = OMAP4460_MAX_TEMP,
-	.min_temp = OMAP4460_MIN_TEMP,
-	.hyst_val = OMAP4460_HYST_VAL,
-	.update_int1 = 1000,
-	.update_int2 = 2000,
 };
 
 /*
Index: b/drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h
===================================================================
--- a/drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h	2018-05-02 15:14:18.133522058 +0200
+++ b/drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h	2018-05-02 15:14:18.125522058 +0200
@@ -73,10 +73,6 @@
 /* bandgap clock limits (no control on 4430) */
 #define OMAP4430_MAX_FREQ				32768
 #define OMAP4430_MIN_FREQ				32768
-/* sensor limits */
-#define OMAP4430_MIN_TEMP				-40000
-#define OMAP4430_MAX_TEMP				125000
-#define OMAP4430_HYST_VAL				5000
 
 /**
  * *** OMAP4460 *** Applicable for OMAP4470
@@ -143,8 +139,6 @@
 #define OMAP4460_TSHUT_COLD_MASK			(0x3ff << 0)
 
 /* OMAP4460.BANDGAP_STATUS bits */
-#define OMAP4460_CLEAN_STOP_MASK			BIT(3)
-#define OMAP4460_BGAP_ALERT_MASK			BIT(2)
 #define OMAP4460_HOT_FLAG_MASK				BIT(1)
 #define OMAP4460_COLD_FLAG_MASK				BIT(0)
 
@@ -162,10 +156,6 @@
 /* bandgap clock limits */
 #define OMAP4460_MAX_FREQ				1500000
 #define OMAP4460_MIN_FREQ				1000000
-/* sensor limits */
-#define OMAP4460_MIN_TEMP				-40000
-#define OMAP4460_MAX_TEMP				123000
-#define OMAP4460_HYST_VAL				5000
 /* interrupts thresholds */
 #define OMAP4460_TSHUT_HOT				900	/* 122 deg C */
 #define OMAP4460_TSHUT_COLD				895	/* 100 deg C */
Index: b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
===================================================================
--- a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c	2018-05-02 15:14:18.133522058 +0200
+++ b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c	2018-05-02 15:14:18.129522058 +0200
@@ -38,12 +38,8 @@ omap5430_mpu_temp_sensor_registers = {
 	.bgap_mask_ctrl = OMAP5430_BGAP_CTRL_OFFSET,
 	.mask_hot_mask = OMAP5430_MASK_HOT_MPU_MASK,
 	.mask_cold_mask = OMAP5430_MASK_COLD_MPU_MASK,
-	.mask_sidlemode_mask = OMAP5430_MASK_SIDLEMODE_MASK,
 	.mask_counter_delay_mask = OMAP5430_MASK_COUNTER_DELAY_MASK,
 	.mask_freeze_mask = OMAP5430_MASK_FREEZE_MPU_MASK,
-	.mask_clear_mask = OMAP5430_MASK_CLEAR_MPU_MASK,
-	.mask_clear_accum_mask = OMAP5430_MASK_CLEAR_ACCUM_MPU_MASK,
-
 
 	.bgap_counter = OMAP5430_BGAP_CTRL_OFFSET,
 	.counter_mask = OMAP5430_COUNTER_MASK,
@@ -57,17 +53,11 @@ omap5430_mpu_temp_sensor_registers = {
 	.tshut_cold_mask = OMAP5430_TSHUT_COLD_MASK,
 
 	.bgap_status = OMAP5430_BGAP_STATUS_OFFSET,
-	.status_clean_stop_mask = 0x0,
-	.status_bgap_alert_mask = OMAP5430_BGAP_ALERT_MASK,
 	.status_hot_mask = OMAP5430_HOT_MPU_FLAG_MASK,
 	.status_cold_mask = OMAP5430_COLD_MPU_FLAG_MASK,
 
-	.bgap_cumul_dtemp = OMAP5430_BGAP_CUMUL_DTEMP_MPU_OFFSET,
-	.ctrl_dtemp_0 = OMAP5430_BGAP_DTEMP_MPU_0_OFFSET,
 	.ctrl_dtemp_1 = OMAP5430_BGAP_DTEMP_MPU_1_OFFSET,
 	.ctrl_dtemp_2 = OMAP5430_BGAP_DTEMP_MPU_2_OFFSET,
-	.ctrl_dtemp_3 = OMAP5430_BGAP_DTEMP_MPU_3_OFFSET,
-	.ctrl_dtemp_4 = OMAP5430_BGAP_DTEMP_MPU_4_OFFSET,
 	.bgap_efuse = OMAP5430_FUSE_OPP_BGAP_MPU,
 };
 
@@ -84,11 +74,8 @@ omap5430_gpu_temp_sensor_registers = {
 	.bgap_mask_ctrl = OMAP5430_BGAP_CTRL_OFFSET,
 	.mask_hot_mask = OMAP5430_MASK_HOT_GPU_MASK,
 	.mask_cold_mask = OMAP5430_MASK_COLD_GPU_MASK,
-	.mask_sidlemode_mask = OMAP5430_MASK_SIDLEMODE_MASK,
 	.mask_counter_delay_mask = OMAP5430_MASK_COUNTER_DELAY_MASK,
 	.mask_freeze_mask = OMAP5430_MASK_FREEZE_GPU_MASK,
-	.mask_clear_mask = OMAP5430_MASK_CLEAR_GPU_MASK,
-	.mask_clear_accum_mask = OMAP5430_MASK_CLEAR_ACCUM_GPU_MASK,
 
 	.bgap_counter = OMAP5430_BGAP_CTRL_OFFSET,
 	.counter_mask = OMAP5430_COUNTER_MASK,
@@ -102,17 +89,11 @@ omap5430_gpu_temp_sensor_registers = {
 	.tshut_cold_mask = OMAP5430_TSHUT_COLD_MASK,
 
 	.bgap_status = OMAP5430_BGAP_STATUS_OFFSET,
-	.status_clean_stop_mask = 0x0,
-	.status_bgap_alert_mask = OMAP5430_BGAP_ALERT_MASK,
 	.status_hot_mask = OMAP5430_HOT_GPU_FLAG_MASK,
 	.status_cold_mask = OMAP5430_COLD_GPU_FLAG_MASK,
 
-	.bgap_cumul_dtemp = OMAP5430_BGAP_CUMUL_DTEMP_GPU_OFFSET,
-	.ctrl_dtemp_0 = OMAP5430_BGAP_DTEMP_GPU_0_OFFSET,
 	.ctrl_dtemp_1 = OMAP5430_BGAP_DTEMP_GPU_1_OFFSET,
 	.ctrl_dtemp_2 = OMAP5430_BGAP_DTEMP_GPU_2_OFFSET,
-	.ctrl_dtemp_3 = OMAP5430_BGAP_DTEMP_GPU_3_OFFSET,
-	.ctrl_dtemp_4 = OMAP5430_BGAP_DTEMP_GPU_4_OFFSET,
 
 	.bgap_efuse = OMAP5430_FUSE_OPP_BGAP_GPU,
 };
@@ -130,11 +111,8 @@ omap5430_core_temp_sensor_registers = {
 	.bgap_mask_ctrl = OMAP5430_BGAP_CTRL_OFFSET,
 	.mask_hot_mask = OMAP5430_MASK_HOT_CORE_MASK,
 	.mask_cold_mask = OMAP5430_MASK_COLD_CORE_MASK,
-	.mask_sidlemode_mask = OMAP5430_MASK_SIDLEMODE_MASK,
 	.mask_counter_delay_mask = OMAP5430_MASK_COUNTER_DELAY_MASK,
 	.mask_freeze_mask = OMAP5430_MASK_FREEZE_CORE_MASK,
-	.mask_clear_mask = OMAP5430_MASK_CLEAR_CORE_MASK,
-	.mask_clear_accum_mask = OMAP5430_MASK_CLEAR_ACCUM_CORE_MASK,
 
 	.bgap_counter = OMAP5430_BGAP_CTRL_OFFSET,
 	.counter_mask = OMAP5430_COUNTER_MASK,
@@ -148,17 +126,11 @@ omap5430_core_temp_sensor_registers = {
 	.tshut_cold_mask = OMAP5430_TSHUT_COLD_MASK,
 
 	.bgap_status = OMAP5430_BGAP_STATUS_OFFSET,
-	.status_clean_stop_mask = 0x0,
-	.status_bgap_alert_mask = OMAP5430_BGAP_ALERT_MASK,
 	.status_hot_mask = OMAP5430_HOT_CORE_FLAG_MASK,
 	.status_cold_mask = OMAP5430_COLD_CORE_FLAG_MASK,
 
-	.bgap_cumul_dtemp = OMAP5430_BGAP_CUMUL_DTEMP_CORE_OFFSET,
-	.ctrl_dtemp_0 = OMAP5430_BGAP_DTEMP_CORE_0_OFFSET,
 	.ctrl_dtemp_1 = OMAP5430_BGAP_DTEMP_CORE_1_OFFSET,
 	.ctrl_dtemp_2 = OMAP5430_BGAP_DTEMP_CORE_2_OFFSET,
-	.ctrl_dtemp_3 = OMAP5430_BGAP_DTEMP_CORE_3_OFFSET,
-	.ctrl_dtemp_4 = OMAP5430_BGAP_DTEMP_CORE_4_OFFSET,
 
 	.bgap_efuse = OMAP5430_FUSE_OPP_BGAP_CORE,
 };
@@ -171,11 +143,6 @@ static struct temp_sensor_data omap5430_
 	.t_cold = OMAP5430_MPU_T_COLD,
 	.min_freq = OMAP5430_MPU_MIN_FREQ,
 	.max_freq = OMAP5430_MPU_MAX_FREQ,
-	.max_temp = OMAP5430_MPU_MAX_TEMP,
-	.min_temp = OMAP5430_MPU_MIN_TEMP,
-	.hyst_val = OMAP5430_MPU_HYST_VAL,
-	.update_int1 = 1000,
-	.update_int2 = 2000,
 };
 
 /* Thresholds and limits for OMAP5430 GPU temperature sensor */
@@ -186,11 +153,6 @@ static struct temp_sensor_data omap5430_
 	.t_cold = OMAP5430_GPU_T_COLD,
 	.min_freq = OMAP5430_GPU_MIN_FREQ,
 	.max_freq = OMAP5430_GPU_MAX_FREQ,
-	.max_temp = OMAP5430_GPU_MAX_TEMP,
-	.min_temp = OMAP5430_GPU_MIN_TEMP,
-	.hyst_val = OMAP5430_GPU_HYST_VAL,
-	.update_int1 = 1000,
-	.update_int2 = 2000,
 };
 
 /* Thresholds and limits for OMAP5430 CORE temperature sensor */
@@ -201,11 +163,6 @@ static struct temp_sensor_data omap5430_
 	.t_cold = OMAP5430_CORE_T_COLD,
 	.min_freq = OMAP5430_CORE_MIN_FREQ,
 	.max_freq = OMAP5430_CORE_MAX_FREQ,
-	.max_temp = OMAP5430_CORE_MAX_TEMP,
-	.min_temp = OMAP5430_CORE_MIN_TEMP,
-	.hyst_val = OMAP5430_CORE_HYST_VAL,
-	.update_int1 = 1000,
-	.update_int2 = 2000,
 };
 
 /*
@@ -319,8 +276,7 @@ const struct ti_bandgap_data omap5430_da
 			TI_BANDGAP_FEATURE_FREEZE_BIT |
 			TI_BANDGAP_FEATURE_TALERT |
 			TI_BANDGAP_FEATURE_COUNTER_DELAY |
-			TI_BANDGAP_FEATURE_HISTORY_BUFFER |
-			TI_BANDGAP_FEATURE_ERRATA_813,
+			TI_BANDGAP_FEATURE_HISTORY_BUFFER,
 	.fclock_name = "l3instr_ts_gclk_div",
 	.div_ck_name = "l3instr_ts_gclk_div",
 	.conv_table = omap5430_adc_to_temp,
Index: b/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
===================================================================
--- a/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h	2018-05-02 15:14:18.133522058 +0200
+++ b/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h	2018-05-02 15:14:18.129522058 +0200
@@ -44,36 +44,24 @@
 #define OMAP5430_TEMP_SENSOR_GPU_OFFSET			0x150
 #define OMAP5430_BGAP_THRESHOLD_GPU_OFFSET		0x1A8
 #define OMAP5430_BGAP_TSHUT_GPU_OFFSET			0x1B4
-#define OMAP5430_BGAP_CUMUL_DTEMP_GPU_OFFSET		0x1C0
-#define OMAP5430_BGAP_DTEMP_GPU_0_OFFSET		0x1F4
 #define OMAP5430_BGAP_DTEMP_GPU_1_OFFSET		0x1F8
 #define OMAP5430_BGAP_DTEMP_GPU_2_OFFSET		0x1FC
-#define OMAP5430_BGAP_DTEMP_GPU_3_OFFSET		0x200
-#define OMAP5430_BGAP_DTEMP_GPU_4_OFFSET		0x204
 
 /* OMAP5430.MPU register offsets */
 #define OMAP5430_FUSE_OPP_BGAP_MPU			0x4
 #define OMAP5430_TEMP_SENSOR_MPU_OFFSET			0x14C
 #define OMAP5430_BGAP_THRESHOLD_MPU_OFFSET		0x1A4
 #define OMAP5430_BGAP_TSHUT_MPU_OFFSET			0x1B0
-#define OMAP5430_BGAP_CUMUL_DTEMP_MPU_OFFSET		0x1BC
-#define OMAP5430_BGAP_DTEMP_MPU_0_OFFSET		0x1E0
 #define OMAP5430_BGAP_DTEMP_MPU_1_OFFSET		0x1E4
 #define OMAP5430_BGAP_DTEMP_MPU_2_OFFSET		0x1E8
-#define OMAP5430_BGAP_DTEMP_MPU_3_OFFSET		0x1EC
-#define OMAP5430_BGAP_DTEMP_MPU_4_OFFSET		0x1F0
 
 /* OMAP5430.MPU register offsets */
 #define OMAP5430_FUSE_OPP_BGAP_CORE			0x8
 #define OMAP5430_TEMP_SENSOR_CORE_OFFSET		0x154
 #define OMAP5430_BGAP_THRESHOLD_CORE_OFFSET		0x1AC
 #define OMAP5430_BGAP_TSHUT_CORE_OFFSET			0x1B8
-#define OMAP5430_BGAP_CUMUL_DTEMP_CORE_OFFSET		0x1C4
-#define OMAP5430_BGAP_DTEMP_CORE_0_OFFSET		0x208
 #define OMAP5430_BGAP_DTEMP_CORE_1_OFFSET		0x20C
 #define OMAP5430_BGAP_DTEMP_CORE_2_OFFSET		0x210
-#define OMAP5430_BGAP_DTEMP_CORE_3_OFFSET		0x214
-#define OMAP5430_BGAP_DTEMP_CORE_4_OFFSET		0x218
 
 /* OMAP5430.common register offsets */
 #define OMAP5430_BGAP_CTRL_OFFSET			0x1A0
@@ -94,17 +82,10 @@
 #define OMAP5430_BGAP_TEMP_SENSOR_DTEMP_MASK		(0x3ff << 0)
 
 /* OMAP5430.BANDGAP_CTRL */
-#define OMAP5430_MASK_SIDLEMODE_MASK			(0x3 << 30)
 #define OMAP5430_MASK_COUNTER_DELAY_MASK		(0x7 << 27)
 #define OMAP5430_MASK_FREEZE_CORE_MASK			BIT(23)
 #define OMAP5430_MASK_FREEZE_GPU_MASK			BIT(22)
 #define OMAP5430_MASK_FREEZE_MPU_MASK			BIT(21)
-#define OMAP5430_MASK_CLEAR_CORE_MASK			BIT(20)
-#define OMAP5430_MASK_CLEAR_GPU_MASK			BIT(19)
-#define OMAP5430_MASK_CLEAR_MPU_MASK			BIT(18)
-#define OMAP5430_MASK_CLEAR_ACCUM_CORE_MASK		BIT(17)
-#define OMAP5430_MASK_CLEAR_ACCUM_GPU_MASK		BIT(16)
-#define OMAP5430_MASK_CLEAR_ACCUM_MPU_MASK		BIT(15)
 #define OMAP5430_MASK_HOT_CORE_MASK			BIT(5)
 #define OMAP5430_MASK_COLD_CORE_MASK			BIT(4)
 #define OMAP5430_MASK_HOT_GPU_MASK			BIT(3)
@@ -123,17 +104,7 @@
 #define OMAP5430_TSHUT_HOT_MASK				(0x3ff << 16)
 #define OMAP5430_TSHUT_COLD_MASK			(0x3ff << 0)
 
-/* OMAP5430.BANDGAP_CUMUL_DTEMP_MPU */
-#define OMAP5430_CUMUL_DTEMP_MPU_MASK			(0xffffffff << 0)
-
-/* OMAP5430.BANDGAP_CUMUL_DTEMP_GPU */
-#define OMAP5430_CUMUL_DTEMP_GPU_MASK			(0xffffffff << 0)
-
-/* OMAP5430.BANDGAP_CUMUL_DTEMP_CORE */
-#define OMAP5430_CUMUL_DTEMP_CORE_MASK			(0xffffffff << 0)
-
 /* OMAP5430.BANDGAP_STATUS */
-#define OMAP5430_BGAP_ALERT_MASK			BIT(31)
 #define OMAP5430_HOT_CORE_FLAG_MASK			BIT(5)
 #define OMAP5430_COLD_CORE_FLAG_MASK			BIT(4)
 #define OMAP5430_HOT_GPU_FLAG_MASK			BIT(3)
@@ -159,10 +130,6 @@
 /* bandgap clock limits */
 #define OMAP5430_GPU_MAX_FREQ				1500000
 #define OMAP5430_GPU_MIN_FREQ				1000000
-/* sensor limits */
-#define OMAP5430_GPU_MIN_TEMP				-40000
-#define OMAP5430_GPU_MAX_TEMP				125000
-#define OMAP5430_GPU_HYST_VAL				5000
 /* interrupts thresholds */
 #define OMAP5430_GPU_TSHUT_HOT				915
 #define OMAP5430_GPU_TSHUT_COLD				900
@@ -173,10 +140,6 @@
 /* bandgap clock limits */
 #define OMAP5430_MPU_MAX_FREQ				1500000
 #define OMAP5430_MPU_MIN_FREQ				1000000
-/* sensor limits */
-#define OMAP5430_MPU_MIN_TEMP				-40000
-#define OMAP5430_MPU_MAX_TEMP				125000
-#define OMAP5430_MPU_HYST_VAL				5000
 /* interrupts thresholds */
 #define OMAP5430_MPU_TSHUT_HOT				915
 #define OMAP5430_MPU_TSHUT_COLD				900
@@ -187,10 +150,6 @@
 /* bandgap clock limits */
 #define OMAP5430_CORE_MAX_FREQ				1500000
 #define OMAP5430_CORE_MIN_FREQ				1000000
-/* sensor limits */
-#define OMAP5430_CORE_MIN_TEMP				-40000
-#define OMAP5430_CORE_MAX_TEMP				125000
-#define OMAP5430_CORE_HYST_VAL				5000
 /* interrupts thresholds */
 #define OMAP5430_CORE_TSHUT_HOT				915
 #define OMAP5430_CORE_TSHUT_COLD			900
Index: b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
===================================================================
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c	2018-05-02 15:14:18.133522058 +0200
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c	2018-05-02 15:14:18.129522058 +0200
@@ -306,217 +306,6 @@ int ti_bandgap_adc_to_mcelsius(struct ti
 }
 
 /**
- * ti_bandgap_mcelsius_to_adc() - converts a mCelsius value to ADC scale
- * @bgp: struct ti_bandgap pointer
- * @temp: value in mCelsius
- * @adc: address where to write the resulting temperature in ADC representation
- *
- * Simple conversion from mCelsius to ADC values. In case the temp value
- * is out of the ADC conv table range, it returns -ERANGE, 0 on success.
- * The conversion table is indexed by the ADC values.
- *
- * Return: 0 if conversion was successful, else -ERANGE in case the @temp
- * argument is out of the ADC conv table range.
- */
-static
-int ti_bandgap_mcelsius_to_adc(struct ti_bandgap *bgp, long temp, int *adc)
-{
-	const struct ti_bandgap_data *conf = bgp->conf;
-	const int *conv_table = bgp->conf->conv_table;
-	int high, low, mid;
-
-	low = 0;
-	high = conf->adc_end_val - conf->adc_start_val;
-	mid = (high + low) / 2;
-
-	if (temp < conv_table[low] || temp > conv_table[high])
-		return -ERANGE;
-
-	while (low < high) {
-		if (temp < conv_table[mid])
-			high = mid - 1;
-		else
-			low = mid + 1;
-		mid = (low + high) / 2;
-	}
-
-	*adc = conf->adc_start_val + low;
-	return 0;
-}
-
-/**
- * ti_bandgap_add_hyst() - add hysteresis (in mCelsius) to an ADC value
- * @bgp: struct ti_bandgap pointer
- * @adc_val: temperature value in ADC representation
- * @hyst_val: hysteresis value in mCelsius
- * @sum: address where to write the resulting temperature (in ADC scale)
- *
- * Adds an hysteresis value (in mCelsius) to a ADC temperature value.
- *
- * Return: 0 on success, -ERANGE otherwise.
- */
-static
-int ti_bandgap_add_hyst(struct ti_bandgap *bgp, int adc_val, int hyst_val,
-			u32 *sum)
-{
-	int temp, ret;
-
-	/*
-	 * Need to add in the mcelsius domain, so we have a temperature
-	 * the conv_table range
-	 */
-	ret = ti_bandgap_adc_to_mcelsius(bgp, adc_val, &temp);
-	if (ret < 0)
-		return ret;
-
-	temp += hyst_val;
-
-	ret = ti_bandgap_mcelsius_to_adc(bgp, temp, sum);
-	return ret;
-}
-
-/***   Helper functions handling device Alert/Shutdown signals   ***/
-
-/**
- * ti_bandgap_unmask_interrupts() - unmasks the events of thot & tcold
- * @bgp: struct ti_bandgap pointer
- * @id: bandgap sensor id
- * @t_hot: hot temperature value to trigger alert signal
- * @t_cold: cold temperature value to trigger alert signal
- *
- * Checks the requested t_hot and t_cold values and configures the IRQ event
- * masks accordingly. Call this function only if bandgap features HAS(TALERT).
- */
-static void ti_bandgap_unmask_interrupts(struct ti_bandgap *bgp, int id,
-					 u32 t_hot, u32 t_cold)
-{
-	struct temp_sensor_registers *tsr;
-	u32 temp, reg_val;
-
-	/* Read the current on die temperature */
-	temp = ti_bandgap_read_temp(bgp, id);
-
-	tsr = bgp->conf->sensors[id].registers;
-	reg_val = ti_bandgap_readl(bgp, tsr->bgap_mask_ctrl);
-
-	if (temp < t_hot)
-		reg_val |= tsr->mask_hot_mask;
-	else
-		reg_val &= ~tsr->mask_hot_mask;
-
-	if (t_cold < temp)
-		reg_val |= tsr->mask_cold_mask;
-	else
-		reg_val &= ~tsr->mask_cold_mask;
-	ti_bandgap_writel(bgp, reg_val, tsr->bgap_mask_ctrl);
-}
-
-/**
- * ti_bandgap_update_alert_threshold() - sequence to update thresholds
- * @bgp: struct ti_bandgap pointer
- * @id: bandgap sensor id
- * @val: value (ADC) of a new threshold
- * @hot: desired threshold to be updated. true if threshold hot, false if
- *       threshold cold
- *
- * It will program the required thresholds (hot and cold) for TALERT signal.
- * This function can be used to update t_hot or t_cold, depending on @hot value.
- * It checks the resulting t_hot and t_cold values, based on the new passed @val
- * and configures the thresholds so that t_hot is always greater than t_cold.
- * Call this function only if bandgap features HAS(TALERT).
- *
- * Return: 0 if no error, else corresponding error
- */
-static int ti_bandgap_update_alert_threshold(struct ti_bandgap *bgp, int id,
-					     int val, bool hot)
-{
-	struct temp_sensor_data *ts_data = bgp->conf->sensors[id].ts_data;
-	struct temp_sensor_registers *tsr;
-	u32 thresh_val, reg_val, t_hot, t_cold, ctrl;
-	int err = 0;
-
-	tsr = bgp->conf->sensors[id].registers;
-
-	/* obtain the current value */
-	thresh_val = ti_bandgap_readl(bgp, tsr->bgap_threshold);
-	t_cold = (thresh_val & tsr->threshold_tcold_mask) >>
-		__ffs(tsr->threshold_tcold_mask);
-	t_hot = (thresh_val & tsr->threshold_thot_mask) >>
-		__ffs(tsr->threshold_thot_mask);
-	if (hot)
-		t_hot = val;
-	else
-		t_cold = val;
-
-	if (t_cold > t_hot) {
-		if (hot)
-			err = ti_bandgap_add_hyst(bgp, t_hot,
-						  -ts_data->hyst_val,
-						  &t_cold);
-		else
-			err = ti_bandgap_add_hyst(bgp, t_cold,
-						  ts_data->hyst_val,
-						  &t_hot);
-	}
-
-	/* write the new threshold values */
-	reg_val = thresh_val &
-		  ~(tsr->threshold_thot_mask | tsr->threshold_tcold_mask);
-	reg_val |= (t_hot << __ffs(tsr->threshold_thot_mask)) |
-		   (t_cold << __ffs(tsr->threshold_tcold_mask));
-
-	/**
-	 * Errata i813:
-	 * Spurious Thermal Alert: Talert can happen randomly while the device
-	 * remains under the temperature limit defined for this event to trig.
-	 * This spurious event is caused by a incorrect re-synchronization
-	 * between clock domains. The comparison between configured threshold
-	 * and current temperature value can happen while the value is
-	 * transitioning (metastable), thus causing inappropriate event
-	 * generation. No spurious event occurs as long as the threshold value
-	 * stays unchanged. Spurious event can be generated while a thermal
-	 * alert threshold is modified in
-	 * CONTROL_BANDGAP_THRESHOLD_MPU/GPU/CORE/DSPEVE/IVA_n.
-	 */
-
-	if (TI_BANDGAP_HAS(bgp, ERRATA_813)) {
-		/* Mask t_hot and t_cold events at the IP Level */
-		ctrl = ti_bandgap_readl(bgp, tsr->bgap_mask_ctrl);
-
-		if (hot)
-			ctrl &= ~tsr->mask_hot_mask;
-		else
-			ctrl &= ~tsr->mask_cold_mask;
-
-		ti_bandgap_writel(bgp, ctrl, tsr->bgap_mask_ctrl);
-	}
-
-	/* Write the threshold value */
-	ti_bandgap_writel(bgp, reg_val, tsr->bgap_threshold);
-
-	if (TI_BANDGAP_HAS(bgp, ERRATA_813)) {
-		/* Unmask t_hot and t_cold events at the IP Level */
-		ctrl = ti_bandgap_readl(bgp, tsr->bgap_mask_ctrl);
-		if (hot)
-			ctrl |= tsr->mask_hot_mask;
-		else
-			ctrl |= tsr->mask_cold_mask;
-
-		ti_bandgap_writel(bgp, ctrl, tsr->bgap_mask_ctrl);
-	}
-
-	if (err) {
-		dev_err(bgp->dev, "failed to reprogram thot threshold\n");
-		err = -EIO;
-		goto exit;
-	}
-
-	ti_bandgap_unmask_interrupts(bgp, id, t_hot, t_cold);
-exit:
-	return err;
-}
-
-/**
  * ti_bandgap_validate() - helper to check the sanity of a struct ti_bandgap
  * @bgp: struct ti_bandgap pointer
  * @id: bandgap sensor id
@@ -544,165 +333,6 @@ static inline int ti_bandgap_validate(st
 }
 
 /**
- * _ti_bandgap_write_threshold() - helper to update TALERT t_cold or t_hot
- * @bgp: struct ti_bandgap pointer
- * @id: bandgap sensor id
- * @val: value (mCelsius) of a new threshold
- * @hot: desired threshold to be updated. true if threshold hot, false if
- *       threshold cold
- *
- * It will update the required thresholds (hot and cold) for TALERT signal.
- * This function can be used to update t_hot or t_cold, depending on @hot value.
- * Validates the mCelsius range and update the requested threshold.
- * Call this function only if bandgap features HAS(TALERT).
- *
- * Return: 0 if no error, else corresponding error value.
- */
-static int _ti_bandgap_write_threshold(struct ti_bandgap *bgp, int id, int val,
-				       bool hot)
-{
-	struct temp_sensor_data *ts_data;
-	struct temp_sensor_registers *tsr;
-	u32 adc_val;
-	int ret;
-
-	ret = ti_bandgap_validate(bgp, id);
-	if (ret)
-		return ret;
-
-	if (!TI_BANDGAP_HAS(bgp, TALERT))
-		return -ENOTSUPP;
-
-	ts_data = bgp->conf->sensors[id].ts_data;
-	tsr = bgp->conf->sensors[id].registers;
-	if (hot) {
-		if (val < ts_data->min_temp + ts_data->hyst_val)
-			ret = -EINVAL;
-	} else {
-		if (val > ts_data->max_temp + ts_data->hyst_val)
-			ret = -EINVAL;
-	}
-
-	if (ret)
-		return ret;
-
-	ret = ti_bandgap_mcelsius_to_adc(bgp, val, &adc_val);
-	if (ret < 0)
-		return ret;
-
-	spin_lock(&bgp->lock);
-	ret = ti_bandgap_update_alert_threshold(bgp, id, adc_val, hot);
-	spin_unlock(&bgp->lock);
-	return ret;
-}
-
-/**
- * _ti_bandgap_read_threshold() - helper to read TALERT t_cold or t_hot
- * @bgp: struct ti_bandgap pointer
- * @id: bandgap sensor id
- * @val: value (mCelsius) of a threshold
- * @hot: desired threshold to be read. true if threshold hot, false if
- *       threshold cold
- *
- * It will fetch the required thresholds (hot and cold) for TALERT signal.
- * This function can be used to read t_hot or t_cold, depending on @hot value.
- * Call this function only if bandgap features HAS(TALERT).
- *
- * Return: 0 if no error, -ENOTSUPP if it has no TALERT support, or the
- * corresponding error value if some operation fails.
- */
-static int _ti_bandgap_read_threshold(struct ti_bandgap *bgp, int id,
-				      int *val, bool hot)
-{
-	struct temp_sensor_registers *tsr;
-	u32 temp, mask;
-	int ret = 0;
-
-	ret = ti_bandgap_validate(bgp, id);
-	if (ret)
-		goto exit;
-
-	if (!TI_BANDGAP_HAS(bgp, TALERT)) {
-		ret = -ENOTSUPP;
-		goto exit;
-	}
-
-	tsr = bgp->conf->sensors[id].registers;
-	if (hot)
-		mask = tsr->threshold_thot_mask;
-	else
-		mask = tsr->threshold_tcold_mask;
-
-	temp = ti_bandgap_readl(bgp, tsr->bgap_threshold);
-	temp = (temp & mask) >> __ffs(mask);
-	ret = ti_bandgap_adc_to_mcelsius(bgp, temp, &temp);
-	if (ret) {
-		dev_err(bgp->dev, "failed to read thot\n");
-		ret = -EIO;
-		goto exit;
-	}
-
-	*val = temp;
-
-exit:
-	return ret;
-}
-
-/***   Exposed APIs   ***/
-
-/**
- * ti_bandgap_read_thot() - reads sensor current thot
- * @bgp: pointer to bandgap instance
- * @id: sensor id
- * @thot: resulting current thot value
- *
- * Return: 0 on success or the proper error code
- */
-int ti_bandgap_read_thot(struct ti_bandgap *bgp, int id, int *thot)
-{
-	return _ti_bandgap_read_threshold(bgp, id, thot, true);
-}
-
-/**
- * ti_bandgap_write_thot() - sets sensor current thot
- * @bgp: pointer to bandgap instance
- * @id: sensor id
- * @val: desired thot value
- *
- * Return: 0 on success or the proper error code
- */
-int ti_bandgap_write_thot(struct ti_bandgap *bgp, int id, int val)
-{
-	return _ti_bandgap_write_threshold(bgp, id, val, true);
-}
-
-/**
- * ti_bandgap_read_tcold() - reads sensor current tcold
- * @bgp: pointer to bandgap instance
- * @id: sensor id
- * @tcold: resulting current tcold value
- *
- * Return: 0 on success or the proper error code
- */
-int ti_bandgap_read_tcold(struct ti_bandgap *bgp, int id, int *tcold)
-{
-	return _ti_bandgap_read_threshold(bgp, id, tcold, false);
-}
-
-/**
- * ti_bandgap_write_tcold() - sets the sensor tcold
- * @bgp: pointer to bandgap instance
- * @id: sensor id
- * @val: desired tcold value
- *
- * Return: 0 on success or the proper error code
- */
-int ti_bandgap_write_tcold(struct ti_bandgap *bgp, int id, int val)
-{
-	return _ti_bandgap_write_threshold(bgp, id, val, false);
-}
-
-/**
  * ti_bandgap_read_counter() - read the sensor counter
  * @bgp: pointer to bandgap instance
  * @id: sensor id
Index: b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
===================================================================
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.h	2018-05-02 15:14:18.133522058 +0200
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.h	2018-05-02 15:14:18.129522058 +0200
@@ -78,11 +78,8 @@
  * @bgap_mask_ctrl: BANDGAP_MASK_CTRL register offset
  * @mask_hot_mask: mask to bandgap_mask_ctrl.mask_hot
  * @mask_cold_mask: mask to bandgap_mask_ctrl.mask_cold
- * @mask_sidlemode_mask: mask to bandgap_mask_ctrl.mask_sidlemode
  * @mask_counter_delay_mask: mask to bandgap_mask_ctrl.mask_counter_delay
  * @mask_freeze_mask: mask to bandgap_mask_ctrl.mask_free
- * @mask_clear_mask: mask to bandgap_mask_ctrl.mask_clear
- * @mask_clear_accum_mask: mask to bandgap_mask_ctrl.mask_clear_accum
  * @bgap_mode_ctrl: BANDGAP_MODE_CTRL register offset
  * @mode_ctrl_mask: mask to bandgap_mode_ctrl.mode_ctrl
  * @bgap_counter: BANDGAP_COUNTER register offset
@@ -91,21 +88,13 @@
  * @threshold_thot_mask: mask to bandgap_threhold.thot
  * @threshold_tcold_mask: mask to bandgap_threhold.tcold
  * @tshut_threshold: TSHUT_THRESHOLD register offset (TSHUT thresholds)
- * @tshut_efuse_mask: mask to tshut_threshold.tshut_efuse
- * @tshut_efuse_shift: shift to tshut_threshold.tshut_efuse
  * @tshut_hot_mask: mask to tshut_threhold.thot
  * @tshut_cold_mask: mask to tshut_threhold.thot
  * @bgap_status: BANDGAP_STATUS register offset
- * @status_clean_stop_mask: mask to bandgap_status.clean_stop
- * @status_bgap_alert_mask: mask to bandgap_status.bandgap_alert
  * @status_hot_mask: mask to bandgap_status.hot
  * @status_cold_mask: mask to bandgap_status.cold
- * @bgap_cumul_dtemp: BANDGAP_CUMUL_DTEMP register offset
- * @ctrl_dtemp_0: CTRL_DTEMP0 register offset
  * @ctrl_dtemp_1: CTRL_DTEMP1 register offset
  * @ctrl_dtemp_2: CTRL_DTEMP2 register offset
- * @ctrl_dtemp_3: CTRL_DTEMP3 register offset
- * @ctrl_dtemp_4: CTRL_DTEMP4 register offset
  * @bgap_efuse: BANDGAP_EFUSE register offset
  *
  * The register offsets and bitfields might change across
@@ -121,17 +110,14 @@ struct temp_sensor_registers {
 	u32	temp_sensor_ctrl;
 	u32	bgap_tempsoff_mask;
 	u32	bgap_soc_mask;
-	u32	bgap_eocz_mask; /* not used: but needs revisit */
+	u32	bgap_eocz_mask;
 	u32	bgap_dtemp_mask;
 
 	u32	bgap_mask_ctrl;
 	u32	mask_hot_mask;
 	u32	mask_cold_mask;
-	u32	mask_sidlemode_mask; /* not used: but may be needed for pm */
 	u32	mask_counter_delay_mask;
 	u32	mask_freeze_mask;
-	u32	mask_clear_mask; /* not used: but needed for trending */
-	u32	mask_clear_accum_mask; /* not used: but needed for trending */
 
 	u32	bgap_mode_ctrl;
 	u32	mode_ctrl_mask;
@@ -144,23 +130,15 @@ struct temp_sensor_registers {
 	u32	threshold_tcold_mask;
 
 	u32	tshut_threshold;
-	u32	tshut_efuse_mask; /* not used */
-	u32	tshut_efuse_shift; /* not used */
 	u32	tshut_hot_mask;
 	u32	tshut_cold_mask;
 
 	u32	bgap_status;
-	u32	status_clean_stop_mask; /* not used: but needed for trending */
-	u32	status_bgap_alert_mask; /* not used */
 	u32	status_hot_mask;
 	u32	status_cold_mask;
 
-	u32	bgap_cumul_dtemp; /* not used: but needed for trending */
-	u32	ctrl_dtemp_0; /* not used: but needed for trending */
-	u32	ctrl_dtemp_1; /* not used: but needed for trending */
-	u32	ctrl_dtemp_2; /* not used: but needed for trending */
-	u32	ctrl_dtemp_3; /* not used: but needed for trending */
-	u32	ctrl_dtemp_4; /* not used: but needed for trending */
+	u32	ctrl_dtemp_1;
+	u32	ctrl_dtemp_2;
 	u32	bgap_efuse;
 };
 
@@ -172,11 +150,6 @@ struct temp_sensor_registers {
  * @t_cold: temperature to trigger a thermal alert (low initial value)
  * @min_freq: sensor minimum clock rate
  * @max_freq: sensor maximum clock rate
- * @max_temp: sensor maximum temperature
- * @min_temp: sensor minimum temperature
- * @hyst_val: temperature hysteresis considered while converting ADC values
- * @update_int1: update interval
- * @update_int2: update interval
  *
  * This data structure will hold the required thresholds and temperature limits
  * for a specific temperature sensor, like shutdown temperature, alert
@@ -189,11 +162,6 @@ struct temp_sensor_data {
 	u32	t_cold;
 	u32	min_freq;
 	u32	max_freq;
-	int     max_temp;
-	int     min_temp;
-	int     hyst_val;
-	u32     update_int1; /* not used */
-	u32     update_int2; /* not used */
 };
 
 struct ti_bandgap_data;
@@ -316,8 +284,6 @@ struct ti_temp_sensor {
  *
  * TI_BANDGAP_FEATURE_ERRATA_814 - used to workaorund when the bandgap device
  *	has Errata 814
- * TI_BANDGAP_FEATURE_ERRATA_813 - used to workaorund when the bandgap device
- *	has Errata 813
  * TI_BANDGAP_FEATURE_UNRELIABLE - used when the sensor readings are too
  *	inaccurate.
  * TI_BANDGAP_HAS(b, f) - macro to check if a bandgap device is capable of a
@@ -334,8 +300,7 @@ struct ti_temp_sensor {
 #define TI_BANDGAP_FEATURE_COUNTER_DELAY	BIT(8)
 #define TI_BANDGAP_FEATURE_HISTORY_BUFFER	BIT(9)
 #define TI_BANDGAP_FEATURE_ERRATA_814		BIT(10)
-#define TI_BANDGAP_FEATURE_ERRATA_813		BIT(11)
-#define TI_BANDGAP_FEATURE_UNRELIABLE		BIT(12)
+#define TI_BANDGAP_FEATURE_UNRELIABLE		BIT(11)
 #define TI_BANDGAP_HAS(b, f)			\
 			((b)->conf->features & TI_BANDGAP_FEATURE_ ## f)
 
