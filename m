From: sricharan <r.sricharan@ti.com>
Subject: [PATCH 2/5] OMAP4: usb-musb: Initialise the usb mux pins.
Date: Mon, 15 Nov 2010 13:08:02 +0530
Message-ID: <1289806685-20688-3-git-send-email-r.sricharan@ti.com>
References: <1289806685-20688-1-git-send-email-r.sricharan@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39686 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757505Ab0KOHf2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Nov 2010 02:35:28 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id oAF7ZP3r026154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 15 Nov 2010 01:35:28 -0600
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id oAF7ZO9b024066
	for <linux-omap@vger.kernel.org>; Mon, 15 Nov 2010 13:05:24 +0530 (IST)
In-Reply-To: <1289806685-20688-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Use the mux framework to initialise the musb mux pins.

Signed-off-by: sricharan <r.sricharan@ti.com>
---
 arch/arm/mach-omap2/usb-musb.c |   41 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 33a5cde..27cb348 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -29,6 +29,7 @@
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <plat/usb.h>
+#include "mux.h"
 
 #ifdef CONFIG_USB_MUSB_SOC
 
@@ -85,6 +86,44 @@ static struct platform_device musb_device = {
 	.resource	= musb_resources,
 };
 
+static void __init usb_musb_mux_init(struct omap_musb_board_data *board_data)
+{
+	if (board_data->interface_type == MUSB_INTERFACE_UTMI) {
+		/* MUSB - UTMI PIN MUX configurations */
+		omap_mux_init_signal("usba0_otg_ce.usba0_otg_ce",
+						OMAP_PIN_OUTPUT);
+		omap_mux_init_signal("usba0_otg_dp.usba0_otg_dp",
+						OMAP_PIN_INPUT);
+		omap_mux_init_signal("usba0_otg_dm.usba0_otg_dm",
+						OMAP_PIN_INPUT);
+	} else {
+		/* MUSB - ULPI PIN MUX configurations */
+		omap_mux_init_signal("usbb1_ulpitll_clk.usbb1_ulpiphy_clk",
+						OMAP_PIN_INPUT);
+		omap_mux_init_signal("usbb1_ulpitll_stp.usbb1_ulpiphy_stp",
+						OMAP_PIN_OUTPUT);
+		omap_mux_init_signal("usbb1_ulpitll_dir.usbb1_ulpiphy_dir",
+						OMAP_PIN_INPUT);
+		omap_mux_init_signal("usbb1_ulpitll_nxt.usbb1_ulpiphy_nxt",
+						OMAP_PIN_INPUT);
+		omap_mux_init_signal("usbb1_ulpitll_dat0.usbb1_ulpiphy_dat0",
+						OMAP_PIN_INPUT);
+		omap_mux_init_signal("usbb1_ulpitll_dat1.usbb1_ulpiphy_dat1",
+						OMAP_PIN_INPUT);
+		omap_mux_init_signal("usbb1_ulpitll_dat2.usbb1_ulpiphy_dat2",
+						OMAP_PIN_INPUT);
+		omap_mux_init_signal("usbb1_ulpitll_dat3.usbb1_ulpiphy_dat3",
+						OMAP_PIN_INPUT);
+		omap_mux_init_signal("usbb1_ulpitll_dat4.usbb1_ulpiphy_dat4",
+						OMAP_PIN_INPUT);
+		omap_mux_init_signal("usbb1_ulpitll_dat5.usbb1_ulpiphy_dat5",
+						OMAP_PIN_INPUT);
+		omap_mux_init_signal("usbb1_ulpitll_dat6.usbb1_ulpiphy_dat6",
+						OMAP_PIN_INPUT);
+		omap_mux_init_signal("usbb1_ulpitll_dat7.usbb1_ulpiphy_dat7",
+						OMAP_PIN_INPUT);
+	}
+}
 void __init usb_musb_init(struct omap_musb_board_data *board_data)
 {
 	if (cpu_is_omap243x()) {
@@ -95,6 +134,8 @@ void __init usb_musb_init(struct omap_musb_board_data *board_data)
 		musb_resources[0].start = OMAP44XX_HSUSB_OTG_BASE;
 		musb_resources[1].start = OMAP44XX_IRQ_HS_USB_MC_N;
 		musb_resources[2].start = OMAP44XX_IRQ_HS_USB_DMA_N;
+
+		usb_musb_mux_init(board_data);
 	}
 	musb_resources[0].end = musb_resources[0].start + SZ_4K - 1;
 
-- 
1.7.0.4

