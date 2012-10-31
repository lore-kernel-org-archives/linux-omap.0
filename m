From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 02/11] ARM: OMAP4: USB: Host: Panda board specific device tree node
Date: Wed, 31 Oct 2012 17:46:40 +0530
Message-ID: <1351685810-20616-3-git-send-email-keshava_mgowda@ti.com>
References: <1351685810-20616-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1351685810-20616-1-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

OMAP4 panda board specific device tree node is included.

In OMAP4 panda board, the port 1 is used in ULPI PHY mode.
The port 1 is connected to a on board hub with ethernet
interface.

TODO:
   The clock bindings are not yet avilable for OMAP4.
   hence , USB hub specific clocks are exported as device tree string
   paramters.
   Will be changed to use the clock bindings later

Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap4-panda.dts |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index e8f927c..dad0df6 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -184,3 +184,36 @@
 &dmic {
 	status = "disabled";
 };
+
+&usbhs {
+	/*
+	 * Maximum fill 3 port info.
+	 * port configured can be any one of the following values
+	 * OMAP_USBHS_PORT_MODE_UNUSED			= 0,
+	 * OMAP_EHCI_PORT_MODE_PHY				= 1,
+	 * OMAP_EHCI_PORT_MODE_TLL				= 2,
+	 * OMAP_EHCI_PORT_MODE_HSIC				= 3,
+	 * OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0	= 4,
+	 * OMAP_OHCI_PORT_MODE_PHY_6PIN_DPDM	= 5,
+	 * OMAP_OHCI_PORT_MODE_PHY_3PIN_DATSE0	= 6,
+	 * OMAP_OHCI_PORT_MODE_PHY_4PIN_DPDM	= 7,
+	 * OMAP_OHCI_PORT_MODE_TLL_6PIN_DATSE0	= 8,
+	 * OMAP_OHCI_PORT_MODE_TLL_6PIN_DPDM	= 9,
+	 * OMAP_OHCI_PORT_MODE_TLL_3PIN_DATSE0	= 10,
+	 * OMAP_OHCI_PORT_MODE_TLL_4PIN_DPDM	= 11,
+	 * OMAP_OHCI_PORT_MODE_TLL_2PIN_DATSE0	= 12,
+	 * OMAP_OHCI_PORT_MODE_TLL_2PIN_DPDM	= 13,
+	 */
+	port-0 = <1>;
+	port-1 = <0>;
+	port-2 = <0>;
+
+	/*
+	 * In some boards, the controller is always connected to hub
+	 * the pandboard always has the hub connect to port0 of usbhs controller
+	 */
+	hub-power-gpio = <&gpio1 1 0>;
+	hub-reset-gpio = <&gpio2 30 0>;  /* gpio 62 */
+	hub-clk = "auxclk3_ck";
+	hub-clkrate = <19200000>;
+};
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
