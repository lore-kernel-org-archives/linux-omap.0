From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 5/8] staging: ti-soc-thermal: update OMAP5 extrapolation rules
Date: Mon, 8 Apr 2013 08:19:11 -0400
Message-ID: <1365423555-2669-6-git-send-email-eduardo.valentin@ti.com>
References: <1365423555-2669-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37044 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935569Ab3DHMVt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Apr 2013 08:21:49 -0400
In-Reply-To: <1365423555-2669-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>

Update the constants to the correct hotspot extrapolation
equation constants. OMAP4 constants are revisited and correct.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 .../staging/ti-soc-thermal/omap5-thermal-data.c    |    1 -
 drivers/staging/ti-soc-thermal/ti-thermal.h        |   16 ++++++++--------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/ti-soc-thermal/omap5-thermal-data.c b/drivers/staging/ti-soc-thermal/omap5-thermal-data.c
index f170211..eff0c80 100644
--- a/drivers/staging/ti-soc-thermal/omap5-thermal-data.c
+++ b/drivers/staging/ti-soc-thermal/omap5-thermal-data.c
@@ -314,7 +314,6 @@ omap5430_adc_to_temp[
 };
 
 /* OMAP54xx ES2.0 data */
-/* TODO : Need to update the slope/constant for ES2.0 silicon */
 const struct ti_bandgap_data omap5430_data = {
 	.features = TI_BANDGAP_FEATURE_TSHUT_CONFIG |
 			TI_BANDGAP_FEATURE_FREEZE_BIT |
diff --git a/drivers/staging/ti-soc-thermal/ti-thermal.h b/drivers/staging/ti-soc-thermal/ti-thermal.h
index 47cc902..5055777 100644
--- a/drivers/staging/ti-soc-thermal/ti-thermal.h
+++ b/drivers/staging/ti-soc-thermal/ti-thermal.h
@@ -33,10 +33,10 @@
 #define OMAP_GRADIENT_SLOPE_4470				308
 #define OMAP_GRADIENT_CONST_4470				-7896
 
-#define OMAP_GRADIENT_SLOPE_5430_CPU				196
-#define OMAP_GRADIENT_CONST_5430_CPU				-6822
-#define OMAP_GRADIENT_SLOPE_5430_GPU				64
-#define OMAP_GRADIENT_CONST_5430_GPU				978
+#define OMAP_GRADIENT_SLOPE_5430_CPU				65
+#define OMAP_GRADIENT_CONST_5430_CPU				-1791
+#define OMAP_GRADIENT_SLOPE_5430_GPU				117
+#define OMAP_GRADIENT_CONST_5430_GPU				-2992
 
 /* PCB sensor calculation constants */
 #define OMAP_GRADIENT_SLOPE_W_PCB_4430				0
@@ -46,10 +46,10 @@
 #define OMAP_GRADIENT_SLOPE_W_PCB_4470				1063
 #define OMAP_GRADIENT_CONST_W_PCB_4470				-477
 
-#define OMAP_GRADIENT_SLOPE_W_PCB_5430_CPU			469
-#define OMAP_GRADIENT_CONST_W_PCB_5430_CPU			-1272
-#define OMAP_GRADIENT_SLOPE_W_PCB_5430_GPU			378
-#define OMAP_GRADIENT_CONST_W_PCB_5430_GPU			154
+#define OMAP_GRADIENT_SLOPE_W_PCB_5430_CPU			100
+#define OMAP_GRADIENT_CONST_W_PCB_5430_CPU			484
+#define OMAP_GRADIENT_SLOPE_W_PCB_5430_GPU			464
+#define OMAP_GRADIENT_CONST_W_PCB_5430_GPU			-5102
 
 /* trip points of interest in milicelsius (at hotspot level) */
 #define OMAP_TRIP_COLD						100000
-- 
1.7.7.1.488.ge8e1c

