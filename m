From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 08/14] staging: ti-soc-thermal: Introduce HAS_COUNTER_DELAY feature for bandgap
Date: Mon, 1 Apr 2013 12:04:40 -0400
Message-ID: <1364832286-17304-9-git-send-email-eduardo.valentin@ti.com>
References: <1364832286-17304-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1364832286-17304-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, J Keerthy <j-keerthy@ti.com>, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

From: J Keerthy <j-keerthy@ti.com>

Introduce HAS_COUNTER_DELAY feature for bandgap.

Signed-off-by: J Keerthy <j-keerthy@ti.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/ti-soc-thermal/ti-bandgap.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/ti-soc-thermal/ti-bandgap.h b/drivers/staging/ti-soc-thermal/ti-bandgap.h
index 8f9bdb9..8ee4857 100644
--- a/drivers/staging/ti-soc-thermal/ti-bandgap.h
+++ b/drivers/staging/ti-soc-thermal/ti-bandgap.h
@@ -312,6 +312,9 @@ struct ti_temp_sensor {
  * TI_BANDGAP_FEATURE_FREEZE_BIT - used when the bandgap device features
  *      a history buffer that its update can be freezed/unfreezed.
  *
+ * TI_BANDGAP_FEATURE_COUNTER_DELAY - used when the bandgap device features
+ *	a delay programming based on distinct values.
+ *
  * TI_BANDGAP_HAS(b, f) - macro to check if a bandgap device is capable of a
  *      specific feature (above) or not. Return non-zero, if yes.
  */
@@ -323,6 +326,7 @@ struct ti_temp_sensor {
 #define TI_BANDGAP_FEATURE_POWER_SWITCH		BIT(5)
 #define TI_BANDGAP_FEATURE_CLK_CTRL		BIT(6)
 #define TI_BANDGAP_FEATURE_FREEZE_BIT		BIT(7)
+#define TI_BANDGAP_FEATURE_COUNTER_DELAY	BIT(8)
 #define TI_BANDGAP_HAS(b, f)			\
 			((b)->conf->features & TI_BANDGAP_FEATURE_ ## f)
 
-- 
1.7.7.1.488.ge8e1c

