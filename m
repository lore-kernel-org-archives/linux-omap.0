From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 3/3] ARM: dts: am43xx: add support for clkout1 clock
Date: Wed, 16 Mar 2016 21:54:57 +0200
Message-ID: <1458158097-21137-4-git-send-email-t-kristo@ti.com>
References: <1458158097-21137-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1458158097-21137-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

clkout1 clock node and its generation tree was missing. Add this based
on the data on TRM and PRCM functional spec.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Tested-by: Benoit Parrot <bparrot@ti.com>
---
 arch/arm/boot/dts/am43xx-clocks.dtsi |   54 ++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi b/arch/arm/boot/dts/am43xx-clocks.dtsi
index a38af2b..f16ffb5 100644
--- a/arch/arm/boot/dts/am43xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
@@ -771,4 +771,58 @@
 		ti,bit-shift = <8>;
 		reg = <0x8a68>;
 	};
+
+	clkout1_osc_div_ck: clkout1_osc_div_ck {
+		#clock-cells = <0>;
+		compatible = "ti,divider-clock";
+		clocks = <&sys_clkin_ck>;
+		ti,bit-shift = <20>;
+		ti,max-div = <4>;
+		reg = <0x4100>;
+	};
+
+	clkout1_src2_mux_ck: clkout1_src2_mux_ck {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&clk_rc32k_ck>, <&sysclk_div>, <&dpll_ddr_m2_ck>,
+			 <&dpll_per_m2_ck>, <&dpll_disp_m2_ck>,
+			 <&dpll_mpu_m2_ck>;
+		reg = <0x4100>;
+	};
+
+	clkout1_src2_pre_div_ck: clkout1_src2_pre_div_ck {
+		#clock-cells = <0>;
+		compatible = "ti,divider-clock";
+		clocks = <&clkout1_src2_mux_ck>;
+		ti,bit-shift = <4>;
+		ti,max-div = <8>;
+		reg = <0x4100>;
+	};
+
+	clkout1_src2_post_div_ck: clkout1_src2_post_div_ck {
+		#clock-cells = <0>;
+		compatible = "ti,divider-clock";
+		clocks = <&clkout1_src2_pre_div_ck>;
+		ti,bit-shift = <8>;
+		ti,max-div = <32>;
+		ti,index-power-of-two;
+		reg = <0x4100>;
+	};
+
+	clkout1_mux_ck: clkout1_mux_ck {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&clkout1_osc_div_ck>, <&clk_rc32k_ck>,
+			 <&clkout1_src2_post_div_ck>, <&dpll_extdev_m2_ck>;
+		ti,bit-shift = <16>;
+		reg = <0x4100>;
+	};
+
+	clkout1_ck: clkout1_ck {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&clkout1_mux_ck>;
+		ti,bit-shift = <23>;
+		reg = <0x4100>;
+	};
 };
-- 
1.7.9.5

