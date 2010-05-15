From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH] OMAP3: musb: remove unneeded include files
Date: Sat, 15 May 2010 11:34:15 +0530
Message-ID: <1273903455-8793-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34720 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335Ab0EOGEW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 15 May 2010 02:04:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.balbi@nokia.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Removed include files from usb-musb.c which were not required.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
Patch created against latest linux-omap/master.

 arch/arm/mach-omap2/usb-musb.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 63104dd..1929f3b 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -16,19 +16,11 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/delay.h>
 #include <linux/platform_device.h>
-#include <linux/clk.h>
 #include <linux/dma-mapping.h>
-#include <linux/io.h>
-
 #include <linux/usb/musb.h>
 
-#include <mach/hardware.h>
 #include <mach/irqs.h>
-#include <plat/mux.h>
 #include <plat/usb.h>
 
 #ifdef CONFIG_USB_MUSB_SOC
-- 
1.6.2.4

