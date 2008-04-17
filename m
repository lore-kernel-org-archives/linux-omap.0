From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/2] ARM: OMAP: CLKFW: Initial debugfs support for omap clock framework
Date: Thu, 17 Apr 2008 17:09:33 +0300
Message-ID: <1208441374-25408-1-git-send-email-Hiroshi.DOYU@nokia.com>
References: <20080416205119.GF17055@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:54427 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753794AbYDQOKO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Apr 2008 10:10:14 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3HE9sLh010610
	for <linux-omap@vger.kernel.org>; Thu, 17 Apr 2008 17:10:10 +0300
Received: from oreo.research.nokia.com (esdhcp041142.research.nokia.com [172.21.41.142])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m3HE9Ywe027821
	for <linux-omap@vger.kernel.org>; Thu, 17 Apr 2008 17:09:34 +0300
In-Reply-To: <20080416205119.GF17055@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

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
---
 arch/arm/plat-omap/clock.c        |   94 ++++++++++++++++++++++++++++++++++++-
 include/asm-arm/arch-omap/clock.h |    3 +
 2 files changed, 96 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 1bd8781..fa5c965 100644
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
@@ -21,6 +21,7 @@
 #include <linux/clk.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
+#include <linux/debugfs.h>
 
 #include <asm/io.h>
 #include <asm/semaphore.h>
@@ -506,3 +507,94 @@ int __init omap_ck_init(void)
 }
 __initcall(omap_ck_init);
 #endif
+
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
+		sprintf(p, "%d", c->id);
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
index cce55ba..0d75724 100644
--- a/include/asm-arm/arch-omap/clock.h
+++ b/include/asm-arm/arch-omap/clock.h
@@ -86,6 +86,9 @@ struct clk {
 	__u8			rate_offset;
 	__u8			src_offset;
 #endif
+#ifdef CONFIG_DEBUG_FS
+	struct dentry		*dent;	/* For visible tree hierarchy */
+#endif
 };
 
 struct clk_functions {
-- 
1.5.5.rc2.6.gf58d

