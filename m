From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/3] ARM: OMAP: Remove plat-omap/common.c
Date: Thu, 01 Nov 2012 15:48:28 -0700
Message-ID: <20121101224828.2103.82950.stgit@muffinssi.local>
References: <20121101224703.2103.95474.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:19855 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934360Ab2KAWs3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Nov 2012 18:48:29 -0400
In-Reply-To: <20121101224703.2103.95474.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This file has only omap_init_consistent_dma_size()
left that can be moved to plat-omap/dma.c.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/Makefile |    2 +-
 arch/arm/plat-omap/common.c |   26 --------------------------
 arch/arm/plat-omap/dma.c    |    8 ++++++++
 3 files changed, 9 insertions(+), 27 deletions(-)
 delete mode 100644 arch/arm/plat-omap/common.c

diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 50da9bf..8d88584 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common support
-obj-y := common.o sram.o dma.o fb.o counter_32k.o
+obj-y := sram.o dma.o fb.o counter_32k.o
 obj-m :=
 obj-n :=
 obj-  :=
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
deleted file mode 100644
index bf6cd80..0000000
--- a/arch/arm/plat-omap/common.c
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * linux/arch/arm/plat-omap/common.c
- *
- * Code common to all OMAP machines.
- * The file is created by Tony Lindgren <tony@atomide.com>
- *
- * Copyright (C) 2009 Texas Instruments
- * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/dma-mapping.h>
-
-#include <plat-omap/dma-omap.h>
-
-void __init omap_init_consistent_dma_size(void)
-{
-#ifdef CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE
-	init_consistent_dma_size(CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE << 20);
-#endif
-}
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index c288b76..00a3a53 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2146,6 +2146,14 @@ static struct platform_driver omap_system_dma_driver = {
 	},
 };
 
+/* This must be called from init_early() */
+void __init omap_init_consistent_dma_size(void)
+{
+#ifdef CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE
+	init_consistent_dma_size(CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE << 20);
+#endif
+}
+
 static int __init omap_system_dma_init(void)
 {
 	return platform_driver_register(&omap_system_dma_driver);

