From: Benoit Parrot <bparrot@ti.com>
Subject: [Patch v3 10/10] arm64: dts: k3-am654-base-board: Add CSI2 OV5640 camera
Date: Tue, 12 Nov 2019 08:27:53 -0600
Message-ID: <20191112142753.22976-11-bparrot@ti.com>
References: <20191112142753.22976-1-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191112142753.22976-1-bparrot@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Benoit Parrot <bparrot@ti.com>
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
index 1102b84f853d..73290c646334 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -53,6 +53,12 @@
 			gpios = <&wkup_gpio0 27 GPIO_ACTIVE_LOW>;
 		};
 	};
+
+	clk_ov5640_fixed: clock {
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
