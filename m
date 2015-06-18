From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 2/2] ARM: dts: am4372: Set the default clock rate for dpll_clksel_mac_clk clock
Date: Thu, 18 Jun 2015 13:31:13 +0530
Message-ID: <1434614473-8500-3-git-send-email-j-keerthy@ti.com>
References: <1434614473-8500-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434614473-8500-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: galak@codeaurora.org, tony@atomide.com, t-kristo@ti.com, pawel.moll@arm.com, linux-kernel@vger.kernel.org, bcousson@baylibre.com, linux-clk@vger.kernel.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

cpsw needs the clock to be running at 50MHz in kernel. Hence setting
the default rate.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index c80a3e2..1680602 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -521,8 +521,11 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ti,hwmods = "cpgmac0";
-			clocks = <&cpsw_125mhz_gclk>, <&cpsw_cpts_rft_clk>;
-			clock-names = "fck", "cpts";
+			clocks = <&cpsw_125mhz_gclk>, <&cpsw_cpts_rft_clk>,
+				 <&dpll_clksel_mac_clk>;
+			clock-names = "fck", "cpts", "50mclk";
+			assigned-clocks = <&dpll_clksel_mac_clk>;
+			assigned-clock-rates = <50000000>;
 			status = "disabled";
 			cpdma_channels = <8>;
 			ale_entries = <1024>;
-- 
1.9.1
