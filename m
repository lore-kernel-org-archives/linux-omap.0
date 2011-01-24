From: hvaibhav@ti.com
Subject: [PATCH] OMAP3EVM: Made backlight GPIO default state to off
Date: Mon, 24 Jan 2011 20:06:12 +0530
Message-ID: <1295879772-14086-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33226 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896Ab1AXOgS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jan 2011 09:36:18 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@nokia.com, tony@atomide.com, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

If you choose default output to DVI, the LCD backlight stays on,
since panel->disable function never gets called.

So, during init put backlight GPIO to off state and the driver
code will decide which output to enable.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 1b8a806..3f5117a 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -448,7 +448,10 @@ static int omap3evm_twl_gpio_setup(struct device *dev,

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

