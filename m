From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] ARM: dts: dra7: Fix efuse register size for ABB
Date: Thu, 16 Apr 2015 16:56:33 -0500
Message-ID: <1429221394-18896-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Matt Gessner <Matt.Gessner@windriver.com>, Suman Anna <s-anna@ti.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Fix a typo in DRA7 dtsi where 12 bytes are needed for register
description of ABB efuse registers, however only 8 bytes are provided
to map. For some weird reason, this does not generate abort at offset
0x8, probably due to default maps already provided in io.c for the bus
register ranges.

Reported-by: Matt Gessner <Matt.Gessner@windriver.com>
Reported-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 5332b57b4950..92b8bb873f43 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -911,7 +911,7 @@
 			ti,clock-cycles = <16>;
 
 			reg = <0x4ae07ddc 0x4>, <0x4ae07de0 0x4>,
-			      <0x4ae06014 0x4>, <0x4a003b20 0x8>,
+			      <0x4ae06014 0x4>, <0x4a003b20 0xc>,
 			      <0x4ae0c158 0x4>;
 			reg-names = "setup-address", "control-address",
 				    "int-address", "efuse-address",
@@ -944,7 +944,7 @@
 			ti,clock-cycles = <16>;
 
 			reg = <0x4ae07e34 0x4>, <0x4ae07e24 0x4>,
-			      <0x4ae06010 0x4>, <0x4a0025cc 0x8>,
+			      <0x4ae06010 0x4>, <0x4a0025cc 0xc>,
 			      <0x4a002470 0x4>;
 			reg-names = "setup-address", "control-address",
 				    "int-address", "efuse-address",
@@ -977,7 +977,7 @@
 			ti,clock-cycles = <16>;
 
 			reg = <0x4ae07e30 0x4>, <0x4ae07e20 0x4>,
-			      <0x4ae06010 0x4>, <0x4a0025e0 0x8>,
+			      <0x4ae06010 0x4>, <0x4a0025e0 0xc>,
 			      <0x4a00246c 0x4>;
 			reg-names = "setup-address", "control-address",
 				    "int-address", "efuse-address",
@@ -1010,7 +1010,7 @@
 			ti,clock-cycles = <16>;
 
 			reg = <0x4ae07de4 0x4>, <0x4ae07de8 0x4>,
-			      <0x4ae06010 0x4>, <0x4a003b08 0x8>,
+			      <0x4ae06010 0x4>, <0x4a003b08 0xc>,
 			      <0x4ae0c154 0x4>;
 			reg-names = "setup-address", "control-address",
 				    "int-address", "efuse-address",
-- 
1.7.9.5
