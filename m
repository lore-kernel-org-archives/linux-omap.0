From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v3 4/4] ARM: dts: AM33xx: updated default ECC scheme in nand-ecc-opt
Date: Sun, 23 Jun 2013 02:33:50 +0530
Message-ID: <1371935030-20773-5-git-send-email-pekon@ti.com>
References: <1371935030-20773-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49802 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751361Ab3FVVEx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 22 Jun 2013 17:04:53 -0400
In-Reply-To: <1371935030-20773-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, artem.bityutskiy@linux.intel.com, b-cousson@ti.com
Cc: arnd@arndb.de, avinashphilip@ti.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, jp.francois@cynove.com, Pekon Gupta <pekon@ti.com>

DT property values for OMAP based gpmc-nand have been updated
to match changes in commit:
	6faf096 ARM: OMAP2+: cleaned-up DT support of various ECC schemes
Refer: Documentation/devicetree/bindings/mtd/gpmc-nand.txt

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 7d2be9c..da64585 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -135,7 +135,7 @@
 			nand@0,0 {
 				reg = <0 0 0>; /* CS0, offset 0 */
 				nand-bus-width = <8>;
-				ti,nand-ecc-opt = "bch8";
+				ti,nand-ecc-opt = "bch8_code_hw";
 				gpmc,device-nand = "true";
 				gpmc,device-width = <1>;
 				gpmc,sync-clk-ps = <0>;
-- 
1.8.1

