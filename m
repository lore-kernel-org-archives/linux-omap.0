From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 6/8] DSPBRIDGE: Use dspbridge to initialize platform data
Date: Thu,  7 Jan 2010 19:00:50 -0600
Message-ID: <1262912450-30100-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38038 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754497Ab0AHAvk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jan 2010 19:51:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Include dspbridge compilation whenever bridge driver is selected to
be compiled, either as a module or part of the kernel. This will
initialize platform data specific PM functions.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index d1cf986..0881470 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -75,7 +75,9 @@ obj-y					+= $(i2c-omap-m) $(i2c-omap-y)
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

