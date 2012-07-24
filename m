From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 1/5] arm: omap: debug-leds: drop machine_is_* checks
Date: Tue, 24 Jul 2012 11:53:58 +0300
Message-ID: <1343120042-16695-2-git-send-email-balbi@ti.com>
References: <1343120042-16695-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:59147 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752476Ab2GXI5R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jul 2012 04:57:17 -0400
Received: by lahj13 with SMTP id j13so586527lah.25
        for <linux-omap@vger.kernel.org>; Tue, 24 Jul 2012 01:57:14 -0700 (PDT)
In-Reply-To: <1343120042-16695-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

that platform_device is only registered by
board-h4.c, so there's no need to check which
machine is running as the driver won't bind
to anything.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/plat-omap/debug-leds.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/debug-leds.c b/arch/arm/plat-omap/debug-leds.c
index 39407cb..17cbef6 100644
--- a/arch/arm/plat-omap/debug-leds.c
+++ b/arch/arm/plat-omap/debug-leds.c
@@ -304,12 +304,6 @@ static struct platform_driver led_driver = {
 
 static int __init fpga_init(void)
 {
-	if (machine_is_omap_h4()
-			|| machine_is_omap_h3()
-			|| machine_is_omap_h2()
-			|| machine_is_omap_perseus2()
-			)
-		return platform_driver_register(&led_driver);
-	return 0;
+	return platform_driver_register(&led_driver);
 }
 fs_initcall(fpga_init);
-- 
1.7.11

