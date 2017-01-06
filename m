From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 1/2] thermal: arm: dra752: Remove TSHUT configuration
Date: Fri, 6 Jan 2017 11:31:42 +0530
Message-ID: <1483682503-27803-2-git-send-email-j-keerthy@ti.com>
References: <1483682503-27803-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1483682503-27803-1-git-send-email-j-keerthy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: rui.zhang@intel.com, linux-kernel@vger.kernel.org, j-keerthy@ti.com, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, rk@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

Technical Reference Manual [1] mandates that software should
not be configuring the thermal shutdown thresholds. Hence
removing TSHUT_CONFIG.

[1] http://www.ti.com/lit/ug/sprui30b/sprui30b.pdf

Signed-off-by: Keerthy <j-keerthy@ti.com>
Reported-by: Ravikumar Kattekola <rk@ti.com>
---
 drivers/thermal/ti-soc-thermal/dra752-thermal-data.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
index 58b5c66..0a3f88d 100644
--- a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
@@ -416,8 +416,7 @@
 
 /* DRA752 data */
 const struct ti_bandgap_data dra752_data = {
-	.features = TI_BANDGAP_FEATURE_TSHUT_CONFIG |
-			TI_BANDGAP_FEATURE_FREEZE_BIT |
+	.features = TI_BANDGAP_FEATURE_FREEZE_BIT |
 			TI_BANDGAP_FEATURE_TALERT |
 			TI_BANDGAP_FEATURE_COUNTER_DELAY |
 			TI_BANDGAP_FEATURE_HISTORY_BUFFER |
-- 
1.9.1

