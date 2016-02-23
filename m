From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v7 7/9] ARM: dts: dm816x: Fix NAND device nodes
Date: Tue, 23 Feb 2016 18:37:23 +0200
Message-ID: <1456245445-31824-8-git-send-email-rogerq@ti.com>
References: <1456245445-31824-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456245445-31824-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: computersforpeace@gmail.com, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Add compatible id, GPMC register resource and interrupt
resource to NAND controller nodes.

The GPMC node will provide an interrupt controller for the
NAND IRQs.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dm8168-evm.dts | 5 +++++
 arch/arm/boot/dts/dm816x.dtsi    | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/dm8168-evm.dts b/arch/arm/boot/dts/dm8168-evm.dts
index 169a855..0cb1003 100644
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
diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
index c3b8811..30fa5b6 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -183,6 +183,8 @@
 			dma-names = "rxtx";
 			gpmc,num-cs = <6>;
 			gpmc,num-waitpins = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 		};
 
 		i2c1: i2c@48028000 {
-- 
2.5.0
