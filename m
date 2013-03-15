From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 09/23] ARM: OMAP: AM3517evm: Adapt to ehci-omap changes
Date: Fri, 15 Mar 2013 17:16:30 +0200
Message-ID: <1363360604-21368-10-git-send-email-rogerq@ti.com>
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

Add 2 platform devices for 'nop-usb-xceiv'. These will be used as a
PHY for HS USB Port 1 and 2, so provide binding information for them.

Use usbhs_init_phys() to register the PHY's RESET regulators.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/board-am3517evm.c |   41 ++++++++++++++++++++++++++++-----
 1 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 9fb8590..4e1283d 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -25,6 +25,7 @@
 #include <linux/can/platform/ti_hecc.h>
 #include <linux/davinci_emac.h>
 #include <linux/mmc/host.h>
+#include <linux/usb/phy.h>
 #include <linux/usb/musb.h>
 #include <linux/platform_data/gpio-omap.h>
 
@@ -274,6 +275,27 @@ static __init void am3517_evm_mcbsp1_init(void)
 	omap_ctrl_writel(devconf0, OMAP2_CONTROL_DEVCONF0);
 }
 
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
+		.reset_gpio = 57,
+		.vcc_gpio = -EINVAL,
+		.phy_id = "nop_usb_xceiv.1",
+	},
+};
+
 static struct usbhs_omap_platform_data usbhs_bdata __initdata = {
 	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
 #if defined(CONFIG_PANEL_SHARP_LQ043T1DG01) || \
@@ -282,12 +304,6 @@ static struct usbhs_omap_platform_data usbhs_bdata __initdata = {
 #else
 	.port_mode[1] = OMAP_EHCI_PORT_MODE_PHY,
 #endif
-	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
-
-	.phy_reset  = true,
-	.reset_gpio_port[0]  = 57,
-	.reset_gpio_port[1]  = -EINVAL,
-	.reset_gpio_port[2]  = -EINVAL
 };
 
 #ifdef CONFIG_OMAP_MUX
@@ -349,6 +365,10 @@ static struct omap2_hsmmc_info mmc[] = {
 	{}      /* Terminator */
 };
 
+static struct platform_device *am3517evm_devices[] __initdata = {
+	&hsusb1_phy_device,
+	&hsusb2_phy_device,
+};
 
 static void __init am3517_evm_init(void)
 {
@@ -361,6 +381,15 @@ static void __init am3517_evm_init(void)
 
 	/* Configure GPIO for EHCI port */
 	omap_mux_init_gpio(57, OMAP_PIN_OUTPUT);
+
+	platform_add_devices(am3517evm_devices, ARRAY_SIZE(am3517evm_devices));
+
+	/* PHY on HSUSB Port 1 i.e. index 0 */
+	usb_bind_phy("ehci-omap.0", 0, "nop_usb_xceiv.1");
+	/* PHY on HSUSB Port 2 i.e. index 1 */
+	usb_bind_phy("ehci-omap.0", 1, "nop_usb_xceiv.2");
+
+	usbhs_init_phys(phy_data, ARRAY_SIZE(phy_data));
 	usbhs_init(&usbhs_bdata);
 	am3517_evm_hecc_init(&am3517_evm_hecc_pdata);
 	/* DSS */
-- 
1.7.4.1
