From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v5 23/26] ARM: dts: am335x: Provide NAND ready pin
Date: Fri, 19 Feb 2016 23:15:45 +0200
Message-ID: <1455916548-3441-24-git-send-email-rogerq@ti.com>
References: <1455916548-3441-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455916548-3441-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, computersforpeace@gmail.com
Cc: dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Teresa Remmet <t.remmet@phytec.de>, Ilya Ledvich <ilya@compulab.co.il>, Yegor Yefremov <yegorslists@googlemail.com>, Rostislav Lisovy <lisovy@gmail.com>, Enric Balletbo i Serra <eballetbo@iseebcn.com>
List-Id: linux-omap@vger.kernel.org

On these boards NAND ready pin status is avilable over
GPMC_WAIT0 pin.

For NAND we don't use GPMC wait pin monitoring but
get the NAND Ready/Busy# status using GPIOlib.
GPMC driver provides the WAIT0 pin status over GPIOlib.

Read speed increases from 7869 KiB/ to 8875 KiB/s
and write speed was unchanged at 5100 KiB/s.

Measured using mtd_speedtest.ko on am335x-evm.

Cc: Teresa Remmet <t.remmet@phytec.de>
Cc: Ilya Ledvich <ilya@compulab.co.il>
Cc: Yegor Yefremov <yegorslists@googlemail.com>
Cc: Rostislav Lisovy <lisovy@gmail.com>
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am335x-baltos-ir5221.dts | 4 +---
 arch/arm/boot/dts/am335x-chilisom.dtsi     | 4 +---
 arch/arm/boot/dts/am335x-cm-t335.dts       | 4 +---
 arch/arm/boot/dts/am335x-evm.dts           | 4 +---
 arch/arm/boot/dts/am335x-igep0033.dtsi     | 4 +---
 arch/arm/boot/dts/am335x-phycore-som.dtsi  | 4 +---
 6 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-baltos-ir5221.dts b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
index 7b6bcb0..17e92e8 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir5221.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
@@ -241,6 +241,7 @@
 		interrupt-parent = <&gpmc>;
 		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
 			     <1 IRQ_TYPE_NONE>;	/* termcount */
+		rb-gpios = <&gpmc 0 GPIO_ACTIVE_HIGH>; /* gpmc_wait0 */
 		nand-bus-width = <8>;
 		ti,nand-ecc-opt = "bch8";
 		ti,nand-xfer-type = "polled";
@@ -261,12 +262,9 @@
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
 
diff --git a/arch/arm/boot/dts/am335x-chilisom.dtsi b/arch/arm/boot/dts/am335x-chilisom.dtsi
index e8e7d9d..6b8e70a 100644
--- a/arch/arm/boot/dts/am335x-chilisom.dtsi
+++ b/arch/arm/boot/dts/am335x-chilisom.dtsi
@@ -224,6 +224,7 @@
 		interrupt-parent = <&gpmc>;
 		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
 			     <1 IRQ_TYPE_NONE>;	/* termcount */
+		rb-gpios = <&gpmc 0 GPIO_ACTIVE_HIGH>; /* gpmc_wait0 */
 		ti,nand-ecc-opt = "bch8";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <8>;
@@ -242,12 +243,9 @@
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
 	};
diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
index 53120b1..817b1de 100644
--- a/arch/arm/boot/dts/am335x-cm-t335.dts
+++ b/arch/arm/boot/dts/am335x-cm-t335.dts
@@ -411,6 +411,7 @@ status = "okay";
 		interrupt-parent = <&gpmc>;
 		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
 			     <1 IRQ_TYPE_NONE>;	/* termcount */
+		rb-gpios = <&gpmc 0 GPIO_ACTIVE_HIGH>; /* gpmc_wait0 */
 		ti,nand-ecc-opt = "bch8";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <8>;
@@ -429,12 +430,9 @@ status = "okay";
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
 		/* MTD partition table */
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 4e7a53e6a..516673b 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -524,6 +524,7 @@
 		interrupt-parent = <&gpmc>;
 		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
 			     <1 IRQ_TYPE_NONE>;	/* termcount */
+		rb-gpios = <&gpmc 0 GPIO_ACTIVE_HIGH>; /* gpmc_wait0 */
 		ti,nand-ecc-opt = "bch8";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <8>;
@@ -542,12 +543,9 @@
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
 		/* MTD partition table */
diff --git a/arch/arm/boot/dts/am335x-igep0033.dtsi b/arch/arm/boot/dts/am335x-igep0033.dtsi
index 4cfe041..df63484 100644
--- a/arch/arm/boot/dts/am335x-igep0033.dtsi
+++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
@@ -135,6 +135,7 @@
 		interrupt-parent = <&gpmc>;
 		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
 			     <1 IRQ_TYPE_NONE>;	/* termcount */
+		rb-gpios = <&gpmc 0 GPIO_ACTIVE_HIGH>; /* gpmc_wait0 */
 		nand-bus-width = <8>;
 		ti,nand-ecc-opt = "bch8";
 		gpmc,device-width = <1>;
@@ -152,12 +153,9 @@
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
 
diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/dts/am335x-phycore-som.dtsi
index 80a5687..86f7731 100644
--- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
+++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
@@ -171,6 +171,7 @@
 		interrupt-parent = <&gpmc>;
 		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
 			     <1 IRQ_TYPE_NONE>;	/* termcount */
+		rb-gpios = <&gpmc 0 GPIO_ACTIVE_HIGH>; /* gpmc_wait0 */
 		nand-bus-width = <8>;
 		ti,nand-ecc-opt = "bch8";
 		gpmc,device-nand = "true";
@@ -189,13 +190,10 @@
 		gpmc,access-ns = <30>;
 		gpmc,rd-cycle-ns = <30>;
 		gpmc,wr-cycle-ns = <30>;
-		gpmc,wait-on-read = "true";
-		gpmc,wait-on-write = "true";
 		gpmc,bus-turnaround-ns = <0>;
 		gpmc,cycle2cycle-delay-ns = <50>;
 		gpmc,cycle2cycle-diffcsen;
 		gpmc,clk-activation-ns = <0>;
-		gpmc,wait-monitoring-ns = <0>;
 		gpmc,wr-access-ns = <30>;
 		gpmc,wr-data-mux-bus-ns = <0>;
 
-- 
2.1.4
