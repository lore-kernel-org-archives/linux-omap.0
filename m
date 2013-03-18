From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 4/4] ARM: OMAP3: Beagle: Adapt to ehci-omap changes
Date: Mon, 18 Mar 2013 14:51:18 +0200
Message-ID: <1363611078-13002-5-git-send-email-rogerq@ti.com>
References: <1363611078-13002-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1363611078-13002-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Use usbhs_init_phys() to register the PHY's VCC and RESET
regulators and the NOP PHY device.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   32 +++++++++++++++++++++---------
 1 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index c3558f9..5382215 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -33,6 +33,7 @@
 #include <linux/mtd/nand.h>
 #include <linux/mmc/host.h>
 #include <linux/usb/phy.h>
+#include <linux/usb/nop-usb-xceiv.h>
 
 #include <linux/regulator/machine.h>
 #include <linux/i2c/twl.h>
@@ -277,6 +278,21 @@ static struct regulator_consumer_supply beagle_vsim_supply[] = {
 
 static struct gpio_led gpio_leds[];
 
+/* PHY's VCC regulator might be added later, so flag that we need it */
+static struct nop_usb_xceiv_platform_data hsusb2_phy_data = {
+	.needs_vcc = true,
+};
+
+static struct usbhs_phy_data phy_data[] = {
+	{
+		.port = 2,
+		.reset_gpio = 147,
+		.vcc_gpio = -1,		/* updated in beagle_twl_gpio_setup */
+		.vcc_polarity = 1,	/* updated in beagle_twl_gpio_setup */
+		.platform_data = &hsusb2_phy_data,
+	},
+};
+
 static int beagle_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
@@ -318,9 +334,11 @@ static int beagle_twl_gpio_setup(struct device *dev,
 	}
 	dvi_panel.power_down_gpio = beagle_config.dvi_pd_gpio;
 
-	gpio_request_one(gpio + TWL4030_GPIO_MAX, beagle_config.usb_pwr_level,
-			"nEN_USB_PWR");
+	/* TWL4030_GPIO_MAX i.e. LED_GPO controls HS USB Port 2 power */
+	phy_data[0].vcc_gpio = gpio + TWL4030_GPIO_MAX;
+	phy_data[0].vcc_polarity = beagle_config.usb_pwr_level;
 
+	usbhs_init_phys(phy_data, ARRAY_SIZE(phy_data));
 	return 0;
 }
 
@@ -453,15 +471,7 @@ static struct platform_device *omap3_beagle_devices[] __initdata = {
 };
 
 static struct usbhs_omap_platform_data usbhs_bdata __initdata = {
-
-	.port_mode[0] = OMAP_USBHS_PORT_MODE_UNUSED,
 	.port_mode[1] = OMAP_EHCI_PORT_MODE_PHY,
-	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
