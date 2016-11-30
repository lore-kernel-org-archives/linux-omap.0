From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [PATCH] ARM: omap3: beagleboard-xm: dt: Add ethernet to the device tree
Date: Wed, 30 Nov 2016 19:58:05 +0200
Message-ID: <1480528685-26259-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The Beagleboard-xM has a LAN9514 USB hub and ethernet controller,
connected to port 2 of the OMAP EHCI controller. The board however has
no EEPROM to store the ethernet MAC address, which is programmed by the
boot loader.

To allow Linux to use the same MAC address as the boot loader (or for
that matter any fixed MAC address), we need a node in the device tree
for the ethernet controller that the boot loader can update at runtime
with a local-mac-address property. Add it, along with an alias for the
ethernet controller to let the boot loader locate it easily.

Signed-off-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 arch/arm/boot/dts/omap3-beagle-xm.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index 85e297ed0ea1..75ac56cdf954 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -27,6 +27,7 @@
 	aliases {
 		display0 = &dvi0;
 		display1 = &tv0;
+		ethernet = &ethernet;
 	};
 
 	leds {
@@ -348,6 +349,21 @@
 
 &usbhsehci {
 	phys = <0 &hsusb2_phy>;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	usb2@2 {
+		compatible = "usb424,9514";
+		reg = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethernet: usbether@1 {
+			compatible = "usb424,ec00";
+			reg = <1>;
+		};
+	};
 };
 
 &vaux2 {
-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
