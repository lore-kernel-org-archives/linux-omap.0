From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH 1/2] omap4: 4430sdp: drop ehci support
Date: Wed, 16 Feb 2011 16:47:19 +0530
Message-ID: <1297855040-1337-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49587 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755570Ab1BPLRa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 06:17:30 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Anand Gadiyar <gadiyar@ti.com>, Keshava Munegowda <keshava_mgowda@ti.com>, Tony Lindgren <tony@atomide.com>

Most revisions of the OMAP4 Blaze/SDP platform do not have
the EHCI signals routed by default. The pads are routed
for the alternate HSI functionality instead, and explicit
board modifications are needed to route the signals to
the USB PHY on the board.

Also, turning on the PHY connected to the EHCI port causes
a board reboot during bootup due to an unintended short
on the rails - this affects many initial revisions of the
board, and needs a minor board mod to fix (or as a
workaround, one should not attempt to power on the
USB PHY).

Given that these boards need explicit board mods to even
get EHCI working (separate from the accidental short above),
we should not attempt to enable EHCI by default.

So drop the EHCI support from the board files for the
Blaze/SDP platforms.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---

 arch/arm/mach-omap2/board-4430sdp.c |   20 --------------------
 1 file changed, 20 deletions(-)

Index: linux-omap-usb/arch/arm/mach-omap2/board-4430sdp.c
===================================================================
--- linux-omap-usb.orig/arch/arm/mach-omap2/board-4430sdp.c
+++ linux-omap-usb/arch/arm/mach-omap2/board-4430sdp.c
@@ -44,7 +44,6 @@
 #define ETH_KS8851_IRQ			34
 #define ETH_KS8851_POWER_ON		48
 #define ETH_KS8851_QUART		138
-#define OMAP4SDP_MDM_PWR_EN_GPIO	157
 #define OMAP4_SFH7741_SENSOR_OUTPUT_GPIO	184
 #define OMAP4_SFH7741_ENABLE_GPIO		188
 
@@ -251,16 +250,6 @@ static void __init omap_4430sdp_init_irq
 	gic_init_irq();
 }
 
-static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
-	.port_mode[0]	= EHCI_HCD_OMAP_MODE_PHY,
-	.port_mode[1]	= EHCI_HCD_OMAP_MODE_UNKNOWN,
-	.port_mode[2]	= EHCI_HCD_OMAP_MODE_UNKNOWN,
-	.phy_reset	= false,
-	.reset_gpio_port[0]  = -EINVAL,
-	.reset_gpio_port[1]  = -EINVAL,
-	.reset_gpio_port[2]  = -EINVAL,
-};
-
 static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_UTMI,
 	.mode			= MUSB_OTG,
@@ -576,14 +564,6 @@ static void __init omap_4430sdp_init(voi
 	omap_serial_init();
 	omap4_twl6030_hsmmc_init(mmc);
 
-	/* Power on the ULPI PHY */
-	status = gpio_request(OMAP4SDP_MDM_PWR_EN_GPIO, "USBB1 PHY VMDM_3V3");
-	if (status)
-		pr_err("%s: Could not get USBB1 PHY GPIO\n", __func__);
-	else
-		gpio_direction_output(OMAP4SDP_MDM_PWR_EN_GPIO, 1);
-
-	usb_ehci_init(&ehci_pdata);
 	usb_musb_init(&musb_board_data);
 
 	status = omap_ethernet_init();
