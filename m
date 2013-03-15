From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 11/23] ARM: OMAP3: cm-t3517: Adapt to ehci-omap changes
Date: Fri, 15 Mar 2013 17:16:32 +0200
Message-ID: <1363360604-21368-12-git-send-email-rogerq@ti.com>
References: <1363360604-21368-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1363360604-21368-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
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

Use usbhs_init_phys() to register the PHY's RESET regulators.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/board-cm-t3517.c |   45 ++++++++++++++++++++++++++++++----
 1 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index a66da80..5e64be1 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -34,6 +34,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mmc/host.h>
 #include <linux/can/platform/ti_hecc.h>
+#include <linux/usb/phy.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -188,15 +189,41 @@ static inline void cm_t3517_init_rtc(void) {}
 #define HSUSB2_RESET_GPIO	(147)
 #define USB_HUB_RESET_GPIO	(152)
 
+/* PHY device on HS USB Port 1 i.e. nop_usb_xceiv.1 */
+static struct platform_device hsusb1_phy_device = {
+	.name = "nop_usb_xceiv",
+	.id = 1,
+};
+
+/* PHY device on HS USB Port 2 i.e. nop_usb_xceiv.2 */
+static struct platform_device hsusb2_phy_device = {
+	.name = "nop_usb_xceiv",
+	.id = 2,
+};
+
+static struct usbhs_phy_data phy_data[] __initdata = {
+	{
+		.port = 1,
+		.reset_gpio = HSUSB1_RESET_GPIO,
+		.vcc_gpio = -EINVAL,
+		.phy_id = "nop_usb_xceiv.1",
+	},
+	{
+		.port = 2,
+		.reset_gpio = HSUSB2_RESET_GPIO,
+		.vcc_gpio = -EINVAL,
+		.phy_id = "nop_usb_xceiv.2",
+	},
+};
+
 static struct usbhs_omap_platform_data cm_t3517_ehci_pdata __initdata = {
 	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
 	.port_mode[1] = OMAP_EHCI_PORT_MODE_PHY,
-	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
+};
 
-	.phy_reset  = true,
-	.reset_gpio_port[0]  = HSUSB1_RESET_GPIO,
-	.reset_gpio_port[1]  = HSUSB2_RESET_GPIO,
-	.reset_gpio_port[2]  = -EINVAL,
+static struct platform_device *usbhs_devices[] = {
+	&hsusb1_phy_device,
+	&hsusb2_phy_device,
 };
 
 static int __init cm_t3517_init_usbh(void)
@@ -213,6 +240,14 @@ static int __init cm_t3517_init_usbh(void)
 		msleep(1);
 	}
 
+	platform_add_devices(usbhs_devices, ARRAY_SIZE(usbhs_devices));
+
+	/* PHY on HSUSB Port 1 i.e. index 0 */
+	usb_bind_phy("ehci-omap.0", 0, "nop_usb_xceiv.1");
+	/* PHY on HSUSB Port 2 i.e. index 1 */
+	usb_bind_phy("ehci-omap.0", 1, "nop_usb_xceiv.2");
+
+	usbhs_init_phys(phy_data, ARRAY_SIZE(phy_data));
 	usbhs_init(&cm_t3517_ehci_pdata);
 
 	return 0;
-- 
1.7.4.1
