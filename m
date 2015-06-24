From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [PATCH 1/1] arm: dts: am43xx-clock: Add qspi clock node.
Date: Wed, 24 Jun 2015 23:15:33 +0530
Message-ID: <1435167933-5249-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Sourav Poddar <sourav.poddar@ti.com>

Add clock node for qspi controller driver on am437x.

Cc: Keerthy <j-keerthy@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi        | 2 ++
 arch/arm/boot/dts/am43xx-clocks.dtsi | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 649e7b9..8ab7831 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -903,6 +903,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "qspi";
+			clocks = <&qspi_fclk>;
+			clock-names = "fck";
 			interrupts = <0 138 0x4>;
 			num-cs = <4>;
 			status = "disabled";
diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi b/arch/arm/boot/dts/am43xx-clocks.dtsi
index cc88728..1506585 100644
--- a/arch/arm/boot/dts/am43xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
@@ -763,4 +763,12 @@
 		ti,bit-shift = <8>;
 		reg = <0x8a68>;
 	};
+
+	qspi_fclk: qspi_fclk {
+		#clock-cells = <0>;
+		compatible = "ti,fixed-factor-clock";
+		clocks = <&dpll_per_m2_div4_ck>;
+		clock-mult = <1>;
+		clock-div = <1>;
+	};
 };
-- 
2.4.2.387.gf86f31a
