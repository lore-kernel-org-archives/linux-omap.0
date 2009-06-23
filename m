From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH v2] ARM: MACH-OMAP2: Cleanup Kconfig entries
Date: Tue, 23 Jun 2009 08:57:56 -0500
Message-ID: <A24693684029E5489D1D202277BE8944413077E4@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42266 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759468AbZFWN4H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Jun 2009 09:56:07 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5NDu50h003529
	for <linux-omap@vger.kernel.org>; Tue, 23 Jun 2009 08:56:10 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id n5NDu5OD007680
	for <linux-omap@vger.kernel.org>; Tue, 23 Jun 2009 08:56:05 -0500 (CDT)
Received: from dsbe71.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id n5NDu4wG025602
	for <linux-omap@vger.kernel.org>; Tue, 23 Jun 2009 08:56:04 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

>From b028b5cff910826972a15d438de9ca6f47104f31 Mon Sep 17 00:00:00 2001
From: Sergio Aguirre <saaguirre@ti.com>
Date: Tue, 23 Jun 2009 08:46:21 -0500
Subject: [PATCH v2] ARM: MACH-OMAP2: Cleanup Kconfig entries

This patch removes some duplicate entries, and intents to cleanup
the order.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/Kconfig |   41 +++++++++++++++--------------------------
 1 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index bfb36e2..d4bb8ed 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -109,22 +109,30 @@ config MACH_OMAP_2430SDP
 	bool "OMAP 2430 SDP board"
 	depends on ARCH_OMAP2 && ARCH_OMAP2430
 
-config MACH_OMAP_LDP
-	bool "OMAP3 LDP board"
+config MACH_OMAP_3430SDP
+	bool "OMAP 3430 SDP board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 
-config MACH_OMAP2EVM 
+config MACH_OMAP_4430SDP
+	bool "OMAP 4430 SDP board"
+	depends on ARCH_OMAP4
+
+config MACH_OMAP2EVM
 	bool "OMAP 2530 EVM board"
 	depends on ARCH_OMAP2 && ARCH_OMAP24XX
 
-config MACH_OMAP_3430SDP
-	bool "OMAP 3430 SDP board"
-	depends on ARCH_OMAP3 && ARCH_OMAP34XX
-
 config MACH_OMAP3EVM
 	bool "OMAP 3530 EVM board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 
+config MACH_OMAP_LDP
+	bool "OMAP3 LDP board"
+	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+
+config MACH_OMAP_ZOOM2
+	bool "OMAP3 Zoom2 board"
+	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+
 config MACH_OMAP3_BEAGLE
 	bool "OMAP3 BEAGLE board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
@@ -133,26 +141,7 @@ config MACH_OVERO
 	bool "Gumstix Overo board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 
-config MACH_OMAP3EVM
-	bool "OMAP 3530 EVM board"
-	depends on ARCH_OMAP3 && ARCH_OMAP34XX
-
 config MACH_OMAP3_PANDORA
 	bool "OMAP3 Pandora"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 
-config MACH_OMAP_3430SDP
-	bool "OMAP 3430 SDP board"
-	depends on ARCH_OMAP3 && ARCH_OMAP34XX
-
-config MACH_OMAP_ZOOM2
-	bool "OMAP3 Zoom2 board"
-	depends on ARCH_OMAP3 && ARCH_OMAP34XX
-
-config MACH_OMAP_ZOOM2
-	bool "OMAP3 Zoom2 board"
-	depends on ARCH_OMAP3 && ARCH_OMAP34XX
-
-config MACH_OMAP_4430SDP
-	bool "OMAP 4430 SDP board"
-	depends on ARCH_OMAP4
-- 
1.6.3.2

