From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 4/4] ARM: DTS: dra7/dra7xx-clocks: ATL related changes
Date: Wed, 7 May 2014 13:20:48 +0300
Message-ID: <1399458048-28213-5-git-send-email-peter.ujfalusi@ti.com>
References: <1399458048-28213-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399458048-28213-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mturquette@linaro.org, grant.likely@linaro.org, tony@atomide.com, t-kristo@ti.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-doc@vger.kernel.org, robh+dt@kernel.org, bcousson@baylibre.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Modify the clock nodes for the ATL clocks to use the ATL clock driver to
handle them.

Add the ATL device node at the same time for DRA7.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi          | 11 +++++++++++
 arch/arm/boot/dts/dra7xx-clocks.dtsi | 16 ++++++++--------
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 149b55099935..84071423016e 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -789,6 +789,17 @@
 			dma-names = "tx0", "rx0";
 			status = "disabled";
 		};
+
+		atl: atl@4843c000 {
+			compatible = "ti,dra7-atl";
+			reg = <0x4843c000 0x3ff>;
+			ti,hwmods = "atl";
+			ti,provided-clocks = <&atl_clkin0_ck>, <&atl_clkin1_ck>,
+					     <&atl_clkin2_ck>, <&atl_clkin3_ck>;
+			clocks = <&atl_gfclk_mux>;
+			clock-names = "fck";
+			status = "disabled";
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 30160348934c..789e92cd5595 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -10,26 +10,26 @@
 &cm_core_aon_clocks {
 	atl_clkin0_ck: atl_clkin0_ck {
 		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <0>;
+		compatible = "ti,dra7-atl-clock";
+		clocks = <&atl_gfclk_mux>;
 	};
 
 	atl_clkin1_ck: atl_clkin1_ck {
 		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <0>;
+		compatible = "ti,dra7-atl-clock";
+		clocks = <&atl_gfclk_mux>;
 	};
 
 	atl_clkin2_ck: atl_clkin2_ck {
 		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <0>;
+		compatible = "ti,dra7-atl-clock";
+		clocks = <&atl_gfclk_mux>;
 	};
 
 	atl_clkin3_ck: atl_clkin3_ck {
 		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <0>;
+		compatible = "ti,dra7-atl-clock";
+		clocks = <&atl_gfclk_mux>;
 	};
 
 	hdmi_clkin_ck: hdmi_clkin_ck {
-- 
1.9.2
