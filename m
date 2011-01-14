From: Daniel Morsing <daniel.morsing@gmail.com>
Subject: [PATCH 2/3] omap3: devkit8000: fix tps65930 pullup/pulldown configuration
Date: Fri, 14 Jan 2011 01:03:28 +0100
Message-ID: <1294963409-29891-3-git-send-email-daniel.morsing@gmail.com>
References: <1294963409-29891-1-git-send-email-daniel.morsing@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56247 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757362Ab1ANAD0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Jan 2011 19:03:26 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so1191165eye.19
        for <linux-omap@vger.kernel.org>; Thu, 13 Jan 2011 16:03:25 -0800 (PST)
In-Reply-To: <1294963409-29891-1-git-send-email-daniel.morsing@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Thomas Weber <weber@corscience.de>, Daniel Morsing <daniel.morsing@gmail.com>

gpio1 and gpio7 on the tps65930 are used as outputs on the devkit8000.
Remove them from the pu/pd configuration.

Signed-off-by: Daniel Morsing <daniel.morsing@gmail.com>
---
 arch/arm/mach-omap2/board-devkit8000.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 864a08f..8dc7a24 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -265,9 +265,8 @@ static struct twl4030_gpio_platform_data devkit8000_gpio_data = {
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
 	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.use_leds	= true,
-	.pullups	= BIT(1),
-	.pulldowns	= BIT(2) | BIT(6) | BIT(7) | BIT(8) | BIT(13)
-				| BIT(15) | BIT(16) | BIT(17),
+	.pulldowns	= BIT(2) | BIT(6) | BIT(8) | BIT(13) | BIT(15)
+				| BIT(16) | BIT(17),
 	.setup		= devkit8000_twl_gpio_setup,
 };
 
-- 
1.7.3.4

