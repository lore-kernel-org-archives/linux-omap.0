From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 05/32] ARM: dts: omap3-gta04: add devconf1 setup for correct tvout pins
Date: Tue, 31 Jul 2018 09:11:08 +0200
Message-ID: <67f5cb7d89001e0a3172844bad3e4150b6053afe.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ladis@linux-mips.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Marek Belisko <marek@goldelico.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

The VENC with external OPA362 amplifier needs a special
"pinmux" setup in DEVCONF1 (TVOUTBYPASS and TVOUTACEN).

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index ed8aff515703..654faa7773a8 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -169,6 +169,24 @@
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&tca6507 0 GPIO_ACTIVE_LOW>;	/* W2CBW003 reset through tca6507 */
 	};
+
+	/* devconf1 setup for tvout pins */
+	pinmux_tv_out@480022d8 {
+		compatible = "pinctrl-single";
+		reg = <0x480022d8 4>;	/* CONTROL_DEVCONF1 */
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-single,bit-per-mux;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x81>;	/* TV out pin control */
+		#pinctrl-cells = <2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&tv_acbias_devconf1_pins>;
+		tv_acbias_devconf1_pins: pinmux_tv_acbias_devconf1_pins {
+			/*			offset	bits	mask */
+			pinctrl-single,bits = <0x00 0x40800 0x40800>;	/* set TVOUTBYPASS and TVOUTACEN */
+		};
+	};
 };
 
 &omap3_pmx_core {
-- 
2.12.2
