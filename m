From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH] ARM: dts: AM33xx: cleaned GPMC DT for AM33xx series
Date: Tue, 18 Jun 2013 16:25:01 +0530
Message-ID: <1371552901-19145-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41988 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751907Ab3FRKzH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Jun 2013 06:55:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, linux-omap@vger.kernel.org
Cc: tony@atomide.com, Pekon Gupta <pekon@ti.com>

This patch contains following updates
- Removed 'gpmc,device-nand'.
	Reference commit f40739faba8e804cf46505869ab98ad7c4a88833 
	ARM: dts: OMAP2+: Simplify NAND support (jon-hunter@ti.com)
- updated 'num-cs' -> 'gpmc,num-cs'
	Reference commit f34f37160c2960a763ed05d1e13b2ea75a48d0fb 
	ARM: OMAP2+: gpmc: get number of useable GPMC chip-select(pekon@ti.com)

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts | 1 -
 arch/arm/boot/dts/am33xx.dtsi    | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 7d2be9c..c71bb77 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -136,7 +136,6 @@
 				reg = <0 0 0>; /* CS0, offset 0 */
 				nand-bus-width = <8>;
 				ti,nand-ecc-opt = "bch8";
-				gpmc,device-nand = "true";
 				gpmc,device-width = <1>;
 				gpmc,sync-clk-ps = <0>;
 				gpmc,cs-on-ns = <0>;
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 095f696..5f80f84 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -417,7 +417,7 @@
 			ti,hwmods = "gpmc";
 			reg = <0x50000000 0x2000>;
 			interrupts = <100>;
-			num-cs = <7>;
+			gpmc,num-cs = <7>;
 			gpmc,num-waitpins = <2>;
 			#address-cells = <2>;
 			#size-cells = <1>;
-- 
1.8.1

