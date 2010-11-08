From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] arm: omap1: devices: need to return with a value
Date: Mon,  8 Nov 2010 08:48:00 +0200
Message-ID: <1289198880-8302-1-git-send-email-balbi@ti.com>
References: <20101105213106.GV9264@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42762 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751087Ab0KHGrA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Nov 2010 01:47:00 -0500
In-Reply-To: <20101105213106.GV9264@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

Get rid of the following warning:

arch/arm/mach-omap1/devices.c: In function 'omap_init_wdt':
arch/arm/mach-omap1/devices.c:298: warning: 'return' with
no value, in function returning non-void

while at that, also change:

platform_device_register();
return 0;

into:

return platform_device_register();

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap1/devices.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index ea0d80a..e7f9ee6 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -321,10 +321,9 @@ static struct platform_device omap_wdt_device = {
 static int __init omap_init_wdt(void)
 {
 	if (!cpu_is_omap16xx())
-		return;
+		return -ENODEV;
 
-	platform_device_register(&omap_wdt_device);
-	return 0;
+	return platform_device_register(&omap_wdt_device);
 }
 subsys_initcall(omap_init_wdt);
 #endif
-- 
1.7.3.2.146.gca209

