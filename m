From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 06/14] thermal: ti-soc-thermal: remove
 ->threshold_[thot,tcold]_mask fields
Date: Mon, 14 May 2018 13:42:13 +0200
Message-ID: <1526298141-14045-7-git-send-email-b.zolnierkie@samsung.com>
References: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180514114331epcas2p3d52dea1f2feda21ff2cce1548f3f5bd4@epcas2p3.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-omap@vger.kernel.org

.threshold_[thot,tcold]_mask fields are set to identical values for
all sensors supporting TALERT feature so remove them and use common
defines instead.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/ti-soc-thermal/dra752-bandgap.h      |  4 ----
 drivers/thermal/ti-soc-thermal/dra752-thermal-data.c | 10 ----------
 drivers/thermal/ti-soc-thermal/omap4-thermal-data.c  |  2 --
 drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h    |  4 ----
 drivers/thermal/ti-soc-thermal/omap5-thermal-data.c  |  6 ------
 drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h    |  4 ----
 drivers/thermal/ti-soc-thermal/ti-bandgap.c          | 20 ++++++++++++++++----
 drivers/thermal/ti-soc-thermal/ti-bandgap.h          |  8 ++++----
 8 files changed, 20 insertions(+), 38 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/dra752-bandgap.h b/drivers/thermal/ti-soc-thermal/dra752-bandgap.h
index 9490cd6..b7156bf 100644
--- a/drivers/thermal/ti-soc-thermal/dra752-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/dra752-bandgap.h
@@ -132,10 +132,6 @@
 #define DRA752_TEMP_SENSOR_EOCZ_MASK		BIT(10)
 #define DRA752_TEMP_SENSOR_DTEMP_MASK		(0x3ff << 0)
 
-/* DRA752.BANDGAP_THRESHOLD */
-#define DRA752_BANDGAP_THRESHOLD_HOT_MASK		(0x3ff << 16)
-#define DRA752_BANDGAP_THRESHOLD_COLD_MASK		(0x3ff << 0)
-
 /**
  * Temperature limits and thresholds for DRA752
  *
diff --git a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
index c854642..a88a0e5 100644
--- a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
@@ -44,8 +44,6 @@
 	.mask_counter_delay_mask = DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_MASK,
 	.mask_freeze_mask = DRA752_BANDGAP_CTRL_1_FREEZE_CORE_MASK,
 	.bgap_threshold = DRA752_BANDGAP_THRESHOLD_CORE_OFFSET,
-	.threshold_thot_mask = DRA752_BANDGAP_THRESHOLD_HOT_MASK,
-	.threshold_tcold_mask = DRA752_BANDGAP_THRESHOLD_COLD_MASK,
 	.bgap_status = DRA752_BANDGAP_STATUS_1_OFFSET,
 	.status_hot_mask = DRA752_BANDGAP_STATUS_1_HOT_CORE_MASK,
 	.status_cold_mask = DRA752_BANDGAP_STATUS_1_COLD_CORE_MASK,
@@ -69,8 +67,6 @@
 	.mask_counter_delay_mask = DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_MASK,
 	.mask_freeze_mask = DRA752_BANDGAP_CTRL_2_FREEZE_IVA_MASK,
 	.bgap_threshold = DRA752_BANDGAP_THRESHOLD_IVA_OFFSET,
-	.threshold_thot_mask = DRA752_BANDGAP_THRESHOLD_HOT_MASK,
-	.threshold_tcold_mask = DRA752_BANDGAP_THRESHOLD_COLD_MASK,
 	.bgap_status = DRA752_BANDGAP_STATUS_2_OFFSET,
 	.status_hot_mask = DRA752_BANDGAP_STATUS_2_HOT_IVA_MASK,
 	.status_cold_mask = DRA752_BANDGAP_STATUS_2_COLD_IVA_MASK,
@@ -94,8 +90,6 @@
 	.mask_counter_delay_mask = DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_MASK,
 	.mask_freeze_mask = DRA752_BANDGAP_CTRL_1_FREEZE_MPU_MASK,
 	.bgap_threshold = DRA752_BANDGAP_THRESHOLD_MPU_OFFSET,
-	.threshold_thot_mask = DRA752_BANDGAP_THRESHOLD_HOT_MASK,
-	.threshold_tcold_mask = DRA752_BANDGAP_THRESHOLD_COLD_MASK,
 	.bgap_status = DRA752_BANDGAP_STATUS_1_OFFSET,
 	.status_hot_mask = DRA752_BANDGAP_STATUS_1_HOT_MPU_MASK,
 	.status_cold_mask = DRA752_BANDGAP_STATUS_1_COLD_MPU_MASK,
@@ -119,8 +113,6 @@
 	.mask_counter_delay_mask = DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_MASK,
 	.mask_freeze_mask = DRA752_BANDGAP_CTRL_2_FREEZE_DSPEVE_MASK,
 	.bgap_threshold = DRA752_BANDGAP_THRESHOLD_DSPEVE_OFFSET,
-	.threshold_thot_mask = DRA752_BANDGAP_THRESHOLD_HOT_MASK,
-	.threshold_tcold_mask = DRA752_BANDGAP_THRESHOLD_COLD_MASK,
 	.bgap_status = DRA752_BANDGAP_STATUS_2_OFFSET,
 	.status_hot_mask = DRA752_BANDGAP_STATUS_2_HOT_DSPEVE_MASK,
 	.status_cold_mask = DRA752_BANDGAP_STATUS_2_COLD_DSPEVE_MASK,
@@ -144,8 +136,6 @@
 	.mask_counter_delay_mask = DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_MASK,
 	.mask_freeze_mask = DRA752_BANDGAP_CTRL_1_FREEZE_GPU_MASK,
 	.bgap_threshold = DRA752_BANDGAP_THRESHOLD_GPU_OFFSET,
-	.threshold_thot_mask = DRA752_BANDGAP_THRESHOLD_HOT_MASK,
-	.threshold_tcold_mask = DRA752_BANDGAP_THRESHOLD_COLD_MASK,
 	.bgap_status = DRA752_BANDGAP_STATUS_1_OFFSET,
 	.status_hot_mask = DRA752_BANDGAP_STATUS_1_HOT_GPU_MASK,
 	.status_cold_mask = DRA752_BANDGAP_STATUS_1_COLD_GPU_MASK,
diff --git a/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c b/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
index 14d9fe2..9545fe3 100644
--- a/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
@@ -108,8 +108,6 @@
 	.counter_mask = OMAP4460_COUNTER_MASK,
 
 	.bgap_threshold = OMAP4460_BGAP_THRESHOLD_OFFSET,
-	.threshold_thot_mask = OMAP4460_T_HOT_MASK,
-	.threshold_tcold_mask = OMAP4460_T_COLD_MASK,
 
 	.tshut_threshold = OMAP4460_BGAP_TSHUT_OFFSET,
 	.tshut_hot_mask = OMAP4460_TSHUT_HOT_MASK,
diff --git a/drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h b/drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h
index b87c8659..c1da37d 100644
--- a/drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h
@@ -130,10 +130,6 @@
 /* OMAP4460.BANDGAP_COUNTER bits */
 #define OMAP4460_COUNTER_MASK				(0xffffff << 0)
 
-/* OMAP4460.BANDGAP_THRESHOLD bits */
-#define OMAP4460_T_HOT_MASK				(0x3ff << 16)
-#define OMAP4460_T_COLD_MASK				(0x3ff << 0)
-
 /* OMAP4460.TSHUT_THRESHOLD bits */
 #define OMAP4460_TSHUT_HOT_MASK				(0x3ff << 16)
 #define OMAP4460_TSHUT_COLD_MASK			(0x3ff << 0)
diff --git a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
index 843faa7..51a6ab4 100644
--- a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
@@ -42,8 +42,6 @@
 	.mask_freeze_mask = OMAP5430_MASK_FREEZE_MPU_MASK,
 
 	.bgap_threshold = OMAP5430_BGAP_THRESHOLD_MPU_OFFSET,
-	.threshold_thot_mask = OMAP5430_T_HOT_MASK,
-	.threshold_tcold_mask = OMAP5430_T_COLD_MASK,
 
 	.tshut_threshold = OMAP5430_BGAP_TSHUT_MPU_OFFSET,
 	.tshut_hot_mask = OMAP5430_TSHUT_HOT_MASK,
@@ -75,8 +73,6 @@
 	.mask_freeze_mask = OMAP5430_MASK_FREEZE_GPU_MASK,
 
 	.bgap_threshold = OMAP5430_BGAP_THRESHOLD_GPU_OFFSET,
-	.threshold_thot_mask = OMAP5430_T_HOT_MASK,
-	.threshold_tcold_mask = OMAP5430_T_COLD_MASK,
 
 	.tshut_threshold = OMAP5430_BGAP_TSHUT_GPU_OFFSET,
 	.tshut_hot_mask = OMAP5430_TSHUT_HOT_MASK,
@@ -109,8 +105,6 @@
 	.mask_freeze_mask = OMAP5430_MASK_FREEZE_CORE_MASK,
 
 	.bgap_threshold = OMAP5430_BGAP_THRESHOLD_CORE_OFFSET,
-	.threshold_thot_mask = OMAP5430_T_HOT_MASK,
-	.threshold_tcold_mask = OMAP5430_T_COLD_MASK,
 
 	.tshut_threshold = OMAP5430_BGAP_TSHUT_CORE_OFFSET,
 	.tshut_hot_mask = OMAP5430_TSHUT_HOT_MASK,
diff --git a/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h b/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
index 223c7a8..ec536d8 100644
--- a/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
@@ -93,10 +93,6 @@
 #define OMAP5430_MASK_HOT_MPU_MASK			BIT(1)
 #define OMAP5430_MASK_COLD_MPU_MASK			BIT(0)
 
-/* OMAP5430.BANDGAP_THRESHOLD */
-#define OMAP5430_T_HOT_MASK				(0x3ff << 16)
-#define OMAP5430_T_COLD_MASK				(0x3ff << 0)
-
 /* OMAP5430.TSHUT_THRESHOLD */
 #define OMAP5430_TSHUT_HOT_MASK				(0x3ff << 16)
 #define OMAP5430_TSHUT_COLD_MASK			(0x3ff << 0)
diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index 3ac74fe..cb9a27e 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -92,6 +92,18 @@ static void ti_bandgap_writel(struct ti_bandgap *bgp, u32 val, u32 reg)
 	ti_bandgap_writel(bgp, r, t->reg);			\
 } while (0)
 
+#define RMW_BITS2(bgp, id, reg, mask, val)			\
+do {								\
+	struct temp_sensor_registers *t;			\
+	u32 r;							\
+								\
+	t = bgp->conf->sensors[(id)].registers;		\
+	r = ti_bandgap_readl(bgp, t->reg);			\
+	r &= ~mask;						\
+	r |= (val) << __ffs(mask);				\
+	ti_bandgap_writel(bgp, r, t->reg);			\
+} while (0)
+
 /***   Basic helper functions   ***/
 
 /**
@@ -980,10 +992,10 @@ int ti_bandgap_probe(struct platform_device *pdev)
 
 		if (TI_BANDGAP_HAS(bgp, TALERT)) {
 			/* Set initial Talert thresholds */
-			RMW_BITS(bgp, i, bgap_threshold,
-				 threshold_tcold_mask, ts_data->t_cold);
-			RMW_BITS(bgp, i, bgap_threshold,
-				 threshold_thot_mask, ts_data->t_hot);
+			RMW_BITS2(bgp, i, bgap_threshold,
+				 OMAP_T_COLD_MASK, ts_data->t_cold);
+			RMW_BITS2(bgp, i, bgap_threshold,
+				 OMAP_T_HOT_MASK, ts_data->t_hot);
 			/* Enable the alert events */
 			RMW_BITS(bgp, i, bgap_mask_ctrl, mask_hot_mask, 1);
 			RMW_BITS(bgp, i, bgap_mask_ctrl, mask_cold_mask, 1);
diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.h b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
index 809dbdc..2e5b146 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
@@ -68,6 +68,10 @@
  * sensors, representing every sensor instance present in this bandgap.
  */
 
+/* BANDGAP_THRESHOLD */
+#define OMAP_T_HOT_MASK		(0x3ff << 16)
+#define OMAP_T_COLD_MASK	(0x3ff << 0)
+
 /**
  * struct temp_sensor_registers - descriptor to access registers and bitfields
  * @temp_sensor_ctrl: TEMP_SENSOR_CTRL register offset
@@ -85,8 +89,6 @@
  * @bgap_counter: BANDGAP_COUNTER register offset
  * @counter_mask: mask to bandgap_counter.counter
  * @bgap_threshold: BANDGAP_THRESHOLD register offset (TALERT thresholds)
- * @threshold_thot_mask: mask to bandgap_threhold.thot
- * @threshold_tcold_mask: mask to bandgap_threhold.tcold
  * @tshut_threshold: TSHUT_THRESHOLD register offset (TSHUT thresholds)
  * @tshut_hot_mask: mask to tshut_threhold.thot
  * @tshut_cold_mask: mask to tshut_threhold.thot
@@ -126,8 +128,6 @@ struct temp_sensor_registers {
 	u32	counter_mask;
 
 	u32	bgap_threshold;
-	u32	threshold_thot_mask;
-	u32	threshold_tcold_mask;
 
 	u32	tshut_threshold;
 	u32	tshut_hot_mask;
-- 
1.9.1
