From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [PATCH 1/1] ARM: dts: DRA72: switch to cpsw slave0 for ethernet
Date: Mon, 22 Jun 2015 14:33:44 +0530
Message-ID: <1434963824-11413-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Vignesh R <vigneshr@ti.com>, Mugunthan V N <mugunthanvnm@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Vignesh R <vigneshr@ti.com>

On DRA72 EVM, cpsw slave1 is muxed with VIN2A, hence switch to cpsw
slave0 for ethernet. Add gpio hog entry to pcf_gpio_21 in order to
select cpsw slave0.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 arch/arm/boot/dts/dra72-evm.dts | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index ce0390f..b05d123 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -274,6 +274,12 @@
 		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
+
+		cpsw_sel_s0 {
+			gpio-hog;
+			gpios = <4 GPIO_ACTIVE_HIGH>;
+			output-low;
+		};
 	};
 };
 
@@ -481,9 +487,10 @@
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&cpsw_default>;
 	pinctrl-1 = <&cpsw_sleep>;
+	slaves = <1>;
 };
 
-&cpsw_emac1 {
+&cpsw_emac0 {
 	phy_id = <&davinci_mdio>, <3>;
 	phy-mode = "rgmii";
 };
@@ -492,7 +499,6 @@
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&davinci_mdio_default>;
 	pinctrl-1 = <&davinci_mdio_sleep>;
-	active_slave = <1>;
 };
 
 &dcan1 {
-- 
2.4.2.387.gf86f31a
