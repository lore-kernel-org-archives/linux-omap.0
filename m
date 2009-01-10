From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 1/3] Add support for OMAP35x processors
Date: Sun, 11 Jan 2009 01:30:37 +0530
Message-ID: <1231617637-18704-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56561 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684AbZAJUAp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 Jan 2009 15:00:45 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n0AK0cCC010773
	for <linux-omap@vger.kernel.org>; Sat, 10 Jan 2009 14:00:44 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This patch adds basic support for the OMAP35x Applications Processors.
(See: http://focus.ti.com/general/docs/gencontent.tsp?contentId=46725)
  - OMAP3503
  - OMAP3515
  - OMAP3525
  - OMAP3530

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/Kconfig |   65 +++++++++++++++++++++++++++++++++++++++----
 1 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 0a86a88..2877def 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -28,6 +28,53 @@ config ARCH_OMAP3430
 	select ARCH_OMAP_OTG
 	select CPU_V7
 
+config ARCH_OMAP35XX
+	bool "OMAP35x Family"
+	select ARCH_OMAP3
+	select ARCH_OMAP34XX
+	select ARCH_OMAP3430
+	select NEON
+	help
+	  OMAP35x family of processors based on ARM Cortex-A8
+	  in combination with IVA2.2 core and OpenGL ES2.0
+	  compatible graphics engine.
+
+	  ARM Cortex-A8 contains NEON SIMD coprocessor.
+
+choice
+	prompt "Current choice"
+	default ARCH_OMAP3503
+
+config ARCH_OMAP3503
+	bool "OMAP3503"
+	depends on ARCH_OMAP35XX
+	help
+	  Contains ARM Cortex-A8 processor.
+
+config ARCH_OMAP3515
+	bool "OMAP3515"
+	depends on ARCH_OMAP35XX
+	help
+	   Contains ARM Cortex-A8 processor and SGX530 subsystem
+	   for 2D and 3D graphics acceleration.
+
+config ARCH_OMAP3525
+	bool "OMAP3525"
+	depends on ARCH_OMAP35XX
+	help
+	  Contains ARM Cortex-A8 processor and IVA2.2 subsystem
+	  with a C64x+ DSP core.
+
+config ARCH_OMAP3530
+	bool "OMAP3530"
+	depends on ARCH_OMAP35XX
+	help
+	   Contains ARM Cortex-A8 processor, IVA2.2 subsystem
+	   with a C64x+ DSP Core and SGX530 subsystem for 2D
+	   and 3D graphics acceleration.
+
+endchoice
+
 comment "OMAP Board Type"
 	depends on ARCH_OMAP2 || ARCH_OMAP3
 
@@ -105,21 +152,24 @@ config MACH_OMAP_2430SDP
 	bool "OMAP 2430 SDP board"
 	depends on ARCH_OMAP2 && ARCH_OMAP2430
 
-config MACH_OMAP_LDP
-	bool "OMAP3 LDP board"
-	depends on ARCH_OMAP3 && ARCH_OMAP34XX
-
 config MACH_OMAP2EVM 
 	bool "OMAP 2530 EVM board"
 	depends on ARCH_OMAP2 && ARCH_OMAP24XX
 
+choice
+	prompt "Choose board"
+
+config MACH_OMAP_LDP
+	bool "OMAP3 LDP board"
+	depends on ARCH_OMAP3 && ARCH_OMAP34XX && !ARCH_OMAP35XX
+
 config MACH_OMAP_3430SDP
 	bool "OMAP 3430 SDP board"
-	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+	depends on ARCH_OMAP3 && ARCH_OMAP34XX && !ARCH_OMAP35XX
 
 config MACH_OMAP3EVM
 	bool "OMAP 3530 EVM board"
-	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+	depends on ARCH_OMAP35XX
 
 config MACH_OMAP3_BEAGLE
 	bool "OMAP3 BEAGLE board"
@@ -132,3 +182,6 @@ config MACH_OVERO
 config MACH_OMAP3_PANDORA
 	bool "OMAP3 Pandora"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+
+endchoice
+
-- 
1.5.6
