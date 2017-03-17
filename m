From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 3/3] ARM: dts: omap4-droid4: Add CPCAP PMIC OTG PHY configuration
Date: Thu, 16 Mar 2017 21:10:12 -0700
Message-ID: <20170317041012.26800-4-tony@atomide.com>
References: <20170317041012.26800-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170317041012.26800-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add CPCAP PMIC OTG PHY configuration.

Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
--- a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
+++ b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
@@ -65,6 +65,29 @@
 			interrupts = <23 IRQ_TYPE_NONE>;
 		};
 
+		cpcap_usb2_phy: phy {
+			compatible = "motorola,mapphone-cpcap-usb-phy";
+			pinctrl-0 = <&usb_gpio_mux_sel1 &usb_gpio_mux_sel2>;
+			pinctrl-1 = <&usb_ulpi_pins>;
+			pinctrl-2 = <&usb_utmi_pins>;
+			pinctrl-3 = <&uart3_pins>;
+			pinctrl-names = "default", "ulpi", "utmi", "uart";
+			#phy-cells = <0>;
+			interrupts-extended = <
+				&cpcap 15 0 &cpcap 14 0 &cpcap 28 0 &cpcap 19 0
+				&cpcap 18 0 &cpcap 17 0 &cpcap 16 0 &cpcap 49 0
+				&cpcap 48 1
+			>;
+			interrupt-names =
+				"id_ground", "id_float", "se0conn", "vbusvld",
+				"sessvld", "sessend", "se1", "dm", "dp";
+			mode-gpios = <&gpio2 28 GPIO_ACTIVE_HIGH
+				      &gpio1 0 GPIO_ACTIVE_HIGH>;
+			io-channels = <&cpcap_adc 2>, <&cpcap_adc 7>;
+			io-channel-names = "vbus", "id";
+			vusb-supply = <&vusb>;
+		};
+
 		led_red: led-red {
 			compatible = "motorola,cpcap-led-red";
 			vdd-supply = <&sw5>;
-- 
2.11.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
