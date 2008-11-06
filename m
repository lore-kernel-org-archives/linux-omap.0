From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 5/5] omap iommu: entries for Kconfig and Makefile
Date: Thu,  6 Nov 2008 10:29:10 +0200
Message-ID: <1225960150-15837-5-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1225960150-15837-1-git-send-email-Hiroshi.DOYU@nokia.com>
 <1225960150-15837-2-git-send-email-Hiroshi.DOYU@nokia.com>
 <1225960150-15837-3-git-send-email-Hiroshi.DOYU@nokia.com>
 <1225960150-15837-4-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:42789 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbYKFI3X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2008 03:29:23 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mA68SxwW019067
	for <linux-omap@vger.kernel.org>; Thu, 6 Nov 2008 10:29:20 +0200
Received: from oreo.research.nokia.com (esdhcp04130.research.nokia.com [172.21.41.30])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id mA68TBKA023288
	for <linux-omap@vger.kernel.org>; Thu, 6 Nov 2008 10:29:11 +0200
In-Reply-To: <1225960150-15837-4-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/Kconfig  |    8 ++++++++
 arch/arm/plat-omap/Makefile |    1 +
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 4df57d5..76bf4e7 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -174,6 +174,14 @@ config OMAP_MMU_FWK
 	  Say Y here if you want to use OMAP MMU framework support for
 	  DSP, IVA1.0 and Camera in OMAP1/2.
 
+config OMAP_IOMMU
+	bool "IOMMU support"
+	depends on ARCH_OMAP
+	default n
+	help
+	  Say Y here if you want to use OMAP MMU framework support for
+	  IVA2 and Camera in OMAP3.
+
 config OMAP_MBOX_FWK
 	tristate "Mailbox framework support"
 	depends on ARCH_OMAP
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 8e4ba1c..13946b3 100644
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

