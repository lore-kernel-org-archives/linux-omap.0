From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 4/5] OMAPDSS: fix dispc register dump for preload & mflag
Date: Wed, 22 Oct 2014 11:39:33 +0300
Message-ID: <1413967174-28009-4-git-send-email-tomi.valkeinen@ti.com>
References: <1413967174-28009-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42064 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754013AbaJVIkL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Oct 2014 04:40:11 -0400
In-Reply-To: <1413967174-28009-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Preload register is dumped twice for video overlays and mflag register
is not dumped for GFX.

Fix the register dump.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index e67976bd0627..0e9a74bb9fc2 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -3290,8 +3290,11 @@ static void dispc_dump_regs(struct seq_file *s)
 		DUMPREG(i, DISPC_OVL_FIFO_SIZE_STATUS);
 		DUMPREG(i, DISPC_OVL_ROW_INC);
 		DUMPREG(i, DISPC_OVL_PIXEL_INC);
+
 		if (dss_has_feature(FEAT_PRELOAD))
 			DUMPREG(i, DISPC_OVL_PRELOAD);
+		if (dss_has_feature(FEAT_MFLAG))
+			DUMPREG(i, DISPC_OVL_MFLAG_THRESHOLD);
 
 		if (i == OMAP_DSS_GFX) {
 			DUMPREG(i, DISPC_OVL_WINDOW_SKIP);
@@ -3312,10 +3315,6 @@ static void dispc_dump_regs(struct seq_file *s)
 		}
 		if (dss_has_feature(FEAT_ATTR2))
 			DUMPREG(i, DISPC_OVL_ATTRIBUTES2);
-		if (dss_has_feature(FEAT_PRELOAD))
-			DUMPREG(i, DISPC_OVL_PRELOAD);
-		if (dss_has_feature(FEAT_MFLAG))
-			DUMPREG(i, DISPC_OVL_MFLAG_THRESHOLD);
 	}
 
 #undef DISPC_REG
-- 
2.1.1

