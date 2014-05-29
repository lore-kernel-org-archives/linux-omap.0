From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 07/18] ARM: dts: DRA7: Change the parent of apll_pcie_in_clk_mux to dpll_pcie_ref_m2ldo_ck
Date: Thu, 29 May 2014 12:08:09 +0530
Message-ID: <1401345500-20188-8-git-send-email-kishon@ti.com>
References: <1401345500-20188-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1401345500-20188-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, tony@atomide.com, jg1.han@samsung.com, kishon@ti.com, Keerthy <j-keerthy@ti.com>, Rajendra Nayak <rnayak@ti.com>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

From: Keerthy <j-keerthy@ti.com>

Change the parent of apll_pcie_in_clk_mux to dpll_pcie_ref_m2ldo_ck
from dpll_pcie_ref_ck.

Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 55e95c5..44993ec 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -1152,7 +1152,7 @@
 
 	apll_pcie_in_clk_mux: apll_pcie_in_clk_mux@4ae06118 {
 		compatible = "ti,mux-clock";
-		clocks = <&dpll_pcie_ref_ck>, <&pciesref_acs_clk_ck>;
+		clocks = <&dpll_pcie_ref_m2ldo_ck>, <&pciesref_acs_clk_ck>;
 		#clock-cells = <0>;
 		reg = <0x021c 0x4>;
 		ti,bit-shift = <7>;
-- 
1.7.9.5
