From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/2] arm: omap: zoom: substitute gpio number with symbolic name
Date: Mon,  8 Nov 2010 08:56:15 +0200
Message-ID: <1289199375-9001-3-git-send-email-balbi@ti.com>
References: <1289199375-9001-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45026 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724Ab0KHGzY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Nov 2010 01:55:24 -0500
In-Reply-To: <1289199375-9001-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Anand Gadiyar <gadiyar@ti.com>, Felipe Balbi <balbi@ti.com>

It's easier to understand what that number means and
also avoids problems if we ever have to change it.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/board-zoom.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom.c b/arch/arm/mach-omap2/board-zoom.c
index f10766b..3da69e4 100644
--- a/arch/arm/mach-omap2/board-zoom.c
+++ b/arch/arm/mach-omap2/board-zoom.c
@@ -31,6 +31,8 @@
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "sdram-hynix-h8mbx00u0mer-0em.h"
 
+#define ZOOM3_EHCI_RESET_GPIO		64
+
 static void __init omap_zoom_init_irq(void)
 {
 	if (machine_is_omap_zoom2())
@@ -112,7 +114,7 @@ static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.port_mode[2]		= EHCI_HCD_OMAP_MODE_UNKNOWN,
 	.phy_reset		= true,
 	.reset_gpio_port[0]	= -EINVAL,
-	.reset_gpio_port[1]	= 64,
+	.reset_gpio_port[1]	= ZOOM3_EHCI_RESET_GPIO,
 	.reset_gpio_port[2]	= -EINVAL,
 };
 
@@ -122,7 +124,7 @@ static void __init omap_zoom_init(void)
 		omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	} else if (machine_is_omap_zoom3()) {
 		omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
-		omap_mux_init_gpio(64, OMAP_PIN_OUTPUT);
+		omap_mux_init_gpio(ZOOM3_EHCI_RESET_GPIO, OMAP_PIN_OUTPUT);
 		usb_ehci_init(&ehci_pdata);
 	}
 
-- 
1.7.3.2.146.gca209

