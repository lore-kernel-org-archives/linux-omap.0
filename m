From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH RFC 4/5] omap: 3430sdp: add ohci platform init
Date: Sun, 21 Mar 2010 17:02:02 +0530
Message-ID: <1269171123-9874-5-git-send-email-gadiyar@ti.com>
References: <1269171123-9874-1-git-send-email-gadiyar@ti.com>
 <1269171123-9874-2-git-send-email-gadiyar@ti.com>
 <1269171123-9874-3-git-send-email-gadiyar@ti.com>
 <1269171123-9874-4-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45270 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751921Ab0CULcJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 21 Mar 2010 07:32:09 -0400
In-Reply-To: <1269171123-9874-4-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Anand Gadiyar <gadiyar@ti.com>

Add platform initialization code for OHCI on the 3430SDP.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |    7 +++++++
 1 files changed, 7 insertions(+)

Index: linux-2.6/arch/arm/mach-omap2/board-3430sdp.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/board-3430sdp.c
+++ linux-2.6/arch/arm/mach-omap2/board-3430sdp.c
@@ -675,6 +675,12 @@ static const struct ehci_hcd_omap_platfo
 	.reset_gpio_port[2]  = -EINVAL
 };
 
+static const struct ohci_hcd_omap_platform_data ohci_pdata __initconst = {
+	.port_mode[0] = OMAP_OHCI_PORT_MODE_UNUSED,
+	.port_mode[1] = OMAP_OHCI_PORT_MODE_UNUSED,
+	.port_mode[2] = OMAP_OHCI_PORT_MODE_PHY_3PIN_DATSE0,
+};
+
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
@@ -817,6 +823,7 @@ static void __init omap_3430sdp_init(voi
 	sdp3430_display_init();
 	enable_board_wakeup_source();
 	usb_ehci_init(&ehci_pdata);
+	usb_ohci_init(&ohci_pdata);
 }
 
 static void __init omap_3430sdp_map_io(void)
