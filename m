From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 7/7 V2] arm: OMAP4430: musb: Configure musb to OTG mode
Date: Fri, 10 Dec 2010 12:35:44 +0530
Message-ID: <1291964744-7278-1-git-send-email-hemahk@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Enabling the musb OTG mode for SDP and PANDA boards.

Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
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
 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
