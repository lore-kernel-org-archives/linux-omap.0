From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/10] ARM: OMAP2: Fix _REGADDR macro offset calculations and cm.h for assembly
Date: Wed, 12 Mar 2008 12:45:41 +0200
Message-ID: <1205318750-9596-2-git-send-email-tony@atomide.com>
References: 34xx-2008-03-12
 <1205318750-9596-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:50616 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbYCLKqD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Mar 2008 06:46:03 -0400
In-Reply-To: <1205318750-9596-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

Make sure unexpected register offsets don't get calculated because of
(unlikely) macro parameter calculations. Also fix cm.h so it can be
included from assembly functions.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/cm.h         |   21 +++++++++++++++------
 arch/arm/mach-omap2/prm.h        |    3 ++-
 arch/arm/mach-omap2/sdrc.h       |   16 ++++++++++------
 include/asm-arm/arch-omap/sdrc.h |    4 ----
 4 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index 53cacc9..1a8f289 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -14,12 +14,19 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/kernel.h>
-#include <asm/io.h>
 #include "prcm_common.h"
 
-
-#define OMAP_CM_REGADDR(module, reg)	 (void __iomem *)IO_ADDRESS(OMAP2_CM_BASE + module + reg)
+#ifndef __ASSEMBLER__
+#define OMAP_CM_REGADDR(module, reg)					\
+	(void __iomem *)IO_ADDRESS(OMAP2_CM_BASE + (module) + (reg))
+#else
+#define OMAP2420_CM_REGADDR(module, reg)				\
+			IO_ADDRESS(OMAP2420_CM_BASE + (module) + (reg))
+#define OMAP2430_CM_REGADDR(module, reg)				\
+			IO_ADDRESS(OMAP2430_CM_BASE + (module) + (reg))
+#define OMAP34XX_CM_REGADDR(module, reg)				\
+			IO_ADDRESS(OMAP3430_CM_BASE + (module) + (reg))
+#endif
 
 /*
  * Architecture-specific global CM registers
@@ -32,7 +39,7 @@
 
 #define OMAP3430_CM_CLKOUT_CTRL		OMAP_CM_REGADDR(OMAP3430_CCR_MOD, 0x0070)
 
-
+#ifndef __ASSEMBLER__
 /* Clock management global register get/set */
 
 static void __attribute__((unused)) cm_write_reg(u32 val, void __iomem *addr)
@@ -46,7 +53,7 @@ static u32 __attribute__((unused)) cm_read_reg(void __iomem *addr)
 {
 	return __raw_readl(addr);
 }
-
+#endif
 
 /*
  * Module specific CM registers from CM_BASE + domain offset
@@ -86,6 +93,7 @@ static u32 __attribute__((unused)) cm_read_reg(void __iomem *addr)
 
 /* Clock management domain register get/set */
 
+#ifndef __ASSEMBLER__
 static void __attribute__((unused)) cm_write_mod_reg(u32 val, s16 module, s16 idx)
 {
 	cm_write_reg(val, OMAP_CM_REGADDR(module, idx));
@@ -95,6 +103,7 @@ static u32 __attribute__((unused)) cm_read_mod_reg(s16 module, s16 idx)
 {
 	return cm_read_reg(OMAP_CM_REGADDR(module, idx));
 }
+#endif
 
 /* CM register bits shared between 24XX and 3430 */
 
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index e090ab4..fd8c81d 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -19,7 +19,8 @@
 #include "prcm_common.h"
 
 
-#define OMAP_PRM_REGADDR(module, reg)	(void __iomem *)IO_ADDRESS(OMAP2_PRM_BASE + module + reg)
+#define OMAP_PRM_REGADDR(module, reg)					\
+	(void __iomem *)IO_ADDRESS(OMAP2_PRM_BASE + (module) + (reg))
 
 /*
  * Architecture-specific global PRM registers
diff --git a/arch/arm/mach-omap2/sdrc.h b/arch/arm/mach-omap2/sdrc.h
index dfc86f1..aa38621 100644
--- a/arch/arm/mach-omap2/sdrc.h
+++ b/arch/arm/mach-omap2/sdrc.h
@@ -15,15 +15,16 @@
  */
 #undef DEBUG
 
-#include <linux/kernel.h>
 #include <asm/arch/sdrc.h>
 
+#ifndef __ASSEMBLER__
 extern unsigned long omap2_sdrc_base;
 extern unsigned long omap2_sms_base;
 
-#define OMAP_SDRC_REGADDR(reg)	(void __iomem *)IO_ADDRESS(omap2_sdrc_base + reg)
-#define OMAP_SMS_REGADDR(reg)	(void __iomem *)IO_ADDRESS(omap2_sms_base + reg)
-
+#define OMAP_SDRC_REGADDR(reg)						\
+		(void __iomem *)IO_ADDRESS(omap2_sdrc_base + (reg))
+#define OMAP_SMS_REGADDR(reg)						\
+		(void __iomem *)IO_ADDRESS(omap2_sms_base + (reg))
 
 /* SDRC global register get/set */
 
@@ -54,7 +55,10 @@ static u32 __attribute__((unused)) sms_read_reg(u16 reg)
 {
 	return __raw_readl(OMAP_SMS_REGADDR(reg));
 }
-
-
+#else
+#define OMAP242X_SDRC_REGADDR(reg)	IO_ADDRESS(OMAP242X_SDRC_BASE + (reg))
+#define OMAP243X_SDRC_REGADDR(reg)	IO_ADDRESS(OMAP243X_SDRC_BASE + (reg))
+#define OMAP34XX_SDRC_REGADDR(reg)	IO_ADDRESS(OMAP343X_SDRC_BASE + (reg))
+#endif	/* __ASSEMBLER__ */
 
 #endif
diff --git a/include/asm-arm/arch-omap/sdrc.h b/include/asm-arm/arch-omap/sdrc.h
index 8f74097..673b396 100644
--- a/include/asm-arm/arch-omap/sdrc.h
+++ b/include/asm-arm/arch-omap/sdrc.h
@@ -16,10 +16,6 @@
 
 #include <asm/arch/io.h>
 
-#define OMAP242X_SDRC_REGADDR(reg)	(void __iomem *)IO_ADDRESS(OMAP242X_SDRC_BASE + reg)
-#define OMAP243X_SDRC_REGADDR(reg)	(void __iomem *)IO_ADDRESS(OMAP243X_SDRC_BASE + reg)
-#define OMAP343X_SDRC_REGADDR(reg)	(void __iomem *)IO_ADDRESS(OMAP343X_SDRC_BASE + reg)
-
 /* SDRC register offsets - read/write with sdrc_{read,write}_reg() */
 
 #define SDRC_SYSCONFIG		0x010
-- 
1.5.3.6

