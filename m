From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/5] arm: omap: debug-leds: move initialization to debug-leds
Date: Tue, 24 Jul 2012 11:53:59 +0300
Message-ID: <1343120042-16695-3-git-send-email-balbi@ti.com>
References: <1343120042-16695-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:48116 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752538Ab2GXI5T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jul 2012 04:57:19 -0400
Received: by lago2 with SMTP id o2so1360879lag.1
        for <linux-omap@vger.kernel.org>; Tue, 24 Jul 2012 01:57:16 -0700 (PDT)
In-Reply-To: <1343120042-16695-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

there's no problem in registering debug-leds on
module_init() as that's not critical to board
boot up.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/plat-omap/debug-leds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/plat-omap/debug-leds.c b/arch/arm/plat-omap/debug-leds.c
index 17cbef6..615d085 100644
--- a/arch/arm/plat-omap/debug-leds.c
+++ b/arch/arm/plat-omap/debug-leds.c
@@ -306,4 +306,4 @@ static int __init fpga_init(void)
 {
 	return platform_driver_register(&led_driver);
 }
-fs_initcall(fpga_init);
+module_init(fpga_init);
-- 
1.7.11

