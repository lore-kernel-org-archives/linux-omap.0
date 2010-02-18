From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/23] omap: zoom3: enable ehci support
Date: Wed, 17 Feb 2010 17:31:50 -0800
Message-ID: <20100218013150.32075.8908.stgit@baageli.muru.com>
References: <20100218013012.32075.43788.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58444 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab0BRBbA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 20:31:00 -0500
In-Reply-To: <20100218013012.32075.43788.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Vikram Pandita <vikram.pandita@ti.com>, linux-omap@vger.kernel.org, Anand Gadiyar <gadiyar@ti.com>

From: vikram pandita <vikram.pandita@ti.com>

Zoom3 board has omap3630 EHCI port2 connected to a ULPI phy.
GPIO_64 is connected to the PHY reset pin.

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Cc: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-zoom3.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index 5e20894..d3e3cd5 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -20,6 +20,7 @@
 
 #include <plat/common.h>
 #include <plat/board.h>
+#include <plat/usb.h>
 
 #include "mux.h"
 #include "sdram-hynix-h8mbx00u0mer-0em.h"
@@ -51,11 +52,24 @@ static struct omap_board_mux board_mux[] __initdata = {
 #define board_mux	NULL
 #endif
 
+static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+	.port_mode[0]		= EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.port_mode[1]		= EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[2]		= EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.phy_reset		= true,
+	.reset_gpio_port[0]	= -EINVAL,
+	.reset_gpio_port[1]	= 64,
+	.reset_gpio_port[2]	= -EINVAL,
+};
+
 static void __init omap_zoom_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
 	zoom_peripherals_init();
 	zoom_debugboard_init();
+
+	omap_mux_init_gpio(64, OMAP_PIN_OUTPUT);
+	usb_ehci_init(&ehci_pdata);
 }
 
 MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")

