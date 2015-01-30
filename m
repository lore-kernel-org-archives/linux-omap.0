From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] omapfb: Return error code when applying overlay settings fails
Date: Fri, 30 Jan 2015 08:59:46 +0100
Message-ID: <1422604786-6804-1-git-send-email-pmeerw@pmeerw.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:43971 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751681AbbA3IGI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Jan 2015 03:06:08 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>

the check of the return code is missing, user space does not get notified
about the error condition:

omapdss OVERLAY error: overlay 2 horizontally not inside the display area (403 + 800 >= 800)
omapdss APPLY error: failed to apply settings: illegal configuration.

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c b/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
index 146b6f5..9ddfdd6 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
@@ -137,8 +137,11 @@ static int omapfb_setup_plane(struct fb_info *fbi, struct omapfb_plane_info *pi)
 			goto undo;
 	}
 
-	if (ovl->manager)
-		ovl->manager->apply(ovl->manager);
+	if (ovl->manager) {
+		r = ovl->manager->apply(ovl->manager);
+		if (r)
+			goto undo;
+	}
 
 	if (pi->enabled) {
 		r = ovl->enable(ovl);
-- 
1.7.10.4

