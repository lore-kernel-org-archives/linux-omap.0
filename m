From: Benoit Parrot <bparrot@ti.com>
Subject: [Patch 5/9] arm: dts: dra72-evm-common: Add entries for the CSI2 cameras
Date: Fri, 18 Oct 2019 10:48:45 -0500
Message-ID: <20191018154849.3127-6-bparrot@ti.com>
References: <20191018154849.3127-1-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191018154849.3127-1-bparrot@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Benoit Parrot <bparrot@ti.com>
List-Id: linux-omap@vger.kernel.org

Add device nodes for CSI2 camera board OV5640.
Add the CAL port nodes with the necessary linkage to the ov5640 nodes.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 arch/arm/boot/dts/dra72-evm-common.dtsi | 35 +++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm-common.dtsi b/arch/arm/boot/dts/dra72-evm-common.dtsi
index 8641a3d7d8ad..e4c01a67f6de 100644
--- a/arch/arm/boot/dts/dra72-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra72-evm-common.dtsi
@@ -187,6 +187,12 @@
 		gpio = <&gpio5 8 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	clk_ov5640_fixed: clk_ov5640_fixed {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+	};
 };
 
 &dra7_pmx_core {
@@ -269,6 +275,23 @@
 			line-name = "vin6_sel_s0";
 		};
 	};
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
 
 &uart1 {
@@ -580,3 +603,15 @@
 &pcie1_rc {
 	status = "okay";
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
-- 
2.17.1
