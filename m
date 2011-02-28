From: Archit Taneja <archit@ti.com>
Subject: [PATCH] OMAP: DSS2: Use dss features to provide the max fck supported
Date: Mon, 28 Feb 2011 12:13:41 +0530
Message-ID: <1298875421-5933-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51256 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752520Ab1B1GlF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 01:41:05 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1S6f40q019954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 00:41:04 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The maximum supported frequency for DSS has increased from 173 to 186 Mhz on
OMAP4.

Introduce a dss feature function to get the max_fck to replace DISPC_MAX_FCK
macro.

Signed-off-by: Archit Taneja <archit@ti.com>
---
Note:
Patch can be tested on:
http://dev.omapzoom.org/?p=axelcx/kernel-display.git;a=shortlog;h=refs/heads/lo-dss2-Feb25

 drivers/video/omap2/dss/dsi.c          |    9 ++++++---
 drivers/video/omap2/dss/dss.c          |    9 ++++++---
 drivers/video/omap2/dss/dss.h          |    2 --
 drivers/video/omap2/dss/dss_features.c |   11 +++++++++++
 drivers/video/omap2/dss/dss_features.h |    1 +
 5 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 2444404..2e92888 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -38,6 +38,7 @@
 #include <plat/clock.h>
 
 #include "dss.h"
+#include "dss_features.h"
 
 /*#define VERBOSE_IRQ*/
 #define DSI_CATCH_MISSING_TE
@@ -856,10 +857,12 @@ int dsi_pll_calc_clock_div_pck(bool is_tft, unsigned long req_pck,
 	struct dispc_clock_info best_dispc;
 	int min_fck_per_pck;
 	int match = 0;
-	unsigned long dss_clk_fck2;
+	unsigned long dss_clk_fck2, max_dss_fck;
 
 	dss_clk_fck2 = dss_clk_get_rate(DSS_CLK_SYSCK);
 
+	max_dss_fck = dss_feat_get_max_dss_fck();
+
 	if (req_pck == dsi.cache_req_pck &&
 			dsi.cache_cinfo.clkin == dss_clk_fck2) {
 		DSSDBG("DSI clock info found from cache\n");
@@ -872,7 +875,7 @@ int dsi_pll_calc_clock_div_pck(bool is_tft, unsigned long req_pck,
 	min_fck_per_pck = CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK;
 
 	if (min_fck_per_pck &&
-		req_pck * min_fck_per_pck > DISPC_MAX_FCK) {
+		req_pck * min_fck_per_pck > max_dss_fck) {
 		DSSERR("Requested pixel clock not possible with the current "
 				"OMAP2_DSS_MIN_FCK_PER_PCK setting. Turning "
 				"the constraint off.\n");
@@ -925,7 +928,7 @@ retry:
 				if (cur.dsi1_pll_fclk  < req_pck)
 					break;
 
-				if (cur.dsi1_pll_fclk > DISPC_MAX_FCK)
+				if (cur.dsi1_pll_fclk > max_dss_fck)
 					continue;
 
 				if (min_fck_per_pck &&
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 5a93e66..a73dbab 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -32,6 +32,7 @@
 #include <plat/display.h>
 #include <plat/clock.h>
 #include "dss.h"
+#include "dss_features.h"
 
 #define DSS_SZ_REGS			SZ_512
 
@@ -380,7 +381,7 @@ int dss_calc_clock_div(bool is_tft, unsigned long req_pck,
 	struct dss_clock_info best_dss;
 	struct dispc_clock_info best_dispc;
 
-	unsigned long fck;
+	unsigned long fck, max_dss_fck;
 
 	u16 fck_div;
 
@@ -389,6 +390,8 @@ int dss_calc_clock_div(bool is_tft, unsigned long req_pck,
 
 	prate = dss_get_dpll4_rate();
 
+	max_dss_fck = dss_feat_get_max_dss_fck();
+
 	fck = dss_clk_get_rate(DSS_CLK_FCK);
 	if (req_pck == dss.cache_req_pck &&
 			((cpu_is_omap34xx() && prate == dss.cache_prate) ||
@@ -402,7 +405,7 @@ int dss_calc_clock_div(bool is_tft, unsigned long req_pck,
 	min_fck_per_pck = CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK;
 
 	if (min_fck_per_pck &&
-		req_pck * min_fck_per_pck > DISPC_MAX_FCK) {
+		req_pck * min_fck_per_pck > max_dss_fck) {
 		DSSERR("Requested pixel clock not possible with the current "
 				"OMAP2_DSS_MIN_FCK_PER_PCK setting. Turning "
 				"the constraint off.\n");
@@ -438,7 +441,7 @@ retry:
 			else
 				fck = prate / fck_div * 2;
 
-			if (fck > DISPC_MAX_FCK)
+			if (fck > max_dss_fck)
 				continue;
 
 			if (min_fck_per_pck &&
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 4b02e07..7fe32d1 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -97,8 +97,6 @@ extern unsigned int dss_debug;
 #define FLD_MOD(orig, val, start, end) \
 	(((orig) & ~FLD_MASK(start, end)) | FLD_VAL(val, start, end))
 
-#define DISPC_MAX_FCK 173000000
-
 enum omap_burst_size {
 	OMAP_DSS_BURST_4x32 = 0,
 	OMAP_DSS_BURST_8x32 = 1,
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index f6f319d..6a52d52 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -41,6 +41,7 @@ struct omap_dss_features {
 
 	const int num_mgrs;
 	const int num_ovls;
+	const unsigned long max_dss_fck;
 	const enum omap_display_type *supported_displays;
 	const enum omap_color_mode *supported_color_modes;
 };
@@ -160,6 +161,7 @@ static struct omap_dss_features omap2_dss_features = {
 
 	.num_mgrs = 2,
 	.num_ovls = 3,
+	.max_dss_fck = 173000000,
 	.supported_displays = omap2_dss_supported_displays,
 	.supported_color_modes = omap2_dss_supported_color_modes,
 };
@@ -177,6 +179,7 @@ static struct omap_dss_features omap3430_dss_features = {
 
 	.num_mgrs = 2,
 	.num_ovls = 3,
+	.max_dss_fck = 173000000,
 	.supported_displays = omap3_dss_supported_displays,
 	.supported_color_modes = omap3_dss_supported_color_modes,
 };
@@ -194,6 +197,7 @@ static struct omap_dss_features omap3630_dss_features = {
 
 	.num_mgrs = 2,
 	.num_ovls = 3,
+	.max_dss_fck = 173000000,
 	.supported_displays = omap3_dss_supported_displays,
 	.supported_color_modes = omap3_dss_supported_color_modes,
 };
@@ -210,6 +214,7 @@ static struct omap_dss_features omap4_dss_features = {
 
 	.num_mgrs = 3,
 	.num_ovls = 3,
+	.max_dss_fck = 186000000,
 	.supported_displays = omap4_dss_supported_displays,
 	.supported_color_modes = omap3_dss_supported_color_modes,
 };
@@ -225,6 +230,12 @@ int dss_feat_get_num_ovls(void)
 	return omap_current_dss_features->num_ovls;
 }
 
+/* Max supported DSS FCK in Hz */
+unsigned long dss_feat_get_max_dss_fck(void)
+{
+	return omap_current_dss_features->max_dss_fck;
+}
+
 enum omap_display_type dss_feat_get_supported_displays(enum omap_channel channel)
 {
 	return omap_current_dss_features->supported_displays[channel];
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 61c05c7..b983c21 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -54,6 +54,7 @@ enum dss_feat_reg_field {
 /* DSS Feature Functions */
 int dss_feat_get_num_mgrs(void);
 int dss_feat_get_num_ovls(void);
+unsigned long dss_feat_get_max_dss_fck(void);
 enum omap_display_type dss_feat_get_supported_displays(enum omap_channel channel);
 enum omap_color_mode dss_feat_get_supported_color_modes(enum omap_plane plane);
 bool dss_feat_color_mode_supported(enum omap_plane plane,
-- 
1.7.1

