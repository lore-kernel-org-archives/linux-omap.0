From: Benoit Parrot <bparrot@ti.com>
Subject: [Patch 8/9] arm64: dts: k3-am65-main Add CAL node
Date: Fri, 18 Oct 2019 10:48:48 -0500
Message-ID: <20191018154849.3127-9-bparrot@ti.com>
References: <20191018154849.3127-1-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191018154849.3127-1-bparrot@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Benoit Parrot <bparrot@ti.com>
List-Id: linux-omap@vger.kernel.org

Add CAL dtsi node for AM654 device. Including proper power-domains and
clock properties.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 799c75fa7981..9bd9a74d5e33 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -516,4 +516,27 @@
 		dma-coherent;
 		interrupts = <GIC_SPI 355 IRQ_TYPE_EDGE_RISING>;
 	};
+
+	cal: cal@6f03000 {
+		compatible = "ti,am654-cal";
+		reg = <0x0 0x06f03000 0x0 0x400>,
+		      <0x0 0x06f03800 0x0 0x40>;
+		reg-names = "cal_top",
+			    "cal_rx_core0";
+		interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+		syscon-camerrx = <&scm_conf 0x40c0>;
+		clock-names = "fck";
+		clocks = <&k3_clks 2 0>;
+		power-domains = <&k3_pds 2 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			csi2_0: port@0 {
+				reg = <0>;
+			};
+		};
+	};
 };
-- 
2.17.1
