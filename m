From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH v2] omap: zoom3: enable ehci support
Date: Thu,  7 Jan 2010 14:07:06 -0600
Message-ID: <1262894826-10057-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52537 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759Ab0AGUDW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jan 2010 15:03:22 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o07K3LbY018040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 7 Jan 2010 14:03:22 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>

Zoom3 board has omap3630 EHCI port2 connected to a ULPI phy.
GPIO_64 is connected to the PHY reset pin.

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Cc: Gadiyar, Anand <gadiyar@ti.com>
---
History:
v1: initial draft
v2: fix minor header file include comment by Anand Gadiyar

 arch/arm/mach-omap2/board-zoom3.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index a9fe918..b691340 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -20,6 +20,7 @@
 
 #include <plat/common.h>
 #include <plat/board.h>
+#include <plat/usb.h>
 
 #include "mux.h"
 #include "sdram-hynix-h8mbx00u0mer-0em.h"
@@ -51,11 +52,25 @@ static struct omap_board_mux board_mux[] __initdata = {
 #define board_mux	NULL
 #endif
 
+static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+	.port_mode[0] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+
+	.phy_reset  = true,
+	.reset_gpio_port[0]  = -EINVAL,
+	.reset_gpio_port[1]  = 64,
+	.reset_gpio_port[2]  = -EINVAL
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
-- 
1.6.6.rc0.66.ge160d

