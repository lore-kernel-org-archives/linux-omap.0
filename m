From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 2/4] ARM: dts: dra7: Use "syscon-phy-power" and
 "syscon-pcs" in PCIe PHY node
Date: Tue, 15 Sep 2015 19:03:03 +0530
Message-ID: <1442323985-29939-3-git-send-email-kishon@ti.com>
References: <1442323985-29939-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1442323985-29939-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, kishon@ti.com, tony@atomide.com, bcousson@baylibre.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, nsekhar@ti.com, robh+dt@kernel.org, galak@codeaurora.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add "syscon-phy-power" property and "syscon-pcs" property which can
be used to perform the control module initializations and remove
the deprecated "ctrl-module" property from PCIe PHY dt nodes.

Phandle to "sysclk" clock node is also added to the PCIe PHY node
since some of the syscon initializations is based on system clock
frequency.

Since "omap_control_pcie1phy" and "omap_control_pcie2phy" devicetree
nodes are no longer used, remove it.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |   28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 0769b5d..fe28215 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1158,16 +1158,18 @@
 				reg = <0x4a094000 0x80>, /* phy_rx */
 				      <0x4a094400 0x64>; /* phy_tx */
 				reg-names = "phy_rx", "phy_tx";
-				ctrl-module = <&omap_control_pcie1phy>;
+				syscon-phy-power = <&scm_conf_pcie 0x1c>;
+				syscon-pcs = <&scm_conf_pcie 0x10>;
 				clocks = <&dpll_pcie_ref_ck>,
 					 <&dpll_pcie_ref_m2ldo_ck>,
 					 <&optfclk_pciephy1_32khz>,
 					 <&optfclk_pciephy1_clk>,
 					 <&optfclk_pciephy1_div_clk>,
-					 <&optfclk_pciephy_div>;
+					 <&optfclk_pciephy_div>,
+					 <&sys_clkin1>;
 				clock-names = "dpll_ref", "dpll_ref_m2",
 					      "wkupclk", "refclk",
-					      "div-clk", "phy-div";
+					      "div-clk", "phy-div", "sysclk";
 				#phy-cells = <0>;
 			};
 
@@ -1176,7 +1178,8 @@
 				reg = <0x4a095000 0x80>, /* phy_rx */
 				      <0x4a095400 0x64>; /* phy_tx */
 				reg-names = "phy_rx", "phy_tx";
-				ctrl-module = <&omap_control_pcie2phy>;
+				syscon-phy-power = <&scm_conf_pcie 0x20>;
+				syscon-pcs = <&scm_conf_pcie 0x10>;
 				clocks = <&dpll_pcie_ref_ck>,
 					 <&dpll_pcie_ref_m2ldo_ck>,
 					 <&optfclk_pciephy2_32khz>,
@@ -1201,23 +1204,6 @@
 			ti,hwmods = "sata";
 		};
 
-		omap_control_pcie1phy: control-phy@0x4a003c40 {
-			compatible = "ti,control-phy-pcie";
-			reg = <0x4a003c40 0x4>, <0x4a003c14 0x4>, <0x4a003c34 0x4>;
-			reg-names = "power", "control_sma", "pcie_pcs";
-			clocks = <&sys_clkin1>;
-			clock-names = "sysclk";
-		};
-
-		omap_control_pcie2phy: control-pcie@0x4a003c44 {
-			compatible = "ti,control-phy-pcie";
-			reg = <0x4a003c44 0x4>, <0x4a003c14 0x4>, <0x4a003c34 0x4>;
-			reg-names = "power", "control_sma", "pcie_pcs";
-			clocks = <&sys_clkin1>;
-			clock-names = "sysclk";
-			status = "disabled";
-		};
-
 		rtc: rtc@48838000 {
 			compatible = "ti,am3352-rtc";
 			reg = <0x48838000 0x100>;
-- 
1.7.9.5
