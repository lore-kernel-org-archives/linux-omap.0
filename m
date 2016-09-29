From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: [PATCH v3 3/3] ARM: dts: omap5 uevm: add USR1 button
Date: Thu, 29 Sep 2016 07:25:38 +0200
Message-ID: <69d19d0153f03a0ecd23fdf4a47bcb8a42d7f647.1475126737.git.hns@goldelico.com>
References: <cover.1475126737.git.hns@goldelico.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1475126737.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
In-Reply-To: <cover.1475126737.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
References: <cover.1475126737.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
---
 arch/arm/boot/dts/omap5-uevm.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 31ce4f8..0f50baf 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -18,6 +18,25 @@
 		reg = <0x80000000 0x7F000000>; /* 2032 MB */
 	};
 
+	evm_keys {
+		compatible = "gpio-keys";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&evm_keys_pins>;
+
+		#address-cells = <7>;
+		#size-cells = <0>;
+
+		btn1 {
+			label = "BTN1";
+			linux,code = <169>;
+			gpios = <&gpio3 19 GPIO_ACTIVE_LOW>;	/* gpio3_83 */
+			gpio-key,wakeup;
+			autorepeat;
+			debounce_interval = <50>;
+		};
+	};
+
 	evm_leds {
 		compatible = "gpio-leds";
 
@@ -105,6 +124,12 @@
 };
 
 &omap5_pmx_core {
+	evm_keys_pins: pinmux_evm_keys_gpio_pins {
+		pinctrl-single,pins = <
+			OMAP5_IOPAD(0x0b6, PIN_INPUT | MUX_MODE6)	/* gpio3_83 */
+		>;
+	};
+
 	i2c5_pins: pinmux_i2c5_pins {
 		pinctrl-single,pins = <
 			OMAP5_IOPAD(0x1c6, PIN_INPUT | MUX_MODE0)		/* i2c5_scl */
-- 
2.7.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
