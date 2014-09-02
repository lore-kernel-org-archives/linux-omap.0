From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 4/6] ARM: dts: am43xx-epos-evm: Don't use read/write wait monitoring
Date: Tue, 2 Sep 2014 16:57:05 +0300
Message-ID: <1409666227-20622-5-git-send-email-rogerq@ti.com>
References: <1409666227-20622-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50817 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979AbaIBN51 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2014 09:57:27 -0400
In-Reply-To: <1409666227-20622-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: pekon@pek-sem.com, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

NAND uses wait pin only to indicate device readiness after
a block/page operation. It is not use to extend individual
read/write cycle and so read/write wait pin monitoring must
be disabled for NAND.

Add gpmc wait pin information as the NAND uses wait pin 0
for device ready indication.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index f6c9898..b489b27 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -459,8 +459,7 @@
 		gpmc,access-ns = <30>; /* tCEA + 4*/
 		gpmc,rd-cycle-ns = <40>;
 		gpmc,wr-cycle-ns = <40>;
-		gpmc,wait-on-read = "true";
-		gpmc,wait-on-write = "true";
+		gpmc,wait-pin = <0>;
 		gpmc,bus-turnaround-ns = <0>;
 		gpmc,cycle2cycle-delay-ns = <0>;
 		gpmc,clk-activation-ns = <0>;
-- 
1.8.3.2

