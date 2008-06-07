From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 15/21] ARM: OMAP: CLKFW: Initial debugfs support for omap clock framework
Date: Fri,  6 Jun 2008 18:30:47 -0700
Message-ID: <1212802253-17797-16-git-send-email-tony@atomide.com>
References: omap-upstream-2008-06-06-183049
 <1212802253-17797-1-git-send-email-tony@atomide.com>
 <1212802253-17797-2-git-send-email-tony@atomide.com>
 <1212802253-17797-3-git-send-email-tony@atomide.com>
 <1212802253-17797-4-git-send-email-tony@atomide.com>
 <1212802253-17797-5-git-send-email-tony@atomide.com>
 <1212802253-17797-6-git-send-email-tony@atomide.com>
 <1212802253-17797-7-git-send-email-tony@atomide.com>
 <1212802253-17797-8-git-send-email-tony@atomide.com>
 <1212802253-17797-9-git-send-email-tony@atomide.com>
 <1212802253-17797-10-git-send-email-tony@atomide.com>
 <1212802253-17797-11-git-send-email-tony@atomide.com>
 <1212802253-17797-12-git-send-email-tony@atomide.com>
 <1212802253-17797-13-git-send-email-tony@atomide.com>
 <1212802253-17797-14-git-send-email-tony@atomide.com>
 <1212802253-17797-15-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:55505 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933066AbYFGBb2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jun 2008 21:31:28 -0400
In-Reply-To: <1212802253-17797-15-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Tony Lindgren <tony@atomide.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

debugfs can provide the infrastructure to trace the dependencies of
clock tree hierarchy quite visibly. This patch enables to keep track
of clock tree hierarchy and expose their attributes under each clock
directry as below:

	omap:~# tree -d -L 2 /debug/clock/omap_32k_fck/
	/debug/clock/omap_32k_fck/
	|-- gpt10_fck
	|-- gpt11_fck
	|-- gpt1_fck
	|-- per_32k_alwon_fck
	|   |-- gpio2_fck
	|   |-- gpio3_fck
	|   |-- gpio4_fck
	|   |-- gpio5_fck
	|   |-- gpio6_fck
	|   `-- wdt3_fck
	|-- ts_fck
	`-- wkup_32k_fck
	    |-- gpio1_fck
	    `-- wdt2_fck

	14 directories
	omap:~# tree  /debug/clock/omap_32k_fck/gpt10_fck/
	/debug/clock/omap_32k_fck/gpt10_fck/
	|-- flags
	|-- rate
	`-- usecount

	0 directories, 3 files

Although, compared with David Brownell's small patch, this may look
bit overkilling, I expect that this debugfs can deal with other PRCM
complexities at the same time. For example, powerdomain dependencies
can be expressed by using symbolic links of these clocks if
powerdomain supports dubgfs as well.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 2db5580..c2e741d 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -1,7 +1,7 @@
 /*
  *  linux/arch/arm/plat-omap/clock.c
  *
- *  Copyright (C) 2004 - 2005 Nokia corporation
+ *  Copyright (C) 2004 - 2008 Nokia corporation
  *  Written by Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
  *
  *  Modified for omap shared clock framework by Tony Lindgren <tony@atomide.com>
@@ -22,6 +22,7 @@
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/cpufreq.h>
+#include <linux/debugfs.h>
 
 #include <asm/io.h>
 
@@ -33,41 +34,6 @@ static DEFINE_SPINLOCK(clockfw_lock);
 
 static struct clk_functions *arch_clock;
 
-#ifdef CONFIG_PM_DEBUG
-
-static void print_parents(struct clk *clk)
-{
-	struct clk *p;
-	int printed = 0;
-
-	list_for_each_entry(p, &clocks, node) {
-		if (p->parent == clk && p->usecount) {
-			if (!clk->usecount && !printed) {
-				printk("MISMATCH: %s\n", clk->name);
-				printed = 1;
-			}
-			printk("\t%-15s\n", p->name);
-		}
-	}
-}
-
-void clk_print_usecounts(void)
-{
-	unsigned long flags;
-	struct clk *p;
-
-	spin_lock_irqsave(&clockfw_lock, flags);
-	list_for_each_entry(p, &clocks, node) {
-		if (p->usecount)
-			printk("%-15s: %d\n", p->name, p->usecount);
-		print_parents(p);
-
-	}
-	spin_unlock_irqrestore(&clockfw_lock, flags);
-}
-
-#endif
-
 /*-------------------------------------------------------------------------
  * Standard clock functions defined in include/linux/clk.h
  *-------------------------------------------------------------------------*/
@@ -446,3 +412,93 @@ int __init clk_init(struct clk_functions * custom_clocks)
 	return 0;
 }
 
+#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
+/*
+ *	debugfs support to trace clock tree hierarchy and attributes
+ */
+static struct dentry *clk_debugfs_root;
+
+static int clk_debugfs_register_one(struct clk *c)
+{
+	int err;
+	struct dentry *d, *child;
+	struct clk *pa = c->parent;
+	char s[255];
+	char *p = s;
+
+	p += sprintf(p, "%s", c->name);
+	if (c->id != 0)
+		sprintf(p, ":%d", c->id);
+	d = debugfs_create_dir(s, pa ? pa->dent : clk_debugfs_root);
+	if (IS_ERR(d))
+		return PTR_ERR(d);
+	c->dent = d;
+
+	d = debugfs_create_u8("usecount", S_IRUGO, c->dent, (u8 *)&c->usecount);
+	if (IS_ERR(d)) {
+		err = PTR_ERR(d);
+		goto err_out;
+	}
+	d = debugfs_create_u32("rate", S_IRUGO, c->dent, (u32 *)&c->rate);
+	if (IS_ERR(d)) {
+		err = PTR_ERR(d);
+		goto err_out;
+	}
+	d = debugfs_create_x32("flags", S_IRUGO, c->dent, (u32 *)&c->flags);
+	if (IS_ERR(d)) {
+		err = PTR_ERR(d);
+		goto err_out;
+	}
+	return 0;
+
+err_out:
+	d = c->dent;
+	list_for_each_entry(child, &d->d_subdirs, d_u.d_child)
+		debugfs_remove(child);
+	debugfs_remove(c->dent);
+	return err;
+}
+
+static int clk_debugfs_register(struct clk *c)
+{
+	int err;
+	struct clk *pa = c->parent;
+
+	if (pa && !pa->dent) {
+		err = clk_debugfs_register(pa);
+		if (err)
+			return err;
+	}
+
+	if (!c->dent) {
+		err = clk_debugfs_register_one(c);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+static int __init clk_debugfs_init(void)
+{
+	struct clk *c;
+	struct dentry *d;
+	int err;
+
+	d = debugfs_create_dir("clock", NULL);
+	if (IS_ERR(d))
+		return PTR_ERR(d);
+	clk_debugfs_root = d;
+
+	list_for_each_entry(c, &clocks, node) {
+		err = clk_debugfs_register(c);
+		if (err)
+			goto err_out;
+	}
+	return 0;
+err_out:
+	debugfs_remove(clk_debugfs_root); /* REVISIT: Cleanup correctly */
+	return err;
+}
+late_initcall(clk_debugfs_init);
+
+#endif /* defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS) */
diff --git a/include/asm-arm/arch-omap/clock.h b/include/asm-arm/arch-omap/clock.h
index 12a5e4d..8490fbb 100644
--- a/include/asm-arm/arch-omap/clock.h
+++ b/include/asm-arm/arch-omap/clock.h
@@ -71,6 +71,9 @@ struct clk {
 	__u8			rate_offset;
 	__u8			src_offset;
 #endif
+#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
+	struct dentry		*dent;	/* For visible tree hierarchy */
+#endif
 };
 
 struct cpufreq_frequency_table;
