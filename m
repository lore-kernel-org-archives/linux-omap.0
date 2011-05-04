From: Archit Taneja <archit@ti.com>
Subject: [PATCH 3/9] OMAP: DSS2: Remove omap_dss_device argument from dsi_pll_init()
Date: Wed,  4 May 2011 13:08:18 +0530
Message-ID: <1304494704-7285-4-git-send-email-archit@ti.com>
References: <1304494704-7285-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51265 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374Ab1EDHdm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 May 2011 03:33:42 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p447Xg69027867
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 4 May 2011 02:33:42 -0500
In-Reply-To: <1304494704-7285-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The function dsi_pll_init() has omap_dss_device argument which is
not used. Remove this argument.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dpi.c |    2 +-
 drivers/video/omap2/dss/dsi.c |    5 ++---
 drivers/video/omap2/dss/dss.h |    3 +--
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index e442b09..426177b 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -189,7 +189,7 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 
 	if (dpi_use_dsi_pll(dssdev)) {
 		dss_clk_enable(DSS_CLK_SYSCK);
-		r = dsi_pll_init(dssdev, 0, 1);
+		r = dsi_pll_init(0, 1);
 		if (r)
 			goto err3;
 	}
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 471d1f0..22dd57c 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1470,8 +1470,7 @@ err:
 	return r;
 }
 
-int dsi_pll_init(struct omap_dss_device *dssdev, bool enable_hsclk,
-		bool enable_hsdiv)
+int dsi_pll_init(bool enable_hsclk, bool enable_hsdiv)
 {
 	int r = 0;
 	enum dsi_pll_power_state pwstate;
@@ -3745,7 +3744,7 @@ static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
 {
 	int r;
 
-	r = dsi_pll_init(dssdev, true, true);
+	r = dsi_pll_init(true, true);
 	if (r)
 		goto err0;
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index eea5c7d..40764e0 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -292,8 +292,7 @@ int dsi_pll_set_clock_div(struct dsi_clock_info *cinfo);
 int dsi_pll_calc_clock_div_pck(bool is_tft, unsigned long req_pck,
 		struct dsi_clock_info *cinfo,
 		struct dispc_clock_info *dispc_cinfo);
-int dsi_pll_init(struct omap_dss_device *dssdev, bool enable_hsclk,
-		bool enable_hsdiv);
+int dsi_pll_init(bool enable_hsclk, bool enable_hsdiv);
 void dsi_pll_uninit(bool disconnect_lanes);
 void dsi_get_overlay_fifo_thresholds(enum omap_plane plane,
 		u32 fifo_size, enum omap_burst_size *burst_size,
-- 
1.7.1

