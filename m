From: Archit Taneja <archit@ti.com>
Subject: [PATCH] Replace strncmp() with sysfs_streq() in overlay_manager_store()
Date: Tue,  6 Jul 2010 09:33:06 +0530
Message-ID: <1278388986-8324-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58116 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721Ab0GFEDS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Jul 2010 00:03:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

In the function overlay_manager_store, the length of the string
buf is used to comapre the 2 strings, there is a possibility of
false positive match if buf is a prefix string of another manager.

The use of sysfs_streq() fixes this.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/overlay.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index 8233658..244dca8
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -65,7 +65,7 @@ static ssize_t overlay_manager_store(struct omap_overlay *ovl, const char *buf,
 		for (i = 0; i < omap_dss_get_num_overlay_managers(); ++i) {
 			mgr = omap_dss_get_overlay_manager(i);
 
-			if (strncmp(buf, mgr->name, len) == 0)
+			if (sysfs_streq(buf, mgr->name))
 				break;
 
 			mgr = NULL;
-- 
1.5.4.7

