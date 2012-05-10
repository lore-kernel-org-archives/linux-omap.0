From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH v2] OMAPDSS: OMAPFB: always allow to configure overlay
Date: Thu, 10 May 2012 14:19:56 +0300
Message-ID: <1336648796-20219-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:60306 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835Ab2EJLUk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 07:20:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Grazvydas Ignotas <notasas@gmail.com>

Currently when multiple overlays are active, OMAPFB_SETUP_PLANE fails.
Instead of failing, allow it to configure the first overlay as if there
was only one overlay, the remaining ones will have to be configured in
other ways (sysfs).

This allows overlay-controlling programs (like video players) to function
properly when framebuffer is cloned to another display (like TV).

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/video/omap2/omapfb/omapfb-ioctl.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/omap2/omapfb/omapfb-ioctl.c
index 6a09ef8..8af7e17 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -70,7 +70,7 @@ static int omapfb_setup_plane(struct fb_info *fbi, struct omapfb_plane_info *pi)
 
 	DBG("omapfb_setup_plane\n");
 
-	if (ofbi->num_overlays != 1) {
+	if (ofbi->num_overlays == 0) {
 		r = -EINVAL;
 		goto out;
 	}
@@ -185,7 +185,7 @@ static int omapfb_query_plane(struct fb_info *fbi, struct omapfb_plane_info *pi)
 {
 	struct omapfb_info *ofbi = FB2OFB(fbi);
 
-	if (ofbi->num_overlays != 1) {
+	if (ofbi->num_overlays == 0) {
 		memset(pi, 0, sizeof(*pi));
 	} else {
 		struct omap_overlay *ovl;
-- 
1.7.0.4

