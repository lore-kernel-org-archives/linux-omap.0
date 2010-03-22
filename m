From: hvaibhav@ti.com
Subject: [PATCH 2/2] AM3517: By default disable LCD panel power in board_init
Date: Mon, 22 Mar 2010 18:41:10 +0530
Message-ID: <1269263470-13814-2-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44919 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754335Ab0CVNLU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Mar 2010 09:11:20 -0400
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@nokia.com, tony@atomide.com, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

If you choose default output to DVI, the LCD panel gets
powered on, since panel->disable function never gets called for LCD.

So, during init put panel power GPIO to off state and the driver
code will decide which output to enable explicitly.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 6ae8805..dff5274 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -152,7 +152,7 @@ static void __init am3517_evm_display_init(void)
 		printk(KERN_ERR "failed to get lcd_panel_pwr\n");
 		goto err_2;
 	}
-	gpio_direction_output(LCD_PANEL_PWR, 1);
+	gpio_direction_output(LCD_PANEL_PWR, 0);
 
 	printk(KERN_INFO "Display initialized successfully\n");
 	return;
-- 
1.6.2.4

