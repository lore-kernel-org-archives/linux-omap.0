From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 1/6] OMAP3: Add OMAP35x processors - OMAP3503/15/25/30
Date: Thu,  6 Aug 2009 16:05:54 +0530
Message-ID: <1249554954-20227-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36685 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447AbZHFKgA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Aug 2009 06:36:00 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n76AZtxN008512
	for <linux-omap@vger.kernel.org>; Thu, 6 Aug 2009 05:36:01 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This patch adds the OMAP35x Applications Processors - OMAP3503,
OMAP3515, OMAP3525 and OMAP3530 - to the kernel configuration.

It also updates the dependency of OMAP3EVM board.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/Kconfig |   27 ++++++++++++++++++++++-----
 1 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 225829e..0358b3d 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -28,6 +28,23 @@ config ARCH_OMAP3430
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
+	    OMAP3503 - ARM Cortex-A8
+	    OMAP3515 - ARM Cortex-A8 + SGX
+	    OMAP3525 - ARM Cortex-A8 + IVA2.2
+	    OMAP3530 - ARM Cortex-A8 + IVA2.2 + SGX
+
+	  ARM Cortex-A8 contains NEON SIMD coprocessor.
+
 comment "OMAP Board Type"
 	depends on ARCH_OMAP2 || ARCH_OMAP3 || ARCH_OMAP4
 
@@ -109,21 +126,21 @@ config MACH_OMAP_2430SDP
 	bool "OMAP 2430 SDP board"
 	depends on ARCH_OMAP2 && ARCH_OMAP2430
 
-config MACH_OMAP_LDP
-	bool "OMAP3 LDP board"
-	depends on ARCH_OMAP3 && ARCH_OMAP34XX
-
 config MACH_OMAP2EVM 
 	bool "OMAP 2530 EVM board"
 	depends on ARCH_OMAP2 && ARCH_OMAP24XX
 
+config MACH_OMAP_LDP
+	bool "OMAP3 LDP board"
+	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+
 config MACH_OMAP_3430SDP
 	bool "OMAP 3430 SDP board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 
 config MACH_OMAP3EVM
 	bool "OMAP 3530 EVM board"
-	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+	depends on ARCH_OMAP35XX
 
 config MACH_OMAP3_BEAGLE
 	bool "OMAP3 BEAGLE board"
-- 
1.6.2.2

