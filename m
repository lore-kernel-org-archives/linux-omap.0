From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 08/23] USB: MUSB: checkpatch.pl fixes to davinci.c
Date: Fri, 11 Apr 2008 11:28:21 +0300
Message-ID: <1207902516-6374-9-git-send-email-felipe.balbi@nokia.com>
References: <1207902516-6374-1-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-2-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-3-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-4-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-5-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-6-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-7-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-8-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:40283 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757502AbYDKIaK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 04:30:10 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3B8TkB0030754
	for <linux-omap@vger.kernel.org>; Fri, 11 Apr 2008 03:32:27 -0500
In-Reply-To: <1207902516-6374-8-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Misc cleanup patch.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/davinci.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
index 3477800..acd2aa8 100644
--- a/drivers/usb/musb/davinci.c
+++ b/drivers/usb/musb/davinci.c
@@ -29,8 +29,8 @@
 #include <linux/list.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
+#include <linux/io.h>
 
-#include <asm/io.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/memory.h>
 #include <asm/arch/gpio.h>
@@ -38,7 +38,6 @@
 
 #include "musb_core.h"
 
-
 #ifdef CONFIG_MACH_DAVINCI_EVM
 #include <asm/arch/i2c-client.h>
 #endif
@@ -93,7 +92,7 @@ void musb_platform_enable(struct musb *musb)
 
 	if (is_dma_capable() && !dma_off)
 		printk(KERN_WARNING "%s %s: dma not reactivated\n",
-				__FILE__, __FUNCTION__);
+				__FILE__, __func__);
 	else
 		dma_off = 0;
 
@@ -446,7 +445,8 @@ int musb_platform_exit(struct musb *musb)
 				break;
 			if ((devctl & MUSB_DEVCTL_VBUS) != warn) {
 				warn = devctl & MUSB_DEVCTL_VBUS;
-				DBG(1, "VBUS %d\n", warn >> MUSB_DEVCTL_VBUS_SHIFT);
+				DBG(1, "VBUS %d\n",
+					warn >> MUSB_DEVCTL_VBUS_SHIFT);
 			}
 			msleep(1000);
 			maxdelay--;
-- 
1.5.5.23.g2a5fe

