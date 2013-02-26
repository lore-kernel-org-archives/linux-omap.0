From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 08/15] staging: omap-thermal: update feature bitfield for OMAP54xx
Date: Tue, 26 Feb 2013 18:53:31 -0400
Message-ID: <1361919218-9788-9-git-send-email-eduardo.valentin@ti.com>
References: <1361919218-9788-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1361919218-9788-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch removes from OMAP54xx the features:
. CLK_CTRL
. COUNTER
. MODE_CONFIG

Because these features are not present in OMAP54xx ES2.0

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/omap-thermal/omap5-thermal.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/omap-thermal/omap5-thermal.c b/drivers/staging/omap-thermal/omap5-thermal.c
index c8c3e6e..6306360 100644
--- a/drivers/staging/omap-thermal/omap5-thermal.c
+++ b/drivers/staging/omap-thermal/omap5-thermal.c
@@ -319,10 +319,7 @@ omap5430_adc_to_temp[
 /* TODO : Need to update the slope/constant for ES2.0 silicon */
 const struct omap_bandgap_data omap5430_data = {
 	.features = OMAP_BANDGAP_FEATURE_TSHUT_CONFIG |
-			OMAP_BANDGAP_FEATURE_TALERT |
-			OMAP_BANDGAP_FEATURE_MODE_CONFIG |
-			OMAP_BANDGAP_FEATURE_COUNTER |
-			OMAP_BANDGAP_FEATURE_CLK_CTRL,
+			OMAP_BANDGAP_FEATURE_TALERT,
 	.fclock_name = "l3instr_ts_gclk_div",
 	.div_ck_name = "l3instr_ts_gclk_div",
 	.conv_table = omap5430_adc_to_temp,
-- 
1.7.7.1.488.ge8e1c
