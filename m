From: Mark Jackson <mpfj@newflow.co.uk>
Subject: [PATCH v2] Update Nanobone dts file
Date: Thu, 19 Mar 2015 15:07:43 +0000
Message-ID: <550AE63F.3020800@newflow.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Update dts file to reflect:-
* new flash memory layout
* add missing phy-mode property
* dual_emac now just a boolean
* rename mcp to microchip
* update gpio definition

Signed-off-by: Mark Jackson <mpfj@newflow.co.uk>
---
 arch/arm/boot/dts/am335x-nano.dts | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-nano.dts b/arch/arm/boot/dts/am335x-nano.dts
index a346645..5ed4ca6 100644
--- a/arch/arm/boot/dts/am335x-nano.dts
+++ b/arch/arm/boot/dts/am335x-nano.dts
@@ -213,7 +213,9 @@
 	pinctrl-0 = <&i2c0_pins>;
 
 	gpio@20 {
-		compatible = "mcp,mcp23017";
+		compatible = "microchip,mcp23017";
+		gpio-controller;
+		#gpio-cells = <2>;
 		reg = <0x20>;
 	};
 
@@ -222,7 +224,7 @@
 	};
 
 	eeprom@53 {
-		compatible = "mcp,24c02";
+		compatible = "microchip,24c02";
 		reg = <0x53>;
 		pagesize = <8>;
 	};
@@ -297,8 +299,8 @@
 		|            |-->0x004FFFFF-> Kernel end
 		|            |-->0x00500000-> File system start
 		|            |
-		|            |-->0x014FFFFF-> File system end
-		|            |-->0x01500000-> User data start
+		|            |-->0x01FFFFFF-> File system end
+		|            |-->0x02000000-> User data start
 		|            |
 		|            |-->0x03FFFFFF-> User data end
 		|            |-->0x04000000-> Data storage start
@@ -327,12 +329,12 @@
 
 		partition@4 {
 			label = "rootfs";
-			reg = <0x00500000 0x01000000>; /* 16MB */
+			reg = <0x00500000 0x01b00000>; /* 27MB */
 		};
 
 		partition@5 {
 			label = "user";
-			reg = <0x01500000 0x02b00000>; /* 43MB */
+			reg = <0x02000000 0x02000000>; /* 32MB */
 		};
 
 		partition@6 {
@@ -343,7 +345,7 @@
 };
 
 &mac {
-	dual_emac = <1>;
+	dual_emac;
 	status = "okay";
 };
 
@@ -353,11 +355,13 @@
 
 &cpsw_emac0 {
 	phy_id = <&davinci_mdio>, <0>;
+	phy-mode = "mii";
 	dual_emac_res_vlan = <1>;
 };
 
 &cpsw_emac1 {
 	phy_id = <&davinci_mdio>, <1>;
+	phy-mode = "mii";
 	dual_emac_res_vlan = <2>;
 };
 
-- 
1.9.1
