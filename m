From: Daniel Morsing <daniel.morsing@gmail.com>
Subject: Re: [PATCH 2/3] omap3: devkit8000: fix tps65930 pullup/pulldown
 configuration
Date: Fri, 14 Jan 2011 12:49:13 +0100
Message-ID: <1295005753.3458.29.camel@morsing>
References: <1294963409-29891-1-git-send-email-daniel.morsing@gmail.com>
	 <1294963409-29891-3-git-send-email-daniel.morsing@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54416 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572Ab1ANLs7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jan 2011 06:48:59 -0500
Received: by fxm20 with SMTP id 20so2666609fxm.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Jan 2011 03:48:58 -0800 (PST)
In-Reply-To: <1294963409-29891-3-git-send-email-daniel.morsing@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Thomas Weber <weber@corscience.de>

gpio7 on the tps65930 is used as an output on the devkit8000 and gpio1
is not connected. Remove gpio7 and change gpio1 to pulldown

Signed-off-by: Daniel Morsing <daniel.morsing@gmail.com>
---

Since Thomas pointed out that I am unable to read schemas, here's
an updated fix.

 arch/arm/mach-omap2/board-devkit8000.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 864a08f..81c8f38 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -265,8 +265,7 @@ static struct twl4030_gpio_platform_data devkit8000_gpio_data = {
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
 	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.use_leds	= true,
-	.pullups	= BIT(1),
-	.pulldowns	= BIT(2) | BIT(6) | BIT(7) | BIT(8) | BIT(13)
+	.pulldowns	= BIT(1) | BIT(2) | BIT(6) | BIT(8) | BIT(13)
 				| BIT(15) | BIT(16) | BIT(17),
 	.setup		= devkit8000_twl_gpio_setup,
 };
-- 
1.7.3.4

