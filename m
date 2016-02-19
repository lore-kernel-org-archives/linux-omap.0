From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v5 24/26] ARM: dts: dm814x: Fix gpmc and NAND node
Date: Fri, 19 Feb 2016 23:15:46 +0200
Message-ID: <1455916548-3441-25-git-send-email-rogerq@ti.com>
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
 arch/arm/boot/dts/dm8148-evm.dts       | 8 +++++---
 arch/arm/boot/dts/dm814x.dtsi          | 4 ++++
 arch/arm/boot/dts/dra62x-j5eco-evm.dts | 8 +++++---
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/dm8148-evm.dts b/arch/arm/boot/dts/dm8148-evm.dts
index 862977f..1e8036e 100644
--- a/arch/arm/boot/dts/dm8148-evm.dts
+++ b/arch/arm/boot/dts/dm8148-evm.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "dm814x.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "DM8148 EVM";
@@ -39,8 +40,12 @@
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
@@ -60,12 +65,9 @@
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
diff --git a/arch/arm/boot/dts/dm814x.dtsi b/arch/arm/boot/dts/dm814x.dtsi
index 3fe68b1..b9a1470 100644
--- a/arch/arm/boot/dts/dm814x.dtsi
+++ b/arch/arm/boot/dts/dm814x.dtsi
@@ -559,6 +559,10 @@
 			gpmc,num-waitpins = <2>;
 			#address-cells = <2>;
 			#size-cells = <1>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/dra62x-j5eco-evm.dts b/arch/arm/boot/dts/dra62x-j5eco-evm.dts
index 3937a58..05b955c 100644
--- a/arch/arm/boot/dts/dra62x-j5eco-evm.dts
+++ b/arch/arm/boot/dts/dra62x-j5eco-evm.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "dra62x.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "DRA62x J5 Eco EVM";
@@ -39,8 +40,12 @@
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
@@ -60,12 +65,9 @@
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
-- 
2.1.4
