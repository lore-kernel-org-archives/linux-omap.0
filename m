From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH 1/3] omap3: igep3: Add USB EHCI support for IGEP module.
Date: Mon, 10 Jan 2011 14:26:12 +0100
Message-ID: <1294665974-10590-2-git-send-email-eballetbo@gmail.com>
References: <1294665974-10590-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58293 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650Ab1AJN01 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jan 2011 08:26:27 -0500
Received: by wyb28 with SMTP id 28so19431115wyb.19
        for <linux-omap@vger.kernel.org>; Mon, 10 Jan 2011 05:26:26 -0800 (PST)
In-Reply-To: <1294665974-10590-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>

The OMAP3 IGEP module has one EHCI interface on board using
USB2HS port. GPIO183 is used as PHY reset.

Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---
 arch/arm/mach-omap2/board-igep0030.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0030.c b/arch/arm/mach-omap2/board-igep0030.c
index c88e8f7..f0a85c1 100644
--- a/arch/arm/mach-omap2/board-igep0030.c
+++ b/arch/arm/mach-omap2/board-igep0030.c
@@ -43,7 +43,7 @@
 #define IGEP3_GPIO_WIFI_NRESET	139
 #define IGEP3_GPIO_BT_NRESET	137
 
-#define IGEP3_GPIO_USBH_NRESET  115
+#define IGEP3_GPIO_USBH_NRESET  183
 
 
 #if defined(CONFIG_MTD_ONENAND_OMAP2) || \
@@ -363,8 +363,20 @@ static void __init igep3_wifi_bt_init(void)
 void __init igep3_wifi_bt_init(void) {}
 #endif
 
+static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+	.port_mode[0] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+
+	.phy_reset = true,
+	.reset_gpio_port[0] = -EINVAL,
+	.reset_gpio_port[1] = IGEP3_GPIO_USBH_NRESET,
+	.reset_gpio_port[2] = -EINVAL,
+};
+
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
+	OMAP3_MUX(I2C2_SDA, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
 #endif
@@ -378,6 +390,7 @@ static void __init igep3_init(void)
 
 	omap_serial_init();
 	usb_musb_init(&musb_board_data);
+	usb_ehci_init(&ehci_pdata);
 
 	igep3_flash_init();
 	igep3_leds_init();
-- 
1.7.0.4

