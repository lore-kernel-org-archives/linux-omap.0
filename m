From: "Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>
Subject: [PATCH] OMAP3 EVM: remove out-of-bounds array access of gpio_leds.
Date: Mon, 13 Feb 2012 09:35:22 +0100
Message-ID: <1329122122-5804-1-git-send-email-arnout@mind.be>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 132.79-246-81.adsl-static.isp.belgacom.be ([81.246.79.132]:51850
	"EHLO viper.mind.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978Ab2BMIfw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Feb 2012 03:35:52 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Syed Mohammed Khasim <khasim@ti.com>, Russell King <linux@arm.linux.org.uk>, Philip Oberstaller <philip.oberstaller@septentrio.com>, "Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>

From: "Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>

The omap3evm BSP enables a GPIO LED on the twl4030 chip.  However,
the static gpio_leds array doesn't have an entry for it.  This is
most likely a copy-and-paste error, because it has been in there
since the first commit of the omap3evm BSP (53c5ec31).

Signed-off-by: Arnout Vandecappelle (Essensium/Mind) <arnout@mind.be>
---
Please CC me, I'm not on the list.

Since I don't have access to an OMAP3EVM board or schematics, I
couldn't actually test if my fix is correct.  I discovered the error
because I'm using this BSP for an AM37xEVM board - which has the
LED connected to a different GPIO.  It works on the AM37xEVM board
if I replace the assignment with the correct GPIO number (8).
---
 arch/arm/mach-omap2/board-omap3evm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index ec00b2e..f6f5cd4 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -381,7 +381,7 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
 	gpio_request_one(gpio + 7, GPIOF_OUT_INIT_LOW, "EN_DVI");
 
 	/* TWL4030_GPIO_MAX + 1 == ledB (out, active low LED) */
-	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
+	gpio_leds[0].gpio = gpio + TWL4030_GPIO_MAX + 1;
 
 	platform_device_register(&leds_gpio);
 
-- 
1.7.8.3

