From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 04/11] ARM: OMAP3: USB: Host: Beagle-XM board specific device tree node
Date: Wed, 31 Oct 2012 17:46:42 +0530
Message-ID: <1351685810-20616-5-git-send-email-keshava_mgowda@ti.com>
References: <1351685810-20616-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1351685810-20616-1-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

OMAP3 Beagle-XM board specific data for usb2 host device tree node
is included.
In Beagle XM board , the port 2 of usb host is connected to a hub
with ethernet interface.

Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap3-beagle-xm.dts |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index c38cf76..b9f8667 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -113,3 +113,35 @@
 	 */
 	ti,pulldowns = <0x03a1c4>;
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
+	port-0 = <0>;
+	port-1 = <1>;
+	port-2 = <0>;
+
+	/*
+	 * gpio resets should be given the format ( Max of 3 ports)
+	 * reset-gpio-1 = <&gpiox x x>
+	 * reset-gpio-2 = <&gpiox x x>
+	 * reset-gpio-3 = <&gpiox x x>
+	 */
+	reset-gpio-2 = <&gpio5 19 0>;   /* gpio 147 */
+};
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
