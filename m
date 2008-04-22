From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 3/3] ARM: OMAP: Expose omap tags as debugfs binary blob
Date: Tue, 22 Apr 2008 10:17:10 +0300
Message-ID: <1208848630-6771-3-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1208848630-6771-1-git-send-email-Hiroshi.DOYU@nokia.com>
 <1208848630-6771-2-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:64382 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbYDVHRS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2008 03:17:18 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3M7HE0J012237
	for <linux-omap@vger.kernel.org>; Tue, 22 Apr 2008 10:17:16 +0300
Received: from oreo.research.nokia.com (esdhcp041142.research.nokia.com [172.21.41.142])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m3M7HB55031112
	for <linux-omap@vger.kernel.org>; Tue, 22 Apr 2008 10:17:12 +0300
In-Reply-To: <1208848630-6771-2-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/common.c |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index f80dab8..5a501e1 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -289,7 +289,26 @@ void __init omap2_set_globals_343x(void)
 #endif
 
 #ifdef CONFIG_DEBUG_FS
+
 struct dentry *omap_debugfs_root;
+
+#ifdef CONFIG_OMAP_BOOT_TAG
+static int __init add_tag_blob(void)
+{
+	struct dentry *d;
+	static struct debugfs_blob_wrapper blob;
+
+	blob.data = omap_bootloader_tag;
+	blob.size = omap_bootloader_tag_len;
+
+	d = debugfs_create_blob("tag", 0444, omap_debugfs_root, &blob);
+	if (IS_ERR(d))
+		return PTR_ERR(d);
+	return 0;
+}
+late_initcall(add_tag_blob);
+#endif
+
 static int __init omap_debugfs_init(void)
 {
 	struct dentry *d;
@@ -301,4 +320,4 @@ static int __init omap_debugfs_init(void)
 	return 0;
 }
 arch_initcall(omap_debugfs_init);
-#endif
+#endif	/* CONFIG_DEBUG_FS */
-- 
1.5.5.rc2.6.gf58d

