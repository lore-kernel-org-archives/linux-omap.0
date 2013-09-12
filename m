From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v6 4/4] ARM: dts: AM33xx: updated default ECC scheme in nand-ecc-opt
Date: Thu, 12 Sep 2013 17:20:19 +0530
Message-ID: <1378986619-26765-5-git-send-email-pekon@ti.com>
References: <1378986619-26765-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44345 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753069Ab3ILLvN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Sep 2013 07:51:13 -0400
In-Reply-To: <1378986619-26765-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dedekind1@gmail.com, olof@lixom.net, computersforpeace@gmail.com
Cc: dwmw2@infradead.org, arnd@arndb.de, tony@atomide.com, benoit.cousson@linaro.org, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Pekon Gupta <pekon@ti.com>

DT property values for OMAP based gpmc-nand have been updated
to match changes in commit:
	6faf096 ARM: OMAP2+: cleaned-up DT support of various ECC schemes
Refer: Documentation/devicetree/bindings/mtd/gpmc-nand.txt

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index e8ec875..e28a2ac 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -268,7 +268,7 @@
 			nand@0,0 {
 				reg = <0 0 0>; /* CS0, offset 0 */
 				nand-bus-width = <8>;
-				ti,nand-ecc-opt = "bch8";
+				ti,nand-ecc-scheme = "bch8";
 				gpmc,device-nand = "true";
 				gpmc,device-width = <1>;
 				gpmc,sync-clk-ps = <0>;
-- 
1.8.1

