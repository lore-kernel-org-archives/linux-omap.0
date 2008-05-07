From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/5] fix sparse, checkpatch warnings in OMAP2/3 SCM code
Date: Wed, 07 May 2008 11:52:02 -0600
Message-ID: <20080507175202.17732.27747.stgit@localhost.localdomain>
References: <20080507171204.17732.97601.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47801 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757135AbYEGTun (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 May 2008 15:50:43 -0400
In-Reply-To: <20080507171204.17732.97601.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Fix sparse warnings with the OMAP2 SCM code. Involves tagging
appropriate pointer<->integer type conversions with __force.  Also fix
a checkpatch warning re: conversion of asm/ includes to linux/.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/control.c       |   13 ++++++-------
 include/asm-arm/arch-omap/control.h |   16 ++++++++--------
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index a5d86a4..400114b 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -13,15 +13,14 @@
 #undef DEBUG
 
 #include <linux/kernel.h>
-
-#include <asm/io.h>
+#include <linux/io.h>
 
 #include <asm/arch/control.h>
 
 static u32 omap2_ctrl_base;
 
-#define OMAP_CTRL_REGADDR(reg)	(void __iomem *)IO_ADDRESS(omap2_ctrl_base \
-								+ (reg))
+#define OMAP_CTRL_REGADDR(reg)					\
+	(__force void __iomem *)IO_ADDRESS(omap2_ctrl_base + (reg))
 
 void omap_ctrl_base_set(u32 base)
 {
@@ -51,7 +50,7 @@ u32 omap_ctrl_readl(u16 offset)
 void omap_ctrl_writeb(u8 val, u16 offset)
 {
 	pr_debug("omap_ctrl_writeb: writing 0x%0x to 0x%0x\n", val,
-		 (u32)OMAP_CTRL_REGADDR(offset));
+		 (__force u32)OMAP_CTRL_REGADDR(offset));
 
 	__raw_writeb(val, OMAP_CTRL_REGADDR(offset));
 }
@@ -59,7 +58,7 @@ void omap_ctrl_writeb(u8 val, u16 offset)
 void omap_ctrl_writew(u16 val, u16 offset)
 {
 	pr_debug("omap_ctrl_writew: writing 0x%0x to 0x%0x\n", val,
-		 (u32)OMAP_CTRL_REGADDR(offset));
+		 (__force u32)OMAP_CTRL_REGADDR(offset));
 
 	__raw_writew(val, OMAP_CTRL_REGADDR(offset));
 }
@@ -67,7 +66,7 @@ void omap_ctrl_writew(u16 val, u16 offset)
 void omap_ctrl_writel(u32 val, u16 offset)
 {
 	pr_debug("omap_ctrl_writel: writing 0x%0x to 0x%0x\n", val,
-		 (u32)OMAP_CTRL_REGADDR(offset));
+		 (__force u32)OMAP_CTRL_REGADDR(offset));
 
 	__raw_writel(val, OMAP_CTRL_REGADDR(offset));
 }
diff --git a/include/asm-arm/arch-omap/control.h b/include/asm-arm/arch-omap/control.h
index 9944bb5..abecbd9 100644
--- a/include/asm-arm/arch-omap/control.h
+++ b/include/asm-arm/arch-omap/control.h
@@ -1,13 +1,10 @@
-#ifndef __ASM_ARCH_CONTROL_H
-#define __ASM_ARCH_CONTROL_H
-
 /*
  * include/asm-arm/arch-omap/control.h
  *
  * OMAP2/3 System Control Module definitions
  *
- * Copyright (C) 2007 Texas Instruments, Inc.
- * Copyright (C) 2007 Nokia Corporation
+ * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * Copyright (C) 2007-2008 Nokia Corporation
  *
  * Written by Paul Walmsley
  *
@@ -16,14 +13,17 @@
  * the Free Software Foundation.
  */
 
+#ifndef __ASM_ARCH_CONTROL_H
+#define __ASM_ARCH_CONTROL_H
+
 #include <asm/arch/io.h>
 
 #define OMAP242X_CTRL_REGADDR(reg)					\
-	(void __iomem *)IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
+	(__force void __iomem *)IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
 #define OMAP243X_CTRL_REGADDR(reg)					\
-	(void __iomem *)IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
+	(__force void __iomem *)IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
 #define OMAP343X_CTRL_REGADDR(reg)					\
-	(void __iomem *)IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
+	(__force void __iomem *)IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
 
 /*
  * As elsewhere, the "OMAP2_" prefix indicates that the macro is valid for


