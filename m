From: Benoit Parrot <bparrot@ti.com>
Subject: [Patch v3 3/3] ARM: dts: am43x-epos-evm: Add VPFE and OV2659 entries
Date: Wed, 11 Dec 2019 08:07:20 -0600
Message-ID: <20191211140720.10539-4-bparrot@ti.com>
References: <20191211140720.10539-1-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191211140720.10539-1-bparrot@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Benoit Parrot <bparrot@ti.com>
List-Id: linux-omap@vger.kernel.org

Add VPFE device nodes entries.
Add OmniVision OV2659 sensor device nodes and linkage.

Since Rev1.2a on this board the sensor source clock (xvclk) has a
dedicated 12Mhz oscillator instead of using clkout1.
Add 'audio_mstrclk' fixed clock object to represent it.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 95314121d111..b0df37014888 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -145,6 +145,12 @@
 			system-clock-frequency = <12000000>;
 		};
 	};
+
+	audio_mstrclk: clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <12000000>;
+	};
 };
 
 &am43xx_pinmux {
@@ -696,6 +702,21 @@
 		IOVDD-supply = <&dcdc4>; /* V3_3D -> DCDC4 */
 		DVDD-supply = <&ldo1>; /* V1_8AUD -> V1_8D -> LDO1 */
 	};
+
+	ov2659@30 {
+		compatible = "ovti,ov2659";
+		reg = <0x30>;
+
+		clocks = <&audio_mstrclk>;
+		clock-names = "xvclk";
+
+		port {
+			ov2659_1: endpoint {
+				remote-endpoint = <&vpfe1_ep>;
+				link-frequencies = /bits/ 64 <70000000>;
+			};
+		};
+	};
 };
 
 &i2c2 {
@@ -962,7 +983,7 @@
 
 	port {
 		vpfe1_ep: endpoint {
-			/* remote-endpoint = <&sensor>; add once we have it */
+			remote-endpoint = <&ov2659_1>;
 			ti,am437x-vpfe-interface = <0>;
 			bus-width = <8>;
 			hsync-active = <0>;
-- 
2.17.1
