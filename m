From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 17/51] ARM: OMAP: convert reset to use arm_arch_reset (fwd)
Date: Fri, 28 Oct 2011 09:47:35 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110280947270.24690@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53842 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755491Ab1J1Prg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Oct 2011 11:47:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


fyi



- Paul

---------- Forwarded message ----------
Date: Fri, 28 Oct 2011 15:43:45 +0100
From: Will Deacon <will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, Will Deacon <will.deacon@arm.com>
Subject: [PATCH 17/51] ARM: OMAP: convert reset to use arm_arch_reset

From: Paul Walmsley <paul@pwsan.com>

Align the OMAP reset code with Will Deacon's "ARM: reset: introduce
arm_arch_reset function pointer" cleanup patch.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-omap1/board-voiceblue.c    |    2 +-
 arch/arm/mach-omap1/io.c                 |    4 ++++
 arch/arm/mach-omap1/reset.c              |    2 --
 arch/arm/mach-omap2/io.c                 |    7 ++++++-
 arch/arm/mach-omap2/prcm.c               |    4 +---
 arch/arm/plat-omap/include/plat/system.h |    6 +++++-
 6 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 036edc0e..e2a24a0 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -296,7 +296,7 @@ static void __init voiceblue_init(void)
 	omap_writeb(0x00, OMAP_LPG1_LCR);
 	omap_writeb(0x00, OMAP_LPG1_PMR);	/* Disable clock */
 
-	arch_reset = voiceblue_reset;
+	arm_arch_reset = voiceblue_reset;
 }
 
 MACHINE_START(VOICEBLUE, "VoiceBlue OMAP5910")
diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
index 870886a..d3b54da 100644
--- a/arch/arm/mach-omap1/io.c
+++ b/arch/arm/mach-omap1/io.c
@@ -15,8 +15,10 @@
 
 #include <asm/tlb.h>
 #include <asm/mach/map.h>
+#include <asm/system.h>
 #include <plat/mux.h>
 #include <plat/tc.h>
+#include <plat/system.h>
 
 #include "clock.h"
 
@@ -140,6 +142,8 @@ void __init omap1_init_common_hw(void)
 	omap1_clk_init();
 
 	omap1_mux_init();
+
+	arm_arch_reset = omap1_arch_reset;
 }
 
 /*
diff --git a/arch/arm/mach-omap1/reset.c b/arch/arm/mach-omap1/reset.c
index ad951ee..a5ed979 100644
--- a/arch/arm/mach-omap1/reset.c
+++ b/arch/arm/mach-omap1/reset.c
@@ -21,5 +21,3 @@ void omap1_arch_reset(char mode, const char *cmd)
 
 	omap_writew(1, ARM_RSTCT1);
 }
-
-void (*arch_reset)(char, const char *) = omap1_arch_reset;
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 2ce1ce6..b94e1a2 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -31,6 +31,7 @@
 #include <plat/sram.h>
 #include <plat/sdrc.h>
 #include <plat/serial.h>
+#include <plat/system.h>
 
 #include "clock2xxx.h"
 #include "clock3xxx.h"
@@ -44,6 +45,8 @@
 #include <plat/omap_hwmod.h>
 #include <plat/multi.h>
 
+#include "prcm-common.h"
+
 /*
  * The machine specific code may provide the extra mapping besides the
  * default mapping provided here.
@@ -358,7 +361,9 @@ void __init omap2_init_common_infrastructure(void)
 		omap44xx_hwmod_init();
 	} else {
 		pr_err("Could not init hwmod data - unknown SoC\n");
-        }
+	}
+
+	arm_arch_reset = omap_prcm_arch_reset;
 
 	/* Set the default postsetup state for all hwmods */
 #ifdef CONFIG_PM_RUNTIME
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 2e40a5c..ad3ac5c 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -58,7 +58,7 @@ u32 omap_prcm_get_reset_sources(void)
 EXPORT_SYMBOL(omap_prcm_get_reset_sources);
 
 /* Resets clock rates and reboots the system. Only called from system.h */
-static void omap_prcm_arch_reset(char mode, const char *cmd)
+void omap_prcm_arch_reset(char mode, const char *cmd)
 {
 	s16 prcm_offs = 0;
 
@@ -109,8 +109,6 @@ static void omap_prcm_arch_reset(char mode, const char *cmd)
 	omap2_prm_read_mod_reg(prcm_offs, OMAP2_RM_RSTCTRL); /* OCP barrier */
 }
 
-void (*arch_reset)(char, const char *) = omap_prcm_arch_reset;
-
 /**
  * omap2_cm_wait_idlest - wait for IDLEST bit to indicate module readiness
  * @reg: physical address of module IDLEST register
diff --git a/arch/arm/plat-omap/include/plat/system.h b/arch/arm/plat-omap/include/plat/system.h
index c5fa9e9..ac32d88 100644
--- a/arch/arm/plat-omap/include/plat/system.h
+++ b/arch/arm/plat-omap/include/plat/system.h
@@ -12,6 +12,10 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-extern void (*arch_reset)(char, const char *);
+/* To be removed in a future ARM-wide cleanup */
+static inline void arch_reset(char mode, const char *cmd) {}
+
+extern void omap1_arch_reset(char mode, const char *cmd);
+extern void omap_prcm_arch_reset(char mode, const char *cmd);
 
 #endif
-- 
1.7.4.1
