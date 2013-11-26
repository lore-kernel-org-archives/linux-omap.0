From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 08/12] ARM: OMAP2+: Remove legacy muxing for usb-tusb6010.c
Date: Mon, 25 Nov 2013 16:14:23 -0800
Message-ID: <1385424867-27243-9-git-send-email-tony@atomide.com>
References: <1385424867-27243-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:30237 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753622Ab3KZAOh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Nov 2013 19:14:37 -0500
In-Reply-To: <1385424867-27243-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

We are moving to device tree based booting, and this should be
done using pinctrl-single instead.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/usb-tusb6010.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
index e832bc7..99ee036 100644
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -22,8 +22,6 @@
 
 #include "gpmc.h"
 
-#include "mux.h"
-
 static u8		async_cs, sync_cs;
 static unsigned		refclk_psec;
 
@@ -227,25 +225,6 @@ tusb6010_setup_interface(struct musb_hdrc_platform_data *data,
 	}
 	tusb_device.dev.platform_data = data;
 
-	/* REVISIT let the driver know what DMA channels work */
-	if (!dmachan)
-		tusb_device.dev.dma_mask = NULL;
-	else {
-		/* assume OMAP 2420 ES2.0 and later */
-		if (dmachan & (1 << 0))
-			omap_mux_init_signal("sys_ndmareq0", 0);
-		if (dmachan & (1 << 1))
-			omap_mux_init_signal("sys_ndmareq1", 0);
-		if (dmachan & (1 << 2))
-			omap_mux_init_signal("sys_ndmareq2", 0);
-		if (dmachan & (1 << 3))
-			omap_mux_init_signal("sys_ndmareq3", 0);
-		if (dmachan & (1 << 4))
-			omap_mux_init_signal("sys_ndmareq4", 0);
-		if (dmachan & (1 << 5))
-			omap_mux_init_signal("sys_ndmareq5", 0);
-	}
-
 	/* so far so good ... register the device */
 	status = platform_device_register(&tusb_device);
 	if (status < 0) {
-- 
1.8.1.1

