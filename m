From: Daniel Morsing <daniel.morsing@gmail.com>
Subject: [PATCH] OMAP: DSS2: Don't allow moving managers away from enabled displays
Date: Wed,  3 Aug 2011 22:10:51 +0200
Message-ID: <1312402251-31588-1-git-send-email-daniel.morsing@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41310 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001Ab1HCULA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Aug 2011 16:11:00 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, Daniel Morsing <daniel.morsing@gmail.com>, linux-fbdev@vger.kernel.org

If a manager is moved while attached to an enabled display, the DSS
system will be left in an inconsistent state. This will eventually cause
a kernel oops when the enabled display is disabled.

Fix this by not allowing the user to move a manager away from an enabled
display.

Signed-off-by: Daniel Morsing <daniel.morsing@gmail.com>
---
 drivers/video/omap2/dss/manager.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 9aeea50..d3372d1 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -502,6 +502,13 @@ static int omap_dss_unset_device(struct omap_overlay_manager *mgr)
 		return -EINVAL;
 	}
 
+	/*
+	 * Don't allow currently enabled displays to have the overlay manager
+	 * pulled out from underneath them
+	 */
+	if (mgr->device->state != OMAP_DSS_DISPLAY_DISABLED)
+		return -EINVAL;
+
 	mgr->device->manager = NULL;
 	mgr->device = NULL;
 	mgr->device_changed = true;
-- 
1.7.6

