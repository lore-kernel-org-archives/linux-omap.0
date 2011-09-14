From: Archit Taneja <archit@ti.com>
Subject: [PATCH 10/10] OMAP2PLUS: DSS2: FEATURES: Create a range param to get max downscaling
Date: Wed, 14 Sep 2011 17:55:14 +0530
Message-ID: <1316003114-24291-7-git-send-email-archit@ti.com>
References: <1316003114-24291-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38890 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932456Ab1INMYh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Sep 2011 08:24:37 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p8ECOb2A024141
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 07:24:37 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id p8ECObjs015233
	for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 07:24:37 -0500 (CDT)
Received: from DLEE74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p8ECObiw001549
	for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 07:24:37 -0500 (CDT)
In-Reply-To: <1316003114-24291-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, hvaibhav@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Create a dss_range_param member called FEAT_PARAM_DOWNSCALE to get the maximum
downscaling possible on the current platform. Use this in
dispc_ovl_calc_scaling().

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c        |    2 +-
 drivers/video/omap2/dss/dss_features.c |    3 +++
 drivers/video/omap2/dss/dss_features.h |    1 +
 3 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 9f36db7..d447359 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1716,7 +1716,7 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 		enum omap_color_mode color_mode, bool *five_taps)
 {
 	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
-	const int maxdownscale = cpu_is_omap34xx() ? 4 : 2;
+	const int maxdownscale = dss_feat_get_param_max(FEAT_PARAM_DOWNSCALE);
 	unsigned long fclk = 0;
 
 	if ((ovl->caps & OMAP_DSS_OVL_CAP_SCALE) == 0) {
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 0299338..e5e94f4 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -303,6 +303,7 @@ static const struct dss_param_range omap2_dss_param_range[] = {
 	[FEAT_PARAM_DSIPLL_REGM_DSI]		= { 0, 0 },
 	[FEAT_PARAM_DSIPLL_FINT]		= { 0, 0 },
 	[FEAT_PARAM_DSIPLL_LPDIV]		= { 0, 0 },
+	[FEAT_PARAM_DOWNSCALE]			= { 1, 2 },
 };
 
 static const struct dss_param_range omap3_dss_param_range[] = {
@@ -314,6 +315,7 @@ static const struct dss_param_range omap3_dss_param_range[] = {
 	[FEAT_PARAM_DSIPLL_REGM_DSI]		= { 0, (1 << 4) - 1 },
 	[FEAT_PARAM_DSIPLL_FINT]		= { 750000, 2100000 },
 	[FEAT_PARAM_DSIPLL_LPDIV]		= { 1, (1 << 13) - 1},
+	[FEAT_PARAM_DOWNSCALE]			= { 1, 4 },
 };
 
 static const struct dss_param_range omap4_dss_param_range[] = {
@@ -325,6 +327,7 @@ static const struct dss_param_range omap4_dss_param_range[] = {
 	[FEAT_PARAM_DSIPLL_REGM_DSI]		= { 0, (1 << 5) - 1 },
 	[FEAT_PARAM_DSIPLL_FINT]		= { 500000, 2500000 },
 	[FEAT_PARAM_DSIPLL_LPDIV]		= { 0, (1 << 13) - 1 },
+	[FEAT_PARAM_DOWNSCALE]			= { 1, 4 },
 };
 
 /* OMAP2 DSS Features */
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 879f3fb..6a6c05d 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -85,6 +85,7 @@ enum dss_range_param {
 	FEAT_PARAM_DSIPLL_REGM_DSI,
 	FEAT_PARAM_DSIPLL_FINT,
 	FEAT_PARAM_DSIPLL_LPDIV,
+	FEAT_PARAM_DOWNSCALE,
 };
 
 /* DSS Feature Functions */
-- 
1.7.1

