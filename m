From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 05/24] ARM: OMAP3: 3430SDP: Adapt to ehci-omap changes
Date: Tue, 12 Mar 2013 13:43:07 +0200
Message-ID: <1363088606-2692-6-git-send-email-rogerq@ti.com>
References: <1363088606-2692-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1363088606-2692-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Add 2 platform devices for 'nop-usb-xceiv'. These will be used
as PHYs for HS USB ports 1 and 2 so provide binding information
for them.

Model RESET for HS USB Ports 1 and 2 as GPIO fixed regulators and
link them to the 2 PHYs we just created.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/board-3430sdp.c |   97 ++++++++++++++++++++++++++++++++--
 1 files changed, 91 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index ce812de..7e3c88a 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -21,6 +21,8 @@
 #include <linux/spi/spi.h>
 #include <linux/i2c/twl.h>
 #include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
+#include <linux/usb/phy.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/mmc/host.h>
@@ -445,16 +447,86 @@ static void enable_board_wakeup_source(void)
 		OMAP_WAKEUP_EN | OMAP_PIN_INPUT_PULLUP);
 }
 
+/* PHY device on HS USB Port 1 i.e. nop_usb_xceiv.1 */
+static struct platform_device hsusb1_phy_device = {
+	.name = "nop_usb_xceiv",
+	.id = 1,
+};
+
+/* Regulator for HS USB Port 1 PHY reset */
+static struct regulator_consumer_supply hsusb1_reset_supplies[] = {
+	/* Link PHY device to reset supply so it gets used in the PHY driver */
+	REGULATOR_SUPPLY("reset", "nop_usb_xceiv.1"),
+};
+
+static struct regulator_init_data hsusb1_reset_data = {
+	.constraints = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+	.consumer_supplies = hsusb1_reset_supplies,
+	.num_consumer_supplies = ARRAY_SIZE(hsusb1_reset_supplies),
+};
+
+static struct fixed_voltage_config hsusb1_reset_config = {
+	.supply_name = "hsusb1_reset",
+	.microvolts = 3300000,
+	.gpio = 57,
+	.startup_delay = 70000, /* 70msec */
+	.enable_high = 1,
+	.enabled_at_boot = 0,   /* keep in RESET */
+	.init_data = &hsusb1_reset_data,
+};
+
+static struct platform_device hsusb1_reset_device = {
+	.name = "reg-fixed-voltage",
+	.id = PLATFORM_DEVID_AUTO,
+	.dev = {
+		.platform_data = &hsusb1_reset_config,
+	},
+};
+
+/* PHY device on HS USB Port 2 i.e. nop_usb_xceiv.2 */
+static struct platform_device hsusb2_phy_device = {
+	.name = "nop_usb_xceiv",
+	.id = 2,
+};
+
+/* Regulator for HS USB Port 2 PHY reset */
+static struct regulator_consumer_supply hsusb2_reset_supplies[] = {
+	/* Link PHY device to reset supply so it gets used in the PHY driver */
+	REGULATOR_SUPPLY("reset", "nop_usb_xceiv.2"),
+};
+
+static struct regulator_init_data hsusb2_reset_data = {
+	.constraints = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+	.consumer_supplies = hsusb2_reset_supplies,
+	.num_consumer_supplies = ARRAY_SIZE(hsusb2_reset_supplies),
+};
+
+static struct fixed_voltage_config hsusb2_reset_config = {
+	.supply_name = "hsusb2_reset",
+	.microvolts = 3300000,
+	.gpio = 61,
+	.startup_delay = 70000, /* 70msec */
+	.enable_high = 1,
+	.enabled_at_boot = 0,   /* keep in RESET */
+	.init_data = &hsusb2_reset_data,
+};
+
+static struct platform_device hsusb2_reset_device = {
+	.name = "reg-fixed-voltage",
+	.id = PLATFORM_DEVID_AUTO,
+	.dev = {
+		.platform_data = &hsusb2_reset_config,
+	},
+};
+
 static struct usbhs_omap_platform_data usbhs_bdata __initdata = {
 
 	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
 	.port_mode[1] = OMAP_EHCI_PORT_MODE_PHY,
-	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
-
-	.phy_reset  = true,
-	.reset_gpio_port[0]  = 57,
-	.reset_gpio_port[1]  = 61,
-	.reset_gpio_port[2]  = -EINVAL
 };
 
 #ifdef CONFIG_OMAP_MUX
@@ -585,6 +657,13 @@ static struct flash_partitions sdp_flash_partitions[] = {
 	},
 };
 
+static struct platform_device *sdp3430_devices[] __initdata = {
+	&hsusb1_phy_device,
+	&hsusb1_reset_device,
+	&hsusb2_phy_device,
+	&hsusb2_reset_device,
+};
+
 static void __init omap_3430sdp_init(void)
 {
 	int gpio_pendown;
@@ -606,6 +685,12 @@ static void __init omap_3430sdp_init(void)
 	board_flash_init(sdp_flash_partitions, chip_sel_3430, 0);
 	sdp3430_display_init();
 	enable_board_wakeup_source();
+
+	platform_add_devices(sdp3430_devices, ARRAY_SIZE(sdp3430_devices));
+	/* PHY on HSUSB Port 1 i.e. index 0 */
+	usb_bind_phy("ehci-omap.0", 0, "nop_usb_xceiv.1");
+	/* PHY on HSUSB Port 2 i.e. index 1 */
+	usb_bind_phy("ehci-omap.0", 1, "nop_usb_xceiv.2");
 	usbhs_init(&usbhs_bdata);
 }
 
-- 
1.7.4.1
