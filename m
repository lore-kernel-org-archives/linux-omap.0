From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 2/2] ARM: OMAP: CLKFW: Remove procfs entry for debugging clock framework
Date: Thu, 17 Apr 2008 17:09:34 +0300
Message-ID: <1208441374-25408-2-git-send-email-Hiroshi.DOYU@nokia.com>
References: <20080416205119.GF17055@atomide.com>
 <1208441374-25408-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:60026 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094AbYDQOJk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Apr 2008 10:09:40 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3HEA8a2007430
	for <linux-omap@vger.kernel.org>; Thu, 17 Apr 2008 09:12:02 -0500
Received: from oreo.research.nokia.com (esdhcp041142.research.nokia.com [172.21.41.142])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m3HE9YRw031357
	for <linux-omap@vger.kernel.org>; Thu, 17 Apr 2008 17:09:34 +0300
In-Reply-To: <1208441374-25408-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

This feature can be covered by debugfs for omap clock framework.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/clock.c |   96 --------------------------------------------
 1 files changed, 0 insertions(+), 96 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index fa5c965..3fd28d1 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -34,41 +34,6 @@ static DEFINE_SPINLOCK(clockfw_lock);
 
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
@@ -447,67 +412,6 @@ int __init clk_init(struct clk_functions * custom_clocks)
 	return 0;
 }
 
-#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_PROC_FS)
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
-
-static void *omap_ck_start(struct seq_file *m, loff_t *pos)
-{
-	return *pos < 1 ? (void *)1 : NULL;
-}
-
-static void *omap_ck_next(struct seq_file *m, void *v, loff_t *pos)
-{
-	++*pos;
-	return NULL;
-}
-
-static void omap_ck_stop(struct seq_file *m, void *v)
-{
-}
-
-int omap_ck_show(struct seq_file *m, void *v)
-{
-	struct clk *cp;
-
-	list_for_each_entry(cp, &clocks, node)
-		seq_printf(m,"%s %ld %d\n", cp->name, cp->rate, cp->usecount);
-
-	return 0;
-}
-
-static struct seq_operations omap_ck_op = {
-	.start =	omap_ck_start,
-	.next =		omap_ck_next,
-	.stop =		omap_ck_stop,
-	.show =		omap_ck_show
-};
-
-static int omap_ck_open(struct inode *inode, struct file *file)
-{
-	return seq_open(file, &omap_ck_op);
-}
-
-static struct file_operations proc_omap_ck_operations = {
-	.open		= omap_ck_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
-int __init omap_ck_init(void)
-{
-	struct proc_dir_entry *entry;
-
-	entry = create_proc_entry("omap_clocks", 0, NULL);
-	if (entry)
-		entry->proc_fops = &proc_omap_ck_operations;
-	return 0;
-
-}
-__initcall(omap_ck_init);
-#endif
-
 #if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
 /*
  *	debugfs support to trace clock tree hierarchy and attributes
-- 
1.5.5.rc2.6.gf58d

