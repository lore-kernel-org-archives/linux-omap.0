From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 01/12] OMAPFB: remove use of extended edid block
Date: Tue, 30 Oct 2012 18:09:58 +0200
Message-ID: <1351613409-21186-2-git-send-email-tomi.valkeinen@ti.com>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56376 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933887Ab2J3QKV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Oct 2012 12:10:21 -0400
In-Reply-To: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: rob@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

It seems that using the second EDID block causes more problems than is
of any help. The first mode in the extended block will get
FB_MODE_IS_FIRST set, which will override the first mode from the first
EDID block, thus making the default videomode selection not to work
properly.

This patch removes the use of the extended edid block for now.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index bc225e4..0358b14 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2274,9 +2274,6 @@ static int omapfb_find_best_mode(struct omap_dss_device *display,
 
 	fb_edid_to_monspecs(edid, specs);
 
-	if (edid[126] > 0)
-		fb_edid_add_monspecs(edid + 0x80, specs);
-
 	best_xres = 0;
 	best_idx = -1;
 
-- 
1.7.10.4

