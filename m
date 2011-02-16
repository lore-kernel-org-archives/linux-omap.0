From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH] omap4: usb: explicitly configure MUSB pads
Date: Wed, 16 Feb 2011 15:42:15 +0530
Message-ID: <1297851135-25952-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44718 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752402Ab1BPKM3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 05:12:29 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Anand Gadiyar <gadiyar@ti.com>, Tony Lindgren <tony@atomide.com>

Use the mux framework APIs to explicitly configure
the MUSB pads. The MUSB controller in OMAP4 can use
either the old ULPI interface, or the new internal PHY.
Configure the pads accordingly.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
Each of these signals are brought out on exactly one pad,
so there is no conflict.

This patch was developed as part of bringing up the USBTLL
interface on OMAP4. However it's purely OMAP4 specific,
so it should go through Tony.

Applies against linux-next as of today.

 arch/arm/mach-omap2/usb-musb.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

Index: linux-omap-usb/arch/arm/mach-omap2/usb-musb.c
===================================================================
--- linux-omap-usb.orig/arch/arm/mach-omap2/usb-musb.c
+++ linux-omap-usb/arch/arm/mach-omap2/usb-musb.c
@@ -31,6 +31,7 @@
 #include <mach/am35xx.h>
 #include <plat/usb.h>
 #include "control.h"
+#include "mux.h"
 
 #if defined(CONFIG_USB_MUSB_OMAP2PLUS) || defined (CONFIG_USB_MUSB_AM35X)
 
@@ -181,6 +182,43 @@ static struct platform_device musb_devic
 	.resource	= musb_resources,
 };
 
+static void usb_musb_mux_init(struct omap_musb_board_data *board_data)
+{
+	switch (board_data->interface_type) {
+	case MUSB_INTERFACE_UTMI:
+		omap_mux_init_signal("usba0_otg_dp", OMAP_PIN_INPUT);
+		omap_mux_init_signal("usba0_otg_dm", OMAP_PIN_INPUT);
+		break;
+	case MUSB_INTERFACE_ULPI:
+		omap_mux_init_signal("usba0_ulpiphy_clk",
+						OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usba0_ulpiphy_stp",
+						OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usba0_ulpiphy_dir",
+						OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usba0_ulpiphy_nxt",
+						OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usba0_ulpiphy_dat0",
+						OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usba0_ulpiphy_dat1",
+						OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usba0_ulpiphy_dat2",
+						OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usba0_ulpiphy_dat3",
+						OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usba0_ulpiphy_dat4",
+						OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usba0_ulpiphy_dat5",
+						OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usba0_ulpiphy_dat6",
+						OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usba0_ulpiphy_dat7",
+						OMAP_PIN_INPUT_PULLDOWN);
+		break;
+	default:
+		break;
+	}
+}
 void __init usb_musb_init(struct omap_musb_board_data *board_data)
 {
 	if (cpu_is_omap243x()) {
@@ -199,6 +237,8 @@ void __init usb_musb_init(struct omap_mu
 		musb_resources[0].start = OMAP44XX_HSUSB_OTG_BASE;
 		musb_resources[1].start = OMAP44XX_IRQ_HS_USB_MC_N;
 		musb_resources[2].start = OMAP44XX_IRQ_HS_USB_DMA_N;
+
+		usb_musb_mux_init(board_data);
 	}
 	musb_resources[0].end = musb_resources[0].start + SZ_4K - 1;
 
