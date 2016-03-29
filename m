From: Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 3/5] ARM: dts: omap4-kc1: USB OTG support
Date: Tue, 29 Mar 2016 21:28:25 +0200
Message-ID: <1459279707-17611-5-git-send-email-contact@paulk.fr>
References: <1459279707-17611-1-git-send-email-contact@paulk.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459279707-17611-1-git-send-email-contact@paulk.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Paul Kocialkowski <contact@paulk.fr>
List-Id: linux-omap@vger.kernel.org

This adds support for USB OTG on the Kindle Fire (first generation).

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/omap4-kc1.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-kc1.dts b/arch/arm/boot/dts/omap4-kc1.dts
index 9fe4441..0d08f9f 100644
--- a/arch/arm/boot/dts/omap4-kc1.dts
+++ b/arch/arm/boot/dts/omap4-kc1.dts
@@ -71,6 +71,14 @@
 			OMAP4_IOPAD(0x084, PIN_INPUT_PULLUP | MUX_MODE1)	/* sdmmc2_cmd */
 		>;
 	};
+
+	usb_otg_hs_pins: pinmux_usb_otg_hs_pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x194, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* usba0_otg_ce */
+			OMAP4_IOPAD(0x196, PIN_INPUT | MUX_MODE0)		/* usba0_otg_dp */
+			OMAP4_IOPAD(0x198, PIN_INPUT | MUX_MODE0)		/* usba0_otg_dm */
+		>;
+	};
 };
 
 &uart3 {
@@ -136,5 +144,18 @@
 	status = "disabled";
 };
 
+&usb_otg_hs {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb_otg_hs_pins>;
+
+	interface-type = <1>;
+	mode = <3>;
+	power = <50>;
+};
+
 #include "twl6030.dtsi"
 #include "twl6030_omap4.dtsi"
+
+&twl_usb_comparator {
+	usb-supply = <&vusb>;
+};
-- 
2.7.4
