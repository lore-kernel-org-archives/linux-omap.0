From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 5/5] omap iommu: entries for Kconfig and Makefile
Date: Tue, 25 Nov 2008 17:37:38 +0200
Message-ID: <1227627458-24412-6-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1227627458-24412-1-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227627458-24412-2-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227627458-24412-3-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227627458-24412-4-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227627458-24412-5-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:22788 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbYKYPh7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 10:37:59 -0500
In-Reply-To: <1227627458-24412-5-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, tony@atomide.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/Kconfig  |    8 ++++++++
 arch/arm/plat-omap/Makefile |    1 +
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 960c13f..b3d6e13 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -174,6 +174,14 @@ config OMAP_MMU_FWK
 	  Say Y here if you want to use OMAP MMU framework support for
 	  DSP, IVA1.0 and Camera in OMAP1/2.
 
+config OMAP_IOMMU
+	tristate "IOMMU support"
+	depends on ARCH_OMAP
+	default n
+	help
+	  Say Y here if you want to use OMAP IOMMU support for IVA2 and
+	  Camera in OMAP3.
+
 config OMAP_MBOX_FWK
 	tristate "Mailbox framework support"
 	depends on ARCH_OMAP
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 1259846..b354548 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_I2C_OMAP) += i2c.o
 
 # OMAP MMU framework
 obj-$(CONFIG_OMAP_MMU_FWK) += mmu.o
+obj-$(CONFIG_OMAP_IOMMU) += iommu.o iovmm.o iommu-sysfs.o
 
 # OMAP mailbox framework
 obj-$(CONFIG_OMAP_MBOX_FWK) += mailbox.o
-- 
1.6.0.3.613.g9f8f13

