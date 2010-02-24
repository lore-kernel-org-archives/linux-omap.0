From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH] OMAP: pass the reboot command to the boot loader
Date: Wed, 24 Feb 2010 15:14:07 +0200
Message-ID: <1267017247-18463-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:50499 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756951Ab0BXNMa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Feb 2010 08:12:30 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com

This patch follows the commit be093beb608edf821b45fe00a8a080fb5c6ed4af
by Russell King:

  OMAP wishes to pass state to the boot loader upon reboot in order
  to instruct it whether to wait for USB-based reflashing or not.
  There is already a facility to do this via the reboot() syscall,
  except we ignore the string passed to machine_restart().

The patch adds the missing parameter to omap1_arch_reset() and
omap_prcm_arch_reset(), and modifies the latter to pass the reboot
command parameter to the boot loader instead of reboot mode (which is
for kernel internal use only and cannot be modified by the userspace).

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/prcm.c               |    4 ++--
 arch/arm/plat-omap/include/plat/prcm.h   |    2 +-
 arch/arm/plat-omap/include/plat/system.h |    6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 338d5f6..0850bb9 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -131,7 +131,7 @@ u32 omap_prcm_get_reset_sources(void)
 EXPORT_SYMBOL(omap_prcm_get_reset_sources);
 
 /* Resets clock rates and reboots the system. Only called from system.h */
-void omap_prcm_arch_reset(char mode)
+void omap_prcm_arch_reset(char mode, const char *cmd)
 {
 	s16 prcm_offs;
 
@@ -143,7 +143,7 @@ void omap_prcm_arch_reset(char mode)
 		u32 l;
 
 		prcm_offs = OMAP3430_GR_MOD;
-		l = ('B' << 24) | ('M' << 16) | mode;
+		l = ('B' << 24) | ('M' << 16) | (cmd ? (u8)*cmd : 0);
 		/* Reserve the first word in scratchpad for communicating
 		 * with the boot ROM. A pointer to a data structure
 		 * describing the boot process can be stored there,
diff --git a/arch/arm/plat-omap/include/plat/prcm.h b/arch/arm/plat-omap/include/plat/prcm.h
index 66938a9..2c89542 100644
--- a/arch/arm/plat-omap/include/plat/prcm.h
+++ b/arch/arm/plat-omap/include/plat/prcm.h
@@ -24,7 +24,7 @@
 #define __ASM_ARM_ARCH_OMAP_PRCM_H
 
 u32 omap_prcm_get_reset_sources(void);
-void omap_prcm_arch_reset(char mode);
+void omap_prcm_arch_reset(char mode, const char *cmd);
 int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, const char *name);
 
 #define START_PADCONF_SAVE 0x2
diff --git a/arch/arm/plat-omap/include/plat/system.h b/arch/arm/plat-omap/include/plat/system.h
index c58a4ef..d0a119f 100644
--- a/arch/arm/plat-omap/include/plat/system.h
+++ b/arch/arm/plat-omap/include/plat/system.h
@@ -22,7 +22,7 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void omap1_arch_reset(char mode)
+static inline void omap1_arch_reset(char mode, const char *cmd)
 {
 	/*
 	 * Workaround for 5912/1611b bug mentioned in sprz209d.pdf p. 28
@@ -43,9 +43,9 @@ static inline void omap1_arch_reset(char mode)
 static inline void arch_reset(char mode, const char *cmd)
 {
 	if (!cpu_class_is_omap2())
-		omap1_arch_reset(mode);
+		omap1_arch_reset(mode, cmd);
 	else
-		omap_prcm_arch_reset(mode);
+		omap_prcm_arch_reset(mode, cmd);
 }
 
 #endif
-- 
1.5.6.5

