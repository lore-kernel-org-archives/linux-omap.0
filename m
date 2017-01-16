From: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: [PATCH 3/6] ARM: dts: am335x-sl50: Enable SPI0 interface and Flash Memory.
Date: Mon, 16 Jan 2017 17:57:33 +0100
Message-ID: <20170116165736.17197-4-enric.balletbo@collabora.com>
References: <20170116165736.17197-1-enric.balletbo@collabora.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170116165736.17197-1-enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Add support for the 32Mb Serial Flash Memory connected to SPI0
and using CS1.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
---
 arch/arm/boot/dts/am335x-sl50.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-sl50.dts b/arch/arm/boot/dts/am335x-sl50.dts
index 89ddf26..6f32078 100644
--- a/arch/arm/boot/dts/am335x-sl50.dts
+++ b/arch/arm/boot/dts/am335x-sl50.dts
@@ -262,6 +262,16 @@
 		>;
 	};
 
+	spi0_pins: pinmux_spi0_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x954, PIN_INPUT_PULLUP | MUX_MODE0)	/* SPI0_MOSI - spi0_d0.spi0_d0 */
+			AM33XX_IOPAD(0x958, PIN_INPUT_PULLUP | MUX_MODE0)	/* SPI0_MISO - spi0_d1.spi0_d1 */
+			AM33XX_IOPAD(0x950, PIN_INPUT_PULLUP | MUX_MODE0)	/* SPI0_CLK  - spi0_clk.spi0_clk */
+			AM33XX_IOPAD(0x95c, PIN_INPUT_PULLUP | MUX_MODE0)	/* SPI0_CS0 (NBATTSS) - spi0_cs0.spi0_cs0 */
+			AM33XX_IOPAD(0x960, PIN_INPUT_PULLUP | MUX_MODE0)	/* SPI0_CS1 (FPGA_FLASH_NCS) - spi0_cs1.spi0_cs1 */
+		>;
+	};
+
 	lwb_pins: pinmux_lwb_pins {
 		pinctrl-single,pins = <
 			AM33XX_IOPAD(0x9a4, PIN_OUTPUT | MUX_MODE7)	/* SoundPA_en - mcasp0_fsr.gpio3_19 */
@@ -400,6 +410,20 @@
 	pinctrl-0 = <&uart4_pins>;
 };
 
+&spi0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins>;
+
+	flash: n25q032@1 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "micron,n25q032";
+		reg = <1>;
+		spi-max-frequency = <5000000>;
+	};
+};
+
 #include "tps65217.dtsi"
 
 &tps {
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
