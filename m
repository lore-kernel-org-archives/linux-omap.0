From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 05/11] OMAPDSS: DISPC: fix row_inc for OMAP3
Date: Wed, 17 Jun 2015 15:54:29 +0300
Message-ID: <1434545675-477-6-git-send-email-tomi.valkeinen@ti.com>
References: <1434545675-477-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40736 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754990AbbFQMy5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Jun 2015 08:54:57 -0400
In-Reply-To: <1434545675-477-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

pixel_inc and row_inc work differently on OMAP2/3 and OMAP4+ DSS. On
OMAP2/3 DSS, the pixel_inc is _not_ added by the HW at the end of the
line, after the last pixel, whereas on OMAP4+ it is.

The driver currently works for OMAP4+, but does not handle OMAP2/3
correctly, which leads to tilted image when row_inc is used.

This patch adds a flag to DISPC driver so that the pixel_inc is added
when required.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index ddce8fcfc5c1..4488d9367bd3 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -95,6 +95,9 @@ struct dispc_features {
 	bool mstandby_workaround:1;
 
 	bool set_max_preload:1;
+
+	/* PIXEL_INC is not added to the last pixel of a line */
+	bool last_pixel_inc_missing:1;
 };
 
 #define DISPC_MAX_NR_FIFOS 5
@@ -2692,6 +2695,9 @@ static int dispc_ovl_setup_common(enum omap_plane plane,
 		dispc_ovl_set_ba1_uv(plane, p_uv_addr + offset1);
 	}
 
+	if (dispc.feat->last_pixel_inc_missing)
+		row_inc += pix_inc - 1;
+
 	dispc_ovl_set_row_inc(plane, row_inc);
 	dispc_ovl_set_pix_inc(plane, pix_inc);
 
@@ -3769,6 +3775,7 @@ static const struct dispc_features omap24xx_dispc_feats __initconst = {
 	.num_fifos		=	3,
 	.no_framedone_tv	=	true,
 	.set_max_preload	=	false,
+	.last_pixel_inc_missing	=	true,
 };
 
 static const struct dispc_features omap34xx_rev1_0_dispc_feats __initconst = {
@@ -3789,6 +3796,7 @@ static const struct dispc_features omap34xx_rev1_0_dispc_feats __initconst = {
 	.num_fifos		=	3,
 	.no_framedone_tv	=	true,
 	.set_max_preload	=	false,
+	.last_pixel_inc_missing	=	true,
 };
 
 static const struct dispc_features omap34xx_rev3_0_dispc_feats __initconst = {
@@ -3809,6 +3817,7 @@ static const struct dispc_features omap34xx_rev3_0_dispc_feats __initconst = {
 	.num_fifos		=	3,
 	.no_framedone_tv	=	true,
 	.set_max_preload	=	false,
+	.last_pixel_inc_missing	=	true,
 };
 
 static const struct dispc_features omap44xx_dispc_feats __initconst = {
-- 
2.1.4

