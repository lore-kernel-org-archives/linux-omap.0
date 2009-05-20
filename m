From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 6/7] omap2 iommu: entries for Kconfig and Makefile
Date: Wed, 20 May 2009 09:42:37 +0300
Message-ID: <20090520064237.24734.65782.stgit@oreo.research.nokia.com>
References: <20090520064211.24734.80725.stgit@oreo.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:17907 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbZETGnL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 02:43:11 -0400
In-Reply-To: <20090520064211.24734.80725.stgit@oreo.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com, omar.ramirez@ti.com, sakari.ailus@maxwell.research.nokia.com, tony@atomide.com

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---

 arch/arm/mach-omap2/Makefile |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index c49d9bf..88629a7 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -28,6 +28,11 @@ endif
 obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o
 
+iommu-y					+= iommu2.o
+iommu-$(CONFIG_ARCH_OMAP3)		+= omap3-iommu.o
+
+obj-$(CONFIG_OMAP_IOMMU)		+= $(iommu-y)
+
 # Specific board support
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
 obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o

