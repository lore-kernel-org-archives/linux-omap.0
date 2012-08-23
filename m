From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 5/8] OMAPDSS: Add DSI fclk maximum to dss_features
Date: Thu, 23 Aug 2012 16:45:11 +0300
Message-ID: <1345729514-2441-6-git-send-email-tomi.valkeinen@ti.com>
References: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:53711 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933657Ab2HWNpm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Aug 2012 09:45:42 -0400
Received: by lahl5 with SMTP id l5so371417lah.15
        for <linux-omap@vger.kernel.org>; Thu, 23 Aug 2012 06:45:39 -0700 (PDT)
In-Reply-To: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add max value of DSI functional clock to dss_features, so that DSI
driver can use it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss_features.c |    2 ++
 drivers/video/omap2/dss/dss_features.h |    1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 2fe39d6..c26fc1f 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -326,6 +326,7 @@ static const struct dss_param_range omap3_dss_param_range[] = {
 	[FEAT_PARAM_DSIPLL_REGM_DSI]		= { 0, (1 << 4) - 1 },
 	[FEAT_PARAM_DSIPLL_FINT]		= { 750000, 2100000 },
 	[FEAT_PARAM_DSIPLL_LPDIV]		= { 1, (1 << 13) - 1},
+	[FEAT_PARAM_DSI_FCK]			= { 0, 173000000 },
 	[FEAT_PARAM_DOWNSCALE]			= { 1, 4 },
 	[FEAT_PARAM_LINEWIDTH]			= { 1, 1024 },
 	[FEAT_PARAM_MGR_WIDTH]			= { 1, 2048 },
@@ -341,6 +342,7 @@ static const struct dss_param_range omap4_dss_param_range[] = {
 	[FEAT_PARAM_DSIPLL_REGM_DSI]		= { 0, (1 << 5) - 1 },
 	[FEAT_PARAM_DSIPLL_FINT]		= { 500000, 2500000 },
 	[FEAT_PARAM_DSIPLL_LPDIV]		= { 0, (1 << 13) - 1 },
+	[FEAT_PARAM_DSI_FCK]			= { 0, 170000000 },
 	[FEAT_PARAM_DOWNSCALE]			= { 1, 4 },
 	[FEAT_PARAM_LINEWIDTH]			= { 1, 2048 },
 	[FEAT_PARAM_MGR_WIDTH]			= { 1, 2048 },
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 26d43a4..b81d603 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -92,6 +92,7 @@ enum dss_range_param {
 	FEAT_PARAM_DSIPLL_REGM_DSI,
 	FEAT_PARAM_DSIPLL_FINT,
 	FEAT_PARAM_DSIPLL_LPDIV,
+	FEAT_PARAM_DSI_FCK,
 	FEAT_PARAM_DOWNSCALE,
 	FEAT_PARAM_LINEWIDTH,
 	FEAT_PARAM_MGR_WIDTH,
-- 
1.7.9.5

