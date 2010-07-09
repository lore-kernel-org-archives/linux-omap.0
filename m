From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH resend 2/2] OMAP3: musb: remove unneeded include files
Date: Fri,  9 Jul 2010 13:52:06 +0530
Message-ID: <1278663726-27689-2-git-send-email-ajay.gupta@ti.com>
References: <1278663726-27689-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59742 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751544Ab0GIIWP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Jul 2010 04:22:15 -0400
In-Reply-To: <1278663726-27689-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.balbi@nokia.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Removed include files from usb-musb.c which were not required.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 arch/arm/mach-omap2/usb-musb.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 03ddf64..3befddb 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -16,17 +16,10 @@
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
 #include <plat/usb.h>
 
-- 
1.6.2.4

