From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/2] ARM: dts: am437x-gp-evm: Add pinctrl states for usb
Date: Mon, 31 Aug 2015 21:09:09 +0530
Message-ID: <4a8a072030c2a82867c6548627739146681b35a5.1441029572.git.nsekhar@ti.com>
References: <cover.1441029572.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1441029572.git.nsekhar-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux ARM Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>

Add pinctrl default and sleep states for each usb device.
The only pin that can be controlled is USB_DRVVBUS, this
must be set to MUX_MODE7 (gpio) during sleep to conserve
power.

Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
[nsekhar-l0cyMroinI0@public.gmane.org: move pins to core dwc3]
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am437x-gp-evm.dts | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 84aa30c3235a..2e990a5f9e95 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -409,6 +409,30 @@
 			0x234 (PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* uart3_rtsn.uart3_rtsn */
 		>;
 	};
+
+	usb1_pins_default: usb1_pins_default {
+		pinctrl-single,pins = <
+			0x2c0 (DS0_PULL_UP_DOWN_EN | PIN_INPUT_PULLDOWN | MUX_MODE0)
+		>;
+	};
+
+	usb1_pins_sleep: usb1_pins_sleep {
+		pinctrl-single,pins = <
+			0x2c0 (DS0_PULL_UP_DOWN_EN | PIN_INPUT_PULLDOWN | MUX_MODE7)
+		>;
+	};
+
+	usb2_pins_default: usb2_pins_default {
+		pinctrl-single,pins = <
+			0x2c4 (DS0_PULL_UP_DOWN_EN | PIN_INPUT_PULLDOWN | MUX_MODE0)
+		>;
+	};
+
+	usb2_pins_sleep: usb2_pins_sleep {
+		pinctrl-single,pins = <
+			0x2c4 (DS0_PULL_UP_DOWN_EN | PIN_INPUT_PULLDOWN | MUX_MODE7)
+		>;
+	};
 };
 
 &i2c0 {
@@ -615,6 +639,9 @@
 &usb1 {
 	dr_mode = "peripheral";
 	status = "okay";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&usb1_pins_default>;
+	pinctrl-1 = <&usb1_pins_sleep>;
 };
 
 &usb2_phy2 {
@@ -624,6 +651,9 @@
 &usb2 {
 	dr_mode = "host";
 	status = "okay";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&usb2_pins_default>;
+	pinctrl-1 = <&usb2_pins_sleep>;
 };
 
 &mac {
-- 
2.4.4.408.g16da57c

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
