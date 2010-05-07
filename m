From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 3/5] omap iommu: Make CONFIG_OMAP_IOMMU_DEBUG selectable
Date: Fri,  7 May 2010 09:56:02 +0300
Message-ID: <1273215364-15098-3-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1273215364-15098-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:60125 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704Ab0EGG4j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 May 2010 02:56:39 -0400
In-Reply-To: <1273215364-15098-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: h-kanigeri2@ti.com, vimarsh.zutshi@nokia.com, Sakari.Ailus@nokia.com, david.cohen@nokia.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

This CONFIG_OMAP_IOMMU_DEBUG option cannot be selected because it's
not visible on menu. Put this option in "Kernel hacking" menu to make
this selectable.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/Kconfig.debug     |    8 ++++++++
 arch/arm/plat-omap/Kconfig |    4 ----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 91344af..43034c2 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -128,4 +128,12 @@ config DEBUG_S3C_UART
 	  The uncompressor code port configuration is now handled
 	  by CONFIG_S3C_LOWLEVEL_UART_PORT.
 
+config OMAP_IOMMU_DEBUG
+	tristate "Export OMAP IOMMU internals in DebugFS"
+	depends on OMAP_IOMMU && DEBUG_FS
+	help
+	  Select this to see extensive information about
+	  the internal state of OMAP IOMMU in debugfs.
+
+	  Say N unless you know you need this.
 endmenu
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 6da796e..28069ba 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -109,10 +109,6 @@ config OMAP_MBOX_FWK
 config OMAP_IOMMU
 	tristate
 
-config OMAP_IOMMU_DEBUG
-	depends on OMAP_IOMMU
-	tristate
-
 choice
 	prompt "System timer"
 	default OMAP_MPU_TIMER
-- 
1.7.1.rc1

