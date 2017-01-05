From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 3/3] ARM: dts: omap5-igep0050: Allow bootloader to configure USB Ethernet MAC
Date: Thu,  5 Jan 2017 08:37:03 -0800
Message-ID: <20170105163703.1982-4-tony@atomide.com>
References: <20170105163703.1982-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170105163703.1982-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This is slightly different wiring compared to omap5-uevm or pandaboard:

/sys/bus/usb/devices/3-2	hub
/sys/bus/usb/devices/3-2.3	7500

Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/omap5-igep0050.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-igep0050.dts b/arch/arm/boot/dts/omap5-igep0050.dts
--- a/arch/arm/boot/dts/omap5-igep0050.dts
+++ b/arch/arm/boot/dts/omap5-igep0050.dts
@@ -19,6 +19,10 @@
 		reg = <0x0 0x80000000 0 0x7f000000>;	/* 2032 MB */
 	};
 
+	aliases {
+		ethernet = &ethernet;
+	};
+
 	gpio_keys {
 		compatible = "gpio-keys";
 		pinctrl-0 = <&power_button_pin>;
@@ -116,3 +120,20 @@
 		OMAP5_IOPAD(0x1ca, PIN_OUTPUT | MUX_MODE6)	/* perslimbus2_clock.gpio5_145 */
 	>;
 };
+
+&usbhsehci {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	hub@2 {
+		compatible = "usb424,3503";
+		reg = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethernet: usbether@3 {
+			compatible = "usb424,7500";
+			reg = <3>;
+		};
+	};
+};
-- 
2.11.0
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
