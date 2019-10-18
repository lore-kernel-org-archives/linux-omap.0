From: Benoit Parrot <bparrot@ti.com>
Subject: [Patch 9/9] arm64: dts: k3-am654-base-board: Add CSI2 OV5640 camera
Date: Fri, 18 Oct 2019 10:48:49 -0500
Message-ID: <20191018154849.3127-10-bparrot@ti.com>
References: <20191018154849.3127-1-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191018154849.3127-1-bparrot@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Benoit Parrot <bparrot@ti.com>
List-Id: linux-omap@vger.kernel.org

Add support for the OV5640 CSI camera:
- add the OV5640 nodes
- add the CAL node linkage
- enable CAL node

Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 1102b84f853d..918601c18f85 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -53,6 +53,12 @@
 			gpios = <&wkup_gpio0 27 GPIO_ACTIVE_LOW>;
 		};
 	};
+
+	clk_ov5640_fixed: clk_ov5640_fixed {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+	};
 };
 
 &wkup_pmx0 {
@@ -184,6 +190,23 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c1_pins_default>;
 	clock-frequency = <400000>;
+
+	ov5640@3c {
+		compatible = "ovti,ov5640";
+		reg = <0x3c>;
+
+		clocks = <&clk_ov5640_fixed>;
+		clock-names = "xclk";
+
+		port {
+			csi2_cam0: endpoint {
+				remote-endpoint = <&csi2_phy0>;
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+			};
+		};
+	};
+
 };
 
 &main_i2c2 {
@@ -280,3 +303,16 @@
 &pcie1_ep {
 	status = "disabled";
 };
+
+&cal {
+	status = "okay";
+};
+
+&csi2_0 {
+	csi2_phy0: endpoint@0 {
+		remote-endpoint = <&csi2_cam0>;
+		clock-lanes = <0>;
+		data-lanes = <1 2>;
+	};
+};
+
-- 
2.17.1
