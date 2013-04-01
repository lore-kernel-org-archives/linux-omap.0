From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 07/14] staging: ti-soc-thermal: Initialise counter_delay field for OMAP5 sensors
Date: Mon, 1 Apr 2013 12:04:39 -0400
Message-ID: <1364832286-17304-8-git-send-email-eduardo.valentin@ti.com>
References: <1364832286-17304-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59240 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758754Ab3DAQHu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Apr 2013 12:07:50 -0400
In-Reply-To: <1364832286-17304-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, J Keerthy <j-keerthy@ti.com>, Eduardo Valentin <eduardo.valentin@ti.com>

From: J Keerthy <j-keerthy@ti.com>

Initialize all 3 temperature sensors of OMAP5 bandgap with the counter delay
mask.

Signed-off-by: J Keerthy <j-keerthy@ti.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 .../staging/ti-soc-thermal/omap5-thermal-data.c    |    3 +++
 drivers/staging/ti-soc-thermal/omap5xxx-bandgap.h  |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/ti-soc-thermal/omap5-thermal-data.c b/drivers/staging/ti-soc-thermal/omap5-thermal-data.c
index aa16f92..a5fa113 100644
--- a/drivers/staging/ti-soc-thermal/omap5-thermal-data.c
+++ b/drivers/staging/ti-soc-thermal/omap5-thermal-data.c
@@ -39,6 +39,7 @@ omap5430_mpu_temp_sensor_registers = {
 	.mask_hot_mask = OMAP5430_MASK_HOT_MPU_MASK,
 	.mask_cold_mask = OMAP5430_MASK_COLD_MPU_MASK,
 	.mask_sidlemode_mask = OMAP5430_MASK_SIDLEMODE_MASK,
+	.mask_counter_delay_mask = OMAP5430_MASK_COUNTER_DELAY_MASK,
 	.mask_freeze_mask = OMAP5430_MASK_FREEZE_MPU_MASK,
 	.mask_clear_mask = OMAP5430_MASK_CLEAR_MPU_MASK,
 	.mask_clear_accum_mask = OMAP5430_MASK_CLEAR_ACCUM_MPU_MASK,
@@ -84,6 +85,7 @@ omap5430_gpu_temp_sensor_registers = {
 	.mask_hot_mask = OMAP5430_MASK_HOT_GPU_MASK,
 	.mask_cold_mask = OMAP5430_MASK_COLD_GPU_MASK,
 	.mask_sidlemode_mask = OMAP5430_MASK_SIDLEMODE_MASK,
+	.mask_counter_delay_mask = OMAP5430_MASK_COUNTER_DELAY_MASK,
 	.mask_freeze_mask = OMAP5430_MASK_FREEZE_GPU_MASK,
 	.mask_clear_mask = OMAP5430_MASK_CLEAR_GPU_MASK,
 	.mask_clear_accum_mask = OMAP5430_MASK_CLEAR_ACCUM_GPU_MASK,
@@ -129,6 +131,7 @@ omap5430_core_temp_sensor_registers = {
 	.mask_hot_mask = OMAP5430_MASK_HOT_CORE_MASK,
 	.mask_cold_mask = OMAP5430_MASK_COLD_CORE_MASK,
 	.mask_sidlemode_mask = OMAP5430_MASK_SIDLEMODE_MASK,
+	.mask_counter_delay_mask = OMAP5430_MASK_COUNTER_DELAY_MASK,
 	.mask_freeze_mask = OMAP5430_MASK_FREEZE_CORE_MASK,
 	.mask_clear_mask = OMAP5430_MASK_CLEAR_CORE_MASK,
 	.mask_clear_accum_mask = OMAP5430_MASK_CLEAR_ACCUM_CORE_MASK,
diff --git a/drivers/staging/ti-soc-thermal/omap5xxx-bandgap.h b/drivers/staging/ti-soc-thermal/omap5xxx-bandgap.h
index 8824db4..400b55d 100644
--- a/drivers/staging/ti-soc-thermal/omap5xxx-bandgap.h
+++ b/drivers/staging/ti-soc-thermal/omap5xxx-bandgap.h
@@ -95,6 +95,7 @@
 
 /* OMAP5430.BANDGAP_CTRL */
 #define OMAP5430_MASK_SIDLEMODE_MASK			(0x3 << 30)
+#define OMAP5430_MASK_COUNTER_DELAY_MASK		(0x7 << 27)
 #define OMAP5430_MASK_FREEZE_CORE_MASK			BIT(23)
 #define OMAP5430_MASK_FREEZE_GPU_MASK			BIT(22)
 #define OMAP5430_MASK_FREEZE_MPU_MASK			BIT(21)
-- 
1.7.7.1.488.ge8e1c

