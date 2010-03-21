From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH RFC 5/5] omap: 3630sdp: add ohci platform init
Date: Sun, 21 Mar 2010 17:02:03 +0530
Message-ID: <1269171123-9874-6-git-send-email-gadiyar@ti.com>
References: <1269171123-9874-1-git-send-email-gadiyar@ti.com>
 <1269171123-9874-2-git-send-email-gadiyar@ti.com>
 <1269171123-9874-3-git-send-email-gadiyar@ti.com>
 <1269171123-9874-4-git-send-email-gadiyar@ti.com>
 <1269171123-9874-5-git-send-email-gadiyar@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1269171123-9874-5-git-send-email-gadiyar-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add platform initialization code for OHCI on the 3630SDP.

Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/board-3630sdp.c |    7 +++++++
 1 files changed, 7 insertions(+)

Index: linux-2.6/arch/arm/mach-omap2/board-3630sdp.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/board-3630sdp.c
+++ linux-2.6/arch/arm/mach-omap2/board-3630sdp.c
@@ -66,6 +66,12 @@ static const struct ehci_hcd_omap_platfo
 	.reset_gpio_port[2]  = -EINVAL
 };
 
+static const struct ohci_hcd_omap_platform_data ohci_pdata __initconst = {
+	.port_mode[0] = OMAP_OHCI_PORT_MODE_UNUSED,
+	.port_mode[1] = OMAP_OHCI_PORT_MODE_UNUSED,
+	.port_mode[2] = OMAP_OHCI_PORT_MODE_PHY_3PIN_DATSE0,
+};
+
 static void __init omap_sdp_map_io(void)
 {
 	omap2_set_globals_36xx();
@@ -100,6 +106,7 @@ static void __init omap_sdp_init(void)
 	board_smc91x_init();
 	enable_board_wakeup_source();
 	usb_ehci_init(&ehci_pdata);
+	usb_ohci_init(&ohci_pdata);
 }
 
 MACHINE_START(OMAP_3630SDP, "OMAP 3630SDP board")
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
