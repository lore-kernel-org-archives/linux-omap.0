From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v7 2/9] ARM: dts: dra7: Remove redundant nand property
Date: Tue, 23 Feb 2016 18:37:18 +0200
Message-ID: <1456245445-31824-3-git-send-email-rogerq@ti.com>
References: <1456245445-31824-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456245445-31824-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: computersforpeace@gmail.com, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

wait pin monitoring is not used for nand so it is pointless to
have the gpmc,wait-monitoring-ns property.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts  | 1 -
 arch/arm/boot/dts/dra72-evm.dts | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 28ae95e..803ab0e 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -770,7 +770,6 @@
 		gpmc,bus-turnaround-ns = <0>;
 		gpmc,cycle2cycle-delay-ns = <0>;
 		gpmc,clk-activation-ns = <0>;
-		gpmc,wait-monitoring-ns = <0>;
 		gpmc,wr-data-mux-bus-ns = <0>;
 		/* MTD partition table */
 		/* All SPL-* partitions are sized to minimal length
diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index 6cf211b..8916433 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -525,7 +525,6 @@
 		gpmc,bus-turnaround-ns = <0>;
 		gpmc,cycle2cycle-delay-ns = <0>;
 		gpmc,clk-activation-ns = <0>;
-		gpmc,wait-monitoring-ns = <0>;
 		gpmc,wr-data-mux-bus-ns = <0>;
 		/* MTD partition table */
 		/* All SPL-* partitions are sized to minimal length
-- 
2.5.0
