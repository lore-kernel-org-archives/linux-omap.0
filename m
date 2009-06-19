From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH] ARM: MACH-OMAP2: Cleanup Kconfig entries
Date: Fri, 19 Jun 2009 09:54:34 -0500
Message-ID: <A24693684029E5489D1D202277BE8944411FC323@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50129 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709AbZFSOwy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Jun 2009 10:52:54 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5JEqpfp011869
	for <linux-omap@vger.kernel.org>; Fri, 19 Jun 2009 09:52:56 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id n5JEqpvf000664
	for <linux-omap@vger.kernel.org>; Fri, 19 Jun 2009 09:52:51 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id n5JEqoPJ028531
	for <linux-omap@vger.kernel.org>; Fri, 19 Jun 2009 09:52:50 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 9258708325e0a04de7d7503b65cabc25860a9e7d Mon Sep 17 00:00:00 2001
From: Sergio Aguirre <saaguirre@ti.com>
Date: Fri, 19 Jun 2009 09:50:52 -0500
Subject: [PATCH] ARM: MACH-OMAP2: Cleanup Kconfig entries

This patch removes some duplicate entries, and intents to cleanup
the order.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/Kconfig |   38 ++++++++++++++------------------------
 1 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index bfb36e2..caf5144 100644
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
 
+config MACH_OMAP_4430SDP
+	bool "OMAP 4430 SDP board"
+	depends on ARCH_OMAP4
+
 config MACH_OMAP2EVM 
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
@@ -133,26 +141,8 @@ config MACH_OVERO
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

