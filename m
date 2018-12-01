From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] media: omap2: omapfb: convert to DEFINE_SHOW_ATTRIBUTE
Date: Sat,  1 Dec 2018 08:01:14 -0500
Message-ID: <20181201130114.7092-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: b.zolnierkie@samsung.com, fengguang.wu@intel.com, mchehab+samsung@kernel.org
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-omap@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/video/fbdev/omap2/omapfb/dss/core.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/core.c b/drivers/video/fbdev/omap2/omapfb/dss/core.c
index a5e58a829ea0..7d3d9f6fad10 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/core.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/core.c
@@ -99,24 +99,14 @@ int dss_set_min_bus_tput(struct device *dev, unsigned long tput)
 }
 
 #if defined(CONFIG_FB_OMAP2_DSS_DEBUGFS)
-static int dss_debug_show(struct seq_file *s, void *unused)
+static int dss_show(struct seq_file *s, void *unused)
 {
 	void (*func)(struct seq_file *) = s->private;
 	func(s);
 	return 0;
 }
 
-static int dss_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, dss_debug_show, inode->i_private);
-}
-
-static const struct file_operations dss_debug_fops = {
-	.open           = dss_debug_open,
-	.read           = seq_read,
-	.llseek         = seq_lseek,
-	.release        = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(dss);
 
 static struct dentry *dss_debugfs_dir;
 
@@ -130,7 +120,7 @@ static int dss_initialize_debugfs(void)
 	}
 
 	debugfs_create_file("clk", S_IRUGO, dss_debugfs_dir,
-			&dss_debug_dump_clocks, &dss_debug_fops);
+			&dss_debug_dump_clocks, &dss_fops);
 
 	return 0;
 }
-- 
2.17.0
