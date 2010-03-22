From: hvaibhav@ti.com
Subject: [PATCH 1/2] OMAP3EVM: Made backlight GPIO default state to off
Date: Mon, 22 Mar 2010 18:41:09 +0530
Message-ID: <1269263470-13814-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35174 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754335Ab0CVNLR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Mar 2010 09:11:17 -0400
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@nokia.com, tony@atomide.com, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

If you choose default output to DVI, the LCD backlight still
gets powered, since panel->disable function never gets called for LCD.

So, during init put backlight GPIO to off state and the driverr
code will decide which output to enable explicitly.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 74bbdcb..f2a52c3 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -420,7 +420,10 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
 
 	/* TWL4030_GPIO_MAX + 0 == ledA, LCD Backlight control */
 	gpio_request(gpio + TWL4030_GPIO_MAX, "EN_LCD_BKL");
-	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
+	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2)
+		gpio_direction_output(gpio + TWL4030_GPIO_MAX, 1);
+	else
+		gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
 
 	/* gpio + 7 == DVI Enable */
 	gpio_request(gpio + 7, "EN_DVI");
-- 
1.6.2.4

