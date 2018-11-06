From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] ARM: OMAP: PM: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date: Tue,  6 Nov 2018 09:35:16 -0500
Message-ID: <20181106143516.8394-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: khilman@kernel.org, aaro.koskinen@iki.fi, tony@atomide.com, linux@armlinux.org.uk
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-omap@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm/mach-omap1/pm.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 3e1de14805e4..998075d3ef86 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -532,18 +532,7 @@ static int omap_pm_debug_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int omap_pm_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, omap_pm_debug_show,
-				&inode->i_private);
-}
-
-static const struct file_operations omap_pm_debug_fops = {
-	.open		= omap_pm_debug_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(omap_pm_debug);
 
 static void omap_pm_init_debugfs(void)
 {
-- 
2.17.0
