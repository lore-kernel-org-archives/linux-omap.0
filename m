From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 3/6] ARM: dts: am4372: switch to use phy-gmii-sel
Date: Wed, 20 Feb 2019 17:25:16 +0200
Message-ID: <1550676319-6440-4-git-send-email-grygorii.strashko@ti.com>
References: <1550676319-6440-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1550676319-6440-1-git-send-email-grygorii.strashko@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "David S. Miller" <davem@davemloft.net>, Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Switch to use phy-gmii-sel PHY instead of cpsw-phy-sel.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/am437x-l4.dtsi     | 17 +++++++++--------
 arch/arm/boot/dts/am43x-epos-evm.dts |  5 +----
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-l4.dtsi b/arch/arm/boot/dts/am437x-l4.dtsi
index ca0896f80248..85c6f4ff1824 100644
--- a/arch/arm/boot/dts/am437x-l4.dtsi
+++ b/arch/arm/boot/dts/am437x-l4.dtsi
@@ -280,12 +280,6 @@
 				#size-cells = <1>;
 				ranges = <0 0 0x4000>;
 
-				phy_sel: cpsw-phy-sel@650 {
-					compatible = "ti,am43xx-cpsw-phy-sel";
-					reg= <0x650 0x4>;
-					reg-names = "gmii-sel";
-				};
-
 				am43xx_pinmux: pinmux@800 {
 					compatible = "ti,am437-padconf",
 						     "pinctrl-single";
@@ -300,11 +294,17 @@
 				};
 
 				scm_conf: scm_conf@0 {
-					compatible = "syscon";
+					compatible = "syscon", "simple-bus";
 					reg = <0x0 0x800>;
 					#address-cells = <1>;
 					#size-cells = <1>;
 
+					phy_gmii_sel: phy-gmii-sel {
+						compatible = "ti,am43xx-phy-gmii-sel";
+						reg = <0x650 0x4>;
+						#phy-cells = <2>;
+					};
+
 					scm_clocks: clocks {
 						#address-cells = <1>;
 						#size-cells = <0>;
@@ -555,7 +555,6 @@
 				cpts_clock_shift = <29>;
 				ranges = <0 0 0x8000>;
 				syscon = <&scm_conf>;
-				cpsw-phy-sel = <&phy_sel>;
 
 				davinci_mdio: mdio@1000 {
 					compatible = "ti,am4372-mdio","ti,cpsw-mdio","ti,davinci_mdio";
@@ -572,11 +571,13 @@
 				cpsw_emac0: slave@200 {
 					/* Filled in by U-Boot */
 					mac-address = [ 00 00 00 00 00 00 ];
+					phys = <&phy_gmii_sel 1 0>;
 				};
 
 				cpsw_emac1: slave@300 {
 					/* Filled in by U-Boot */
 					mac-address = [ 00 00 00 00 00 00 ];
+					phys = <&phy_gmii_sel 2 0>;
 				};
 			};
 		};
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 4ea753b3ee43..9dfd80e3b76e 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -584,10 +584,7 @@
 &cpsw_emac0 {
 	phy-handle = <&ethphy0>;
 	phy-mode = "rmii";
-};
-
-&phy_sel {
-	rmii-clock-ext;
+	phys = <&phy_gmii_sel 1 1>;
 };
 
 &i2c0 {
-- 
2.17.1
