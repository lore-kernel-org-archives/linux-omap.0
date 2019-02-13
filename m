From: Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] fbdev: omap2: fix warnings in dss core
Date: Wed, 13 Feb 2019 09:47:21 +0100
Message-ID: <20190213084721.29624-1-anders.roxell@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: b.zolnierkie@samsung.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>
List-Id: linux-omap@vger.kernel.org

Commit 60d2fa0dad06 ("fbdev: omap2: no need to check return value of
debugfs_create functions") changed the declaration of the return value
of function dss_debugfs_create_file() and the following two warnings
appeared:

drivers/video/fbdev/omap2/omapfb/dss/core.c: In function ‘dss_debugfs_create_file’:
drivers/video/fbdev/omap2/omapfb/dss/core.c:139:9: warning: ‘return’ with a value,
 in function returning void
  return 0;
         ^
drivers/video/fbdev/omap2/omapfb/dss/core.c: In function ‘omap_dss_probe’:
drivers/video/fbdev/omap2/omapfb/dss/core.c:172:6: warning: unused variable ‘r’
 [-Wunused-variable]
  int r;
      ^

Rework so function dss_debugfs_create_file() that is declared to return
void don't 'return 0' and remove the declaration of the unused variable
'r'.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/video/fbdev/omap2/omapfb/dss/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/core.c b/drivers/video/fbdev/omap2/omapfb/dss/core.c
index 7e6a3eb266d0..b5956a1a30d4 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/core.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/core.c
@@ -136,7 +136,6 @@ static inline void dss_uninitialize_debugfs(void)
 }
 void dss_debugfs_create_file(const char *name, void (*write)(struct seq_file *))
 {
-	return 0;
 }
 #endif /* CONFIG_FB_OMAP2_DSS_DEBUGFS */
 
@@ -169,8 +168,6 @@ static struct notifier_block omap_dss_pm_notif_block = {
 
 static int __init omap_dss_probe(struct platform_device *pdev)
 {
-	int r;
-
 	core.pdev = pdev;
 
 	dss_features_init(omapdss_get_version());
-- 
2.19.2
