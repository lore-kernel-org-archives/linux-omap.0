From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 05/12] ARM: dts: DRA7: Change the parent of apll_pcie_in_clk_mux to dpll_pcie_ref_m2ldo_ck
Date: Wed, 26 Mar 2014 19:27:45 +0530
Message-ID: <1395842272-15267-6-git-send-email-kishon@ti.com>
References: <1395842272-15267-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1395842272-15267-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, mohit.kumar@st.com, jg1.han@samsung.com
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rob@landley.net, linux@arm.linux.org.uk, tony@atomide.com, rnayak@ti.com, paul@pwsan.com, kishon@ti.com, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Keerthy <j-keerthy@ti.com>

Change the parent of apll_pcie_in_clk_mux to dpll_pcie_ref_m2ldo_ck
from dpll_pcie_ref_ck.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index d909484..9e0bb09 100644
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
