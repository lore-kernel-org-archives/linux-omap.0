From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 4/9] OMAP2: Support for early device registration
Date: Sat, 29 May 2010 20:07:06 +0530
Message-ID: <1275143831-7629-5-git-send-email-thara@ti.com>
References: <1275143831-7629-1-git-send-email-thara@ti.com>
 <1275143831-7629-2-git-send-email-thara@ti.com>
 <1275143831-7629-3-git-send-email-thara@ti.com>
 <1275143831-7629-4-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35545 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756516Ab0E2OhV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 29 May 2010 10:37:21 -0400
In-Reply-To: <1275143831-7629-4-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, tony@atomide.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch adds a new API in the common boot up sequence to register
early drivers and probe for early devices. This API can be used by any
early device to register itself.
This patch also adds support to register "earlytimer" drivers and
probe for any associated devices that are registered as early devices.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/io.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 3bf1cb4..edf1146 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/omapfb.h>
+#include <linux/platform_device.h>
 
 #include <asm/tlb.h>
 
@@ -47,6 +48,8 @@
 #include "clockdomains.h"
 #include <plat/omap_hwmod.h>
 
+#include "dmtimers.h"
+
 /*
  * The machine specific code may provide the extra mapping besides the
  * default mapping provided here.
@@ -304,6 +307,16 @@ static int __init _omap2_init_reprogram_sdrc(void)
 	return v;
 }
 
+static void __init omap_init_early_devices(void)
+{
+	int timer_count;
+
+	early_platform_driver_register_all("earlytimer");
+	timer_count = omap2_get_early_timer_count();
+	early_platform_driver_probe("earlytimer", timer_count, 0);
+	/* Add any other early devices needed here */
+}
+
 void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 				 struct omap_sdrc_params *sdrc_cs1)
 {
@@ -341,4 +354,7 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 		_omap2_init_reprogram_sdrc();
 	}
 	gpmc_init();
+	omap2_dm_timer_early_init();
+	/* Call the probe for all early devices */
+	omap_init_early_devices();
 }
-- 
1.7.0.rc1.33.g07cf0f

