From: Bjarne Steinsbo <bsteinsbo@gmail.com>
Subject: [PATCH 4/4] usb: musb: OMAP: Delete unused function
Date: Thu, 4 Aug 2011 20:02:23 +0200
Message-ID: <CAFULf_y-Pzef7zC5TN01ikr3hhe7Jfui77=O+8zCHP2ZOHOkgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:65101 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856Ab1HDSCY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Aug 2011 14:02:24 -0400
Received: by mail-vw0-f46.google.com with SMTP id 1so1319292vws.19
        for <linux-omap@vger.kernel.org>; Thu, 04 Aug 2011 11:02:23 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Not in use anymore.
---
 arch/arm/mach-omap2/usb-musb.c |   38 --------------------------------------
 1 files changed, 0 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 19e4dac..852d6e4 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -68,44 +68,6 @@ static struct omap_device_pm_latency omap_musb_latency[] = {
 	},
 };

-static void usb_musb_mux_init(struct omap_musb_board_data *board_data)
-{
-	switch (board_data->interface_type) {
-	case MUSB_INTERFACE_UTMI:
-		omap_mux_init_signal("usba0_otg_dp", OMAP_PIN_INPUT);
-		omap_mux_init_signal("usba0_otg_dm", OMAP_PIN_INPUT);
-		break;
-	case MUSB_INTERFACE_ULPI:
-		omap_mux_init_signal("usba0_ulpiphy_clk",
-						OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usba0_ulpiphy_stp",
-						OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usba0_ulpiphy_dir",
-						OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usba0_ulpiphy_nxt",
-						OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usba0_ulpiphy_dat0",
-						OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usba0_ulpiphy_dat1",
-						OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usba0_ulpiphy_dat2",
-						OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usba0_ulpiphy_dat3",
-						OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usba0_ulpiphy_dat4",
-						OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usba0_ulpiphy_dat5",
-						OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usba0_ulpiphy_dat6",
-						OMAP_PIN_INPUT_PULLDOWN);
-		omap_mux_init_signal("usba0_ulpiphy_dat7",
-						OMAP_PIN_INPUT_PULLDOWN);
-		break;
-	default:
-		break;
-	}
-}
-
 static struct omap_musb_board_data musb_default_board_data = {
 	.interface_type		= MUSB_INTERFACE_ULPI,
 	.mode			= MUSB_OTG,
-- 
1.7.1
