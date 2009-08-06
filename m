From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 2/6] OMAP3: Add OMAP35x processors - OMAP3505/17
Date: Thu,  6 Aug 2009 16:06:01 +0530
Message-ID: <1249554961-20345-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47022 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751249AbZHFKgI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Aug 2009 06:36:08 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n76Aa2bh026826
	for <linux-omap@vger.kernel.org>; Thu, 6 Aug 2009 05:36:08 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This patch adds the new devices in the OMAP35x family - OMAP3505
and OMAP3517. These devices differ in following areas:
 - Power management capabilities
 - EMIF4 instead of SDRC
 - Support for DDR2
 - EMAC
 - USB
 - HECC

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 0358b3d..cffd70f 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -43,6 +43,11 @@ config ARCH_OMAP35XX
 	    OMAP3525 - ARM Cortex-A8 + IVA2.2
 	    OMAP3530 - ARM Cortex-A8 + IVA2.2 + SGX
 
+	  These devices differ in the power management capabilities
+	  and specific IPs - USB, EMIF, EMAC, HECC, ...
+            OMAP3505 - ARM Cortex-A8
+            OMAP3517 - ARM Cortex-A8 + SGX
+
 	  ARM Cortex-A8 contains NEON SIMD coprocessor.
 
 comment "OMAP Board Type"
@@ -158,6 +163,10 @@ config MACH_OMAP_ZOOM2
 	bool "OMAP3 Zoom2 board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 
+config MACH_OMAP3517EVM
+	bool "OMAP 3517 EVM board"
+	depends on ARCH_OMAP35XX
+
 config MACH_OMAP_4430SDP
 	bool "OMAP 4430 SDP board"
 	depends on ARCH_OMAP4
-- 
1.6.2.2

