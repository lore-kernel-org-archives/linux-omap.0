From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 2/3] ARM: OMAP: Create an OMAP debugfs root.
Date: Tue, 22 Apr 2008 10:17:09 +0300
Message-ID: <1208848630-6771-2-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1208848630-6771-1-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:56269 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678AbYDVHRV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2008 03:17:21 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3M7GtCM023367
	for <linux-omap@vger.kernel.org>; Tue, 22 Apr 2008 10:17:18 +0300
Received: from oreo.research.nokia.com (esdhcp041142.research.nokia.com [172.21.41.142])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m3M7HBDS020522
	for <linux-omap@vger.kernel.org>; Tue, 22 Apr 2008 10:17:12 +0300
In-Reply-To: <1208848630-6771-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/common.c       |   16 +++++++++++++++-
 include/asm-arm/arch-omap/board.h |    4 +++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index fd6f329..f80dab8 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -9,7 +9,6 @@
  */
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/console.h>
@@ -18,6 +17,7 @@
 #include <linux/serial_8250.h>
 #include <linux/serial_reg.h>
 #include <linux/clk.h>
+#include <linux/debugfs.h>
=20
 #include <asm/hardware.h>
 #include <asm/system.h>
@@ -288,3 +288,17 @@ void __init omap2_set_globals_343x(void)
 }
 #endif
=20
+#ifdef CONFIG_DEBUG_FS
+struct dentry *omap_debugfs_root;
+static int __init omap_debugfs_init(void)
+{
+	struct dentry *d;
+
+	d =3D debugfs_create_dir("omap", arm_debugfs_root);
+	if (IS_ERR(d))
+		return PTR_ERR(d);
+	omap_debugfs_root =3D d;
+	return 0;
+}
+arch_initcall(omap_debugfs_init);
+#endif
diff --git a/include/asm-arm/arch-omap/board.h b/include/asm-arm/arch-o=
map/board.h
index 3763f3e..d94065b 100644
--- a/include/asm-arm/arch-omap/board.h
+++ b/include/asm-arm/arch-omap/board.h
@@ -3,7 +3,7 @@
  *
  *  Information structures for board-specific data
  *
- *  Copyright (C) 2004	Nokia Corporation
+ *  Copyright (C) 2004-2008	Nokia Corporation
  *  Written by Juha Yrj=C3=B6l=C3=A4 <juha.yrjola@nokia.com>
  */
=20
@@ -196,4 +196,6 @@ extern int omap_board_config_size;
 /* for TI reference platforms sharing the same debug card */
 extern int debug_card_init(u32 addr, unsigned gpio);
=20
+extern struct dentry *omap_debugfs_root;
+
 #endif
--=20
1.5.5.rc2.6.gf58d

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
