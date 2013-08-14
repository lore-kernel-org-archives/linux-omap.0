From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 3/9] ARM: OMAP2+: omap-usb-host: Get rid of platform_data from struct usbhs_phy_data
Date: Wed, 14 Aug 2013 16:58:07 +0300
Message-ID: <1376488693-31659-4-git-send-email-rogerq@ti.com>
References: <1376488693-31659-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38538 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758291Ab3HNN66 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Aug 2013 09:58:58 -0400
In-Reply-To: <1376488693-31659-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, tony@atomide.com, bcousson@baylibre.com
Cc: p.zabel@pengutronix.de, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>

The platform data bits can be inferred from the other members of
struct usbhs_phy_data. So get rid of the platform_data member.

Build the platform data for the PHY device in usbhs_init_phys() instead.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    6 ------
 arch/arm/mach-omap2/usb-host.c          |   11 ++++++++++-
 arch/arm/mach-omap2/usb.h               |    1 -
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 04c1165..47bca8f 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -278,18 +278,12 @@ static struct regulator_consumer_supply beagle_vsim_supply[] = {
 
 static struct gpio_led gpio_leds[];
 
-/* PHY's VCC regulator might be added later, so flag that we need it */
-static struct nop_usb_xceiv_platform_data hsusb2_phy_data = {
-	.needs_vcc = true,
-};
-
 static struct usbhs_phy_data phy_data[] = {
 	{
 		.port = 2,
 		.reset_gpio = 147,
 		.vcc_gpio = -1,		/* updated in beagle_twl_gpio_setup */
 		.vcc_polarity = 1,	/* updated in beagle_twl_gpio_setup */
-		.platform_data = &hsusb2_phy_data,
 	},
 };
 
diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
index 2eb19d4..1626801 100644
--- a/arch/arm/mach-omap2/usb-host.c
+++ b/arch/arm/mach-omap2/usb-host.c
@@ -435,6 +435,7 @@ int usbhs_init_phys(struct usbhs_phy_data *phy, int num_phys)
 	struct platform_device *pdev;
 	char *phy_id;
 	struct platform_device_info pdevinfo;
+	struct nop_usb_xceiv_platform_data nop_pdata;
 
 	for (i = 0; i < num_phys; i++) {
 
@@ -455,11 +456,19 @@ int usbhs_init_phys(struct usbhs_phy_data *phy, int num_phys)
 			return -ENOMEM;
 		}
 
+		/* set platform data */
+		memset(&nop_pdata, 0, sizeof(nop_pdata));
+		if (gpio_is_valid(phy->vcc_gpio))
+			nop_pdata.needs_vcc = true;
+		if (gpio_is_valid(phy->reset_gpio))
+			nop_pdata.needs_reset = true;
+		nop_pdata.type = USB_PHY_TYPE_USB2;
+
 		/* create a NOP PHY device */
 		memset(&pdevinfo, 0, sizeof(pdevinfo));
 		pdevinfo.name = nop_name;
 		pdevinfo.id = phy->port;
-		pdevinfo.data = phy->platform_data;
+		pdevinfo.data = &nop_pdata;
 		pdevinfo.size_data = sizeof(struct nop_usb_xceiv_platform_data);
 
 		scnprintf(phy_id, MAX_STR, "nop_usb_xceiv.%d",
diff --git a/arch/arm/mach-omap2/usb.h b/arch/arm/mach-omap2/usb.h
index e7261eb..4ba2ae7 100644
--- a/arch/arm/mach-omap2/usb.h
+++ b/arch/arm/mach-omap2/usb.h
@@ -58,7 +58,6 @@ struct usbhs_phy_data {
 	int reset_gpio;
 	int vcc_gpio;
 	bool vcc_polarity;	/* 1 active high, 0 active low */
-	void *platform_data;
 };
 
 extern void usb_musb_init(struct omap_musb_board_data *board_data);
-- 
1.7.4.1

