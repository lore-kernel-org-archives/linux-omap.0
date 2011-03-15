From: Archit Taneja <archit@ti.com>
Subject: [PATCH] OMAP: DSS2: FEATURES: Functions to return min and max values of parameters
Date: Tue, 15 Mar 2011 09:58:22 +0530
Message-ID: <1300163303-31662-2-git-send-email-archit@ti.com>
References: <1300163303-31662-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51219 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736Ab1COEYi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Mar 2011 00:24:38 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2F4OcG9003643
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 14 Mar 2011 23:24:38 -0500
In-Reply-To: <1300163303-31662-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Create 2 functions dss_feat_get_param_min() and dss_feat_get_param_max() which
return the minimum and maximum value of a parameter. Introduce a enum in
dss_features called dss_range_param which contains parameters whose ranges we
are interested in.

Replace this with dss_feat_get_max_dss_fck() which is specific to the parameter
DSS_FCK.

Signed-off-by: Archit Taneja <archit@ti.com>
---
Note: Applies over:

http://gitorious.org/linux-omap-dss2/linux/commits/master

and the patch submitted on linux-omap:
OMAP2PLUS: DSS2: FEATURES: Fix usage of dss_reg_field and dss_clk_source_name

 drivers/video/omap2/dss/dsi.c          |    2 +-
 drivers/video/omap2/dss/dss.c          |    2 +-
 drivers/video/omap2/dss/dss_features.c |   36 ++++++++++++++++++++++++-------
 drivers/video/omap2/dss/dss_features.h |    7 +++++-
 4 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index be7694f..6e7f468 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -864,7 +864,7 @@ int dsi_pll_calc_clock_div_pck(bool is_tft, unsigned long req_pck,
 
 	dss_sys_clk = dss_clk_get_rate(DSS_CLK_SYSCK);
 
-	max_dss_fck = dss_feat_get_max_dss_fck();
+	max_dss_fck = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
 
 	if (req_pck == dsi.cache_req_pck &&
 			dsi.cache_cinfo.clkin == dss_sys_clk) {
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 06ad312..562d8d2 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -457,7 +457,7 @@ int dss_calc_clock_div(bool is_tft, unsigned long req_pck,
 
 	prate = dss_get_dpll4_rate();
 
-	max_dss_fck = dss_feat_get_max_dss_fck();
+	max_dss_fck = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
 
 	fck = dss_clk_get_rate(DSS_CLK_FCK);
 	if (req_pck == dss.cache_req_pck &&
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 8de3344..4c8b32a 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -33,6 +33,10 @@ struct dss_reg_field {
 	u8 start, end;
 };
 
+struct dss_param_range {
+	int min, max;
+};
+
 struct omap_dss_features {
 	const struct dss_reg_field *reg_fields;
 	const int num_reg_fields;
@@ -41,10 +45,10 @@ struct omap_dss_features {
 
 	const int num_mgrs;
 	const int num_ovls;
-	const unsigned long max_dss_fck;
 	const enum omap_display_type *supported_displays;
 	const enum omap_color_mode *supported_color_modes;
 	const char * const *clksrc_names;
+	const struct dss_param_range *dss_params;
 };
 
 /* This struct is assigned to one of the below during initialization */
@@ -179,6 +183,18 @@ static const char * const omap4_dss_clk_source_names[] = {
 	[DSS_CLK_SRC_FCK]			= "DSS_FCLK",
 };
 
+static const struct dss_param_range omap2_dss_param_range[] = {
+	[FEAT_PARAM_DSS_FCK]	= { 0, 173000000 },
+};
+
+static const struct dss_param_range omap3_dss_param_range[] = {
+	[FEAT_PARAM_DSS_FCK]	= { 0, 173000000 },
+};
+
+static const struct dss_param_range omap4_dss_param_range[] = {
+	[FEAT_PARAM_DSS_FCK]	= { 0, 186000000 },
+};
+
 /* OMAP2 DSS Features */
 static struct omap_dss_features omap2_dss_features = {
 	.reg_fields = omap2_dss_reg_fields,
@@ -191,10 +207,10 @@ static struct omap_dss_features omap2_dss_features = {
 
 	.num_mgrs = 2,
 	.num_ovls = 3,
-	.max_dss_fck = 173000000,
 	.supported_displays = omap2_dss_supported_displays,
 	.supported_color_modes = omap2_dss_supported_color_modes,
 	.clksrc_names = omap2_dss_clk_source_names,
+	.dss_params = omap2_dss_param_range,
 };
 
 /* OMAP3 DSS Features */
@@ -210,10 +226,10 @@ static struct omap_dss_features omap3430_dss_features = {
 
 	.num_mgrs = 2,
 	.num_ovls = 3,
-	.max_dss_fck = 173000000,
 	.supported_displays = omap3430_dss_supported_displays,
 	.supported_color_modes = omap3_dss_supported_color_modes,
 	.clksrc_names = omap3_dss_clk_source_names,
+	.dss_params = omap3_dss_param_range,
 };
 
 static struct omap_dss_features omap3630_dss_features = {
@@ -229,10 +245,10 @@ static struct omap_dss_features omap3630_dss_features = {
 
 	.num_mgrs = 2,
 	.num_ovls = 3,
-	.max_dss_fck = 173000000,
 	.supported_displays = omap3630_dss_supported_displays,
 	.supported_color_modes = omap3_dss_supported_color_modes,
 	.clksrc_names = omap3_dss_clk_source_names,
+	.dss_params = omap3_dss_param_range,
 };
 
 /* OMAP4 DSS Features */
@@ -247,10 +263,10 @@ static struct omap_dss_features omap4_dss_features = {
 
 	.num_mgrs = 3,
 	.num_ovls = 3,
-	.max_dss_fck = 186000000,
 	.supported_displays = omap4_dss_supported_displays,
 	.supported_color_modes = omap3_dss_supported_color_modes,
 	.clksrc_names = omap4_dss_clk_source_names,
+	.dss_params = omap4_dss_param_range,
 };
 
 /* Functions returning values related to a DSS feature */
@@ -264,10 +280,14 @@ int dss_feat_get_num_ovls(void)
 	return omap_current_dss_features->num_ovls;
 }
 
-/* Max supported DSS FCK in Hz */
-unsigned long dss_feat_get_max_dss_fck(void)
+unsigned long dss_feat_get_param_min(enum dss_range_param param)
+{
+	return omap_current_dss_features->dss_params[param].min;
+}
+
+unsigned long dss_feat_get_param_max(enum dss_range_param param)
 {
-	return omap_current_dss_features->max_dss_fck;
+	return omap_current_dss_features->dss_params[param].max;
 }
 
 enum omap_display_type dss_feat_get_supported_displays(enum omap_channel channel)
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 729b5f1..da63bbf 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -54,10 +54,15 @@ enum dss_feat_reg_field {
 	FEAT_REG_DISPC_CLK_SWITCH,
 };
 
+enum dss_range_param {
+	FEAT_PARAM_DSS_FCK,
+};
+
 /* DSS Feature Functions */
 int dss_feat_get_num_mgrs(void);
 int dss_feat_get_num_ovls(void);
-unsigned long dss_feat_get_max_dss_fck(void);
+unsigned long dss_feat_get_param_min(enum dss_range_param param);
+unsigned long dss_feat_get_param_max(enum dss_range_param param);
 enum omap_display_type dss_feat_get_supported_displays(enum omap_channel channel);
 enum omap_color_mode dss_feat_get_supported_color_modes(enum omap_plane plane);
 bool dss_feat_color_mode_supported(enum omap_plane plane,
-- 
1.7.1

