From: Bob Liu <lliubbo@gmail.com>
Subject: [PATCH] arm: omap3beagle: init musb default role by Kconfig
Date: Tue, 15 Feb 2011 16:55:00 +0800
Message-ID: <1297760100-7200-1-git-send-email-lliubbo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:61000 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408Ab1BOIrV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Feb 2011 03:47:21 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: archit@ti.com, tony@atomide.com, balbi@ti.com, adrian.hunter@nokia.com, Bob Liu <lliubbo@gmail.com>

Currently musb is initialized to OTG mode by default in musb_board_data, it's
better to init it depending on Kconfig.

Signed-off-by: Bob Liu <lliubbo@gmail.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 14f4224..fb82773 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -554,7 +554,13 @@ static struct omap_board_mux board_mux[] __initdata = {
 
 static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_ULPI,
-	.mode			= MUSB_OTG,
+#if defined(CONFIG_USB_MUSB_OTG)
+	.mode		= MUSB_OTG,
+#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
+	.mode		= MUSB_HOST,
+#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
+	.mode		= MUSB_PERIPHERAL,
+#endif
 	.power			= 100,
 };
 
-- 
1.6.3.3

