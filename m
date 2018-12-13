From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/2] ARM: dts: Fix wrong address for omap5 sata phy
Date: Wed, 12 Dec 2018 18:18:00 -0800
Message-ID: <20181213021801.49938-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, devicetree@vger.kernel.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Looks like I missed converting the omap5 sata phy addresses to use offset
from the module base instead of full physical address.

While at it, we can also more it to be a direct parent of the interconnect
target module, it is not really a child of the ocp2scp control device.

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap5-l4.dtsi | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-l4.dtsi b/arch/arm/boot/dts/omap5-l4.dtsi
--- a/arch/arm/boot/dts/omap5-l4.dtsi
+++ b/arch/arm/boot/dts/omap5-l4.dtsi
@@ -515,19 +515,19 @@
 					#address-cells = <1>;
 					#size-cells = <1>;
 					reg = <0x0 0x20>;
-					ranges = <0 0 0x4000>;
-					sata_phy: phy@4a096000 {
-						compatible = "ti,phy-pipe3-sata";
-						reg = <0x6000 0x80>, /* phy_rx */
-						      <0x4A096400 0x64>, /* phy_tx */
-						      <0x4A096800 0x40>; /* pll_ctrl */
-						reg-names = "phy_rx", "phy_tx", "pll_ctrl";
-						syscon-phy-power = <&scm_conf 0x374>;
-						clocks = <&sys_clkin>,
-							 <&l3init_clkctrl OMAP5_SATA_CLKCTRL 8>;
-						clock-names = "sysclk", "refclk";
-						#phy-cells = <0>;
-					};
+				};
+
+				sata_phy: phy@6000 {
+					compatible = "ti,phy-pipe3-sata";
+					reg = <0x6000 0x80>, /* phy_rx */
+					      <0x6400 0x64>, /* phy_tx */
+					      <0x6800 0x40>; /* pll_ctrl */
+					reg-names = "phy_rx", "phy_tx", "pll_ctrl";
+					syscon-phy-power = <&scm_conf 0x374>;
+					clocks = <&sys_clkin>,
+						 <&l3init_clkctrl OMAP5_SATA_CLKCTRL 8>;
+					clock-names = "sysclk", "refclk";
+					#phy-cells = <0>;
 				};
 		};
 
-- 
2.19.2
