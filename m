From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 23/27] ARM: dts: am437x-gp-evm: Provide NAND ready pin
Date: Fri, 18 Sep 2015 17:53:45 +0300
Message-ID: <1442588029-13769-24-git-send-email-rogerq@ti.com>
References: <1442588029-13769-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442588029-13769-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: dwmw2@infradead.org, computersforpeace@gmail.com, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
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
index aa96c99..d7bfe9f 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -800,6 +800,7 @@
 		reg = <0 0 4>;		/* device IO registers */
 		interrupt-parent = <&gic>;
 		interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+		ready-gpio = <&gpmc 0 GPIO_ACTIVE_HIGH>;	/* gpmc_wait0 */
 		ti,nand-ecc-opt = "bch16";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <8>;
@@ -818,11 +819,9 @@
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
index 9a7786d..4b26762 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -567,6 +567,7 @@
 		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
 		interrupt-parent = <&gic>;
 		interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+		ready-gpio = <&gpmc 0 GPIO_ACTIVE_HIGH>;	/* gpmc_wait0 */
 		ti,nand-ecc-opt = "bch16";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <8>;
@@ -585,11 +586,9 @@
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
