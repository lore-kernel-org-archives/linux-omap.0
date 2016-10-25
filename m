From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/4] ARM: dts: Add #pinctrl-cells for pinctrl-single instances
Date: Tue, 25 Oct 2016 09:45:38 -0700
Message-ID: <20161025164538.453-5-tony@atomide.com>
References: <20161025164538.453-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161025164538.453-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jon Hunter <jonathanh@nvidia.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Drivers using pinctrl-single,pins have #pinctrl-cells = <1>, while
pinctrl-single,bits need #pinctrl-cells = <2>.

Note that this patch can be optionally applied separately from the
driver changes as the driver supports also the legacy binding without
#pinctrl-cells.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt | 3 +++
 arch/arm/boot/dts/am33xx.dtsi                                | 2 ++
 arch/arm/boot/dts/am3517.dtsi                                | 1 +
 arch/arm/boot/dts/am4372.dtsi                                | 1 +
 arch/arm/boot/dts/da850.dtsi                                 | 1 +
 arch/arm/boot/dts/dm814x.dtsi                                | 1 +
 arch/arm/boot/dts/dm816x.dtsi                                | 2 ++
 arch/arm/boot/dts/dra7.dtsi                                  | 1 +
 arch/arm/boot/dts/hi3620.dtsi                                | 2 ++
 arch/arm/boot/dts/keystone-k2g.dtsi                          | 1 +
 arch/arm/boot/dts/keystone-k2l.dtsi                          | 1 +
 arch/arm/boot/dts/omap2420.dtsi                              | 2 ++
 arch/arm/boot/dts/omap2430.dtsi                              | 2 ++
 arch/arm/boot/dts/omap3.dtsi                                 | 2 ++
 arch/arm/boot/dts/omap34xx.dtsi                              | 1 +
 arch/arm/boot/dts/omap36xx.dtsi                              | 1 +
 arch/arm/boot/dts/omap4.dtsi                                 | 2 ++
 arch/arm/boot/dts/omap5.dtsi                                 | 2 ++
 arch/arm/boot/dts/pxa3xx.dtsi                                | 1 +
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi                    | 3 +++
 20 files changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
@@ -7,6 +7,9 @@ Required properties:
 
 - reg : offset and length of the register set for the mux registers
 
+- #pinctrl-cells : number of cells in addition to the index, set to 1
+  for pinctrl-single,pins and 2 for pinctrl-single,bits
+
 - pinctrl-single,register-width : pinmux register access width in bits
 
 - pinctrl-single,function-mask : mask of allowed pinmux function bits
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -130,6 +130,7 @@
 				reg = <0x210000 0x2000>;
 				#address-cells = <1>;
 				#size-cells = <1>;
+				#pinctrl-cells = <1>;
 				ranges = <0 0x210000 0x2000>;
 
 				am33xx_pinmux: pinmux@800 {
@@ -137,6 +138,7 @@
 					reg = <0x800 0x238>;
 					#address-cells = <1>;
 					#size-cells = <0>;
+					#pinctrl-cells = <1>;
 					pinctrl-single,register-width = <32>;
 					pinctrl-single,function-mask = <0x7f>;
 				};
diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
--- a/arch/arm/boot/dts/am3517.dtsi
+++ b/arch/arm/boot/dts/am3517.dtsi
@@ -66,6 +66,7 @@
 			reg = <0x480025d8 0x24>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#pinctrl-cells = <1>;
 			#interrupt-cells = <1>;
 			interrupt-controller;
 			pinctrl-single,register-width = <16>;
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -189,6 +189,7 @@
 					reg = <0x800 0x31c>;
 					#address-cells = <1>;
 					#size-cells = <0>;
+					#pinctrl-cells = <1>;
 					#interrupt-cells = <1>;
 					interrupt-controller;
 					pinctrl-single,register-width = <32>;
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -36,6 +36,7 @@
 			reg = <0x14120 0x50>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#pinctrl-cells = <2>;
 			pinctrl-single,bit-per-mux;
 			pinctrl-single,register-width = <32>;
 			pinctrl-single,function-mask = <0xf>;
diff --git a/arch/arm/boot/dts/dm814x.dtsi b/arch/arm/boot/dts/dm814x.dtsi
--- a/arch/arm/boot/dts/dm814x.dtsi
+++ b/arch/arm/boot/dts/dm814x.dtsi
@@ -374,6 +374,7 @@
 					reg = <0x800 0x438>;
 					#address-cells = <1>;
 					#size-cells = <0>;
+					#pinctrl-cells = <1>;
 					pinctrl-single,register-width = <32>;
 					pinctrl-single,function-mask = <0x307ff>;
 				};
diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -83,6 +83,7 @@
 			reg = <0x48140000 0x21000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+			#pinctrl-cells = <1>;
 			ranges = <0 0x48140000 0x21000>;
 
 			dm816x_pinmux: pinmux@800 {
@@ -90,6 +91,7 @@
 				reg = <0x800 0x50a>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				#pinctrl-cells = <1>;
 				pinctrl-single,register-width = <16>;
 				pinctrl-single,function-mask = <0xf>;
 			};
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -171,6 +171,7 @@
 					reg = <0x1400 0x0468>;
 					#address-cells = <1>;
 					#size-cells = <0>;
+					#pinctrl-cells = <1>;
 					#interrupt-cells = <1>;
 					interrupt-controller;
 					pinctrl-single,register-width = <32>;
diff --git a/arch/arm/boot/dts/hi3620.dtsi b/arch/arm/boot/dts/hi3620.dtsi
--- a/arch/arm/boot/dts/hi3620.dtsi
+++ b/arch/arm/boot/dts/hi3620.dtsi
@@ -537,6 +537,7 @@
 			reg = <0x803000 0x188>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+			#pinctrl-cells = <1>;
 			#gpio-range-cells = <3>;
 			ranges;
 
@@ -558,6 +559,7 @@
 			reg = <0x803800 0x2dc>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+			#pinctrl-cells = <1>;
 			ranges;
 
 			pinctrl-single,register-width = <32>;
diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -72,6 +72,7 @@
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
+		#pinctrl-cells = <1>;
 		compatible = "ti,keystone","simple-bus";
 		ranges = <0x0 0x0 0x0 0xc0000000>;
 		dma-ranges = <0x80000000 0x8 0x00000000 0x80000000>;
diff --git a/arch/arm/boot/dts/keystone-k2l.dtsi b/arch/arm/boot/dts/keystone-k2l.dtsi
--- a/arch/arm/boot/dts/keystone-k2l.dtsi
+++ b/arch/arm/boot/dts/keystone-k2l.dtsi
@@ -59,6 +59,7 @@
 			reg = <0x02620690 0xc>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#pinctrl-cells = <2>;
 			pinctrl-single,bit-per-mux;
 			pinctrl-single,register-width = <32>;
 			pinctrl-single,function-mask = <0x1>;
diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
--- a/arch/arm/boot/dts/omap2420.dtsi
+++ b/arch/arm/boot/dts/omap2420.dtsi
@@ -38,6 +38,7 @@
 				reg = <0x0 0x1000>;
 				#address-cells = <1>;
 				#size-cells = <1>;
+				#pinctrl-cells = <1>;
 				ranges = <0 0x0 0x1000>;
 
 				omap2420_pmx: pinmux@30 {
@@ -46,6 +47,7 @@
 					reg = <0x30 0x0113>;
 					#address-cells = <1>;
 					#size-cells = <0>;
+					#pinctrl-cells = <1>;
 					pinctrl-single,register-width = <8>;
 					pinctrl-single,function-mask = <0x3f>;
 				};
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -38,6 +38,7 @@
 				reg = <0x2000 0x1000>;
 				#address-cells = <1>;
 				#size-cells = <1>;
+				#pinctrl-cells = <1>;
 				ranges = <0 0x2000 0x1000>;
 
 				omap2430_pmx: pinmux@30 {
@@ -46,6 +47,7 @@
 					reg = <0x30 0x0154>;
 					#address-cells = <1>;
 					#size-cells = <0>;
+					#pinctrl-cells = <1>;
 					pinctrl-single,register-width = <8>;
 					pinctrl-single,function-mask = <0x3f>;
 				};
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -106,6 +106,7 @@
 					reg = <0x30 0x238>;
 					#address-cells = <1>;
 					#size-cells = <0>;
+					#pinctrl-cells = <1>;
 					#interrupt-cells = <1>;
 					interrupt-controller;
 					pinctrl-single,register-width = <16>;
@@ -145,6 +146,7 @@
 					reg = <0xa00 0x5c>;
 					#address-cells = <1>;
 					#size-cells = <0>;
+					#pinctrl-cells = <1>;
 					#interrupt-cells = <1>;
 					interrupt-controller;
 					pinctrl-single,register-width = <16>;
diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/omap34xx.dtsi
--- a/arch/arm/boot/dts/omap34xx.dtsi
+++ b/arch/arm/boot/dts/omap34xx.dtsi
@@ -34,6 +34,7 @@
 			reg = <0x480025d8 0x24>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#pinctrl-cells = <1>;
 			#interrupt-cells = <1>;
 			interrupt-controller;
 			pinctrl-single,register-width = <16>;
diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -66,6 +66,7 @@
 			reg = <0x480025a0 0x5c>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#pinctrl-cells = <1>;
 			#interrupt-cells = <1>;
 			interrupt-controller;
 			pinctrl-single,register-width = <16>;
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -184,6 +184,7 @@
 					reg = <0x40 0x0196>;
 					#address-cells = <1>;
 					#size-cells = <0>;
+					#pinctrl-cells = <1>;
 					#interrupt-cells = <1>;
 					interrupt-controller;
 					pinctrl-single,register-width = <16>;
@@ -256,6 +257,7 @@
 					reg = <0x1e040 0x0038>;
 					#address-cells = <1>;
 					#size-cells = <0>;
+					#pinctrl-cells = <1>;
 					#interrupt-cells = <1>;
 					interrupt-controller;
 					pinctrl-single,register-width = <16>;
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -171,6 +171,7 @@
 					reg = <0x40 0x01b6>;
 					#address-cells = <1>;
 					#size-cells = <0>;
+					#pinctrl-cells = <1>;
 					#interrupt-cells = <1>;
 					interrupt-controller;
 					pinctrl-single,register-width = <16>;
@@ -270,6 +271,7 @@
 				reg = <0xc840 0x003c>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				#pinctrl-cells = <1>;
 				#interrupt-cells = <1>;
 				interrupt-controller;
 				pinctrl-single,register-width = <16>;
diff --git a/arch/arm/boot/dts/pxa3xx.dtsi b/arch/arm/boot/dts/pxa3xx.dtsi
--- a/arch/arm/boot/dts/pxa3xx.dtsi
+++ b/arch/arm/boot/dts/pxa3xx.dtsi
@@ -138,6 +138,7 @@
 			reg = <0x40e10000 0xffff>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#pinctrl-cells = <1>;
 			pinctrl-single,register-width = <32>;
 			pinctrl-single,function-mask = <0x7>;
 		};
diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -364,6 +364,7 @@
 			reg = <0x0 0xf7010000  0x0 0x27c>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+			#pinctrl-cells = <1>;
 			#gpio-range-cells = <3>;
 			pinctrl-single,register-width = <32>;
 			pinctrl-single,function-mask = <7>;
@@ -402,6 +403,7 @@
 			reg = <0x0 0xf7010800 0x0 0x28c>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+			#pinctrl-cells = <1>;
 			pinctrl-single,register-width = <32>;
 		};
 
@@ -410,6 +412,7 @@
 			reg = <0x0 0xf8001800 0x0 0x78>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+			#pinctrl-cells = <1>;
 			pinctrl-single,register-width = <32>;
 		};
 
-- 
2.9.3
