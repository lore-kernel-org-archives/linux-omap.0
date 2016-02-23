From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v7 4/9] ARM: dts: am437x: Disable wait pin monitoring for NAND
Date: Tue, 23 Feb 2016 18:37:20 +0200
Message-ID: <1456245445-31824-5-git-send-email-rogerq@ti.com>
References: <1456245445-31824-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456245445-31824-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: computersforpeace@gmail.com, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The NAND Ready/Busy# line is connected to GPMC_WAIT0 pin and
can't be used for wait state insertion for NAND I/O read/write.
So disable read/write wait monitoring as per Reference Manual's
suggestion [1].

[1] AM437x TRM: SPRUHL7D: 9.1.3.3.12.2 NAND Device-Ready Pin

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am437x-cm-t43.dts  | 5 -----
 arch/arm/boot/dts/am437x-gp-evm.dts  | 2 --
 arch/arm/boot/dts/am43x-epos-evm.dts | 2 --
 3 files changed, 9 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-cm-t43.dts b/arch/arm/boot/dts/am437x-cm-t43.dts
index 4aa5357..9551c47 100644
--- a/arch/arm/boot/dts/am437x-cm-t43.dts
+++ b/arch/arm/boot/dts/am437x-cm-t43.dts
@@ -170,17 +170,12 @@
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
 
-		gpmc,wait-pin = <0>;
-
 		#address-cells = <1>;
 		#size-cells = <1>;
 		/* MTD partition table */
diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 7081b88..b3cfedb 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -837,11 +837,9 @@
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
index 12b08cf..b1f2bd6 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -586,11 +586,9 @@
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
2.5.0
