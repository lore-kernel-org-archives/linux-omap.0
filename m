From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 5/5] OMAPFB: fix releasing overlays
Date: Thu, 16 Oct 2014 12:39:47 +0300
Message-ID: <1413452387-25452-5-git-send-email-tomi.valkeinen@ti.com>
References: <1413452387-25452-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39631 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbaJPJkA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Oct 2014 05:40:00 -0400
In-Reply-To: <1413452387-25452-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

omapfb disables all the overlays when freeing resources, but it should
also remove those overlays from overlay managers.

Not doing so causes a crash if omapfb is unbound and bound, or omapfb
module is removed and loaded, while keeping omapdss around.

Fix this by calling unset_manager() for all overlays.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
index 36ffb525be73..58ffd651d2c2 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
@@ -1837,6 +1837,9 @@ static void omapfb_free_resources(struct omapfb2_device *fbdev)
 		struct omap_overlay *ovl = fbdev->overlays[i];
 
 		ovl->disable(ovl);
+
+		if (ovl->manager)
+			ovl->unset_manager(ovl);
 	}
 
 	for (i = 0; i < fbdev->num_fbs; i++)
-- 
2.1.1

