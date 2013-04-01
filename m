From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 12/14] staging: ti-soc-thermal: Enable HISTORY_BUFFER Feature for OMAP5
Date: Mon, 1 Apr 2013 12:04:44 -0400
Message-ID: <1364832286-17304-13-git-send-email-eduardo.valentin@ti.com>
References: <1364832286-17304-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57276 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758964Ab3DAQJl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Apr 2013 12:09:41 -0400
In-Reply-To: <1364832286-17304-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, J Keerthy <j-keerthy@ti.com>, Eduardo Valentin <eduardo.valentin@ti.com>

From: J Keerthy <j-keerthy@ti.com>

This patch enables the HISTORY_BUFFER eature for OMAP5.

Signed-off-by: J Keerthy <j-keerthy@ti.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 .../staging/ti-soc-thermal/omap5-thermal-data.c    |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/ti-soc-thermal/omap5-thermal-data.c b/drivers/staging/ti-soc-thermal/omap5-thermal-data.c
index 460a3b2..f170211 100644
--- a/drivers/staging/ti-soc-thermal/omap5-thermal-data.c
+++ b/drivers/staging/ti-soc-thermal/omap5-thermal-data.c
@@ -319,7 +319,8 @@ const struct ti_bandgap_data omap5430_data = {
 	.features = TI_BANDGAP_FEATURE_TSHUT_CONFIG |
 			TI_BANDGAP_FEATURE_FREEZE_BIT |
 			TI_BANDGAP_FEATURE_TALERT |
-			TI_BANDGAP_FEATURE_COUNTER_DELAY,
+			TI_BANDGAP_FEATURE_COUNTER_DELAY |
+			TI_BANDGAP_FEATURE_HISTORY_BUFFER,
 	.fclock_name = "l3instr_ts_gclk_div",
 	.div_ck_name = "l3instr_ts_gclk_div",
 	.conv_table = omap5430_adc_to_temp,
-- 
1.7.7.1.488.ge8e1c

