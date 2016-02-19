From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v5 25/26] ARM: dts: dm816x: Fix gpmc and NAND node
Date: Fri, 19 Feb 2016 23:15:47 +0200
Message-ID: <1455916548-3441-26-git-send-email-rogerq@ti.com>
References: <1455916548-3441-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455916548-3441-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, computersforpeace@gmail.com
Cc: dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Make gpmc node gpio+interrupt capable.

Add compatible id and interrupt to NAND node.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dm8168-evm.dts | 8 +++++---
 arch/arm/boot/dts/dm816x.dtsi    | 4 ++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/dm8168-evm.dts b/arch/arm/boot/dts/dm8168-evm.dts
index 169a855..f50348b 100644
--- a/arch/arm/boot/dts/dm8168-evm.dts
+++ b/arch/arm/boot/dts/dm8168-evm.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "dm816x.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "DM8168 EVM";
@@ -85,8 +86,12 @@
 	ranges = <0 0 0x04000000 0x01000000>;	/* CS0: 16MB for NAND */
 
 	nand@0,0 {
+		compatible = "ti,omap2-nand";
 		linux,mtd-name= "micron,mt29f2g16aadwp";
 		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&gpmc>;
+		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
+			     <1 IRQ_TYPE_NONE>; /* termcount */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ti,nand-ecc-opt = "bch8";
@@ -106,12 +111,9 @@
 		gpmc,access-ns = <64>;
 		gpmc,rd-cycle-ns = <82>;
 		gpmc,wr-cycle-ns = <82>;
-		gpmc,wait-on-read = "true";
-		gpmc,wait-on-write = "true";
 		gpmc,bus-turnaround-ns = <0>;
 		gpmc,cycle2cycle-delay-ns = <0>;
 		gpmc,clk-activation-ns = <0>;
-		gpmc,wait-monitoring-ns = <0>;
 		gpmc,wr-access-ns = <40>;
 		gpmc,wr-data-mux-bus-ns = <0>;
 		partition@0 {
diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
index c3b8811..115519e 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -183,6 +183,10 @@
 			dma-names = "rxtx";
 			gpmc,num-cs = <6>;
 			gpmc,num-waitpins = <2>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 		};
 
 		i2c1: i2c@48028000 {
-- 
2.1.4
