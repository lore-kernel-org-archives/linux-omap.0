From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH linux-next 06/10] ARM: dts: dm814x: switch to use phy-gmii-sel
Date: Sun, 25 Nov 2018 18:15:27 -0600
Message-ID: <20181126001531.12974-7-grygorii.strashko@ti.com>
References: <20181126001531.12974-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181126001531.12974-1-grygorii.strashko@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "David S. Miller" <davem@davemloft.net>, Tony Lindgren <tony@atomide.com>, Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Switch to use phy-gmii-sel PHY instead of cpsw-phy-sel.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/dm814x.dtsi | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/dm814x.dtsi b/arch/arm/boot/dts/dm814x.dtsi
index 601c57a..413ae19 100644
--- a/arch/arm/boot/dts/dm814x.dtsi
+++ b/arch/arm/boot/dts/dm814x.dtsi
@@ -343,6 +343,12 @@
 					#size-cells = <1>;
 					ranges = <0 0 0x800>;
 
+					phy_gmii_sel: phy-gmii-sel {
+						compatible = "ti,dm814-phy-gmii-sel";
+						reg = <0x650 0x4>;
+						#phy-cells = <1>;
+					};
+
 					scm_clocks: clocks {
 						#address-cells = <1>;
 						#size-cells = <0>;
@@ -549,17 +555,14 @@
 			cpsw_emac0: slave@4a100200 {
 				/* Filled in by U-Boot */
 				mac-address = [ 00 00 00 00 00 00 ];
+				phys = <&phy_gmii_sel 1>;
+
 			};
 
 			cpsw_emac1: slave@4a100300 {
 				/* Filled in by U-Boot */
 				mac-address = [ 00 00 00 00 00 00 ];
-			};
-
-			phy_sel: cpsw-phy-sel@48140650 {
-				compatible = "ti,am3352-cpsw-phy-sel";
-				reg= <0x48140650 0x4>;
-				reg-names = "gmii-sel";
+				phys = <&phy_gmii_sel 2>;
 			};
 		};
 
-- 
2.10.5
