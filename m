From: yegorslists@googlemail.com
Subject: [PATCH v2] ARM: dts: am335x-baltos: use phy-phandle declarations
Date: Wed, 23 Nov 2016 16:49:26 +0100
Message-ID: <1479916166-6633-1-git-send-email-yegorslists@googlemail.com>
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
Cc: tony@atomide.com, bcousson@baylibre.com, linux-arm-kernel@lists.infradead.org, Yegor Yefremov <yegorslists@googlemail.com>
List-Id: linux-omap@vger.kernel.org

From: Yegor Yefremov <yegorslists@googlemail.com>

phy-phandle is now a preferred method to reference a PHY device.
Especially in regards to cpsw it enables PHY specific settings like
max-speed etc. being specified in DTS.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
Changes:
	v2: add patch description (Tony Lindgren)

 arch/arm/boot/dts/am335x-baltos-ir2110.dts | 10 ++++++++--
 arch/arm/boot/dts/am335x-baltos-ir3220.dts |  2 +-
 arch/arm/boot/dts/am335x-baltos-ir5221.dts |  2 +-
 arch/arm/boot/dts/am335x-baltos.dtsi       |  5 ++++-
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-baltos-ir2110.dts b/arch/arm/boot/dts/am335x-baltos-ir2110.dts
index a9a9730..501c752 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir2110.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir2110.dts
@@ -54,16 +54,22 @@
 	dr_mode = "host";
 };
 
+&davinci_mdio {
+	phy0: ethernet-phy@0 {
+		reg = <1>;
+	};
+};
+
 &cpsw_emac0 {
-	phy_id = <&davinci_mdio>, <1>;
 	phy-mode = "rmii";
 	dual_emac_res_vlan = <1>;
+	phy-handle = <&phy0>;
 };
 
 &cpsw_emac1 {
-	phy_id = <&davinci_mdio>, <7>;
 	phy-mode = "rgmii-txid";
 	dual_emac_res_vlan = <2>;
+	phy-handle = <&phy1>;
 };
 
 &phy_sel {
diff --git a/arch/arm/boot/dts/am335x-baltos-ir3220.dts b/arch/arm/boot/dts/am335x-baltos-ir3220.dts
index fe002a1..19f53b8 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir3220.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir3220.dts
@@ -109,9 +109,9 @@
 };
 
 &cpsw_emac1 {
-	phy_id = <&davinci_mdio>, <7>;
 	phy-mode = "rgmii-txid";
 	dual_emac_res_vlan = <2>;
+	phy-handle = <&phy1>;
 };
 
 &phy_sel {
diff --git a/arch/arm/boot/dts/am335x-baltos-ir5221.dts b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
index f599350..2b9d7f4 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir5221.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
@@ -127,9 +127,9 @@
 };
 
 &cpsw_emac1 {
-	phy_id = <&davinci_mdio>, <7>;
 	phy-mode = "rgmii-txid";
 	dual_emac_res_vlan = <2>;
+	phy-handle = <&phy1>;
 };
 
 &phy_sel {
diff --git a/arch/arm/boot/dts/am335x-baltos.dtsi b/arch/arm/boot/dts/am335x-baltos.dtsi
index 09b9541..efb5eae 100644
--- a/arch/arm/boot/dts/am335x-baltos.dtsi
+++ b/arch/arm/boot/dts/am335x-baltos.dtsi
@@ -364,11 +364,14 @@
 };
 
 &davinci_mdio {
+	status = "okay";
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&davinci_mdio_default>;
 	pinctrl-1 = <&davinci_mdio_sleep>;
 
-	status = "okay";
+	phy1: ethernet-phy@1 {
+		reg = <7>;
+	};
 };
 
 &mmc1 {
-- 
2.1.4
