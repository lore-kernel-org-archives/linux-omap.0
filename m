From: Andrei Epure <epure.andrei@gmail.com>
Subject: [PATCH] video: omap2: dss: use PTR_RET function
Date: Wed, 27 Mar 2013 22:35:37 +0200
Message-ID: <1364416537-25367-1-git-send-email-epure.andrei@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:60122 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394Ab3C0Ufq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Mar 2013 16:35:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, FlorianSchandinat@gmx.de
Cc: sumit.semwal@ti.com, archit@ti.com, cmahapatra@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrei Epure <epure.andrei@gmail.com>

Use PTR_RET function instead of IS_ERR + PTR_ERR.
Patch found using coccinelle.

Signed-off-by: Andrei Epure <epure.andrei@gmail.com>
---
 drivers/video/omap2/dss/core.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index f8779d4..60cc6fe 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -181,10 +181,7 @@ int dss_debugfs_create_file(const char *name, void (*write)(struct seq_file *))
 	d = debugfs_create_file(name, S_IRUGO, dss_debugfs_dir,
 			write, &dss_debug_fops);
 
-	if (IS_ERR(d))
-		return PTR_ERR(d);
-
-	return 0;
+	return PTR_RET(d);
 }
 #else /* CONFIG_OMAP2_DSS_DEBUGFS */
 static inline int dss_initialize_debugfs(void)
-- 
1.7.9.5

