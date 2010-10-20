From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/2] arm: omap: zoom: substitute gpio number with symbolic name
Date: Wed, 20 Oct 2010 09:25:12 +0300
Message-ID: <1287555912-16058-3-git-send-email-balbi@ti.com>
References: <1287555912-16058-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59798 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755515Ab0JTGZi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Oct 2010 02:25:38 -0400
In-Reply-To: <1287555912-16058-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Anand Gadiyar <gadiyar@ti.com>, Felipe Balbi <balbi@ti.com>

It's easier to understand what that number means and
also avoids problems if we ever have to change it.

Tested-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/board-zoom.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom.c b/arch/arm/mach-omap2/board-zoom.c
index 4215abc..d641be8 100644
--- a/arch/arm/mach-omap2/board-zoom.c
+++ b/arch/arm/mach-omap2/board-zoom.c
@@ -30,6 +30,8 @@
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "sdram-hynix-h8mbx00u0mer-0em.h"
 
+#define ZOOM3_EHCI_RESET_GPIO		64
+
 static void __init omap_zoom_init_irq(void)
 {
 	if (machine_is_omap_zoom2())
@@ -146,7 +148,7 @@ static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.port_mode[2]		= EHCI_HCD_OMAP_MODE_UNKNOWN,
 	.phy_reset		= true,
 	.reset_gpio_port[0]	= -EINVAL,
-	.reset_gpio_port[1]	= 64,
+	.reset_gpio_port[1]	= ZOOM3_EHCI_RESET_GPIO,
 	.reset_gpio_port[2]	= -EINVAL,
 };
 
@@ -156,7 +158,7 @@ static void __init omap_zoom_init(void)
 		omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	} else if (machine_is_omap_zoom3()) {
 		omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
-		omap_mux_init_gpio(64, OMAP_PIN_OUTPUT);
+		omap_mux_init_gpio(ZOOM3_EHCI_RESET_GPIO, OMAP_PIN_OUTPUT);
 		usb_ehci_init(&ehci_pdata);
 	}
 
-- 
1.7.3.1.120.g38a18

