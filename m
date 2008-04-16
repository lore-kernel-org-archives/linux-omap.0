From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: [PATCH 1/9] Re-arranging OMAP2 and OMAP3 boards
Date: Wed, 16 Apr 2008 17:34:07 +0530
Message-ID: <7EAD1AEEA7621C45899FE99123E124A0018C8A6A@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35596 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758319AbYDPMEo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Apr 2008 08:04:44 -0400
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: discussion@beagleboard.org

Re-arranging OMAP2 and OMAP3 boards

Signed-off-by: Syed Mohammed Khasim <khasim@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: my_branch/arch/arm/mach-omap2/Kconfig
===================================================================
--- my_branch.orig/arch/arm/mach-omap2/Kconfig	2008-04-16 14:39:51.000000000 +0530
+++ my_branch/arch/arm/mach-omap2/Kconfig	2008-04-16 14:40:02.000000000 +0530
@@ -98,10 +98,11 @@
 	bool "OMAP 2430 SDP board"
 	depends on ARCH_OMAP2 && ARCH_OMAP2430
 
+config MACH_OMAP_2430OSK
+	bool "OMAP 2430 OSK board"
+	depends on ARCH_OMAP2 && ARCH_OMAP24XX
+
 config MACH_OMAP_3430SDP
 	bool "OMAP 3430 SDP board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 
-config MACH_OMAP_2430OSK
-	bool "OMAP 2430 OSK board"
-	depends on ARCH_OMAP2 && ARCH_OMAP24XX
