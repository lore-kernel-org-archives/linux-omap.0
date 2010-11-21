From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH] omap4: 4430sdp: enable the ehci port on 4430SDP
Date: Mon, 22 Nov 2010 00:13:19 +0530
Message-ID: <1290364999-4783-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37344 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755482Ab0KUSn0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 21 Nov 2010 13:43:26 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, Anand Gadiyar <gadiyar@ti.com>, Tony Lindgren <tony@atomide.com>

From: Keshava Munegowda <keshava_mgowda@ti.com>

Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
Depends on the series I just sent out for adding OMAP4 ehci support,
but can be applied independently of that.

 arch/arm/mach-omap2/board-4430sdp.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index df5a425..d7cb968 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -42,6 +42,7 @@
 #define ETH_KS8851_IRQ			34
 #define ETH_KS8851_POWER_ON		48
 #define ETH_KS8851_QUART		138
+#define OMAP4SDP_MDM_PWR_EN_GPIO	157
 #define OMAP4_SFH7741_SENSOR_OUTPUT_GPIO	184
 #define OMAP4_SFH7741_ENABLE_GPIO		188
 
@@ -225,6 +226,16 @@ static void __init omap_4430sdp_init_irq(void)
 	omap_gpio_init();
 }
 
+static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+	.port_mode[0]	= EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[1]	= EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.port_mode[2]	= EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.phy_reset	= false,
+	.reset_gpio_port[0]  = -EINVAL,
+	.reset_gpio_port[1]  = -EINVAL,
+	.reset_gpio_port[2]  = -EINVAL,
+};
+
 static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_UTMI,
 	.mode			= MUSB_PERIPHERAL,
@@ -514,6 +525,15 @@ static void __init omap_4430sdp_init(void)
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
 	omap_serial_init();
 	omap4_twl6030_hsmmc_init(mmc);
+
+	/* Power on the ULPI PHY */
+	if (gpio_is_valid(OMAP4SDP_MDM_PWR_EN_GPIO)) {
+		/* FIXME: Assumes pad is already muxed for GPIO mode */
+		gpio_request(OMAP4SDP_MDM_PWR_EN_GPIO, "USBB1 PHY VMDM_3V3");
+		gpio_direction_output(OMAP4SDP_MDM_PWR_EN_GPIO, 1);
+	}
+	usb_ehci_init(&ehci_pdata);
+
 	/* OMAP4 SDP uses internal transceiver so register nop transceiver */
 	usb_nop_xceiv_register();
 	/* FIXME: allow multi-omap to boot until musb is updated for omap4 */
-- 
1.7.0.4

