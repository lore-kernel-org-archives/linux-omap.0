From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 1/2] omap3evm: fix compilation warning for omap3evm_flash_init
Date: Tue, 22 Sep 2009 18:42:09 +0530
Message-ID: <1253625132-15050-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50372 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756539AbZIVNMW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Sep 2009 09:12:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.balbi@nokia.com, david-b@pacbell.net, tony@atomide.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

omap3evm_flash_init() was earlier defined in seperate file but now need to merge to
board_omap3evm.c file.

Removing it to fix the compilation. It should be added back with function
definitions.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 7b4e16c..62a6f32 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -324,7 +324,6 @@ static void __init omap3_evm_init(void)
 	/* Setup EHCI phy reset padconfig */
 	omap_cfg_reg(AF4_34XX_GPIO135_OUT);
 	usb_ehci_init(&ehci_pdata);
-	omap3evm_flash_init();
 	ads7846_dev_init();
 }
 
-- 
1.6.2.4

