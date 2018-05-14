From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 07/14] thermal: ti-soc-thermal: remove
 ->tshut_[hot,cold]_mask fields
Date: Mon, 14 May 2018 13:42:14 +0200
Message-ID: <1526298141-14045-8-git-send-email-b.zolnierkie@samsung.com>
References: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180514114334epcas1p4c1b268d8253cda369826e67b06b4c28b@epcas1p4.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-omap@vger.kernel.org

.tshut_[hot,cold]_mask fields are set to identical values for
all sensors supporting TSHUT_CONFIG feature so remove them and
use common defines instead.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/ti-soc-thermal/omap4-thermal-data.c | 2 --
 drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h   | 4 ----
 drivers/thermal/ti-soc-thermal/omap5-thermal-data.c | 6 ------
 drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h   | 4 ----
 drivers/thermal/ti-soc-thermal/ti-bandgap.c         | 8 ++++----
 drivers/thermal/ti-soc-thermal/ti-bandgap.h         | 8 ++++----
 6 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c b/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
index 9545fe3..74d05cc 100644
--- a/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
@@ -110,8 +110,6 @@
 	.bgap_threshold = OMAP4460_BGAP_THRESHOLD_OFFSET,
 
 	.tshut_threshold = OMAP4460_BGAP_TSHUT_OFFSET,
-	.tshut_hot_mask = OMAP4460_TSHUT_HOT_MASK,
-	.tshut_cold_mask = OMAP4460_TSHUT_COLD_MASK,
 
 	.bgap_status = OMAP4460_BGAP_STATUS_OFFSET,
 	.status_hot_mask = OMAP4460_HOT_FLAG_MASK,
diff --git a/drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h b/drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h
index c1da37d..5ba4c62 100644
--- a/drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h
@@ -130,10 +130,6 @@
 /* OMAP4460.BANDGAP_COUNTER bits */
 #define OMAP4460_COUNTER_MASK				(0xffffff << 0)
 
-/* OMAP4460.TSHUT_THRESHOLD bits */
-#define OMAP4460_TSHUT_HOT_MASK				(0x3ff << 16)
-#define OMAP4460_TSHUT_COLD_MASK			(0x3ff << 0)
-
 /* OMAP4460.BANDGAP_STATUS bits */
 #define OMAP4460_HOT_FLAG_MASK				BIT(1)
 #define OMAP4460_COLD_FLAG_MASK				BIT(0)
diff --git a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
index 51a6ab4..a7ca3b6 100644
--- a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
@@ -44,8 +44,6 @@
 	.bgap_threshold = OMAP5430_BGAP_THRESHOLD_MPU_OFFSET,
 
 	.tshut_threshold = OMAP5430_BGAP_TSHUT_MPU_OFFSET,
-	.tshut_hot_mask = OMAP5430_TSHUT_HOT_MASK,
-	.tshut_cold_mask = OMAP5430_TSHUT_COLD_MASK,
 
 	.bgap_status = OMAP5430_BGAP_STATUS_OFFSET,
 	.status_hot_mask = OMAP5430_HOT_MPU_FLAG_MASK,
@@ -75,8 +73,6 @@
 	.bgap_threshold = OMAP5430_BGAP_THRESHOLD_GPU_OFFSET,
 
 	.tshut_threshold = OMAP5430_BGAP_TSHUT_GPU_OFFSET,
-	.tshut_hot_mask = OMAP5430_TSHUT_HOT_MASK,
-	.tshut_cold_mask = OMAP5430_TSHUT_COLD_MASK,
 
 	.bgap_status = OMAP5430_BGAP_STATUS_OFFSET,
 	.status_hot_mask = OMAP5430_HOT_GPU_FLAG_MASK,
@@ -107,8 +103,6 @@
 	.bgap_threshold = OMAP5430_BGAP_THRESHOLD_CORE_OFFSET,
 
 	.tshut_threshold = OMAP5430_BGAP_TSHUT_CORE_OFFSET,
-	.tshut_hot_mask = OMAP5430_TSHUT_HOT_MASK,
-	.tshut_cold_mask = OMAP5430_TSHUT_COLD_MASK,
 
 	.bgap_status = OMAP5430_BGAP_STATUS_OFFSET,
 	.status_hot_mask = OMAP5430_HOT_CORE_FLAG_MASK,
diff --git a/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h b/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
index ec536d8..e931ae0 100644
--- a/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
@@ -93,10 +93,6 @@
 #define OMAP5430_MASK_HOT_MPU_MASK			BIT(1)
 #define OMAP5430_MASK_COLD_MPU_MASK			BIT(0)
 
-/* OMAP5430.TSHUT_THRESHOLD */
-#define OMAP5430_TSHUT_HOT_MASK				(0x3ff << 16)
-#define OMAP5430_TSHUT_COLD_MASK			(0x3ff << 0)
-
 /* OMAP5430.BANDGAP_STATUS */
 #define OMAP5430_HOT_CORE_FLAG_MASK			BIT(5)
 #define OMAP5430_COLD_CORE_FLAG_MASK			BIT(4)
diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index cb9a27e..4d45160 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -1003,10 +1003,10 @@ int ti_bandgap_probe(struct platform_device *pdev)
 
 		if (TI_BANDGAP_HAS(bgp, TSHUT_CONFIG)) {
 			/* Set initial Tshut thresholds */
-			RMW_BITS(bgp, i, tshut_threshold,
-				 tshut_hot_mask, ts_data->tshut_hot);
-			RMW_BITS(bgp, i, tshut_threshold,
-				 tshut_cold_mask, ts_data->tshut_cold);
+			RMW_BITS2(bgp, i, tshut_threshold,
+				 OMAP_TSHUT_HOT_MASK, ts_data->tshut_hot);
+			RMW_BITS2(bgp, i, tshut_threshold,
+				 OMAP_TSHUT_COLD_MASK, ts_data->tshut_cold);
 		}
 	}
 
diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.h b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
index 2e5b146..4d5b54a 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
@@ -72,6 +72,10 @@
 #define OMAP_T_HOT_MASK		(0x3ff << 16)
 #define OMAP_T_COLD_MASK	(0x3ff << 0)
 
+/* TSHUT_THRESHOLD */
+#define OMAP_TSHUT_HOT_MASK	(0x3ff << 16)
+#define OMAP_TSHUT_COLD_MASK	(0x3ff << 0)
+
 /**
  * struct temp_sensor_registers - descriptor to access registers and bitfields
  * @temp_sensor_ctrl: TEMP_SENSOR_CTRL register offset
@@ -90,8 +94,6 @@
  * @counter_mask: mask to bandgap_counter.counter
  * @bgap_threshold: BANDGAP_THRESHOLD register offset (TALERT thresholds)
  * @tshut_threshold: TSHUT_THRESHOLD register offset (TSHUT thresholds)
- * @tshut_hot_mask: mask to tshut_threhold.thot
- * @tshut_cold_mask: mask to tshut_threhold.thot
  * @bgap_status: BANDGAP_STATUS register offset
  * @status_hot_mask: mask to bandgap_status.hot
  * @status_cold_mask: mask to bandgap_status.cold
@@ -130,8 +132,6 @@ struct temp_sensor_registers {
 	u32	bgap_threshold;
 
 	u32	tshut_threshold;
-	u32	tshut_hot_mask;
-	u32	tshut_cold_mask;
 
 	u32	bgap_status;
 	u32	status_hot_mask;
-- 
1.9.1
