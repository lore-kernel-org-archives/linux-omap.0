From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 1/2] ARM: dts: dm814x: dra62x: Fix NAND device nodes
Date: Tue, 1 Mar 2016 15:44:47 +0200
Message-ID: <1456839888-6244-2-git-send-email-rogerq@ti.com>
References: <1456839888-6244-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456839888-6244-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, fcooper@ti.com, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Add compatible id, GPMC register resource and interrupt
resource to NAND controller nodes.

The GPMC node will provide an interrupt controller for the
NAND IRQs.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dm8148-evm.dts       | 7 ++++++-
 arch/arm/boot/dts/dm814x.dtsi          | 2 ++
 arch/arm/boot/dts/dra62x-j5eco-evm.dts | 7 ++++++-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dm8148-evm.dts b/arch/arm/boot/dts/dm8148-evm.dts
index 862977f..be56c8f 100644
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
-		linux,mtd-name= "micron,mt29f2g16aadwp";
+		compatible = "ti,omap2-nand";
 		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&gpmc>;
+		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
+			     <1 IRQ_TYPE_NONE>; /* termcount */
+		linux,mtd-name= "micron,mt29f2g16aadwp";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ti,nand-ecc-opt = "bch8";
diff --git a/arch/arm/boot/dts/dm814x.dtsi b/arch/arm/boot/dts/dm814x.dtsi
index f752ac1..4a6ce8c 100644
--- a/arch/arm/boot/dts/dm814x.dtsi
+++ b/arch/arm/boot/dts/dm814x.dtsi
@@ -566,6 +566,8 @@
 			gpmc,num-waitpins = <2>;
 			#address-cells = <2>;
 			#size-cells = <1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/dra62x-j5eco-evm.dts b/arch/arm/boot/dts/dra62x-j5eco-evm.dts
index 3937a58..b0c8144 100644
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
-		linux,mtd-name= "micron,mt29f2g16aadwp";
+		compatible = "ti,omap2-nand";
 		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&gpmc>;
+		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
+			     <1 IRQ_TYPE_NONE>; /* termcount */
+		linux,mtd-name= "micron,mt29f2g16aadwp";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ti,nand-ecc-opt = "bch8";
-- 
2.5.0
