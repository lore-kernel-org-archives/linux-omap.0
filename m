From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 1/5] OMAP4: DSS2: Create a DSS features structure for OMAP4430 ES1.0
Date: Thu,  5 May 2011 02:01:30 -0500
Message-ID: <1304578894-23967-2-git-send-email-ricardo.neri@ti.com>
References: <1304578894-23967-1-git-send-email-ricardo.neri@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40321 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799Ab1EEHB0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 May 2011 03:01:26 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4571Q6C008161
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 5 May 2011 02:01:26 -0500
In-Reply-To: <1304578894-23967-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@ti.com, mythripk@ti.com
Cc: Ricardo Neri <ricardo.neri@ti.com>

Create a separate DSS features structure for OMAP4430 ES1.0. This
structure is used to expose features only present in such
silicon version. Specifically, this is required to handle how
the HDMI IP calculates the CTS parameter for audio clock
regeneration packets. OMAP4430 ES1.0 is the only one that supports
computation of the CTS parameter by the HDMI IP (hardware mode).
The rest of the revisions require the HDMI driver to perform the
computation.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/dss_features.c |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index aa16222..6c57af4 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -282,6 +282,25 @@ static struct omap_dss_features omap3630_dss_features = {
 };
 
 /* OMAP4 DSS Features */
+/* For OMAP4430 ES 1.0 revision */
+static struct omap_dss_features omap4430_es1_0_dss_features = {
+	.reg_fields = omap4_dss_reg_fields,
+	.num_reg_fields = ARRAY_SIZE(omap4_dss_reg_fields),
+
+	.has_feature	=
+		FEAT_GLOBAL_ALPHA | FEAT_PRE_MULT_ALPHA |
+		FEAT_MGR_LCD2 | FEAT_GLOBAL_ALPHA_VID1 |
+		FEAT_CORE_CLK_DIV | FEAT_LCD_CLK_SRC,
+
+	.num_mgrs = 3,
+	.num_ovls = 3,
+	.supported_displays = omap4_dss_supported_displays,
+	.supported_color_modes = omap3_dss_supported_color_modes,
+	.clksrc_names = omap4_dss_clk_source_names,
+	.dss_params = omap4_dss_param_range,
+};
+
+/* For all the other OMAP4 versions */
 static struct omap_dss_features omap4_dss_features = {
 	.reg_fields = omap4_dss_reg_fields,
 	.num_reg_fields = ARRAY_SIZE(omap4_dss_reg_fields),
@@ -299,6 +318,7 @@ static struct omap_dss_features omap4_dss_features = {
 	.dss_params = omap4_dss_param_range,
 };
 
+
 /* Functions returning values related to a DSS feature */
 int dss_feat_get_num_mgrs(void)
 {
@@ -365,6 +385,10 @@ void dss_features_init(void)
 		omap_current_dss_features = &omap3630_dss_features;
 	else if (cpu_is_omap34xx())
 		omap_current_dss_features = &omap3430_dss_features;
-	else
+	else if (omap_rev() == OMAP4430_REV_ES1_0)
+		omap_current_dss_features = &omap4430_es1_0_dss_features;
+	else if (cpu_is_omap44xx())
 		omap_current_dss_features = &omap4_dss_features;
+	else
+		DSSWARN("Unsupported OMAP version");
 }
-- 
1.7.1

