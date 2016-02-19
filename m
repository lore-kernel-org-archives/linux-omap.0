From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v5 21/26] ARM: dts: am437x: Provide NAND ready pin
Date: Fri, 19 Feb 2016 23:15:43 +0200
Message-ID: <1455916548-3441-22-git-send-email-rogerq@ti.com>
References: <1455916548-3441-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455916548-3441-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, computersforpeace@gmail.com
Cc: dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On these boards NAND ready pin status is avilable over
GPMC_WAIT0 pin.

For NAND we don't use GPMC wait pin monitoring but
get the NAND Ready/Busy# status using GPIOlib.
GPMC driver provides the WAIT0 pin status over GPIOlib.

Read speed increases from 16516 KiB/ to 18813 KiB/s
and write speed was unchanged at 9941 KiB/s.

Measured using mtd_speedtest.ko.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts  | 3 +--
 arch/arm/boot/dts/am43x-epos-evm.dts | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 7081b88..2405004 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -819,6 +819,7 @@
 		interrupt-parent = <&gpmc>;
 		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
 			     <1 IRQ_TYPE_NONE>;	/* termcount */
+		rb-gpios = <&gpmc 0 GPIO_ACTIVE_HIGH>;	/* gpmc_wait0 */
 		ti,nand-ecc-opt = "bch16";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <8>;
@@ -837,11 +838,9 @@
 		gpmc,access-ns = <30>;
 		gpmc,rd-cycle-ns = <40>;
 		gpmc,wr-cycle-ns = <40>;
-		gpmc,wait-pin = <0>;
 		gpmc,bus-turnaround-ns = <0>;
 		gpmc,cycle2cycle-delay-ns = <0>;
 		gpmc,clk-activation-ns = <0>;
-		gpmc,wait-monitoring-ns = <0>;
 		gpmc,wr-access-ns = <40>;
 		gpmc,wr-data-mux-bus-ns = <0>;
 		/* MTD partition table */
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 12b08cf..8d71af6 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -568,6 +568,7 @@
 		interrupt-parent = <&gpmc>;
 		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
 			     <1 IRQ_TYPE_NONE>;	/* termcount */
+		rb-gpios = <&gpmc 0 GPIO_ACTIVE_HIGH>;	/* gpmc_wait0 */
 		ti,nand-ecc-opt = "bch16";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <8>;
@@ -586,11 +587,9 @@
 		gpmc,access-ns = <30>; /* tCEA + 4*/
 		gpmc,rd-cycle-ns = <40>;
 		gpmc,wr-cycle-ns = <40>;
-		gpmc,wait-pin = <0>;
 		gpmc,bus-turnaround-ns = <0>;
 		gpmc,cycle2cycle-delay-ns = <0>;
 		gpmc,clk-activation-ns = <0>;
-		gpmc,wait-monitoring-ns = <0>;
 		gpmc,wr-access-ns = <40>;
 		gpmc,wr-data-mux-bus-ns = <0>;
 		/* MTD partition table */
-- 
2.1.4
