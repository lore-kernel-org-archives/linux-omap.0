From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 6/6] OMAP: Add debugfs node to show the summary of all clocks
Date: Thu, 14 Jul 2011 18:25:08 -0500
Message-ID: <1310685908-3434-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52583 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932590Ab1GNXZL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jul 2011 19:25:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Jon Hunter <jon-hunter@ti.com>

From: Jon Hunter <jon-hunter@ti.com>

Add a debugfs node called "summary" to /sys/kernel/debug/clock/
that displays a quick summary of all clocks registered in the
"clocks" structure. The format of the output from this node is:

<clock-name> <parent-name> <rate> <usecount>

This debugfs node was very helpful for taking a quick snapshot of
the linux clock tree for OMAP and ensuring clock frequencies
calculated by the kernel were indeed correct. This patch helped
uncover some bugs in the linux clock tree for OMAP4.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/plat-omap/clock.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index c9122dd..156b27d 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -475,8 +475,41 @@ int __init clk_init(struct clk_functions * custom_clocks)
 /*
  *	debugfs support to trace clock tree hierarchy and attributes
  */
+
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+
 static struct dentry *clk_debugfs_root;
 
+static int clk_dbg_show_summary(struct seq_file *s, void *unused)
+{
+	struct clk *c;
+	struct clk *pa;
+
+	seq_printf(s, "%-30s %-30s %-10s %s\n",
+		"clock-name", "parent-name", "rate", "use-count");
+
+	list_for_each_entry(c, &clocks, node) {
+		pa = c->parent;
+		seq_printf(s, "%-30s %-30s %-10lu %d\n",
+			c->name, pa ? pa->name : "none", c->rate, c->usecount);
+	}
+
+	return 0;
+}
+
+static int clk_dbg_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, clk_dbg_show_summary, inode->i_private);
+}
+
+static const struct file_operations debug_clock_fops = {
+	.open           = clk_dbg_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release        = single_release,
+};
+
 static int clk_debugfs_register_one(struct clk *c)
 {
 	int err;
@@ -551,6 +584,12 @@ static int __init clk_debugfs_init(void)
 		if (err)
 			goto err_out;
 	}
+
+	d = debugfs_create_file("summary", S_IRUGO,
+		d, NULL, &debug_clock_fops);
+	if (!d)
+		return -ENOMEM;
+
 	return 0;
 err_out:
 	debugfs_remove_recursive(clk_debugfs_root);
-- 
1.7.4.1

