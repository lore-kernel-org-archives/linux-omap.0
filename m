From: Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] ARM: dts: am335x-bone-common: Add i2c2 definition
Date: Fri,  9 May 2014 18:43:04 -0700
Message-ID: <1399686184-1594-1-git-send-email-mranostay@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pantelis.antoniou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add missing i2c2 bus define to access various cape and
prototype/breakout board devices.

Signed-off-by: Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index 2e7d932..5fdae2e 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -84,6 +84,13 @@
 		>;
 	};
 
+	i2c2_pins: pinmux_i2c2_pins {
+		pinctrl-single,pins = <
+			0x178 (PIN_INPUT_PULLUP | MUX_MODE3)	/* uart1_ctsn.i2c2_sda */
+			0x17c (PIN_INPUT_PULLUP | MUX_MODE3)	/* uart1_rtsn.i2c2_scl */
+		>;
+	};
+
 	uart0_pins: pinmux_uart0_pins {
 		pinctrl-single,pins = <
 			0x170 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
@@ -222,6 +229,15 @@
 
 };
 
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
+
+	status = "okay";
+	clock-frequency = <100000>;
+};
+
 /include/ "tps65217.dtsi"
 
 &tps {
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
