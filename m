From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 5/7] omap iommu: entries for Kconfig and Makefile
Date: Wed, 20 May 2009 09:42:32 +0300
Message-ID: <20090520064232.24734.19153.stgit@oreo.research.nokia.com>
References: <20090520064211.24734.80725.stgit@oreo.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:17881 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220AbZETGnA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 02:43:00 -0400
In-Reply-To: <20090520064211.24734.80725.stgit@oreo.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com, omar.ramirez@ti.com, sakari.ailus@maxwell.research.nokia.com, tony@atomide.com

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---

 arch/arm/plat-omap/Kconfig  |    6 ++++++
 arch/arm/plat-omap/Makefile |    1 +
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 9dd68fa..30e47a3 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -115,6 +115,12 @@ config OMAP_MBOX_FWK
 	  Say Y here if you want to use OMAP Mailbox framework support for
 	  DSP, IVA1.0 and IVA2 in OMAP1/2/3.
 
+config OMAP_IOMMU
+	tristate "IOMMU support"
+	help
+	  Say Y here if you want to use OMAP IOMMU support for IVA2 and
+	  Camera in OMAP3.
+
 choice
         prompt "System timer"
 	default OMAP_MPU_TIMER
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 04a100c..a832795 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -13,6 +13,7 @@ obj-  :=
 obj-$(CONFIG_ARCH_OMAP16XX) += ocpi.o
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
+obj-$(CONFIG_OMAP_IOMMU) += iommu.o iovmm.o
 
 obj-$(CONFIG_CPU_FREQ) += cpu-omap.o
 obj-$(CONFIG_OMAP_DM_TIMER) += dmtimer.o

