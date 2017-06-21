From: Tom Rini <trini-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 1/2] ARM: dts: dm816x: Correct NAND support nodes
Date: Wed, 21 Jun 2017 07:42:26 -0400
Message-ID: <1498045347-27324-1-git-send-email-trini@konsulko.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Mihail Grigorov <michael.grigorov-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The ELM node in dm816x.dtsi needs to declare the correct compatible
value here as per the binding only one value is correct, and the current
driver handles it correctly.  We then add pinmux information for the
NAND found on the EVM so that we do not rely on the ROM to do this for
us, and also so that we do not try and probe NAND before we probe the
ELM.

Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Mihail Grigorov <michael.grigorov-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Signed-off-by: Tom Rini <trini-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
---
 arch/arm/boot/dts/dm8168-evm.dts | 32 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dm816x.dtsi    |  2 +-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dm8168-evm.dts b/arch/arm/boot/dts/dm8168-evm.dts
index 1865976db5f9..996eba0c2e7a 100644
--- a/arch/arm/boot/dts/dm8168-evm.dts
+++ b/arch/arm/boot/dts/dm8168-evm.dts
@@ -68,6 +68,34 @@
 			DM816X_IOPAD(0x0d08, MUX_MODE0)			/* USB1_DRVVBUS */
 		>;
 	};
+
+	nandflash_pins: nandflash_pins {
+		pinctrl-single,pins = <
+			DM816X_IOPAD(0x0b38, PULL_UP | MUX_MODE0)		/* PINCTRL207 GPMC_CS0*/
+			DM816X_IOPAD(0x0b60, PULL_ENA | MUX_MODE0)		/* PINCTRL217 GPMC_ADV_ALE */
+			DM816X_IOPAD(0x0b54, PULL_UP | PULL_ENA | MUX_MODE0)	/* PINCTRL214 GPMC_OE_RE */
+			DM816X_IOPAD(0x0b58, PULL_ENA | MUX_MODE0)		/* PINCTRL215 GPMC_BE0_CLE */
+			DM816X_IOPAD(0x0b50, PULL_UP | MUX_MODE0)		/* PINCTRL213 GPMC_WE */
+			DM816X_IOPAD(0x0b6c, MUX_MODE0)				/* PINCTRL220 GPMC_WAIT */
+			DM816X_IOPAD(0x0be4, PULL_ENA | MUX_MODE0)		/* PINCTRL250 GPMC_CLK */
+			DM816X_IOPAD(0x0ba4, MUX_MODE0)				/* PINCTRL234 GPMC_D0 */
+			DM816X_IOPAD(0x0ba8, MUX_MODE0)				/* PINCTRL234 GPMC_D1 */
+			DM816X_IOPAD(0x0bac, MUX_MODE0)				/* PINCTRL234 GPMC_D2 */
+			DM816X_IOPAD(0x0bb0, MUX_MODE0)				/* PINCTRL234 GPMC_D3 */
+			DM816X_IOPAD(0x0bb4, MUX_MODE0)				/* PINCTRL234 GPMC_D4 */
+			DM816X_IOPAD(0x0bb8, MUX_MODE0)				/* PINCTRL234 GPMC_D5 */
+			DM816X_IOPAD(0x0bbc, MUX_MODE0)				/* PINCTRL234 GPMC_D6 */
+			DM816X_IOPAD(0x0bc0, MUX_MODE0)				/* PINCTRL234 GPMC_D7 */
+			DM816X_IOPAD(0x0bc4, MUX_MODE0)				/* PINCTRL234 GPMC_D8 */
+			DM816X_IOPAD(0x0bc8, MUX_MODE0)				/* PINCTRL234 GPMC_D9 */
+			DM816X_IOPAD(0x0bcc, MUX_MODE0)				/* PINCTRL234 GPMC_D10 */
+			DM816X_IOPAD(0x0bd0, MUX_MODE0)				/* PINCTRL234 GPMC_D11 */
+			DM816X_IOPAD(0x0bd4, MUX_MODE0)				/* PINCTRL234 GPMC_D12 */
+			DM816X_IOPAD(0x0bd8, MUX_MODE0)				/* PINCTRL234 GPMC_D13 */
+			DM816X_IOPAD(0x0bdc, MUX_MODE0)				/* PINCTRL234 GPMC_D14 */
+			DM816X_IOPAD(0x0be0, MUX_MODE0)				/* PINCTRL234 GPMC_D15 */
+		>;
+	};
 };
 
 &i2c1 {
@@ -90,6 +118,8 @@
 
 &gpmc {
 	ranges = <0 0 0x04000000 0x01000000>;	/* CS0: 16MB for NAND */
+	pinctrl-names = "default";
+	pinctrl-0 = <&nandflash_pins>;
 
 	nand@0,0 {
 		compatible = "ti,omap2-nand";
@@ -98,9 +128,11 @@
 		interrupt-parent = <&gpmc>;
 		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
 			     <1 IRQ_TYPE_NONE>; /* termcount */
+		rb-gpios = <&gpmc 0 GPIO_ACTIVE_HIGH>; /* gpmc_wait0 */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ti,nand-ecc-opt = "bch8";
+		ti,elm-id = <&elm>;
 		nand-bus-width = <16>;
 		gpmc,device-width = <2>;
 		gpmc,sync-clk-ps = <0>;
diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
index 59cbf958fcc3..566b2a8c8b96 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -145,7 +145,7 @@
 		};
 
 		elm: elm@48080000 {
-			compatible = "ti,816-elm";
+			compatible = "ti,am3352-elm";
 			ti,hwmods = "elm";
 			reg = <0x48080000 0x2000>;
 			interrupts = <4>;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
