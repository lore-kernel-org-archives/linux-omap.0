From: Mark Jackson <mpfj@newflow.co.uk>
Subject: [PATCH] Update Nanobone dts file
Date: Thu, 19 Mar 2015 11:51:43 +0000
Message-ID: <550AB84F.6090304@newflow.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Update dts file to reflect:-
(1) new flash memory layout
(2) add missing phy-mode property

Signed-off-by: Mark Jackson <mpfj@newflow.co.uk>
---
 arch/arm/boot/dts/am335x-nano.dts | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-nano.dts b/arch/arm/boot/dts/am335x-nano.dts
index a346645..dfa610f 100644
--- a/arch/arm/boot/dts/am335x-nano.dts
+++ b/arch/arm/boot/dts/am335x-nano.dts
@@ -297,8 +297,8 @@
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
@@ -327,12 +327,12 @@
 
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
@@ -353,11 +353,13 @@
 
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
