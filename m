From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 6/8] am335xevm: Add support for musb interface
Date: Tue, 11 Oct 2011 16:56:07 +0530
Message-ID: <1318332369-9732-7-git-send-email-ajay.gupta@ti.com>
References: <1318332369-9732-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50356 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754704Ab1JKL0Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Oct 2011 07:26:16 -0400
In-Reply-To: <1318332369-9732-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, balbi@ti.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Adding musb support in am335x EVM board file.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/board-am335xevm.c |    9 +++++++++
 arch/arm/mach-omap2/usb-musb.c        |    2 +-
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am335xevm.c b/arch/arm/mach-omap2/board-am335xevm.c
index a4102ef..298dc51 100644
--- a/arch/arm/mach-omap2/board-am335xevm.c
+++ b/arch/arm/mach-omap2/board-am335xevm.c
@@ -24,6 +24,14 @@
 #include <plat/irqs.h>
 #include <plat/board.h>
 #include <plat/common.h>
+#include <plat/usb.h>
+
+static struct omap_musb_board_data musb_board_data = {
+	.set_phy_power	= ti81xx_musb_phy_power,
+	.interface_type	= MUSB_INTERFACE_ULPI,
+	.mode           = MUSB_OTG,
+	.power		= 500,
+};
 
 #include "mux.h"
 
@@ -73,6 +81,7 @@ static void __init am335x_evm_init(void)
 	omap_sdrc_init(NULL, NULL);
 	omap_board_config = am335x_evm_config;
 	omap_board_config_size = ARRAY_SIZE(am335x_evm_config);
+	usb_musb_init(&musb_board_data);
 }
 
 static void __init am335x_evm_map_io(void)
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 8bceeca..5cd373e 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -143,7 +143,7 @@ void __init usb_musb_init(struct omap_musb_board_data *musb_board_data)
 	if (cpu_is_omap3517() || cpu_is_omap3505()) {
 		oh_name = "am35x_otg_hs";
 		name = "musb-am35x";
-	} else if (cpu_is_ti81xx()) {
+	} else if (cpu_is_ti81xx() || cpu_is_am33xx()) {
 		oh_name = "usb_otg_hs";
 		name = "musb-ti81xx";
 	} else {
-- 
1.6.2.4

