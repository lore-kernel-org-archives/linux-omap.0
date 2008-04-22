From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/3] ARM: Create an ARM debugfs root.
Date: Tue, 22 Apr 2008 10:17:08 +0300
Message-ID: <1208848630-6771-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:56268 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbYDVHRV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2008 03:17:21 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3M7Gv23023657
	for <linux-omap@vger.kernel.org>; Tue, 22 Apr 2008 10:17:18 +0300
Received: from oreo.research.nokia.com (esdhcp041142.research.nokia.com [172.21.41.142])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m3M7HBKU031111
	for <linux-omap@vger.kernel.org>; Tue, 22 Apr 2008 10:17:12 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/kernel/setup.c  |   14 ++++++++++++++
 include/asm-arm/system.h |    2 ++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index b7b0720..1b1e6e4 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -24,6 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/smp.h>
 #include <linux/fs.h>
+#include <linux/debugfs.h>
 
 #include <asm/cpu.h>
 #include <asm/elf.h>
@@ -1007,3 +1008,16 @@ const struct seq_operations cpuinfo_op = {
 	.stop	= c_stop,
 	.show	= c_show
 };
+
+#ifdef CONFIG_DEBUG_FS
+struct dentry *arm_debugfs_root;
+static int __init arm_debugfs_init(void)
+{
+	arm_debugfs_root = debugfs_create_dir("arm", NULL);
+	if (IS_ERR(arm_debugfs_root))
+		return PTR_ERR(arm_debugfs_root);
+
+	return 0;
+}
+arch_initcall(arm_debugfs_init);
+#endif
diff --git a/include/asm-arm/system.h b/include/asm-arm/system.h
index 6335de9..a6be185 100644
--- a/include/asm-arm/system.h
+++ b/include/asm-arm/system.h
@@ -378,6 +378,8 @@ extern void enable_hlt(void);
 #include <asm-generic/cmpxchg.h>
 #endif
 
+extern struct dentry *arm_debugfs_root;
+
 #endif /* __ASSEMBLY__ */
 
 #define arch_align_stack(x) (x)
-- 
1.5.5.rc2.6.gf58d

