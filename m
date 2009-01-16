From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 5/6] omap iommu: entries for Kconfig and Makefile
Date: Fri, 16 Jan 2009 10:37:30 +0200
Message-ID: <20090116083730.18344.765.stgit@oreo.research.nokia.com>
References: <20090116083003.18344.38307.stgit@oreo.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:29329 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760669AbZAPIhm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 03:37:42 -0500
In-Reply-To: <20090116083003.18344.38307.stgit@oreo.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---

 arch/arm/plat-omap/Kconfig  |    8 ++++++++
 arch/arm/plat-omap/Makefile |    1 +
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 46d3b0b..bacdc32 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -104,6 +104,14 @@ config OMAP_MCBSP
 	  Say Y here if you want support for the OMAP Multichannel
 	  Buffered Serial Port.
 
+config OMAP_IOMMU
+	tristate "IOMMU support"
+	depends on ARCH_OMAP
+	default n
+	help
+	  Say Y here if you want to use OMAP IOMMU support for IVA2 and
+	  Camera in OMAP3.
+
 choice
         prompt "System timer"
 	default OMAP_MPU_TIMER
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index deaff58..e2453e2 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -13,6 +13,7 @@ obj-  :=
 obj-$(CONFIG_ARCH_OMAP16XX) += ocpi.o
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
+obj-$(CONFIG_OMAP_IOMMU) += iommu.o iovmm.o
 
 obj-$(CONFIG_CPU_FREQ) += cpu-omap.o
 obj-$(CONFIG_OMAP_DM_TIMER) += dmtimer.o

