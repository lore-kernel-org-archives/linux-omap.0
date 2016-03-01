From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 2/2] ARM: dts: dm814x: dra62x: Disable wait pin monitoring for NAND
Date: Tue, 1 Mar 2016 15:44:48 +0200
Message-ID: <1456839888-6244-3-git-send-email-rogerq@ti.com>
References: <1456839888-6244-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456839888-6244-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, fcooper@ti.com, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The NAND Ready/Busy# line is connected to GPMC_WAIT0 pin and
can't be used for wait state insertion for NAND I/O read/write.
So disable read/write wait monitoring as per Reference Manual's
suggestion [1].

[1] dm814x TRM: SPRUGZ8F: 11.2.4.12.2 NAND Device-Ready Pin

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dm8148-evm.dts       | 3 ---
 arch/arm/boot/dts/dra62x-j5eco-evm.dts | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/dm8148-evm.dts b/arch/arm/boot/dts/dm8148-evm.dts
index be56c8f..cbc17b0 100644
--- a/arch/arm/boot/dts/dm8148-evm.dts
+++ b/arch/arm/boot/dts/dm8148-evm.dts
@@ -65,12 +65,9 @@
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
diff --git a/arch/arm/boot/dts/dra62x-j5eco-evm.dts b/arch/arm/boot/dts/dra62x-j5eco-evm.dts
index b0c8144..f820573 100644
--- a/arch/arm/boot/dts/dra62x-j5eco-evm.dts
+++ b/arch/arm/boot/dts/dra62x-j5eco-evm.dts
@@ -65,12 +65,9 @@
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
