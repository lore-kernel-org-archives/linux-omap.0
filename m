From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 1/3] Add support for OMAP35x processors
Date: Tue,  2 Sep 2008 01:27:45 +0530
Message-ID: <1220299067-17307-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52529 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751351AbYIAT56 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Sep 2008 15:57:58 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m81JvoKb030783
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 1 Sep 2008 14:57:57 -0500
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
---
 arch/arm/mach-omap2/Kconfig |   50 ++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 49 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 365b982..73e0726 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -25,6 +25,54 @@ config ARCH_OMAP3430
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 	select ARCH_OMAP_OTG
 
+config ARCH_OMAP35XX
+	bool "OMAP35x Family"
+	select ARCH_OMAP3
+	select ARCH_OMAP34XX
+	select ARCH_OMAP3430
+	select OMAP3430_ES2
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
 
@@ -117,7 +165,7 @@ config MACH_OMAP_3430SDP
 
 config MACH_OMAP3EVM
 	bool "OMAP 3530 EVM board"
-	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+	depends on ARCH_OMAP35XX
 
 config MACH_OMAP3_BEAGLE
 	bool "OMAP3 BEAGLE board"
-- 
1.5.6
