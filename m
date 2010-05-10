From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH] omap iommu: Make CONFIG_OMAP_IOMMU_DEBUG selectable
Date: Mon, 10 May 2010 12:16:09 +0300
Message-ID: <1273482972-5586-6-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1273482972-5586-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:28032 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072Ab0EJJRD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 05:17:03 -0400
In-Reply-To: <1273482972-5586-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

This CONFIG_OMAP_IOMMU_DEBUG option cannot be selected because it's
not visible on menu. Make this option selectable.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/plat-omap/Kconfig |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 6da796e..78b49a6 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -110,8 +110,13 @@ config OMAP_IOMMU
 	tristate
 
 config OMAP_IOMMU_DEBUG
-	depends on OMAP_IOMMU
-	tristate
+       tristate "Export OMAP IOMMU internals in DebugFS"
+       depends on OMAP_IOMMU && DEBUG_FS
+       help
+         Select this to see extensive information about
+         the internal state of OMAP IOMMU in debugfs.
+
+         Say N unless you know you need this.
 
 choice
 	prompt "System timer"
-- 
1.7.1.rc1

