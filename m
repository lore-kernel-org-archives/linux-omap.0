From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 3/3] DSPBRIDGE: Use dspbridge to initialize platform data
Date: Fri, 15 Jan 2010 20:01:47 -0600
Message-ID: <1263607307-21693-4-git-send-email-omar.ramirez@ti.com>
References: <1263607307-21693-1-git-send-email-omar.ramirez@ti.com>
 <1263607307-21693-2-git-send-email-omar.ramirez@ti.com>
 <1263607307-21693-3-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42913 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932328Ab0APBwE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jan 2010 20:52:04 -0500
In-Reply-To: <1263607307-21693-3-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Include dspbridge compilation whenever bridge driver is selected to
be compiled, either as a module or part of the kernel. This will
initialize platform data specific PM functions.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index a37c713..1693c03 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -57,7 +57,9 @@ obj-$(CONFIG_OMAP_IOMMU)		+= $(iommu-y)
 # Debobs
 obj-$(CONFIG_OMAP3_DEBOBS)	+= debobs.o
 
-obj-$(CONFIG_MPU_BRIDGE)		+= dspbridge.o
+ifneq ($(CONFIG_MPU_BRIDGE),)
+obj-y					+= dspbridge.o
+endif
 
 # Specific board support
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
-- 
1.6.2.4

