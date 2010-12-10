From: Hema HK <hemahk@ti.com>
Subject: [PATCH 8/8 V2] arm: OMAP4430: musb: Configure musb to OTG mode
Date: Fri, 10 Dec 2010 18:11:42 +0530
Message-ID: <1291984902-26112-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33542 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756100Ab0LJMls (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Dec 2010 07:41:48 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Hema HK <hemahk@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

Enabling the musb OTG mode for SDP and PANDA boards.

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c    |    2 +-
 arch/arm/mach-omap2/board-omap4panda.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: usb/arch/arm/mach-omap2/board-4430sdp.c
===================================================================
--- usb.orig/arch/arm/mach-omap2/board-4430sdp.c
+++ usb/arch/arm/mach-omap2/board-4430sdp.c
@@ -238,7 +238,7 @@ static const struct ehci_hcd_omap_platfo
 
 static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_UTMI,
-	.mode			= MUSB_PERIPHERAL,
+	.mode			= MUSB_OTG,
 	.power			= 100,
 };
 
Index: usb/arch/arm/mach-omap2/board-omap4panda.c
===================================================================
--- usb.orig/arch/arm/mach-omap2/board-omap4panda.c
+++ usb/arch/arm/mach-omap2/board-omap4panda.c
@@ -133,7 +133,7 @@ error1:
 
 static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_UTMI,
-	.mode			= MUSB_PERIPHERAL,
+	.mode			= MUSB_OTG,
 	.power			= 100,
 };
 
