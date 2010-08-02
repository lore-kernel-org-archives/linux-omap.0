From: archit taneja <archit@ti.com>
Subject: [PATCH v2] OMAP: DSS2: Replace strncmp() with sysfs_streq() in overlay_manager_store()
Date: Mon,  2 Aug 2010 18:44:11 +0530
Message-ID: <1280754851-17077-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48809 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751607Ab0HBNOD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Aug 2010 09:14:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

From: Archit Taneja <archit@ti.com>

The function overlay_manager_store currently fails if the sysfs input is a
prefix string of an existing overlay manager name. This occurs because strncmp
compares the two strings only till the length of the input sysfs string. So a
sysfs input "lcd" will match manager name "lcd2" which is incorrect behavior.

The use of sysfs_streq here will prevent this false positive match to occur.

Signed-off-by: Archit Taneja <archit@ti.com>
---
v2:
 Rewrite the git commit message

v1:
 https://patchwork.kernel.org/patch/114697/

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
