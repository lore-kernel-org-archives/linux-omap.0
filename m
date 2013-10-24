From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v11 08/10] ARM: dts: AM33xx: updated default ECC scheme in nand-ecc-opt
Date: Thu, 24 Oct 2013 18:20:24 +0530
Message-ID: <1382619026-4182-9-git-send-email-pekon@ti.com>
References: <1382619026-4182-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60897 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754854Ab3JXM5E (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Oct 2013 08:57:04 -0400
In-Reply-To: <1382619026-4182-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mark.rutland@arm.com, olof@lixom.net, computersforpeace@gmail.com, dedekind1@gmail.com
Cc: robherring2@gmail.com, Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, tony@atomide.com, bcousson@baylibre.com, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, jp.francois@cynove.com, ivan.djelic@parrot.com, Pekon Gupta <pekon@ti.com>

Updated DTS to replace deprecated binding with newer values
Refer: Documentation/devicetree/bindings/mtd/gpmc-nand.txt

Signed-off-by: Pekon Gupta <pekon@ti.com>
Reviewed-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts   | 3 +--
 arch/arm/boot/dts/omap3430-sdp.dts | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index e8ec875..1aee6ac 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -269,7 +269,6 @@
 				reg = <0 0 0>; /* CS0, offset 0 */
 				nand-bus-width = <8>;
 				ti,nand-ecc-opt = "bch8";
-				gpmc,device-nand = "true";
 				gpmc,device-width = <1>;
 				gpmc,sync-clk-ps = <0>;
 				gpmc,cs-on-ns = <0>;
@@ -296,7 +295,7 @@
 
 				#address-cells = <1>;
 				#size-cells = <1>;
-				elm_id = <&elm>;
+				ti,elm-id = <&elm>;
 
 				/* MTD partition table */
 				partition@0 {
diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/omap3430-sdp.dts
index e2249bc..501f863 100644
--- a/arch/arm/boot/dts/omap3430-sdp.dts
+++ b/arch/arm/boot/dts/omap3430-sdp.dts
@@ -105,7 +105,7 @@
 		reg = <1 0 0x08000000>;
 		nand-bus-width = <8>;
 
-		ti,nand-ecc-opt = "sw";
+		ti,nand-ecc-opt = "ham1";
 		gpmc,cs-on-ns = <0>;
 		gpmc,cs-rd-off-ns = <36>;
 		gpmc,cs-wr-off-ns = <36>;
-- 
1.8.1

