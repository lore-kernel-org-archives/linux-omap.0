From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v4 4/4] ARM: dts: AM33xx: updated default ECC scheme in nand-ecc-opt
Date: Mon, 1 Jul 2013 15:21:53 +0530
Message-ID: <1372672313-4104-5-git-send-email-pekon@ti.com>
References: <1372672313-4104-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46116 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752764Ab3GAJwv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Jul 2013 05:52:51 -0400
In-Reply-To: <1372672313-4104-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, artem.bityutskiy@linux.intel.com, benoit.cousson@linaro.org
Cc: arnd@arndb.de, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, jp.francois@cynove.com, Pekon Gupta <pekon@ti.com>

DT property values for OMAP based gpmc-nand have been updated
to match changes in commit:
	6faf096 ARM: OMAP2+: cleaned-up DT support of various ECC schemes
Refer: Documentation/devicetree/bindings/mtd/gpmc-nand.txt

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index c71bb77..cc50fb8 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -135,7 +135,7 @@
 			nand@0,0 {
 				reg = <0 0 0>; /* CS0, offset 0 */
 				nand-bus-width = <8>;
-				ti,nand-ecc-opt = "bch8";
+				ti,nand-ecc-opt = "bch8_code_hw";
 				gpmc,device-width = <1>;
 				gpmc,sync-clk-ps = <0>;
 				gpmc,cs-on-ns = <0>;
-- 
1.8.1

