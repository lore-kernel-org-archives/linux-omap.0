From: Benoit Parrot <bparrot@ti.com>
Subject: [Patch v4 10/10] arm64: dts: k3-am654-base-board: Add CSI2 OV5640 camera
Date: Wed, 11 Dec 2019 08:05:58 -0600
Message-ID: <20191211140558.10407-11-bparrot@ti.com>
References: <20191211140558.10407-1-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191211140558.10407-1-bparrot@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Benoit Parrot <bparrot@ti.com>
List-Id: linux-omap@vger.kernel.org

Add support for the OV5640 CSI camera:
- add the OV5640 nodes
- add the CAL node linkage
- enable CAL node

Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 8a85b482ad31..f918c5804589 100644
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
@@ -339,3 +362,12 @@
 &mailbox0_cluster11 {
 	status = "disabled";
 };
+
+&csi2_0 {
+	csi2_phy0: endpoint {
+		remote-endpoint = <&csi2_cam0>;
+		clock-lanes = <0>;
+		data-lanes = <1 2>;
+	};
+};
+
-- 
2.17.1
