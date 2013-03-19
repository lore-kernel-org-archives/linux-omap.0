From: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
Subject: [PATCH] drivers: video: omap2: dss: Use PTR_RET function
Date: Tue, 19 Mar 2013 10:03:14 +0200
Message-ID: <1363680194-10404-1-git-send-email-gheorghiuandru@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Sumit Semwal <sumit.semwal@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Alexandru Gheorghiu <gheorghiuandru@gmail.com>
List-Id: linux-omap@vger.kernel.org

Use PTR_RET function instead of IS_ERR and PTR_ERR.
Patch found using coccinelle.

Signed-off-by: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
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
