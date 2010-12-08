From: Hema HK <hemahk@ti.com>
Subject: [PATCH 7/7] arm: OMAP4430: musb: Enable musb device initialization for OMAP4430
Date: Tue,  7 Dec 2010 19:12:19 -0500
Message-ID: <1291767139-10303-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44400 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753962Ab0LGNkX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 08:40:23 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-usb-owner@vger.kernel.org
Cc: Hema HK <hemahk@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

musb device registration during board initialization of OMAP4430SDP
and OMAP4430 PANDA.Enable the musb OTG mode.

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c    |    6 ++----
 arch/arm/mach-omap2/board-omap4panda.c |    2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

Index: linux-2.6/arch/arm/mach-omap2/board-4430sdp.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/board-4430sdp.c
+++ linux-2.6/arch/arm/mach-omap2/board-4430sdp.c
@@ -227,7 +227,7 @@ static void __init omap_4430sdp_init_irq
 
 static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_UTMI,
-	.mode			= MUSB_PERIPHERAL,
+	.mode			= MUSB_OTG,
 	.power			= 100,
 };
 
@@ -522,9 +522,7 @@ static void __init omap_4430sdp_init(voi
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
 	omap_serial_init();
 	omap4_twl6030_hsmmc_init(mmc);
-	/* FIXME: allow multi-omap to boot until musb is updated for omap4 */
-	if (!cpu_is_omap44xx())
-		usb_musb_init(&musb_board_data);
+	usb_musb_init(&musb_board_data);
 
 	status = omap_ethernet_init();
 	if (status) {
Index: linux-2.6/arch/arm/mach-omap2/board-omap4panda.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/board-omap4panda.c
+++ linux-2.6/arch/arm/mach-omap2/board-omap4panda.c
@@ -133,7 +133,7 @@ error1:
 
 static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_UTMI,
-	.mode			= MUSB_PERIPHERAL,
+	.mode			= MUSB_OTG,
 	.power			= 100,
 };
 
