From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 1/2] CLK: TI: AM437X: add dpll_clksel_mac_clk node
Date: Thu, 18 Jun 2015 13:31:12 +0530
Message-ID: <1434614473-8500-2-git-send-email-j-keerthy@ti.com>
References: <1434614473-8500-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434614473-8500-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: galak@codeaurora.org, tony@atomide.com, t-kristo@ti.com, pawel.moll@arm.com, linux-kernel@vger.kernel.org, bcousson@baylibre.com, linux-clk@vger.kernel.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

The patch adds the missing dpll_clksel_mac_clk clock node.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/am43xx-clocks.dtsi | 9 +++++++++
 drivers/clk/ti/clk-43xx.c            | 1 +
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi b/arch/arm/boot/dts/am43xx-clocks.dtsi
index d0c0dfa..cc88728 100644
--- a/arch/arm/boot/dts/am43xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
@@ -486,6 +486,15 @@
 		reg = <0x4238>;
 	};
 
+	dpll_clksel_mac_clk: dpll_clksel_mac_clk {
+		#clock-cells = <0>;
+		compatible = "ti,divider-clock";
+		clocks = <&dpll_core_m5_ck>;
+		reg = <0x4234>;
+		ti,bit-shift = <2>;
+		ti,dividers = <2>, <5>;
+	};
+
 	clk_32k_mosc_ck: clk_32k_mosc_ck {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
diff --git a/drivers/clk/ti/clk-43xx.c b/drivers/clk/ti/clk-43xx.c
index 3795fce..7549b87 100644
--- a/drivers/clk/ti/clk-43xx.c
+++ b/drivers/clk/ti/clk-43xx.c
@@ -71,6 +71,7 @@ static struct ti_dt_clk am43xx_clks[] = {
 	DT_CLK(NULL, "clk_24mhz", "clk_24mhz"),
 	DT_CLK(NULL, "cpsw_125mhz_gclk", "cpsw_125mhz_gclk"),
 	DT_CLK(NULL, "cpsw_cpts_rft_clk", "cpsw_cpts_rft_clk"),
+	DT_CLK(NULL, "dpll_clksel_mac_clk", "dpll_clksel_mac_clk"),
 	DT_CLK(NULL, "gpio0_dbclk_mux_ck", "gpio0_dbclk_mux_ck"),
 	DT_CLK(NULL, "gpio0_dbclk", "gpio0_dbclk"),
 	DT_CLK(NULL, "gpio1_dbclk", "gpio1_dbclk"),
-- 
1.9.1
