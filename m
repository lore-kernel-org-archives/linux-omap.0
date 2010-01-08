From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 7/8] DSPBRIDGE: Fix header locations mach to plat
Date: Thu,  7 Jan 2010 19:00:55 -0600
Message-ID: <1262912455-30125-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38041 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754504Ab0AHAvp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jan 2010 19:51:45 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Fix header locations, replaced mach to plat

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/dspbridge.c                |    2 +-
 arch/arm/plat-omap/include/dspbridge/host_os.h |    2 +-
 drivers/dsp/bridge/wmd/tiomap3430.c            |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/dspbridge.c b/arch/arm/mach-omap2/dspbridge.c
index ea109a3..4150896 100644
--- a/arch/arm/mach-omap2/dspbridge.c
+++ b/arch/arm/mach-omap2/dspbridge.c
@@ -14,7 +14,7 @@
 #include <linux/platform_device.h>
 
 #ifdef CONFIG_BRIDGE_DVFS
-#include <mach/omap-pm.h>
+#include <plat/omap-pm.h>
 #endif
 
 #include <dspbridge/host_os.h>
diff --git a/arch/arm/plat-omap/include/dspbridge/host_os.h b/arch/arm/plat-omap/include/dspbridge/host_os.h
index 6fe1462..74cf6d4 100644
--- a/arch/arm/plat-omap/include/dspbridge/host_os.h
+++ b/arch/arm/plat-omap/include/dspbridge/host_os.h
@@ -54,7 +54,7 @@
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
 #include <dspbridge/dbtype.h>
-#include <mach/clock.h>
+#include <plat/clock.h>
 #include <linux/clk.h>
 #include <linux/pagemap.h>
 #include <asm/cacheflush.h>
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 7138396..b123707 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -34,7 +34,7 @@
 #include <mach-omap2/cm.h>
 #include <mach-omap2/prm-regbits-34xx.h>
 #include <mach-omap2/cm-regbits-34xx.h>
-#include <mach/control.h>
+#include <plat/control.h>
 
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
-- 
1.6.2.4

