From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 4/5] OMAP: DSS2: DISPC: Shorten _dispc_set_color_conv_coef()
Date: Fri, 5 Aug 2011 19:06:03 +0530
Message-ID: <1312551364-4828-5-git-send-email-archit@ti.com>
References: <1312551364-4828-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59274 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754761Ab1HEN1m (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Aug 2011 09:27:42 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p75DRfuD025638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 5 Aug 2011 08:27:42 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id p75DRfrH027400
	for <linux-omap@vger.kernel.org>; Fri, 5 Aug 2011 08:27:41 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p75DRfkT022700
	for <linux-omap@vger.kernel.org>; Fri, 5 Aug 2011 08:27:41 -0500 (CDT)
In-Reply-To: <1312551364-4828-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Iterate over overlay id's to shorten _dispc_set_color_conv_coef()

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   42 ++++++++++++++------------------------
 1 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 2fd16ac..8cab996 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -641,6 +641,7 @@ static void _dispc_set_scale_coef(enum omap_plane plane, int hscaleup,
 
 static void _dispc_setup_color_conv_coef(void)
 {
+	int i;
 	const struct color_conv_coef {
 		int  ry,  rcr,  rcb,   gy,  gcr,  gcb,   by,  bcr,  bcb;
 		int  full_range;
@@ -654,34 +655,23 @@ static void _dispc_setup_color_conv_coef(void)
 
 	ct = &ctbl_bt601_5;
 
-	dispc_write_reg(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO1, 0),
-		CVAL(ct->rcr, ct->ry));
-	dispc_write_reg(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO1, 1),
-		CVAL(ct->gy,  ct->rcb));
-	dispc_write_reg(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO1, 2),
-		CVAL(ct->gcb, ct->gcr));
-	dispc_write_reg(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO1, 3),
-		CVAL(ct->bcr, ct->by));
-	dispc_write_reg(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO1, 4),
-		CVAL(0, ct->bcb));
-
-	dispc_write_reg(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO2, 0),
-		CVAL(ct->rcr, ct->ry));
-	dispc_write_reg(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO2, 1),
-		CVAL(ct->gy, ct->rcb));
-	dispc_write_reg(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO2, 2),
-		CVAL(ct->gcb, ct->gcr));
-	dispc_write_reg(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO2, 3),
-		CVAL(ct->bcr, ct->by));
-	dispc_write_reg(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO2, 4),
-		CVAL(0, ct->bcb));
+	for (i = 1; i < dss_feat_get_num_ovls(); i++) {
+		dispc_write_reg(DISPC_OVL_CONV_COEF(i, 0),
+			CVAL(ct->rcr, ct->ry));
+		dispc_write_reg(DISPC_OVL_CONV_COEF(i, 1),
+			CVAL(ct->gy,  ct->rcb));
+		dispc_write_reg(DISPC_OVL_CONV_COEF(i, 2),
+			CVAL(ct->gcb, ct->gcr));
+		dispc_write_reg(DISPC_OVL_CONV_COEF(i, 3),
+			CVAL(ct->bcr, ct->by));
+		dispc_write_reg(DISPC_OVL_CONV_COEF(i, 4),
+			CVAL(0, ct->bcb));
 
-#undef CVAL
+		REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(i), ct->full_range,
+			11, 11);
+	}
 
-	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(OMAP_DSS_VIDEO1),
-		ct->full_range, 11, 11);
-	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(OMAP_DSS_VIDEO2),
-		ct->full_range, 11, 11);
+#undef CVAL
 }
 
 
-- 
1.7.1

