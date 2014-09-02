From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 3/6] ARM: dts: am437x-gp-evm: Don't use read/write wait monitoring
Date: Tue, 2 Sep 2014 16:57:04 +0300
Message-ID: <1409666227-20622-4-git-send-email-rogerq@ti.com>
References: <1409666227-20622-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54092 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752738AbaIBN5S (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Sep 2014 09:57:18 -0400
In-Reply-To: <1409666227-20622-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: pekon@pek-sem.com, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

NAND uses wait pin only to indicate device readiness after
a block/page operation. It is not use to extend individual
read/write cycle and so read/write wait pin monitoring must
be disabled for NAND.

This patch also gets rid of the below warning when NAND is
accessed for the first time.

omap_l3_noc 44000000.ocp: L3 application error: target 13 mod:1 (unclearable)

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 402249e..ff4af7b 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -443,8 +443,6 @@
 		gpmc,rd-cycle-ns = <40>;
 		gpmc,wr-cycle-ns = <40>;
 		gpmc,wait-pin = <0>;
-		gpmc,wait-on-read;
-		gpmc,wait-on-write;
 		gpmc,bus-turnaround-ns = <0>;
 		gpmc,cycle2cycle-delay-ns = <0>;
 		gpmc,clk-activation-ns = <0>;
-- 
1.8.3.2

