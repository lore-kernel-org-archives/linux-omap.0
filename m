From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: [RFC] [PATCH 5/5] usb: ohci: omap: enable the ohci port on OMAP4SDP
Date: Fri, 20 Aug 2010 00:48:10 +0530
Message-ID: <1282245490-24339-6-git-send-email-keshava_mgowda@ti.com>
References: <1282245490-24339-1-git-send-email-keshava_mgowda@ti.com>
 <1282245490-24339-2-git-send-email-keshava_mgowda@ti.com>
 <1282245490-24339-3-git-send-email-keshava_mgowda@ti.com>
 <1282245490-24339-4-git-send-email-keshava_mgowda@ti.com>
 <1282245490-24339-5-git-send-email-keshava_mgowda@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55281 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752017Ab0HTHRi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Aug 2010 03:17:38 -0400
In-Reply-To: <1282245490-24339-5-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, Anand Gadiyar <gadiyar@ti.com>

The port 2 of OHCI controller is connected to external PHY. 
The Unidirection 6 pin serial mode is configured.

Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-2.6/arch/arm/mach-omap2/board-4430sdp.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/board-4430sdp.c
+++ linux-2.6/arch/arm/mach-omap2/board-4430sdp.c
@@ -424,6 +424,11 @@ static const struct ehci_hcd_omap_platfo
 	.reset_gpio_port[2]  = -EINVAL
 };
 
+static const struct ohci_hcd_omap_platform_data ohci_pdata __initconst = {
+	.port_mode[0] = OMAP_OHCI_PORT_MODE_UNUSED,
+	.port_mode[1] = OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0,
+	.port_mode[2] = OMAP_OHCI_PORT_MODE_UNUSED,
+};
 static int __init omap4_i2c_init(void)
 {
 	/*
@@ -454,6 +459,7 @@ static void __init omap_4430sdp_init(voi
 		gpio_direction_output(OMAP4SDP_MDM_PWR_EN_GPIO, 1);
 	}
 	usb_ehci_init(&ehci_pdata);
+	usb_ohci_init(&ohci_pdata);
 	/* OMAP4 SDP uses internal transceiver so register nop transceiver */
 	usb_nop_xceiv_register();
 	/* FIXME: allow multi-omap to boot until musb is updated for omap4 */
