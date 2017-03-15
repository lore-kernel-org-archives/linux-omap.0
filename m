From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] ARM: dts: omap4-droid4: Configure EHCI so modems can be accessed
Date: Tue, 14 Mar 2017 17:40:33 -0700
Message-ID: <20170315004033.28852-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Droid 4 has two modems, mdm6600 and w3glte. Both are on the HCI USB
controller.

Let's add a configuration for the HCI so the modems can be enabled.

Note that the modems still need GPIO based configuration that can
be done with the test-d4-echi shell script I've posted to:

http://muru.com/linux/d4/test-d4-ehci

Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -71,6 +71,11 @@
 		regulator-always-on;
 	};
 
+	/* HS USB Host PHY on PORT 1 */
+	hsusb1_phy: hsusb1_phy {
+		compatible = "usb-nop-xceiv";
+	};
+
 	/* LCD regulator from sw5 source */
 	lcd_regulator: regulator-lcd {
 		compatible = "regulator-fixed";
@@ -475,6 +480,15 @@
 			       &omap4_pmx_core 0x17c>;
 };
 
+&usbhsehci {
+	phys = <&hsusb1_phy>;
+};
+
+&usbhshost {
+	port1-mode = "ohci-phy-4pin-dpdm";
+	port2-mode = "ehci-tll";
+};
+
 /* Internal UTMI+ PHY used for OTG, CPCAP ULPI PHY for detection and charger */
 &usb_otg_hs {
 	interface-type = <1>;
-- 
2.11.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
