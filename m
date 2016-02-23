From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v7 8/9] ARM: dts: dm8168-evm: ARM: dts: Disable wait pin monitoring for NAND
Date: Tue, 23 Feb 2016 18:37:24 +0200
Message-ID: <1456245445-31824-9-git-send-email-rogerq@ti.com>
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

[1] dm816x TRM: SPRUGX8C: 9.2.4.12.2 NAND Device-Ready Pin

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dm8168-evm.dts | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/dm8168-evm.dts b/arch/arm/boot/dts/dm8168-evm.dts
index 0cb1003..f50348b 100644
--- a/arch/arm/boot/dts/dm8168-evm.dts
+++ b/arch/arm/boot/dts/dm8168-evm.dts
@@ -111,12 +111,9 @@
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
2.5.0
