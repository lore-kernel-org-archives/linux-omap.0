From: Benoit Parrot <bparrot@ti.com>
Subject: [Patch v4 08/10] arm: dts: dra76-evm: Add CAL and OV5640 nodes
Date: Wed, 11 Dec 2019 08:05:56 -0600
Message-ID: <20191211140558.10407-9-bparrot@ti.com>
References: <20191211140558.10407-1-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191211140558.10407-1-bparrot@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Benoit Parrot <bparrot@ti.com>
List-Id: linux-omap@vger.kernel.org

Add device nodes for CSI2 camera board OV5640.
Add the CAL port nodes with the necessary linkage to the ov5640 nodes.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 arch/arm/boot/dts/dra76-evm.dts | 35 +++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/dra76-evm.dts b/arch/arm/boot/dts/dra76-evm.dts
index 1fb6f13fb5e2..a17d4875bb2e 100644
--- a/arch/arm/boot/dts/dra76-evm.dts
+++ b/arch/arm/boot/dts/dra76-evm.dts
@@ -116,6 +116,12 @@
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 	};
+
+	clk_ov5640_fixed: clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+	};
 };
 
 &i2c1 {
@@ -317,6 +323,27 @@
 	};
 };
 
+&i2c5 {
+	status = "okay";
+	clock-frequency = <400000>;
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
+};
+
 &cpu0 {
 	vdd-supply = <&buck10_reg>;
 };
@@ -447,3 +474,11 @@
 		max-bitrate = <5000000>;
 	};
 };
+
+&csi2_0 {
+	csi2_phy0: endpoint {
+		remote-endpoint = <&csi2_cam0>;
+		clock-lanes = <0>;
+		data-lanes = <1 2>;
+	};
+};
-- 
2.17.1
