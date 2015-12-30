From: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH 1/3] ARM: dts: cm-t335: Add support for CAN bus
Date: Wed, 30 Dec 2015 13:41:33 +0200
Message-ID: <1451475695-26921-2-git-send-email-uri.mashiach@compulab.co.il>
References: <1451475695-26921-1-git-send-email-uri.mashiach@compulab.co.il>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1451475695-26921-1-git-send-email-uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add CAN bus pinmux.
Enable D_CAN bus controllers 0 and 1

The pinmux of uart1 node contradicts the pinmux of dcan0 and dcan1 nodes.
U-Boot should delete the uart1 or dcan0/1 nodes.

Signed-off-by: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Acked-by: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
---
 arch/arm/boot/dts/am335x-cm-t335.dts | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
index b700940..f3d7845 100644
--- a/arch/arm/boot/dts/am335x-cm-t335.dts
+++ b/arch/arm/boot/dts/am335x-cm-t335.dts
@@ -144,6 +144,24 @@
 		>;
 	};
 
+	dcan0_pins: pinmux_dcan0_pins {
+		pinctrl-single,pins = <
+			/* uart1_ctsn.dcan0_tx */
+			AM33XX_IOPAD(0x978, PIN_OUTPUT | MUX_MODE2)
+			/* uart1_rtsn.dcan0_rx */
+			AM33XX_IOPAD(0x97C, PIN_INPUT | MUX_MODE2)
+		>;
+	};
+
+	dcan1_pins: pinmux_dcan1_pins {
+		pinctrl-single,pins = <
+			/* uart1_rxd.dcan1_tx */
+			AM33XX_IOPAD(0x980, PIN_OUTPUT | MUX_MODE2)
+			/* uart1_txd.dcan1_rx */
+			AM33XX_IOPAD(0x984, PIN_INPUT | MUX_MODE2)
+		>;
+	};
+
 	ecap0_pins: pinmux_ecap0_pins {
 		pinctrl-single,pins = <
 			/* eCAP0_in_PWM0_out.eCAP0_in_PWM0_out MODE0 */
@@ -448,3 +466,15 @@ status = "okay";
 		vwlan-supply = <&vwlan_fixed>;
 	};
 };
+
+&dcan0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&dcan0_pins>;
+};
+
+&dcan1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&dcan1_pins>;
+};
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
