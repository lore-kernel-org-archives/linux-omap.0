From: Felipe Balbi <balbi@ti.com>
Subject: [patch-v2.6.39 1/7] arm: omap4: usb: explicitly configure MUSB pads
Date: Thu, 17 Feb 2011 14:41:00 +0200
Message-ID: <1297946466-9565-2-git-send-email-balbi@ti.com>
References: <1297946466-9565-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:56456 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755035Ab1BQMlQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 07:41:16 -0500
Received: by bwg12 with SMTP id 12so2520506bwg.9
        for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 04:41:14 -0800 (PST)
In-Reply-To: <1297946466-9565-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Anand Gadiyar <gadiyar@ti.com>, Felipe Balbi <balbi@ti.com>

From: Anand Gadiyar <gadiyar@ti.com>

Use the mux framework APIs to explicitly configure
the MUSB pads. The MUSB controller in OMAP4 can use
either the old ULPI interface, or the new internal PHY.
Configure the pads accordingly.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/usb-musb.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 5298949..5a82b43 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -31,6 +31,7 @@
 #include <mach/am35xx.h>
 #include <plat/usb.h>
 #include "control.h"
+#include "mux.h"
 
 #if defined(CONFIG_USB_MUSB_OMAP2PLUS) || defined (CONFIG_USB_MUSB_AM35X)
 
@@ -181,6 +182,43 @@ static struct platform_device musb_device = {
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
@@ -199,6 +237,8 @@ void __init usb_musb_init(struct omap_musb_board_data *board_data)
 		musb_resources[0].start = OMAP44XX_HSUSB_OTG_BASE;
 		musb_resources[1].start = OMAP44XX_IRQ_HS_USB_MC_N;
 		musb_resources[2].start = OMAP44XX_IRQ_HS_USB_DMA_N;
+
+		usb_musb_mux_init(board_data);
 	}
 	musb_resources[0].end = musb_resources[0].start + SZ_4K - 1;
 
-- 
1.7.4.rc2

