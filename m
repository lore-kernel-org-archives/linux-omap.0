From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 11/11] OMAP3: control/PM: move padconf save code to
	mach-omap2/control.c
Date: Tue, 07 Dec 2010 23:18:45 -0700
Message-ID: <20101208061844.30541.27788.stgit@twilight.localdomain>
References: <20101208061657.30541.79824.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37207 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243Ab0LHGT5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 01:19:57 -0500
In-Reply-To: <20101208061657.30541.79824.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

Move the padconf save code from pm34xx.c to the System Control Module
code in mach-omap2/control.c.  This is part of the general push to
move direct register access from middle-layer core code to low-level
core code, so the middle-layer code can be abstracted to work on
multiple platforms and cleaned up.

In the medium-to-long term, this code should be called by the mux
layer code, not the PM idle code.  This is because, according to the
TRM, saving the padconf only needs to be done when the padconf
changes[1].

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>

1. OMAP34xx Multimedia Device Silicon Revision 3.1.x [Rev. ZH] [SWPU222H]
   Section 4.11.4 "Device Off-Mode Sequences"
---
 arch/arm/mach-omap2/control.c          |   32 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/control.h          |    1 +
 arch/arm/mach-omap2/pm34xx.c           |   11 +----------
 arch/arm/plat-omap/include/plat/prcm.h |    3 ---
 4 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 16bde76..891df18 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -26,6 +26,10 @@
 #include "pm.h"
 #include "control.h"
 
+/* Used by omap3_ctrl_save_padconf() */
+#define START_PADCONF_SAVE		0x2
+#define PADCONF_SAVE_DONE		0x1
+
 static void __iomem *omap2_ctrl_base;
 static void __iomem *omap4_ctrl_pad_base;
 
@@ -512,4 +516,32 @@ void omap3_control_restore_context(void)
 			 OMAP343X_CONTROL_PADCONF_SYSNIRQ);
 	return;
 }
+
+/**
+ * omap3_ctrl_save_padconf - save padconf registers to scratchpad RAM
+ *
+ * Tell the SCM to start saving the padconf registers, then wait for
+ * the process to complete.  Returns 0 unconditionally, although it
+ * should also eventually be able to return -ETIMEDOUT, if the save
+ * does not complete.
+ *
+ * XXX This function is missing a timeout.  What should it be?
+ */
+int omap3_ctrl_save_padconf(void)
+{
+	u32 cpo;
+
+	/* Save the padconf registers */
+	cpo = omap_ctrl_readl(OMAP343X_CONTROL_PADCONF_OFF);
+	cpo |= START_PADCONF_SAVE;
+	omap_ctrl_writel(cpo, OMAP343X_CONTROL_PADCONF_OFF);
+
+	/* wait for the save to complete */
+	while (!(omap_ctrl_readl(OMAP343X_CONTROL_GENERAL_PURPOSE_STATUS)
+		 & PADCONF_SAVE_DONE))
+		udelay(1);
+
+	return 0;
+}
+
 #endif /* CONFIG_ARCH_OMAP3 && CONFIG_PM */
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index a9325ad..5289461 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -351,6 +351,7 @@ extern u32 omap3_arm_context[128];
 extern void omap3_control_save_context(void);
 extern void omap3_control_restore_context(void);
 extern void omap3_ctrl_write_boot_mode(u8 bootmode);
+extern int omap3_ctrl_save_padconf(void);
 
 #else
 #define omap_ctrl_base_get()		0
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index e804a9f..be755a6 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -117,16 +117,7 @@ static void omap3_disable_io_chain(void)
 
 static void omap3_core_save_context(void)
 {
-	u32 control_padconf_off;
-
-	/* Save the padconf registers */
-	control_padconf_off = omap_ctrl_readl(OMAP343X_CONTROL_PADCONF_OFF);
-	control_padconf_off |= START_PADCONF_SAVE;
-	omap_ctrl_writel(control_padconf_off, OMAP343X_CONTROL_PADCONF_OFF);
-	/* wait for the save to complete */
-	while (!(omap_ctrl_readl(OMAP343X_CONTROL_GENERAL_PURPOSE_STATUS)
-			& PADCONF_SAVE_DONE))
-		udelay(1);
+	omap3_ctrl_save_padconf();
 
 	/*
 	 * Force write last pad into memory, as this can fail in some
diff --git a/arch/arm/plat-omap/include/plat/prcm.h b/arch/arm/plat-omap/include/plat/prcm.h
index 078906d..2fdf8c8 100644
--- a/arch/arm/plat-omap/include/plat/prcm.h
+++ b/arch/arm/plat-omap/include/plat/prcm.h
@@ -32,9 +32,6 @@ void omap_prcm_arch_reset(char mode, const char *cmd);
 int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, u8 idlest,
 			 const char *name);
 
-#define START_PADCONF_SAVE 0x2
-#define PADCONF_SAVE_DONE  0x1
-
 #endif
 
 


