From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 2/2] DSPBRIDGE: Fix header locations mach to plat
Date: Thu, 18 Mar 2010 15:57:09 -0600
Message-ID: <1268949429-30368-3-git-send-email-omar.ramirez@ti.com>
References: <1268949429-30368-1-git-send-email-omar.ramirez@ti.com>
 <1268949429-30368-2-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39251 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752311Ab0CRVmL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Mar 2010 17:42:11 -0400
In-Reply-To: <1268949429-30368-2-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, Guzman Lugo Fernando <x0095840@ti.com>, Hari Kanigeri <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Fix header locations, replaced mach to plat

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
Acked-by: Ameya Palande <ameya.palande@nokia.com>
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
index 92b12de..faf1aaa 100644
--- a/arch/arm/plat-omap/include/dspbridge/host_os.h
+++ b/arch/arm/plat-omap/include/dspbridge/host_os.h
@@ -43,7 +43,7 @@
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
 #include <dspbridge/dbtype.h>
-#include <mach/clock.h>
+#include <plat/clock.h>
 #include <linux/clk.h>
 #include <linux/pagemap.h>
 #include <asm/cacheflush.h>
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 949279d..b49a965 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -24,7 +24,7 @@
 #include <mach-omap2/cm.h>
 #include <mach-omap2/prm-regbits-34xx.h>
 #include <mach-omap2/cm-regbits-34xx.h>
-#include <mach/control.h>
+#include <plat/control.h>
 
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
-- 
1.6.2.4

