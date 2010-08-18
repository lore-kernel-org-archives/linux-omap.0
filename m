From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [RFC] [PATCH 7/7] omap: ehci: enable the ehci port on OMAP4SDP
Date: Thu, 19 Aug 2010 05:19:37 +0530
Message-ID: <1282175377-2784-8-git-send-email-keshava_mgowda@ti.com>
References: <1282175377-2784-1-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-2-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-3-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-4-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-5-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-6-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-7-git-send-email-keshava_mgowda@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1282175377-2784-7-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The OMAP4 SDP has EHCI port1 hooked up to an external SMSC3320
transciever. GPIO 157 is used to power on the transceiver.

Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/board-4430sdp.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

Index: linux-2.6/arch/arm/mach-omap2/board-4430sdp.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/board-4430sdp.c
+++ linux-2.6/arch/arm/mach-omap2/board-4430sdp.c
@@ -40,6 +40,7 @@
 #define ETH_KS8851_IRQ			34
 #define ETH_KS8851_POWER_ON		48
 #define ETH_KS8851_QUART		138
+#define OMAP4SDP_MDM_PWR_EN_GPIO	157
 
 static struct gpio_led sdp4430_gpio_leds[] = {
 	{
@@ -412,6 +413,17 @@ static struct i2c_board_info __initdata 
 		I2C_BOARD_INFO("tmp105", 0x48),
 	},
 };
+
+static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[1] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.phy_reset  = false,
+	.reset_gpio_port[0]  = -EINVAL,
+	.reset_gpio_port[1]  = -EINVAL,
+	.reset_gpio_port[2]  = -EINVAL
+};
+
 static int __init omap4_i2c_init(void)
 {
 	/*
@@ -434,6 +446,14 @@ static void __init omap_4430sdp_init(voi
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
 	omap_serial_init();
 	omap4_twl6030_hsmmc_init(mmc);
+
+	/* Power on the ULPI PHY */
+	if (gpio_is_valid(OMAP4SDP_MDM_PWR_EN_GPIO)) {
+		/* FIXME: Assumes pad is muxed for GPIO mode */
+		gpio_request(OMAP4SDP_MDM_PWR_EN_GPIO, "USBB1 PHY VMDM_3V3");
+		gpio_direction_output(OMAP4SDP_MDM_PWR_EN_GPIO, 1);
+	}
+	usb_ehci_init(&ehci_pdata);
 	/* OMAP4 SDP uses internal transceiver so register nop transceiver */
 	usb_nop_xceiv_register();
 	/* FIXME: allow multi-omap to boot until musb is updated for omap4 */
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
